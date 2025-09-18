Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BEEC4B25D9C
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Aug 2025 09:38:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umSVy-0006tt-Oc; Thu, 14 Aug 2025 03:36:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1umSVp-0006rx-TI
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 03:36:37 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1umSVk-0004Pe-9S
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 03:36:36 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8AxSWr4kZ1o_Ko_AQ--.20323S3;
 Thu, 14 Aug 2025 15:36:24 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJCxM+T4kZ1oM9xKAA--.22944S3;
 Thu, 14 Aug 2025 15:36:24 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH 1/9] target/loongarch: Use auto method with PTW feature
Date: Thu, 14 Aug 2025 15:36:16 +0800
Message-Id: <20250814073624.430928-2-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250814073624.430928-1-maobibo@loongson.cn>
References: <20250814073624.430928-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxM+T4kZ1oM9xKAA--.22944S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

PTW is short for page table walker, it is hardware page table walker
function. With PTW supported, hardware MMU will parse page table
table and update TLB entries automatically.

This patch adds type OnOffAuto for PTW feature setting.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/cpu.c | 22 ++++++++++++++++++++++
 target/loongarch/cpu.h |  2 ++
 2 files changed, 24 insertions(+)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 990985708e..92292e6009 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -495,12 +495,29 @@ static void loongarch_set_lasx(Object *obj, bool value, Error **errp)
     cpu->env.cpucfg[2] = FIELD_DP32(val, CPUCFG2, LASX, value);
 }
 
+static bool loongarch_get_ptw(Object *obj, Error **errp)
+{
+    return LOONGARCH_CPU(obj)->ptw != ON_OFF_AUTO_OFF;
+}
+
+static void loongarch_set_ptw(Object *obj, bool value, Error **errp)
+{
+    LoongArchCPU *cpu = LOONGARCH_CPU(obj);
+    uint32_t val;
+
+    cpu->ptw = value ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
+
+    val = cpu->env.cpucfg[2];
+    cpu->env.cpucfg[2] = FIELD_DP32(val, CPUCFG2, HPTW, value);
+}
+
 static void loongarch_cpu_post_init(Object *obj)
 {
     LoongArchCPU *cpu = LOONGARCH_CPU(obj);
 
     cpu->lbt = ON_OFF_AUTO_OFF;
     cpu->pmu = ON_OFF_AUTO_OFF;
+    cpu->ptw = ON_OFF_AUTO_OFF;
     cpu->lsx = ON_OFF_AUTO_AUTO;
     cpu->lasx = ON_OFF_AUTO_AUTO;
     object_property_add_bool(obj, "lsx", loongarch_get_lsx,
@@ -508,6 +525,11 @@ static void loongarch_cpu_post_init(Object *obj)
     object_property_add_bool(obj, "lasx", loongarch_get_lasx,
                              loongarch_set_lasx);
     /* lbt is enabled only in kvm mode, not supported in tcg mode */
+    if (tcg_enabled()) {
+        object_property_add_bool(obj, "ptw", loongarch_get_ptw,
+                                 loongarch_set_ptw);
+    }
+
     if (kvm_enabled()) {
         kvm_loongarch_cpu_post_init(cpu);
     }
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 3c5fcaa154..76e42f6d4e 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -158,6 +158,7 @@ FIELD(CPUCFG2, LBT_MIPS, 20, 1)
 FIELD(CPUCFG2, LBT_ALL, 18, 3)
 FIELD(CPUCFG2, LSPW, 21, 1)
 FIELD(CPUCFG2, LAM, 22, 1)
+FIELD(CPUCFG2, HPTW, 24, 1)
 
 /* cpucfg[3] bits */
 FIELD(CPUCFG3, CCDMA, 0, 1)
@@ -429,6 +430,7 @@ struct ArchCPU {
     uint32_t  phy_id;
     OnOffAuto lbt;
     OnOffAuto pmu;
+    OnOffAuto ptw;
     OnOffAuto lsx;
     OnOffAuto lasx;
     OnOffAuto kvm_pv_ipi;
-- 
2.39.3


