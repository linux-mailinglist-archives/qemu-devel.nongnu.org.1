Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AF45E7CDD6A
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 15:36:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt6e4-0007gy-PB; Wed, 18 Oct 2023 09:31:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qt6dl-0007f5-Lv
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 09:31:14 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qt6dj-0004hS-Ov
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 09:31:13 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-507a29c7eefso5717610e87.1
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 06:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697635869; x=1698240669; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R88+Z+VGYIDcvDUiZgRkTIEWNSTtdo2zUBsOwzRZMmc=;
 b=TdqlEWr6rzRpsbUxD3h21MmktH5yi26TbzzBOdYrmiC2kz0Mys8jL3nykzBvHdEMPV
 vtdAqXVP1JMucNuq/LXB/LXNl3FY1IEE9eUA9U31nDK/fmrL2qZAeNi3Ut5sd5vDHIcS
 qIpdaISyIqZvdIxAoQwkJYHdUvaCMP0V+WLRriPcK+YKftlhIFXJb2UfZq1mWagzGThQ
 JVyxaVAmocJIp5BXvozEyigk7rHwTsI9Ch6qd17wizuDZmz0954EWKylP9qXAZArKwbK
 HgwFW78OjX4L5/6ZRcmdkFRG6RDVclwHA2CAv1CLSwRvsiDkyZmG00SVyEqDlfSJnIfZ
 SZkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697635869; x=1698240669;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R88+Z+VGYIDcvDUiZgRkTIEWNSTtdo2zUBsOwzRZMmc=;
 b=GUXOkq9c+Y7C+wMi0N1jubRtZxnsF7Ioof0BVUWY325Nq7s5q6p1zOaAMiplH/bzvy
 NtwBEW04jcRD6SZKfVqTXzx4DnseIEWlO3zG2/OIV9rbLgQWJ3ukAVaJ7fRK36uahauU
 wQH+cM2lFj6wCri1nkekZ+/JMzlFSRJrMWDbzotNnxeZe6wCR6i0oiYWD4mNdmEBRU5a
 4qKjacDAyBMmDWdj8ruw5qbsqi+Hhdx6rdNeIiYJbwqC66y0HkL3l8jqYpJe1y+QYGI+
 FAUYanBcDQUIXcTucV2wX1/0EKAwkiukdlx5z3tMEGpNGhDgnFDHdVSkZoH0WMIXkJ3h
 Oj0g==
X-Gm-Message-State: AOJu0YyIDXRBI1Ztik99GqMAy5bwQ/aGDM8HYUpeefkzyvNjd5DN/KBa
 wsXF1Q3GSVl7QZDQLW7WDiFaVYg1U1EHb2/tQtg=
X-Google-Smtp-Source: AGHT+IFxcFaHh/Bj1G95qsKg2cCrSGzutk9+zbqEQ5GaPVW3cYv+8JtnhKA4ZSKWqAoAiyVj7sUHFw==
X-Received: by 2002:ac2:4315:0:b0:500:d8d6:fc5a with SMTP id
 l21-20020ac24315000000b00500d8d6fc5amr3887487lfh.37.1697635869405; 
 Wed, 18 Oct 2023 06:31:09 -0700 (PDT)
Received: from m1x-phil.lan (gyl59-h01-176-171-218-149.dsl.sta.abo.bbox.fr.
 [176.171.218.149]) by smtp.gmail.com with ESMTPSA id
 r13-20020a5d498d000000b0032da40fd7bdsm2139621wrq.24.2023.10.18.06.31.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 18 Oct 2023 06:31:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/6] hw/ppc/pnv_xscom: Rename pnv_xscom_realize(Error **) ->
 pnv_xscom_init()
Date: Wed, 18 Oct 2023 15:30:54 +0200
Message-ID: <20231018133059.85765-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018133059.85765-1-philmd@linaro.org>
References: <20231018133059.85765-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12a.google.com
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

pnv_xscom_realize() is not used to *realize* QDev object, rename
it as pnv_xscom_init(). The Error** argument is unused: remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/ppc/pnv_xscom.h |  2 +-
 hw/ppc/pnv.c               | 18 +++---------------
 hw/ppc/pnv_xscom.c         |  2 +-
 3 files changed, 5 insertions(+), 17 deletions(-)

diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
index 9bc6463547..41671001da 100644
--- a/include/hw/ppc/pnv_xscom.h
+++ b/include/hw/ppc/pnv_xscom.h
@@ -170,7 +170,7 @@ struct PnvXScomInterfaceClass {
 #define PNV10_XSCOM_PEC_PCI_BASE   0x8010800 /* index goes upwards ... */
 #define PNV10_XSCOM_PEC_PCI_SIZE   0x200
 
-void pnv_xscom_realize(PnvChip *chip, uint64_t size, Error **errp);
+void pnv_xscom_init(PnvChip *chip, uint64_t size);
 int pnv_dt_xscom(PnvChip *chip, void *fdt, int root_offset,
                  uint64_t xscom_base, uint64_t xscom_size,
                  const char *compat, int compat_size);
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index eb54f93986..456631c9dc 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1249,11 +1249,7 @@ static void pnv_chip_power8_realize(DeviceState *dev, Error **errp)
     assert(chip8->xics);
 
     /* XSCOM bridge is first */
-    pnv_xscom_realize(chip, PNV_XSCOM_SIZE, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        return;
-    }
+    pnv_xscom_init(chip, PNV_XSCOM_SIZE);
     sysbus_mmio_map(SYS_BUS_DEVICE(chip), 0, PNV_XSCOM_BASE(chip));
 
     pcc->parent_realize(dev, &local_err);
@@ -1512,11 +1508,7 @@ static void pnv_chip_power9_realize(DeviceState *dev, Error **errp)
     Error *local_err = NULL;
 
     /* XSCOM bridge is first */
-    pnv_xscom_realize(chip, PNV9_XSCOM_SIZE, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        return;
-    }
+    pnv_xscom_init(chip, PNV9_XSCOM_SIZE);
     sysbus_mmio_map(SYS_BUS_DEVICE(chip), 0, PNV9_XSCOM_BASE(chip));
 
     pcc->parent_realize(dev, &local_err);
@@ -1727,11 +1719,7 @@ static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
     Error *local_err = NULL;
 
     /* XSCOM bridge is first */
-    pnv_xscom_realize(chip, PNV10_XSCOM_SIZE, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        return;
-    }
+    pnv_xscom_init(chip, PNV10_XSCOM_SIZE);
     sysbus_mmio_map(SYS_BUS_DEVICE(chip), 0, PNV10_XSCOM_BASE(chip));
 
     pcc->parent_realize(dev, &local_err);
diff --git a/hw/ppc/pnv_xscom.c b/hw/ppc/pnv_xscom.c
index d820e05e40..af57b55863 100644
--- a/hw/ppc/pnv_xscom.c
+++ b/hw/ppc/pnv_xscom.c
@@ -221,7 +221,7 @@ const MemoryRegionOps pnv_xscom_ops = {
     .endianness = DEVICE_BIG_ENDIAN,
 };
 
-void pnv_xscom_realize(PnvChip *chip, uint64_t size, Error **errp)
+void pnv_xscom_init(PnvChip *chip, uint64_t size)
 {
     SysBusDevice *sbd = SYS_BUS_DEVICE(chip);
     char *name;
-- 
2.41.0


