Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 844B07161FA
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 15:32:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3zP8-00021i-QY; Tue, 30 May 2023 09:28:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q3zOc-0001Ks-F5; Tue, 30 May 2023 09:28:21 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q3zOa-0002Jv-9S; Tue, 30 May 2023 09:28:17 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id C003E748A61;
 Tue, 30 May 2023 15:28:11 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id A0FE3748A4D; Tue, 30 May 2023 15:28:11 +0200 (CEST)
Message-Id: <d470118c3adcbd41b1a91779f6bb7cbdb2b0d346.1685448535.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1685448535.git.balaton@eik.bme.hu>
References: <cover.1685448535.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 5/7] target/ppc: Simplify ppcemb_tlb_search()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: clg@kaod.org, Greg Kurz <groug@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Tue, 30 May 2023 15:28:11 +0200 (CEST)
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

No nead to store return value and break from loop when we can return
directly.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 target/ppc/mmu_common.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
index a84bc7de88..ff7f987546 100644
--- a/target/ppc/mmu_common.c
+++ b/target/ppc/mmu_common.c
@@ -521,19 +521,15 @@ int ppcemb_tlb_search(CPUPPCState *env, target_ulong address, uint32_t pid)
 {
     ppcemb_tlb_t *tlb;
     hwaddr raddr;
-    int i, ret;
+    int i;
 
-    /* Default return value is no match */
-    ret = -1;
     for (i = 0; i < env->nb_tlb; i++) {
         tlb = &env->tlb.tlbe[i];
         if (ppcemb_tlb_check(env, tlb, &raddr, address, pid, i) == 0) {
-            ret = i;
-            break;
+            return i;
         }
     }
-
-    return ret;
+    return -1;
 }
 
 static int mmu40x_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
-- 
2.30.9


