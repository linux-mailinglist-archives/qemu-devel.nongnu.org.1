Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D8B791B36
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 18:14:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdCDM-0004Bu-37; Mon, 04 Sep 2023 12:14:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdCDC-0003bT-8o
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 12:14:03 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdCD9-0007fn-WE
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 12:14:01 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-52c9be5e6f0so2037864a12.1
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 09:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693844037; x=1694448837; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1py6WJ7lyP7JjfX18bziMc96oyFqE8D3chzbCT/Lnv8=;
 b=MNd3w8XOTB9J+rzeWLWgsDrMqDCWYGGHhv5W9sS13eAhto5q8PYFGcP7boDYDASpUF
 Q3YLHb1B3TJAX5Bt0XaPrjvmlYh45s3cmHxpJbKWXomblQz9QfJ6KRVscy0yZgt+G2LJ
 WdG8HIOZc1Mu8icYy335Temn2aUFP8LnOqBKTQzYyq3YJwcMHTuWQw1yZ45BC+w1cX1g
 PWXaViyIrcx1xr2FkdwNjp3N0iP+/uuk4OM9eY2Vt5T/K+rDerjCn/LPOArVDryG2DG2
 P/i2012cSyQR2HSToDcXRfQR600ud6prMgyVJsosAltiG7tCx/uKlXOcLjeRnj2AnlV+
 hdSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693844037; x=1694448837;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1py6WJ7lyP7JjfX18bziMc96oyFqE8D3chzbCT/Lnv8=;
 b=LLOS/YJGeovqFRYCozacULZW6ev9xHCLUeKzAPo+Xud9xELvk0w96JUyyZP+Mb7MYJ
 m5ZheJa3j167Da0V0AkbwhWX/PBfgkyZPdPCb/mTY9t7Dr3O1DQ6i2iy2sCx/zh78BMf
 b8IARjTpd/xiKgZrfarlf6Xctai7z2O/EjAh8qkU97R2zGxdsSHpO2WGlCD0VqB67cls
 nFHGzr+U1mtY84V5r6ExXw/EfWZ8sqwV/fdDZCtavkVjFzQnQ0cYYzEbtstLfPJ0LWTA
 o9E90PiXGqMPhi2uVSxTah+IDzZyzyMkFb6giJ4InT0mglSnTM3kqZvCPwZ4AF4AbxPw
 7XVw==
X-Gm-Message-State: AOJu0YztW7lMyFVFvxgQvUMC4Mf5UvY3Aa2xyhzfQXvdzIYLQWD43lux
 rJtvSGGdq28Fc6XQdSn+ilvb78CIRMB8CfjxHMg=
X-Google-Smtp-Source: AGHT+IHjjSJOIGAoHuJdRwcZPVmjj08ii4SeZiRHQe5tto31wArJKX9Uk1qnnn7mA27fG3HUacFxQQ==
X-Received: by 2002:a17:906:70d6:b0:9a1:6318:4d39 with SMTP id
 g22-20020a17090670d600b009a163184d39mr7494768ejk.29.1693844037451; 
 Mon, 04 Sep 2023 09:13:57 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.227])
 by smtp.gmail.com with ESMTPSA id
 xo9-20020a170907bb8900b0099cbe71f3b5sm6306309ejc.0.2023.09.04.09.13.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 04 Sep 2023 09:13:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Markus Armbruster <armbru@redhat.com>,
	qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Chris Wulff <crwulff@gmail.com>, Marek Vasut <marex@denx.de>
Subject: [PATCH v2 14/22] hw/nios2: Clean up local variable shadowing
Date: Mon,  4 Sep 2023 18:12:26 +0200
Message-ID: <20230904161235.84651-15-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230904161235.84651-1-philmd@linaro.org>
References: <20230904161235.84651-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Fix:

  hw/nios2/10m50_devboard.c: In function ‘nios2_10m50_ghrd_init’:
  hw/nios2/10m50_devboard.c:101:22: warning: declaration of ‘dev’ shadows a previous local [-Wshadow=compatible-local]
    101 |         DeviceState *dev = qdev_new(TYPE_NIOS2_VIC);
        |                      ^~~
  hw/nios2/10m50_devboard.c:60:18: note: shadowed declaration is here
     60 |     DeviceState *dev;
        |                  ^~~

  hw/nios2/10m50_devboard.c:110:18: warning: declaration of ‘i’ shadows a previous local [-Wshadow=compatible-local]
    110 |         for (int i = 0; i < 32; i++) {
        |                  ^
  hw/nios2/10m50_devboard.c:67:9: note: shadowed declaration is here
     67 |     int i;
        |         ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/nios2/10m50_devboard.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/nios2/10m50_devboard.c b/hw/nios2/10m50_devboard.c
index 91383fb097..952a0dc33e 100644
--- a/hw/nios2/10m50_devboard.c
+++ b/hw/nios2/10m50_devboard.c
@@ -98,7 +98,7 @@ static void nios2_10m50_ghrd_init(MachineState *machine)
     qdev_realize_and_unref(DEVICE(cpu), NULL, &error_fatal);
 
     if (nms->vic) {
-        DeviceState *dev = qdev_new(TYPE_NIOS2_VIC);
+        dev = qdev_new(TYPE_NIOS2_VIC);
         MemoryRegion *dev_mr;
         qemu_irq cpu_irq;
 
@@ -107,7 +107,7 @@ static void nios2_10m50_ghrd_init(MachineState *machine)
 
         cpu_irq = qdev_get_gpio_in_named(DEVICE(cpu), "EIC", 0);
         sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, cpu_irq);
-        for (int i = 0; i < 32; i++) {
+        for (i = 0; i < 32; i++) {
             irq[i] = qdev_get_gpio_in(dev, i);
         }
 
-- 
2.41.0


