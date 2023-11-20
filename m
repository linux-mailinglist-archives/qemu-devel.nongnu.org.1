Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 644F37F1F58
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 22:40:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5ByR-0002Uj-Ie; Mon, 20 Nov 2023 16:38:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5By2-0002N0-0L
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 16:38:09 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5Bxx-0004WU-CC
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 16:38:05 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-32f737deedfso3157413f8f.3
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 13:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700516280; x=1701121080; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UraS1TRuHZYl48d9Wxp+wjyyWyHIh0UIpS4MHa3Y4jk=;
 b=EMBorPeMlRr1txEOH2gF6Y2X6k8m5nwJHO2cE97N0IBuKfrGw6qCArNBVTLJa5tWo7
 OwHA6UtPfeW3u6RsiBiIwwbR4o6XKiMTBLjRQZIhiiQSqIqCVNzVvI1wKBkIDtBYcKou
 xB8/JVrRaPmEBqMy58X6it2Tb8Z1qmZPvterG/f6in38nit0ttgDraeF+IGtzgz5G3ur
 6Ph/QFd+iZoOP2+ZvbfhIw8qvFdQbd9XcfNpEIdMkTwqTFuET2ZnggYh/eY4w+M0P+Rf
 W5XUhDXCqEC8HlruRVB+2hYJFtOh+4fKECjkh6oTuVzN8+Q/ZcEbsD40Sz4VJ9wb/onM
 fTiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700516280; x=1701121080;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UraS1TRuHZYl48d9Wxp+wjyyWyHIh0UIpS4MHa3Y4jk=;
 b=QzjSSSc2So31IYwUiLuy3+Q65GHnhRHqYFkhjuWaft1k/gpzfVRVaHLuwydfL2eqDw
 Qsicd1xVsKZkf4aei2MXEp8UKA3UzgDNRO68inexflStqUoZUfthzWqBrTKw2ZEf42Np
 Yr9vW7zpajGKjCCcJvBcOj/g/NlGQD7z2V4mCicy8IhRvMafeVmP/7+hekh/8zsHfscy
 BUS0aj/BoK2WpfK/xGPBGjcDW+7WeffdsCELYLvmegVlXoocDDBqdsTMDcD6DB9rwzoA
 NFawDA9uXcck2eLyNk8ENYzTue2JdsgSKWIFC2HnlN7odhQjPzS4VL9XhZI1YxAercNk
 2sPw==
X-Gm-Message-State: AOJu0YxA4VAgI+l3E4kX5zIM+qVr/TuB5dDscs8v5sV0yvgkwrJY3xMI
 ki8oUXrzTPptA0KI8c1ruJwVCWkWBzfY/AQ+5aE=
X-Google-Smtp-Source: AGHT+IHflBalbLTcSpEJQEAQvMRHfmEnyQGY+PR0zSBuPt0JnWpgaSnexdgF77NL40SfRrfXafhNBQ==
X-Received: by 2002:a5d:5f88:0:b0:331:3425:b84d with SMTP id
 dr8-20020a5d5f88000000b003313425b84dmr6763766wrb.12.1700516279757; 
 Mon, 20 Nov 2023 13:37:59 -0800 (PST)
Received: from m1x-phil.lan ([176.176.181.190])
 by smtp.gmail.com with ESMTPSA id
 d16-20020adffbd0000000b003313902cef5sm12291345wrs.93.2023.11.20.13.37.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 20 Nov 2023 13:37:59 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>
Subject: [PATCH-for-9.0 20/25] hw: Simplify memory_region_init_ram() calls
Date: Mon, 20 Nov 2023 22:32:54 +0100
Message-ID: <20231120213301.24349-21-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231120213301.24349-1-philmd@linaro.org>
References: <20231120213301.24349-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

Mechanical change using the following coccinelle script:

@@
expression mr, owner, arg3, arg4, errp;
@@
-   memory_region_init_ram(mr, owner, arg3, arg4, &errp);
    if (
-       errp
+       !memory_region_init_ram(mr, owner, arg3, arg4, &errp)
    ) {
        ...
        return;
    }

and removing the local Error variable.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/aspeed_ast2400.c | 6 ++----
 hw/arm/aspeed_ast2600.c | 6 ++----
 hw/arm/fsl-imx25.c      | 6 ++----
 hw/arm/fsl-imx31.c      | 6 ++----
 hw/arm/fsl-imx6.c       | 6 ++----
 hw/arm/integratorcp.c   | 7 ++-----
 hw/arm/nrf51_soc.c      | 7 ++-----
 hw/ppc/rs6000_mc.c      | 7 ++-----
 8 files changed, 16 insertions(+), 35 deletions(-)

diff --git a/hw/arm/aspeed_ast2400.c b/hw/arm/aspeed_ast2400.c
index a4334c81b8..0baa2ff96e 100644
--- a/hw/arm/aspeed_ast2400.c
+++ b/hw/arm/aspeed_ast2400.c
@@ -247,7 +247,6 @@ static void aspeed_ast2400_soc_realize(DeviceState *dev, Error **errp)
     Aspeed2400SoCState *a = ASPEED2400_SOC(dev);
     AspeedSoCState *s = ASPEED_SOC(dev);
     AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
-    Error *err = NULL;
     g_autofree char *sram_name = NULL;
 
     /* Default boot region (SPI memory or ROMs) */
@@ -276,9 +275,8 @@ static void aspeed_ast2400_soc_realize(DeviceState *dev, Error **errp)
 
     /* SRAM */
     sram_name = g_strdup_printf("aspeed.sram.%d", CPU(&a->cpu[0])->cpu_index);
-    memory_region_init_ram(&s->sram, OBJECT(s), sram_name, sc->sram_size, &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!memory_region_init_ram(&s->sram, OBJECT(s), sram_name, sc->sram_size,
+                                errp)) {
         return;
     }
     memory_region_add_subregion(s->memory,
diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
index b965fbab5e..3a9a303ab8 100644
--- a/hw/arm/aspeed_ast2600.c
+++ b/hw/arm/aspeed_ast2600.c
@@ -282,7 +282,6 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     Aspeed2600SoCState *a = ASPEED2600_SOC(dev);
     AspeedSoCState *s = ASPEED_SOC(dev);
     AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
-    Error *err = NULL;
     qemu_irq irq;
     g_autofree char *sram_name = NULL;
 
@@ -355,9 +354,8 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
 
     /* SRAM */
     sram_name = g_strdup_printf("aspeed.sram.%d", CPU(&a->cpu[0])->cpu_index);
-    memory_region_init_ram(&s->sram, OBJECT(s), sram_name, sc->sram_size, &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!memory_region_init_ram(&s->sram, OBJECT(s), sram_name, sc->sram_size,
+                                errp)) {
         return;
     }
     memory_region_add_subregion(s->memory,
diff --git a/hw/arm/fsl-imx25.c b/hw/arm/fsl-imx25.c
index 9aabbf7f58..b15435ccaf 100644
--- a/hw/arm/fsl-imx25.c
+++ b/hw/arm/fsl-imx25.c
@@ -299,10 +299,8 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
                                 &s->rom[1]);
 
     /* initialize internal RAM (128 KB) */
-    memory_region_init_ram(&s->iram, NULL, "imx25.iram", FSL_IMX25_IRAM_SIZE,
-                           &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!memory_region_init_ram(&s->iram, NULL, "imx25.iram",
+                                FSL_IMX25_IRAM_SIZE, errp)) {
         return;
     }
     memory_region_add_subregion(get_system_memory(), FSL_IMX25_IRAM_ADDR,
diff --git a/hw/arm/fsl-imx31.c b/hw/arm/fsl-imx31.c
index def27bb913..1d5dcd51e8 100644
--- a/hw/arm/fsl-imx31.c
+++ b/hw/arm/fsl-imx31.c
@@ -208,10 +208,8 @@ static void fsl_imx31_realize(DeviceState *dev, Error **errp)
                                 &s->rom);
 
     /* initialize internal RAM (16 KB) */
-    memory_region_init_ram(&s->iram, NULL, "imx31.iram", FSL_IMX31_IRAM_SIZE,
-                           &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!memory_region_init_ram(&s->iram, NULL, "imx31.iram",
+                                FSL_IMX31_IRAM_SIZE, errp)) {
         return;
     }
     memory_region_add_subregion(get_system_memory(), FSL_IMX31_IRAM_ADDR,
diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
index 7dc42cbfe6..58f37e7c11 100644
--- a/hw/arm/fsl-imx6.c
+++ b/hw/arm/fsl-imx6.c
@@ -443,10 +443,8 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
                                 &s->caam);
 
     /* OCRAM memory */
-    memory_region_init_ram(&s->ocram, NULL, "imx6.ocram", FSL_IMX6_OCRAM_SIZE,
-                           &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!memory_region_init_ram(&s->ocram, NULL, "imx6.ocram",
+                                FSL_IMX6_OCRAM_SIZE, errp)) {
         return;
     }
     memory_region_add_subregion(get_system_memory(), FSL_IMX6_OCRAM_ADDR,
diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
index d176e9af7e..bb722fd46f 100644
--- a/hw/arm/integratorcp.c
+++ b/hw/arm/integratorcp.c
@@ -291,12 +291,9 @@ static void integratorcm_realize(DeviceState *d, Error **errp)
 {
     IntegratorCMState *s = INTEGRATOR_CM(d);
     SysBusDevice *dev = SYS_BUS_DEVICE(d);
-    Error *local_err = NULL;
 
-    memory_region_init_ram(&s->flash, OBJECT(d), "integrator.flash", 0x100000,
-                           &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    if (!memory_region_init_ram(&s->flash, OBJECT(d), "integrator.flash",
+                                0x100000, errp)) {
         return;
     }
 
diff --git a/hw/arm/nrf51_soc.c b/hw/arm/nrf51_soc.c
index 34da0d62f0..ac53441630 100644
--- a/hw/arm/nrf51_soc.c
+++ b/hw/arm/nrf51_soc.c
@@ -58,7 +58,6 @@ static void nrf51_soc_realize(DeviceState *dev_soc, Error **errp)
 {
     NRF51State *s = NRF51_SOC(dev_soc);
     MemoryRegion *mr;
-    Error *err = NULL;
     uint8_t i = 0;
     hwaddr base_addr = 0;
 
@@ -92,10 +91,8 @@ static void nrf51_soc_realize(DeviceState *dev_soc, Error **errp)
 
     memory_region_add_subregion_overlap(&s->container, 0, s->board_memory, -1);
 
-    memory_region_init_ram(&s->sram, OBJECT(s), "nrf51.sram", s->sram_size,
-                           &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!memory_region_init_ram(&s->sram, OBJECT(s), "nrf51.sram", s->sram_size,
+                                errp)) {
         return;
     }
     memory_region_add_subregion(&s->container, NRF51_SRAM_BASE, &s->sram);
diff --git a/hw/ppc/rs6000_mc.c b/hw/ppc/rs6000_mc.c
index c0bc212e92..0bf9cb9c47 100644
--- a/hw/ppc/rs6000_mc.c
+++ b/hw/ppc/rs6000_mc.c
@@ -143,7 +143,6 @@ static void rs6000mc_realize(DeviceState *dev, Error **errp)
     RS6000MCState *s = RS6000MC(dev);
     int socket = 0;
     unsigned int ram_size = s->ram_size / MiB;
-    Error *local_err = NULL;
 
     while (socket < 6) {
         if (ram_size >= 64) {
@@ -165,10 +164,8 @@ static void rs6000mc_realize(DeviceState *dev, Error **errp)
         if (s->simm_size[socket]) {
             char name[] = "simm.?";
             name[5] = socket + '0';
-            memory_region_init_ram(&s->simm[socket], OBJECT(dev), name,
-                                   s->simm_size[socket] * MiB, &local_err);
-            if (local_err) {
-                error_propagate(errp, local_err);
+            if (!memory_region_init_ram(&s->simm[socket], OBJECT(dev), name,
+                                        s->simm_size[socket] * MiB, errp)) {
                 return;
             }
             memory_region_add_subregion_overlap(get_system_memory(), 0,
-- 
2.41.0


