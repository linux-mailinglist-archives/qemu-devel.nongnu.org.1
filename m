Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 14970B185D1
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Aug 2025 18:31:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhsYr-0005r3-G6; Fri, 01 Aug 2025 12:24:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uhrSJ-0005FO-F0
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 11:13:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uhrSH-0002lI-PE
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 11:13:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754061237;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zOsXLkgQwvhCL0FcIEPwutsM9p8/52O1BwSSCAb0Msk=;
 b=YBxpTSVFR7I4V0gybgKR+WeylEnMqwdaU5vDTDwmPlaz1It6k/0O0BF5Bmq5A8+Xh83vro
 Xj/vFK1fFty/qGDYduHGuArpWFJQV4IVH5lpRZEO833uKTgzqVGrAyt4nHAKsUn825HgBu
 tlKsmiP0VKNGEPott4XCXvWwkiwToAE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-338-3HEg6e0NOKajPoxoK02g1Q-1; Fri,
 01 Aug 2025 11:13:53 -0400
X-MC-Unique: 3HEg6e0NOKajPoxoK02g1Q-1
X-Mimecast-MFC-AGG-ID: 3HEg6e0NOKajPoxoK02g1Q_1754061232
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 768161956046; Fri,  1 Aug 2025 15:13:52 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.225.137])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 107801800B7F; Fri,  1 Aug 2025 15:13:49 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 17/24] tests/functional: Move riscv32/riscv64 tests into
 target-specific folders
Date: Fri,  1 Aug 2025 17:12:42 +0200
Message-ID: <20250801151251.751368-18-thuth@redhat.com>
In-Reply-To: <20250801151251.751368-1-thuth@redhat.com>
References: <20250801151251.751368-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

From: Thomas Huth <thuth@redhat.com>

The opensbi test is used for both, riscv32 and riscv64. Copy the main
test to the riscv64 folder and add a simple wrapper to the riscv32
folder to be able to run it for that target, too.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS                                   |  3 ++-
 tests/functional/meson.build                  | 24 ++-----------------
 tests/functional/riscv32/meson.build          | 10 ++++++++
 .../test_migration.py}                        |  0
 tests/functional/riscv32/test_opensbi.py      | 10 ++++++++
 .../test_tuxrun.py}                           |  0
 tests/functional/riscv64/meson.build          | 14 +++++++++++
 .../test_migration.py}                        |  0
 .../test_opensbi.py}                          |  0
 .../test_tuxrun.py}                           |  0
 10 files changed, 38 insertions(+), 23 deletions(-)
 create mode 100644 tests/functional/riscv32/meson.build
 rename tests/functional/{test_riscv32_migration.py => riscv32/test_migration.py} (100%)
 create mode 100755 tests/functional/riscv32/test_opensbi.py
 rename tests/functional/{test_riscv32_tuxrun.py => riscv32/test_tuxrun.py} (100%)
 create mode 100644 tests/functional/riscv64/meson.build
 rename tests/functional/{test_riscv64_migration.py => riscv64/test_migration.py} (100%)
 rename tests/functional/{test_riscv_opensbi.py => riscv64/test_opensbi.py} (100%)
 rename tests/functional/{test_riscv64_tuxrun.py => riscv64/test_tuxrun.py} (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 09e31ca1af8..ee26bb82b58 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -331,7 +331,8 @@ F: include/hw/riscv/
 F: linux-user/host/riscv32/
 F: linux-user/host/riscv64/
 F: common-user/host/riscv*
-F: tests/functional/test_riscv*
+F: tests/functional/riscv32
+F: tests/functional/riscv64
 F: tests/tcg/riscv64/
 
 RISC-V XThead* extensions
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index cc0e0bc6e0c..2d8f67fd94f 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -26,10 +26,8 @@ subdir('mips64el')
 subdir('or1k')
 subdir('ppc')
 subdir('ppc64')
-
-test_riscv64_timeouts = {
-  'riscv64_tuxrun' : 120,
-}
+subdir('riscv32')
+subdir('riscv64')
 
 test_s390x_timeouts = {
   's390x_ccw_virtio' : 420,
@@ -60,24 +58,6 @@ tests_generic_linuxuser = [
 tests_generic_bsduser = [
 ]
 
-tests_riscv32_system_quick = [
-  'riscv32_migration',
-  'riscv_opensbi',
-]
-
-tests_riscv32_system_thorough = [
-  'riscv32_tuxrun',
-]
-
-tests_riscv64_system_quick = [
-  'riscv64_migration',
-  'riscv_opensbi',
-]
-
-tests_riscv64_system_thorough = [
-  'riscv64_tuxrun',
-]
-
 tests_rx_system_thorough = [
   'rx_gdbsim',
 ]
diff --git a/tests/functional/riscv32/meson.build b/tests/functional/riscv32/meson.build
new file mode 100644
index 00000000000..f3ebbb8db5d
--- /dev/null
+++ b/tests/functional/riscv32/meson.build
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+tests_riscv32_system_quick = [
+  'migration',
+  'opensbi',
+]
+
+tests_riscv32_system_thorough = [
+  'tuxrun',
+]
diff --git a/tests/functional/test_riscv32_migration.py b/tests/functional/riscv32/test_migration.py
similarity index 100%
rename from tests/functional/test_riscv32_migration.py
rename to tests/functional/riscv32/test_migration.py
diff --git a/tests/functional/riscv32/test_opensbi.py b/tests/functional/riscv32/test_opensbi.py
new file mode 100755
index 00000000000..d1ac706f0bb
--- /dev/null
+++ b/tests/functional/riscv32/test_opensbi.py
@@ -0,0 +1,10 @@
+#!/usr/bin/env python3
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Reuse the 64-bit OpenSBI test for RISC-V 32-bit machines
+
+from riscv64.test_opensbi import RiscvOpenSBI
+
+if __name__ == '__main__':
+    RiscvOpenSBI.main()
diff --git a/tests/functional/test_riscv32_tuxrun.py b/tests/functional/riscv32/test_tuxrun.py
similarity index 100%
rename from tests/functional/test_riscv32_tuxrun.py
rename to tests/functional/riscv32/test_tuxrun.py
diff --git a/tests/functional/riscv64/meson.build b/tests/functional/riscv64/meson.build
new file mode 100644
index 00000000000..2bdd6b408e8
--- /dev/null
+++ b/tests/functional/riscv64/meson.build
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+test_riscv64_timeouts = {
+  'tuxrun' : 120,
+}
+
+tests_riscv64_system_quick = [
+  'migration',
+  'opensbi',
+]
+
+tests_riscv64_system_thorough = [
+  'tuxrun',
+]
diff --git a/tests/functional/test_riscv64_migration.py b/tests/functional/riscv64/test_migration.py
similarity index 100%
rename from tests/functional/test_riscv64_migration.py
rename to tests/functional/riscv64/test_migration.py
diff --git a/tests/functional/test_riscv_opensbi.py b/tests/functional/riscv64/test_opensbi.py
similarity index 100%
rename from tests/functional/test_riscv_opensbi.py
rename to tests/functional/riscv64/test_opensbi.py
diff --git a/tests/functional/test_riscv64_tuxrun.py b/tests/functional/riscv64/test_tuxrun.py
similarity index 100%
rename from tests/functional/test_riscv64_tuxrun.py
rename to tests/functional/riscv64/test_tuxrun.py
-- 
2.50.1


