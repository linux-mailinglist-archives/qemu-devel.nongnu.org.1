Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B32098AFBCE
	for <lists+qemu-devel@lfdr.de>; Wed, 24 Apr 2024 00:35:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzOfs-0001Cz-7o; Tue, 23 Apr 2024 18:31:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rzOfh-00017E-BI; Tue, 23 Apr 2024 18:31:29 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rzOff-0004cF-7v; Tue, 23 Apr 2024 18:31:29 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 340CA4E6041;
 Wed, 24 Apr 2024 00:31:25 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id bLvPjQN-Squc; Wed, 24 Apr 2024 00:31:23 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 4A0D24E603E; Wed, 24 Apr 2024 00:31:23 +0200 (CEST)
Message-Id: <e480d376d0eb1164a7af4a169a589682a05898b7.1713907038.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1713907038.git.balaton@eik.bme.hu>
References: <cover.1713907038.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 12/24] target/ppc/mmu_common.c: Inline and remove
 check_physical()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Wed, 24 Apr 2024 00:31:23 +0200 (CEST)
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
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

This function just does two assignments and and unnecessary check that
is always true so inline it in the only caller left and remove it.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 target/ppc/mmu_common.c | 26 +++-----------------------
 1 file changed, 3 insertions(+), 23 deletions(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index fb66468d34..843f909619 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -1166,28 +1166,6 @@ void dump_mmu(CPUPPCState *env)
     }
 }
 
-static int check_physical(CPUPPCState *env, mmu_ctx_t *ctx, target_ulong eaddr,
-                          MMUAccessType access_type)
-{
-    ctx->raddr = eaddr;
-    ctx->prot = PAGE_READ | PAGE_EXEC;
-
-    switch (env->mmu_model) {
-    case POWERPC_MMU_SOFT_6xx:
-    case POWERPC_MMU_SOFT_4xx:
-    case POWERPC_MMU_REAL:
-    case POWERPC_MMU_BOOKE:
-        ctx->prot |= PAGE_WRITE;
-        break;
-
-    default:
-        /* Caller's checks mean we should never get here for other models */
-        g_assert_not_reached();
-    }
-
-    return 0;
-}
-
 int get_physical_address_wtlb(CPUPPCState *env, mmu_ctx_t *ctx,
                                      target_ulong eaddr,
                                      MMUAccessType access_type, int type,
@@ -1207,7 +1185,9 @@ int get_physical_address_wtlb(CPUPPCState *env, mmu_ctx_t *ctx,
     if (real_mode && (env->mmu_model == POWERPC_MMU_SOFT_6xx ||
                       env->mmu_model == POWERPC_MMU_SOFT_4xx ||
                       env->mmu_model == POWERPC_MMU_REAL)) {
-        return check_physical(env, ctx, eaddr, access_type);
+        ctx->raddr = eaddr;
+        ctx->prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
+        return 0;
     }
 
     switch (env->mmu_model) {
-- 
2.30.9


