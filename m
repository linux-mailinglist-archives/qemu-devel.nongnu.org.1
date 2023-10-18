Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A51467CDCEA
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 15:14:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt6Me-0007tg-1I; Wed, 18 Oct 2023 09:13:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qt6Lt-000768-HE
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 09:12:47 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qt6Lr-0000hN-2B
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 09:12:45 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-9ad8a822508so1111690166b.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 06:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697634760; x=1698239560; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e3Wrm2+hEgcQGJPeHM5sv3LDR90OXcyWyLu0fpUZ2rw=;
 b=Kh8udEtt+dWC2Gmh54JzfmUZD7PGqUegm5Xw+jEe4HwJ23FSD2UiIhqUONX12uKVCc
 IWSO1zckDCSXF6ARHGaRkoNIDejbkBJQgPZeFHPpIGQEbDd9DmAdlwSE9xYgymBGJHdw
 NeTIEgN3xC/PyzdZuV4qh4ZAVl45FrEtMDLln0Iou2ZOhXHWJLZCC9PB1lYfE/rwp8cO
 eODPn2cp9i5/9IVae0uMZFt7Q/nZL9v7JsSE1tD4dbo1ctL0vj6/PG/uHIwkICAYex+H
 2OBVY9JV7t3l5Lx8uzOvxWny2HxYFew0cvuCxNW8jpprTBjeE729PllxDnn13N6Xn5as
 aV9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697634760; x=1698239560;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e3Wrm2+hEgcQGJPeHM5sv3LDR90OXcyWyLu0fpUZ2rw=;
 b=OxhUN3r8zh3wLDBPdajgPTNN/T0Xxk5yAecp4Xve0wCv8eA4FnC2nR1Kvpd01B9PAM
 9U/LTMx4jMW7J2XDFR5czqOCCasMpS32ddJSd7l3xDMU77ZtrxsA1OvaxeKB14YloS7t
 OeeqNbRcKMLAF96bEz6W36AGwD6DfagojnSDsoY8Ep3LBCNXDgxhW0MEU1UBHpmmvedP
 5VlmTl0G2vEu8kUfjZRlpgYkT+IAp/TfZkv4BYeX+/g9L3D3cks0mFzyukIAItLJbeH7
 WdSeNzTCmGodAEgIN4PQDqXoZa09UO9PKWwXSUWZsNofeSUjHJYZFcZXeo5fYNVIEP6O
 wA0w==
X-Gm-Message-State: AOJu0Yxy1Ln9k5RuzXc7KUTpmdzUljxKhFrK/uz27a9O2oJ8qtNnusWp
 7DBfJvDuhi0RmzloVxaWwTOIg4Z50QtuXoQyalk=
X-Google-Smtp-Source: AGHT+IGrJh/dXC82ML7++cZkWfhm29VHzsu3GfQ0NX8aAyqBEG+jc6d1/tsU3cGYW4D8ixTLWf9sUQ==
X-Received: by 2002:a17:907:97c3:b0:9c5:8a6b:29e with SMTP id
 js3-20020a17090797c300b009c58a6b029emr4246757ejc.13.1697634760760; 
 Wed, 18 Oct 2023 06:12:40 -0700 (PDT)
Received: from m1x-phil.lan (gyl59-h01-176-171-218-149.dsl.sta.abo.bbox.fr.
 [176.171.218.149]) by smtp.gmail.com with ESMTPSA id
 gz8-20020a170906f2c800b009bd9ac83a9fsm1639471ejb.152.2023.10.18.06.12.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 18 Oct 2023 06:12:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/8] hw/pcmcia/pxa2xx: Realize sysbus device before accessing
 it
Date: Wed, 18 Oct 2023 15:12:15 +0200
Message-ID: <20231018131220.84380-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018131220.84380-1-philmd@linaro.org>
References: <20231018131220.84380-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x629.google.com
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

sysbus_mmio_map() should not be called on unrealized device.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/pcmcia/pxa2xx.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/hw/pcmcia/pxa2xx.c b/hw/pcmcia/pxa2xx.c
index fcca7e571b..e7264feb45 100644
--- a/hw/pcmcia/pxa2xx.c
+++ b/hw/pcmcia/pxa2xx.c
@@ -142,15 +142,12 @@ PXA2xxPCMCIAState *pxa2xx_pcmcia_init(MemoryRegion *sysmem,
                                       hwaddr base)
 {
     DeviceState *dev;
-    PXA2xxPCMCIAState *s;
 
     dev = qdev_new(TYPE_PXA2XX_PCMCIA);
-    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
-    s = PXA2XX_PCMCIA(dev);
-
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
 
-    return s;
+    return PXA2XX_PCMCIA(dev);
 }
 
 static void pxa2xx_pcmcia_initfn(Object *obj)
-- 
2.41.0


