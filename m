Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0F37D66D0
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 11:30:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvaCk-000531-CO; Wed, 25 Oct 2023 05:29:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qvaCh-0004xA-R1
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 05:29:31 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qvaCc-0001do-EQ
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 05:29:31 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8DxVujs3zhlEIA0AA--.1537S3;
 Wed, 25 Oct 2023 17:29:16 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxK9zp3zhlpuExAA--.39806S6; 
 Wed, 25 Oct 2023 17:29:16 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, philmd@linaro.org,
 alex.bennee@linaro.org, maobibo@loongson.cn
Subject: [risu PATCH 4/5] loongarch: init LASX registers
Date: Wed, 25 Oct 2023 17:29:14 +0800
Message-Id: <20231025092915.902814-5-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20231025092915.902814-1-gaosong@loongson.cn>
References: <20231025092915.902814-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxK9zp3zhlpuExAA--.39806S6
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Most of LoongArch cpus have LSX and LASX, so we can init LASX registers
for risu test. We use $f0-$f31 value to init LASX $vreg0- $vreg31 registers.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 risugen_loongarch64.pm | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/risugen_loongarch64.pm b/risugen_loongarch64.pm
index 5394fdc..b3f901d 100644
--- a/risugen_loongarch64.pm
+++ b/risugen_loongarch64.pm
@@ -374,6 +374,16 @@ sub write_random_register_data($)
     if ($fp_enabled) {
         # Load floating point registers
         write_random_loongarch64_fpdata();
+
+        # Write random LASX data.
+        for (my $i = 0; $i < 32; $i++) {
+            my $tmp_reg = 6;
+            # $fi is lasx register initial value.
+            # movfr2gr.d r6 fi
+            insn32(0x114b800 | $i << 5 | $tmp_reg);
+            # xvreplgr2vr_d  $i r6
+            insn32(0x769f0c00 | 6 << 5 | $i);
+        }
     }
 
     write_random_regdata();
-- 
2.25.1


