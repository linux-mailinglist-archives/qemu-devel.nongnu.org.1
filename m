Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 75632A581BD
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Mar 2025 09:40:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trCAN-0005lM-ET; Sun, 09 Mar 2025 04:37:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1trCAH-0005QX-8W
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 04:37:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1trCAF-0002W9-FR
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 04:37:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741509458;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BQvE/HneCGz1g30jzw3OwriCq5NXZt5xVT54X3KVDic=;
 b=hSUg1wwzmY98YpuYzBhXzty9mwPd3KMirExwQITzzsvaMeuP7JzEDTYITcS/vPg5MK/Msm
 754pg5AmG2CNR38bWdQlaeIU5tGOtY6kq5gEt7voSV6i91GtiNp4t7wuxIzrkAdN0g6bfd
 CZD5vM6dbYwJEtKQQodhNLcx8lAN+QQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-28-X6xWUR4bNEmvwiA1Hn-4mA-1; Sun,
 09 Mar 2025 04:37:34 -0400
X-MC-Unique: X6xWUR4bNEmvwiA1Hn-4mA-1
X-Mimecast-MFC-AGG-ID: X6xWUR4bNEmvwiA1Hn-4mA_1741509453
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7051D19560B0; Sun,  9 Mar 2025 08:37:33 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.4])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8609F19560AB; Sun,  9 Mar 2025 08:37:31 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>
Subject: [PATCH v2 39/62] docs/qapidoc: add transmogrifier class stub
Date: Sun,  9 Mar 2025 04:35:26 -0400
Message-ID: <20250309083550.5155-40-jsnow@redhat.com>
In-Reply-To: <20250309083550.5155-1-jsnow@redhat.com>
References: <20250309083550.5155-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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
 docs/sphinx/qapidoc.py | 73 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 70 insertions(+), 3 deletions(-)

diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
index 5246832b68c..c243bb6faaa 100644
--- a/docs/sphinx/qapidoc.py
+++ b/docs/sphinx/qapidoc.py
@@ -26,14 +26,17 @@
 
 from __future__ import annotations
 
+from contextlib import contextmanager
 import os
 import sys
 from typing import TYPE_CHECKING
 
 from docutils import nodes
 from docutils.parsers.rst import Directive, directives
+from docutils.statemachine import StringList
 from qapi.error import QAPIError
 from qapi.schema import QAPISchema, QAPISchemaVisitor
+from qapi.source import QAPISourceInfo
 
 from qapidoc_legacy import QAPISchemaGenRSTVisitor  # type: ignore
 from sphinx import addnodes
@@ -44,9 +47,12 @@
 
 
 if TYPE_CHECKING:
-    from typing import Any, List, Sequence
-
-    from docutils.statemachine import StringList
+    from typing import (
+        Any,
+        Generator,
+        List,
+        Sequence,
+    )
 
     from sphinx.application import Sphinx
     from sphinx.util.typing import ExtensionMetadata
@@ -55,6 +61,67 @@
 __version__ = "1.0"
 
 
+class Transmogrifier:
+    def __init__(self) -> None:
+        self._result = StringList()
+        self.indent = 0
+
+    # General-purpose rST generation functions
+
+    def get_indent(self) -> str:
+        return "   " * self.indent
+
+    @contextmanager
+    def indented(self) -> Generator[None]:
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
+        self.add_line_raw(content, info.fname, info.line)
+
+    def add_lines(
+        self,
+        content: str,
+        info: QAPISourceInfo,
+    ) -> None:
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
+            assert isinstance(line, int)
+            # New blank line is credited to one-after the current last line.
+            # +2: correct for zero/one index, then increment by one.
+            self.add_line_raw("", fname, line + 2)
+
+
 class QAPISchemaGenDepVisitor(QAPISchemaVisitor):
     """A QAPI schema visitor which adds Sphinx dependencies each module
 
-- 
2.48.1


