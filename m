Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 56FB472B4A9
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 00:44:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8Tlk-0000G4-7H; Sun, 11 Jun 2023 18:42:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q8Tlh-0000FD-Tm; Sun, 11 Jun 2023 18:42:41 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q8Tlf-0004gk-6Y; Sun, 11 Jun 2023 18:42:41 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 8F45D748A6A;
 Mon, 12 Jun 2023 00:42:34 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 5B961748A64; Mon, 12 Jun 2023 00:42:34 +0200 (CEST)
Message-Id: <2323bc631817a134319fc1978531160986ecbe13.1686522199.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1686522199.git.balaton@eik.bme.hu>
References: <cover.1686522199.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 04/10] target/ppc: Use env_cpu for cpu_abort in excp_helper
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: clg@kaod.org, Greg Kurz <groug@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Mon, 12 Jun 2023 00:42:34 +0200 (CEST)
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

Use the env_cpu function to get the CPUState for cpu_abort. These are
only needed in case of fatal errors so this allows to avoid casting
and storing CPUState in a local variable wnen not needed.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 target/ppc/excp_helper.c | 118 +++++++++++++++++++++------------------
 1 file changed, 63 insertions(+), 55 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index e4532f5088..51202f7028 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -422,7 +422,6 @@ static void powerpc_checkstop_state(CPUPPCState *env)
 
 static void powerpc_excp_40x(PowerPCCPU *cpu, int excp)
 {
-    CPUState *cs = CPU(cpu);
     CPUPPCState *env = &cpu->env;
     target_ulong msr, new_msr, vector;
     int srr0, srr1;
@@ -450,8 +449,8 @@ static void powerpc_excp_40x(PowerPCCPU *cpu, int excp)
 
     vector = env->excp_vectors[excp];
     if (vector == (target_ulong)-1ULL) {
-        cpu_abort(cs, "Raised an exception without defined vector %d\n",
-                  excp);
+        cpu_abort(env_cpu(env),
+                  "Raised an exception without defined vector %d\n", excp);
     }
 
     vector |= env->excp_prefix;
@@ -500,7 +499,7 @@ static void powerpc_excp_40x(PowerPCCPU *cpu, int excp)
             env->spr[SPR_40x_ESR] = ESR_PTR;
             break;
         default:
-            cpu_abort(cs, "Invalid program exception %d. Aborting\n",
+            cpu_abort(env_cpu(env), "Invalid program exception %d. Aborting\n",
                       env->error_code);
             break;
         }
@@ -527,11 +526,12 @@ static void powerpc_excp_40x(PowerPCCPU *cpu, int excp)
         trace_ppc_excp_print("PIT");
         break;
     case POWERPC_EXCP_DEBUG:     /* Debug interrupt                          */
-        cpu_abort(cs, "%s exception not implemented\n",
+        cpu_abort(env_cpu(env), "%s exception not implemented\n",
                   powerpc_excp_name(excp));
         break;
     default:
-        cpu_abort(cs, "Invalid PowerPC exception %d. Aborting\n", excp);
+        cpu_abort(env_cpu(env), "Invalid PowerPC exception %d. Aborting\n",
+                  excp);
         break;
     }
 
@@ -546,7 +546,6 @@ static void powerpc_excp_40x(PowerPCCPU *cpu, int excp)
 
 static void powerpc_excp_6xx(PowerPCCPU *cpu, int excp)
 {
-    CPUState *cs = CPU(cpu);
     CPUPPCState *env = &cpu->env;
     target_ulong msr, new_msr, vector;
 
@@ -569,8 +568,8 @@ static void powerpc_excp_6xx(PowerPCCPU *cpu, int excp)
 
     vector = env->excp_vectors[excp];
     if (vector == (target_ulong)-1ULL) {
-        cpu_abort(cs, "Raised an exception without defined vector %d\n",
-                  excp);
+        cpu_abort(env_cpu(env),
+                  "Raised an exception without defined vector %d\n", excp);
     }
 
     vector |= env->excp_prefix;
@@ -630,7 +629,7 @@ static void powerpc_excp_6xx(PowerPCCPU *cpu, int excp)
             break;
         default:
             /* Should never occur */
-            cpu_abort(cs, "Invalid program exception %d. Aborting\n",
+            cpu_abort(env_cpu(env), "Invalid program exception %d. Aborting\n",
                       env->error_code);
             break;
         }
@@ -652,8 +651,9 @@ static void powerpc_excp_6xx(PowerPCCPU *cpu, int excp)
         break;
     case POWERPC_EXCP_RESET:     /* System reset exception                   */
         if (FIELD_EX64(env->msr, MSR, POW)) {
-            cpu_abort(cs, "Trying to deliver power-saving system reset "
-                      "exception %d with no HV support\n", excp);
+            cpu_abort(env_cpu(env),
+                      "Trying to deliver power-saving system reset exception "
+                      "%d with no HV support\n", excp);
         }
         break;
     case POWERPC_EXCP_TRACE:     /* Trace exception                          */
@@ -680,11 +680,12 @@ static void powerpc_excp_6xx(PowerPCCPU *cpu, int excp)
     case POWERPC_EXCP_SMI:       /* System management interrupt              */
     case POWERPC_EXCP_MEXTBR:    /* Maskable external breakpoint             */
     case POWERPC_EXCP_NMEXTBR:   /* Non maskable external breakpoint         */
-        cpu_abort(cs, "%s exception not implemented\n",
+        cpu_abort(env_cpu(env), "%s exception not implemented\n",
                   powerpc_excp_name(excp));
         break;
     default:
-        cpu_abort(cs, "Invalid PowerPC exception %d. Aborting\n", excp);
+        cpu_abort(env_cpu(env), "Invalid PowerPC exception %d. Aborting\n",
+                  excp);
         break;
     }
 
@@ -707,7 +708,6 @@ static void powerpc_excp_6xx(PowerPCCPU *cpu, int excp)
 
 static void powerpc_excp_7xx(PowerPCCPU *cpu, int excp)
 {
-    CPUState *cs = CPU(cpu);
     CPUPPCState *env = &cpu->env;
     target_ulong msr, new_msr, vector;
 
@@ -730,8 +730,8 @@ static void powerpc_excp_7xx(PowerPCCPU *cpu, int excp)
 
     vector = env->excp_vectors[excp];
     if (vector == (target_ulong)-1ULL) {
-        cpu_abort(cs, "Raised an exception without defined vector %d\n",
-                  excp);
+        cpu_abort(env_cpu(env),
+                  "Raised an exception without defined vector %d\n", excp);
     }
 
     vector |= env->excp_prefix;
@@ -789,7 +789,7 @@ static void powerpc_excp_7xx(PowerPCCPU *cpu, int excp)
             break;
         default:
             /* Should never occur */
-            cpu_abort(cs, "Invalid program exception %d. Aborting\n",
+            cpu_abort(env_cpu(env), "Invalid program exception %d. Aborting\n",
                       env->error_code);
             break;
         }
@@ -830,8 +830,9 @@ static void powerpc_excp_7xx(PowerPCCPU *cpu, int excp)
         break;
     case POWERPC_EXCP_RESET:     /* System reset exception                   */
         if (FIELD_EX64(env->msr, MSR, POW)) {
-            cpu_abort(cs, "Trying to deliver power-saving system reset "
-                      "exception %d with no HV support\n", excp);
+            cpu_abort(env_cpu(env),
+                      "Trying to deliver power-saving system reset exception "
+                      "%d with no HV support\n", excp);
         }
         break;
     case POWERPC_EXCP_TRACE:     /* Trace exception                          */
@@ -851,11 +852,12 @@ static void powerpc_excp_7xx(PowerPCCPU *cpu, int excp)
     case POWERPC_EXCP_SMI:       /* System management interrupt              */
     case POWERPC_EXCP_THERM:     /* Thermal interrupt                        */
     case POWERPC_EXCP_PERFM:     /* Embedded performance monitor interrupt   */
-        cpu_abort(cs, "%s exception not implemented\n",
+        cpu_abort(env_cpu(env), "%s exception not implemented\n",
                   powerpc_excp_name(excp));
         break;
     default:
-        cpu_abort(cs, "Invalid PowerPC exception %d. Aborting\n", excp);
+        cpu_abort(env_cpu(env), "Invalid PowerPC exception %d. Aborting\n",
+                  excp);
         break;
     }
 
@@ -878,7 +880,6 @@ static void powerpc_excp_7xx(PowerPCCPU *cpu, int excp)
 
 static void powerpc_excp_74xx(PowerPCCPU *cpu, int excp)
 {
-    CPUState *cs = CPU(cpu);
     CPUPPCState *env = &cpu->env;
     target_ulong msr, new_msr, vector;
 
@@ -901,8 +902,8 @@ static void powerpc_excp_74xx(PowerPCCPU *cpu, int excp)
 
     vector = env->excp_vectors[excp];
     if (vector == (target_ulong)-1ULL) {
-        cpu_abort(cs, "Raised an exception without defined vector %d\n",
-                  excp);
+        cpu_abort(env_cpu(env),
+                  "Raised an exception without defined vector %d\n", excp);
     }
 
     vector |= env->excp_prefix;
@@ -960,7 +961,7 @@ static void powerpc_excp_74xx(PowerPCCPU *cpu, int excp)
             break;
         default:
             /* Should never occur */
-            cpu_abort(cs, "Invalid program exception %d. Aborting\n",
+            cpu_abort(env_cpu(env), "Invalid program exception %d. Aborting\n",
                       env->error_code);
             break;
         }
@@ -1001,7 +1002,8 @@ static void powerpc_excp_74xx(PowerPCCPU *cpu, int excp)
         break;
     case POWERPC_EXCP_RESET:     /* System reset exception                   */
         if (FIELD_EX64(env->msr, MSR, POW)) {
-            cpu_abort(cs, "Trying to deliver power-saving system reset "
+            cpu_abort(env_cpu(env),
+                      "Trying to deliver power-saving system reset "
                       "exception %d with no HV support\n", excp);
         }
         break;
@@ -1014,11 +1016,12 @@ static void powerpc_excp_74xx(PowerPCCPU *cpu, int excp)
     case POWERPC_EXCP_THERM:     /* Thermal interrupt                        */
     case POWERPC_EXCP_PERFM:     /* Embedded performance monitor interrupt   */
     case POWERPC_EXCP_VPUA:      /* Vector assist exception                  */
-        cpu_abort(cs, "%s exception not implemented\n",
+        cpu_abort(env_cpu(env), "%s exception not implemented\n",
                   powerpc_excp_name(excp));
         break;
     default:
-        cpu_abort(cs, "Invalid PowerPC exception %d. Aborting\n", excp);
+        cpu_abort(env_cpu(env), "Invalid PowerPC exception %d. Aborting\n",
+                  excp);
         break;
     }
 
@@ -1041,7 +1044,6 @@ static void powerpc_excp_74xx(PowerPCCPU *cpu, int excp)
 
 static void powerpc_excp_booke(PowerPCCPU *cpu, int excp)
 {
-    CPUState *cs = CPU(cpu);
     CPUPPCState *env = &cpu->env;
     target_ulong msr, new_msr, vector;
     int srr0, srr1;
@@ -1078,8 +1080,8 @@ static void powerpc_excp_booke(PowerPCCPU *cpu, int excp)
 
     vector = env->excp_vectors[excp];
     if (vector == (target_ulong)-1ULL) {
-        cpu_abort(cs, "Raised an exception without defined vector %d\n",
-                  excp);
+        cpu_abort(env_cpu(env),
+                  "Raised an exception without defined vector %d\n", excp);
     }
 
     vector |= env->excp_prefix;
@@ -1110,6 +1112,7 @@ static void powerpc_excp_booke(PowerPCCPU *cpu, int excp)
         break;
     case POWERPC_EXCP_EXTERNAL:  /* External input                           */
         if (env->mpic_proxy) {
+            CPUState *cs = env_cpu(env);
             /* IACK the IRQ on delivery */
             env->spr[SPR_BOOKE_EPR] = ldl_phys(cs->as, env->mpic_iack);
         }
@@ -1148,7 +1151,7 @@ static void powerpc_excp_booke(PowerPCCPU *cpu, int excp)
             break;
         default:
             /* Should never occur */
-            cpu_abort(cs, "Invalid program exception %d. Aborting\n",
+            cpu_abort(env_cpu(env), "Invalid program exception %d. Aborting\n",
                       env->error_code);
             break;
         }
@@ -1189,7 +1192,8 @@ static void powerpc_excp_booke(PowerPCCPU *cpu, int excp)
 
             /* DBSR already modified by caller */
         } else {
-            cpu_abort(cs, "Debug exception triggered on unsupported model\n");
+            cpu_abort(env_cpu(env),
+                      "Debug exception triggered on unsupported model\n");
         }
         break;
     case POWERPC_EXCP_SPEU:   /* SPE/embedded floating-point unavailable/VPU  */
@@ -1203,17 +1207,19 @@ static void powerpc_excp_booke(PowerPCCPU *cpu, int excp)
         break;
     case POWERPC_EXCP_RESET:     /* System reset exception                   */
         if (FIELD_EX64(env->msr, MSR, POW)) {
-            cpu_abort(cs, "Trying to deliver power-saving system reset "
+            cpu_abort(env_cpu(env),
+                      "Trying to deliver power-saving system reset "
                       "exception %d with no HV support\n", excp);
         }
         break;
     case POWERPC_EXCP_EFPDI:     /* Embedded floating-point data interrupt   */
     case POWERPC_EXCP_EFPRI:     /* Embedded floating-point round interrupt  */
-        cpu_abort(cs, "%s exception not implemented\n",
+        cpu_abort(env_cpu(env), "%s exception not implemented\n",
                   powerpc_excp_name(excp));
         break;
     default:
-        cpu_abort(cs, "Invalid PowerPC exception %d. Aborting\n", excp);
+        cpu_abort(env_cpu(env), "Invalid PowerPC exception %d. Aborting\n",
+                  excp);
         break;
     }
 
@@ -1276,7 +1282,6 @@ static bool books_vhyp_handles_hv_excp(PowerPCCPU *cpu)
 
 static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
 {
-    CPUState *cs = CPU(cpu);
     CPUPPCState *env = &cpu->env;
     target_ulong msr, new_msr, vector;
     int srr0, srr1, lev = -1;
@@ -1315,8 +1320,8 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
 
     vector = env->excp_vectors[excp];
     if (vector == (target_ulong)-1ULL) {
-        cpu_abort(cs, "Raised an exception without defined vector %d\n",
-                  excp);
+        cpu_abort(env_cpu(env),
+                  "Raised an exception without defined vector %d\n", excp);
     }
 
     vector |= env->excp_prefix;
@@ -1406,7 +1411,7 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
             break;
         default:
             /* Should never occur */
-            cpu_abort(cs, "Invalid program exception %d. Aborting\n",
+            cpu_abort(env_cpu(env), "Invalid program exception %d. Aborting\n",
                       env->error_code);
             break;
         }
@@ -1467,7 +1472,8 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
             new_msr |= (target_ulong)MSR_HVB;
         } else {
             if (FIELD_EX64(env->msr, MSR, POW)) {
-                cpu_abort(cs, "Trying to deliver power-saving system reset "
+                cpu_abort(env_cpu(env),
+                          "Trying to deliver power-saving system reset "
                           "exception %d with no HV support\n", excp);
             }
         }
@@ -1522,11 +1528,12 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
     case POWERPC_EXCP_VPUA:      /* Vector assist exception                  */
     case POWERPC_EXCP_MAINT:     /* Maintenance exception                    */
     case POWERPC_EXCP_HV_MAINT:  /* Hypervisor Maintenance exception         */
-        cpu_abort(cs, "%s exception not implemented\n",
+        cpu_abort(env_cpu(env), "%s exception not implemented\n",
                   powerpc_excp_name(excp));
         break;
     default:
-        cpu_abort(cs, "Invalid PowerPC exception %d. Aborting\n", excp);
+        cpu_abort(env_cpu(env), "Invalid PowerPC exception %d. Aborting\n",
+                  excp);
         break;
     }
 
@@ -1559,8 +1566,8 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
     } else {
         /* Sanity check */
         if (!(env->msr_mask & MSR_HVB) && srr0 == SPR_HSRR0) {
-            cpu_abort(cs, "Trying to deliver HV exception (HSRR) %d with "
-                      "no HV support\n", excp);
+            cpu_abort(env_cpu(env), "Trying to deliver HV exception (HSRR) %d "
+                      "with no HV support\n", excp);
         }
 
         /* This can update new_msr and vector if AIL applies */
@@ -1578,11 +1585,11 @@ static inline void powerpc_excp_books(PowerPCCPU *cpu, int excp)
 
 static void powerpc_excp(PowerPCCPU *cpu, int excp)
 {
-    CPUState *cs = CPU(cpu);
     CPUPPCState *env = &cpu->env;
 
     if (excp <= POWERPC_EXCP_NONE || excp >= POWERPC_EXCP_NB) {
-        cpu_abort(cs, "Invalid PowerPC exception %d. Aborting\n", excp);
+        cpu_abort(env_cpu(env), "Invalid PowerPC exception %d. Aborting\n",
+                  excp);
     }
 
     qemu_log_mask(CPU_LOG_INT, "Raise exception at " TARGET_FMT_lx
@@ -2116,7 +2123,6 @@ void ppc_maybe_interrupt(CPUPPCState *env)
 static void p7_deliver_interrupt(CPUPPCState *env, int interrupt)
 {
     PowerPCCPU *cpu = env_archcpu(env);
-    CPUState *cs = env_cpu(env);
 
     switch (interrupt) {
     case PPC_INTERRUPT_MCK: /* Machine check exception */
@@ -2160,14 +2166,14 @@ static void p7_deliver_interrupt(CPUPPCState *env, int interrupt)
         assert(!env->resume_as_sreset);
         break;
     default:
-        cpu_abort(cs, "Invalid PowerPC interrupt %d. Aborting\n", interrupt);
+        cpu_abort(env_cpu(env), "Invalid PowerPC interrupt %d. Aborting\n",
+                  interrupt);
     }
 }
 
 static void p8_deliver_interrupt(CPUPPCState *env, int interrupt)
 {
     PowerPCCPU *cpu = env_archcpu(env);
-    CPUState *cs = env_cpu(env);
 
     switch (interrupt) {
     case PPC_INTERRUPT_MCK: /* Machine check exception */
@@ -2231,7 +2237,8 @@ static void p8_deliver_interrupt(CPUPPCState *env, int interrupt)
         assert(!env->resume_as_sreset);
         break;
     default:
-        cpu_abort(cs, "Invalid PowerPC interrupt %d. Aborting\n", interrupt);
+        cpu_abort(env_cpu(env), "Invalid PowerPC interrupt %d. Aborting\n",
+                  interrupt);
     }
 }
 
@@ -2310,7 +2317,8 @@ static void p9_deliver_interrupt(CPUPPCState *env, int interrupt)
         assert(!env->resume_as_sreset);
         break;
     default:
-        cpu_abort(cs, "Invalid PowerPC interrupt %d. Aborting\n", interrupt);
+        cpu_abort(env_cpu(env), "Invalid PowerPC interrupt %d. Aborting\n",
+                  interrupt);
     }
 }
 #endif
@@ -2318,7 +2326,6 @@ static void p9_deliver_interrupt(CPUPPCState *env, int interrupt)
 static void ppc_deliver_interrupt_generic(CPUPPCState *env, int interrupt)
 {
     PowerPCCPU *cpu = env_archcpu(env);
-    CPUState *cs = env_cpu(env);
 
     switch (interrupt) {
     case PPC_INTERRUPT_RESET: /* External reset */
@@ -2415,7 +2422,8 @@ static void ppc_deliver_interrupt_generic(CPUPPCState *env, int interrupt)
         assert(!env->resume_as_sreset);
         break;
     default:
-        cpu_abort(cs, "Invalid PowerPC interrupt %d. Aborting\n", interrupt);
+        cpu_abort(env_cpu(env), "Invalid PowerPC interrupt %d. Aborting\n",
+                  interrupt);
     }
 }
 
-- 
2.30.9


