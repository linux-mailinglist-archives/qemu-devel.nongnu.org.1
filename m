Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D677F8C3956
	for <lists+qemu-devel@lfdr.de>; Mon, 13 May 2024 01:34:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6IdB-00030z-C0; Sun, 12 May 2024 19:29:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s6Icd-00020y-Ro; Sun, 12 May 2024 19:28:53 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1s6Icb-0000Qq-4D; Sun, 12 May 2024 19:28:51 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id D7BBC4E6788;
 Mon, 13 May 2024 01:28:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id LAP1qRlM2GJ7; Mon, 13 May 2024 01:28:22 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id E56794E6789; Mon, 13 May 2024 01:28:22 +0200 (CEST)
Message-Id: <4c6b1cb30200ba42ef7afea8b12501eea47f2875.1715555763.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1715555763.git.balaton@eik.bme.hu>
References: <cover.1715555763.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v7 48/61] target/ppc/mmu_common.c: Simplify a switch statement
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Mon, 13 May 2024 01:28:22 +0200 (CEST)
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

In mmu6xx_get_physical_address() the switch handles all cases so the
default is never reached and can be dropped. Also group together cases
which just return -4.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 target/ppc/mmu_common.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index 1a2b4158d5..f38a73464f 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -375,15 +375,6 @@ static int mmu6xx_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
     case ACCESS_INT:
         /* Integer load/store : only access allowed */
         break;
-    case ACCESS_CODE:
-        /* No code fetch is allowed in direct-store areas */
-        return -4;
-    case ACCESS_FLOAT:
-        /* Floating point load/store */
-        return -4;
-    case ACCESS_RES:
-        /* lwarx, ldarx or srwcx. */
-        return -4;
     case ACCESS_CACHE:
         /*
          * dcba, dcbt, dcbtst, dcbf, dcbi, dcbst, dcbz, or icbi
@@ -393,12 +384,10 @@ static int mmu6xx_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
          */
         ctx->raddr = eaddr;
         return 0;
-    case ACCESS_EXT:
-        /* eciwx or ecowx */
-        return -4;
-    default:
-        qemu_log_mask(CPU_LOG_MMU, "ERROR: instruction should not need address"
-                                   " translation\n");
+    case ACCESS_CODE: /* No code fetch is allowed in direct-store areas */
+    case ACCESS_FLOAT: /* Floating point load/store */
+    case ACCESS_RES: /* lwarx, ldarx or srwcx. */
+    case ACCESS_EXT: /* eciwx or ecowx */
         return -4;
     }
     if ((access_type == MMU_DATA_STORE || ctx->key != 1) &&
-- 
2.30.9


