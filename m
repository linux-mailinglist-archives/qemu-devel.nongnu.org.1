Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A2B79D50D
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 17:36:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg5QB-0007O5-1e; Tue, 12 Sep 2023 11:35:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qg5Q5-0007MO-01
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 11:35:17 -0400
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qg5Po-0001XR-2O
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 11:35:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ggUCBX4pndpvew0+Bvf3La4j0PlM5VB5bL6z/4Z5DO0=; b=lhyJRwfCafonpgCKNl1FepWY/0
 bPkno0UlfOuqIkY5dNBghu6Ul/mgRh9BA8RFj8hLMsTSf8VKHVwG2UeowzXab1+gCI3ZdQ0EHvH8P
 sCLw/iUavXNiZRiKuxR40jHbociPnJ96SwvVmmT9G9aBISxzBS8SN0qwiwaB+hRZ+jnI=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, richard.henderson@linaro.org, pbonzini@redhat.com,
 philmd@linaro.org, peter.maydell@linaro.org
Subject: [PATCH 09/11] tcg: Update env_tlb() comments
Date: Tue, 12 Sep 2023 17:34:26 +0200
Message-ID: <20230912153428.17816-10-anjo@rev.ng>
In-Reply-To: <20230912153428.17816-1-anjo@rev.ng>
References: <20230912153428.17816-1-anjo@rev.ng>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=5.9.113.41; envelope-from=anjo@rev.ng; helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 tcg/aarch64/tcg-target.c.inc | 2 +-
 tcg/arm/tcg-target.c.inc     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 0931a69448..d2f5ca5946 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -1676,7 +1676,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
     mask_type = (s->page_bits + s->tlb_dyn_max_bits > 32
                  ? TCG_TYPE_I64 : TCG_TYPE_I32);
 
-    /* Load env_tlb(env)->f[mmu_idx].{mask,table} into {tmp0,tmp1}. */
+    /* Load cpu_tlb(cpu)->f[mmu_idx].{mask,table} into {tmp0,tmp1}. */
     QEMU_BUILD_BUG_ON(offsetof(CPUTLBDescFast, mask) != 0);
     QEMU_BUILD_BUG_ON(offsetof(CPUTLBDescFast, table) != 8);
     tcg_out_insn(s, 3314, LDP, TCG_REG_TMP0, TCG_REG_TMP1, TCG_AREG0,
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index acb5f23b54..9b96f5e7b5 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -1420,7 +1420,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
     ldst->addrlo_reg = addrlo;
     ldst->addrhi_reg = addrhi;
 
-    /* Load env_tlb(env)->f[mmu_idx].{mask,table} into {r0,r1}.  */
+    /* Load cpu_tlb(cpu)->f[mmu_idx].{mask,table} into {r0,r1}.  */
     QEMU_BUILD_BUG_ON(offsetof(CPUTLBDescFast, mask) != 0);
     QEMU_BUILD_BUG_ON(offsetof(CPUTLBDescFast, table) != 4);
     tcg_out_ldrd_8(s, COND_AL, TCG_REG_R0, TCG_AREG0, fast_off);
-- 
2.41.0


