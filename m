Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 61DF4B185BF
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Aug 2025 18:25:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhsYQ-0003dG-3e; Fri, 01 Aug 2025 12:24:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uhrSC-0004TU-OS
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 11:13:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uhrSA-0002js-QT
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 11:13:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754061229;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pFRRAPD7J9bYzRMDMci0gEJxp+NnubUn3QJKLuRVcLw=;
 b=MWxMVdGQOz6zpRzj+xYD8dUUlZtovBsYULZjkgQ8NHxkOL7tarKIS3jK+K7dzRqpHiditN
 rl8zaTWKA+wZP9xkRo2hpJ0XS60BfrYrk+HQ1O5pN5otIf+9TOnrg5P8ZEvQl4wFghsuvK
 ZaL7Y2URvaCZ6WCk8dEijA1rOwHhMgw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-586-OtCA88bwPW6NJ0OCXH16DA-1; Fri,
 01 Aug 2025 11:13:45 -0400
X-MC-Unique: OtCA88bwPW6NJ0OCXH16DA-1
X-Mimecast-MFC-AGG-ID: OtCA88bwPW6NJ0OCXH16DA_1754061221
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3542E18015F7; Fri,  1 Aug 2025 15:13:39 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.225.137])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DCD2A180035E; Fri,  1 Aug 2025 15:13:36 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 13/24] tests/functional: Move microblaze tests into
 architecture specific folder
Date: Fri,  1 Aug 2025 17:12:38 +0200
Message-ID: <20250801151251.751368-14-thuth@redhat.com>
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
microblaze tests into a target-specific subfolder.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS                                           |  2 +-
 tests/functional/meson.build                          | 11 ++---------
 tests/functional/microblaze/meson.build               |  6 ++++++
 .../test_replay.py}                                   |  0
 .../test_s3adsp1800.py}                               |  0
 tests/functional/microblazeel/meson.build             |  5 +++++
 .../test_s3adsp1800.py}                               |  2 +-
 7 files changed, 15 insertions(+), 11 deletions(-)
 create mode 100644 tests/functional/microblaze/meson.build
 rename tests/functional/{test_microblaze_replay.py => microblaze/test_replay.py} (100%)
 rename tests/functional/{test_microblaze_s3adsp1800.py => microblaze/test_s3adsp1800.py} (100%)
 create mode 100644 tests/functional/microblazeel/meson.build
 rename tests/functional/{test_microblazeel_s3adsp1800.py => microblazeel/test_s3adsp1800.py} (92%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5860922277e..7e2080faa5c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1367,7 +1367,7 @@ M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
 S: Maintained
 F: hw/microblaze/petalogix_s3adsp1800_mmu.c
 F: include/hw/char/xilinx_uartlite.h
-F: tests/functional/test_microblaze*.py
+F: tests/functional/microblaze*/test_s3adsp1800.py
 
 petalogix_ml605
 M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index cc81d40a314..fc15c261f7b 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -17,6 +17,8 @@ subdir('hppa')
 subdir('i386')
 subdir('loongarch64')
 subdir('m68k')
+subdir('microblaze')
+subdir('microblazeel')
 
 test_mips_timeouts = {
   'mips_malta' : 480,
@@ -82,15 +84,6 @@ tests_generic_linuxuser = [
 tests_generic_bsduser = [
 ]
 
-tests_microblaze_system_thorough = [
-  'microblaze_replay',
-  'microblaze_s3adsp1800'
-]
-
-tests_microblazeel_system_thorough = [
-  'microblazeel_s3adsp1800'
-]
-
 tests_mips_system_thorough = [
   'mips_malta',
   'mips_replay',
diff --git a/tests/functional/microblaze/meson.build b/tests/functional/microblaze/meson.build
new file mode 100644
index 00000000000..8069ca9be60
--- /dev/null
+++ b/tests/functional/microblaze/meson.build
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+tests_microblaze_system_thorough = [
+  'replay',
+  's3adsp1800'
+]
diff --git a/tests/functional/test_microblaze_replay.py b/tests/functional/microblaze/test_replay.py
similarity index 100%
rename from tests/functional/test_microblaze_replay.py
rename to tests/functional/microblaze/test_replay.py
diff --git a/tests/functional/test_microblaze_s3adsp1800.py b/tests/functional/microblaze/test_s3adsp1800.py
similarity index 100%
rename from tests/functional/test_microblaze_s3adsp1800.py
rename to tests/functional/microblaze/test_s3adsp1800.py
diff --git a/tests/functional/microblazeel/meson.build b/tests/functional/microblazeel/meson.build
new file mode 100644
index 00000000000..27619dc5a9a
--- /dev/null
+++ b/tests/functional/microblazeel/meson.build
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+tests_microblazeel_system_thorough = [
+  's3adsp1800'
+]
diff --git a/tests/functional/test_microblazeel_s3adsp1800.py b/tests/functional/microblazeel/test_s3adsp1800.py
similarity index 92%
rename from tests/functional/test_microblazeel_s3adsp1800.py
rename to tests/functional/microblazeel/test_s3adsp1800.py
index 915902d48bd..75ce8856ed1 100755
--- a/tests/functional/test_microblazeel_s3adsp1800.py
+++ b/tests/functional/microblazeel/test_s3adsp1800.py
@@ -7,7 +7,7 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later. See the COPYING file in the top-level directory.
 
-from test_microblaze_s3adsp1800 import MicroblazeMachine
+from microblaze.test_s3adsp1800 import MicroblazeMachine
 
 
 class MicroblazeLittleEndianMachine(MicroblazeMachine):
-- 
2.50.1


