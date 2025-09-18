Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ADAA7B19AA1
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Aug 2025 06:03:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uimLv-0000Sz-DL; Sun, 03 Aug 2025 23:59:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1uimLq-0000Jz-6e
 for qemu-devel@nongnu.org; Sun, 03 Aug 2025 23:59:06 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1uimLm-00014r-BC
 for qemu-devel@nongnu.org; Sun, 03 Aug 2025 23:59:05 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8CxLGv9L5BoZh04AQ--.45687S3;
 Mon, 04 Aug 2025 11:58:53 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJDxQ+T5L5BoVP40AA--.64718S3;
 Mon, 04 Aug 2025 11:58:53 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH 1/6] target/loongarch: Add tlb search callback in
 loongarch_tlb_search()
Date: Mon,  4 Aug 2025 11:58:44 +0800
Message-Id: <20250804035849.1305498-2-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250804035849.1305498-1-maobibo@loongson.cn>
References: <20250804035849.1305498-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxQ+T5L5BoVP40AA--.64718S3
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

With function loongarch_tlb_search(), it is to search TLB entry with
speficied virtual address, the difference is selection with asid and
global bit. Here add callback with selection with asid and global bit.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/tcg/tlb_helper.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index 0a86040c41..1813f13165 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -21,6 +21,17 @@
 #include "cpu-csr.h"
 #include "tcg/tcg_loongarch.h"
 
+typedef bool (*tlb_match)(int global, int asid, int tlb_asid);
+
+static bool tlb_match_any(int global, int asid, int tlb_asid)
+{
+    if (global == 1 || tlb_asid == asid) {
+        return true;
+    }
+
+    return false;
+}
+
 bool check_ps(CPULoongArchState *env, uint8_t tlb_ps)
 {
     if (tlb_ps >= 64) {
@@ -215,9 +226,11 @@ static bool loongarch_tlb_search(CPULoongArchState *env, vaddr vaddr,
     uint8_t tlb_e, tlb_ps, tlb_g, stlb_ps;
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
@@ -231,7 +244,7 @@ static bool loongarch_tlb_search(CPULoongArchState *env, vaddr vaddr,
             tlb_asid = FIELD_EX64(tlb->tlb_misc, TLB_MISC, ASID);
             tlb_g = FIELD_EX64(tlb->tlb_entry0, TLBENTRY, G);
 
-            if ((tlb_g == 1 || tlb_asid == csr_asid) &&
+            if (func(tlb_g, csr_asid, tlb_asid) &&
                 (vpn == (tlb_vppn >> compare_shift))) {
                 *index = i * 256 + stlb_idx;
                 return true;
@@ -250,7 +263,7 @@ static bool loongarch_tlb_search(CPULoongArchState *env, vaddr vaddr,
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


