Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C32C8B4954
	for <lists+qemu-devel@lfdr.de>; Sun, 28 Apr 2024 05:17:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0v2F-0006fc-Fd; Sat, 27 Apr 2024 23:17:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1s0v2C-0006fM-PC
 for qemu-devel@nongnu.org; Sat, 27 Apr 2024 23:17:00 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1s0v29-0000JF-UQ
 for qemu-devel@nongnu.org; Sat, 27 Apr 2024 23:17:00 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8DxUuqlvy1mEzgEAA--.3418S3;
 Sun, 28 Apr 2024 11:16:53 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8CxHlWjvy1mnOgHAA--.5442S2; 
 Sun, 28 Apr 2024 11:16:52 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
Subject: [PATCH] target/loongarch: Put cpucfg operation before CSR register
Date: Sun, 28 Apr 2024 11:16:51 +0800
Message-Id: <20240428031651.1354587-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxHlWjvy1mnOgHAA--.5442S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
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

On Loongarch, cpucfg is register for cpu feature, some other registers
depend on cpucfg feature such as perf CSR registers. Here put cpucfg
read/write operations before CSR register, so that KVM knows how many
perf CSR registers are valid from pre-set cpucfg feature information.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/kvm/kvm.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index 8224d94333..bc75552d0f 100644
--- a/target/loongarch/kvm/kvm.c
+++ b/target/loongarch/kvm/kvm.c
@@ -587,22 +587,22 @@ int kvm_arch_get_registers(CPUState *cs)
         return ret;
     }
 
-    ret = kvm_loongarch_get_csr(cs);
+    ret = kvm_loongarch_get_cpucfg(cs);
     if (ret) {
         return ret;
     }
 
-    ret = kvm_loongarch_get_regs_fp(cs);
+    ret = kvm_loongarch_get_csr(cs);
     if (ret) {
         return ret;
     }
 
-    ret = kvm_loongarch_get_mpstate(cs);
+    ret = kvm_loongarch_get_regs_fp(cs);
     if (ret) {
         return ret;
     }
 
-    ret = kvm_loongarch_get_cpucfg(cs);
+    ret = kvm_loongarch_get_mpstate(cs);
     return ret;
 }
 
@@ -615,22 +615,22 @@ int kvm_arch_put_registers(CPUState *cs, int level)
         return ret;
     }
 
-    ret = kvm_loongarch_put_csr(cs, level);
+    ret = kvm_loongarch_put_cpucfg(cs);
     if (ret) {
         return ret;
     }
 
-    ret = kvm_loongarch_put_regs_fp(cs);
+    ret = kvm_loongarch_put_csr(cs, level);
     if (ret) {
         return ret;
     }
 
-    ret = kvm_loongarch_put_mpstate(cs);
+    ret = kvm_loongarch_put_regs_fp(cs);
     if (ret) {
         return ret;
     }
 
-    ret = kvm_loongarch_put_cpucfg(cs);
+    ret = kvm_loongarch_put_mpstate(cs);
     return ret;
 }
 

base-commit: a118c4aff4087eafb68f7132b233ad548cf16376
-- 
2.39.3


