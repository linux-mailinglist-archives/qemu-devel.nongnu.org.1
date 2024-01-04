Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A6DBF824851
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 19:38:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLSaI-0001Mm-Fe; Thu, 04 Jan 2024 13:36:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rLSaE-0001LX-Rw
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 13:36:46 -0500
Received: from sin.source.kernel.org ([145.40.73.55])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rLSaD-00052L-1O
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 13:36:46 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 07DAFCE1A9E;
 Thu,  4 Jan 2024 18:36:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0391C433C7;
 Thu,  4 Jan 2024 18:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1704393394;
 bh=U9ELA9CSzBzQvR2mewIpQhkEKKPZ2EGYxEwZmAAmKrc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=VBpqQ+/wEnAx+9b/o2CiUmH/iQrGbrlHVFQFjPo6WbytQ6PEWH52+r8r0S36cPNZD
 c/Jze45+GC8HKfZCdcL5iytdfGrUKqmD2NH18yaxRQ3hzSHjwPZHPZT/lZf7fF8frI
 eav745R3DaFVW/l5EicStuLkEGWPgL/adA5xzD6hBXzuVakR10d44E7BJM7kxcvswW
 ZJc7vr+7QKZ7/AK4V08VYK1pT0VUSCWwDkT7CWsLpXhR8D3Y9/FhDqlrulNnN1YiXK
 VAX4/XVQKG5jQgimOqBjDdbP9bcpOjCzLn0uB5y1BuKj43SGnkzkrPOKEkOB4NUDz7
 2CYNev72BtAaQ==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, Bruno Haible <bruno@clisp.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Nelson H . F . Beebe" <beebe@math.utah.edu>, Helge Deller <deller@gmx.de>
Subject: [PATCH 1/9] hw/hppa/machine: Allow up to 3840 MB total memory
Date: Thu,  4 Jan 2024 19:36:20 +0100
Message-ID: <20240104183628.101366-2-deller@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240104183628.101366-1-deller@kernel.org>
References: <20240104183628.101366-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=145.40.73.55; envelope-from=deller@kernel.org;
 helo=sin.source.kernel.org
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.691,
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

Signed-off-by: Helge Deller <deller@gmx.de>
Noticed-by: Nelson H. F. Beebe <beebe@math.utah.edu>
Fixes: b7746b1194c8 ("hw/hppa/machine: Restrict the total memory size to 3GB")
---
 hw/hppa/machine.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index c8da7c18d5..6181f4b747 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -276,6 +276,7 @@ static TranslateFn *machine_HP_common_init_cpus(MachineState *machine)
     unsigned int smp_cpus = machine->smp.cpus;
     TranslateFn *translate;
     MemoryRegion *cpu_region;
+    ram_addr_t ram_max;
 
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
+        info_report("Max RAM size limited to %ld MB", ram_max / MiB);
+        machine->ram_size = ram_max;
     }
     memory_region_add_subregion_overlap(addr_space, 0, machine->ram, -1);
 
-- 
2.43.0


