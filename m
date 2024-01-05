Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 51480824F8A
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 09:13:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLfIR-0002n8-SZ; Fri, 05 Jan 2024 03:11:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaotianrui@loongson.cn>)
 id 1rLfIP-0002ma-8u
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 03:11:13 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhaotianrui@loongson.cn>) id 1rLfIL-0007DV-WF
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 03:11:13 -0500
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8BxXbuZuZdlcEECAA--.114S3;
 Fri, 05 Jan 2024 16:11:05 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8CxO9yQuZdl8xoDAA--.8153S5; 
 Fri, 05 Jan 2024 16:11:05 +0800 (CST)
From: Tianrui Zhao <zhaotianrui@loongson.cn>
To: qemu-devel@nongnu.org
Cc: gaosong@loongson.cn, maobibo@loongson.cn, zhaotianrui@loongson.cn,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, berrange@redhat.com, thuth@redhat.com,
 philmd@linaro.org, richard.henderson@linaro.org, peter.maydell@linaro.org,
 yangxiaojuan@loongson.cn, xianglai li <lixianglai@loongson.cn>
Subject: [PATCH v4 3/9] target/loongarch: Supplement vcpu env initial when
 vcpu reset
Date: Fri,  5 Jan 2024 15:57:58 +0800
Message-Id: <20240105075804.1228596-4-zhaotianrui@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20240105075804.1228596-1-zhaotianrui@loongson.cn>
References: <20240105075804.1228596-1-zhaotianrui@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxO9yQuZdl8xoDAA--.8153S5
X-CM-SenderInfo: p2kd03xldq233l6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163;
 envelope-from=zhaotianrui@loongson.cn; helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Supplement vcpu env initial when vcpu reset, including
init vcpu CSR_CPUID,CSR_TID to cpu->cpu_index. The two
regs will be used in kvm_get/set_csr_ioctl.

Signed-off-by: Tianrui Zhao <zhaotianrui@loongson.cn>
Signed-off-by: xianglai li <lixianglai@loongson.cn>
Reviewed-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/cpu.c | 2 ++
 target/loongarch/cpu.h | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 07319d6fb9..72b83e49aa 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -533,10 +533,12 @@ static void loongarch_cpu_reset_hold(Object *obj)
 
     env->CSR_ESTAT = env->CSR_ESTAT & (~MAKE_64BIT_MASK(0, 2));
     env->CSR_RVACFG = FIELD_DP64(env->CSR_RVACFG, CSR_RVACFG, RBITS, 0);
+    env->CSR_CPUID = cs->cpu_index;
     env->CSR_TCFG = FIELD_DP64(env->CSR_TCFG, CSR_TCFG, EN, 0);
     env->CSR_LLBCTL = FIELD_DP64(env->CSR_LLBCTL, CSR_LLBCTL, KLO, 0);
     env->CSR_TLBRERA = FIELD_DP64(env->CSR_TLBRERA, CSR_TLBRERA, ISTLBR, 0);
     env->CSR_MERRCTL = FIELD_DP64(env->CSR_MERRCTL, CSR_MERRCTL, ISMERR, 0);
+    env->CSR_TID = cs->cpu_index;
 
     env->CSR_PRCFG3 = FIELD_DP64(env->CSR_PRCFG3, CSR_PRCFG3, TLB_TYPE, 2);
     env->CSR_PRCFG3 = FIELD_DP64(env->CSR_PRCFG3, CSR_PRCFG3, MTLB_ENTRY, 63);
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 00d1fba597..f6d5ef0852 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -319,6 +319,7 @@ typedef struct CPUArchState {
     uint64_t CSR_PWCH;
     uint64_t CSR_STLBPS;
     uint64_t CSR_RVACFG;
+    uint64_t CSR_CPUID;
     uint64_t CSR_PRCFG1;
     uint64_t CSR_PRCFG2;
     uint64_t CSR_PRCFG3;
@@ -350,7 +351,6 @@ typedef struct CPUArchState {
     uint64_t CSR_DBG;
     uint64_t CSR_DERA;
     uint64_t CSR_DSAVE;
-    uint64_t CSR_CPUID;
 
 #ifndef CONFIG_USER_ONLY
     LoongArchTLB  tlb[LOONGARCH_TLB_MAX];
-- 
2.39.1


