Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 122BD7D03F8
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 23:26:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtaRx-0000xC-IB; Thu, 19 Oct 2023 17:21:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtaRv-0000wS-KG
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 17:20:59 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtaRt-0005gn-U0
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 17:20:59 -0400
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2c51388ccebso1489371fa.3
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 14:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697750456; x=1698355256; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3U1ctCoB2Patr0sOy1+nWAx2R2m9mUOpe8fog16ZiDc=;
 b=hb23pGJmXToeKTmU3gP2MsVGPmWhHHR8/tzQZ4Js544D4usDcpUPREFe+Wb5Tl2XII
 dQ77WKvxkA/XfRWy4zeUPRwzemCDQ3z3UDVYGCJqCzYqj9vdZ1Jujiejc19kSgjU/BCt
 6fBvxRYXw/O1zQXrdcbkDqHyPMPa1ia1emFiGu9PU3hT1Jc8sJFIf8ndVuXuEFvyji+y
 zjWAIvkfCz5AzTM8tzlP/BCNsld76CE1/MeDhow6qf1/avFiBFpjY7TnLHBlidPT1jvv
 oBaSKklxokeWV74elpCczDuiAYSO3fzXgZx+dbavRGc5I1zzJ6NNpY49SLmQLuyr6yQG
 CT+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697750456; x=1698355256;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3U1ctCoB2Patr0sOy1+nWAx2R2m9mUOpe8fog16ZiDc=;
 b=YJbNiGTo32VDJw0zxTkd7e5tGPYRw+tjryfQxLZPNGAbyLZ50gJ5cXp+jIlxsASc6V
 8Fkn1qt9EmKeSJ8YVDx6nvVF3sRqOUYc9q3ayGTq559AHJwmyHRFrLyqzE/FpVCe65/4
 LKG8Nr8XrCzTp4U9MyAew/JG+ZXltF/bH4dhdqHya5/TwZQwCp45flk2YhErAc56tv0T
 ByYrTbRbLVQPL49WJh3a8rj8xQw9nYv9rq/UmPljw0i+lzgoTpDd6rZ72A7+LWWFHu7V
 JIkZXYxsm4SqKTBnCZAFw0Yvtz17/FJcAcgPCewg8zzdsmYCKb9AboiznmZzN/XNBIHJ
 aJ2Q==
X-Gm-Message-State: AOJu0Yzo+u47qv+8JBqd6jg32qDV/dnr9AuqaEcdbUX2KY4mm/iGsEAE
 YNpkN7Q27cfQfsrvfmwW4iBwBlh2iSX/I4bMc4xxtQ==
X-Google-Smtp-Source: AGHT+IF1Cs5mdlWzPkGYea84Vd07648MdGbDgVQbrEz8zcF5A2grPHIs48HYVPMRuzZObs/V+eBfhw==
X-Received: by 2002:a05:651c:1986:b0:2c0:afd:e7ed with SMTP id
 bx6-20020a05651c198600b002c00afde7edmr136679ljb.10.1697750456122; 
 Thu, 19 Oct 2023 14:20:56 -0700 (PDT)
Received: from m1x-phil.lan (176-131-216-177.abo.bbox.fr. [176.131.216.177])
 by smtp.gmail.com with ESMTPSA id
 bh9-20020a05600c3d0900b003feae747ff2sm5380666wmb.35.2023.10.19.14.20.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Oct 2023 14:20:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-block@nongnu.org,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>
Subject: [PULL 24/46] hw/ppc/pnv_xscom: Rename pnv_xscom_realize(Error **) ->
 pnv_xscom_init()
Date: Thu, 19 Oct 2023 23:17:49 +0200
Message-ID: <20231019211814.30576-25-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231019211814.30576-1-philmd@linaro.org>
References: <20231019211814.30576-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22c.google.com
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
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Message-Id: <20231019131647.19690-3-philmd@linaro.org>
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


