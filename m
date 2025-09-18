Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CEF9B469CA
	for <lists+qemu-devel@lfdr.de>; Sat,  6 Sep 2025 09:07:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uumz6-0001dn-Gj; Sat, 06 Sep 2025 03:05:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1uumyu-0001Jk-OM
 for qemu-devel@nongnu.org; Sat, 06 Sep 2025 03:05:04 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1uumyi-0003Lt-Sk
 for qemu-devel@nongnu.org; Sat, 06 Sep 2025 03:05:03 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8DxudEO3btouFgHAA--.15743S3;
 Sat, 06 Sep 2025 15:04:46 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJDx_8MJ3btoC6OBAA--.17248S11;
 Sat, 06 Sep 2025 15:04:46 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v4 09/13] target/loongarch: Use loongarch_tlb_search_cb in
 helper_invtlb_page_asid_or_g
Date: Sat,  6 Sep 2025 15:04:37 +0800
Message-Id: <20250906070441.3749413-10-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250906070441.3749413-1-maobibo@loongson.cn>
References: <20250906070441.3749413-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDx_8MJ3btoC6OBAA--.17248S11
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
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

With function helper_invtlb_page_asid_or_g(), currently it is to
search TLB entry one by one. Instead STLB can be searched at first
with hash method, and then search MTLB with one by one method.

Here common API loongarch_tlb_search_cb() is used in function
helper_invtlb_page_asid_or_g().

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/loongarch/tcg/tlb_helper.c | 31 ++++++++-----------------------
 1 file changed, 8 insertions(+), 23 deletions(-)

diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index c7f30eaf15..0a87354ba9 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -559,31 +559,16 @@ void helper_invtlb_page_asid(CPULoongArchState *env, target_ulong info,
 void helper_invtlb_page_asid_or_g(CPULoongArchState *env,
                                   target_ulong info, target_ulong addr)
 {
-    uint16_t asid = info & 0x3ff;
-
-    for (int i = 0; i < LOONGARCH_TLB_MAX; i++) {
-        LoongArchTLB *tlb = &env->tlb[i];
-        uint8_t tlb_g = FIELD_EX64(tlb->tlb_entry0, TLBENTRY, G);
-        uint16_t tlb_asid = FIELD_EX64(tlb->tlb_misc, TLB_MISC, ASID);
-        uint64_t vpn, tlb_vppn;
-        uint8_t tlb_ps, compare_shift;
-        uint8_t tlb_e = FIELD_EX64(tlb->tlb_misc, TLB_MISC, E);
-
-        if (!tlb_e) {
-            continue;
-        }
-
-        tlb_ps = FIELD_EX64(tlb->tlb_misc, TLB_MISC, PS);
-        tlb_vppn = FIELD_EX64(tlb->tlb_misc, TLB_MISC, VPPN);
-        vpn = (addr & TARGET_VIRT_MASK) >> (tlb_ps + 1);
-        compare_shift = tlb_ps + 1 - R_TLB_MISC_VPPN_SHIFT;
+    int asid = info & 0x3ff;
+    LoongArchTLB *tlb;
+    tlb_match func;
 
-        if ((tlb_g || (tlb_asid == asid)) &&
-            (vpn == (tlb_vppn >> compare_shift))) {
-            tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, E, 0);
-        }
+    func = tlb_match_any;
+    tlb = loongarch_tlb_search_cb(env, addr, asid, func);
+    if (tlb) {
+        tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, E, 0);
+        tlb_flush(env_cpu(env));
     }
-    tlb_flush(env_cpu(env));
 }
 
 bool loongarch_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
-- 
2.39.3


