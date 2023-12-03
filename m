Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9C6802829
	for <lists+qemu-devel@lfdr.de>; Sun,  3 Dec 2023 22:54:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r9uLV-0003Gw-Vh; Sun, 03 Dec 2023 16:49:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1r9uLP-00037d-3P; Sun, 03 Dec 2023 16:49:43 -0500
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1r9uLN-0008NC-Ci; Sun, 03 Dec 2023 16:49:42 -0500
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-5d747dbf81eso10141367b3.1; 
 Sun, 03 Dec 2023 13:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701640180; x=1702244980; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wh1QnDZocCaPOy/8crynrl25nM9IxATZq1B+Q2/YqWE=;
 b=guC7ro8PC/C9wP9nEPOgeuwOF1Fy02HqP+DSbU+1has4IsA/lRVznrdl8YNMjSI1Mf
 SC5bzxoNswq+cR+FL0KLsD1kEiSDqnxgO7zmowgj/HBSDr6qir3Yb2I4eiTO3z1mWSjP
 4jrGOeoZq9jiG59RfaOZrK1jZhzXD4Z6t2bO6DyCK443JHJk5SFDZlAQBMERF8ytZNtV
 2AXkVjUkOnOBDmh1bnjhKcwcy+xp1rVOBYQZmxQnlYa0zG9EhbXb26la49h2AWUhApll
 e/hUN6RZFdD6AhXVKsIyxXq3Jbe3ZKQIQFc658Z7FFdRcjsg+UGKRBPy2rF/t92Z2Fe8
 clPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701640180; x=1702244980;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wh1QnDZocCaPOy/8crynrl25nM9IxATZq1B+Q2/YqWE=;
 b=LFVe8aJWt4awHL6U+OWl03mwMZTmIILzAvYqqBO5/qJzgeDXTDX4NaDV4vBZqNkJHr
 dtnNuArUyn1JtNvIQDJVUorBvJQ9BoYfGh6TbZ1NPIKAzns7kQtiR2Sk11YhmLY/BVeH
 xRF9YBtXHi6w/XS518GMt9HrvyPg+HHh2R8iSKN7Q3bMLl7K8f9OTVaObYr/qhQ8PUsj
 mIn7juIImdiDgPlyPVMoVS6KhYs1hjr8pR+uZFnPRgY4vJRAW1IOcj87mEc/5rBLjp9F
 rFBlFLhE687CsBt5i8/yZEdv2FzFMjiO2I5s2kbAZ8nA7TwfR1LNxC0vIRbTkFMk6BhI
 WmbA==
X-Gm-Message-State: AOJu0YyBLAfFxbHjALzE2v/dbWyeKO7h6nhsUYP/Br3l/dk/I6Lst8aI
 cxvcaqVqpF+KmtFC/ypT2yJC2hREPs46ZQ==
X-Google-Smtp-Source: AGHT+IEVgzSGzoOhF7ygeqpAjzv7+Ns7EpYarGRYmh5dFyeqKjl1EHcdchQB3ZISIZ5RvAuaRCYhng==
X-Received: by 2002:a81:c80a:0:b0:5d7:1941:ac6 with SMTP id
 n10-20020a81c80a000000b005d719410ac6mr2150657ywi.97.1701640179719; 
 Sun, 03 Dec 2023 13:49:39 -0800 (PST)
Received: from localhost.localdomain ([201.206.180.22])
 by smtp.gmail.com with ESMTPSA id
 z2-20020a816502000000b00597e912e67esm2832788ywb.131.2023.12.03.13.49.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Dec 2023 13:49:39 -0800 (PST)
From: Sergey Kambalin <serg.oker@gmail.com>
X-Google-Original-From: Sergey Kambalin <sergey.kambalin@auriga.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org,
	Sergey Kambalin <sergey.kambalin@auriga.com>
Subject: [PATCH v3 21/45] Add clock_isp stub
Date: Sun,  3 Dec 2023 15:48:46 -0600
Message-Id: <20231203214910.1364468-22-sergey.kambalin@auriga.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231203214910.1364468-21-sergey.kambalin@auriga.com>
References: <20230726132512.149618-1-sergey.kambalin@auriga.com>
 <20231203214910.1364468-1-sergey.kambalin@auriga.com>
 <20231203214910.1364468-2-sergey.kambalin@auriga.com>
 <20231203214910.1364468-3-sergey.kambalin@auriga.com>
 <20231203214910.1364468-4-sergey.kambalin@auriga.com>
 <20231203214910.1364468-5-sergey.kambalin@auriga.com>
 <20231203214910.1364468-6-sergey.kambalin@auriga.com>
 <20231203214910.1364468-7-sergey.kambalin@auriga.com>
 <20231203214910.1364468-8-sergey.kambalin@auriga.com>
 <20231203214910.1364468-9-sergey.kambalin@auriga.com>
 <20231203214910.1364468-10-sergey.kambalin@auriga.com>
 <20231203214910.1364468-11-sergey.kambalin@auriga.com>
 <20231203214910.1364468-12-sergey.kambalin@auriga.com>
 <20231203214910.1364468-13-sergey.kambalin@auriga.com>
 <20231203214910.1364468-14-sergey.kambalin@auriga.com>
 <20231203214910.1364468-15-sergey.kambalin@auriga.com>
 <20231203214910.1364468-16-sergey.kambalin@auriga.com>
 <20231203214910.1364468-17-sergey.kambalin@auriga.com>
 <20231203214910.1364468-18-sergey.kambalin@auriga.com>
 <20231203214910.1364468-19-sergey.kambalin@auriga.com>
 <20231203214910.1364468-20-sergey.kambalin@auriga.com>
 <20231203214910.1364468-21-sergey.kambalin@auriga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=serg.oker@gmail.com; helo=mail-yw1-x1132.google.com
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


