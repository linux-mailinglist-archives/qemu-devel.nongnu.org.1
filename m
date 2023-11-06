Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B227E28CF
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 16:34:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r01b8-0008L3-4a; Mon, 06 Nov 2023 10:33:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r01aw-00082Q-Pd
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 10:32:57 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r01ao-0004Oa-Ka
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 10:32:53 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-32f87b1c725so3257980f8f.3
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 07:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699284765; x=1699889565; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=813QsleyMqyhS0dbJ++cZmaNQq8ezRMtCTKDgM9WCS0=;
 b=v1mEVIvUTJfMi/gBhbyuiQjp+iLFCr4T4CA50SmS5k/YNC4i/D4YzQAX/MN5pTi3HZ
 So+GyChJtjOjZUDHARF8T2RWqK99yQJ1Wpz/tQWJfpAHjvyeGVQEXO6a5X3KcrmOO6cw
 Cyb0ZKYL5pixyP78oEmANMwB4qtKODie+F58Q5KRwrKms7wOrdE3NsDodkfSB3f/O9o7
 l1cVO3GAwYRy+18I7vyY9BvSBH4HkADaLd1xJk8TLJ1XpSUsEbObCDIdPnypSfgMbReV
 x8jC8pYyFcD0f5Ws4YuhCMZPUUq5WN8P81KrVuIBJjuztlZAHZxmLIaWsOuBsuGjpBor
 VkXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699284765; x=1699889565;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=813QsleyMqyhS0dbJ++cZmaNQq8ezRMtCTKDgM9WCS0=;
 b=LU6VlwZXUQwhZu6a06+U6a58cdI9KOCMVDGJtxqsfLHBrM3MBVmJ14fMg+jv1ZTaEy
 a59J+Dr2y2tOTCKNqJk4amvRWqfrHxV9+nXKS6tsPqbqLm07X5rcoBfLIQQYpumAVegm
 zxn8HBi8bQ9d7LscZkrUhcHbbrG5GJDv3aKQe6DX0nLrr8RKyfhqb91HCCOzU18q/dZS
 Q8+GkuYggFemg+Ay3mN/vetrc9AuNYJW0twcZhltVnXKRIEUjwVVkKuSMzmJV6kLruDv
 jjznBZRq255OfB7duGxdQXhCeMAwkwe829KScvRw2hBeYa/iVAUQqxi+hsNO1EQ/rwfx
 0kPg==
X-Gm-Message-State: AOJu0YyElP4OTMvB/y3qDhr7sIfyPYTjqwo29WDzDQaGQH5c+RF4ZfjC
 8EMONbz14DHswW3kmCVGE4B1Q5wFFzhmFST64pY=
X-Google-Smtp-Source: AGHT+IFOyQDOFZtMqNAqYumZY2BuHp8KU7WT35Hg+Pps/dDbKSM21RAhTTMM0npRRblQcfyB42t5Dg==
X-Received: by 2002:adf:d1c9:0:b0:32d:8505:b9d7 with SMTP id
 b9-20020adfd1c9000000b0032d8505b9d7mr24715508wrd.43.1699284764920; 
 Mon, 06 Nov 2023 07:32:44 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 d5-20020adff2c5000000b0032da6f17ffdsm9752176wrp.38.2023.11.06.07.32.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 07:32:44 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/12] hw/arm/vexpress-a9: Remove useless mapping of RAM at
 address 0
Date: Mon,  6 Nov 2023 15:32:37 +0000
Message-Id: <20231106153238.1426649-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231106153238.1426649-1-peter.maydell@linaro.org>
References: <20231106153238.1426649-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On the vexpress-a9 board we try to map both RAM and flash to address 0,
as seen in "info mtree":

address-space: memory
  0000000000000000-ffffffffffffffff (prio 0, i/o): system
    0000000000000000-0000000003ffffff (prio 0, romd): alias vexpress.flashalias @vexpress.flash0 0000000000000000-0000000003ffffff
    0000000000000000-0000000003ffffff (prio 0, ram): alias vexpress.lowmem @vexpress.highmem 0000000000000000-0000000003ffffff
    0000000010000000-0000000010000fff (prio 0, i/o): arm-sysctl
    0000000010004000-0000000010004fff (prio 0, i/o): pl041
(etc)

The flash "wins" and the RAM mapping is useless (but also harmless).

This happened as a result of commit 6ec1588e in 2014, which changed
"we always map the RAM to the low addresses for vexpress-a9" to "we
always map flash in the low addresses", but forgot to stop mapping
the RAM.

In real hardware, this low part of memory is remappable, both at
runtime by the guest writing to a control register, and configurably
as to what you get out of reset -- you can have the first flash
device, or the second, or the DDR2 RAM, or the external AXI bus
(which for QEMU means "nothing there").  In an ideal world we would
support that remapping both at runtime and via a machine property to
select the out-of-reset behaviour.

Pending anybody caring enough to implement the full remapping
behaviour:
 * remove the useless mapped-but-inaccessible lowram MR
 * document that QEMU doesn't support remapping of low memory

Fixes: 6ec1588e ("hw/arm/vexpress: Alias NOR flash at 0 for vexpress-a9")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1761
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20231103185602.875849-1-peter.maydell@linaro.org
---
 docs/system/arm/vexpress.rst |  3 +++
 hw/arm/vexpress.c            | 14 +++-----------
 2 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/docs/system/arm/vexpress.rst b/docs/system/arm/vexpress.rst
index 3e3839e9231..38f29c73e71 100644
--- a/docs/system/arm/vexpress.rst
+++ b/docs/system/arm/vexpress.rst
@@ -58,6 +58,9 @@ Other differences between the hardware and the QEMU model:
   ``vexpress-a15``, and have IRQs from 40 upwards. If a dtb is
   provided on the command line then QEMU will edit it to include
   suitable entries describing these transports for the guest.
+- QEMU does not currently support either dynamic or static remapping
+  of the area of memory at address 0: it is always mapped to alias
+  the first flash bank
 
 Booting a Linux kernel
 ----------------------
diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index 8ff37f52ca1..c08ea34e924 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -177,7 +177,6 @@ struct VexpressMachineState {
     MemoryRegion vram;
     MemoryRegion sram;
     MemoryRegion flashalias;
-    MemoryRegion lowram;
     MemoryRegion a15sram;
     bool secure;
     bool virt;
@@ -276,7 +275,6 @@ static void a9_daughterboard_init(VexpressMachineState *vms,
 {
     MachineState *machine = MACHINE(vms);
     MemoryRegion *sysmem = get_system_memory();
-    ram_addr_t low_ram_size;
 
     if (ram_size > 0x40000000) {
         /* 1GB is the maximum the address space permits */
@@ -284,17 +282,11 @@ static void a9_daughterboard_init(VexpressMachineState *vms,
         exit(1);
     }
 
-    low_ram_size = ram_size;
-    if (low_ram_size > 0x4000000) {
-        low_ram_size = 0x4000000;
-    }
-    /* RAM is from 0x60000000 upwards. The bottom 64MB of the
+    /*
+     * RAM is from 0x60000000 upwards. The bottom 64MB of the
      * address space should in theory be remappable to various
-     * things including ROM or RAM; we always map the RAM there.
+     * things including ROM or RAM; we always map the flash there.
      */
-    memory_region_init_alias(&vms->lowram, NULL, "vexpress.lowmem",
-                             machine->ram, 0, low_ram_size);
-    memory_region_add_subregion(sysmem, 0x0, &vms->lowram);
     memory_region_add_subregion(sysmem, 0x60000000, machine->ram);
 
     /* 0x1e000000 A9MPCore (SCU) private memory region */
-- 
2.34.1


