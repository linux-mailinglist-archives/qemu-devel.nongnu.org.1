Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 559D27CFAA7
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 15:14:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtSrD-0000aR-Ah; Thu, 19 Oct 2023 09:14:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtSq5-0007LQ-2y
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:13:30 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtSq2-0002Sz-Vn
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:13:24 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2c50cf61f6dso91433421fa.2
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 06:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697721201; x=1698326001; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ldJFXb9fdD2sfJu6FP/y4XyBQnTwT0OjDzwlspACaHE=;
 b=jR/NU8jJ5LO3DqRLNXoJ+YzJfle8KgeLvIYXMMjX/D0Y8mPtOYrgbl+2v5CHjnKDLZ
 cBm2dK2aOkGktzAY4S8Zd9OQJohNmJcrHBfWIXThz0+O+Ccrqyr2vZBrj/2qeGdTG8ts
 mcfNwjAs2vf77MyuvsYf9r/oKlM88Ask8dUpm3TA5NcA9/uoMaRz4ztp8OJIbsbBCt3R
 agRS6zBWTihq7u3Smvf/G0kXar+17je8AaPX6g+8Gc7kd9WjrVbKoXdvH+f9ThkgxJdA
 ci9TTdz4K1+oDJsjlOyzU+4cZlZkFP5Wrb+dlPjYB7gKIWLN4Aj3seSakzRsyb4D7Ehy
 rCUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697721201; x=1698326001;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ldJFXb9fdD2sfJu6FP/y4XyBQnTwT0OjDzwlspACaHE=;
 b=jTs2P9BoumKLUMFA509otan0oOMeMir/nmy/3c2RAaS8GoJ/Eu421D1IDrHyH5JrGI
 /SFWFLzPcWuLaDebirPkTWzgRxQKEp8JfF7jjyf0fh96FodbuLOfCf83BqATRicBMBFf
 I8UyuNFhD/e8XpWyG8XWxvpaE7P3tsjYS1yL7knh76yUmo9vP202l+auvkUX1VjVi0Bp
 gb8BNn72T1dgV3wFrCFzADTPkREVboB4hYuvbKjRFmXWOO26EZ9+isKoxODRhXYreu60
 SFu7Es/Vqcn59yadvzSoV/d00ZwT9lilXfHfg5pzSoKPOf/g44y6z1WLgXgEezK9zVRF
 uALQ==
X-Gm-Message-State: AOJu0YwdXyfIj+x7LCrYcdCMx//jFe7ZnKgZO1EEgWOy9Wet/f+SmIXq
 xIt40CCIBvc02/AnX+nj+XeOIq0+wKHUF3QHDuI0Xw==
X-Google-Smtp-Source: AGHT+IGZoh11Uln0OxwxV9e+G1pJ51ZBYlvraf2PQOpg6T2qO8PpNAyNFDq2TIREEcITmteJYBfEdg==
X-Received: by 2002:a19:5f53:0:b0:507:a003:57a2 with SMTP id
 a19-20020a195f53000000b00507a00357a2mr1677205lfj.52.1697721201002; 
 Thu, 19 Oct 2023 06:13:21 -0700 (PDT)
Received: from m1x-phil.lan (176-131-216-177.abo.bbox.fr. [176.131.216.177])
 by smtp.gmail.com with ESMTPSA id
 q7-20020adffec7000000b0031980294e9fsm4462971wrs.116.2023.10.19.06.13.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Oct 2023 06:13:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 2/7] hw/ppc/pnv_xscom: Rename pnv_xscom_realize(Error **)
 -> pnv_xscom_init()
Date: Thu, 19 Oct 2023 15:13:00 +0200
Message-ID: <20231019131305.19157-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231019131305.19157-1-philmd@linaro.org>
References: <20231019131305.19157-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22e.google.com
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


