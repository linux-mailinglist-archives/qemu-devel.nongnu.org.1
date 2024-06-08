Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 139BC900E22
	for <lists+qemu-devel@lfdr.de>; Sat,  8 Jun 2024 00:36:29 +0200 (CEST)
Received: from [::1] (helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFf39-0004X3-U8; Fri, 07 Jun 2024 15:14:55 -0400
Received: from [2001:470:142:3::10] (helo=eggs.gnu.org)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sFf37-0004O7-Pb; Fri, 07 Jun 2024 15:14:53 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sFf35-0002BR-SI; Fri, 07 Jun 2024 15:14:53 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 769956E54E;
 Fri,  7 Jun 2024 22:14:05 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 902B5E274A;
 Fri,  7 Jun 2024 22:13:10 +0300 (MSK)
Received: (nullmailer pid 528740 invoked by uid 1000);
 Fri, 07 Jun 2024 19:13:08 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Joseph Chan <jchan@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.5 37/45] target/riscv: prioritize pmp errors in
 raise_mmu_exception()
Date: Fri,  7 Jun 2024 22:12:56 +0300
Message-Id: <20240607191307.528622-17-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.5-20240607221227@cover.tls.msk.ru>
References: <qemu-stable-8.2.5-20240607221227@cover.tls.msk.ru>
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

raise_mmu_exception(), as is today, is prioritizing guest page faults by
checking first if virt_enabled && !first_stage, and then considering the
regular inst/load/store faults.

There's no mention in the spec about guest page fault being a higher
priority that PMP faults. In fact, privileged spec section 3.7.1 says:

"Attempting to fetch an instruction from a PMP region that does not have
execute permissions raises an instruction access-fault exception.
Attempting to execute a load or load-reserved instruction which accesses
a physical address within a PMP region without read permissions raises a
load access-fault exception. Attempting to execute a store,
store-conditional, or AMO instruction which accesses a physical address
within a PMP region without write permissions raises a store
access-fault exception."

So, in fact, we're doing it wrong - PMP faults should always be thrown,
regardless of also being a first or second stage fault.

The way riscv_cpu_tlb_fill() and get_physical_address() work is
adequate: a TRANSLATE_PMP_FAIL error is immediately reported and
reflected in the 'pmp_violation' flag. What we need is to change
raise_mmu_exception() to prioritize it.

Reported-by: Joseph Chan <jchan@ventanamicro.com>
Fixes: 82d53adfbb ("target/riscv/cpu_helper.c: Invalid exception on MMU translation stage")
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240413105929.7030-1-alexei.filippov@syntacore.com>
Cc: qemu-stable <qemu-stable@nongnu.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
(cherry picked from commit 68e7c86927afa240fa450578cb3a4f18926153e4)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index da1a153abf..cf97c782dd 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1162,28 +1162,30 @@ static void raise_mmu_exception(CPURISCVState *env, target_ulong address,
 
     switch (access_type) {
     case MMU_INST_FETCH:
-        if (env->virt_enabled && !first_stage) {
+        if (pmp_violation) {
+            cs->exception_index = RISCV_EXCP_INST_ACCESS_FAULT;
+        } else if (env->virt_enabled && !first_stage) {
             cs->exception_index = RISCV_EXCP_INST_GUEST_PAGE_FAULT;
         } else {
-            cs->exception_index = pmp_violation ?
-                RISCV_EXCP_INST_ACCESS_FAULT : RISCV_EXCP_INST_PAGE_FAULT;
+            cs->exception_index = RISCV_EXCP_INST_PAGE_FAULT;
         }
         break;
     case MMU_DATA_LOAD:
-        if (two_stage && !first_stage) {
+        if (pmp_violation) {
+            cs->exception_index = RISCV_EXCP_LOAD_ACCESS_FAULT;
+        } else if (two_stage && !first_stage) {
             cs->exception_index = RISCV_EXCP_LOAD_GUEST_ACCESS_FAULT;
         } else {
-            cs->exception_index = pmp_violation ?
-                RISCV_EXCP_LOAD_ACCESS_FAULT : RISCV_EXCP_LOAD_PAGE_FAULT;
+            cs->exception_index = RISCV_EXCP_LOAD_PAGE_FAULT;
         }
         break;
     case MMU_DATA_STORE:
-        if (two_stage && !first_stage) {
+        if (pmp_violation) {
+            cs->exception_index = RISCV_EXCP_STORE_AMO_ACCESS_FAULT;
+        } else if (two_stage && !first_stage) {
             cs->exception_index = RISCV_EXCP_STORE_GUEST_AMO_ACCESS_FAULT;
         } else {
-            cs->exception_index = pmp_violation ?
-                RISCV_EXCP_STORE_AMO_ACCESS_FAULT :
-                RISCV_EXCP_STORE_PAGE_FAULT;
+            cs->exception_index = RISCV_EXCP_STORE_PAGE_FAULT;
         }
         break;
     default:
-- 
2.39.2


