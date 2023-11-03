Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D4D7E088C
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 19:57:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyzL3-0000s3-1t; Fri, 03 Nov 2023 14:56:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qyzL1-0000rg-03
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 14:56:11 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qyzKx-0005De-0d
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 14:56:10 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-5094727fa67so3130366e87.3
 for <qemu-devel@nongnu.org>; Fri, 03 Nov 2023 11:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699037764; x=1699642564; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=R/Qz4BRA1gjPk+dEXh6h6hhbMDtVGzlPlkIywNyzTUM=;
 b=b0QBjV9fl629eql9D8Q4r86RAds2U2r1OZWtw9mADcIyqIR/5dz4gTfPo4H9cYTzm6
 cxPE9F6Tvdb5V0G0PupF24IaLjvtvON3R5Q+SYGT3vQ60oqmItr11TJEcE7IPpsW+baI
 t8HlvPRTnijhL3MI7tHBBBGLV6L3QLvN9iBFLnTb4jJSheVQvF3nsf1CZw7AR2FmCGIi
 EJv/7QLjx0gJgdgkyrbl3LOOK04l0lu7NEKYnmpg2PE3wuw96zxrcN8jhdXKNyJluZFV
 +WykOa68h5+sTJdyhgkoQO9qmytvij3OEI+ZyEhtgD+t11c0bOjR6nYEgYHkgwI4d3tx
 5X0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699037764; x=1699642564;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=R/Qz4BRA1gjPk+dEXh6h6hhbMDtVGzlPlkIywNyzTUM=;
 b=OGiMoAcHxQFFd0Y2B3X9M7LxKNTjXFVMjK3xWKQsRSLrOljlBbpr4bVBbFim2qrJ01
 Jx2WM5P8WNXfqCmFouQYqeGlmp/qrlRHiZKb/he217NgG3r1vz9LIR42q+zFBUa/VNth
 2ZVwAcec+SSXVbqIjq73Mr+dw6PosEhlmxpLEYbD3sGlR8bG2Ze2EnvZutXNTNBPJE4K
 r86Cpjg7OEKACuCc06Rt11uxI0iJ4CkPUvYizOSvtKOpVr5+Ck4dsnZgH+CgFeQq8x4t
 hWft3xjuxFt/smmbr5IpDOj8KiOpyEqGjwVrJkWrAsjOWuzdDr/stsyisIQCjy34JMid
 VwtQ==
X-Gm-Message-State: AOJu0YyobJpyLOt9ws3IxzpEr5/sWYrXG62npR77BhfnlxjPJJ42suOJ
 CzLT3YsUS9PK5mioSMCAML5IFg==
X-Google-Smtp-Source: AGHT+IGQF1CKoVhZc6rZPSrYhD+f4a71wnwtb3dk4/0hT3W+ymqnp2eCBG2ZOde66AojoBqcfpGCyg==
X-Received: by 2002:a05:6512:1081:b0:500:daf6:3898 with SMTP id
 j1-20020a056512108100b00500daf63898mr18623958lfg.26.1699037764476; 
 Fri, 03 Nov 2023 11:56:04 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 q2-20020adff782000000b0032179c4a46dsm2483584wrp.100.2023.11.03.11.56.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Nov 2023 11:56:03 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH] hw/arm/vexpress-a9: Remove useless mapping of RAM at address 0
Date: Fri,  3 Nov 2023 18:56:02 +0000
Message-Id: <20231103185602.875849-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x131.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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


