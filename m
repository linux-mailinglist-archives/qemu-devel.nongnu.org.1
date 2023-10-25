Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF287D6201
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 08:59:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvXrR-0000Lq-S7; Wed, 25 Oct 2023 02:59:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvXrI-0000LL-05
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 02:59:16 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvXrG-0007pt-BW
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 02:59:15 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-9b9faf05f51so761999066b.2
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 23:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698217153; x=1698821953; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YzPUlHkDa7ZGEtBjlxYdFOPbay5a/eaftzCExJs7XYo=;
 b=xcMJpwRo6okEZ8YUkF0xzYx4Oisycq0zhckKT7NEElW4QV+RkeFV5B3YXOGg4xxg17
 h0plHcxaHcCTBPr4QAvOEANlEZ5yn70TNMxQYwzu0aZ9wQ6Q5HccoXRnhqpdi6jsyzCz
 zt/RlDaJU+HTUuCLHNZ5nS76r9mO3p1JNGfJ5oJbbatRyTU/bhwWlT+HfPfw1hIQlyrt
 LZx0fUaoleEarkdRvE9BZZKM/jwxPm5SL9FhmmQ+87D/Y1uKzQHfcDP/ZJD4UUuhPMyv
 gEO3/Qupb6ZRn9cmLjMGyDDptKhqKGXGz4kobE4w50VeFbyc1R15rMHxDUc7hQKkBOgH
 Cgeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698217153; x=1698821953;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YzPUlHkDa7ZGEtBjlxYdFOPbay5a/eaftzCExJs7XYo=;
 b=EqFR54+jaMZ0ms6uhTrsHCkrno4zjUVGHyZGldaIAY8eHNVUfCmjUzJJZ3GRwEqwR3
 c9u8QTeONyYQ8WCbjUSNb/e4NLj7E0WE/X+3aCKM+GG1gRN3Rh3w63nHNpoDebUyC22F
 b8xdi9w5HIlBY6iUU50GNRW8mreA4xrAHv6wQwRx8Cedh99mxq1MHlVP0mVDNqN65qHZ
 8t3D43isuNu4tgmUQ4JKPQrtL/n2yV74sgIW82L8mEY9Bpg2iu7/XYOeawaOOGG74qn8
 Q4dX7wR5Q1JEHEB/nAOpKMUHhZXKCmamUECiCVtsaXUTt1eDQEqzaiT6H0tTQjbYkPmp
 0HDg==
X-Gm-Message-State: AOJu0YwmOXu5SeoWQreTxKEAddBBJ3tVNDy1PbyhK+pdY868POWvtJsw
 n9Fgax05LjDvs/q50pd2DdrDZIbYrPPp4RuIlM4=
X-Google-Smtp-Source: AGHT+IEsaALLE46GxFyW/81xdFZH7oNav6Px5ouGogxti4B4zZIeJcyaK0woSITg1kPflggkOpkLFw==
X-Received: by 2002:a17:906:fd8b:b0:9ae:54c3:c627 with SMTP id
 xa11-20020a170906fd8b00b009ae54c3c627mr10825841ejb.71.1698217152803; 
 Tue, 24 Oct 2023 23:59:12 -0700 (PDT)
Received: from m1x-phil.lan (ghy59-h01-176-171-219-76.dsl.sta.abo.bbox.fr.
 [176.171.219.76]) by smtp.gmail.com with ESMTPSA id
 g15-20020a170906348f00b009c387ff67bdsm9322263ejb.22.2023.10.24.23.59.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Oct 2023 23:59:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
 Niek Linnenbank <nieklinnenbank@gmail.com>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] hw/arm: Avoid using 'first_cpu' when first ARM CPU is
 reachable
Date: Wed, 25 Oct 2023 08:59:09 +0200
Message-ID: <20231025065909.57344-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
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

Prefer using a well known local first CPU rather than a global one.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/bananapi_m2u.c   | 2 +-
 hw/arm/exynos4_boards.c | 7 ++++---
 hw/arm/orangepi.c       | 2 +-
 hw/arm/realview.c       | 2 +-
 hw/arm/xilinx_zynq.c    | 2 +-
 5 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/hw/arm/bananapi_m2u.c b/hw/arm/bananapi_m2u.c
index a7c7a9f96d..8f24b18d8c 100644
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
index ef5bcbc212..b0e13eb4f0 100644
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
index d0eca54cd9..f3784d45ca 100644
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
index 8f89526596..132217b2ed 100644
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
index 8dc2ea83a9..dbb9793aa1 100644
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
2.41.0


