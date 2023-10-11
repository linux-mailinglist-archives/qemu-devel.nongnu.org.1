Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6207C5558
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 15:25:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqZCy-0007C9-Ar; Wed, 11 Oct 2023 09:25:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqZCp-00072q-Cf
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 09:24:57 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqZCn-0004Z6-IM
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 09:24:55 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-9b275afb6abso204079966b.1
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 06:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697030692; x=1697635492; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1k4hLIH5x/CYejK+Tga2Zv6nJJJ/LS2i152HT3xRn+4=;
 b=GnwPEoTak+FXUt0cvRIyJGNIkSPwf3osYiMp9rUrKSYPo41hXuO5ADHRr2lRejL+P5
 uB6X9riYw7uTsvdRAUYQQIphB+UyGCzdtjAH2yfO1Pa6UsTznI/uXJoPBFMbGS4E7gW4
 rHerPSZnMSgJcPBpZ4Bj1KJ27t8qYu/OZEcEV8XZ38pIDOGqOvLysTjLdzEfUmorjS+r
 3hLaR1Einra5Ac3WIvW7XrVts5GQ6gxLmT8XnxB4sBQz2ZJln6pOmbBXVOIlvFKUKNJt
 eC73HUstdAgm3N0qX3NBNX1mpW6GM68S5BJDhEt8YaGkdtNJwJ5mwGeyFXs9aGheO+n/
 Mf7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697030692; x=1697635492;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1k4hLIH5x/CYejK+Tga2Zv6nJJJ/LS2i152HT3xRn+4=;
 b=pUdE1MLkAJgIHpcghSscv9adA2pD0HWHUXjLcltTgolG+28G+OAFwe662sO6VbOtPl
 TYts2nH19PFUB7ZqkylcmbwFyO/Fs48hWYz5H+bs/byaPvQQy49qnIZtZqT3QVNJ15E7
 T6EWMnKa0t6EuSVnMj6cNRQNM5TvbLtkTZUISIG7BuwBMP1rX3Fub4sTUD53zOoOBSpj
 V9s2ofl260CsB98OKT6pvQkg5ch6AvtOcm1edKWI06UOIsUsM1+yUaXCje9JW0pqczdK
 Nux9GO8q4PQGZ0MNMz2g2LCerHXq+2QXE0+74yg1sNRCmbmTqETbCBT1eBRKILRTi1aR
 Jx9g==
X-Gm-Message-State: AOJu0Yy629E/SBnKLfxUtEuHxL8TIqM50QxjaDYKRnJ6j/sCxBm2ftHK
 G9O05h/C09hBU+rIBZpBogwRQt5wlmctN75E3pM=
X-Google-Smtp-Source: AGHT+IH9gKS1GaTk8i10QsXGGPYi0ByLmg9yY5iHoZ9wOfk9cSVWD5rkX7m6RKK0Uiyouv+mdIdTPA==
X-Received: by 2002:a17:907:8b8c:b0:9a9:f0e6:904e with SMTP id
 tb12-20020a1709078b8c00b009a9f0e6904emr15634129ejc.16.1697030691933; 
 Wed, 11 Oct 2023 06:24:51 -0700 (PDT)
Received: from m1x-phil.lan (mdq11-h01-176-173-161-48.dsl.sta.abo.bbox.fr.
 [176.173.161.48]) by smtp.gmail.com with ESMTPSA id
 rp19-20020a170906d97300b009b95b46bbd1sm9780620ejb.133.2023.10.11.06.24.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 11 Oct 2023 06:24:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, BALATON Zoltan <balaton@eik.bme.hu>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 4/5] hw/ppc/ppc4xx_pci: Move ppc4xx_pci.c to hw/pci-host/
Date: Wed, 11 Oct 2023 15:24:26 +0200
Message-ID: <20231011132427.65001-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231011132427.65001-1-philmd@linaro.org>
References: <20231011132427.65001-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
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

ppc4xx_pci.c is moved from the target specific ppc_ss[] meson
source set to pci_ss[] which is common to all targets: the
object is built once.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS                       | 1 +
 hw/{ppc => pci-host}/ppc4xx_pci.c | 0
 hw/pci-host/ppce500.c             | 2 +-
 hw/pci-host/meson.build           | 1 +
 hw/pci-host/trace-events          | 4 ++++
 hw/ppc/meson.build                | 1 -
 hw/ppc/trace-events               | 4 ----
 7 files changed, 7 insertions(+), 6 deletions(-)
 rename hw/{ppc => pci-host}/ppc4xx_pci.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 158896d03e..d7af23c1be 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1358,6 +1358,7 @@ Bamboo
 L: qemu-ppc@nongnu.org
 S: Orphan
 F: hw/ppc/ppc440_bamboo.c
+F: hw/pci-host/ppc4xx_pci.c
 F: tests/avocado/ppc_bamboo.py
 
 e500
diff --git a/hw/ppc/ppc4xx_pci.c b/hw/pci-host/ppc4xx_pci.c
similarity index 100%
rename from hw/ppc/ppc4xx_pci.c
rename to hw/pci-host/ppc4xx_pci.c
diff --git a/hw/pci-host/ppce500.c b/hw/pci-host/ppce500.c
index 38814247f2..c16bc255ed 100644
--- a/hw/pci-host/ppce500.c
+++ b/hw/pci-host/ppce500.c
@@ -5,7 +5,7 @@
  *
  * Author: Yu Liu,     <yu.liu@freescale.com>
  *
- * This file is derived from hw/ppc4xx_pci.c,
+ * This file is derived from ppc4xx_pci.c,
  * the copyright for that material belongs to the original owners.
  *
  * This is free software; you can redistribute it and/or modify
diff --git a/hw/pci-host/meson.build b/hw/pci-host/meson.build
index 64eada76fe..9cabac5d63 100644
--- a/hw/pci-host/meson.build
+++ b/hw/pci-host/meson.build
@@ -14,6 +14,7 @@ pci_ss.add(when: 'CONFIG_REMOTE_PCIHOST', if_true: files('remote.c'))
 pci_ss.add(when: 'CONFIG_SH_PCI', if_true: files('sh_pci.c'))
 
 # PPC devices
+pci_ss.add(when: 'CONFIG_PPC4XX_PCI', if_true: files('ppc4xx_pci.c'))
 pci_ss.add(when: 'CONFIG_RAVEN_PCI', if_true: files('raven.c'))
 pci_ss.add(when: 'CONFIG_GRACKLE_PCI', if_true: files('grackle.c'))
 # NewWorld PowerMac
diff --git a/hw/pci-host/trace-events b/hw/pci-host/trace-events
index 9d216bb89f..f8afb28a01 100644
--- a/hw/pci-host/trace-events
+++ b/hw/pci-host/trace-events
@@ -37,6 +37,10 @@ unin_data_read(uint64_t addr, unsigned len, uint64_t val) "read addr 0x%"PRIx64
 unin_write(uint64_t addr, uint64_t value) "addr=0x%" PRIx64 " val=0x%"PRIx64
 unin_read(uint64_t addr, uint64_t value) "addr=0x%" PRIx64 " val=0x%"PRIx64
 
+# ppc4xx_pci.c
+ppc4xx_pci_map_irq(int32_t devfn, int irq_num, int slot) "devfn 0x%x irq %d -> %d"
+ppc4xx_pci_set_irq(int irq_num) "PCI irq %d"
+
 # pnv_phb4.c
 pnv_phb4_xive_notify(uint64_t notif_port, uint64_t data) "notif=@0x%"PRIx64" data=0x%"PRIx64
 pnv_phb4_xive_notify_ic(uint64_t addr, uint64_t data) "addr=@0x%"PRIx64" data=0x%"PRIx64
diff --git a/hw/ppc/meson.build b/hw/ppc/meson.build
index 6931ba88b4..a4821da094 100644
--- a/hw/ppc/meson.build
+++ b/hw/ppc/meson.build
@@ -61,7 +61,6 @@ ppc_ss.add(when: 'CONFIG_PPC440', if_true: files(
 ppc_ss.add(when: 'CONFIG_PPC4XX', if_true: files(
   'ppc4xx_devs.c',
   'ppc4xx_sdram.c'))
-ppc_ss.add(when: 'CONFIG_PPC4XX_PCI', if_true: files('ppc4xx_pci.c'))
 ppc_ss.add(when: 'CONFIG_SAM460EX', if_true: files('sam460ex.c'))
 # PReP
 ppc_ss.add(when: 'CONFIG_PREP', if_true: files('prep.c'))
diff --git a/hw/ppc/trace-events b/hw/ppc/trace-events
index f670e8906c..b59fbf340f 100644
--- a/hw/ppc/trace-events
+++ b/hw/ppc/trace-events
@@ -146,10 +146,6 @@ rs6000mc_size_read(uint32_t addr, uint32_t val) "read addr=0x%x val=0x%x"
 rs6000mc_size_write(uint32_t addr, uint32_t val) "write addr=0x%x val=0x%x"
 rs6000mc_parity_read(uint32_t addr, uint32_t val) "read addr=0x%x val=0x%x"
 
-# ppc4xx_pci.c
-ppc4xx_pci_map_irq(int32_t devfn, int irq_num, int slot) "devfn 0x%x irq %d -> %d"
-ppc4xx_pci_set_irq(int irq_num) "PCI irq %d"
-
 # ppc440_pcix.c
 ppc440_pcix_map_irq(int32_t devfn, int irq_num, int slot) "devfn 0x%x irq %d -> %d"
 ppc440_pcix_set_irq(int irq_num) "PCI irq %d"
-- 
2.41.0


