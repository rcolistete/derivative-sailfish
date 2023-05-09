/*
  Copyright (C) 2013 Jolla Ltd.
  Contact: Thomas Perl <thomas.perl@jollamobile.com>
  All rights reserved.

  You may use this file under the terms of BSD license as follows:

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the Jolla Ltd nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

import QtQuick 2.0
import Sailfish.Silica 1.0
import io.thp.pyotherside 1.2

Page {
    id: firstPage

    allowedOrientations: derivativeScreenOrientation

    // To enable PullDownMenu, place our content in a SilicaFlickable
    SilicaFlickable {
        id: container
        anchors.fill: parent
        contentHeight: contentItem.childrenRect.height
        contentWidth: firstPage.width

        VerticalScrollDecorator { flickable: container }

        // PullDownMenu and PushUpMenu must be declared in SilicaFlickable, SilicaListView or SilicaGridView
        PullDownMenu {
            MenuItem {
                text: "About"
                onClicked: pageStack.push(Qt.resolvedUrl("AboutPage.qml"))
            }
            MenuItem {
                text: "Help"
                onClicked: pageStack.push(Qt.resolvedUrl("HelpPage.qml"))
            }
            MenuItem {
                text: "Settings"
                onClicked: pageStack.push(Qt.resolvedUrl("SettingsPage.qml"))
            }
        }

        // Place our content in a Column.  The PageHeader is always placed at the top
        // of the page, followed by our content.
        Column {
            id : derivative_Column
            width: firstPage.width
            spacing: Theme.paddingSmall

            function calculateResultDerivative() {
                result_TextArea.text = '<FONT COLOR="LightGreen">Calculating derivative...</FONT>'
                py.call('derivative.calculate_Derivative', [expression_TextField.text,var1_TextField.text,numVar1_TextField.text,var2_TextField.text,numVar2_TextField.text,var3_TextField.text,numVar3_TextField.text,orientation!==Orientation.Landscape,showDerivative,showTime,numerApprox,numDigText,simplifyResult_index,outputTypeResult_index], function(result) {
                    result_TextArea.text = result;
                    result_TextArea.selectAll()
                    result_TextArea.copy()
                    result_TextArea.deselect()
                })
            }

            PageHeader {
                title: qsTr("Derivative")
            }
            TextField {
                id: expression_TextField
                width: parent.width
                inputMethodHints: Qt.ImhNoAutoUppercase
                label: qsTr("Expression")
                placeholderText: "sqrt(x/(x**3+1))"
                text: "sqrt(x/(x**3+1))"
                EnterKey.enabled: text.length > 0
                EnterKey.iconSource: "image://theme/icon-m-enter-next"
                EnterKey.onClicked: var1_TextField.focus = true
            }
            Grid {
                id: diffs_Item
                anchors {left: parent.left; right: parent.right}
                width: parent.width
                rows: 1
                columns: 6
                TextField {
                   id: var1_TextField
                   width: parent.width*0.20
                   inputMethodHints: Qt.ImhNoAutoUppercase
                   label: qsTr("Var.1")
                   placeholderText: "x"
                   text: "x"
                   EnterKey.enabled: text.length > 0
                   EnterKey.iconSource: "image://theme/icon-m-enter-next"
                   EnterKey.onClicked: numVar1_TextField.focus = true
                }
                TextField {
                   id: numVar1_TextField
                   width: parent.width*0.13
                   inputMethodHints: Qt.ImhNoAutoUppercase | Qt.ImhDigitsOnly
                   validator: IntValidator { bottom: 0; top: 9999 }
                   label: "#"
                   placeholderText: "1"
                   text: "1"
                   EnterKey.enabled: text.length > 0
                   EnterKey.iconSource: "image://theme/icon-m-enter-next"
                   EnterKey.onClicked: var2_TextField.focus = true
                }
                TextField {
                   id: var2_TextField
                   width: parent.width*0.20
                   inputMethodHints: Qt.ImhNoAutoUppercase
                   label: qsTr("Var.2")
                   placeholderText: "y"
                   text: "y"
                   EnterKey.enabled: text.length > 0
                   EnterKey.iconSource: "image://theme/icon-m-enter-next"
                   EnterKey.onClicked: numVar2_TextField.focus = true
                }
                TextField {
                   id: numVar2_TextField
                   width: parent.width*0.13
                   inputMethodHints: Qt.ImhNoAutoUppercase | Qt.ImhDigitsOnly
                   validator: IntValidator { bottom: 0; top: 9999 }
                   label: "#"
                   placeholderText: "0"
                   text: "0"
                   EnterKey.enabled: text.length > 0
                   EnterKey.iconSource: "image://theme/icon-m-enter-next"
                   EnterKey.onClicked: var3_TextField.focus = true
                }
                TextField {
                   id: var3_TextField
                   width: parent.width*0.20
                   inputMethodHints: Qt.ImhNoAutoUppercase
                   label: qsTr("Var.3")
                   placeholderText: "z"
                   text: "z"
                   EnterKey.enabled: text.length > 0
                   EnterKey.iconSource: "image://theme/icon-m-enter-next"
                   EnterKey.onClicked: numVar3_TextField.focus = true
                }
                TextField {
                   id: numVar3_TextField
                   width: parent.width*0.13
                   inputMethodHints: Qt.ImhNoAutoUppercase | Qt.ImhDigitsOnly
                   validator: IntValidator { bottom: 0; top: 9999 }
                   label: "#"
                   placeholderText: "0"
                   text: "0"
                   EnterKey.enabled: text.length > 0
                   EnterKey.iconSource: "image://theme/icon-m-enter-accept"
                   EnterKey.onClicked: derivative_Column.calculateResultDerivative()
                }
            }
            Button {
                id: calculate_Button
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width*0.60
                text: qsTr("Calculate")
                focus: true
                onClicked: derivative_Column.calculateResultDerivative()
            }
            Separator {
                id : derivative_Separator
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width*0.9
                color: Theme.primaryColor
            }
            FontLoader { id: dejavusansmono; source: "file:DejaVuSansMono.ttf" }
            TextArea {
                id: result_TextArea
                height: Math.max(firstPage.width, 600, implicitHeight)
                width: parent.width
                readOnly: true
                font.family: dejavusansmono.name
                font.pixelSize: Theme.fontSizeExtraSmall
                text : '<FONT COLOR="LightGreen">All calculation results are copied to clipboard.<br>Loading Python and SymPy, it takes some seconds...</FONT>'
                Component.onCompleted: {
                    _editor.textFormat = Text.RichText;
                }
            }

            Python {
                id: py

                Component.onCompleted: {
                    // Add the Python library directory to the import path
                    var pythonpath = Qt.resolvedUrl('.').substr('file://'.length);
                    addImportPath(pythonpath);
                    console.log(pythonpath);

                    // Asynchronous module importing
                    importModule('derivative', function() {
                        console.log('Python version: ' + evaluate('derivative.versionPython'));
                        result_TextArea.text+='<FONT COLOR="LightGreen">Using Python version ' + evaluate('derivative.versionPython') + '.</FONT>'
                        console.log('SymPy version ' + evaluate('derivative.versionSymPy') + evaluate('(" loaded in %f seconds." % derivative.loadingtimeSymPy)'));
                        result_TextArea.text+='<FONT COLOR="LightGreen">SymPy version ' + evaluate('derivative.versionSymPy') + evaluate('(" loaded in %f seconds." % derivative.loadingtimeSymPy)') + '</FONT><br>'
                    });
                }

                onError: {
                    // when an exception is raised, this error handler will be called
                    console.log('python error: ' + traceback);
                }

                onReceived: {
                    // asychronous messages from Python arrive here
                    // in Python, this can be accomplished via pyotherside.send()
                    console.log('got message from python: ' + data);
                }
            }
        }
    }
}
