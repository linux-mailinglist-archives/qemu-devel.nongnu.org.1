Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A9882ACFB
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 12:10:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNss8-0001Kv-BP; Thu, 11 Jan 2024 06:05:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNss4-0001Jw-S1
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 06:05:12 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNss1-0004N3-Qg
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 06:05:12 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3374eb61cbcso4674105f8f.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 03:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704971107; x=1705575907; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MdZwmTLITE8hM1960RQmf+O/Y15HZKpOylRTPJryBDk=;
 b=qkVW2vZ3aU/PhGkaOGoao9R6aq68PcAuA+uIwBW36uN/8L+TCHNZIYf4VTYHgguGks
 bFz6rrv4Fy0fbW4bjzoLwua+C6va4a+n0Iuc8Ch3qeLcpYOb0Rc4pMACX6wQCqCjF6Jp
 wroJCR6fXJwUNYctoID4y+UiTEGnPjpkVflNVHA4dbUa2asQwjkvA6/P23/AvLBisbAM
 oWORuMg/+frXngB5hYnRU2rMvpWK+CVDURMvXkrZyON+bP6lfCgxeOk5ZmbOHEQgdnVc
 KbXX+HOD37r1DzSnq0JhxwSp2GEK5NI/xEvJNCAlmfNMzv9S/Q6Wt/BoZkugTu+SnOoY
 cTTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704971107; x=1705575907;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MdZwmTLITE8hM1960RQmf+O/Y15HZKpOylRTPJryBDk=;
 b=kTDNPWoYDnehaJy/Bm6H1Ptr6OQOIse9HZ19Q+BVXeAu5ut94zEgw1DcKHAvAXLewi
 QTR/KEX7zQt1k1Qr5kiJ0Nk2eQKaTWj9+OJAudBy9XtVbhvCB4XGCu8KaQL+4XV27LVS
 tl0YWpxPZWh/XXxk4CRTqN6fu3eLLttUCrrIOR7smYwALsfSnhhO/YW6r0j+Vw4PD/WS
 NfW9Q+KZfSVvEGTs4QjCIzRZ2EWHSXfSIDpkmVu8JBN6GFCFEZjNZ0S2nSCZYcFltzqi
 G5hap32y6RUaWlSkjM6uFVXCXQz4viICjiHj6+XiHKw+exnGb/YF0Nmq/VAj+fGtwbL5
 lT+Q==
X-Gm-Message-State: AOJu0YxzGbg7iafPyZljP1PSdhSsPI3K/trRq6g7SiP1pVg5tBVusF7/
 VuM7AKVhxYOVfoBHnBcEyw3+ZTDdEL+Osx6omv3nxYXmfqY=
X-Google-Smtp-Source: AGHT+IGu89YwMtdCi41Bi0dSZSvqIkhmyDo8aKEvejO8MfjcrCZBhCwU+Uc3GpctDOE6oDyn1Kj1rQ==
X-Received: by 2002:adf:ce83:0:b0:336:7790:6a36 with SMTP id
 r3-20020adfce83000000b0033677906a36mr542240wrn.129.1704971107649; 
 Thu, 11 Jan 2024 03:05:07 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v30-20020adf8b5e000000b0033690139ea5sm951323wra.44.2024.01.11.03.05.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jan 2024 03:05:07 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/41] hw/arm: add cache controller for Freescale i.MX6
Date: Thu, 11 Jan 2024 11:04:25 +0000
Message-Id: <20240111110505.1563291-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240111110505.1563291-1-peter.maydell@linaro.org>
References: <20240111110505.1563291-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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

From: Nikita Ostrenkov <n.ostrenkov@gmail.com>

Signed-off-by: Nikita Ostrenkov <n.ostrenkov@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20231219105510.4907-1-n.ostrenkov@gmail.com
[PMM: fixed stray whitespace]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/fsl-imx6.c | 3 +++
 hw/arm/Kconfig    | 1 +
 2 files changed, 4 insertions(+)

diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
index b2153022c04..af2e982b052 100644
--- a/hw/arm/fsl-imx6.c
+++ b/hw/arm/fsl-imx6.c
@@ -154,6 +154,9 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
                            qdev_get_gpio_in(DEVICE(&s->cpu[i]), ARM_CPU_FIQ));
     }
 
+    /* L2 cache controller */
+    sysbus_create_simple("l2x0", FSL_IMX6_PL310_ADDR, NULL);
+
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->ccm), errp)) {
         return;
     }
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 660f49db498..b853577e725 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -537,6 +537,7 @@ config FSL_IMX6
     select IMX_I2C
     select IMX_USBPHY
     select WDT_IMX2
+    select PL310  # cache controller
     select SDHCI
 
 config ASPEED_SOC
-- 
2.34.1


