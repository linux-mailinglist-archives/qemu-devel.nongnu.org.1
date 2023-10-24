Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA637D582C
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 18:26:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvKDl-0002F1-6M; Tue, 24 Oct 2023 12:25:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvKDW-0001hq-9d
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 12:25:21 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvKDT-0001Eo-0j
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 12:25:18 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-408425c7c10so38874505e9.0
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 09:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698164713; x=1698769513; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xBLyy7Cf+oXVlWV7APmJwsDD8O0kUea2KuFgfmlS14s=;
 b=iX41Fdk18oWV3fz6hHWrpH6sNMs1QXAOxgBcnYz2+4DgHWq9jDzKx+j1ziNnXtLGKi
 ON0KYKt/LH4mRdgqkt3WAe7SJTFC1GAzdXJ+ZgIu7e0MV4yWyXgmrITD2oYyCs0P2JuK
 Yaf3Q6geTsgMWk9y8JWPTp6QsMugUN0hT8jLjy/zcKsx4eUbrTgmefslvXeesQq/HutX
 oAKEBAAt/sNsNKbjTinKZiWgNF8zvuSfVWXv8QOKuJghj3ydEUXo4DJejY2hveLta+K1
 iROVrXXmqP36paJ1CyeGgf9DlIAsyzHnQYkCzaQx+T2DfUdfRZRxGtDWH2vIYZK1VCvB
 RJuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698164713; x=1698769513;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xBLyy7Cf+oXVlWV7APmJwsDD8O0kUea2KuFgfmlS14s=;
 b=J+y2pcmiovwO1svljZIVRZKgRC4pzdmu3tsYg86ycgy5sDBYLdu94ryD2CEnOwO5tt
 SaPYs/hgE+4i+22JUzFmxrRgDxTYTFo62w/NMYSNnP/1x3wcdEOogxk2orUnvz/o/4dE
 TNWWsfITlShopidrdmigxJHH//GQW0MUuL8rfOnpOQGfxMBv33DLHkLItk2DLz+vNVGB
 wJSAdRH1I73bUk4VJHVaPMnDta0FhhibBSEEHVnuoVl4b44YWimw6L0iKSfvpIxSziqo
 SWkXnv/NYki+UbmVXMJh5kt50mvJD1Cp4NaDakTRJ+i3jrvCk5DDOT23PxD9HK500cOe
 HgQQ==
X-Gm-Message-State: AOJu0Yzz4zo3qrZcWRdhwFyYzXjW5k3TeLp3Z29E6ZnDWG3ufvIaW0Xp
 tMlQthNVSkkYqTWZIo6m81YUCJ8jLUatYxxIJf4=
X-Google-Smtp-Source: AGHT+IEszfb/w7lby4EjM+dADGeJwoeO9PrNq+w+8PfeCZOKckQx4GuWB5xSQK6N7/gJNY3ZsU2Ftw==
X-Received: by 2002:a05:600c:a07:b0:405:3251:47a1 with SMTP id
 z7-20020a05600c0a0700b00405325147a1mr9354995wmp.40.1698164713328; 
 Tue, 24 Oct 2023 09:25:13 -0700 (PDT)
Received: from m1x-phil.lan (sem44-h01-176-172-55-165.dsl.sta.abo.bbox.fr.
 [176.172.55.165]) by smtp.gmail.com with ESMTPSA id
 g14-20020a05600c310e00b0040813e14b49sm17205378wmo.30.2023.10.24.09.25.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Oct 2023 09:25:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>, Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 08/11] hw/arm/aspeed: Check 'memory' link is set in common
 aspeed_soc_realize
Date: Tue, 24 Oct 2023 18:24:19 +0200
Message-ID: <20231024162423.40206-9-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231024162423.40206-1-philmd@linaro.org>
References: <20231024162423.40206-1-philmd@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/aspeed_soc_common.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/arm/aspeed_soc_common.c b/hw/arm/aspeed_soc_common.c
index b66f769d18..828f61093b 100644
--- a/hw/arm/aspeed_soc_common.c
+++ b/hw/arm/aspeed_soc_common.c
@@ -114,6 +114,16 @@ void aspeed_mmio_map_unimplemented(AspeedSoCState *s, SysBusDevice *dev,
                                         sysbus_mmio_get_region(dev, 0), -1000);
 }
 
+static void aspeed_soc_realize(DeviceState *dev, Error **errp)
+{
+    AspeedSoCState *s = ASPEED_SOC(dev);
+
+    if (!s->memory) {
+        error_setg(errp, "'memory' link is not set");
+        return;
+    }
+}
+
 static Property aspeed_soc_properties[] = {
     DEFINE_PROP_LINK("dram", AspeedSoCState, dram_mr, TYPE_MEMORY_REGION,
                      MemoryRegion *),
@@ -126,6 +136,7 @@ static void aspeed_soc_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
+    dc->realize = aspeed_soc_realize;
     device_class_set_props(dc, aspeed_soc_properties);
 }
 
-- 
2.41.0


