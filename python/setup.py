from setuptools import setup

setup(
    name='hello',
    version='0.1',
    py_modules=['hello'],
    entry_points={
        'console_scripts': ['hello = hello:run']
    },
)