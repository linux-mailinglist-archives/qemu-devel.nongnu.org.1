Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8542C8BF3AA
	for <lists+qemu-devel@lfdr.de>; Wed,  8 May 2024 02:25:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4V0P-00049C-Ul; Tue, 07 May 2024 20:17:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s4Uxk-00076a-RJ; Tue, 07 May 2024 20:15:21 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s4Uxj-0003k1-9z; Tue, 07 May 2024 20:15:12 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id F3B4B4E65CB;
 Wed, 08 May 2024 02:15:07 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id 09a8us5z_zD3; Wed,  8 May 2024 02:15:06 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 122644E65CE; Wed, 08 May 2024 02:15:06 +0200 (CEST)
Message-Id: <744f860c39b6a0090367a4ff874119aa530415e4.1715125376.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1715125376.git.balaton@eik.bme.hu>
References: <cover.1715125376.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v3 13/33] target/ppc/mmu_common.c: Split out BookE cases
 before checking real mode
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Wed, 08 May 2024 02:15:06 +0200 (CEST)
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

BookE does not have real mode so split off and handle it first in
get_physical_address_wtlb() before checking for real mode for other
MMU models.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/mmu_common.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index 2b6252f3f9..5a0df60ebc 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -1178,6 +1178,13 @@ int get_physical_address_wtlb(CPUPPCState *env, mmu_ctx_t *ctx,
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
 
@@ -1198,13 +1205,6 @@ int get_physical_address_wtlb(CPUPPCState *env, mmu_ctx_t *ctx,
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


