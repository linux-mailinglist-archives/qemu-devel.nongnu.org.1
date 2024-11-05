Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 573919BCA98
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Nov 2024 11:36:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8Guc-00083v-EQ; Tue, 05 Nov 2024 05:35:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t8GuR-00082p-IS
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 05:35:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t8GuO-0002iH-Cb
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 05:35:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730802933;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=3IjeZHhgrukS63bYFX7rOh2OPgHJRvVOn6pFVT1F1jY=;
 b=L1r5XGZSVtp2G2j51Dqc4Xqh9JefdtU5c+xaoTbQU2+Hok2FkkqaRDHTM4N+kJsl0QGupQ
 KINvyYrjYTve5V6NMJlo5xMm487rRLPARXy8B3DZy5kY9QWii5en2lDBaS+CzYPLzW2DkI
 FTENsUDnEZX2X162qoUtLnEKmMFdtU8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-usqQ-EoTOiOuLN6PFGJarA-1; Tue,
 05 Nov 2024 05:35:29 -0500
X-MC-Unique: usqQ-EoTOiOuLN6PFGJarA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5D28919560A2; Tue,  5 Nov 2024 10:35:26 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.117])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D78FD195607C; Tue,  5 Nov 2024 10:35:21 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Alistair Francis <alistair.francis@wdc.com>
Cc: qemu-riscv@nongnu.org, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH] tests/functional: Convert the RV32-on-RV64 riscv test
Date: Tue,  5 Nov 2024 11:35:19 +0100
Message-ID: <20241105103519.341304-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
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

A straggler that has been added to the Avocado framework while the
conversion to the functional framework was already in progress...
Move it over now, too!

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/avocado/tuxrun_baselines.py       | 16 ----------------
 tests/functional/test_riscv64_tuxrun.py | 13 +++++++++++++
 2 files changed, 13 insertions(+), 16 deletions(-)

diff --git a/tests/avocado/tuxrun_baselines.py b/tests/avocado/tuxrun_baselines.py
index 366c262e32..38064840da 100644
--- a/tests/avocado/tuxrun_baselines.py
+++ b/tests/avocado/tuxrun_baselines.py
@@ -222,19 +222,3 @@ def test_arm64be(self):
                  "rootfs.ext4.zst" :
                  "e6ffd8813c8a335bc15728f2835f90539c84be7f8f5f691a8b01451b47fb4bd7"}
         self.common_tuxrun(csums=sums)
-
-    def test_riscv64_rv32(self):
-        """
-        :avocado: tags=arch:riscv64
-        :avocado: tags=machine:virt
-        :avocado: tags=tuxboot:riscv32
-        :avocado: tags=cpu:rv32
-        """
-        sums = { "Image" :
-                 "89599407d7334de629a40e7ad6503c73670359eb5f5ae9d686353a3d6deccbd5",
-                 "fw_jump.elf" :
-                 "f2ef28a0b77826f79d085d3e4aa686f1159b315eff9099a37046b18936676985",
-                 "rootfs.ext4.zst" :
-                 "7168d296d0283238ea73cd5a775b3dd608e55e04c7b92b76ecce31bb13108cba" }
-
-        self.common_tuxrun(csums=sums)
diff --git a/tests/functional/test_riscv64_tuxrun.py b/tests/functional/test_riscv64_tuxrun.py
index 13501628f9..4e2449539c 100755
--- a/tests/functional/test_riscv64_tuxrun.py
+++ b/tests/functional/test_riscv64_tuxrun.py
@@ -23,6 +23,13 @@ class TuxRunRiscV64Test(TuxRunBaselineTest):
         'https://storage.tuxboot.com/20230331/riscv64/rootfs.ext4.zst',
         'b18e3a3bdf27be03da0b285e84cb71bf09eca071c3a087b42884b6982ed679eb')
 
+    ASSET_RISCV32_KERNEL = Asset(
+        'https://storage.tuxboot.com/20230331/riscv32/Image',
+        '89599407d7334de629a40e7ad6503c73670359eb5f5ae9d686353a3d6deccbd5')
+    ASSET_RISCV32_ROOTFS = Asset(
+        'https://storage.tuxboot.com/20230331/riscv32/rootfs.ext4.zst',
+        '7168d296d0283238ea73cd5a775b3dd608e55e04c7b92b76ecce31bb13108cba')
+
     def test_riscv64(self):
         self.set_machine('virt')
         self.common_tuxrun(kernel_asset=self.ASSET_RISCV64_KERNEL,
@@ -34,5 +41,11 @@ def test_riscv64_maxcpu(self):
         self.common_tuxrun(kernel_asset=self.ASSET_RISCV64_KERNEL,
                            rootfs_asset=self.ASSET_RISCV64_ROOTFS)
 
+    def test_riscv64_rv32(self):
+        self.set_machine('virt')
+        self.cpu='rv32'
+        self.common_tuxrun(kernel_asset=self.ASSET_RISCV32_KERNEL,
+                           rootfs_asset=self.ASSET_RISCV32_ROOTFS)
+
 if __name__ == '__main__':
     TuxRunBaselineTest.main()
-- 
2.47.0


