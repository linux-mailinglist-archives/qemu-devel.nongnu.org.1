Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 71383AC11CE
	for <lists+qemu-devel@lfdr.de>; Thu, 22 May 2025 19:05:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uI9KI-0003iu-JF; Thu, 22 May 2025 13:03:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uI9K1-0003hh-56
 for qemu-devel@nongnu.org; Thu, 22 May 2025 13:03:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uI9Jx-00088A-Sp
 for qemu-devel@nongnu.org; Thu, 22 May 2025 13:03:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747933384;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=flXxQ9mQ75rzpuGxgTAIi78ZPPtvSQUgnaAAbPBO+xw=;
 b=cE0zwtHeCdEqj5F9001P1u5B+qhvFtAHXVb7ct38swPpio3OHvuyJH/Fx5gsw0/JwRl6Gn
 9GVJ92XV1yN5iqZd9TSpliP4htYEdN0wj+4zmMUdVy+jK5AO7RpMZukC0TxAkcIL7nqlWV
 +lNSRqxcf71fkjMMXb7w2jW3rqPU6Gw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-378-yid41W9qPz26hS4C8Jjy6A-1; Thu,
 22 May 2025 13:03:01 -0400
X-MC-Unique: yid41W9qPz26hS4C8Jjy6A-1
X-Mimecast-MFC-AGG-ID: yid41W9qPz26hS4C8Jjy6A_1747933378
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CD68B1800261; Thu, 22 May 2025 17:02:57 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.178])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1088B195608F; Thu, 22 May 2025 17:02:45 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fan Ni <fan.ni@samsung.com>, Zhao Liu <zhao1.liu@intel.com>,
 Kashyap Chamarthy <kchamart@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-block@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Zhenwei Pi <pizhenwei@bytedance.com>, Jason Wang <jasowang@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
 Igor Mammedov <imammedo@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>, Eric Blake <eblake@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, Mads Ynddal <mads@ynddal.dk>,
 Konstantin Kostiuk <kkostiuk@redhat.com>, Peter Xu <peterx@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 2/3] docs: remove legacy QAPI manual generator
Date: Thu, 22 May 2025 13:02:18 -0400
Message-ID: <20250522170219.58058-3-jsnow@redhat.com>
In-Reply-To: <20250522170219.58058-1-jsnow@redhat.com>
References: <20250522170219.58058-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.275,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Thanks for your service!

Remove the old qapidoc and the option to enable the transmogrifier,
leaving the transmogrifier as the ONLY qapi doc generator. This has the
side effect of converting the tests to use the new system, too.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/interop/qemu-ga-ref.rst                 |   1 -
 docs/interop/qemu-qmp-ref.rst                |   1 -
 docs/interop/qemu-storage-daemon-qmp-ref.rst |   1 -
 docs/sphinx/qapidoc.py                       |  25 +-
 docs/sphinx/qapidoc_legacy.py                | 440 -------------------
 python/tests/qapi-isort.sh                   |   2 +-
 6 files changed, 2 insertions(+), 468 deletions(-)
 delete mode 100644 docs/sphinx/qapidoc_legacy.py

diff --git a/docs/interop/qemu-ga-ref.rst b/docs/interop/qemu-ga-ref.rst
index 25f6e24b03c..ea6652ae43e 100644
--- a/docs/interop/qemu-ga-ref.rst
+++ b/docs/interop/qemu-ga-ref.rst
@@ -2,5 +2,4 @@ QEMU Guest Agent Protocol Reference
 ===================================
 
 .. qapi-doc:: qga/qapi-schema.json
-   :transmogrify:
    :namespace: QGA
diff --git a/docs/interop/qemu-qmp-ref.rst b/docs/interop/qemu-qmp-ref.rst
index 3bc1ca12b16..f0ce39ad67d 100644
--- a/docs/interop/qemu-qmp-ref.rst
+++ b/docs/interop/qemu-qmp-ref.rst
@@ -7,5 +7,4 @@ QEMU QMP Reference Manual
    :local:
 
 .. qapi-doc:: qapi/qapi-schema.json
-   :transmogrify:
    :namespace: QMP
diff --git a/docs/interop/qemu-storage-daemon-qmp-ref.rst b/docs/interop/qemu-storage-daemon-qmp-ref.rst
index dc7bde262ae..4dbb6a2cc83 100644
--- a/docs/interop/qemu-storage-daemon-qmp-ref.rst
+++ b/docs/interop/qemu-storage-daemon-qmp-ref.rst
@@ -5,5 +5,4 @@ QEMU Storage Daemon QMP Reference Manual
    :local:
 
 .. qapi-doc:: storage-daemon/qapi/qapi-schema.json
-   :transmogrify:
    :namespace: QSD
diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
index 8011ac9efaf..c9c477378f5 100644
--- a/docs/sphinx/qapidoc.py
+++ b/docs/sphinx/qapidoc.py
@@ -64,8 +64,6 @@
 from sphinx.util.docutils import SphinxDirective, switch_source_input
 from sphinx.util.nodes import nested_parse_with_titles
 
-from qapidoc_legacy import QAPISchemaGenRSTVisitor  # type: ignore
-
 
 if TYPE_CHECKING:
     from typing import (
@@ -504,15 +502,9 @@ class QAPIDocDirective(NestedDirective):
     option_spec = {
         "qapifile": directives.unchanged_required,
         "namespace": directives.unchanged,
-        "transmogrify": directives.flag,
     }
     has_content = False
 
-    def new_serialno(self) -> str:
-        """Return a unique new ID string suitable for use as a node's ID"""
-        env = self.state.document.settings.env
-        return "qapidoc-%d" % env.new_serialno("qapidoc")
-
     def transmogrify(self, schema: QAPISchema) -> nodes.Element:
         logger.info("Transmogrifying QAPI to rST ...")
         vis = Transmogrifier()
@@ -590,21 +582,10 @@ def write_intermediate(self, content: StringList, filename: str) -> None:
                     outfile.write(f" {rcol}")
                 outfile.write("\n")
 
-    def legacy(self, schema: QAPISchema) -> nodes.Element:
-        vis = QAPISchemaGenRSTVisitor(self)
-        vis.visit_begin(schema)
-        for doc in schema.docs:
-            if doc.symbol:
-                vis.symbol(doc, schema.lookup_entity(doc.symbol))
-            else:
-                vis.freeform(doc)
-        return vis.get_document_node()  # type: ignore
-
     def run(self) -> Sequence[nodes.Node]:
         env = self.state.document.settings.env
         qapifile = env.config.qapidoc_srctree + "/" + self.arguments[0]
         qapidir = os.path.dirname(qapifile)
-        transmogrify = "transmogrify" in self.options
 
         try:
             schema = QAPISchema(qapifile)
@@ -617,11 +598,7 @@ def run(self) -> Sequence[nodes.Node]:
             # so they are displayed nicely to the user
             raise ExtensionError(str(err)) from err
 
-        if transmogrify:
-            contentnode = self.transmogrify(schema)
-        else:
-            contentnode = self.legacy(schema)
-
+        contentnode = self.transmogrify(schema)
         return contentnode.children
 
 
diff --git a/docs/sphinx/qapidoc_legacy.py b/docs/sphinx/qapidoc_legacy.py
deleted file mode 100644
index 13520f4c26b..00000000000
--- a/docs/sphinx/qapidoc_legacy.py
+++ /dev/null
@@ -1,440 +0,0 @@
-# coding=utf-8
-# type: ignore
-#
-# QEMU qapidoc QAPI file parsing extension
-#
-# Copyright (c) 2020 Linaro
-#
-# This work is licensed under the terms of the GNU GPLv2 or later.
-# See the COPYING file in the top-level directory.
-
-"""
-qapidoc is a Sphinx extension that implements the qapi-doc directive
-
-The purpose of this extension is to read the documentation comments
-in QAPI schema files, and insert them all into the current document.
-
-It implements one new rST directive, "qapi-doc::".
-Each qapi-doc:: directive takes one argument, which is the
-pathname of the schema file to process, relative to the source tree.
-
-The docs/conf.py file must set the qapidoc_srctree config value to
-the root of the QEMU source tree.
-
-The Sphinx documentation on writing extensions is at:
-https://www.sphinx-doc.org/en/master/development/index.html
-"""
-
-import re
-import textwrap
-
-from docutils import nodes
-from docutils.statemachine import ViewList
-from qapi.error import QAPISemError
-from qapi.gen import QAPISchemaVisitor
-from qapi.parser import QAPIDoc
-
-
-def dedent(text: str) -> str:
-    # Adjust indentation to make description text parse as paragraph.
-
-    lines = text.splitlines(True)
-    if re.match(r"\s+", lines[0]):
-        # First line is indented; description started on the line after
-        # the name. dedent the whole block.
-        return textwrap.dedent(text)
-
-    # Descr started on same line. Dedent line 2+.
-    return lines[0] + textwrap.dedent("".join(lines[1:]))
-
-
-class QAPISchemaGenRSTVisitor(QAPISchemaVisitor):
-    """A QAPI schema visitor which generates docutils/Sphinx nodes
-
-    This class builds up a tree of docutils/Sphinx nodes corresponding
-    to documentation for the various QAPI objects. To use it, first
-    create a QAPISchemaGenRSTVisitor object, and call its
-    visit_begin() method.  Then you can call one of the two methods
-    'freeform' (to add documentation for a freeform documentation
-    chunk) or 'symbol' (to add documentation for a QAPI symbol). These
-    will cause the visitor to build up the tree of document
-    nodes. Once you've added all the documentation via 'freeform' and
-    'symbol' method calls, you can call 'get_document_nodes' to get
-    the final list of document nodes (in a form suitable for returning
-    from a Sphinx directive's 'run' method).
-    """
-    def __init__(self, sphinx_directive):
-        self._cur_doc = None
-        self._sphinx_directive = sphinx_directive
-        self._top_node = nodes.section()
-        self._active_headings = [self._top_node]
-
-    def _make_dlitem(self, term, defn):
-        """Return a dlitem node with the specified term and definition.
-
-        term should be a list of Text and literal nodes.
-        defn should be one of:
-        - a string, which will be handed to _parse_text_into_node
-        - a list of Text and literal nodes, which will be put into
-          a paragraph node
-        """
-        dlitem = nodes.definition_list_item()
-        dlterm = nodes.term('', '', *term)
-        dlitem += dlterm
-        if defn:
-            dldef = nodes.definition()
-            if isinstance(defn, list):
-                dldef += nodes.paragraph('', '', *defn)
-            else:
-                self._parse_text_into_node(defn, dldef)
-            dlitem += dldef
-        return dlitem
-
-    def _make_section(self, title):
-        """Return a section node with optional title"""
-        section = nodes.section(ids=[self._sphinx_directive.new_serialno()])
-        if title:
-            section += nodes.title(title, title)
-        return section
-
-    def _nodes_for_ifcond(self, ifcond, with_if=True):
-        """Return list of Text, literal nodes for the ifcond
-
-        Return a list which gives text like ' (If: condition)'.
-        If with_if is False, we don't return the "(If: " and ")".
-        """
-
-        doc = ifcond.docgen()
-        if not doc:
-            return []
-        doc = nodes.literal('', doc)
-        if not with_if:
-            return [doc]
-
-        nodelist = [nodes.Text(' ('), nodes.strong('', 'If: ')]
-        nodelist.append(doc)
-        nodelist.append(nodes.Text(')'))
-        return nodelist
-
-    def _nodes_for_one_member(self, member):
-        """Return list of Text, literal nodes for this member
-
-        Return a list of doctree nodes which give text like
-        'name: type (optional) (If: ...)' suitable for use as the
-        'term' part of a definition list item.
-        """
-        term = [nodes.literal('', member.name)]
-        if member.type.doc_type():
-            term.append(nodes.Text(': '))
-            term.append(nodes.literal('', member.type.doc_type()))
-        if member.optional:
-            term.append(nodes.Text(' (optional)'))
-        if member.ifcond.is_present():
-            term.extend(self._nodes_for_ifcond(member.ifcond))
-        return term
-
-    def _nodes_for_variant_when(self, branches, variant):
-        """Return list of Text, literal nodes for variant 'when' clause
-
-        Return a list of doctree nodes which give text like
-        'when tagname is variant (If: ...)' suitable for use in
-        the 'branches' part of a definition list.
-        """
-        term = [nodes.Text(' when '),
-                nodes.literal('', branches.tag_member.name),
-                nodes.Text(' is '),
-                nodes.literal('', '"%s"' % variant.name)]
-        if variant.ifcond.is_present():
-            term.extend(self._nodes_for_ifcond(variant.ifcond))
-        return term
-
-    def _nodes_for_members(self, doc, what, base=None, branches=None):
-        """Return list of doctree nodes for the table of members"""
-        dlnode = nodes.definition_list()
-        for section in doc.args.values():
-            term = self._nodes_for_one_member(section.member)
-            # TODO drop fallbacks when undocumented members are outlawed
-            if section.text:
-                defn = dedent(section.text)
-            else:
-                defn = [nodes.Text('Not documented')]
-
-            dlnode += self._make_dlitem(term, defn)
-
-        if base:
-            dlnode += self._make_dlitem([nodes.Text('The members of '),
-                                         nodes.literal('', base.doc_type())],
-                                        None)
-
-        if branches:
-            for v in branches.variants:
-                if v.type.name == 'q_empty':
-                    continue
-                assert not v.type.is_implicit()
-                term = [nodes.Text('The members of '),
-                        nodes.literal('', v.type.doc_type())]
-                term.extend(self._nodes_for_variant_when(branches, v))
-                dlnode += self._make_dlitem(term, None)
-
-        if not dlnode.children:
-            return []
-
-        section = self._make_section(what)
-        section += dlnode
-        return [section]
-
-    def _nodes_for_enum_values(self, doc):
-        """Return list of doctree nodes for the table of enum values"""
-        seen_item = False
-        dlnode = nodes.definition_list()
-        for section in doc.args.values():
-            termtext = [nodes.literal('', section.member.name)]
-            if section.member.ifcond.is_present():
-                termtext.extend(self._nodes_for_ifcond(section.member.ifcond))
-            # TODO drop fallbacks when undocumented members are outlawed
-            if section.text:
-                defn = dedent(section.text)
-            else:
-                defn = [nodes.Text('Not documented')]
-
-            dlnode += self._make_dlitem(termtext, defn)
-            seen_item = True
-
-        if not seen_item:
-            return []
-
-        section = self._make_section('Values')
-        section += dlnode
-        return [section]
-
-    def _nodes_for_arguments(self, doc, arg_type):
-        """Return list of doctree nodes for the arguments section"""
-        if arg_type and not arg_type.is_implicit():
-            assert not doc.args
-            section = self._make_section('Arguments')
-            dlnode = nodes.definition_list()
-            dlnode += self._make_dlitem(
-                [nodes.Text('The members of '),
-                 nodes.literal('', arg_type.name)],
-                None)
-            section += dlnode
-            return [section]
-
-        return self._nodes_for_members(doc, 'Arguments')
-
-    def _nodes_for_features(self, doc):
-        """Return list of doctree nodes for the table of features"""
-        seen_item = False
-        dlnode = nodes.definition_list()
-        for section in doc.features.values():
-            dlnode += self._make_dlitem(
-                [nodes.literal('', section.member.name)], dedent(section.text))
-            seen_item = True
-
-        if not seen_item:
-            return []
-
-        section = self._make_section('Features')
-        section += dlnode
-        return [section]
-
-    def _nodes_for_sections(self, doc):
-        """Return list of doctree nodes for additional sections"""
-        nodelist = []
-        for section in doc.sections:
-            if section.kind == QAPIDoc.Kind.TODO:
-                # Hide TODO: sections
-                continue
-
-            if section.kind == QAPIDoc.Kind.PLAIN:
-                # Sphinx cannot handle sectionless titles;
-                # Instead, just append the results to the prior section.
-                container = nodes.container()
-                self._parse_text_into_node(section.text, container)
-                nodelist += container.children
-                continue
-
-            snode = self._make_section(section.kind.name.title())
-            self._parse_text_into_node(dedent(section.text), snode)
-            nodelist.append(snode)
-        return nodelist
-
-    def _nodes_for_if_section(self, ifcond):
-        """Return list of doctree nodes for the "If" section"""
-        nodelist = []
-        if ifcond.is_present():
-            snode = self._make_section('If')
-            snode += nodes.paragraph(
-                '', '', *self._nodes_for_ifcond(ifcond, with_if=False)
-            )
-            nodelist.append(snode)
-        return nodelist
-
-    def _add_doc(self, typ, sections):
-        """Add documentation for a command/object/enum...
-
-        We assume we're documenting the thing defined in self._cur_doc.
-        typ is the type of thing being added ("Command", "Object", etc)
-
-        sections is a list of nodes for sections to add to the definition.
-        """
-
-        doc = self._cur_doc
-        snode = nodes.section(ids=[self._sphinx_directive.new_serialno()])
-        snode += nodes.title('', '', *[nodes.literal(doc.symbol, doc.symbol),
-                                       nodes.Text(' (' + typ + ')')])
-        self._parse_text_into_node(doc.body.text, snode)
-        for s in sections:
-            if s is not None:
-                snode += s
-        self._add_node_to_current_heading(snode)
-
-    def visit_enum_type(self, name, info, ifcond, features, members, prefix):
-        doc = self._cur_doc
-        self._add_doc('Enum',
-                      self._nodes_for_enum_values(doc)
-                      + self._nodes_for_features(doc)
-                      + self._nodes_for_sections(doc)
-                      + self._nodes_for_if_section(ifcond))
-
-    def visit_object_type(self, name, info, ifcond, features,
-                          base, members, branches):
-        doc = self._cur_doc
-        if base and base.is_implicit():
-            base = None
-        self._add_doc('Object',
-                      self._nodes_for_members(doc, 'Members', base, branches)
-                      + self._nodes_for_features(doc)
-                      + self._nodes_for_sections(doc)
-                      + self._nodes_for_if_section(ifcond))
-
-    def visit_alternate_type(self, name, info, ifcond, features,
-                             alternatives):
-        doc = self._cur_doc
-        self._add_doc('Alternate',
-                      self._nodes_for_members(doc, 'Members')
-                      + self._nodes_for_features(doc)
-                      + self._nodes_for_sections(doc)
-                      + self._nodes_for_if_section(ifcond))
-
-    def visit_command(self, name, info, ifcond, features, arg_type,
-                      ret_type, gen, success_response, boxed, allow_oob,
-                      allow_preconfig, coroutine):
-        doc = self._cur_doc
-        self._add_doc('Command',
-                      self._nodes_for_arguments(doc, arg_type)
-                      + self._nodes_for_features(doc)
-                      + self._nodes_for_sections(doc)
-                      + self._nodes_for_if_section(ifcond))
-
-    def visit_event(self, name, info, ifcond, features, arg_type, boxed):
-        doc = self._cur_doc
-        self._add_doc('Event',
-                      self._nodes_for_arguments(doc, arg_type)
-                      + self._nodes_for_features(doc)
-                      + self._nodes_for_sections(doc)
-                      + self._nodes_for_if_section(ifcond))
-
-    def symbol(self, doc, entity):
-        """Add documentation for one symbol to the document tree
-
-        This is the main entry point which causes us to add documentation
-        nodes for a symbol (which could be a 'command', 'object', 'event',
-        etc). We do this by calling 'visit' on the schema entity, which
-        will then call back into one of our visit_* methods, depending
-        on what kind of thing this symbol is.
-        """
-        self._cur_doc = doc
-        entity.visit(self)
-        self._cur_doc = None
-
-    def _start_new_heading(self, heading, level):
-        """Start a new heading at the specified heading level
-
-        Create a new section whose title is 'heading' and which is placed
-        in the docutils node tree as a child of the most recent level-1
-        heading. Subsequent document sections (commands, freeform doc chunks,
-        etc) will be placed as children of this new heading section.
-        """
-        if len(self._active_headings) < level:
-            raise QAPISemError(self._cur_doc.info,
-                               'Level %d subheading found outside a '
-                               'level %d heading'
-                               % (level, level - 1))
-        snode = self._make_section(heading)
-        self._active_headings[level - 1] += snode
-        self._active_headings = self._active_headings[:level]
-        self._active_headings.append(snode)
-        return snode
-
-    def _add_node_to_current_heading(self, node):
-        """Add the node to whatever the current active heading is"""
-        self._active_headings[-1] += node
-
-    def freeform(self, doc):
-        """Add a piece of 'freeform' documentation to the document tree
-
-        A 'freeform' document chunk doesn't relate to any particular
-        symbol (for instance, it could be an introduction).
-
-        If the freeform document starts with a line of the form
-        '= Heading text', this is a section or subsection heading, with
-        the heading level indicated by the number of '=' signs.
-        """
-
-        # QAPIDoc documentation says free-form documentation blocks
-        # must have only a body section, nothing else.
-        assert not doc.sections
-        assert not doc.args
-        assert not doc.features
-        self._cur_doc = doc
-
-        text = doc.body.text
-        if re.match(r'=+ ', text):
-            # Section/subsection heading (if present, will always be
-            # the first line of the block)
-            (heading, _, text) = text.partition('\n')
-            (leader, _, heading) = heading.partition(' ')
-            node = self._start_new_heading(heading, len(leader))
-            if text == '':
-                return
-        else:
-            node = nodes.container()
-
-        self._parse_text_into_node(text, node)
-        self._cur_doc = None
-
-    def _parse_text_into_node(self, doctext, node):
-        """Parse a chunk of QAPI-doc-format text into the node
-
-        The doc comment can contain most inline rST markup, including
-        bulleted and enumerated lists.
-        As an extra permitted piece of markup, @var will be turned
-        into ``var``.
-        """
-
-        # Handle the "@var means ``var`` case
-        doctext = re.sub(r'@([\w-]+)', r'``\1``', doctext)
-
-        rstlist = ViewList()
-        for line in doctext.splitlines():
-            # The reported line number will always be that of the start line
-            # of the doc comment, rather than the actual location of the error.
-            # Being more precise would require overhaul of the QAPIDoc class
-            # to track lines more exactly within all the sub-parts of the doc
-            # comment, as well as counting lines here.
-            rstlist.append(line, self._cur_doc.info.fname,
-                           self._cur_doc.info.line)
-        # Append a blank line -- in some cases rST syntax errors get
-        # attributed to the line after one with actual text, and if there
-        # isn't anything in the ViewList corresponding to that then Sphinx
-        # 1.6's AutodocReporter will then misidentify the source/line location
-        # in the error message (usually attributing it to the top-level
-        # .rst file rather than the offending .json file). The extra blank
-        # line won't affect the rendered output.
-        rstlist.append("", self._cur_doc.info.fname, self._cur_doc.info.line)
-        self._sphinx_directive.do_parse(rstlist, node)
-
-    def get_document_node(self):
-        """Return the root docutils node which makes up the document"""
-        return self._top_node
diff --git a/python/tests/qapi-isort.sh b/python/tests/qapi-isort.sh
index f31f12d3425..9039389f137 100755
--- a/python/tests/qapi-isort.sh
+++ b/python/tests/qapi-isort.sh
@@ -1,6 +1,6 @@
 #!/bin/sh -e
 python3 -m isort --sp . -c ../scripts/qapi/
 # Force isort to recognize "compat" as a local module and not third-party
-python3 -m isort --sp . -c -p compat -p qapidoc_legacy \
+python3 -m isort --sp . -c -p compat \
         ../docs/sphinx/qapi_domain.py \
         ../docs/sphinx/qapidoc.py
-- 
2.48.1


