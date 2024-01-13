Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FAF482CA16
	for <lists+qemu-devel@lfdr.de>; Sat, 13 Jan 2024 06:58:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOX1Z-0007O1-CS; Sat, 13 Jan 2024 00:57:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rOX1X-0007NJ-AI
 for qemu-devel@nongnu.org; Sat, 13 Jan 2024 00:57:39 -0500
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rOX1V-00080T-HZ
 for qemu-devel@nongnu.org; Sat, 13 Jan 2024 00:57:39 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 64FF9CE259F;
 Sat, 13 Jan 2024 05:57:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF360C43143;
 Sat, 13 Jan 2024 05:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1705125454;
 bh=day6KyXxhUli/IuqjOYXEYLGEYoeP1JU/ugYQ5fILLM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Wm6Li8nDws9aqsIS8czyk/aKK+R4ShXmcWUZyEoswYD/3PL6pP//XEsmk6mljazFj
 xvT536Pn8IPVtg5HIzyVTtxRdPhBFl1yYIpIpg/LkCKx0TX4P8AnilMK/8F8GMkzdt
 fXuUrmVKGdbORdKsCvjemEmRhTkzHvvsnzShXY/4r97rlZ2ZNxpoqv+Tq56irLqS2R
 CJH5mV34u6IHeQ4+ohzQtGlXdjoOk20kilb23R651Wz5tTk4dgZAM0j1WJewi/3vZB
 SmLTpgebsMxW3a9fmr71280iVYRSXQJCI93Ze+JaQLKSBEzHJ9lIxSF5Uv9F8hTXpp
 Uk5foUS/Isqtw==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Nelson H . F . Beebe" <beebe@math.utah.edu>,
 Bruno Haible <bruno@clisp.org>
Subject: [PULL 01/10] hw/hppa/machine: Allow up to 3840 MB total memory
Date: Sat, 13 Jan 2024 06:57:19 +0100
Message-ID: <20240113055729.4480-2-deller@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240113055729.4480-1-deller@kernel.org>
References: <20240113055729.4480-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:40e1:4800::1;
 envelope-from=deller@kernel.org; helo=sin.source.kernel.org
X-Spam_score_int: -64
X-Spam_score: -6.5
X-Spam_bar: ------
X-Spam_report: (-6.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.09,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Helge Deller <deller@gmx.de>

The physical hardware allows DIMMs of 4 MB size and above, allowing up
to 3840 MB of memory, but is restricted by setup code to 3 GB.
Increase the limit to allow up to the maximum amount of memory.

Btw. the memory area from 0xf000.0000 to 0xffff.ffff is reserved by
the architecture for firmware and I/O memory and can not be used for
standard memory.

An upcoming 64-bit SeaBIOS-hppa firmware will allow more than 3.75GB
on 64-bit HPPA64. In this case the ram_max for the pa20 case will change.

Signed-off-by: Helge Deller <deller@gmx.de>
Noticed-by: Nelson H. F. Beebe <beebe@math.utah.edu>
Fixes: b7746b1194c8 ("hw/hppa/machine: Restrict the total memory size to 3GB")
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Bruno Haible <bruno@clisp.org>
---
 hw/hppa/machine.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index c8da7c18d5..b11907617e 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -276,6 +276,7 @@ static TranslateFn *machine_HP_common_init_cpus(MachineState *machine)
     unsigned int smp_cpus = machine->smp.cpus;
     TranslateFn *translate;
     MemoryRegion *cpu_region;
+    uint64_t ram_max;
 
     /* Create CPUs.  */
     for (unsigned int i = 0; i < smp_cpus; i++) {
@@ -288,8 +289,10 @@ static TranslateFn *machine_HP_common_init_cpus(MachineState *machine)
      */
     if (hppa_is_pa20(&cpu[0]->env)) {
         translate = translate_pa20;
+        ram_max = 0xf0000000;      /* 3.75 GB (limited by 32-bit firmware) */
     } else {
         translate = translate_pa10;
+        ram_max = 0xf0000000;      /* 3.75 GB (32-bit CPU) */
     }
 
     for (unsigned int i = 0; i < smp_cpus; i++) {
@@ -311,9 +314,9 @@ static TranslateFn *machine_HP_common_init_cpus(MachineState *machine)
                                 cpu_region);
 
     /* Main memory region. */
-    if (machine->ram_size > 3 * GiB) {
-        error_report("RAM size is currently restricted to 3GB");
-        exit(EXIT_FAILURE);
+    if (machine->ram_size > ram_max) {
+        info_report("Max RAM size limited to %" PRIu64 " MB", ram_max / MiB);
+        machine->ram_size = ram_max;
     }
     memory_region_add_subregion_overlap(addr_space, 0, machine->ram, -1);
 
-- 
2.43.0


