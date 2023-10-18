Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EAEA7CDD54
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 15:32:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt6e7-0007vg-7v; Wed, 18 Oct 2023 09:31:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qt6ds-0007hO-Tl
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 09:31:27 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qt6dp-0004i8-Df
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 09:31:20 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-50435ad51bbso9073325e87.2
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 06:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697635875; x=1698240675; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4JzNT1BOnEa9xt/v/nMXe1GFFvZS33OkSi1pdN0E7RE=;
 b=iqiTj8zu8CT367PAtB1vzD+K/+MTlHCDhyNSy9nLLMxRYnDj517dXjp4r3nJ8eCeI6
 IZ/Y6zXpil4iv8+0JXRLy0vTw3+i03ZE8wc2EqYj3KF20PE04tGpR/sdcQa8ichPxnS4
 wQk27XpNRN6BTFTTjqKNYS6YFLZE3tkk/R0+TnnP/V52luqs5cqH2mETZCXlN9FVXWWm
 s8ErfAFX+HK+IOnNJ2hvCDvTEK9hufZkOpTOWj2oM/ljyO0ycF9klecB+3ae6wE8A98F
 jJSztiHgOeBarVCLyE3rJIPRrlhohBhZzSzto5LnlDYExr+y4rQyT2FrRfgOYYSVbyrf
 jg9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697635875; x=1698240675;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4JzNT1BOnEa9xt/v/nMXe1GFFvZS33OkSi1pdN0E7RE=;
 b=E+IPkImFt6QPFNEr/JqxYxNQvMIhfaSlQHVI06BIAiH1ajIdnGgMH7RETumUBVnqfl
 ZPdAsfm9gxEbciFQ86jleau3CEVReU61qCeA670PGO/IADQtB2PFUzquixAEVdjWUj51
 7WxF+HxC8calKIXrUE70WxTmJb0nijVQUHPx8CcsvESu9hAi9IfLrL09UPAr0r0SH3wg
 G83/Z7Evub4LVLBHKzlYFTc2R5SyBRrGrS9qpwaqymsWgTk53d0rym1Jj5LvxIiGGoPg
 9TMduQqBDt7bVkmqdwp63Bb7xb+6NeIP32rC2VUoEAttCK9XNoiViyXPw2zED82ji0Bu
 uI3w==
X-Gm-Message-State: AOJu0Yw2oMUS90RNjRFs0JTT7i2vBcMAJ6tlMLe9ufnGzBBfI371hSBq
 vUynz2ZtSNq1vnaYK5hWtOKk8THtfUNyJmhvNw0=
X-Google-Smtp-Source: AGHT+IGGC/DB16P3BB1nPMWKF5VXyCaUMtP+5TJuuZKA2x7kSuINdEw73p8KJAwQkuLGO7HIMlxqNA==
X-Received: by 2002:a19:7411:0:b0:507:95ea:1e72 with SMTP id
 v17-20020a197411000000b0050795ea1e72mr4327162lfe.22.1697635875553; 
 Wed, 18 Oct 2023 06:31:15 -0700 (PDT)
Received: from m1x-phil.lan (gyl59-h01-176-171-218-149.dsl.sta.abo.bbox.fr.
 [176.171.218.149]) by smtp.gmail.com with ESMTPSA id
 z3-20020a5d6403000000b0032db430fb9bsm2114410wru.68.2023.10.18.06.31.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 18 Oct 2023 06:31:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/6] hw/ppc/pnv_xscom: Move sysbus_mmio_map() call within
 pnv_xscom_init()
Date: Wed, 18 Oct 2023 15:30:55 +0200
Message-ID: <20231018133059.85765-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018133059.85765-1-philmd@linaro.org>
References: <20231018133059.85765-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x135.google.com
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

In order to make the next commit trivial, move sysbus_init_mmio()
calls just before the corresponding sysbus_mmio_map() calls.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/ppc/pnv_xscom.h | 2 +-
 hw/ppc/pnv.c               | 9 +++------
 hw/ppc/pnv_xscom.c         | 3 ++-
 3 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
index 41671001da..35b19610f7 100644
--- a/include/hw/ppc/pnv_xscom.h
+++ b/include/hw/ppc/pnv_xscom.h
@@ -170,7 +170,7 @@ struct PnvXScomInterfaceClass {
 #define PNV10_XSCOM_PEC_PCI_BASE   0x8010800 /* index goes upwards ... */
 #define PNV10_XSCOM_PEC_PCI_SIZE   0x200
 
-void pnv_xscom_init(PnvChip *chip, uint64_t size);
+void pnv_xscom_init(PnvChip *chip, uint64_t size, hwaddr addr);
 int pnv_dt_xscom(PnvChip *chip, void *fdt, int root_offset,
                  uint64_t xscom_base, uint64_t xscom_size,
                  const char *compat, int compat_size);
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 456631c9dc..10158f7684 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1249,8 +1249,7 @@ static void pnv_chip_power8_realize(DeviceState *dev, Error **errp)
     assert(chip8->xics);
 
     /* XSCOM bridge is first */
-    pnv_xscom_init(chip, PNV_XSCOM_SIZE);
-    sysbus_mmio_map(SYS_BUS_DEVICE(chip), 0, PNV_XSCOM_BASE(chip));
+    pnv_xscom_init(chip, PNV_XSCOM_SIZE, PNV_XSCOM_BASE(chip));
 
     pcc->parent_realize(dev, &local_err);
     if (local_err) {
@@ -1508,8 +1507,7 @@ static void pnv_chip_power9_realize(DeviceState *dev, Error **errp)
     Error *local_err = NULL;
 
     /* XSCOM bridge is first */
-    pnv_xscom_init(chip, PNV9_XSCOM_SIZE);
-    sysbus_mmio_map(SYS_BUS_DEVICE(chip), 0, PNV9_XSCOM_BASE(chip));
+    pnv_xscom_init(chip, PNV9_XSCOM_SIZE, PNV9_XSCOM_BASE(chip));
 
     pcc->parent_realize(dev, &local_err);
     if (local_err) {
@@ -1719,8 +1717,7 @@ static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
     Error *local_err = NULL;
 
     /* XSCOM bridge is first */
-    pnv_xscom_init(chip, PNV10_XSCOM_SIZE);
-    sysbus_mmio_map(SYS_BUS_DEVICE(chip), 0, PNV10_XSCOM_BASE(chip));
+    pnv_xscom_init(chip, PNV10_XSCOM_SIZE, PNV10_XSCOM_BASE(chip));
 
     pcc->parent_realize(dev, &local_err);
     if (local_err) {
diff --git a/hw/ppc/pnv_xscom.c b/hw/ppc/pnv_xscom.c
index af57b55863..cf892c9fe8 100644
--- a/hw/ppc/pnv_xscom.c
+++ b/hw/ppc/pnv_xscom.c
@@ -221,7 +221,7 @@ const MemoryRegionOps pnv_xscom_ops = {
     .endianness = DEVICE_BIG_ENDIAN,
 };
 
-void pnv_xscom_init(PnvChip *chip, uint64_t size)
+void pnv_xscom_init(PnvChip *chip, uint64_t size, hwaddr addr)
 {
     SysBusDevice *sbd = SYS_BUS_DEVICE(chip);
     char *name;
@@ -230,6 +230,7 @@ void pnv_xscom_init(PnvChip *chip, uint64_t size)
     memory_region_init_io(&chip->xscom_mmio, OBJECT(chip), &pnv_xscom_ops,
                           chip, name, size);
     sysbus_init_mmio(sbd, &chip->xscom_mmio);
+    sysbus_mmio_map(sbd, 0, addr);
 
     memory_region_init(&chip->xscom, OBJECT(chip), name, size);
     address_space_init(&chip->xscom_as, &chip->xscom, name);
-- 
2.41.0


