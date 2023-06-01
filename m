Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F355719795
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 11:48:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4etD-0004hk-Fa; Thu, 01 Jun 2023 05:46:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4etB-0004h7-Oa
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 05:46:37 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4et9-0004Bd-Dw
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 05:46:37 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-3f606912ebaso6755995e9.3
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 02:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685612794; x=1688204794;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vY/PoCZ3Ec5EYMAMd5EtE2RxWZcVnX6V92z8a0JGnWI=;
 b=xbOS1AhFoorwp4b4xkMClFMty4NklH1wCrWv+kCAtiFdYRyn8TNuqgfafNInrS8SGp
 M0ia6xiUYJK6sOQAPUc5ayfUtQcTOUsVWIA7eIKxtS+F/HIIVTkuZsBfJFimOY6OQAxv
 Mew98DkL9m/WUK/r+SoOfCygw6IUUONs+tXAcl64BGwOgFb2lCyWzRUhKdP8FRTxE7B3
 yMzG4bUosPDD+vEo+x4U1It4gHn81ZJseCqG0Po7ne65TuR80CcIEDpJ9Z4Z5NYTGqs9
 r9Y0aiFPx+mPbT0TEhoKO+CDvl4OMh2ZgWh4tsbDLQOg6tEPj/4IBjxpElfSegibSk68
 j4zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685612794; x=1688204794;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vY/PoCZ3Ec5EYMAMd5EtE2RxWZcVnX6V92z8a0JGnWI=;
 b=lORIO2BkSjxzZxAtrCyAoGBg2K3AS4JRWI0XwyZ4qiIyCygm4u4H9bxnMOM9CApemZ
 q+zJ87PJeYFIuGYRDmHY6qVXlwDcDcLATFpJsNRPt/gtPYCUcgqUc7emGWw3E8noc8ts
 euLIMO9c20C9xMJHsAJZe7BuDa3gbtdyNUQThjALNuKwhddY+l7VJtyE9qosRbCoUi14
 o8dZaewEfJJ6ZPLc0C7EvBoMwmiZfEI3CE6wsvXIhqC0N1rOv9chQGVIhNXJHUTfDfHd
 B597titCN318mNQrBc42P+FsD+N8HhuN9PBeGOZsUEdip7HNDIBmyGd+c2LhPmakr6R0
 fncA==
X-Gm-Message-State: AC+VfDx8v633NUfb9eny4UeJrqIoc//pnBkJR9/jnDBIPoLYTapYLpdZ
 EN/1Tp5dH/urL+K6+c3nG67MwPtUPnlsaum/dvU=
X-Google-Smtp-Source: ACHHUZ7oiKq5icPbeSO2Lui18+Bo9iPjDQK+7+W3OemN5R34TJOEEkd6+aYCjV1cAWMzi+yt4jfQmg==
X-Received: by 2002:a7b:cd15:0:b0:3f4:21ff:b91f with SMTP id
 f21-20020a7bcd15000000b003f421ffb91fmr1305050wmj.28.1685612793736; 
 Thu, 01 Jun 2023 02:46:33 -0700 (PDT)
Received: from localhost.localdomain ([176.176.141.224])
 by smtp.gmail.com with ESMTPSA id
 k7-20020a05600c0b4700b003f4f89bc48dsm1709017wmr.15.2023.06.01.02.46.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 01 Jun 2023 02:46:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-ppc@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 1/7] hw/arm/xlnx-versal: Do not open-code
 sysbus_connect_irq()
Date: Thu,  1 Jun 2023 11:46:19 +0200
Message-Id: <20230601094625.39569-2-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230601094625.39569-1-philmd@linaro.org>
References: <20230601094625.39569-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/arm/xlnx-versal.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index db1e0dee6e..79133afa71 100644
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


