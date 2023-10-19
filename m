Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E2BB47CFAB6
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 15:17:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtSuL-0000ad-Hw; Thu, 19 Oct 2023 09:17:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtStn-0000AO-P9
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:17:19 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtStl-0003mb-P7
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:17:15 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5384975e34cso13920460a12.0
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 06:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697721431; x=1698326231; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wFvi5lmNEMObBf6omDuTraTBDs9CBVzxTa3XSY9GsF4=;
 b=X2m9uf0erXWKjJzPNU1m88B8FFQVaNGpU3apvVCakuoHKpuXZ3ebyL1LG9l/0fCfh3
 kx2Ik2By9EA2gHeTSeVj2Zi5Q+KkOeTBG7mYnfn9kmy77aEJenb79Dbez/VWETSq0POm
 3a+Np4AJ2Eb4FM+eSa4e3i2MEBoC4n3NeuWZIyVXIQDNtPwCLel+n/1lUaE4ORTc0N69
 jGym20hAk32qFE9MYJ3Yix9wbmnDJJYIt9ny3wUoGwE+QbxDLy4Mvoi/ndwHk9FbtUDo
 QafNS4A0TND4co/i1DhzdudUcPG5wcyAlLGbkAiQDkNbxOcjJmj34x9uWNor/SKuHqad
 mPLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697721431; x=1698326231;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wFvi5lmNEMObBf6omDuTraTBDs9CBVzxTa3XSY9GsF4=;
 b=rJ8+9rk6Znn+UiFsdMq7O5ETJptzINbnbS4NiQTJmEUBQQLXCIoW012o+0OOyo2tiD
 SknaKPJ8XirCA58RgQ4J2nEgEJGmd0TDnjgW3s58dZfyM9m8pj3HocpufAhwgzwLnY8w
 4WoQTlIJmL0oM4q0RXB8Pg3wR+g2LM+DxbP/piCv5N392t7DCCormZQB0tONzjLtbTuw
 4IhbjXExP8kGEhuYrCDkcfuolXKPRRkpNAu0UuS/N6JBVx7npZ7ioxtW1igCsiVq9UP4
 XscivCi0LgKbnKtne22Px2LJ9XkWDvd4E3zpiWSnBfZ5iQqhz75lUwYkOzj64NjUyHVk
 Cfkw==
X-Gm-Message-State: AOJu0Yx1OAdSCu8bNnxiWvTKu+eC6r7KswuKzrQ5hG6vHSwqkxzYqKat
 +6DsvMMcn7s3g/JJR2/XLdtJBdW2KjnlGroC0SWQ0w==
X-Google-Smtp-Source: AGHT+IFeBnfZ8oy4rptlH2XfXHQ+bwPIqW2tam7CxMBSvhTD0M7AWD5taehvU3+aEMB5p6nO1wTaWg==
X-Received: by 2002:a05:6402:2155:b0:53d:fba2:24be with SMTP id
 bq21-20020a056402215500b0053dfba224bemr1348963edb.15.1697721431540; 
 Thu, 19 Oct 2023 06:17:11 -0700 (PDT)
Received: from m1x-phil.lan (176-131-216-177.abo.bbox.fr. [176.131.216.177])
 by smtp.gmail.com with ESMTPSA id
 d29-20020a50f69d000000b0053daf92f0easm4480571edn.97.2023.10.19.06.17.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Oct 2023 06:17:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 3/7] hw/ppc/pnv_xscom: Move sysbus_mmio_map() call within
 pnv_xscom_init()
Date: Thu, 19 Oct 2023 15:16:43 +0200
Message-ID: <20231019131647.19690-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231019131647.19690-1-philmd@linaro.org>
References: <20231019131647.19690-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52c.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
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


