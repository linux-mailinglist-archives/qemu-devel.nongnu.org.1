Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F2BDEB185C4
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Aug 2025 18:27:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhsa7-00025J-1J; Fri, 01 Aug 2025 12:26:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uhrST-0006Ub-4i
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 11:14:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uhrSR-0002nC-7X
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 11:14:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754061246;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oipK1OeC3bdbJFBzivehJS+QgomO99gXEYY97DjM9B8=;
 b=hwKz6z+wlnHbh3M3rNJow27ukYz9iQCZXuAXV4z/gsP6XWw/Y/PFfIGW/PlyLbEZmzSw4/
 2mMTFkR2s6f5WLO1UpM2hpr0OBBFcjE165pRwLzdCX0/ypr516dVWC4vsU0mw0yzZzEz0Z
 RnKnfLbLb6k+sFq0RuK8YplSi8sIGOY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-638-tJio6C2ZN-uUJFUlBfG99Q-1; Fri,
 01 Aug 2025 11:14:03 -0400
X-MC-Unique: tJio6C2ZN-uUJFUlBfG99Q-1
X-Mimecast-MFC-AGG-ID: tJio6C2ZN-uUJFUlBfG99Q_1754061242
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DE33F1800261; Fri,  1 Aug 2025 15:14:01 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.225.137])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EB7B8180035E; Fri,  1 Aug 2025 15:13:59 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 20/24] tests/functional: Move sh4/sh4eb tests into
 target-specific folders
Date: Fri,  1 Aug 2025 17:12:45 +0200
Message-ID: <20250801151251.751368-21-thuth@redhat.com>
In-Reply-To: <20250801151251.751368-1-thuth@redhat.com>
References: <20250801151251.751368-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The tests/functional folder has become quite crowded, thus move the
sh4 tests into a target-specific subfolder.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS                                       |  4 ++--
 tests/functional/meson.build                      | 15 ++-------------
 tests/functional/sh4/meson.build                  | 10 ++++++++++
 .../{test_sh4_r2d.py => sh4/test_r2d.py}          |  0
 .../{test_sh4_tuxrun.py => sh4/test_tuxrun.py}    |  0
 tests/functional/sh4eb/meson.build                |  5 +++++
 .../{test_sh4eb_r2d.py => sh4eb/test_r2d.py}      |  0
 7 files changed, 19 insertions(+), 15 deletions(-)
 create mode 100644 tests/functional/sh4/meson.build
 rename tests/functional/{test_sh4_r2d.py => sh4/test_r2d.py} (100%)
 rename tests/functional/{test_sh4_tuxrun.py => sh4/test_tuxrun.py} (100%)
 create mode 100644 tests/functional/sh4eb/meson.build
 rename tests/functional/{test_sh4eb_r2d.py => sh4eb/test_r2d.py} (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1f6b85ee132..a0174fca572 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1732,8 +1732,8 @@ F: hw/pci-host/sh_pci.c
 F: hw/timer/sh_timer.c
 F: include/hw/sh4/sh_intc.h
 F: include/hw/timer/tmu012.h
-F: tests/functional/test_sh4*_r2d.py
-F: tests/functional/test_sh4_tuxrun.py
+F: tests/functional/sh4*/test_r2d.py
+F: tests/functional/sh4/test_tuxrun.py
 
 SPARC Machines
 --------------
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index abaa4e00fca..ce713509e32 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -30,10 +30,8 @@ subdir('riscv32')
 subdir('riscv64')
 subdir('rx')
 subdir('s390x')
-
-test_sh4_timeouts = {
-  'sh4_tuxrun' : 240,
-}
+subdir('sh4')
+subdir('sh4eb')
 
 test_x86_64_timeouts = {
   'acpi_bits' : 420,
@@ -56,15 +54,6 @@ tests_generic_linuxuser = [
 tests_generic_bsduser = [
 ]
 
-tests_sh4_system_thorough = [
-  'sh4_r2d',
-  'sh4_tuxrun',
-]
-
-tests_sh4eb_system_thorough = [
-  'sh4eb_r2d',
-]
-
 tests_sparc_system_quick = [
   'sparc_migration',
 ]
diff --git a/tests/functional/sh4/meson.build b/tests/functional/sh4/meson.build
new file mode 100644
index 00000000000..56f824e1e71
--- /dev/null
+++ b/tests/functional/sh4/meson.build
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+test_sh4_timeouts = {
+  'tuxrun' : 240,
+}
+
+tests_sh4_system_thorough = [
+  'r2d',
+  'tuxrun',
+]
diff --git a/tests/functional/test_sh4_r2d.py b/tests/functional/sh4/test_r2d.py
similarity index 100%
rename from tests/functional/test_sh4_r2d.py
rename to tests/functional/sh4/test_r2d.py
diff --git a/tests/functional/test_sh4_tuxrun.py b/tests/functional/sh4/test_tuxrun.py
similarity index 100%
rename from tests/functional/test_sh4_tuxrun.py
rename to tests/functional/sh4/test_tuxrun.py
diff --git a/tests/functional/sh4eb/meson.build b/tests/functional/sh4eb/meson.build
new file mode 100644
index 00000000000..25e9a6e4041
--- /dev/null
+++ b/tests/functional/sh4eb/meson.build
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+tests_sh4eb_system_thorough = [
+  'r2d',
+]
diff --git a/tests/functional/test_sh4eb_r2d.py b/tests/functional/sh4eb/test_r2d.py
similarity index 100%
rename from tests/functional/test_sh4eb_r2d.py
rename to tests/functional/sh4eb/test_r2d.py
-- 
2.50.1


