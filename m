Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7292B8AFBCF
	for <lists+qemu-devel@lfdr.de>; Wed, 24 Apr 2024 00:35:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzOfq-0001Ao-5l; Tue, 23 Apr 2024 18:31:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rzOfb-00016v-SG; Tue, 23 Apr 2024 18:31:25 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rzOfY-0004an-6a; Tue, 23 Apr 2024 18:31:23 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id C161D4E6042;
 Wed, 24 Apr 2024 00:31:16 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id wRP8tTGP9yDN; Wed, 24 Apr 2024 00:31:14 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id D45FC4E6031; Wed, 24 Apr 2024 00:31:14 +0200 (CEST)
Message-Id: <70bd4c106a5dd14eacf4b79131741c76accb9ad4.1713907038.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1713907038.git.balaton@eik.bme.hu>
References: <cover.1713907038.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 04/24] target/ppc: Remove unused helper
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Wed, 24 Apr 2024 00:31:14 +0200 (CEST)
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The helper_rac function is defined but not used, remove it.

Fixes: 005b69fdcc (target/ppc: Remove PowerPC 601 CPUs)
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 target/ppc/helper.h     |  2 --
 target/ppc/mmu_helper.c | 24 ------------------------
 2 files changed, 26 deletions(-)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 86f97ee1e7..f769e01c3d 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -700,8 +700,6 @@ DEF_HELPER_2(book3s_msgclr, void, env, tl)
 
 DEF_HELPER_4(dlmzb, tl, env, tl, tl, i32)
 #if !defined(CONFIG_USER_ONLY)
-DEF_HELPER_2(rac, tl, env, tl)
-
 DEF_HELPER_2(load_dcr, tl, env, tl)
 DEF_HELPER_3(store_dcr, void, env, tl, tl)
 #endif
diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
index c071b4d5e2..817836b731 100644
--- a/target/ppc/mmu_helper.c
+++ b/target/ppc/mmu_helper.c
@@ -595,30 +595,6 @@ void helper_6xx_tlbi(CPUPPCState *env, target_ulong EPN)
     do_6xx_tlb(env, EPN, 1);
 }
 
-/*****************************************************************************/
-/* PowerPC 601 specific instructions (POWER bridge) */
-
-target_ulong helper_rac(CPUPPCState *env, target_ulong addr)
-{
-    mmu_ctx_t ctx;
-    int nb_BATs;
-    target_ulong ret = 0;
-
-    /*
-     * We don't have to generate many instances of this instruction,
-     * as rac is supervisor only.
-     *
-     * XXX: FIX THIS: Pretend we have no BAT
-     */
-    nb_BATs = env->nb_BATs;
-    env->nb_BATs = 0;
-    if (get_physical_address_wtlb(env, &ctx, addr, 0, ACCESS_INT, 0) == 0) {
-        ret = ctx.raddr;
-    }
-    env->nb_BATs = nb_BATs;
-    return ret;
-}
-
 static inline target_ulong booke_tlb_to_page_size(int size)
 {
     return 1024 << (2 * size);
-- 
2.30.9


