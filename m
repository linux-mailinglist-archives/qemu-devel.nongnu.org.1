Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CBF792A388
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jul 2024 15:20:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQoIQ-0002T3-7B; Mon, 08 Jul 2024 09:20:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sQoIC-0001ux-B8; Mon, 08 Jul 2024 09:20:35 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sQoIA-0003fg-KY; Mon, 08 Jul 2024 09:20:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1720444825; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=8RHVADkdlrrTuG148EglpAgGdKZcrHCAouxXGJUl4TA=;
 b=l+/Xfgy1xRGzqSh8KU5cYWNOLkPTpSo6zLA5wZkRUJzxZbSX86rmJ0XLmK+UAnmvb7o5mVd/QcpBwMOtaM0vGB2yNg1Oyuj8bO1bR/1OPSMCZ/+RX/NOpDCceMNM0IhXzUwx/q5Up3j2BDoUu5mvYzIjyiaeXhrkefWite2aBco=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R201e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033068173054;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=11; SR=0;
 TI=SMTPD_---0WA7RcTX_1720444823; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WA7RcTX_1720444823) by smtp.aliyun-inc.com;
 Mon, 08 Jul 2024 21:20:24 +0800
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 zhiwei_liu@linux.alibaba.com, richard.henderson@linaro.org,
 philmd@linaro.org, TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
Subject: [PATCH v4 4/7] target/riscv: Detect sxl to set bit width for RV32 in
 RV64
Date: Mon,  8 Jul 2024 21:16:41 +0800
Message-Id: <20240708131645.1345-5-zhiwei_liu@linux.alibaba.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20240708131645.1345-1-zhiwei_liu@linux.alibaba.com>
References: <20240708131645.1345-1-zhiwei_liu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.132;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-132.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

From: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>

Ensure correct bit width based on sxl when running RV32 on RV64 QEMU.
This is required as MMU address translations run in S-mode.

Signed-off-by: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
Reviewed-by: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_helper.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 6709622dd3..4f0ab90ac7 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -887,12 +887,14 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
 
     CPUState *cs = env_cpu(env);
     int va_bits = PGSHIFT + levels * ptidxbits + widened;
+    int sxlen = 16 << riscv_cpu_sxl(env);
+    int sxlen_bytes = sxlen / 8;
 
     if (first_stage == true) {
         target_ulong mask, masked_msbs;
 
-        if (TARGET_LONG_BITS > (va_bits - 1)) {
-            mask = (1L << (TARGET_LONG_BITS - (va_bits - 1))) - 1;
+        if (sxlen > (va_bits - 1)) {
+            mask = (1L << (sxlen - (va_bits - 1))) - 1;
         } else {
             mask = 0;
         }
@@ -961,7 +963,7 @@ restart:
 
         int pmp_prot;
         int pmp_ret = get_physical_address_pmp(env, &pmp_prot, pte_addr,
-                                               sizeof(target_ulong),
+                                               sxlen_bytes,
                                                MMU_DATA_LOAD, PRV_S);
         if (pmp_ret != TRANSLATE_SUCCESS) {
             return TRANSLATE_PMP_FAIL;
@@ -1113,7 +1115,7 @@ restart:
          *   it is no longer valid and we must re-walk the page table.
          */
         MemoryRegion *mr;
-        hwaddr l = sizeof(target_ulong), addr1;
+        hwaddr l = sxlen_bytes, addr1;
         mr = address_space_translate(cs->as, pte_addr, &addr1, &l,
                                      false, MEMTXATTRS_UNSPECIFIED);
         if (memory_region_is_ram(mr)) {
@@ -1125,7 +1127,12 @@ restart:
              */
             *pte_pa = pte = updated_pte;
 #else
-            target_ulong old_pte = qatomic_cmpxchg(pte_pa, pte, updated_pte);
+            target_ulong old_pte;
+            if (riscv_cpu_sxl(env) == MXL_RV32) {
+                old_pte = qatomic_cmpxchg((uint32_t *)pte_pa, pte, updated_pte);
+            } else {
+                old_pte = qatomic_cmpxchg(pte_pa, pte, updated_pte);
+            }
             if (old_pte != pte) {
                 goto restart;
             }
-- 
2.43.0


