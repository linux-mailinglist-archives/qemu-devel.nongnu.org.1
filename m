Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EB652809959
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Dec 2023 03:39:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBQfy-0004hQ-VZ; Thu, 07 Dec 2023 21:33:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1rBQfs-0004Vw-Hh; Thu, 07 Dec 2023 21:33:08 -0500
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1rBQfq-0002YS-Rf; Thu, 07 Dec 2023 21:33:08 -0500
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2c9f413d6b2so18989141fa.1; 
 Thu, 07 Dec 2023 18:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702002784; x=1702607584; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wh1QnDZocCaPOy/8crynrl25nM9IxATZq1B+Q2/YqWE=;
 b=AVgZaeuG0nP/Tk2ImFCKVtinLGwEUtLuWnxLLaRqcAR+lZv+GijSuHkdiAEhlbEZlN
 aEzzXXFx77Wx4B7dw+tuvLJSBAFhItDTc6StFReZeVktCE1mk9mAqRy3oZySF9mS0Sm0
 tZfDU6AFzW/UNv149jsw74vVuWIRws0Aik8n6XOrTGa8Xw2G4w0AazabGdCbukmJa0Qw
 +G9d0pr2t0hSrKGb80F/5YzCctJsegjS0eXgw+iEd8J/3rYDW0jUR9Xis/CodjByciaF
 V9D8tRHch6Icxm2aAT6YeFSOBBNAyqTOLZiFQ9s8hnUU7MeRfxButwcWj+mzYMQ4YVb4
 R4Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702002784; x=1702607584;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wh1QnDZocCaPOy/8crynrl25nM9IxATZq1B+Q2/YqWE=;
 b=FM4vd3tWmrPQsIOyqIvDuk+VkcPQRRAloLpgKy9XTQR1UeYX6RBhOQ1rIOhe38wYJu
 cqUC1Opf9zbb63lGK9letcxteqiy0xTXsG9yQB6Bzbiqvqci+JuCPxZpe9X3N1NyNzM2
 jiBSi0xtFWcTTo+AD0P9mbGG5uxcvbF8wxtyRnFn+QI3VuQ1paZJyAkucaQHLRJ8hsit
 yzhPloGpvKsdYy5QxqZK3Z5ES8DEf+C6ETBqLa6aba1f0Wya73Vpob/vkpAiVOCp0bGO
 3bsG6u05vRCCMq4M++WQeuXQ5Lx68CRh2hh9CDcxWgitaNhAMq/O3kWVr0StcHFy6lgZ
 Dw9A==
X-Gm-Message-State: AOJu0YzjhV2OkL6rWoF5N9eUi01jVj66ZT4vmHFGcK2PSRQN5go9BwaR
 2qNd2T4oniEYqcR4LyTzhIwFBR0hI3kGUQ==
X-Google-Smtp-Source: AGHT+IGYdgKflwvrlDnZYJKsQ+TtV0wHPTTIOKWTz9kXaUmfnim+MRg/hK4QV1RHKxoH2h+jQsNryw==
X-Received: by 2002:a2e:97d3:0:b0:2ca:18de:126b with SMTP id
 m19-20020a2e97d3000000b002ca18de126bmr1480986ljj.43.1702002784428; 
 Thu, 07 Dec 2023 18:33:04 -0800 (PST)
Received: from localhost.localdomain ([185.200.240.39])
 by smtp.gmail.com with ESMTPSA id
 r1-20020a2e94c1000000b002c9e6cbf78esm99062ljh.19.2023.12.07.18.33.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Dec 2023 18:33:03 -0800 (PST)
From: Sergey Kambalin <serg.oker@gmail.com>
X-Google-Original-From: Sergey Kambalin <sergey.kambalin@auriga.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org,
	Sergey Kambalin <sergey.kambalin@auriga.com>
Subject: [PATCH v4 21/45] Add clock_isp stub
Date: Thu,  7 Dec 2023 20:31:21 -0600
Message-Id: <20231208023145.1385775-22-sergey.kambalin@auriga.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231208023145.1385775-1-sergey.kambalin@auriga.com>
References: <20231208023145.1385775-1-sergey.kambalin@auriga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=serg.oker@gmail.com; helo=mail-lj1-x233.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
---
 hw/arm/bcm2838_peripherals.c         | 6 ++++++
 include/hw/arm/bcm2838_peripherals.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/hw/arm/bcm2838_peripherals.c b/hw/arm/bcm2838_peripherals.c
index e9c6d47ba6..65a659c15c 100644
--- a/hw/arm/bcm2838_peripherals.c
+++ b/hw/arm/bcm2838_peripherals.c
@@ -17,6 +17,9 @@
 #define PCIE_MMIO_ARM_OFFSET    0x600000000
 #define PCIE_MMIO_SIZE          0x40000000
 
+#define CLOCK_ISP_OFFSET        0xc11000
+#define CLOCK_ISP_SIZE          0x100
+
 /* Lower peripheral base address on the VC (GPU) system bus */
 #define BCM2838_VC_PERI_LOW_BASE 0x7c000000
 
@@ -228,6 +231,9 @@ static void bcm2838_peripherals_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion(get_system_memory(), PCIE_MMIO_ARM_OFFSET,
                                 &s->pcie_mmio_alias);
 
+    create_unimp(s_base, &s->clkisp, "bcm2835-clkisp", CLOCK_ISP_OFFSET,
+                 CLOCK_ISP_SIZE);
+
     /* GPIO */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio), errp)) {
         return;
diff --git a/include/hw/arm/bcm2838_peripherals.h b/include/hw/arm/bcm2838_peripherals.h
index 0e8465ba34..20b7d1eb67 100644
--- a/include/hw/arm/bcm2838_peripherals.h
+++ b/include/hw/arm/bcm2838_peripherals.h
@@ -70,6 +70,7 @@ struct BCM2838PeripheralState {
     BCM2838Rng200State rng200;
     Bcm2838ThermalState thermal;
     SDHCIState emmc2;
+    UnimplementedDeviceState clkisp;
     BCM2838PcieHostState pcie_host;
     BCM2838GpioState gpio;
 
-- 
2.34.1


