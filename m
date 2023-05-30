Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 00BE17161ED
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 15:31:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3zOy-0001sU-49; Tue, 30 May 2023 09:28:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q3zOY-00015H-W0; Tue, 30 May 2023 09:28:16 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q3zOU-0002Ai-VO; Tue, 30 May 2023 09:28:14 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 5F062746E5A;
 Tue, 30 May 2023 15:28:07 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 43A64746335; Tue, 30 May 2023 15:28:07 +0200 (CEST)
Message-Id: <302697d63d26caebefaeee1e45352145ebd0318a.1685448535.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1685448535.git.balaton@eik.bme.hu>
References: <cover.1685448535.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 1/7] target/ppc: Remove single use function
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: clg@kaod.org, Greg Kurz <groug@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Tue, 30 May 2023 15:28:07 +0200 (CEST)
X-Spam-Probability: 8%
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The get_physical_address() function is a trivial wrapper of
get_physical_address_wtlb() that is only used once. Remove it and call
get_physical_address_wtlb() directly instead.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 target/ppc/mmu_helper.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/target/ppc/mmu_helper.c b/target/ppc/mmu_helper.c
index 64e30435f5..c0c71a68ff 100644
--- a/target/ppc/mmu_helper.c
+++ b/target/ppc/mmu_helper.c
@@ -168,15 +168,6 @@ static void booke206_flush_tlb(CPUPPCState *env, int flags,
     tlb_flush(env_cpu(env));
 }
 
-static int get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
-                                target_ulong eaddr, MMUAccessType access_type,
-                                int type)
-{
-    return get_physical_address_wtlb(env, ctx, eaddr, access_type, type, 0);
-}
-
-
-
 /*****************************************************************************/
 /* BATs management */
 #if !defined(FLUSH_ALL_TLBS)
@@ -643,7 +634,7 @@ target_ulong helper_rac(CPUPPCState *env, target_ulong addr)
      */
     nb_BATs = env->nb_BATs;
     env->nb_BATs = 0;
-    if (get_physical_address(env, &ctx, addr, 0, ACCESS_INT) == 0) {
+    if (get_physical_address_wtlb(env, &ctx, addr, 0, ACCESS_INT, 0) == 0) {
         ret = ctx.raddr;
     }
     env->nb_BATs = nb_BATs;
-- 
2.30.9


