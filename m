Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5017322FB
	for <lists+qemu-devel@lfdr.de>; Fri, 16 Jun 2023 01:04:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9vzz-0002Nt-Hx; Thu, 15 Jun 2023 19:03:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q9vzw-0002F1-WF; Thu, 15 Jun 2023 19:03:25 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q9vzs-0007iE-Sz; Thu, 15 Jun 2023 19:03:24 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id F3DB5748A5E;
 Fri, 16 Jun 2023 01:03:13 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id BD8BD748A56; Fri, 16 Jun 2023 01:03:13 +0200 (CEST)
Message-Id: <455daa044e616caddb87dec33074f29196a1b560.1686868895.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1686868895.git.balaton@eik.bme.hu>
References: <cover.1686868895.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v3 04/14] target/ppc: Use env_cpu for cpu_abort in excp_helper
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: clg@kaod.org, Greg Kurz <groug@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>
Date: Fri, 16 Jun 2023 01:03:13 +0200 (CEST)
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

Use the env_cpu function to get the CPUState for cpu_abort. These are
only needed in case of fatal errors so this allows to avoid casting
and storing CPUState in a local variable wnen not needed.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 target/ppc/excp_helper.c | 118 +++++++++++++++++++++------------------
 1 file changed, 63 insertions(+), 55 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 79f5ca1034..122e2a6e41 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -424,7 +424,6 @@ static void powerpc_mcheck_checkstop(CPUPPCState *env)
 
 static void powerpc_excp_40x(PowerPCCPU *cpu, int excp)
 {
-    CPUState *cs = CPU(cpu);
     CPUPPCState *env = &cpu->env;
     target_ulong msr, new_msr, vector;
     int srr0, srr1;
@@ -452,8 +451,8 @@ static void powerpc_excp_40x(PowerPCCPU *cpu, int excp)
 
     vector = env->excp_vectors[excp];
     if (vector == (target_ulong)-1ULL) {
-        cpu_abort(cs, "Raised an exception without defined vector %d\n",
-                  excp);
+        cpu_abort(env_cpu(env),
+                  "Raised an exception without defined vector %d\n", excp);
     }
 
     vector |= env->excp_prefix;
@@ -502,7 +501,7 @@ static void powerpc_excp_40x(PowerPCCPU *cpu, int excp)
             env->spr[SPR_40x_ESR] = ESR_PTR;
             break;
         default:
-            cpu_abort(cs, "Invalid program exception %d. Aborting\n",
+            cpu_abort(env_cpu(env), "Invalid program exception %d. Aborting\n",
                       env->error_code);
             break;
         }
@@ -529,11 +528,12 @@ static void powerpc_excp_40x(PowerPCCPU *cpu, int excp)
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
 
@@ -548,7 +548,6 @@ static void powerpc_excp_40x(PowerPCCPU *cpu, int excp)
 
 static void powerpc_excp_6xx(PowerPCCPU *cpu, int excp)
 {
-    CPUState *cs = CPU(cpu);
     CPUPPCState *env = &cpu->env;
     target_ulong msr, new_msr, vector;
 
@@ -571,8 +570,8 @@ static void powerpc_excp_6xx(PowerPCCPU *cpu, int excp)
 
     vector = env->excp_vectors[excp];
     if (vector == (target_ulong)-1ULL) {
-        cpu_abort(cs, "Raised an exception without defined vector %d\n",
-                  excp);
+        cpu_abort(env_cpu(env),
+                  "Raised an exception without defined vector %d\n", excp);
     }
 
     vector |= env->excp_prefix;
@@ -632,7 +631,7 @@ static void powerpc_excp_6xx(PowerPCCPU *cpu, int excp)
             break;
         default:
             /* Should never occur */
-            cpu_abort(cs, "Invalid program exception %d. Aborting\n",
+            cpu_abort(env_cpu(env), "Invalid program exception %d. Aborting\n",
                       env->error_code);
             break;
         }
@@ -654,8 +653,9 @@ static void powerpc_excp_6xx(PowerPCCPU *cpu, int excp)
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
@@ -682,11 +682,12 @@ static void powerpc_excp_6xx(PowerPCCPU *cpu, int excp)
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
 
@@ -709,7 +710,6 @@ static void powerpc_excp_6xx(PowerPCCPU *cpu, int excp)
 
 static void powerpc_excp_7xx(PowerPCCPU *cpu, int excp)
 {
-    CPUState *cs = CPU(cpu);
     CPUPPCState *env = &cpu->env;
     target_ulong msr, new_msr, vector;
 
@@ -732,8 +732,8 @@ static void powerpc_excp_7xx(PowerPCCPU *cpu, int excp)
 
     vector = env->excp_vectors[excp];
     if (vector == (target_ulong)-1ULL) {
-        cpu_abort(cs, "Raised an exception without defined vector %d\n",
-                  excp);
+        cpu_abort(env_cpu(env),
+                  "Raised an exception without defined vector %d\n", excp);
     }
 
     vector |= env->excp_prefix;
@@ -791,7 +791,7 @@ static void powerpc_excp_7xx(PowerPCCPU *cpu, int excp)
             break;
         default:
             /* Should never occur */
-            cpu_abort(cs, "Invalid program exception %d. Aborting\n",
+            cpu_abort(env_cpu(env), "Invalid program exception %d. Aborting\n",
                       env->error_code);
             break;
         }
@@ -832,8 +832,9 @@ static void powerpc_excp_7xx(PowerPCCPU *cpu, int excp)
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
@@ -853,11 +854,12 @@ static void powerpc_excp_7xx(PowerPCCPU *cpu, int excp)
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
 
@@ -880,7 +882,6 @@ static void powerpc_excp_7xx(PowerPCCPU *cpu, int excp)
 
 static void powerpc_excp_74xx(PowerPCCPU *cpu, int excp)
 {
-    CPUState *cs = CPU(cpu);
     CPUPPCState *env = &cpu->env;
     target_ulong msr, new_msr, vector;
 
@@ -903,8 +904,8 @@ static void powerpc_excp_74xx(PowerPCCPU *cpu, int excp)
 
     vector = env->excp_vectors[excp];
     if (vector == (target_ulong)-1ULL) {
-        cpu_abort(cs, "Raised an exception without defined vector %d\n",
-                  excp);
+        cpu_abort(env_cpu(env),
+                  "Raised an exception without defined vector %d\n", excp);
     }
 
     vector |= env->excp_prefix;
@@ -962,7 +963,7 @@ static void powerpc_excp_74xx(PowerPCCPU *cpu, int excp)
             break;
         default:
             /* Should never occur */
-            cpu_abort(cs, "Invalid program exception %d. Aborting\n",
+            cpu_abort(env_cpu(env), "Invalid program exception %d. Aborting\n",
                       env->error_code);
             break;
         }
@@ -1003,7 +1004,8 @@ static void powerpc_excp_74xx(PowerPCCPU *cpu, int excp)
         break;
     case POWERPC_EXCP_RESET:     /* System reset exception                   */
         if (FIELD_EX64(env->msr, MSR, POW)) {
-            cpu_abort(cs, "Trying to deliver power-saving system reset "
+            cpu_abort(env_cpu(env),
+                      "Trying to deliver power-saving system reset "
                       "exception %d with no HV support\n", excp);
         }
         break;
@@ -1016,11 +1018,12 @@ static void powerpc_excp_74xx(PowerPCCPU *cpu, int excp)
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
 
@@ -1043,7 +1046,6 @@ static void powerpc_excp_74xx(PowerPCCPU *cpu, int excp)
 
 static void powerpc_excp_booke(PowerPCCPU *cpu, int excp)
 {
-    CPUState *cs = CPU(cpu);
     CPUPPCState *env = &cpu->env;
     target_ulong msr, new_msr, vector;
     int srr0, srr1;
@@ -1080,8 +1082,8 @@ static void powerpc_excp_booke(PowerPCCPU *cpu, int excp)
 
     vector = env->excp_vectors[excp];
     if (vector == (target_ulong)-1ULL) {
-        cpu_abort(cs, "Raised an exception without defined vector %d\n",
-                  excp);
+        cpu_abort(env_cpu(env),
+                  "Raised an exception without defined vector %d\n", excp);
     }
 
     vector |= env->excp_prefix;
@@ -1112,6 +1114,7 @@ static void powerpc_excp_booke(PowerPCCPU *cpu, int excp)
         break;
     case POWERPC_EXCP_EXTERNAL:  /* External input                           */
         if (env->mpic_proxy) {
+            CPUState *cs = env_cpu(env);
             /* IACK the IRQ on delivery */
             env->spr[SPR_BOOKE_EPR] = ldl_phys(cs->as, env->mpic_iack);
         }
@@ -1150,7 +1153,7 @@ static void powerpc_excp_booke(PowerPCCPU *cpu, int excp)
             break;
         default:
             /* Should never occur */
-            cpu_abort(cs, "Invalid program exception %d. Aborting\n",
+            cpu_abort(env_cpu(env), "Invalid program exception %d. Aborting\n",
                       env->error_code);
             break;
         }
@@ -1191,7 +1194,8 @@ static void powerpc_excp_booke(PowerPCCPU *cpu, int excp)
 
             /* DBSR already modified by caller */
         } else {
-            cpu_abort(cs, "Debug exception triggered on unsupported model\n");
+            cpu_abort(env_cpu(env),
+                      "Debug exception triggered on unsupported model\n");
         }
         break;
     case POWERPC_EXCP_SPEU:   /* SPE/embedded floating-point unavailable/VPU  */
@@ -1205,17 +1209,19 @@ static void powerpc_excp_booke(PowerPCCPU *cpu, int excp)
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
 
@@ -1278,7 +1284,6 @@ static bool books_vhyp_handles_hv_excp(PowerPCCPU *cpu)
 
 static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
 {
-    CPUState *cs = CPU(cpu);
     CPUPPCState *env = &cpu->env;
     target_ulong msr, new_msr, vector;
     int srr0, srr1, lev = -1;
@@ -1317,8 +1322,8 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
 
     vector = env->excp_vectors[excp];
     if (vector == (target_ulong)-1ULL) {
-        cpu_abort(cs, "Raised an exception without defined vector %d\n",
-                  excp);
+        cpu_abort(env_cpu(env),
+                  "Raised an exception without defined vector %d\n", excp);
     }
 
     vector |= env->excp_prefix;
@@ -1408,7 +1413,7 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
             break;
         default:
             /* Should never occur */
-            cpu_abort(cs, "Invalid program exception %d. Aborting\n",
+            cpu_abort(env_cpu(env), "Invalid program exception %d. Aborting\n",
                       env->error_code);
             break;
         }
@@ -1469,7 +1474,8 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
             new_msr |= (target_ulong)MSR_HVB;
         } else {
             if (FIELD_EX64(env->msr, MSR, POW)) {
-                cpu_abort(cs, "Trying to deliver power-saving system reset "
+                cpu_abort(env_cpu(env),
+                          "Trying to deliver power-saving system reset "
                           "exception %d with no HV support\n", excp);
             }
         }
@@ -1524,11 +1530,12 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
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
 
@@ -1561,8 +1568,8 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
     } else {
         /* Sanity check */
         if (!(env->msr_mask & MSR_HVB) && srr0 == SPR_HSRR0) {
-            cpu_abort(cs, "Trying to deliver HV exception (HSRR) %d with "
-                      "no HV support\n", excp);
+            cpu_abort(env_cpu(env), "Trying to deliver HV exception (HSRR) %d "
+                      "with no HV support\n", excp);
         }
 
         /* This can update new_msr and vector if AIL applies */
@@ -1580,11 +1587,11 @@ static inline void powerpc_excp_books(PowerPCCPU *cpu, int excp)
 
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
@@ -2118,7 +2125,6 @@ void ppc_maybe_interrupt(CPUPPCState *env)
 static void p7_deliver_interrupt(CPUPPCState *env, int interrupt)
 {
     PowerPCCPU *cpu = env_archcpu(env);
-    CPUState *cs = env_cpu(env);
 
     switch (interrupt) {
     case PPC_INTERRUPT_MCK: /* Machine check exception */
@@ -2162,14 +2168,14 @@ static void p7_deliver_interrupt(CPUPPCState *env, int interrupt)
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
@@ -2233,7 +2239,8 @@ static void p8_deliver_interrupt(CPUPPCState *env, int interrupt)
         assert(!env->resume_as_sreset);
         break;
     default:
-        cpu_abort(cs, "Invalid PowerPC interrupt %d. Aborting\n", interrupt);
+        cpu_abort(env_cpu(env), "Invalid PowerPC interrupt %d. Aborting\n",
+                  interrupt);
     }
 }
 
@@ -2312,7 +2319,8 @@ static void p9_deliver_interrupt(CPUPPCState *env, int interrupt)
         assert(!env->resume_as_sreset);
         break;
     default:
-        cpu_abort(cs, "Invalid PowerPC interrupt %d. Aborting\n", interrupt);
+        cpu_abort(env_cpu(env), "Invalid PowerPC interrupt %d. Aborting\n",
+                  interrupt);
     }
 }
 #endif
@@ -2320,7 +2328,6 @@ static void p9_deliver_interrupt(CPUPPCState *env, int interrupt)
 static void ppc_deliver_interrupt_generic(CPUPPCState *env, int interrupt)
 {
     PowerPCCPU *cpu = env_archcpu(env);
-    CPUState *cs = env_cpu(env);
 
     switch (interrupt) {
     case PPC_INTERRUPT_RESET: /* External reset */
@@ -2417,7 +2424,8 @@ static void ppc_deliver_interrupt_generic(CPUPPCState *env, int interrupt)
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


