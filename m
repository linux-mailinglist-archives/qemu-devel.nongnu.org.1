Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A357082ACFE
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 12:10:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNssC-0001Ma-2U; Thu, 11 Jan 2024 06:05:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNss6-0001Kq-TR
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 06:05:15 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNss4-0004Nk-2C
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 06:05:14 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3375a236525so4180580f8f.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 03:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704971110; x=1705575910; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0GNFtYvCPWXBGX6d6WliU7kR2DeEivpmW78851S/hGQ=;
 b=LgwdZO7UKoofP5hQV533+Ut4VZGR9YwI25eryAgcyGtIzYFZlZk4D1Zzs14jIAUOjD
 7ZgexFrzliwlgnr1Xr69r4rT6G1WbPNqBToIG2r1D6RcSZ/Fu2apUiYrtvrbdu47Lwpg
 HFLBLy5cK17nfeToSt4DYJDB8NI/hjPMgZrtFXxInpMJChJH1mVxijymeCCecnufvvQX
 dseH/RX9WLQlBK7Ro2g62xVF2G6FPQuQUvHli59GI0IGNDM9lmKrzXVmtUf+bGkd9Gxa
 F3/YEtmz6v28LuUPbvQ3IqkjyLxt9MIMDDMToFe0Kq3xmiocKrANtMSopKBMuGhrQlLZ
 byCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704971110; x=1705575910;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0GNFtYvCPWXBGX6d6WliU7kR2DeEivpmW78851S/hGQ=;
 b=opKO16yDHEc8kts8hLmSiA1A1bl0eVWYKEPTiXsUSsKCh1I5TukWlkNV64Vqp2H7WJ
 84mqOoMbFi8/oQW9a4oQ+d9m+wi9w8E2SgXejY7NdoxwWb5WWRRMyPJqs+Sm9NLYzlbj
 HC6FT0J332FK2GCN8NBtuNmBH3zQrPYeK0Dkwg0+/aekQ18Fz5zsRZ2wBGjZMzIiwlQV
 z9qs0EwW2wv/ezRngbG3fGl4OaHxD+UVsmVIy6ovV0zmVcJxvklmNi7wZMQTgz4AzABZ
 98LL6Jq/pVVPaZQMPGp2od2ywO7EHnntB5kdW3XQCJX8WUag8pPAJjN7weMz8u7xqT75
 3uIQ==
X-Gm-Message-State: AOJu0YwaiOaWPTAkV4stzJ3V5cv2zZtUa8MOeJsDZ4qprmGbrJhXmr0H
 TPEHUdgC2cAIFejzO8IWKfa/ARIWYRfUPG9UGg+dVHGcBXk=
X-Google-Smtp-Source: AGHT+IHesHXzBIncFz28Ysb9BB5AwK7rMTkqunGD04l1O7X1Y7BgjLf9Ftb3jP/XpvEB/3tIXd2Vng==
X-Received: by 2002:a5d:6a46:0:b0:337:476f:9966 with SMTP id
 t6-20020a5d6a46000000b00337476f9966mr502493wrw.104.1704971110158; 
 Thu, 11 Jan 2024 03:05:10 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v30-20020adf8b5e000000b0033690139ea5sm951323wra.44.2024.01.11.03.05.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jan 2024 03:05:09 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/41] hw/arm: Add missing QOM parent for v7-M SoCs
Date: Thu, 11 Jan 2024 11:04:31 +0000
Message-Id: <20240111110505.1563291-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240111110505.1563291-1-peter.maydell@linaro.org>
References: <20240111110505.1563291-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

QDev objects created with qdev_new() need to manually add
their parent relationship with object_property_add_child().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20240104141159.53883-1-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/msf2-som.c          | 1 +
 hw/arm/netduino2.c         | 1 +
 hw/arm/netduinoplus2.c     | 1 +
 hw/arm/olimex-stm32-h405.c | 1 +
 hw/arm/stm32vldiscovery.c  | 1 +
 5 files changed, 5 insertions(+)

diff --git a/hw/arm/msf2-som.c b/hw/arm/msf2-som.c
index eb74b23797c..a269cf044b9 100644
--- a/hw/arm/msf2-som.c
+++ b/hw/arm/msf2-som.c
@@ -60,6 +60,7 @@ static void emcraft_sf2_s2s010_init(MachineState *machine)
     memory_region_add_subregion(sysmem, DDR_BASE_ADDRESS, ddr);
 
     dev = qdev_new(TYPE_MSF2_SOC);
+    object_property_add_child(OBJECT(machine), "soc", OBJECT(dev));
     qdev_prop_set_string(dev, "part-name", "M2S010");
     qdev_prop_set_string(dev, "cpu-type", mc->default_cpu_type);
 
diff --git a/hw/arm/netduino2.c b/hw/arm/netduino2.c
index 501f63a77f9..8b1a9a24379 100644
--- a/hw/arm/netduino2.c
+++ b/hw/arm/netduino2.c
@@ -44,6 +44,7 @@ static void netduino2_init(MachineState *machine)
     clock_set_hz(sysclk, SYSCLK_FRQ);
 
     dev = qdev_new(TYPE_STM32F205_SOC);
+    object_property_add_child(OBJECT(machine), "soc", OBJECT(dev));
     qdev_connect_clock_in(dev, "sysclk", sysclk);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
diff --git a/hw/arm/netduinoplus2.c b/hw/arm/netduinoplus2.c
index 2e589849478..bccd1003549 100644
--- a/hw/arm/netduinoplus2.c
+++ b/hw/arm/netduinoplus2.c
@@ -44,6 +44,7 @@ static void netduinoplus2_init(MachineState *machine)
     clock_set_hz(sysclk, SYSCLK_FRQ);
 
     dev = qdev_new(TYPE_STM32F405_SOC);
+    object_property_add_child(OBJECT(machine), "soc", OBJECT(dev));
     qdev_connect_clock_in(dev, "sysclk", sysclk);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
diff --git a/hw/arm/olimex-stm32-h405.c b/hw/arm/olimex-stm32-h405.c
index d793de7c97f..4ad7b043be0 100644
--- a/hw/arm/olimex-stm32-h405.c
+++ b/hw/arm/olimex-stm32-h405.c
@@ -47,6 +47,7 @@ static void olimex_stm32_h405_init(MachineState *machine)
     clock_set_hz(sysclk, SYSCLK_FRQ);
 
     dev = qdev_new(TYPE_STM32F405_SOC);
+    object_property_add_child(OBJECT(machine), "soc", OBJECT(dev));
     qdev_connect_clock_in(dev, "sysclk", sysclk);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
diff --git a/hw/arm/stm32vldiscovery.c b/hw/arm/stm32vldiscovery.c
index 190db6118b9..cc419351605 100644
--- a/hw/arm/stm32vldiscovery.c
+++ b/hw/arm/stm32vldiscovery.c
@@ -47,6 +47,7 @@ static void stm32vldiscovery_init(MachineState *machine)
     clock_set_hz(sysclk, SYSCLK_FRQ);
 
     dev = qdev_new(TYPE_STM32F100_SOC);
+    object_property_add_child(OBJECT(machine), "soc", OBJECT(dev));
     qdev_connect_clock_in(dev, "sysclk", sysclk);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
-- 
2.34.1


