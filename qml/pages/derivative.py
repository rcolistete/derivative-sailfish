#!/usr/bin/env python
# -*- coding: utf-8 -*-

import pyotherside
import sys
import time
import os

from platform import python_version
timet1=time.time()
from sympy import *
from sympy import __version__
from sympy.interactive.printing import init_printing
from sympy.printing.mathml import mathml
timet2=time.time()
loadingtimeSymPy = timet2-timet1

versionPython = python_version()
versionSymPy = __version__

nonCalculatedDerivative = ""
nonCalculatedDerivativeOutput = ""
resultDerivative = ""
resultDerivativeSimp = ""
resultOutput = ""
timeDerivative = 0.0
derivativeErrorMessage = 'Error: derivative not calculated'

numerApprox = False

def fixUnicodeText(text):
    text = text.replace(u"⎽","_")
    text = text.replace(u"ℯ","e")
    text = text.replace(u"ⅈ","i")
    return text

def calculate_Derivative(expression,var1,numvar1,var2,numvar2,var3,numvar3):
    global nonCalculatedDerivative, nonCalculatedDerivativeOutput, resultDerivative, resultDerivativeSimp, resultOutput, timeDerivative

    init_printing(use_unicode=True, num_columns=35)
    timet1=time.time()

    expressionDerivative = expression
    variable1Derivative = var1.strip()
    numVar1Derivative = numvar1.strip()
    if not numVar1Derivative:
        numVar1Derivative = '0'
    variable2Derivative = var2.strip()
    numVar2Derivative = numvar2.strip()
    if not numVar2Derivative:
        numVar2Derivative = '0'
    variable3Derivative = var3.strip()
    numVar3Derivative = numvar3.strip()
    if not numVar3Derivative:
        numVar3Derivative = '0'

    derivativeExpr = '('+expressionDerivative
    if variable1Derivative and (eval(numVar1Derivative) > 0):
        derivativeExpr += ','+variable1Derivative+','+numVar1Derivative
    if variable2Derivative and (eval(numVar2Derivative) > 0):
        derivativeExpr += ','+variable2Derivative+','+numVar2Derivative
    if variable3Derivative and (eval(numVar3Derivative) > 0):
        derivativeExpr += ','+variable3Derivative+','+numVar3Derivative
    derivativeExpr += u')'
    try:
        nonCalculatedDerivative = sympify('Derivative'+derivativeExpr)
    except:
        nonCalculatedDerivative = 'Derivative'+derivativeExpr
    try:
        if numerApprox:
            resultDerivative = sympify('N(diff'+derivativeExpr+','+unicode(str(self.numDig))+')')
        else:
            resultDerivative = sympify('diff'+derivativeExpr)
    except:
        resultDerivative = derivativeErrorMessage

    resultDerivativeSimp = sympify(simplify(resultDerivative))

    timet2=time.time()
    timeDerivative = timet2-timet1

    nonCalculatedDerivativeOutput = nonCalculatedDerivative
    resultOutput = resultDerivativeSimp

    if (type(nonCalculatedDerivative) != str):
        nonCalculatedDerivativeOutput = fixUnicodeText(printing.pretty(nonCalculatedDerivative))
    if (type(resultDerivativeSimp) != str):
        resultOutput = fixUnicodeText(printing.pretty(resultDerivativeSimp))

    if (timeDerivative > 0.0):
        result = '<FONT COLOR="LightGreen">'+("Calculated after %f s :" % timeDerivative)+'</FONT><br>'
    else:
        result = u""
    if nonCalculatedDerivativeOutput:
        result += u'<FONT COLOR="LightBlue">'+(nonCalculatedDerivativeOutput.replace(' ','&nbsp;')).replace("\n","<br>")+'<br>=</FONT><br>'
    if (type(resultDerivativeSimp) != str):
        result += (resultOutput.replace(' ','&nbsp;')).replace("\n","<br>")
    else:
        result += u'<FONT COLOR="Red">'+((resultOutput.replace(' ','&nbsp;')).replace("\n","<br>"))+'</FONT>'
    return result

