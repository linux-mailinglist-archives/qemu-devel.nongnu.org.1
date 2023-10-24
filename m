Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F23A97D569A
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 17:35:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvJQw-0007sO-HO; Tue, 24 Oct 2023 11:35:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qvJQD-0006RA-Vw; Tue, 24 Oct 2023 11:34:22 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qvJQ8-0005lK-Lk; Tue, 24 Oct 2023 11:34:21 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id ED0B6757233;
 Tue, 24 Oct 2023 17:34:06 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id C7DD1757202; Tue, 24 Oct 2023 17:34:06 +0200 (CEST)
Message-Id: <c929b3a123b4746e8f22ec9defd362f2202b9bfd.1698158152.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1698158152.git.balaton@eik.bme.hu>
References: <cover.1698158152.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v4 5/8] target/ppc: Simplify syscall exception handlers
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: clg@kaod.org, Greg Kurz <groug@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>
Date: Tue, 24 Oct 2023 17:34:06 +0200 (CEST)
X-Spam-Probability: 8%
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

After previous changes the hypercall handling in 7xx and 74xx
exception handlers can be folded into one if statement to simpilfy
this code. Also add "unlikely" to mark the less freqiently used branch
for the compiler.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 target/ppc/excp_helper.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index dd08efe4f2..d073c35989 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -762,26 +762,22 @@ static void powerpc_excp_7xx(PowerPCCPU *cpu, int excp)
     case POWERPC_EXCP_SYSCALL:   /* System call exception                    */
     {
         int lev = env->error_code;
-
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
+        if (unlikely(lev == 1 && cpu->vhyp)) {
             PPCVirtualHypervisorClass *vhc =
                 PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
+            dump_hcall(env);
             vhc->hypercall(cpu->vhyp, cpu);
             powerpc_reset_excp_state(cpu);
             return;
+        } else {
+            dump_syscall(env);
         }
-
         break;
     }
     case POWERPC_EXCP_FPU:       /* Floating-point unavailable exception     */
@@ -907,26 +903,22 @@ static void powerpc_excp_74xx(PowerPCCPU *cpu, int excp)
     case POWERPC_EXCP_SYSCALL:   /* System call exception                    */
     {
         int lev = env->error_code;
-
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
+        if (unlikely(lev == 1 && cpu->vhyp)) {
             PPCVirtualHypervisorClass *vhc =
                 PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
+            dump_hcall(env);
             vhc->hypercall(cpu->vhyp, cpu);
             powerpc_reset_excp_state(cpu);
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


