Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 990977E6B61
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 14:45:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r15Kk-0000uq-TN; Thu, 09 Nov 2023 08:44:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r15Kg-0000aH-OZ; Thu, 09 Nov 2023 08:44:30 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r15Ke-0001FZ-PK; Thu, 09 Nov 2023 08:44:30 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 1F47D31B06;
 Thu,  9 Nov 2023 16:43:12 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 2DDA1344AD;
 Thu,  9 Nov 2023 16:43:04 +0300 (MSK)
Received: (nullmailer pid 1461806 invoked by uid 1000);
 Thu, 09 Nov 2023 13:43:02 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Michal Orzel <michal.orzel@amd.com>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.1.3 15/55] target/arm: Fix CNTPCT_EL0 trapping from EL0
 when HCR_EL2.E2H is 0
Date: Thu,  9 Nov 2023 16:42:19 +0300
Message-Id: <20231109134300.1461632-15-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.1.3-20231109164030@cover.tls.msk.ru>
References: <qemu-stable-8.1.3-20231109164030@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Michal Orzel <michal.orzel@amd.com>

On an attempt to access CNTPCT_EL0 from EL0 using a guest running on top
of Xen, a trap from EL2 was observed which is something not reproducible
on HW (also, Xen does not trap accesses to physical counter).

This is because gt_counter_access() checks for an incorrect bit (1
instead of 0) of CNTHCTL_EL2 if HCR_EL2.E2H is 0 and access is made to
physical counter. Refer ARM ARM DDI 0487J.a, D19.12.2:
When HCR_EL2.E2H is 0:
 - EL1PCTEN, bit [0]: refers to physical counter
 - EL1PCEN, bit [1]: refers to physical timer registers

Drop entire block "if (hcr & HCR_E2H) {...} else {...}" from EL0 case
and fall through to EL1 case, given that after fixing checking for the
correct bit, the handling is the same.

Fixes: 5bc8437136fb ("target/arm: Update timer access for VHE")
Signed-off-by: Michal Orzel <michal.orzel@amd.com>
Tested-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Message-id: 20230928094404.20802-1-michal.orzel@amd.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit d01448c79d89cfdc86228081b1dd1dfaf85fb4c3)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 50f61e42ca..f66b610bdd 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2475,22 +2475,7 @@ static CPAccessResult gt_counter_access(CPUARMState *env, int timeridx,
         if (!extract32(env->cp15.c14_cntkctl, timeridx, 1)) {
             return CP_ACCESS_TRAP;
         }
-
-        /* If HCR_EL2.<E2H,TGE> == '10': check CNTHCTL_EL2.EL1PCTEN. */
-        if (hcr & HCR_E2H) {
-            if (timeridx == GTIMER_PHYS &&
-                !extract32(env->cp15.cnthctl_el2, 10, 1)) {
-                return CP_ACCESS_TRAP_EL2;
-            }
-        } else {
-            /* If HCR_EL2.<E2H> == 0: check CNTHCTL_EL2.EL1PCEN. */
-            if (has_el2 && timeridx == GTIMER_PHYS &&
-                !extract32(env->cp15.cnthctl_el2, 1, 1)) {
-                return CP_ACCESS_TRAP_EL2;
-            }
-        }
-        break;
-
+        /* fall through */
     case 1:
         /* Check CNTHCTL_EL2.EL1PCTEN, which changes location based on E2H. */
         if (has_el2 && timeridx == GTIMER_PHYS &&
-- 
2.39.2


