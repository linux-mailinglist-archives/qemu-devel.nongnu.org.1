Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6BC72F1F4
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 03:33:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9FCd-0005Sn-07; Tue, 13 Jun 2023 21:21:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FCa-0005Jl-Sv
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:21:36 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FCY-0004cr-0u
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:21:35 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6537d2a8c20so4950335b3a.2
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 18:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686705692; x=1689297692;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aFV+fw31FylRixKzTrvacU7lGvyFfcKEfv9NZgaC2Pw=;
 b=PJHiXcykAr3KdOfgo5OpyzNb2HLiXUSD2QlQvQPjc0CLVuiXwV+2BJQPRe2ZUAs2fh
 EhRoJ8uOFAs+o4Lm1Oco2I3eMgfcPPC226Dlt2oDvjzvENm8E4Pfan9or8twtca6BeX0
 VIZdSSkf5IXabFL4SwzPSvcOBeKemA+aOMXOHafI6axACgTPmlZ0jd122JsEcP8GQ4m3
 hh7la/iChvwyh7AyG4BqcWWyumwUU4bW1lCaGQtDAUzp5kfxV2hCy2DHUU0klytnxRw8
 0DV9Jf3BJ2QmUPEjUK+5LiOaMwmYSMnOBrSZHQo0P0YbkgEBwgYJ//scI+6fatudVgMM
 o4tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686705692; x=1689297692;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aFV+fw31FylRixKzTrvacU7lGvyFfcKEfv9NZgaC2Pw=;
 b=JEZRF888LfPdLdKYR6kUl3J9JdgPlk4yUBB6kxKpmPXzV64hAdSVvsJM3KzasQx0T9
 FR2I6U3k7ah+Y1ojk5y0LlFrb6zVgkedkyDCNMD0/FUPFGx2MoGIsL1ZJALReCxxtYWh
 QJ9JOaEMf9AlokCvKMwqYR5e6XTL0pdRk2U/RVIMvderaa885gLO8XSEb8fVjB/2vkNq
 e0GGy9I5TZFKBy/vxBKn7sXsU9UDfGxBLMRn5JOWPe87AmROOXHgICl/iCufpylssjkR
 dDTZSO0rrEhaQJGTKJhpdpOnf/j4n7CUnSlZ/3fD9Ut2uK5lg36VfZUJ+dt2pptvMnc2
 36nA==
X-Gm-Message-State: AC+VfDxHcz8rIs8cB6XwuKaFghKqwKPCQSMEm5G4i7pAX+iXnyOSAgdb
 HmIk23M11bpLoeUaRD4Tuth8crmFQD4XcA==
X-Google-Smtp-Source: ACHHUZ5UTl6O0LMrIQA8troqRI1uE4gEOKxTes/kVZJfmDRRz954UAwkF0eeN2vpNzDiScGjMHmHrQ==
X-Received: by 2002:a05:6a21:1519:b0:101:5037:7542 with SMTP id
 nq25-20020a056a21151900b0010150377542mr622467pzb.10.1686705692598; 
 Tue, 13 Jun 2023 18:21:32 -0700 (PDT)
Received: from toolbox.wdc.com
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u1-20020aa78381000000b0064f7c56d8b7sm9112238pfm.219.2023.06.13.18.21.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jun 2023 18:21:32 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Weiwei Li <liweiwei@iscas.ac.cn>,
 Junqiang Wang <wangjunqiang@iscas.ac.cn>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 14/60] target/riscv: Update pmp_get_tlb_size()
Date: Wed, 14 Jun 2023 11:19:31 +1000
Message-Id: <20230614012017.3100663-15-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230614012017.3100663-1-alistair.francis@wdc.com>
References: <20230614012017.3100663-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x431.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Weiwei Li <liweiwei@iscas.ac.cn>

PMP entries before (including) the matched PMP entry may only cover partial
of the TLB page, and this may split the page into regions with different
permissions. Such as for PMP0 (0x80000008~0x8000000F, R) and PMP1 (0x80000000~
0x80000FFF, RWX), write access to 0x80000000 will match PMP1. However we cannot
cache the translation result in the TLB since this will make the write access
to 0x80000008 bypass the check of PMP0. So we should check all of them instead
of the matched PMP entry in pmp_get_tlb_size() and set the tlb_size to 1 in
this case.
Set tlb_size to TARGET_PAGE_SIZE if PMP is not support or there is no PMP rules.

Signed-off-by: Weiwei Li <liweiwei@iscas.ac.cn>
Signed-off-by: Junqiang Wang <wangjunqiang@iscas.ac.cn>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20230517091519.34439-2-liweiwei@iscas.ac.cn>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/pmp.h        |  3 +-
 target/riscv/cpu_helper.c |  7 ++--
 target/riscv/pmp.c        | 69 ++++++++++++++++++++++++++++++---------
 3 files changed, 57 insertions(+), 22 deletions(-)

diff --git a/target/riscv/pmp.h b/target/riscv/pmp.h
index b296ea1fc6..0a7e24750b 100644
--- a/target/riscv/pmp.h
+++ b/target/riscv/pmp.h
@@ -76,8 +76,7 @@ int pmp_hart_has_privs(CPURISCVState *env, target_ulong addr,
                        target_ulong size, pmp_priv_t privs,
                        pmp_priv_t *allowed_privs,
                        target_ulong mode);
-target_ulong pmp_get_tlb_size(CPURISCVState *env, int pmp_index,
-                              target_ulong tlb_sa, target_ulong tlb_ea);
+target_ulong pmp_get_tlb_size(CPURISCVState *env, target_ulong addr);
 void pmp_update_rule_addr(CPURISCVState *env, uint32_t pmp_index);
 void pmp_update_rule_nums(CPURISCVState *env);
 uint32_t pmp_get_num_rules(CPURISCVState *env);
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 56381aaf26..065b433b88 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -715,11 +715,8 @@ static int get_physical_address_pmp(CPURISCVState *env, int *prot,
     }
 
     *prot = pmp_priv_to_page_prot(pmp_priv);
-    if ((tlb_size != NULL) && pmp_index != MAX_RISCV_PMPS) {
-        target_ulong tlb_sa = addr & ~(TARGET_PAGE_SIZE - 1);
-        target_ulong tlb_ea = tlb_sa + TARGET_PAGE_SIZE - 1;
-
-        *tlb_size = pmp_get_tlb_size(env, pmp_index, tlb_sa, tlb_ea);
+    if (tlb_size != NULL) {
+        *tlb_size = pmp_get_tlb_size(env, addr);
     }
 
     return TRANSLATE_SUCCESS;
diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
index 1f5aca42e8..2bc924340a 100644
--- a/target/riscv/pmp.c
+++ b/target/riscv/pmp.c
@@ -601,28 +601,67 @@ target_ulong mseccfg_csr_read(CPURISCVState *env)
 }
 
 /*
- * Calculate the TLB size if the start address or the end address of
- * PMP entry is presented in the TLB page.
+ * Calculate the TLB size.
+ * It's possible that PMP regions only cover partial of the TLB page, and
+ * this may split the page into regions with different permissions.
+ * For example if PMP0 is (0x80000008~0x8000000F, R) and PMP1 is (0x80000000
+ * ~0x80000FFF, RWX), then region 0x80000008~0x8000000F has R permission, and
+ * the other regions in this page have RWX permissions.
+ * A write access to 0x80000000 will match PMP1. However we cannot cache the
+ * translation result in the TLB since this will make the write access to
+ * 0x80000008 bypass the check of PMP0.
+ * To avoid this we return a size of 1 (which means no caching) if the PMP
+ * region only covers partial of the TLB page.
  */
-target_ulong pmp_get_tlb_size(CPURISCVState *env, int pmp_index,
-                              target_ulong tlb_sa, target_ulong tlb_ea)
+target_ulong pmp_get_tlb_size(CPURISCVState *env, target_ulong addr)
 {
-    target_ulong pmp_sa = env->pmp_state.addr[pmp_index].sa;
-    target_ulong pmp_ea = env->pmp_state.addr[pmp_index].ea;
+    target_ulong pmp_sa;
+    target_ulong pmp_ea;
+    target_ulong tlb_sa = addr & ~(TARGET_PAGE_SIZE - 1);
+    target_ulong tlb_ea = tlb_sa + TARGET_PAGE_SIZE - 1;
+    int i;
 
-    if (pmp_sa <= tlb_sa && pmp_ea >= tlb_ea) {
+    /*
+     * If PMP is not supported or there are no PMP rules, the TLB page will not
+     * be split into regions with different permissions by PMP so we set the
+     * size to TARGET_PAGE_SIZE.
+     */
+    if (!riscv_cpu_cfg(env)->pmp || !pmp_get_num_rules(env)) {
         return TARGET_PAGE_SIZE;
-    } else {
+    }
+
+    for (i = 0; i < MAX_RISCV_PMPS; i++) {
+        if (pmp_get_a_field(env->pmp_state.pmp[i].cfg_reg) == PMP_AMATCH_OFF) {
+            continue;
+        }
+
+        pmp_sa = env->pmp_state.addr[i].sa;
+        pmp_ea = env->pmp_state.addr[i].ea;
+
         /*
-         * At this point we have a tlb_size that is the smallest possible size
-         * That fits within a TARGET_PAGE_SIZE and the PMP region.
-         *
-         * If the size is less then TARGET_PAGE_SIZE we drop the size to 1.
-         * This means the result isn't cached in the TLB and is only used for
-         * a single translation.
+         * Only the first PMP entry that covers (whole or partial of) the TLB
+         * page really matters:
+         * If it covers the whole TLB page, set the size to TARGET_PAGE_SIZE,
+         * since the following PMP entries have lower priority and will not
+         * affect the permissions of the page.
+         * If it only covers partial of the TLB page, set the size to 1 since
+         * the allowed permissions of the region may be different from other
+         * region of the page.
          */
-        return 1;
+        if (pmp_sa <= tlb_sa && pmp_ea >= tlb_ea) {
+            return TARGET_PAGE_SIZE;
+        } else if ((pmp_sa >= tlb_sa && pmp_sa <= tlb_ea) ||
+                   (pmp_ea >= tlb_sa && pmp_ea <= tlb_ea)) {
+            return 1;
+        }
     }
+
+    /*
+     * If no PMP entry matches the TLB page, the TLB page will also not be
+     * split into regions with different permissions by PMP so we set the size
+     * to TARGET_PAGE_SIZE.
+     */
+    return TARGET_PAGE_SIZE;
 }
 
 /*
-- 
2.40.1


