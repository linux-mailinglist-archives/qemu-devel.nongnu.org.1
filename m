Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B8755A1109E
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Jan 2025 20:00:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXm8q-000610-0k; Tue, 14 Jan 2025 13:59:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tXm8I-0005ht-MJ
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 13:59:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tXm8H-0002p4-4v
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 13:59:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736881160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JSMzf3IA+Cx4m2xVjwFgnm+qCXh0qMlR4ayQRRIc+1k=;
 b=WjAwhu9b5z9oH7BtpYMw9A53HcJrFTIpoipl9OgR1E6XgKPtndrK1QtDYp1xGm3p8G0qx9
 mTNnc9Gbysyzqwl9AnguGxSHTe9CplZV9laDjOBxAWPor5/GoPv2J2DikA2NXjgXD1Uoou
 MFLC2xIO45rJHf5kpOyHtX4FSz0OrJQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-619-CGZEZGwkOvGt9JGERI4dAQ-1; Tue,
 14 Jan 2025 13:59:16 -0500
X-MC-Unique: CGZEZGwkOvGt9JGERI4dAQ-1
X-Mimecast-MFC-AGG-ID: CGZEZGwkOvGt9JGERI4dAQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 65B6E19560B2; Tue, 14 Jan 2025 18:59:15 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.175])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 56E1E19560A3; Tue, 14 Jan 2025 18:59:14 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH v2 22/23] docs/qapidoc: implement transmogrify() method
Date: Tue, 14 Jan 2025 13:58:39 -0500
Message-ID: <20250114185840.3058525-23-jsnow@redhat.com>
In-Reply-To: <20250114185840.3058525-1-jsnow@redhat.com>
References: <20250114185840.3058525-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This is the true top-level processor for the new transmogrifier;
responsible both for generating the intermediate rST and then running
the nested parse on that generated document to produce the final
docutils tree that is then - very finally - postprocessed by sphinx for
final rendering to HTML &c.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/sphinx/qapidoc.py | 47 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 46 insertions(+), 1 deletion(-)

diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
index a2fc8d25ff7..5d946a46637 100644
--- a/docs/sphinx/qapidoc.py
+++ b/docs/sphinx/qapidoc.py
@@ -2,6 +2,7 @@
 #
 # QEMU qapidoc QAPI file parsing extension
 #
+# Copyright (c) 2024 Red Hat
 # Copyright (c) 2020 Linaro
 #
 # This work is licensed under the terms of the GNU GPLv2 or later.
@@ -53,12 +54,15 @@
 from sphinx import addnodes
 from sphinx.directives.code import CodeBlock
 from sphinx.errors import ExtensionError
+from sphinx.util import logging
 from sphinx.util.docutils import switch_source_input
 from sphinx.util.nodes import nested_parse_with_titles
 
 
 __version__ = "1.0"
 
+logger = logging.getLogger(__name__)
+
 
 def dedent(text: str) -> str:
     # Adjust indentation to make description text parse as paragraph.
@@ -89,6 +93,10 @@ def __init__(self, schema):
         self._result = StringList()
         self.indent = 0
 
+    @property
+    def result(self) -> StringList:
+        return self._result
+
     @property
     def entity(self) -> QAPISchemaEntity:
         assert self._curr_ent is not None
@@ -823,7 +831,43 @@ def new_serialno(self):
         return "qapidoc-%d" % env.new_serialno("qapidoc")
 
     def transmogrify(self, schema) -> nodes.Element:
-        raise NotImplementedError
+        logger.info("Transmogrifying QAPI to rST ...")
+        vis = Transmogrifier(schema)
+        modules = set()
+
+        for doc in schema.docs:
+            module_source = doc.info.fname
+            if module_source not in modules:
+                vis.visit_module(module_source)
+                modules.add(module_source)
+
+            if doc.symbol:
+                ent = schema.lookup_entity(doc.symbol)
+                assert ent
+                vis.visit_entity(ent)
+            else:
+                vis.visit_freeform(doc)
+
+        logger.info("Transmogrification complete.")
+
+        contentnode = nodes.section()
+        content = vis.result
+        titles_allowed = True
+
+        logger.info("Transmogrifier running nested parse ...")
+        with switch_source_input(self.state, content):
+            if titles_allowed:
+                node: nodes.Element = nodes.section()
+                node.document = self.state.document
+                nested_parse_with_titles(self.state, content, contentnode)
+            else:
+                node = nodes.paragraph()
+                node.document = self.state.document
+                self.state.nested_parse(content, 0, contentnode)
+        logger.info("Transmogrifier's nested parse completed.")
+        sys.stdout.flush()
+
+        return contentnode
 
     def legacy(self, schema) -> nodes.Element:
         vis = QAPISchemaGenRSTVisitor(self)
@@ -957,6 +1001,7 @@ def run(self) -> List[nodes.Node]:
 
 def setup(app):
     """Register qapi-doc directive with Sphinx"""
+    app.setup_extension("qapi-domain")
     app.add_config_value("qapidoc_srctree", None, "env")
     app.add_directive("qapi-doc", QAPIDocDirective)
     app.add_directive("qmp-example", QMPExample)
-- 
2.47.1


