Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E70B4763903
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 16:25:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOeWr-00033V-7S; Wed, 26 Jul 2023 09:26:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1qOeWS-0002lN-ML; Wed, 26 Jul 2023 09:25:48 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1qOeWP-0003Id-VD; Wed, 26 Jul 2023 09:25:48 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-4fdddf92b05so10386526e87.3; 
 Wed, 26 Jul 2023 06:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690377944; x=1690982744;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/qANR99YnNIUbYven75G7/rKePRG7+0KMRhRw5KLj3k=;
 b=aI78jG1UP1L7FEB6zZcke26x5Jm0Je0XygsXLmZ0YSUE4N7I3OCZ4GhQVlDow0e2HA
 dEbpoLI+eQHpPS5xhbhk3MscozYIg2auyVl4WCeW2xNcU068db92HUSIyFyfgQcPMiEM
 uPCLvdWQkfxsehitO+MWA1ji9Q039F6o7CHVlVzJ1hqhEXuWeYt/hz4vpt33QjpVsbOi
 IhLqR6ORVYQ94GsFuCyVNAFiA8aR9i9NJP8YXaFlV3sWUzP5YpSEa8CXYr02ZvwH/Azm
 j/ayP1PIPr0OnC2R8wxfbP18IbDLdpK+ZyJJP3BPmrPI40etej4uA816z1xM3pX1k2W8
 9Ikg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690377944; x=1690982744;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/qANR99YnNIUbYven75G7/rKePRG7+0KMRhRw5KLj3k=;
 b=AhV6DD4L+uoPN478ONDHKqLTEE8WuPKbquEztEwR7Jcegzk0n0+Fnd61SFzvRZBg4Q
 bgKSCIQ8MKGlawxsHeoOWw7oNGUmSPvzYg0Cc1fDn31Q+9qNNV/mZMLkExM8sa+2We4r
 CQzSR7YMHo4rKuLvFCOGZqcyh6/U6RiPKCaNtvNcuQmwrcNWemRdk1qWj60GD5Cs9ums
 eB0Bog7RPMLMn3tjK2+gdSBpHuII7VDpBjH7DhBU1kDAy+dSfcZw6ABZawsqOsvspFP/
 rILtdCiYYfPG6qUCLEBlLw/pCSqt37kb4J2tiOCUVccvL+CvxzEsOZbs8I/CsIUa/NzQ
 mDhQ==
X-Gm-Message-State: ABy/qLawzQY10RuRfpZZL6rhqjxZwZJHZTOfKBtXfIS33IFORHGzMhPQ
 1Y4qHPb97wXpNRU4N5g8XBADeNidaOs=
X-Google-Smtp-Source: APBJJlFDOkDvjqPiSb3CTF+nBmpbw1SvvUMdTo1kdfrY/7KjbuV8Mxd/7voMeV5J14eKngkv8Fp00w==
X-Received: by 2002:a05:6512:3e7:b0:4f8:5f32:b1da with SMTP id
 n7-20020a05651203e700b004f85f32b1damr1375893lfq.24.1690377943737; 
 Wed, 26 Jul 2023 06:25:43 -0700 (PDT)
Received: from sergevik-thinkpad.localdomain ([213.197.136.186])
 by smtp.gmail.com with ESMTPSA id
 j22-20020a19f516000000b004fe0c3d8bb4sm565079lfb.84.2023.07.26.06.25.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jul 2023 06:25:43 -0700 (PDT)
From: Sergey Kambalin <serg.oker@gmail.com>
X-Google-Original-From: Sergey Kambalin <sergey.kambalin@auriga.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org,
	Sergey Kambalin <sergey.kambalin@auriga.com>
Subject: [PATCH 21/44] Add clock_isp stub
Date: Wed, 26 Jul 2023 16:24:49 +0300
Message-Id: <20230726132512.149618-22-sergey.kambalin@auriga.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230726132512.149618-1-sergey.kambalin@auriga.com>
References: <20230726132512.149618-1-sergey.kambalin@auriga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=serg.oker@gmail.com; helo=mail-lf1-x129.google.com
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
index e7a9db97ab..60ed535673 100644
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
 
@@ -224,6 +227,9 @@ static void bcm2838_peripherals_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion(get_system_memory(), PCIE_MMIO_ARM_OFFSET,
                                 &s->pcie_mmio_alias);
 
+    create_unimp(s_base, &s->clkisp, "bcm2835-clkisp", CLOCK_ISP_OFFSET,
+                 CLOCK_ISP_SIZE);
+
     /* GPIO */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio), errp)) {
         return;
diff --git a/include/hw/arm/bcm2838_peripherals.h b/include/hw/arm/bcm2838_peripherals.h
index bb26aceb13..be4fc20f11 100644
--- a/include/hw/arm/bcm2838_peripherals.h
+++ b/include/hw/arm/bcm2838_peripherals.h
@@ -72,6 +72,7 @@ struct BCM2838PeripheralState {
     BCM2838Rng200State rng200;
     Bcm2838ThermalState thermal;
     SDHCIState emmc2;
+    UnimplementedDeviceState clkisp;
     BCM2838PcieHostState pcie_host;
     BCM2838GpioState gpio;
 
-- 
2.34.1


