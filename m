Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C8BEA93355D
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jul 2024 04:15:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTuB1-0008Fd-TU; Tue, 16 Jul 2024 22:13:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sTuAu-0007yU-3T
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 22:13:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sTuAs-0003Uv-Co
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 22:13:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721182424;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cK72dcimvSi3Yg3WciBVNzlipHpTmUZFliZYoEMaEOY=;
 b=gEfsi5fIQBYMZ2grfMHq28yl+0XxfQ1LPjL0gXyT0L+5dp779UAA/M9Bfm19VFtDeMT/s6
 kMi+Tv+3yDN5Wjx98OZ9EbiAqVfXxIZ6QxGcVOzB51TjU3E2XYB84KTUiXPbbXvQmJD9Qz
 6ECrMTD9jb6hMog3zSlFawa4IjPi6dA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-461-_JumL3G1O0yKIGgnaowjww-1; Tue,
 16 Jul 2024 22:13:41 -0400
X-MC-Unique: _JumL3G1O0yKIGgnaowjww-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 98C441955D45; Wed, 17 Jul 2024 02:13:38 +0000 (UTC)
Received: from scv.localdomain (unknown [10.22.65.127])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 33DD01955E80; Wed, 17 Jul 2024 02:13:32 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-block@nongnu.org,
 Lukas Straub <lukasstraub2@web.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mads Ynddal <mads@ynddal.dk>, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Michael Roth <michael.roth@amd.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>,
 Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH v2 3/9] docs/qapidoc: create qmp-example directive
Date: Tue, 16 Jul 2024 22:13:05 -0400
Message-ID: <20240717021312.606116-4-jsnow@redhat.com>
In-Reply-To: <20240717021312.606116-1-jsnow@redhat.com>
References: <20240717021312.606116-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This is a directive that creates a syntactic sugar for creating
"Example" boxes very similar to the ones already used in the bitmaps.rst
document, please see e.g.
https://www.qemu.org/docs/master/interop/bitmaps.html#creation-block-dirty-bitmap-add

In its simplest form, when a custom title is not needed or wanted, and
the example body is *solely* a QMP example:

```
.. qmp-example::

   {body}
```

is syntactic sugar for:

```
.. admonition:: Example:

   .. code-block:: QMP

      {body}
```

When a custom, plaintext title that describes the example is desired,
this form:

```
.. qmp-example::
   :title: Defrobnification

   {body}
```

Is syntactic sugar for:

```
.. admonition:: Example: Defrobnification

   .. code-block:: QMP

      {body}
```

Lastly, when Examples are multi-step processes that require non-QMP
exposition, have lengthy titles, or otherwise involve prose with rST
markup (lists, cross-references, etc), the most complex form:

```
.. qmp-example::
   :annotated:

   This example shows how to use `foo-command`::

     {body}

   For more information, please see `frobnozz`.
```

Is desugared to:

```
.. admonition:: Example:

   This example shows how to use `foo-command`::

     {body}

   For more information, please see `frobnozz`.
```

Note that :annotated: and :title: options can be combined together, if
desired.

The primary benefit here being documentation source consistently using
the same directive for all forms of examples to ensure consistent visual
styling, and ensuring all relevant prose is visually grouped alongside
the code literal block.

Note that as of this commit, the code-block rST syntax "::" does not
apply QMP highlighting; you would need to use ".. code-block:: QMP". The
very next commit changes this behavior to assume all "::" code blocks
within this directive are QMP blocks.

Signed-off-by: John Snow <jsnow@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
---
 docs/sphinx/qapidoc.py | 55 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
index b3be82998a8..11defcfa3f6 100644
--- a/docs/sphinx/qapidoc.py
+++ b/docs/sphinx/qapidoc.py
@@ -27,6 +27,7 @@
 import os
 import re
 import textwrap
+from typing import List
 
 from docutils import nodes
 from docutils.parsers.rst import Directive, directives
@@ -35,6 +36,7 @@
 from qapi.gen import QAPISchemaVisitor
 from qapi.schema import QAPISchema
 
+from sphinx.directives.code import CodeBlock
 from sphinx.errors import ExtensionError
 from sphinx.util.docutils import switch_source_input
 from sphinx.util.nodes import nested_parse_with_titles
@@ -538,10 +540,63 @@ def run(self):
             raise ExtensionError(str(err)) from err
 
 
+class QMPExample(CodeBlock, NestedDirective):
+    """
+    Custom admonition for QMP code examples.
+
+    When the :annotated: option is present, the body of this directive
+    is parsed as normal rST instead. Code blocks must be explicitly
+    written by the user, but this allows for intermingling explanatory
+    paragraphs with arbitrary rST syntax and code blocks for more
+    involved examples.
+
+    When :annotated: is absent, the directive body is treated as a
+    simple standalone QMP code block literal.
+    """
+
+    required_argument = 0
+    optional_arguments = 0
+    has_content = True
+    option_spec = {
+        "annotated": directives.flag,
+        "title": directives.unchanged,
+    }
+
+    def admonition_wrap(self, *content) -> List[nodes.Node]:
+        title = "Example:"
+        if "title" in self.options:
+            title = f"{title} {self.options['title']}"
+
+        admon = nodes.admonition(
+            "",
+            nodes.title("", title),
+            *content,
+            classes=["admonition", "admonition-example"],
+        )
+        return [admon]
+
+    def run_annotated(self) -> List[nodes.Node]:
+        content_node: nodes.Element = nodes.section()
+        self.do_parse(self.content, content_node)
+        return content_node.children
+
+    def run(self) -> List[nodes.Node]:
+        annotated = "annotated" in self.options
+
+        if annotated:
+            content_nodes = self.run_annotated()
+        else:
+            self.arguments = ["QMP"]
+            content_nodes = super().run()
+
+        return self.admonition_wrap(*content_nodes)
+
+
 def setup(app):
     """Register qapi-doc directive with Sphinx"""
     app.add_config_value("qapidoc_srctree", None, "env")
     app.add_directive("qapi-doc", QAPIDocDirective)
+    app.add_directive("qmp-example", QMPExample)
 
     return {
         "version": __version__,
-- 
2.45.0


