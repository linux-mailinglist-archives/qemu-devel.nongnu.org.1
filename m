Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 435A0AF8C00
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Jul 2025 10:39:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXbvs-0006ho-4g; Fri, 04 Jul 2025 04:38:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uXbvn-0006fc-6s
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 04:38:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uXbvk-0004Tf-6K
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 04:38:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751618279;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PYeMgjFg032GHfu4oPCpL5YfLHwnY18kdYtSCJsI+ig=;
 b=egPejfEgJqrxxsSndyAeMuQ2hDNZuShDgp8UDNJpKFTg+EpoUnBfkHz/+YvXcNQ5bdbjM6
 PAsqZQs719r5tiiMuaXxLr68V4+pr+LEB8FPFVz1ZpZ7sBv9kpuqDi/QJO3N5Pfppt6wH+
 MR25i6Cg/w2ph8clZO7kGiU0mVShOBU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-134-5rJHuaCnPNGlzr1CM5XiFA-1; Fri,
 04 Jul 2025 04:37:58 -0400
X-MC-Unique: 5rJHuaCnPNGlzr1CM5XiFA-1
X-Mimecast-MFC-AGG-ID: 5rJHuaCnPNGlzr1CM5XiFA_1751618277
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6B43E1808985; Fri,  4 Jul 2025 08:37:56 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.43])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BD9371803AFF; Fri,  4 Jul 2025 08:37:54 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Ed Tanous <etanous@nvidia.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 11/11] tests/functional: Add gb200 tests
Date: Fri,  4 Jul 2025 10:37:23 +0200
Message-ID: <20250704083723.1410455-12-clg@redhat.com>
In-Reply-To: <20250704083723.1410455-1-clg@redhat.com>
References: <20250704083723.1410455-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Ed Tanous <etanous@nvidia.com>

To support the newly added gb200 machine, add appropriate tests and
extend do_test_arm_aspeed_openbmc() to support the hostname of this
new system: "gb200nvl-obmc".

Signed-off-by: Ed Tanous <etanous@nvidia.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250703144249.3348879-5-etanous@nvidia.com
[ clg: Adjust commit log to document do_test_arm_aspeed_openbmc() change ]
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 tests/functional/aspeed.py                    |  9 +++++--
 tests/functional/meson.build                  |  2 ++
 .../test_arm_aspeed_gb200nvl_bmc.py           | 26 +++++++++++++++++++
 3 files changed, 35 insertions(+), 2 deletions(-)
 create mode 100644 tests/functional/test_arm_aspeed_gb200nvl_bmc.py

diff --git a/tests/functional/aspeed.py b/tests/functional/aspeed.py
index 7a40d5dda736..b131703c5283 100644
--- a/tests/functional/aspeed.py
+++ b/tests/functional/aspeed.py
@@ -8,8 +8,13 @@
 class AspeedTest(LinuxKernelTest):
 
     def do_test_arm_aspeed_openbmc(self, machine, image, uboot='2019.04',
-                                   cpu_id='0x0', soc='AST2500 rev A1'):
-        hostname = machine.removesuffix('-bmc')
+                                   cpu_id='0x0', soc='AST2500 rev A1',
+                                   image_hostname=None):
+        # Allow for the image hostname to not end in "-bmc"
+        if image_hostname is not None:
+            hostname = image_hostname
+        else:
+            hostname = machine.removesuffix('-bmc')
 
         self.set_machine(machine)
         self.vm.set_console()
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index fb87b957aa6c..050c9000b95c 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -33,6 +33,7 @@ test_timeouts = {
   'arm_aspeed_ast2600' : 1200,
   'arm_aspeed_bletchley' : 480,
   'arm_aspeed_catalina' : 480,
+  'arm_aspeed_gb200nvl_bmc' : 480,
   'arm_aspeed_rainier' : 480,
   'arm_bpim2u' : 500,
   'arm_collie' : 180,
@@ -129,6 +130,7 @@ tests_arm_system_thorough = [
   'arm_aspeed_ast2600',
   'arm_aspeed_bletchley',
   'arm_aspeed_catalina',
+  'arm_aspeed_gb200nvl_bmc',
   'arm_aspeed_rainier',
   'arm_bpim2u',
   'arm_canona1100',
diff --git a/tests/functional/test_arm_aspeed_gb200nvl_bmc.py b/tests/functional/test_arm_aspeed_gb200nvl_bmc.py
new file mode 100644
index 000000000000..8e8e3f05c1b2
--- /dev/null
+++ b/tests/functional/test_arm_aspeed_gb200nvl_bmc.py
@@ -0,0 +1,26 @@
+#!/usr/bin/env python3
+#
+# Functional test that boots the ASPEED machines
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import Asset
+from aspeed import AspeedTest
+
+
+class GB200Machine(AspeedTest):
+
+    ASSET_GB200_FLASH = Asset(
+        'https://github.com/legoater/qemu-aspeed-boot/raw/refs/heads/master/images/gb200nvl-obmc/obmc-phosphor-image-gb200nvl-obmc-20250702182348.static.mtd.xz',
+        'b84819317cb3dc762895ad507705978ef000bfc77c50c33a63bdd37921db0dbc')
+
+    def test_arm_aspeed_gb200_openbmc(self):
+        image_path = self.uncompress(self.ASSET_GB200_FLASH)
+
+        self.do_test_arm_aspeed_openbmc('gb200nvl-bmc', image=image_path,
+                                        uboot='2019.04', cpu_id='0xf00',
+                                        soc='AST2600 rev A3',
+                                        image_hostname='gb200nvl-obmc')
+
+if __name__ == '__main__':
+    AspeedTest.main()
-- 
2.50.0


