Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C4E5A22D74
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Jan 2025 14:17:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdUPO-0007R1-Nl; Thu, 30 Jan 2025 08:16:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tdUOg-0007JT-AH
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 08:15:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tdUOd-0008S3-4b
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 08:15:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738242949;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lvLWZbNpmkDvoiJJCHx1BQ5Jl5GDuueHWcFNwgJmFeE=;
 b=B4LAqNF2M62f5s/A7J8ayn4emdlqsMT6Ult7WRxRXVChgpLgE3vDA8W5k5/0dfc7cG/oJL
 mqsyjNDNNCESRxuWSGXgwiKW1j0Uh9K0aRp8RPthcuCwXTcuWXVGZ5jlaP47o3Bo0Qvi98
 Gfi8xsb0eKZldIAdtg3oqQntCO6bgtE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-687-xnLXe0DdOIKxJ_-K9jHimw-1; Thu,
 30 Jan 2025 08:15:47 -0500
X-MC-Unique: xnLXe0DdOIKxJ_-K9jHimw-1
X-Mimecast-MFC-AGG-ID: xnLXe0DdOIKxJ_-K9jHimw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DA64519560B4
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2025 13:15:46 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.95])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AD02630001BE; Thu, 30 Jan 2025 13:15:45 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 04/20] tests/functional: Fix the aarch64_tcg_plugins test
Date: Thu, 30 Jan 2025 14:15:18 +0100
Message-ID: <20250130131535.91297-5-thuth@redhat.com>
In-Reply-To: <20250130131535.91297-1-thuth@redhat.com>
References: <20250130131535.91297-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Unfortunately, this test had not been added to meson.build, so we did
not notice a regression: Looking for 'Kernel panic - not syncing: VFS:'
as the indication for the final boot state of the kernel was a bad
idea since 'Kernel panic - not syncing' is the default failure
message of the LinuxKernelTest class, and since we're now reading
the console input byte by byte instead of linewise (see commit
cdad03b74f75), the failure now triggers before we fully read the
success string. Let's fix this by simply looking for the previous
line in the console output instead.

Also, replace the call to cancel() - this was only available in the
Avocado framework. In the functional framework, we must use skipTest()
instead. While we're at it, also fix the TODO here by looking for the
exact error and only skip the test if the plugins are not available.

Fixes: 3abc545e66 ("tests/functional: Convert the tcg_plugins test")
Fixes: cdad03b74f ("tests/functional: rewrite console handling to be bytewise")
Message-ID: <20250123083625.1498495-1-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/meson.build                 |  1 +
 tests/functional/test_aarch64_tcg_plugins.py | 15 +++++++++------
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 3e11b725cb..2b2d8953aa 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -72,6 +72,7 @@ tests_aarch64_system_thorough = [
   'aarch64_sbsaref',
   'aarch64_sbsaref_alpine',
   'aarch64_sbsaref_freebsd',
+  'aarch64_tcg_plugins',
   'aarch64_tuxrun',
   'aarch64_virt',
   'aarch64_xlnx_versal',
diff --git a/tests/functional/test_aarch64_tcg_plugins.py b/tests/functional/test_aarch64_tcg_plugins.py
index 01660eb090..7e8beacc83 100755
--- a/tests/functional/test_aarch64_tcg_plugins.py
+++ b/tests/functional/test_aarch64_tcg_plugins.py
@@ -15,6 +15,7 @@
 import mmap
 import re
 
+from qemu.machine.machine import VMLaunchFailure
 from qemu_test import LinuxKernelTest, Asset
 
 
@@ -43,10 +44,12 @@ def run_vm(self, kernel_path, kernel_command_line,
 
         try:
             vm.launch()
-        except:
-            # TODO: probably fails because plugins not enabled but we
-            # can't currently probe for the feature.
-            self.cancel("TCG Plugins not enabled?")
+        except VMLaunchFailure as excp:
+            if "plugin interface not enabled in this build" in excp.output:
+                self.skipTest("TCG plugins not enabled")
+            else:
+                self.log.info(f"unhandled launch failure: {excp.output}")
+                raise excp
 
         self.wait_for_console_pattern(console_pattern, vm)
         # ensure logs are flushed
@@ -65,7 +68,7 @@ def test_aarch64_virt_insn(self):
         kernel_path = self.ASSET_KERNEL.fetch()
         kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
                                'console=ttyAMA0')
-        console_pattern = 'Kernel panic - not syncing: VFS:'
+        console_pattern = 'Please append a correct "root=" boot option'
 
         plugin_log = tempfile.NamedTemporaryFile(mode="r+t", prefix="plugin",
                                                  suffix=".log")
@@ -91,7 +94,7 @@ def test_aarch64_virt_insn_icount(self):
         kernel_path = self.ASSET_KERNEL.fetch()
         kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
                                'console=ttyAMA0')
-        console_pattern = 'Kernel panic - not syncing: VFS:'
+        console_pattern = 'Please append a correct "root=" boot option'
 
         plugin_log = tempfile.NamedTemporaryFile(mode="r+t", prefix="plugin",
                                                  suffix=".log")
-- 
2.48.1


