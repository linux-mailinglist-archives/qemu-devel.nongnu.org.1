Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6317C9DEBAE
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Nov 2024 18:33:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tH4qJ-0003XV-Db; Fri, 29 Nov 2024 12:31:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tH4qG-0003Wy-N8
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 12:31:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tH4qF-0000s0-2h
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 12:31:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732901502;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DpH98FjxHZ1UVnVesB0HAAW6c+0dIFSrTacLuFyVkfg=;
 b=L7VPcpRcU/czl12HMekpXfhcYH9D05gt997jb0W+SRCLiMfUpZojOu3ns0vOo8YOv3XlbK
 9jIL+hPKxqHMX7HSsHIZi4lCCg+LygRtDtxbbOGo/G0ZlrmWQkqCpGAqI91I4ZaH/LiSSs
 eVJM/M+1E2aLm4O075BFoFB9PucciMc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-48-FtXx4xptOdO7FA-MwmeH2A-1; Fri,
 29 Nov 2024 12:31:39 -0500
X-MC-Unique: FtXx4xptOdO7FA-MwmeH2A-1
X-Mimecast-MFC-AGG-ID: FtXx4xptOdO7FA-MwmeH2A
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F192E1955EA9; Fri, 29 Nov 2024 17:31:37 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.37])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F1B371955F41; Fri, 29 Nov 2024 17:31:35 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 05/22] tests/functional: remove duplicated 'which' function
 impl
Date: Fri, 29 Nov 2024 17:31:03 +0000
Message-ID: <20241129173120.761728-6-berrange@redhat.com>
In-Reply-To: <20241129173120.761728-1-berrange@redhat.com>
References: <20241129173120.761728-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Put the 'which' function into shared code.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/functional/qemu_test/__init__.py |  2 +-
 tests/functional/qemu_test/cmd.py      | 10 ++++++++++
 tests/functional/test_acpi_bits.py     | 13 +------------
 tests/functional/test_ppc64_hv.py      | 13 +------------
 4 files changed, 13 insertions(+), 25 deletions(-)

diff --git a/tests/functional/qemu_test/__init__.py b/tests/functional/qemu_test/__init__.py
index 67f87be9c4..8fddddbe67 100644
--- a/tests/functional/qemu_test/__init__.py
+++ b/tests/functional/qemu_test/__init__.py
@@ -10,6 +10,6 @@
 from .config import BUILD_DIR
 from .cmd import has_cmd, has_cmds, run_cmd, is_readable_executable_file, \
     interrupt_interactive_console_until_pattern, wait_for_console_pattern, \
-    exec_command, exec_command_and_wait_for_pattern, get_qemu_img
+    exec_command, exec_command_and_wait_for_pattern, get_qemu_img, which
 from .testcase import QemuBaseTest, QemuUserTest, QemuSystemTest
 from .linuxkernel import LinuxKernelTest
diff --git a/tests/functional/qemu_test/cmd.py b/tests/functional/qemu_test/cmd.py
index 11c8334a7c..4106f1ee7c 100644
--- a/tests/functional/qemu_test/cmd.py
+++ b/tests/functional/qemu_test/cmd.py
@@ -18,6 +18,16 @@
 
 from .config import BUILD_DIR
 
+def which(tool):
+    """ looks up the full path for @tool, returns None if not found
+        or if @tool does not have executable permissions.
+    """
+    paths=os.getenv('PATH')
+    for p in paths.split(os.path.pathsep):
+        p = os.path.join(p, tool)
+        if os.path.exists(p) and os.access(p, os.X_OK):
+            return p
+    return None
 
 def has_cmd(name, args=None):
     """
diff --git a/tests/functional/test_acpi_bits.py b/tests/functional/test_acpi_bits.py
index 6fc49a30bc..4162faf414 100755
--- a/tests/functional/test_acpi_bits.py
+++ b/tests/functional/test_acpi_bits.py
@@ -49,7 +49,7 @@
 )
 from qemu.machine import QEMUMachine
 from unittest import skipIf
-from qemu_test import QemuBaseTest, Asset
+from qemu_test import QemuBaseTest, Asset, which
 
 deps = ["xorriso", "mformat"] # dependent tools needed in the test setup/box.
 supported_platforms = ['x86_64'] # supported test platforms.
@@ -57,17 +57,6 @@
 # default timeout of 120 secs is sometimes not enough for bits test.
 BITS_TIMEOUT = 200
 
-def which(tool):
-    """ looks up the full path for @tool, returns None if not found
-        or if @tool does not have executable permissions.
-    """
-    paths=os.getenv('PATH')
-    for p in paths.split(os.path.pathsep):
-        p = os.path.join(p, tool)
-        if os.path.exists(p) and os.access(p, os.X_OK):
-            return p
-    return None
-
 def missing_deps():
     """ returns True if any of the test dependent tools are absent.
     """
diff --git a/tests/functional/test_ppc64_hv.py b/tests/functional/test_ppc64_hv.py
index 53bae90401..cc77cd22b1 100755
--- a/tests/functional/test_ppc64_hv.py
+++ b/tests/functional/test_ppc64_hv.py
@@ -11,7 +11,7 @@
 
 from unittest import skipIf, skipUnless
 from qemu_test import (QemuSystemTest, Asset, wait_for_console_pattern,
-                       exec_command)
+                       exec_command, which)
 import os
 import time
 import subprocess
@@ -19,17 +19,6 @@
 
 deps = ["xorriso"] # dependent tools needed in the test setup/box.
 
-def which(tool):
-    """ looks up the full path for @tool, returns None if not found
-        or if @tool does not have executable permissions.
-    """
-    paths=os.getenv('PATH')
-    for p in paths.split(os.path.pathsep):
-        p = os.path.join(p, tool)
-        if os.path.exists(p) and os.access(p, os.X_OK):
-            return p
-    return None
-
 def missing_deps():
     """ returns True if any of the test dependent tools are absent.
     """
-- 
2.46.0


