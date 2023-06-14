Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7523D7309DD
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 23:35:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9Y89-0004Ua-1B; Wed, 14 Jun 2023 17:34:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q9Y86-0004TX-Qe; Wed, 14 Jun 2023 17:34:14 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q9Y85-0003mY-AR; Wed, 14 Jun 2023 17:34:14 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 0FA70746369;
 Wed, 14 Jun 2023 23:34:07 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id E5C7D746335; Wed, 14 Jun 2023 23:34:06 +0200 (CEST)
Message-Id: <f42761401c708fd6e02f7523d9f709b1972e5863.1686776990.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1686776990.git.balaton@eik.bme.hu>
References: <cover.1686776990.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v2 02/10] target/ppc: Remove unneeded parameter from
 powerpc_reset_wakeup()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: clg@kaod.org, Greg Kurz <groug@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>
Date: Wed, 14 Jun 2023 23:34:06 +0200 (CEST)
X-Spam-Probability: 8%
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
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

CPUState is rarely needed by this function (only for logging a fatal
error) and it's easy to get from the env parameter so passing it
separately is not necessary.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Acked-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/excp_helper.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 8298217e78..3783315fdb 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -166,8 +166,7 @@ static void ppc_excp_debug_sw_tlb(CPUPPCState *env, int excp)
 }
 
 #if defined(TARGET_PPC64)
-static int powerpc_reset_wakeup(CPUState *cs, CPUPPCState *env, int excp,
-                                target_ulong *msr)
+static int powerpc_reset_wakeup(CPUPPCState *env, int excp, target_ulong *msr)
 {
     /* We no longer are in a PM state */
     env->resume_as_sreset = false;
@@ -202,8 +201,8 @@ static int powerpc_reset_wakeup(CPUState *cs, CPUPPCState *env, int excp,
         *msr |= SRR1_WAKEHVI;
         break;
     default:
-        cpu_abort(cs, "Unsupported exception %d in Power Save mode\n",
-                  excp);
+        cpu_abort(env_cpu(env),
+                  "Unsupported exception %d in Power Save mode\n", excp);
     }
     return POWERPC_EXCP_RESET;
 }
@@ -1353,7 +1352,7 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
      * P7/P8/P9
      */
     if (env->resume_as_sreset) {
-        excp = powerpc_reset_wakeup(cs, env, excp, &msr);
+        excp = powerpc_reset_wakeup(env, excp, &msr);
     }
 
     /*
-- 
2.30.9


