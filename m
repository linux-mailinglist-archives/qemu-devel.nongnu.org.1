Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 939FAA110C4
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Jan 2025 20:05:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXm8a-0005l1-8X; Tue, 14 Jan 2025 13:59:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tXm7w-0005fC-4J
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 13:59:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tXm7u-0002lV-7L
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 13:58:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736881137;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y+YkRE0jmFIrVCtqYhqBKeexad8OLiX2Y5aip/6UJg4=;
 b=cvJN91l/EQ7fK2snFALSXjjHgJbcZesPnOUu9uHVS9SaIHWdunsaOIPoC+dQdEqVFEjcC/
 te/lJKYQQomzcJPsseckmmxEp86IaAR1Z3yIAveie/bpIggkmOhS6B74v8WWPAi0HbuzEy
 Va/KhZojw7C7rfDN+giOEU7HtsINa3w=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-552-SdbHP4xzMwSldy8HWbKo9g-1; Tue,
 14 Jan 2025 13:58:56 -0500
X-MC-Unique: SdbHP4xzMwSldy8HWbKo9g-1
X-Mimecast-MFC-AGG-ID: SdbHP4xzMwSldy8HWbKo9g
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F236C1956080; Tue, 14 Jan 2025 18:58:54 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.175])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E35DF19560A3; Tue, 14 Jan 2025 18:58:53 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH v2 07/23] docs/qapidoc: add transmogrifier class stub
Date: Tue, 14 Jan 2025 13:58:24 -0500
Message-ID: <20250114185840.3058525-8-jsnow@redhat.com>
In-Reply-To: <20250114185840.3058525-1-jsnow@redhat.com>
References: <20250114185840.3058525-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.794,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Add the beginnings of the Transmogrifier class by adding the rST
conversion helpers that will be used to build the virtual rST document.

This version of the class does not actually "do anything" yet; each
individual feature is added one-at-a-time in the forthcoming commits.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/sphinx/qapidoc.py | 66 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 65 insertions(+), 1 deletion(-)

diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
index dc72f3fd3f3..6593c3f28cd 100644
--- a/docs/sphinx/qapidoc.py
+++ b/docs/sphinx/qapidoc.py
@@ -24,6 +24,7 @@
 https://www.sphinx-doc.org/en/master/development/index.html
 """
 
+from contextlib import contextmanager
 import os
 import re
 import sys
@@ -32,11 +33,12 @@
 
 from docutils import nodes
 from docutils.parsers.rst import Directive, directives
-from docutils.statemachine import ViewList
+from docutils.statemachine import StringList, ViewList
 from qapi.error import QAPIError, QAPISemError
 from qapi.gen import QAPISchemaVisitor
 from qapi.parser import QAPIDoc
 from qapi.schema import QAPISchema
+from qapi.source import QAPISourceInfo
 
 from sphinx import addnodes
 from sphinx.directives.code import CodeBlock
@@ -61,6 +63,68 @@ def dedent(text: str) -> str:
     return lines[0] + textwrap.dedent("".join(lines[1:]))
 
 
+class Transmogrifier:
+    def __init__(self, schema):
+        self._result = StringList()
+        self.indent = 0
+
+    # General-purpose rST generation functions
+
+    def get_indent(self) -> str:
+        return "   " * self.indent
+
+    @contextmanager
+    def indented(self):
+        self.indent += 1
+        try:
+            yield
+        finally:
+            self.indent -= 1
+
+    def add_line_raw(self, line: str, source: str, *lineno: int) -> None:
+        """Append one line of generated reST to the output."""
+
+        # NB: Sphinx uses zero-indexed lines; subtract one.
+        lineno = tuple((n - 1 for n in lineno))
+
+        if line.strip():
+            # not a blank line
+            self._result.append(
+                self.get_indent() + line.rstrip("\n"), source, *lineno
+            )
+        else:
+            self._result.append("", source, *lineno)
+
+    def add_line(self, content: str, info: QAPISourceInfo) -> None:
+        # NB: We *require* an info object; this works out OK because we
+        # don't document built-in objects that don't have
+        # one. Everything else should.
+        assert info
+        self.add_line_raw(content, info.fname, info.line)
+
+    def add_lines(
+        self,
+        content: str,
+        info: QAPISourceInfo,
+    ) -> None:
+        assert info
+        lines = content.splitlines(True)
+        for i, line in enumerate(lines):
+            self.add_line_raw(line, info.fname, info.line + i)
+
+    def ensure_blank_line(self) -> None:
+        # Empty document -- no blank line required.
+        if not self._result:
+            return
+
+        # Last line isn't blank, add one.
+        if self._result[-1].strip():  # pylint: disable=no-member
+            fname, line = self._result.info(-1)
+            # New blank line is credited to one-after the current last line.
+            # +2: correct for zero/one index, then increment by one.
+            self.add_line_raw("", fname, line + 2)
+
+
 # Disable black auto-formatter until re-enabled:
 # fmt: off
 
-- 
2.47.1


