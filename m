Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BFAB9E6F09
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Dec 2024 14:13:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJY87-0004Ze-Bn; Fri, 06 Dec 2024 08:12:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tJY85-0004Uf-8i
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 08:12:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tJY83-000770-FY
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 08:12:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733490738;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8ZrjqSEqsqiCmDFS4Jy0NVtxIhdOdq1hlkgv8ya55oc=;
 b=GUBD69efKCCOXsNa4xXIRaM9U59fRi9KJdIHfTB0VQOMgFSBeFdT77Z5TMt8N7+m5r4W/b
 jbaUvVPFKv8K6FaKihs0nE4BOltPp2BQ/RgyeOGQ1qfH2yjYLzrCpFEeC4UubANvPCTYGS
 qq6DvbMCw0M/apK7s+jcFMlSVZi3KxQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-ga61lMDnPeaVzMiRvn7Jig-1; Fri,
 06 Dec 2024 08:12:14 -0500
X-MC-Unique: ga61lMDnPeaVzMiRvn7Jig-1
X-Mimecast-MFC-AGG-ID: ga61lMDnPeaVzMiRvn7Jig
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 66F731955F3E; Fri,  6 Dec 2024 13:12:13 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.16])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6E02B1955E9C; Fri,  6 Dec 2024 13:12:10 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 7/7] tests/functional: Move debian boot test from avocado
Date: Fri,  6 Dec 2024 14:11:32 +0100
Message-ID: <20241206131132.520911-8-clg@redhat.com>
In-Reply-To: <20241206131132.520911-1-clg@redhat.com>
References: <20241206131132.520911-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

This simply moves the debian boot test from the avocado testsuite to
the new functional testsuite. No changes in the test.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 tests/avocado/boot_linux_console.py         | 26 ---------------------
 tests/functional/test_arm_aspeed_rainier.py | 24 +++++++++++++++++++
 2 files changed, 24 insertions(+), 26 deletions(-)

diff --git a/tests/avocado/boot_linux_console.py b/tests/avocado/boot_linux_console.py
index 12e24bb05a75..738dd5a8c4bf 100644
--- a/tests/avocado/boot_linux_console.py
+++ b/tests/avocado/boot_linux_console.py
@@ -470,29 +470,3 @@ def test_arm_quanta_gsj_initrd(self):
         self.wait_for_console_pattern('CPU1: thread -1, cpu 1, socket 0')
         self.wait_for_console_pattern(
                 'Give root password for system maintenance')
-
-    def test_arm_ast2600_debian(self):
-        """
-        :avocado: tags=arch:arm
-        :avocado: tags=machine:rainier-bmc
-        """
-        deb_url = ('http://snapshot.debian.org/archive/debian/'
-                   '20220606T211338Z/'
-                   'pool/main/l/linux/'
-                   'linux-image-5.17.0-2-armmp_5.17.6-1%2Bb1_armhf.deb')
-        deb_hash = '8acb2b4439faedc2f3ed4bdb2847ad4f6e0491f73debaeb7f660c8abe4dcdc0e'
-        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash,
-                                    algorithm='sha256')
-        kernel_path = self.extract_from_deb(deb_path, '/boot/vmlinuz-5.17.0-2-armmp')
-        dtb_path = self.extract_from_deb(deb_path,
-                '/usr/lib/linux-image-5.17.0-2-armmp/aspeed-bmc-ibm-rainier.dtb')
-
-        self.vm.set_console()
-        self.vm.add_args('-kernel', kernel_path,
-                         '-dtb', dtb_path,
-                         '-net', 'nic')
-        self.vm.launch()
-        self.wait_for_console_pattern("Booting Linux on physical CPU 0xf00")
-        self.wait_for_console_pattern("SMP: Total of 2 processors activated")
-        self.wait_for_console_pattern("No filesystem could mount root")
-
diff --git a/tests/functional/test_arm_aspeed_rainier.py b/tests/functional/test_arm_aspeed_rainier.py
index a60274926d6f..b856aea6dbd7 100644
--- a/tests/functional/test_arm_aspeed_rainier.py
+++ b/tests/functional/test_arm_aspeed_rainier.py
@@ -36,5 +36,29 @@ def test_arm_aspeed_emmc_boot(self):
         self.wait_for_console_pattern('mmcblk0: p1 p2 p3 p4 p5 p6 p7')
         self.wait_for_console_pattern('IBM eBMC (OpenBMC for IBM Enterprise')
 
+    ASSET_DEBIAN_LINUX_ARMHF_DEB = Asset(
+            ('http://snapshot.debian.org/archive/debian/20220606T211338Z/pool/main/l/linux/linux-image-5.17.0-2-armmp_5.17.6-1%2Bb1_armhf.deb'),
+        '8acb2b4439faedc2f3ed4bdb2847ad4f6e0491f73debaeb7f660c8abe4dcdc0e')
+
+    def test_arm_debian_kernel_boot(self):
+        self.set_machine('rainier-bmc')
+
+        deb_path = self.ASSET_DEBIAN_LINUX_ARMHF_DEB.fetch()
+
+        kernel_path = self.extract_from_deb(deb_path, '/boot/vmlinuz-5.17.0-2-armmp')
+        dtb_path = self.extract_from_deb(deb_path,
+                '/usr/lib/linux-image-5.17.0-2-armmp/aspeed-bmc-ibm-rainier.dtb')
+
+        self.vm.set_console()
+        self.vm.add_args('-kernel', kernel_path,
+                         '-dtb', dtb_path,
+                         '-net', 'nic')
+        self.vm.launch()
+
+        self.wait_for_console_pattern("Booting Linux on physical CPU 0xf00")
+        self.wait_for_console_pattern("SMP: Total of 2 processors activated")
+        self.wait_for_console_pattern("No filesystem could mount root")
+
+
 if __name__ == '__main__':
     AspeedTest.main()
-- 
2.47.0


