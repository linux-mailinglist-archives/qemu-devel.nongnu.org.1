Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4097DA5BF47
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Mar 2025 12:38:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trxsh-00087D-1j; Tue, 11 Mar 2025 07:34:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trxqW-0003Ct-6U
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 07:32:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trxq9-0006Vc-1P
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 07:32:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741692717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WGVrBYsiq7W1vAcIrspew+rSYJpEs9GSJRb6vtVbA0A=;
 b=Vcqko+uOzvBT2BXW4axzjEQWyNObswWfsT3OmjYjtcw3knselxT+hO4XDqPNP52T49T83b
 u/Vam9qtct9jJj3pmnMrZ2NAOGjDYAVqOFSjAUbbJD6pUDfd67kjW3lu0GfQvo1A1rKP5W
 GWJUW56JkkfF91yHnrYXch8BsWJOPL8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-445-8yafwbsNNCe_tJBKpxPT3A-1; Tue,
 11 Mar 2025 07:31:55 -0400
X-MC-Unique: 8yafwbsNNCe_tJBKpxPT3A-1
X-Mimecast-MFC-AGG-ID: 8yafwbsNNCe_tJBKpxPT3A_1741692715
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 45339180AF70
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 11:31:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9CDD81828A95
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 11:31:53 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 35BEB21E61AA; Tue, 11 Mar 2025 12:31:38 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	John Snow <jsnow@redhat.com>
Subject: [PULL 31/61] qapi: clean up encoding of section kinds
Date: Tue, 11 Mar 2025 12:31:07 +0100
Message-ID: <20250311113137.1277125-32-armbru@redhat.com>
In-Reply-To: <20250311113137.1277125-1-armbru@redhat.com>
References: <20250311113137.1277125-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: John Snow <jsnow@redhat.com>

We have several kinds of sections, and to tell them apart, we use
Section attribute @tag and also the section object's Python type:

              type        @tag
    untagged  Section     None
    @foo:     ArgSection  'foo'
    Returns:  Section     'Returns'
    Errors:   Section     'Errors'
    Since:    Section     'Since'
    TODO:     Section     'TODO'

Note:

* @foo can be a member or a feature description, depending on context.

* tag == 'Since' can be a Since: section or a member or feature
  description.  If it's a Section, it's the former, and if it's an
  ArgSection, it's the latter.

Clean this up as follows.  Move the member or feature name to new
ArgSection attribute @name, and replace @tag by enum @kind like this:

              type         kind     name
    untagged  Section      PLAIN
    @foo:     ArgSection   MEMBER   'foo'   if member or argument
              ArgSection   FEATURE  'foo'   if feature
    Returns:  Section      RETURNS
    Errors:   Section      ERRORS
    Since:    Section      SINCE
    TODO:     Section      TODO

The qapi-schema tests are updated to account for the new section names;
"TODO" becomes "Todo" and `None` becomes "Plain" there.

Signed-off-by: John Snow <jsnow@redhat.com>
Message-ID: <20250311034303.75779-34-jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/sphinx/qapidoc.py         |  7 +--
 scripts/qapi/parser.py         | 97 ++++++++++++++++++++++++----------
 tests/qapi-schema/doc-good.out | 10 ++--
 tests/qapi-schema/test-qapi.py |  2 +-
 4 files changed, 80 insertions(+), 36 deletions(-)

diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
index 61997fd21a..d622398f1d 100644
--- a/docs/sphinx/qapidoc.py
+++ b/docs/sphinx/qapidoc.py
@@ -35,6 +35,7 @@
 from docutils.statemachine import ViewList
 from qapi.error import QAPIError, QAPISemError
 from qapi.gen import QAPISchemaVisitor
+from qapi.parser import QAPIDoc
 from qapi.schema import QAPISchema
 
 from sphinx import addnodes
@@ -258,11 +259,11 @@ def _nodes_for_sections(self, doc):
         """Return list of doctree nodes for additional sections"""
         nodelist = []
         for section in doc.sections:
-            if section.tag and section.tag == 'TODO':
+            if section.kind == QAPIDoc.Kind.TODO:
                 # Hide TODO: sections
                 continue
 
-            if not section.tag:
+            if section.kind == QAPIDoc.Kind.PLAIN:
                 # Sphinx cannot handle sectionless titles;
                 # Instead, just append the results to the prior section.
                 container = nodes.container()
@@ -270,7 +271,7 @@ def _nodes_for_sections(self, doc):
                 nodelist += container.children
                 continue
 
-            snode = self._make_section(section.tag)
+            snode = self._make_section(section.kind.name.title())
             self._parse_text_into_node(dedent(section.text), snode)
             nodelist.append(snode)
         return nodelist
diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index 97def9f0e4..94d5322f8a 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -14,6 +14,7 @@
 # This work is licensed under the terms of the GNU GPL, version 2.
 # See the COPYING file in the top-level directory.
 
+import enum
 import os
 import re
 from typing import (
@@ -574,7 +575,10 @@ def get_doc(self) -> 'QAPIDoc':
                         )
                         raise QAPIParseError(self, emsg)
 
-                    doc.new_tagged_section(self.info, match.group(1))
+                    doc.new_tagged_section(
+                        self.info,
+                        QAPIDoc.Kind.from_string(match.group(1))
+                    )
                     text = line[match.end():]
                     if text:
                         doc.append_line(text)
@@ -585,7 +589,7 @@ def get_doc(self) -> 'QAPIDoc':
                         self,
                         "unexpected '=' markup in definition documentation")
                 else:
-                    # tag-less paragraph
+                    # plain paragraph
                     doc.ensure_untagged_section(self.info)
                     doc.append_line(line)
                     line = self.get_doc_paragraph(doc)
@@ -634,14 +638,33 @@ class QAPIDoc:
     Free-form documentation blocks consist only of a body section.
     """
 
+    class Kind(enum.Enum):
+        PLAIN = 0
+        MEMBER = 1
+        FEATURE = 2
+        RETURNS = 3
+        ERRORS = 4
+        SINCE = 5
+        TODO = 6
+
+        @staticmethod
+        def from_string(kind: str) -> 'QAPIDoc.Kind':
+            return QAPIDoc.Kind[kind.upper()]
+
+        def __str__(self) -> str:
+            return self.name.title()
+
     class Section:
         # pylint: disable=too-few-public-methods
-        def __init__(self, info: QAPISourceInfo,
-                     tag: Optional[str] = None):
+        def __init__(
+            self,
+            info: QAPISourceInfo,
+            kind: 'QAPIDoc.Kind',
+        ):
             # section source info, i.e. where it begins
             self.info = info
-            # section tag, if any ('Returns', '@name', ...)
-            self.tag = tag
+            # section kind
+            self.kind = kind
             # section text without tag
             self.text = ''
 
@@ -649,8 +672,14 @@ def append_line(self, line: str) -> None:
             self.text += line + '\n'
 
     class ArgSection(Section):
-        def __init__(self, info: QAPISourceInfo, tag: str):
-            super().__init__(info, tag)
+        def __init__(
+            self,
+            info: QAPISourceInfo,
+            kind: 'QAPIDoc.Kind',
+            name: str
+        ):
+            super().__init__(info, kind)
+            self.name = name
             self.member: Optional['QAPISchemaMember'] = None
 
         def connect(self, member: 'QAPISchemaMember') -> None:
@@ -662,7 +691,9 @@ def __init__(self, info: QAPISourceInfo, symbol: Optional[str] = None):
         # definition doc's symbol, None for free-form doc
         self.symbol: Optional[str] = symbol
         # the sections in textual order
-        self.all_sections: List[QAPIDoc.Section] = [QAPIDoc.Section(info)]
+        self.all_sections: List[QAPIDoc.Section] = [
+            QAPIDoc.Section(info, QAPIDoc.Kind.PLAIN)
+        ]
         # the body section
         self.body: Optional[QAPIDoc.Section] = self.all_sections[0]
         # dicts mapping parameter/feature names to their description
@@ -679,12 +710,14 @@ def __init__(self, info: QAPISourceInfo, symbol: Optional[str] = None):
     def end(self) -> None:
         for section in self.all_sections:
             section.text = section.text.strip('\n')
-            if section.tag is not None and section.text == '':
+            if section.kind != QAPIDoc.Kind.PLAIN and section.text == '':
                 raise QAPISemError(
-                    section.info, "text required after '%s:'" % section.tag)
+                    section.info, "text required after '%s:'" % section.kind)
 
     def ensure_untagged_section(self, info: QAPISourceInfo) -> None:
-        if self.all_sections and not self.all_sections[-1].tag:
+        kind = QAPIDoc.Kind.PLAIN
+
+        if self.all_sections and self.all_sections[-1].kind == kind:
             # extend current section
             section = self.all_sections[-1]
             if not section.text:
@@ -692,46 +725,56 @@ def ensure_untagged_section(self, info: QAPISourceInfo) -> None:
                 section.info = info
             section.text += '\n'
             return
+
         # start new section
-        section = self.Section(info)
+        section = self.Section(info, kind)
         self.sections.append(section)
         self.all_sections.append(section)
 
-    def new_tagged_section(self, info: QAPISourceInfo, tag: str) -> None:
-        section = self.Section(info, tag)
-        if tag == 'Returns':
+    def new_tagged_section(
+        self,
+        info: QAPISourceInfo,
+        kind: 'QAPIDoc.Kind',
+    ) -> None:
+        section = self.Section(info, kind)
+        if kind == QAPIDoc.Kind.RETURNS:
             if self.returns:
                 raise QAPISemError(
-                    info, "duplicated '%s' section" % tag)
+                    info, "duplicated '%s' section" % kind)
             self.returns = section
-        elif tag == 'Errors':
+        elif kind == QAPIDoc.Kind.ERRORS:
             if self.errors:
                 raise QAPISemError(
-                    info, "duplicated '%s' section" % tag)
+                    info, "duplicated '%s' section" % kind)
             self.errors = section
-        elif tag == 'Since':
+        elif kind == QAPIDoc.Kind.SINCE:
             if self.since:
                 raise QAPISemError(
-                    info, "duplicated '%s' section" % tag)
+                    info, "duplicated '%s' section" % kind)
             self.since = section
         self.sections.append(section)
         self.all_sections.append(section)
 
-    def _new_description(self, info: QAPISourceInfo, name: str,
-                         desc: Dict[str, ArgSection]) -> None:
+    def _new_description(
+        self,
+        info: QAPISourceInfo,
+        name: str,
+        kind: 'QAPIDoc.Kind',
+        desc: Dict[str, ArgSection]
+    ) -> None:
         if not name:
             raise QAPISemError(info, "invalid parameter name")
         if name in desc:
             raise QAPISemError(info, "'%s' parameter name duplicated" % name)
-        section = self.ArgSection(info, '@' + name)
+        section = self.ArgSection(info, kind, name)
         self.all_sections.append(section)
         desc[name] = section
 
     def new_argument(self, info: QAPISourceInfo, name: str) -> None:
-        self._new_description(info, name, self.args)
+        self._new_description(info, name, QAPIDoc.Kind.MEMBER, self.args)
 
     def new_feature(self, info: QAPISourceInfo, name: str) -> None:
-        self._new_description(info, name, self.features)
+        self._new_description(info, name, QAPIDoc.Kind.FEATURE, self.features)
 
     def append_line(self, line: str) -> None:
         self.all_sections[-1].append_line(line)
@@ -744,7 +787,7 @@ def connect_member(self, member: 'QAPISchemaMember') -> None:
                                    "%s '%s' lacks documentation"
                                    % (member.role, member.name))
             self.args[member.name] = QAPIDoc.ArgSection(
-                self.info, '@' + member.name)
+                self.info, QAPIDoc.Kind.MEMBER, member.name)
         self.args[member.name].connect(member)
 
     def connect_feature(self, feature: 'QAPISchemaFeature') -> None:
diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.out
index 0a9da3efde..5773f1dd6d 100644
--- a/tests/qapi-schema/doc-good.out
+++ b/tests/qapi-schema/doc-good.out
@@ -113,7 +113,7 @@ The _one_ {and only}, description on the same line
 Also _one_ {and only}
     feature=enum-member-feat
 a member feature
-    section=None
+    section=Plain
 @two is undocumented
 doc symbol=Base
     body=
@@ -171,15 +171,15 @@ description starts on the same line
 a feature
     feature=cmd-feat2
 another feature
-    section=None
+    section=Plain
 .. note:: @arg3 is undocumented
     section=Returns
 @Object
     section=Errors
 some
-    section=TODO
+    section=Todo
 frobnicate
-    section=None
+    section=Plain
 .. admonition:: Notes
 
  - Lorem ipsum dolor sit amet
@@ -212,7 +212,7 @@ If you're bored enough to read this, go see a video of boxed cats
 a feature
     feature=cmd-feat2
 another feature
-    section=None
+    section=Plain
 .. qmp-example::
 
    -> "this example"
diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi.py
index 8fe951c880..4be930228c 100755
--- a/tests/qapi-schema/test-qapi.py
+++ b/tests/qapi-schema/test-qapi.py
@@ -122,7 +122,7 @@ def test_frontend(fname):
         for feat, section in doc.features.items():
             print('    feature=%s\n%s' % (feat, section.text))
         for section in doc.sections:
-            print('    section=%s\n%s' % (section.tag, section.text))
+            print('    section=%s\n%s' % (section.kind, section.text))
 
 
 def open_test_result(dir_name, file_name, update):
-- 
2.48.1


