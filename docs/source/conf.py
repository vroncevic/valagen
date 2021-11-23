# -*- coding: utf-8 -*-

project = u'valagen'
copyright = u'2016, Vladimir Roncevic <elektron.ronca@gmail.com>'
author = u'Vladimir Roncevic <elektron.ronca@gmail.com>'
version = u'2.0'
release = u'https://github.com/vroncevic/valagen/releases'
extensions = []
templates_path = ['_templates']
source_suffix = '.rst'
master_doc = 'index'
language = None
exclude_patterns = []
pygments_style = None
html_theme = 'sphinx_rtd_theme'
html_static_path = ['_static']
htmlhelp_basename = 'valagendoc'
latex_elements = {}
latex_documents = [(
    master_doc, 'valagen.tex', u'valagen Documentation',
    u'Vladimir Roncevic \\textless{}elektron.ronca@gmail.com\\textgreater{}',
    'manual'
)]
man_pages = [(
    master_doc, 'valagen', u'valagen Documentation', [author], 1
)]
texinfo_documents = [(
    master_doc, 'valagen', u'valagen Documentation', author, 'valagen',
    'One line description of project.', 'Miscellaneous'
)]
epub_title = project
epub_exclude_files = ['search.html']
