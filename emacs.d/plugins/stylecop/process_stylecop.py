"""
Converts StyleCop XML output to an emacs-readable output, similar to how gcc
prints errors
"""
import bs4
import sys

def main(f):
    b = bs4.BeautifulSoup(f, 'xml')
    for violation in b('Violation'):
        f = violation['Source'].replace('.astyled.cs', '')
        line = violation['LineNumber']
        try:
            column = violation['StartColumn']
        except KeyError:
            column = str(1)
        msg = violation.text
        rule = violation['RuleId']

        print "{}:{}:{}: error: {} [{}]".format(f, line, column, msg, rule)

if __name__ == '__main__':
    if len(sys.argv) == 1:
        main(sys.stdin)
    elif len(sys.argv) == 2:
        with open(sys.argv[1]) as f:
            main(f)
