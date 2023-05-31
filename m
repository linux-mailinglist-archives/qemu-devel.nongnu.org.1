Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D23718E94
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 00:34:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4UOG-0002WU-1Y; Wed, 31 May 2023 18:34:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4UOD-0002PI-Sh
 for qemu-devel@nongnu.org; Wed, 31 May 2023 18:33:57 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4UOA-00051o-5p
 for qemu-devel@nongnu.org; Wed, 31 May 2023 18:33:57 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3f6094cb2d2so1910315e9.2
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 15:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685572429; x=1688164429;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xkoRU3l97/30UWV/TA7AZTeSTQhuq1S7+Fh1SEZ9jOM=;
 b=YylBRMK/L9OS+eZBH7SnMJ6Pt7wA6dpH6UR6ds4CTy4tYK2Xd1Wt8KKi5S4R30tHNA
 ibjb7ijRdcBdFNcOkngju06IYvk3VTzSBF0N/owBwaXWoOWVSk7Be+Rqmx/f28usK1du
 lAZ4wsocPXbxHa2OnV7cj02bCsLooUKHK9VTn00o5AZpo/F5F+GdbBR2b5O5UUCrcOJ0
 lThIi+HcBY1m+KKLr5UJ0LtjsB4IXCWCfPb+WKc9neGGlBSmUP/oUZ10GlBo+5E93EYe
 bGaqj54wskmcuEtihxCpNfwrNfewVvU9lXmsRLDdjAttO0uGNutyeq2Ryp53yr9WF5e9
 SBWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685572429; x=1688164429;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xkoRU3l97/30UWV/TA7AZTeSTQhuq1S7+Fh1SEZ9jOM=;
 b=Z6faj7lVmwn5pZyaih5VG2HL9gsWY6hmnoPtQ+zBC7cvEpcfFYMxjFbi0RZ9uEqQh2
 PV4YMGdC4GfYKcy8ouCZ8husrHscj4FtM0zyC3+xgRfpfhLui5PbRxB/qasK4/O9PsBT
 fsymbTuhshzslR8+2xIAxcljeVNzBp2fhaiyAoMvhjkONVV7VQ8I2ffhPLt5OGBYkGT9
 88B00KPjocvrAu/l1DnX524qL8LJsq4me4UIPvb0YyQmJgRrX0IUFU1gaQoBzW7SEMtf
 r1Kjp7GnsaFXH/AIQnNcY9iEeAhdf41mbTIWytBTwbtLOympUQZStVOEqRDToEkv46Gf
 pfAg==
X-Gm-Message-State: AC+VfDzbIBo/Yirm+j7VZV/8BdN4F9Qxc/yu3XgYwYNABUhRLlcTVtnY
 E1GnL67mQfhYpiG+bJnhiZmyuBCFUywQ1CV3tPM=
X-Google-Smtp-Source: ACHHUZ7fHcdvt1cRQtWDzVbggSVAQNHbvaU1snF5j0WJgelxjBh8Hoetx6KkFi5F7qrIO7ssHuD4BQ==
X-Received: by 2002:a05:600c:378b:b0:3f6:1a9:b9db with SMTP id
 o11-20020a05600c378b00b003f601a9b9dbmr476000wmr.21.1685572429395; 
 Wed, 31 May 2023 15:33:49 -0700 (PDT)
Received: from localhost.localdomain ([176.176.146.12])
 by smtp.gmail.com with ESMTPSA id
 k15-20020a7bc40f000000b003f5ffba9ae1sm97659wmi.24.2023.05.31.15.33.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 31 May 2023 15:33:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/7] hw/arm/xlnx-versal: Do not open-code sysbus_connect_irq()
Date: Thu,  1 Jun 2023 00:33:35 +0200
Message-Id: <20230531223341.34827-2-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230531223341.34827-1-philmd@linaro.org>
References: <20230531223341.34827-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

The SYSBUS_DEVICE_GPIO_IRQ definition should be internal to
the SysBus API. Here we simply open-coded sysbus_connect_irq().
Replace to use the proper API.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/xlnx-versal.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 69b1b99e93..de5af506f7 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -704,9 +704,7 @@ static void versal_unimp(Versal *s)
                                 gpio_in);
 
     gpio_in = qdev_get_gpio_in_named(DEVICE(s), "irq-parity-imr-dummy", 0);
-    qdev_connect_gpio_out_named(DEVICE(&s->pmc.iou.slcr),
-                                SYSBUS_DEVICE_GPIO_IRQ, 0,
-                                gpio_in);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->pmc.iou.slcr), 0, gpio_in);
 }
 
 static void versal_realize(DeviceState *dev, Error **errp)
-- 
2.38.1


