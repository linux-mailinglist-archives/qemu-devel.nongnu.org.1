Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 522977F1F53
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 22:39:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5ByT-0002jE-2V; Mon, 20 Nov 2023 16:38:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5ByH-0002YJ-6x
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 16:38:26 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5ByD-0004Z6-Iw
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 16:38:20 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40a46ea95f0so22421165e9.2
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 13:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700516295; x=1701121095; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3UqXJrP7Csw+EZpRSYWbaVbFeUsJSZVShG00VIsudqs=;
 b=m0sVu+6mWbTSb3y7RENxTOq7Y65Ex7Ref2Sua35bbHUNhnSydXjpYMlBwRni/pnRnS
 DpkR9lP0caM3pNn5Qqbc2glVVBCeOVBhept1NmXBI0e/7/Xeb/laDoj9bnPV3rRP0A1v
 PegaPx26rjoFpqVXNqFfJxwki17r9yqDKQ1PkDlPjyxwmp0i88CH9CrhFPLttVU1l1c9
 qDbJJu8GS0kL71b/p+uA7Ob8cocNM3l0S+tusTfM2qnyPuL8SNxS/d3AFu5bVSyzwU4d
 nx8n2kKGqqI04YoJR9SyVt/MocXC/r2TxP1zaANjlAQIHRwEvEKcyWYOoE8lQ0OW2JxN
 1cjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700516295; x=1701121095;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3UqXJrP7Csw+EZpRSYWbaVbFeUsJSZVShG00VIsudqs=;
 b=gX5l2Q8C/X9WZxSmXgddhkPHJW8XUpQieVqqo7hpLy5z0cJ5JPczdTv/szBab8qTqw
 lcMmyLvPkVLeh0mo8lFKUvKbrSPMigjbMwumIlqVqqSmE/EpKBk6hcTQzY9Q/NvU8//5
 W64RbMt+22UhL32gLejBpZ9NNb7FtqyZ5Yap+cmUYOVhVAyuoxwj4l/P47qqqKzau/hF
 yewX47q3vg2WwklNHNHHg5bf4Uw9AoNdn5Cg3G/Cx8FuOzod63DAoBixxeABl8oq+Mda
 +s1cNEl/TZA22LJf4zCVNaCIYPJ7Oo3N2SbhjaV0qf9oqT8TXXSfx7bLCmhrfA+o/mDr
 DOvA==
X-Gm-Message-State: AOJu0Ywhc3O4X9YEa84BTUx6g9VMhHUCOo4Uvc2dT0C+7b2VYCvGH3hj
 c3WHwNnlt3wc8Kt/V4aVMF+o+Eyamx0hpU4g+Rk=
X-Google-Smtp-Source: AGHT+IH/HTfb8qthb84Bbah+CqNXTN5ijzceXsgsGeMfBJJDbXmgtirc0oJW9g0/8WbtfWUhVpi7VQ==
X-Received: by 2002:a5d:54d1:0:b0:32f:b407:5b77 with SMTP id
 x17-20020a5d54d1000000b0032fb4075b77mr4653144wrv.64.1700516294438; 
 Mon, 20 Nov 2023 13:38:14 -0800 (PST)
Received: from m1x-phil.lan ([176.176.181.190])
 by smtp.gmail.com with ESMTPSA id
 s15-20020adfea8f000000b00323287186aasm12332571wrm.32.2023.11.20.13.38.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 20 Nov 2023 13:38:14 -0800 (PST)
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
 Peter Xu <peterx@redhat.com>, Jean-Christophe Dubois <jcd@tribudubois.net>
Subject: [PATCH-for-9.0 21/25] hw/arm: Simplify memory_region_init_rom() calls
Date: Mon, 20 Nov 2023 22:32:55 +0100
Message-ID: <20231120213301.24349-22-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231120213301.24349-1-philmd@linaro.org>
References: <20231120213301.24349-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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
-   memory_region_init_rom(mr, owner, arg3, arg4, &errp);
    if (
-       errp
+       !memory_region_init_rom(mr, owner, arg3, arg4, &errp)
    ) {
        ...
        return;
    }

and removing the local Error variable.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/fsl-imx25.c | 13 ++++---------
 hw/arm/fsl-imx31.c | 13 ++++---------
 hw/arm/fsl-imx6.c  | 13 ++++---------
 3 files changed, 12 insertions(+), 27 deletions(-)

diff --git a/hw/arm/fsl-imx25.c b/hw/arm/fsl-imx25.c
index b15435ccaf..9d2fb75a68 100644
--- a/hw/arm/fsl-imx25.c
+++ b/hw/arm/fsl-imx25.c
@@ -81,7 +81,6 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
 {
     FslIMX25State *s = FSL_IMX25(dev);
     uint8_t i;
-    Error *err = NULL;
 
     if (!qdev_realize(DEVICE(&s->cpu), NULL, errp)) {
         return;
@@ -281,18 +280,14 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
                                                        FSL_IMX25_WDT_IRQ));
 
     /* initialize 2 x 16 KB ROM */
-    memory_region_init_rom(&s->rom[0], OBJECT(dev), "imx25.rom0",
-                           FSL_IMX25_ROM0_SIZE, &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!memory_region_init_rom(&s->rom[0], OBJECT(dev), "imx25.rom0",
+                                FSL_IMX25_ROM0_SIZE, errp)) {
         return;
     }
     memory_region_add_subregion(get_system_memory(), FSL_IMX25_ROM0_ADDR,
                                 &s->rom[0]);
-    memory_region_init_rom(&s->rom[1], OBJECT(dev), "imx25.rom1",
-                           FSL_IMX25_ROM1_SIZE, &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!memory_region_init_rom(&s->rom[1], OBJECT(dev), "imx25.rom1",
+                                FSL_IMX25_ROM1_SIZE, errp)) {
         return;
     }
     memory_region_add_subregion(get_system_memory(), FSL_IMX25_ROM1_ADDR,
diff --git a/hw/arm/fsl-imx31.c b/hw/arm/fsl-imx31.c
index 1d5dcd51e8..c0584e4dfc 100644
--- a/hw/arm/fsl-imx31.c
+++ b/hw/arm/fsl-imx31.c
@@ -63,7 +63,6 @@ static void fsl_imx31_realize(DeviceState *dev, Error **errp)
 {
     FslIMX31State *s = FSL_IMX31(dev);
     uint16_t i;
-    Error *err = NULL;
 
     if (!qdev_realize(DEVICE(&s->cpu), NULL, errp)) {
         return;
@@ -188,20 +187,16 @@ static void fsl_imx31_realize(DeviceState *dev, Error **errp)
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->wdt), 0, FSL_IMX31_WDT_ADDR);
 
     /* On a real system, the first 16k is a `secure boot rom' */
-    memory_region_init_rom(&s->secure_rom, OBJECT(dev), "imx31.secure_rom",
-                           FSL_IMX31_SECURE_ROM_SIZE, &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!memory_region_init_rom(&s->secure_rom, OBJECT(dev), "imx31.secure_rom",
+                                FSL_IMX31_SECURE_ROM_SIZE, errp)) {
         return;
     }
     memory_region_add_subregion(get_system_memory(), FSL_IMX31_SECURE_ROM_ADDR,
                                 &s->secure_rom);
 
     /* There is also a 16k ROM */
-    memory_region_init_rom(&s->rom, OBJECT(dev), "imx31.rom",
-                           FSL_IMX31_ROM_SIZE, &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!memory_region_init_rom(&s->rom, OBJECT(dev), "imx31.rom",
+                                FSL_IMX31_ROM_SIZE, errp)) {
         return;
     }
     memory_region_add_subregion(get_system_memory(), FSL_IMX31_ROM_ADDR,
diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
index 58f37e7c11..b2153022c0 100644
--- a/hw/arm/fsl-imx6.c
+++ b/hw/arm/fsl-imx6.c
@@ -109,7 +109,6 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
     MachineState *ms = MACHINE(qdev_get_machine());
     FslIMX6State *s = FSL_IMX6(dev);
     uint16_t i;
-    Error *err = NULL;
     unsigned int smp_cpus = ms->smp.cpus;
 
     if (smp_cpus > FSL_IMX6_NUM_CPUS) {
@@ -423,20 +422,16 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
     }
 
     /* ROM memory */
-    memory_region_init_rom(&s->rom, OBJECT(dev), "imx6.rom",
-                           FSL_IMX6_ROM_SIZE, &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!memory_region_init_rom(&s->rom, OBJECT(dev), "imx6.rom",
+                                FSL_IMX6_ROM_SIZE, errp)) {
         return;
     }
     memory_region_add_subregion(get_system_memory(), FSL_IMX6_ROM_ADDR,
                                 &s->rom);
 
     /* CAAM memory */
-    memory_region_init_rom(&s->caam, OBJECT(dev), "imx6.caam",
-                           FSL_IMX6_CAAM_MEM_SIZE, &err);
-    if (err) {
-        error_propagate(errp, err);
+    if (!memory_region_init_rom(&s->caam, OBJECT(dev), "imx6.caam",
+                                FSL_IMX6_CAAM_MEM_SIZE, errp)) {
         return;
     }
     memory_region_add_subregion(get_system_memory(), FSL_IMX6_CAAM_MEM_ADDR,
-- 
2.41.0


