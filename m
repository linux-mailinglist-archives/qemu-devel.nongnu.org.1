Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A4DD199271D
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Oct 2024 10:38:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxjEl-00065H-Oc; Mon, 07 Oct 2024 04:37:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sxjEk-00064p-6U
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 04:37:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sxjEg-0006Nz-Ru
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 04:37:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728290217;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=X56J6m3ksGmeIeQ0juQ6+g3Dw6yr+pZHrfPX1DCp2Xk=;
 b=IW3GikM/i9W2XKXFPNbhcc+ScgVbqQvF3wWySHSnkYP3jBqvr56WgCBlkf17UtIBKL2ALB
 SQiwVzsAaQQY7Wj+AK9wLKYdYauK1cgFDMWh1uexhrvwBv8hbeQo5VBCtmJXraqpYxVsYz
 POYG4eohi0dM+0HLVWYwt99u+jtPLyc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-403-UZILxorfPBeT0AN9MMhI-Q-1; Mon,
 07 Oct 2024 04:36:55 -0400
X-MC-Unique: UZILxorfPBeT0AN9MMhI-Q-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F1464195FE3F; Mon,  7 Oct 2024 08:36:53 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.46])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AED9F19560A3; Mon,  7 Oct 2024 08:36:50 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v2] tests/functional: Switch back to the gitlab URLs for the
 advent calendar tests
Date: Mon,  7 Oct 2024 10:36:49 +0200
Message-ID: <20241007083649.204886-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Shortly after we switched to the original URLs on qemu-advent-calendar.org,
the server went offline - looks like we are better off using the gitlab
URLs again instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 v2: Drop the wrong change to the test_microblazeel_s3adsp1800.py file

 tests/functional/test_arm_vexpress.py    | 2 +-
 tests/functional/test_m68k_mcf5208evb.py | 2 +-
 tests/functional/test_or1k_sim.py        | 2 +-
 tests/functional/test_ppc64_e500.py      | 2 +-
 tests/functional/test_ppc_mac.py         | 2 +-
 tests/functional/test_sh4_r2d.py         | 2 +-
 tests/functional/test_sparc_sun4m.py     | 2 +-
 tests/functional/test_xtensa_lx60.py     | 2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tests/functional/test_arm_vexpress.py b/tests/functional/test_arm_vexpress.py
index cc6015112b..6bd6290030 100755
--- a/tests/functional/test_arm_vexpress.py
+++ b/tests/functional/test_arm_vexpress.py
@@ -11,7 +11,7 @@
 class VExpressTest(LinuxKernelTest):
 
     ASSET_DAY16 = Asset(
-        'https://www.qemu-advent-calendar.org/2018/download/day16.tar.xz',
+        'https://qemu-advcal.gitlab.io/qac-best-of-multiarch/download/day16.tar.xz',
         '63311adb2d4c4e7a73214a86d29988add87266a909719c56acfadd026b4110a7')
 
     def test_arm_vexpressa9(self):
diff --git a/tests/functional/test_m68k_mcf5208evb.py b/tests/functional/test_m68k_mcf5208evb.py
index 869ccc88df..00c59590c3 100755
--- a/tests/functional/test_m68k_mcf5208evb.py
+++ b/tests/functional/test_m68k_mcf5208evb.py
@@ -13,7 +13,7 @@
 class Mcf5208EvbTest(LinuxKernelTest):
 
     ASSET_DAY07 = Asset(
-        'https://www.qemu-advent-calendar.org/2018/download/day07.tar.xz',
+        'https://qemu-advcal.gitlab.io/qac-best-of-multiarch/download/day07.tar.xz',
         '753c2f3837126b7c6ba92d0b1e0b156e8a2c5131d2d576bb0b9a763fae73c08a')
 
     def test_m68k_mcf5208evb(self):
diff --git a/tests/functional/test_or1k_sim.py b/tests/functional/test_or1k_sim.py
index aa2a1f08d2..10e0437c50 100755
--- a/tests/functional/test_or1k_sim.py
+++ b/tests/functional/test_or1k_sim.py
@@ -13,7 +13,7 @@
 class OpenRISC1kSimTest(LinuxKernelTest):
 
     ASSET_DAY20 = Asset(
-        'https://www.qemu-advent-calendar.org/2018/download/day20.tar.xz',
+        'https://qemu-advcal.gitlab.io/qac-best-of-multiarch/download/day20.tar.xz',
         'ff9d7dd7c6bdba325bd85ee85c02db61ff653e129558aeffe6aff55bffb6763a')
 
     def test_or1k_sim(self):
diff --git a/tests/functional/test_ppc64_e500.py b/tests/functional/test_ppc64_e500.py
index 3558ae0c8c..f1af92373e 100755
--- a/tests/functional/test_ppc64_e500.py
+++ b/tests/functional/test_ppc64_e500.py
@@ -10,7 +10,7 @@
 class E500Test(LinuxKernelTest):
 
     ASSET_DAY19 = Asset(
-        'https://www.qemu-advent-calendar.org/2018/download/day19.tar.xz',
+        'https://qemu-advcal.gitlab.io/qac-best-of-multiarch/download/day19.tar.xz',
         '20b1bb5a8488c664defbb5d283addc91a05335a936c63b3f5ff7eee74b725755')
 
     def test_ppc64_e500(self):
diff --git a/tests/functional/test_ppc_mac.py b/tests/functional/test_ppc_mac.py
index a6b1ca2d4c..3f45e37a45 100755
--- a/tests/functional/test_ppc_mac.py
+++ b/tests/functional/test_ppc_mac.py
@@ -10,7 +10,7 @@
 class MacTest(LinuxKernelTest):
 
     ASSET_DAY15 = Asset(
-        'https://www.qemu-advent-calendar.org/2018/download/day15.tar.xz',
+        'https://qemu-advcal.gitlab.io/qac-best-of-multiarch/download/day15.tar.xz',
         '03e0757c131d2959decf293a3572d3b96c5a53587165bf05ce41b2818a2bccd5')
 
     def do_day15_test(self):
diff --git a/tests/functional/test_sh4_r2d.py b/tests/functional/test_sh4_r2d.py
index 5fe8cf9f8d..c3cfff79ad 100755
--- a/tests/functional/test_sh4_r2d.py
+++ b/tests/functional/test_sh4_r2d.py
@@ -13,7 +13,7 @@
 class R2dTest(LinuxKernelTest):
 
     ASSET_DAY09 = Asset(
-        'https://www.qemu-advent-calendar.org/2018/download/day09.tar.xz',
+        'https://qemu-advcal.gitlab.io/qac-best-of-multiarch/download/day09.tar.xz',
         'a61b44d2630a739d1380cc4ff4b80981d47ccfd5992f1484ccf48322c35f09ac')
 
     # This test has a 6-10% failure rate on various hosts that look
diff --git a/tests/functional/test_sparc_sun4m.py b/tests/functional/test_sparc_sun4m.py
index b334375820..573f85222a 100755
--- a/tests/functional/test_sparc_sun4m.py
+++ b/tests/functional/test_sparc_sun4m.py
@@ -11,7 +11,7 @@
 class Sun4mTest(LinuxKernelTest):
 
     ASSET_DAY11 = Asset(
-        'https://www.qemu-advent-calendar.org/2018/download/day11.tar.xz',
+        'https://qemu-advcal.gitlab.io/qac-best-of-multiarch/download/day11.tar.xz',
         'c776533ba756bf4dd3f1fc4c024fb50ef0d853e05c5f5ddf0900a32d1eaa49e0')
 
     def test_sparc_ss20(self):
diff --git a/tests/functional/test_xtensa_lx60.py b/tests/functional/test_xtensa_lx60.py
index 8ce5206a4f..d4ad92dc6c 100755
--- a/tests/functional/test_xtensa_lx60.py
+++ b/tests/functional/test_xtensa_lx60.py
@@ -11,7 +11,7 @@
 class XTensaLX60Test(LinuxKernelTest):
 
     ASSET_DAY02 = Asset(
-        'https://www.qemu-advent-calendar.org/2018/download/day02.tar.xz',
+        'https://qemu-advcal.gitlab.io/qac-best-of-multiarch/download/day02.tar.xz',
         '68ff07f9b3fd3df36d015eb46299ba44748e94bfbb2d5295fddc1a8d4a9fd324')
 
     def test_xtensa_lx60(self):
-- 
2.46.1


