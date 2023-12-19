Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D46318185C0
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 11:56:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFXlL-0003dr-H4; Tue, 19 Dec 2023 05:55:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <n.ostrenkov@gmail.com>)
 id 1rFXlE-0003dC-1q; Tue, 19 Dec 2023 05:55:40 -0500
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <n.ostrenkov@gmail.com>)
 id 1rFXl8-00082J-Ld; Tue, 19 Dec 2023 05:55:38 -0500
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-50e384cd6ebso2547621e87.3; 
 Tue, 19 Dec 2023 02:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702983326; x=1703588126; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lIRbGwXO6TvwI0IntgDTvlax6D6vei+jQDLXSTHmwHI=;
 b=KlP51azAP9zkUsdVrHvTf6KJHwzHTMu5C5ccWZAqmVG9UarVsr3v2icwr5abhyfRbt
 ABOx6W0lURqUs2KX+HzDKereY+c7WgBp1i1m0Q86zU+ODwc9YNnWUIOagOzfU6MAYjsK
 XqIIuXRsQ7LTpCFdqpH1z9wagkhLLmQ83IiDDu47HFm5xjuPiuLCBU1Lqs43UCI9MXZl
 ODHkynIyTa+rzhTq6wNbk3OjYZmhN9PM1LCdyKBdi4/cluPxP5TW8B42Gt1yawFghqau
 T1CmAW3RemNA5RAsJObwVw8PVPgwinYzxVxz5ge1XDmQ5G17QI6nDIKz3/yfdI5kMnZG
 Jm1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702983326; x=1703588126;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lIRbGwXO6TvwI0IntgDTvlax6D6vei+jQDLXSTHmwHI=;
 b=I3oI066zDk9n1p+ZqOkIqaHSGXY4IhASzm5jrT3k0SI5y1GK8Mk+XdhOcWWl/bsARb
 HRR3ZT+2mdRDkFdAdVjjxnxvR6Sbd+T3rTlTWLDx1UmQVIKEkDkOav1F5EKbKOwyyVJ+
 s+6Gf+5HyeIfbMQiiz0BhOLfwqkpG5CrxZDfInX61WxJ+1VWSeOHB7L0iZmSM4FwD9jR
 v9esxUXHDq29bIUgTETJeNkxIg2Hr/JqFmCmW27UWom7JYa+UHDJuzbyH1AfjuchpNcY
 QutKiyo76pt/DA5ZiOx5fLI6IyEgOHvHbm4g18tfp1T8L82JCjRrBblzYNQkudvGyMuy
 axdg==
X-Gm-Message-State: AOJu0YyspiTMXVdDtbnUweGgQrItR2vCIf6nnwplwGAhfwlH6RPW30uO
 +5NZkcrYHhvM9qknuiIdCC4vaR3ecBSld8/7
X-Google-Smtp-Source: AGHT+IFFi/e3Zzvnn4+eFMNZ5d0PpDrkkXc0bafZ/R0cwMa2fmre68LGvu8KzAIV5FjPLAnyY8ChSA==
X-Received: by 2002:a05:6512:4024:b0:50e:4444:b94b with SMTP id
 br36-20020a056512402400b0050e4444b94bmr504873lfb.101.1702983325684; 
 Tue, 19 Dec 2023 02:55:25 -0800 (PST)
Received: from localhost.localdomain ([176.120.189.69])
 by smtp.gmail.com with ESMTPSA id
 s16-20020a056512215000b0050be73a1c27sm3163749lfr.258.2023.12.19.02.55.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 02:55:25 -0800 (PST)
From: Nikita Ostrenkov <n.ostrenkov@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org,
 Nikita Ostrenkov <n.ostrenkov@gmail.com>
Subject: [PATCH] hw/arm: add cache controller for Freescale i.MX6
Date: Tue, 19 Dec 2023 10:55:10 +0000
Message-Id: <20231219105510.4907-1-n.ostrenkov@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=n.ostrenkov@gmail.com; helo=mail-lf1-x131.google.com
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

Signed-off-by: Nikita Ostrenkov <n.ostrenkov@gmail.com>
---
 hw/arm/Kconfig    | 1 +
 hw/arm/fsl-imx6.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 3ada335a24..386f06840c 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -536,6 +536,7 @@ config FSL_IMX6
     select IMX_I2C
     select IMX_USBPHY
     select WDT_IMX2
+    select PL310  # cache controller
     select SDHCI
 
 config ASPEED_SOC
diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
index 7dc42cbfe6..f56130a7a7 100644
--- a/hw/arm/fsl-imx6.c
+++ b/hw/arm/fsl-imx6.c
@@ -154,6 +154,9 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->a9mpcore), i + smp_cpus,
                            qdev_get_gpio_in(DEVICE(&s->cpu[i]), ARM_CPU_FIQ));
     }
+    
+    /* L2 cache controller */
+    sysbus_create_simple("l2x0", FSL_IMX6_PL310_ADDR, NULL);
 
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->ccm), errp)) {
         return;
-- 
2.34.1


