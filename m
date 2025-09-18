Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C684EB469C9
	for <lists+qemu-devel@lfdr.de>; Sat,  6 Sep 2025 09:07:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uumz1-0001Ux-Hs; Sat, 06 Sep 2025 03:05:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1uumyu-0001Jo-Pj
 for qemu-devel@nongnu.org; Sat, 06 Sep 2025 03:05:04 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1uumyi-0003Ld-1W
 for qemu-devel@nongnu.org; Sat, 06 Sep 2025 03:05:03 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8DxLvAO3btor1gHAA--.15662S3;
 Sat, 06 Sep 2025 15:04:46 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJDx_8MJ3btoC6OBAA--.17248S8;
 Sat, 06 Sep 2025 15:04:45 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v4 06/13] target/loongarch: Add tlb search callback in
 loongarch_tlb_search()
Date: Sat,  6 Sep 2025 15:04:34 +0800
Message-Id: <20250906070441.3749413-7-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250906070441.3749413-1-maobibo@loongson.cn>
References: <20250906070441.3749413-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDx_8MJ3btoC6OBAA--.17248S8
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

With function loongarch_tlb_search(), it is to search TLB entry with
speficied virtual address, the difference is selection with asid and
global bit. Here add selection callback with asid and global bit.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/loongarch/tcg/tlb_helper.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index b46621f203..fda81f190a 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -21,6 +21,13 @@
 #include "cpu-csr.h"
 #include "tcg/tcg_loongarch.h"
 
+typedef bool (*tlb_match)(bool global, int asid, int tlb_asid);
+
+static bool tlb_match_any(bool global, int asid, int tlb_asid)
+{
+    return global || tlb_asid == asid;
+}
+
 bool check_ps(CPULoongArchState *env, uint8_t tlb_ps)
 {
     if (tlb_ps >= 64) {
@@ -201,12 +208,15 @@ static bool loongarch_tlb_search(CPULoongArchState *env, vaddr vaddr,
 {
     LoongArchTLB *tlb;
     uint16_t csr_asid, tlb_asid, stlb_idx;
-    uint8_t tlb_e, tlb_ps, tlb_g, stlb_ps;
+    uint8_t tlb_e, tlb_ps, stlb_ps;
+    bool tlb_g;
     int i, compare_shift;
     uint64_t vpn, tlb_vppn;
+    tlb_match func;
 
+    func = tlb_match_any;
     csr_asid = FIELD_EX64(env->CSR_ASID, CSR_ASID, ASID);
-   stlb_ps = FIELD_EX64(env->CSR_STLBPS, CSR_STLBPS, PS);
+    stlb_ps = FIELD_EX64(env->CSR_STLBPS, CSR_STLBPS, PS);
     vpn = (vaddr & TARGET_VIRT_MASK) >> (stlb_ps + 1);
     stlb_idx = vpn & 0xff; /* VA[25:15] <==> TLBIDX.index for 16KiB Page */
     compare_shift = stlb_ps + 1 - R_TLB_MISC_VPPN_SHIFT;
@@ -218,9 +228,9 @@ static bool loongarch_tlb_search(CPULoongArchState *env, vaddr vaddr,
         if (tlb_e) {
             tlb_vppn = FIELD_EX64(tlb->tlb_misc, TLB_MISC, VPPN);
             tlb_asid = FIELD_EX64(tlb->tlb_misc, TLB_MISC, ASID);
-            tlb_g = FIELD_EX64(tlb->tlb_entry0, TLBENTRY, G);
+            tlb_g = !!FIELD_EX64(tlb->tlb_entry0, TLBENTRY, G);
 
-            if ((tlb_g == 1 || tlb_asid == csr_asid) &&
+            if (func(tlb_g, csr_asid, tlb_asid) &&
                 (vpn == (tlb_vppn >> compare_shift))) {
                 *index = i * 256 + stlb_idx;
                 return true;
@@ -239,7 +249,7 @@ static bool loongarch_tlb_search(CPULoongArchState *env, vaddr vaddr,
             tlb_g = FIELD_EX64(tlb->tlb_entry0, TLBENTRY, G);
             compare_shift = tlb_ps + 1 - R_TLB_MISC_VPPN_SHIFT;
             vpn = (vaddr & TARGET_VIRT_MASK) >> (tlb_ps + 1);
-            if ((tlb_g == 1 || tlb_asid == csr_asid) &&
+            if (func(tlb_g, csr_asid, tlb_asid) &&
                 (vpn == (tlb_vppn >> compare_shift))) {
                 *index = i;
                 return true;
-- 
2.39.3


