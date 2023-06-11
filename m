Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D3472B4A5
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 00:44:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8Tli-0000ES-By; Sun, 11 Jun 2023 18:42:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q8Tlf-0000DJ-FX; Sun, 11 Jun 2023 18:42:39 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q8Tld-0004g5-LC; Sun, 11 Jun 2023 18:42:39 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 4468F748A66;
 Mon, 12 Jun 2023 00:42:31 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 27A30748A64; Mon, 12 Jun 2023 00:42:31 +0200 (CEST)
Message-Id: <0e526b0cdfc31655fd1d3c3f2d6ea75bcafb8f3c.1686522199.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1686522199.git.balaton@eik.bme.hu>
References: <cover.1686522199.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 01/10] target/ppc: Remove some superfluous parentheses
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: clg@kaod.org, Greg Kurz <groug@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Mon, 12 Jun 2023 00:42:31 +0200 (CEST)
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

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 target/ppc/excp_helper.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 12d8a7257b..8298217e78 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -1009,7 +1009,7 @@ static void powerpc_excp_74xx(PowerPCCPU *cpu, int excp)
     {
         int lev = env->error_code;
 
-        if ((lev == 1) && cpu->vhyp) {
+        if (lev == 1 && cpu->vhyp) {
             dump_hcall(env);
         } else {
             dump_syscall(env);
@@ -1027,7 +1027,7 @@ static void powerpc_excp_74xx(PowerPCCPU *cpu, int excp)
          * uses VOF and the 74xx CPUs, so although the 74xx don't have
          * HV mode, we need to keep hypercall support.
          */
-        if ((lev == 1) && cpu->vhyp) {
+        if (lev == 1 && cpu->vhyp) {
             PPCVirtualHypervisorClass *vhc =
                 PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
             vhc->hypercall(cpu->vhyp, cpu);
@@ -1481,7 +1481,7 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
     case POWERPC_EXCP_SYSCALL:   /* System call exception                    */
         lev = env->error_code;
 
-        if ((lev == 1) && cpu->vhyp) {
+        if (lev == 1 && cpu->vhyp) {
             dump_hcall(env);
         } else {
             dump_syscall(env);
@@ -1494,7 +1494,7 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
         env->nip += 4;
 
         /* "PAPR mode" built-in hypercall emulation */
-        if ((lev == 1) && books_vhyp_handles_hcall(cpu)) {
+        if (lev == 1 && books_vhyp_handles_hcall(cpu)) {
             PPCVirtualHypervisorClass *vhc =
                 PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
             vhc->hypercall(cpu->vhyp, cpu);
-- 
2.30.9


