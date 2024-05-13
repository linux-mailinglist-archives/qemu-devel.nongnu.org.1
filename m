Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AF53E8C3959
	for <lists+qemu-devel@lfdr.de>; Mon, 13 May 2024 01:35:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6Ibk-0001Ab-JE; Sun, 12 May 2024 19:27:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s6Ibh-00017V-Te; Sun, 12 May 2024 19:27:53 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s6Ibg-0000JM-DZ; Sun, 12 May 2024 19:27:53 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 0BB854E6776;
 Mon, 13 May 2024 01:27:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id H4V6rgFTuIyJ; Mon, 13 May 2024 01:27:49 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 1B9214E6765; Mon, 13 May 2024 01:27:49 +0200 (CEST)
Message-Id: <a449ebb07db382b08e551f913d881fda10e9415b.1715555763.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1715555763.git.balaton@eik.bme.hu>
References: <cover.1715555763.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v7 16/61] target/ppc/mmu_common.c: Replace hard coded
 constants in ppc_jumbo_xlate()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Mon, 13 May 2024 01:27:49 +0200 (CEST)
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

The "2" in booke206_update_mas_tlb_miss() call corresponds to
MMU_INST_FETCH which is the value of access_type in this branch;
mmubooke206_esr() only checks for MMU_DATA_STORE and it's called from
code access so using MMU_DATA_LOAD here seems wrong so replace it with
access_type here as well that yields the same result. This also makes
these calls the same as the data access branch further down.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/mmu_common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index f40481b4b1..6570b280ca 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -1287,13 +1287,13 @@ static bool ppc_jumbo_xlate(PowerPCCPU *cpu, vaddr eaddr,
                 env->spr[SPR_40x_ESR] = 0x00000000;
                 break;
             case POWERPC_MMU_BOOKE206:
-                booke206_update_mas_tlb_miss(env, eaddr, 2, mmu_idx);
+                booke206_update_mas_tlb_miss(env, eaddr, access_type, mmu_idx);
                 /* fall through */
             case POWERPC_MMU_BOOKE:
                 cs->exception_index = POWERPC_EXCP_ITLB;
                 env->error_code = 0;
                 env->spr[SPR_BOOKE_DEAR] = eaddr;
-                env->spr[SPR_BOOKE_ESR] = mmubooke206_esr(mmu_idx, MMU_DATA_LOAD);
+                env->spr[SPR_BOOKE_ESR] = mmubooke206_esr(mmu_idx, access_type);
                 break;
             case POWERPC_MMU_REAL:
                 cpu_abort(cs, "PowerPC in real mode should never raise "
-- 
2.30.9


