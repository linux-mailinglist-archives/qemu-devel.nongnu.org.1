Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A720C732313
	for <lists+qemu-devel@lfdr.de>; Fri, 16 Jun 2023 01:07:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9w05-0002ii-20; Thu, 15 Jun 2023 19:03:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q9w01-0002Xe-VZ; Thu, 15 Jun 2023 19:03:29 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q9w00-0007kV-BR; Thu, 15 Jun 2023 19:03:29 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 55B98748A5E;
 Fri, 16 Jun 2023 01:03:21 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 2F2EE748A56; Fri, 16 Jun 2023 01:03:21 +0200 (CEST)
Message-Id: <28424220f37f51ce97f24cadc7538a9c0d16cb45.1686868895.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1686868895.git.balaton@eik.bme.hu>
References: <cover.1686868895.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v3 11/14] target/ppc: Get CPUState in one step
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: clg@kaod.org, Greg Kurz <groug@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>
Date: Fri, 16 Jun 2023 01:03:21 +0200 (CEST)
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

We can get CPUState from env with env_cpu without going through
PowerPCCPU and casting that.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Acked-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/excp_helper.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index a62103b8ac..cfb652445a 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -1503,8 +1503,8 @@ static int p7_interrupt_powersave(CPUPPCState *env)
 
 static int p7_next_unmasked_interrupt(CPUPPCState *env)
 {
-    PowerPCCPU *cpu = env_archcpu(env);
-    CPUState *cs = CPU(cpu);
+    CPUState *cs = env_cpu(env);
+
     /* Ignore MSR[EE] when coming out of some power management states */
     bool msr_ee = FIELD_EX64(env->msr, MSR, EE) || env->resume_as_sreset;
 
@@ -1593,8 +1593,8 @@ static int p8_interrupt_powersave(CPUPPCState *env)
 
 static int p8_next_unmasked_interrupt(CPUPPCState *env)
 {
-    PowerPCCPU *cpu = env_archcpu(env);
-    CPUState *cs = CPU(cpu);
+    CPUState *cs = env_cpu(env);
+
     /* Ignore MSR[EE] when coming out of some power management states */
     bool msr_ee = FIELD_EX64(env->msr, MSR, EE) || env->resume_as_sreset;
 
@@ -1714,8 +1714,8 @@ static int p9_interrupt_powersave(CPUPPCState *env)
 
 static int p9_next_unmasked_interrupt(CPUPPCState *env)
 {
-    PowerPCCPU *cpu = env_archcpu(env);
-    CPUState *cs = CPU(cpu);
+    CPUState *cs = env_cpu(env);
+
     /* Ignore MSR[EE] when coming out of some power management states */
     bool msr_ee = FIELD_EX64(env->msr, MSR, EE) || env->resume_as_sreset;
 
@@ -2410,9 +2410,8 @@ void helper_scv(CPUPPCState *env, uint32_t lev)
 
 void helper_pminsn(CPUPPCState *env, uint32_t insn)
 {
-    CPUState *cs;
+    CPUState *cs = env_cpu(env);
 
-    cs = env_cpu(env);
     cs->halted = 1;
 
     /* Condition for waking up at 0x100 */
-- 
2.30.9


