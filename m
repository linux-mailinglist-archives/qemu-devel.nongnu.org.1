Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 501E17CFABF
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 15:18:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtSuK-0000P4-8D; Thu, 19 Oct 2023 09:17:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtSti-00009f-KQ
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:17:18 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtStg-0003m0-GR
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:17:10 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-9be02fcf268so948163366b.3
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 06:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697721425; x=1698326225; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ldJFXb9fdD2sfJu6FP/y4XyBQnTwT0OjDzwlspACaHE=;
 b=c/BBzh4oXBRMC0TDq4XMv9aSSM1ZadqILTg8dgf80riug5WNh/GC4OQ48g4DNjNATB
 oSB1ZUTTZ+zg42TJSXdOCKuVxifmoCRjAp+KvdhI0n4Bg4fyFdHlXaNeNxdgizwhEoEX
 DgrIi5J0GB1jFvEIzbBBi0F8kjSD3QVWxHD97NQ9/soMw7cQbS+iSoXeeGMaU+KHedRg
 yekYTWEf6+PLr/yg5mw3BH8BQ593oxwV0XXCyAnxZ+HGhHma5hjDToM8Cu/7N+Q0SKT9
 CqnG7abEuATJ+399paqO6R/CMr33xv2jc94u/JPL28pLq2uOcm/iyKqAlmx+dq6UaMCf
 B2sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697721425; x=1698326225;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ldJFXb9fdD2sfJu6FP/y4XyBQnTwT0OjDzwlspACaHE=;
 b=kW57UiYx5AUCKJqpKkJ8lx6bJlYMkN/LQxZ3FhsNC6CAQpnJqf/b+azNSkxvVeJBoP
 h+hwFgqIAtFaSCXp8hw1x+hQ2Rr0JrJKQRjRjpNIuDK1WUa8BzwFYeHxYjVPhI1OfLch
 HNE13RlEHK9xdCTPRFi1vlvMrMJmHPvqsHgsqftwmKBVoKqT9gICmGVR3d2Nc+/LYcCz
 n3q/wHZD8CuqpYz+8j3rD5MI/R6qE05apGE+ut6Gr3l3PvZEeWEoRVv3Pu45yxGT4GLb
 7kd9vkrqHpI+QA2L/5xUYV6hAFGa75p2RUcLRh5g5jgN4r/U94o2GRlaRUvNT1bW9fvT
 SvoQ==
X-Gm-Message-State: AOJu0Yw4OPYIoSATmKPZHj3wfM3mWr5LRb5CTjSQjlrowgHSXgJQXeCL
 41VuGS4HnkAnmwkoYnGQSLp/XAqPlL0y3Ml9LrCrLQ==
X-Google-Smtp-Source: AGHT+IHRF8ty9YL0dEqLoLr3yIJIHhp0JGV+nxVe/fi5DQ7WoUmpsRLU7iSbm+t79cCCwqudiaYTxQ==
X-Received: by 2002:a17:907:2d10:b0:9b2:cf77:a105 with SMTP id
 gs16-20020a1709072d1000b009b2cf77a105mr1544701ejc.15.1697721424881; 
 Thu, 19 Oct 2023 06:17:04 -0700 (PDT)
Received: from m1x-phil.lan (176-131-216-177.abo.bbox.fr. [176.131.216.177])
 by smtp.gmail.com with ESMTPSA id
 qq20-20020a17090720d400b00997e99a662bsm3544760ejb.20.2023.10.19.06.17.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Oct 2023 06:17:04 -0700 (PDT)
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
Subject: [PATCH v3 2/7] hw/ppc/pnv_xscom: Rename pnv_xscom_realize(Error **)
 -> pnv_xscom_init()
Date: Thu, 19 Oct 2023 15:16:42 +0200
Message-ID: <20231019131647.19690-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231019131647.19690-1-philmd@linaro.org>
References: <20231019131647.19690-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x633.google.com
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

pnv_xscom_realize() is not used to *realize* QDev object, rename
it as pnv_xscom_init(). The Error** argument is unused: remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
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


