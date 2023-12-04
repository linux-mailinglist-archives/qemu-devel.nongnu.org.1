Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4801C80298E
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 01:36:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r9wnr-0004s6-Ud; Sun, 03 Dec 2023 19:27:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1r9wnW-0004YS-Li; Sun, 03 Dec 2023 19:26:56 -0500
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1r9wnT-0000BF-Ix; Sun, 03 Dec 2023 19:26:53 -0500
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-5d747dbf81eso10813467b3.1; 
 Sun, 03 Dec 2023 16:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701649610; x=1702254410; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wh1QnDZocCaPOy/8crynrl25nM9IxATZq1B+Q2/YqWE=;
 b=ck3n9HSCwwyqar7+iwQKV8wTcix74G3eIzy4yME6CWC/pk0OGBzHZbu8pcNICn4iP1
 qpiTP/MZXr7WgYVCwFI6M5BRA/PqL66w2wozM7Y0wKp1lyliBhzSP/F6gtH2+VNM7DPy
 l1DWHwxu8xIu26vmbSX3aYH1MqqTKCpBvZg8/LYeYe6a3jLXJRFn4+KgoR0iLg540Z9G
 ygaeWYjDHx0JrpwnGJ/9mZxF9kUk4pGdABzj8qeRalQhEIGL8WbZRKUGnF5ZQQvH7N4o
 IkMCAGGd/yGxAy02NAJ/riEKVbVixLcADExaRaZj0WyY7D+O9QThkHuMrGS272HzqEz7
 YY7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701649610; x=1702254410;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wh1QnDZocCaPOy/8crynrl25nM9IxATZq1B+Q2/YqWE=;
 b=Y8LV2sfkm05Vgzudb/xr0hpPh8rNNZu8V/JV/JM4m+nykr3D7INv6DqYFkLavNxWsy
 tNX2TwZy19PXIZ7OfCHhw3dpcKroqnxp0kUkCNblAKWW6QW3TeEv8QbKYzh75OoqGBXm
 9lEnZfkGTkiy/EkIJkYK0zo7eJ6MzdTHKgiXv0VDVzfOeeyEex5Ow1B2QdK1lK/XrxxJ
 ye8P72GtL7MyE/ReVxNKRNejl19ZkbcJYQd6j2DuwiR/y4WXih9mgZBzIapStflWcAbu
 382WeB5Cz01FZBHjrVqxqabIYjiymVMoezk0VCsRbd5CfhEyXLXvoGZYmR16f9QjYLEP
 lA2Q==
X-Gm-Message-State: AOJu0YwlDP5N1fIXtTKEio4PMXRFI3MN27E9PUNGqtXVszUatyx346bC
 ArI1jG8NHKjOsxD0hfJHM5SgyQfJ51FTmA==
X-Google-Smtp-Source: AGHT+IFATBwFEdExV1tOqKcf3C3O59SI5tfvvY/ErXrLFMez8p142VsDpGVva8N7qeYdJUKLa3Efig==
X-Received: by 2002:a81:830f:0:b0:5d7:1941:ac9 with SMTP id
 t15-20020a81830f000000b005d719410ac9mr2211587ywf.100.1701649609980; 
 Sun, 03 Dec 2023 16:26:49 -0800 (PST)
Received: from localhost.localdomain ([201.206.180.22])
 by smtp.gmail.com with ESMTPSA id
 l63-20020a0de242000000b005d3e6ce07e7sm2443187ywe.6.2023.12.03.16.26.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Dec 2023 16:26:49 -0800 (PST)
From: Sergey Kambalin <serg.oker@gmail.com>
X-Google-Original-From: Sergey Kambalin <sergey.kambalin@auriga.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org,
	Sergey Kambalin <sergey.kambalin@auriga.com>
Subject: [PATCH v3 21/45] Add clock_isp stub
Date: Sun,  3 Dec 2023 18:25:55 -0600
Message-Id: <20231204002619.1367044-22-sergey.kambalin@auriga.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231204002619.1367044-1-sergey.kambalin@auriga.com>
References: <20231204002619.1367044-1-sergey.kambalin@auriga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=serg.oker@gmail.com; helo=mail-yw1-x112b.google.com
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


