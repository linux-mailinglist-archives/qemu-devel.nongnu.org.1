Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 667A67309E4
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 23:36:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9Y8f-00054a-9j; Wed, 14 Jun 2023 17:34:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q9Y8E-0004hF-IM; Wed, 14 Jun 2023 17:34:22 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q9Y8C-0003oq-QE; Wed, 14 Jun 2023 17:34:22 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 68AFC748A5F;
 Wed, 14 Jun 2023 23:34:14 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 3506F748A4D; Wed, 14 Jun 2023 23:34:14 +0200 (CEST)
Message-Id: <ee7c07146e8e2e5a3d1d52aaf5a4eeef695c359d.1686776990.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1686776990.git.balaton@eik.bme.hu>
References: <cover.1686776990.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v2 09/10] target/ppc: Simplify syscall exception handlers
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: clg@kaod.org, Greg Kurz <groug@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>
Date: Wed, 14 Jun 2023 23:34:14 +0200 (CEST)
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

After previous changes the hypercall handling in 7xx and 74xx
exception handlers can be folded into one if statement to simpilfy
this code.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 target/ppc/excp_helper.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 1682b988ba..662457f342 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -740,26 +740,23 @@ static void powerpc_excp_7xx(PowerPCCPU *cpu, int excp)
         break;
     case POWERPC_EXCP_SYSCALL:   /* System call exception                    */
     {
-        int lev = env->error_code;
+        PowerPCCPU *cpu = env_archcpu(env);
 
-        if (lev == 1 && cpu->vhyp) {
-            dump_hcall(env);
-        } else {
-            dump_syscall(env);
-        }
         /*
          * The Virtual Open Firmware (VOF) relies on the 'sc 1'
          * instruction to communicate with QEMU. The pegasos2 machine
          * uses VOF and the 7xx CPUs, so although the 7xx don't have
          * HV mode, we need to keep hypercall support.
          */
-        if (lev == 1 && cpu->vhyp) {
+        if (unlikely(env->error_code == 1 && cpu->vhyp)) {
             PPCVirtualHypervisorClass *vhc =
                 PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
+            dump_hcall(env);
             vhc->hypercall(cpu->vhyp, cpu);
             return;
+        } else {
+            dump_syscall(env);
         }
-
         break;
     }
     case POWERPC_EXCP_FPU:       /* Floating-point unavailable exception     */
@@ -884,26 +881,23 @@ static void powerpc_excp_74xx(PowerPCCPU *cpu, int excp)
         break;
     case POWERPC_EXCP_SYSCALL:   /* System call exception                    */
     {
-        int lev = env->error_code;
+        PowerPCCPU *cpu = env_archcpu(env);
 
-        if (lev == 1 && cpu->vhyp) {
-            dump_hcall(env);
-        } else {
-            dump_syscall(env);
-        }
         /*
          * The Virtual Open Firmware (VOF) relies on the 'sc 1'
          * instruction to communicate with QEMU. The pegasos2 machine
          * uses VOF and the 74xx CPUs, so although the 74xx don't have
          * HV mode, we need to keep hypercall support.
          */
-        if (lev == 1 && cpu->vhyp) {
+        if (unlikely(env->error_code == 1 && cpu->vhyp)) {
             PPCVirtualHypervisorClass *vhc =
                 PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
+            dump_hcall(env);
             vhc->hypercall(cpu->vhyp, cpu);
             return;
+        } else {
+            dump_syscall(env);
         }
-
         break;
     }
     case POWERPC_EXCP_FPU:       /* Floating-point unavailable exception     */
-- 
2.30.9


