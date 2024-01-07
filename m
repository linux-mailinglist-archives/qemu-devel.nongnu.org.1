Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A5C826443
	for <lists+qemu-devel@lfdr.de>; Sun,  7 Jan 2024 14:25:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMT74-0006De-V4; Sun, 07 Jan 2024 08:22:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rMT71-0006Br-QY
 for qemu-devel@nongnu.org; Sun, 07 Jan 2024 08:22:47 -0500
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1rMT6z-0003IT-Ss
 for qemu-devel@nongnu.org; Sun, 07 Jan 2024 08:22:47 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 2097B60B8F;
 Sun,  7 Jan 2024 13:22:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3144BC433C7;
 Sun,  7 Jan 2024 13:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1704633763;
 bh=x5HS85v9XKG7GpzaRkj/xQnL6uABu0jC0TxVzXDXJsc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=OuP20gdGLoO5cog7SuTa3qKU2V1+PJQRlCt5QNFxjVQSUictuCpiyOMSNK/+gTCoB
 B0ci8gux35dn4eD2qRrKpEuWzsi5Fsnz+bEs2isi6r56wjNjiNFXWiWN48x3RTbjaV
 QWfJ5q5MRlEqLHvXVVrn4aPCz+2CsgLPQv/Yp/n8csCqB+fUUJN2cyFqXCztLJHdZJ
 UIOHkgcnUblJLXHZdUSM4u1NA0rk1V6GE6Dyr/SeQp4U8oHlD6LEJOZqO1OdaTzKm2
 vT07RDtVxA+SrB4sTOgbcWIDLBYB2H8mpyH91g3uGblfFbmNSzS2o3RathDly65R1k
 67wx5zz2qEPug==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, Bruno Haible <bruno@clisp.org>,
 "Nelson H . F . Beebe" <beebe@math.utah.edu>, Helge Deller <deller@gmx.de>
Subject: [PATCH v2 1/9] hw/hppa/machine: Allow up to 3840 MB total memory
Date: Sun,  7 Jan 2024 14:22:29 +0100
Message-ID: <20240107132237.50553-2-deller@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240107132237.50553-1-deller@kernel.org>
References: <20240107132237.50553-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=139.178.84.217; envelope-from=deller@kernel.org;
 helo=dfw.source.kernel.org
X-Spam_score_int: -91
X-Spam_score: -9.2
X-Spam_bar: ---------
X-Spam_report: (-9.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.098,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


