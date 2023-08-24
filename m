Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D305787CB2
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 03:04:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZLES-0007WA-IH; Thu, 24 Aug 2023 21:03:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1qZHVf-0002eo-30
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 17:04:55 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1qZHVc-0001fj-UW
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 17:04:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id F23B866BEF;
 Thu, 24 Aug 2023 21:04:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80FA0C433CA;
 Thu, 24 Aug 2023 21:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1692911083;
 bh=j621srJL5S1qolYFP7yJm0kHV3+xYRZ7QQm0gbaERf0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=SLw/gKfTOhLdKLdqQbud2sBMsZPbGVsq4UzcOjMxFleHUhjuP+M15GRcqvtM8t/JV
 ifmhnJ5RftApDnC1VQ0xa3PQyYKGQhq5LMVTMYbNIe2cqFlu2h0w/rqsoV057MNXRe
 Pmc+wJTIbCQGpaibhoVBMrVOD/5VbenET/kgD1OJOYs7cCTeDH0pt8kuWozkK8nSai
 EPbAtsy8gZBFKa/CeZHBY9Bawgp8zLpavpqk4N3iH29Apy+dXJRNm+VE+kJ7faYmQ5
 EZBmajUII/kVJXiFub7vy07YDJQ+Mzp59KHRCl/pNfWW1DhHCEL1z3qSKsEECquh1G
 OCfO4nzBI1xPw==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PATCH 4/5] target/hppa: Use privilege helper in
 hppa_get_physical_address()
Date: Thu, 24 Aug 2023 23:04:33 +0200
Message-ID: <20230824210434.151971-5-deller@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230824210434.151971-1-deller@kernel.org>
References: <20230824210434.151971-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=139.178.84.217; envelope-from=deller@kernel.org;
 helo=dfw.source.kernel.org
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 24 Aug 2023 21:03:17 -0400
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

From: Helge Deller <deller@gmx.de>

Convert hppa_get_physical_address() to use the privilege helper macro.

Signed-off-by: Helge Deller <deller@gmx.de>
---
 target/hppa/mem_helper.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index 6f04c101dd..66cf84a0d9 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -73,7 +73,7 @@ int hppa_get_physical_address(CPUHPPAState *env, vaddr addr, int mmu_idx,
                               int type, hwaddr *pphys, int *pprot)
 {
     hwaddr phys;
-    int prot, r_prot, w_prot, x_prot;
+    int prot, r_prot, w_prot, x_prot, mmu_priv;
     hppa_tlb_entry *ent;
     int ret = -1;
 
@@ -97,9 +97,10 @@ int hppa_get_physical_address(CPUHPPAState *env, vaddr addr, int mmu_idx,
     phys = ent->pa + (addr & ~TARGET_PAGE_MASK);
 
     /* Map TLB access_rights field to QEMU protection.  */
-    r_prot = (mmu_idx <= ent->ar_pl1) * PAGE_READ;
-    w_prot = (mmu_idx <= ent->ar_pl2) * PAGE_WRITE;
-    x_prot = (ent->ar_pl2 <= mmu_idx && mmu_idx <= ent->ar_pl1) * PAGE_EXEC;
+    mmu_priv = MMU_IDX_TO_PRIV(mmu_idx);
+    r_prot = (mmu_priv <= ent->ar_pl1) * PAGE_READ;
+    w_prot = (mmu_priv <= ent->ar_pl2) * PAGE_WRITE;
+    x_prot = (ent->ar_pl2 <= mmu_priv && mmu_priv <= ent->ar_pl1) * PAGE_EXEC;
     switch (ent->ar_type) {
     case 0: /* read-only: data page */
         prot = r_prot;
-- 
2.41.0


