Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 42708B2C068
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Aug 2025 13:29:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoKSY-0003Pq-77; Tue, 19 Aug 2025 07:24:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uoKSV-0003Nv-2B
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 07:24:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uoKSR-0007Du-Fm
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 07:24:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755602690;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FVdJJ1AvdcUfocTDevJ8KZ/rsNZ89fUNpetyyw4eVy0=;
 b=RlDCrHuiYn3Uth7j/h//b0LXHQPcGNF+etX/Y9GfepCpaFLi28Tt07gFgHZUdVvCGCkkhv
 6aehO9iE1EAiNXTkoJDvbzcXhj6xujxK/wIjL3L5aInjL9qMxb9rRHm/0Sb43bLiKAWAqJ
 HwkzzKOU/zgGPEw9yRotELQOuWUhS1M=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-213-A49LNdOhMxWrJ8B8-wWxYQ-1; Tue,
 19 Aug 2025 07:24:49 -0400
X-MC-Unique: A49LNdOhMxWrJ8B8-wWxYQ-1
X-Mimecast-MFC-AGG-ID: A49LNdOhMxWrJ8B8-wWxYQ_1755602688
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1ACD918002CC; Tue, 19 Aug 2025 11:24:48 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.251])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 07FED30001A8; Tue, 19 Aug 2025 11:24:45 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 13/25] tests/functional: Move microblaze tests into
 architecture specific folder
Date: Tue, 19 Aug 2025 13:23:50 +0200
Message-ID: <20250819112403.432587-14-thuth@redhat.com>
In-Reply-To: <20250819112403.432587-1-thuth@redhat.com>
References: <20250819112403.432587-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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
index e188de813fb..b6a835777bb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1370,7 +1370,7 @@ M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
 S: Maintained
 F: hw/microblaze/petalogix_s3adsp1800_mmu.c
 F: include/hw/char/xilinx_uartlite.h
-F: tests/functional/test_microblaze*.py
+F: tests/functional/microblaze*/test_s3adsp1800.py
 
 petalogix_ml605
 M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index d32dd4a371f..fee68056145 100644
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


