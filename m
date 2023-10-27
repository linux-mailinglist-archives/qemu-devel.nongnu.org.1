Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C82FD7D9BEC
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 16:45:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwO0n-0007wB-FT; Fri, 27 Oct 2023 10:40:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qwO0L-0007Nd-UN
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 10:40:06 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qwO0G-0008BN-CP
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 10:40:05 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2c50906f941so32202241fa.2
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 07:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698417598; x=1699022398; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1p9KVKDoDB453y9P2t06KEHsQm3HAkllfoNShv9eI/E=;
 b=ua2ibiCrlXYt1g9DGNEAZqgV69UukvbYIJc5fYIOvYG9U9U1+neMhsUr4ZxlGtjsZT
 veEHFYIVbD7v5GIcWP9BeRQJF7/bxO3m34X4o1RteZpTYVXcX9ZY6LPGjRz5Vn4AMsOH
 N+Dj1gH6o90+YjFzUyqonHYW+byTC1Cu3U+JXAY4KRuv7Tbp0wBWY+NRzNVAGKzP3ZFV
 WUjztUooWTVLNkE7l9+3n9AXoH1S2U0lSuDG10mzCMmp24ngSx7/pLaJEp5Hct+FjHtQ
 ltpTMfMh2RiZ3DOLuOXjlD08l35v1aUENAP28qYUJMikfjm0FtcGdBwiTVyr3mKMmfen
 aDjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698417598; x=1699022398;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1p9KVKDoDB453y9P2t06KEHsQm3HAkllfoNShv9eI/E=;
 b=FYUAdVycT0ubAniH7rb89/nUxcwzI5flMTbSAzUi0msCGHAsO9GwzrpiZk7SD2n5kB
 YIkXUsDPubWPOOMe20KBIRQI4YoztEeycgga7rdjIaZIE+z6NoCIHS5QI+vy97vLyaQj
 nGOprjxjCbk37wHBbP5xAlpwpwvIqaW9x4H7geQDarIvQXAz0340gFKSqHp8/3e4MrFy
 K5P6Bh1wWr5lzVXtr97XHdNhG3rCopeLmMePjqQggn21fUFZBkYDO+cyIL/iP7wGUneB
 48xYarINUiGdFCJnUkf386FDvS9e2eFkUYQx1Xtmqc6ZndQJNYzRvVjsmdYYdlPLrKHt
 c8YQ==
X-Gm-Message-State: AOJu0YysjB5Dy4fnisUZ/qL42FwRsilTyDMdHW7GKLozdK1IotngEOGq
 EXbsesDP8P4YX7ytd7Io89Cx20jxn6CCSgutWhk=
X-Google-Smtp-Source: AGHT+IF4AVepCoQ/nlYOUP1tHs8mnKD2MX25PhfLVTHB/b7w7NQOQfzXaHNA8oeXNh8L1uDOakgQnw==
X-Received: by 2002:ac2:4e65:0:b0:500:7efe:313c with SMTP id
 y5-20020ac24e65000000b005007efe313cmr1898119lfs.24.1698417598418; 
 Fri, 27 Oct 2023 07:39:58 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 e2-20020a5d5002000000b0031c6581d55esm1874123wrt.91.2023.10.27.07.39.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Oct 2023 07:39:58 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 29/41] hw/arm: Avoid using 'first_cpu' when first ARM CPU is
 reachable
Date: Fri, 27 Oct 2023 15:39:30 +0100
Message-Id: <20231027143942.3413881-30-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231027143942.3413881-1-peter.maydell@linaro.org>
References: <20231027143942.3413881-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Prefer using a well known local first CPU rather than a global one.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20231025065909.57344-1-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/bananapi_m2u.c   | 2 +-
 hw/arm/exynos4_boards.c | 7 ++++---
 hw/arm/orangepi.c       | 2 +-
 hw/arm/realview.c       | 2 +-
 hw/arm/xilinx_zynq.c    | 2 +-
 5 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/hw/arm/bananapi_m2u.c b/hw/arm/bananapi_m2u.c
index a7c7a9f96d7..8f24b18d8ca 100644
--- a/hw/arm/bananapi_m2u.c
+++ b/hw/arm/bananapi_m2u.c
@@ -128,7 +128,7 @@ static void bpim2u_init(MachineState *machine)
     bpim2u_binfo.loader_start = r40->memmap[AW_R40_DEV_SDRAM];
     bpim2u_binfo.ram_size = machine->ram_size;
     bpim2u_binfo.psci_conduit = QEMU_PSCI_CONDUIT_SMC;
-    arm_load_kernel(ARM_CPU(first_cpu), machine, &bpim2u_binfo);
+    arm_load_kernel(&r40->cpus[0], machine, &bpim2u_binfo);
 }
 
 static void bpim2u_machine_init(MachineClass *mc)
diff --git a/hw/arm/exynos4_boards.c b/hw/arm/exynos4_boards.c
index ef5bcbc212c..b0e13eb4f00 100644
--- a/hw/arm/exynos4_boards.c
+++ b/hw/arm/exynos4_boards.c
@@ -134,9 +134,10 @@ exynos4_boards_init_common(MachineState *machine,
 
 static void nuri_init(MachineState *machine)
 {
-    exynos4_boards_init_common(machine, EXYNOS4_BOARD_NURI);
+    Exynos4BoardState *s = exynos4_boards_init_common(machine,
+                                                      EXYNOS4_BOARD_NURI);
 
-    arm_load_kernel(ARM_CPU(first_cpu), machine, &exynos4_board_binfo);
+    arm_load_kernel(s->soc.cpu[0], machine, &exynos4_board_binfo);
 }
 
 static void smdkc210_init(MachineState *machine)
@@ -146,7 +147,7 @@ static void smdkc210_init(MachineState *machine)
 
     lan9215_init(SMDK_LAN9118_BASE_ADDR,
             qemu_irq_invert(s->soc.irq_table[exynos4210_get_irq(37, 1)]));
-    arm_load_kernel(ARM_CPU(first_cpu), machine, &exynos4_board_binfo);
+    arm_load_kernel(s->soc.cpu[0], machine, &exynos4_board_binfo);
 }
 
 static void nuri_class_init(ObjectClass *oc, void *data)
diff --git a/hw/arm/orangepi.c b/hw/arm/orangepi.c
index d0eca54cd95..f3784d45caf 100644
--- a/hw/arm/orangepi.c
+++ b/hw/arm/orangepi.c
@@ -106,7 +106,7 @@ static void orangepi_init(MachineState *machine)
     orangepi_binfo.loader_start = h3->memmap[AW_H3_DEV_SDRAM];
     orangepi_binfo.ram_size = machine->ram_size;
     orangepi_binfo.psci_conduit = QEMU_PSCI_CONDUIT_SMC;
-    arm_load_kernel(ARM_CPU(first_cpu), machine, &orangepi_binfo);
+    arm_load_kernel(&h3->cpus[0], machine, &orangepi_binfo);
 }
 
 static void orangepi_machine_init(MachineClass *mc)
diff --git a/hw/arm/realview.c b/hw/arm/realview.c
index 8f89526596c..132217b2edd 100644
--- a/hw/arm/realview.c
+++ b/hw/arm/realview.c
@@ -384,7 +384,7 @@ static void realview_init(MachineState *machine,
     realview_binfo.ram_size = ram_size;
     realview_binfo.board_id = realview_board_id[board_type];
     realview_binfo.loader_start = (board_type == BOARD_PB_A8 ? 0x70000000 : 0);
-    arm_load_kernel(ARM_CPU(first_cpu), machine, &realview_binfo);
+    arm_load_kernel(cpu, machine, &realview_binfo);
 }
 
 static void realview_eb_init(MachineState *machine)
diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index 8dc2ea83a93..dbb9793aa13 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -349,7 +349,7 @@ static void zynq_init(MachineState *machine)
     zynq_binfo.board_setup_addr = BOARD_SETUP_ADDR;
     zynq_binfo.write_board_setup = zynq_write_board_setup;
 
-    arm_load_kernel(ARM_CPU(first_cpu), machine, &zynq_binfo);
+    arm_load_kernel(cpu, machine, &zynq_binfo);
 }
 
 static void zynq_machine_class_init(ObjectClass *oc, void *data)
-- 
2.34.1


