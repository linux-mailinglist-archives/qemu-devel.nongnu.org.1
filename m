Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B2808732308
	for <lists+qemu-devel@lfdr.de>; Fri, 16 Jun 2023 01:06:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9w00-0002QD-A6; Thu, 15 Jun 2023 19:03:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q9vzw-0002EB-86; Thu, 15 Jun 2023 19:03:24 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q9vzt-0007iM-RT; Thu, 15 Jun 2023 19:03:23 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id E00F4748A5F;
 Fri, 16 Jun 2023 01:03:14 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id C5841748A56; Fri, 16 Jun 2023 01:03:14 +0200 (CEST)
Message-Id: <aa34e449552c6ab52d48938ccbe762fc06adac01.1686868895.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1686868895.git.balaton@eik.bme.hu>
References: <cover.1686868895.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v3 05/14] target/ppc: Remove some more local CPUState
 variables only used once
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: clg@kaod.org, Greg Kurz <groug@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>
Date: Fri, 16 Jun 2023 01:03:14 +0200 (CEST)
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

Some helpers only have a CPUState local to call cpu_interrupt_exittb()
but we can use env_cpu for that and remove the local.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 target/ppc/excp_helper.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 122e2a6e41..a175865fa9 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -2551,8 +2551,7 @@ void helper_store_msr(CPUPPCState *env, target_ulong val)
     uint32_t excp = hreg_store_msr(env, val, 0);
 
     if (excp != 0) {
-        CPUState *cs = env_cpu(env);
-        cpu_interrupt_exittb(cs);
+        cpu_interrupt_exittb(env_cpu(env));
         raise_exception(env, excp);
     }
 }
@@ -2589,8 +2588,6 @@ void helper_pminsn(CPUPPCState *env, uint32_t insn)
 
 static void do_rfi(CPUPPCState *env, target_ulong nip, target_ulong msr)
 {
-    CPUState *cs = env_cpu(env);
-
     /* MSR:POW cannot be set by any form of rfi */
     msr &= ~(1ULL << MSR_POW);
 
@@ -2614,7 +2611,7 @@ static void do_rfi(CPUPPCState *env, target_ulong nip, target_ulong msr)
      * No need to raise an exception here, as rfi is always the last
      * insn of a TB
      */
-    cpu_interrupt_exittb(cs);
+    cpu_interrupt_exittb(env_cpu(env));
     /* Reset the reservation */
     env->reserve_addr = -1;
 
-- 
2.30.9


