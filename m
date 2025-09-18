Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 373EEB41913
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Sep 2025 10:49:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utjAl-0003SP-UI; Wed, 03 Sep 2025 04:48:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1utjAY-0003LE-Ef
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 04:48:42 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1utjAW-0007Nc-Ab
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 04:48:42 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8AxztLlALhoMScGAA--.12811S3;
 Wed, 03 Sep 2025 16:48:37 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJDxbMHcALhoc916AA--.5293S9;
 Wed, 03 Sep 2025 16:48:36 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v3 07/12] target/loongarch: Add common API
 loongarch_tlb_search_cb()
Date: Wed,  3 Sep 2025 16:48:22 +0800
Message-Id: <20250903084827.3085911-8-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250903084827.3085911-1-maobibo@loongson.cn>
References: <20250903084827.3085911-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxbMHcALhoc916AA--.5293S9
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

Common API loongarch_tlb_search_cb() is added here to search TLB entry
with specified address.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/tcg/tlb_helper.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index 006fe1b207..fc853f6e80 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -207,18 +207,16 @@ static uint32_t get_random_tlb(uint32_t low, uint32_t high)
  * field in tlb entry contains bit[47:13], so need adjust.
  * virt_vpn = vaddr[47:13]
  */
-static bool loongarch_tlb_search(CPULoongArchState *env, vaddr vaddr,
-                                 int *index)
+static bool loongarch_tlb_search_cb(CPULoongArchState *env, vaddr vaddr,
+                                    int *index, int asid, tlb_match func)
 {
     LoongArchTLB *tlb;
     uint16_t csr_asid, tlb_asid, stlb_idx;
     uint8_t tlb_e, tlb_ps, tlb_g, stlb_ps;
     int i, compare_shift;
     uint64_t vpn, tlb_vppn;
-    tlb_match func;
 
-    func = tlb_match_any;
-    csr_asid = FIELD_EX64(env->CSR_ASID, CSR_ASID, ASID);
+    csr_asid = asid;
     stlb_ps = FIELD_EX64(env->CSR_STLBPS, CSR_STLBPS, PS);
     vpn = (vaddr & TARGET_VIRT_MASK) >> (stlb_ps + 1);
     stlb_idx = vpn & 0xff; /* VA[25:15] <==> TLBIDX.index for 16KiB Page */
@@ -262,6 +260,17 @@ static bool loongarch_tlb_search(CPULoongArchState *env, vaddr vaddr,
     return false;
 }
 
+static bool loongarch_tlb_search(CPULoongArchState *env, vaddr vaddr,
+                                 int *index)
+{
+    int asid;
+    tlb_match func;
+
+    func = tlb_match_any;
+    asid = FIELD_EX64(env->CSR_ASID, CSR_ASID, ASID);
+    return loongarch_tlb_search_cb(env, vaddr, index, asid, func);
+}
+
 void helper_tlbsrch(CPULoongArchState *env)
 {
     int index, match;
-- 
2.39.3


