Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A09A38C07C9
	for <lists+qemu-devel@lfdr.de>; Thu,  9 May 2024 01:39:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4qpl-0003P8-Gu; Wed, 08 May 2024 19:36:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s4qph-0003KN-Ha; Wed, 08 May 2024 19:36:21 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s4qpf-0002YC-Th; Wed, 08 May 2024 19:36:21 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 59DAA4E65D5;
 Thu, 09 May 2024 01:36:18 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id 0r19Wr9HeXmT; Thu,  9 May 2024 01:36:16 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 683DE4E65CE; Thu, 09 May 2024 01:36:16 +0200 (CEST)
Message-Id: <46f3158e778f43346dd9203bb618aea06bcffa64.1715209155.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1715209155.git.balaton@eik.bme.hu>
References: <cover.1715209155.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v4 13/33] target/ppc/mmu_common.c: Split out BookE cases
 before checking real mode
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Thu, 09 May 2024 01:36:16 +0200 (CEST)
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

BookE does not have real mode so split off and handle it first in
get_physical_address_wtlb() before checking for real mode for other
MMU models.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/mmu_common.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index 03d9e6bfda..9f177b6976 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -1175,6 +1175,13 @@ int get_physical_address_wtlb(CPUPPCState *env, mmu_ctx_t *ctx,
     int ret = -1;
     bool real_mode;
 
+    if (env->mmu_model == POWERPC_MMU_BOOKE) {
+        return mmubooke_get_physical_address(env, ctx, eaddr, access_type);
+    } else if (env->mmu_model == POWERPC_MMU_BOOKE206) {
+        return mmubooke206_get_physical_address(env, ctx, eaddr, access_type,
+                                                mmu_idx);
+    }
+
     real_mode = (type == ACCESS_CODE) ? !FIELD_EX64(env->msr, MSR, IR)
                                       : !FIELD_EX64(env->msr, MSR, DR);
 
@@ -1195,13 +1202,6 @@ int get_physical_address_wtlb(CPUPPCState *env, mmu_ctx_t *ctx,
             ret = mmu40x_get_physical_address(env, ctx, eaddr, access_type);
         }
         break;
-    case POWERPC_MMU_BOOKE:
-        ret = mmubooke_get_physical_address(env, ctx, eaddr, access_type);
-        break;
-    case POWERPC_MMU_BOOKE206:
-        ret = mmubooke206_get_physical_address(env, ctx, eaddr, access_type,
-                                               mmu_idx);
-        break;
     case POWERPC_MMU_REAL:
         if (real_mode) {
             ret = check_physical(env, ctx, eaddr, access_type);
-- 
2.30.9


