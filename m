Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A6280290C
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 00:43:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r9w6t-0007BD-DH; Sun, 03 Dec 2023 18:42:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1r9w6l-00075E-P3; Sun, 03 Dec 2023 18:42:43 -0500
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1r9w6k-0002mV-6B; Sun, 03 Dec 2023 18:42:43 -0500
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-5d4f71f7e9fso24013537b3.0; 
 Sun, 03 Dec 2023 15:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701646960; x=1702251760; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wh1QnDZocCaPOy/8crynrl25nM9IxATZq1B+Q2/YqWE=;
 b=g0+NHeMMHjVYJcRXiXdGUp/F7V1IvXDQ5BeUvxv4kIsWn7uTly12Zkz1NwiCwaJ8YK
 gK81Am+c5gv5n/PHQGqD4v6U1nU691NsBUch0O9qONhcwRSa32RuJQGVTH570Z4+LlAX
 DQ0YZL0TH9y6Zco9sMez8VV+94cieAgDdIP8fT/P9uZfFCZz3gRqDihdEfHC2OdnG0H4
 7N5cznfe5cRxAjDpFZMYHadGttQEH61XdTW4FOhWBeTVaiTJtZOXx9Dhe8ClihyJ2xYc
 fH7k4s5EGa7iLosl2ZDywk+Q9lUe2HWKVIkmTY4NoCMUlKR2YOc6I5665WZHjQv6b2oN
 ySGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701646960; x=1702251760;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wh1QnDZocCaPOy/8crynrl25nM9IxATZq1B+Q2/YqWE=;
 b=Y4yVFDQ5/+pUHbBz4GD0Iar6vIu57U+fs1XAjSoV6bkO4T8fKjpDiG3HcwWZyFYQyr
 YCjThOtBhWlB9PVgT6pHsH7GQAZvAWPwQnhBJD4m5/9SsDlRKbU5UtBAVSuK+ISTRTNS
 D4PYQmRHmzQmsATKJEGwSC2ryuagzH6Rgx44pZu0ABY8lBN3Yr0KiqllQfl8/jShq7jA
 DH+mW0JVYZ9zYN/XhwZCLc8ogzPMnKEKJjCogFPjSUSI2heRY/Xyr4WLhcXQm6Yo1P2I
 K2Ttcvb4X+yVBnI9mP0vOV7EMXKwvHcEh19CSZEd5EpPnzMI65EYeN0BphDK8zhqJzAu
 kj+Q==
X-Gm-Message-State: AOJu0Yxmq8F57quhKUyVDZtjfsvQUNC4RHJxMmK4qD5qWxCjlBMmBSKx
 x4j5BqnRgvC7srEwAJlss1sIaf8MVBOaDg==
X-Google-Smtp-Source: AGHT+IED4yJR4TXCTsiMXkIAnUKM4zW7tDl/7goY9fymSLMZRm6LgtTfYO5o3G238+YDx5xJYjLWgA==
X-Received: by 2002:a05:690c:c0d:b0:5d7:545e:3bda with SMTP id
 cl13-20020a05690c0c0d00b005d7545e3bdamr1610512ywb.20.1701646960014; 
 Sun, 03 Dec 2023 15:42:40 -0800 (PST)
Received: from localhost.localdomain ([201.206.180.22])
 by smtp.gmail.com with ESMTPSA id
 c126-20020a0dda84000000b005d718fff165sm1536299ywe.78.2023.12.03.15.42.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Dec 2023 15:42:39 -0800 (PST)
From: Sergey Kambalin <serg.oker@gmail.com>
X-Google-Original-From: Sergey Kambalin <sergey.kambalin@auriga.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org,
	Sergey Kambalin <sergey.kambalin@auriga.com>
Subject: [PATCH v3 21/45] Add clock_isp stub
Date: Sun,  3 Dec 2023 17:41:49 -0600
Message-Id: <20231203234213.1366214-22-sergey.kambalin@auriga.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230726132512.149618-1-sergey.kambalin@auriga.com>
References: <20230726132512.149618-1-sergey.kambalin@auriga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=serg.oker@gmail.com; helo=mail-yw1-x1130.google.com
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


