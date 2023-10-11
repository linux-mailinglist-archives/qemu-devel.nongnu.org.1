Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 490687C5559
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 15:25:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqZDJ-0007Ub-W8; Wed, 11 Oct 2023 09:25:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqZCy-0007IR-TI
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 09:25:04 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqZCw-0004a5-OY
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 09:25:04 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-9b64b98656bso1161386466b.0
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 06:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697030697; x=1697635497; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yPOKwx+vha+69RBWTG45/wKN7dXRUEkgDKQ2NkwugtM=;
 b=IzhlVNWytK9S85m028Bua9BGwzQ5zCNRbhZh+gi0Y50pS4Tj53iymNs4S6w6xCw+0j
 a6aIUHqii1nZIRw5FcCK4ZU3jZxNpvVKWaJUAOglbc4rw2zbFpKME1u/cx8IzrSi+5az
 eMVF2U6EfFgfJqYy/qIDwMkTkkFVAIR6kONWItZRjfovDe9AUhhZvtwK6ovq28BrRzgq
 l/j+C8Jewals9nulqwNP5tt4NwyTWEeu70LCyNTSJlY0gHmHMAkK/CI+7rZWEBECkgXv
 sK8iBT0Ut1maXZHD03wpZ8fgDxI1F0Ml5eBiUNrqbZMKV7byAPdmUNepNJerwUpfNK3M
 9/oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697030697; x=1697635497;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yPOKwx+vha+69RBWTG45/wKN7dXRUEkgDKQ2NkwugtM=;
 b=hj+gAlUcHOwl/2+n5MVQSZ4TYGLEyHRgg2zH3XV+xuNQFU4fgIkMfVMVt1uSmkIYun
 ymkXicK4g34uCQM1S43GfcQDD+M6yAs8PEymkMdP+ymBY5kIamRUML63jqq1tCPEA5Ms
 NtScVPVYZL9RsX1QOGGLed9CMml1RRKNLuTXKT3FFQn0fauzin+y6LXyBF09uvpeMT5b
 lB43UrQ/41SV2Zr36KlrIDqJLy33g17AM6lETMwPvJbO8e8G3+FDTdJmvrDyTVnB9g2I
 viUGta5OT0n3za35pMXBpDtGFbDoCtGWnk+zPGTgC+RxtGLgCQP6cYTTsacf3UnbflYj
 Rz0w==
X-Gm-Message-State: AOJu0YwhBDvv0HN9rf+H0ubZVWjna+NZp15L/G41SMwqHYMHe/abgaQQ
 NPGRUKdIoVm3eOMzEiMdgES/EgMc0rCHc4csHsM=
X-Google-Smtp-Source: AGHT+IE155e9z3brfwDq65weTSXlDw7cl/kAChrAs9TbOrmoqEbJ61OLTe2nDypK5TVrYfMt0voCLA==
X-Received: by 2002:a17:906:3ca1:b0:9a1:891b:6eed with SMTP id
 b1-20020a1709063ca100b009a1891b6eedmr16899436ejh.76.1697030697334; 
 Wed, 11 Oct 2023 06:24:57 -0700 (PDT)
Received: from m1x-phil.lan (mdq11-h01-176-173-161-48.dsl.sta.abo.bbox.fr.
 [176.173.161.48]) by smtp.gmail.com with ESMTPSA id
 h16-20020a17090619d000b00997e99a662bsm9718613ejd.20.2023.10.11.06.24.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 11 Oct 2023 06:24:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, BALATON Zoltan <balaton@eik.bme.hu>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 5/5] hw/ppc/ppc440_pcix: Move ppc440_pcix.c to hw/pci-host/
Date: Wed, 11 Oct 2023 15:24:27 +0200
Message-ID: <20231011132427.65001-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231011132427.65001-1-philmd@linaro.org>
References: <20231011132427.65001-1-philmd@linaro.org>
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

ppc440_pcix.c is moved from the target specific ppc_ss[] meson
source set to pci_ss[] which is common to all targets: the
object is built once.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS                        | 2 +-
 hw/{ppc => pci-host}/ppc440_pcix.c | 0
 hw/pci-host/Kconfig                | 4 ++++
 hw/pci-host/meson.build            | 1 +
 hw/pci-host/trace-events           | 8 ++++++++
 hw/ppc/Kconfig                     | 1 +
 hw/ppc/meson.build                 | 2 +-
 hw/ppc/trace-events                | 8 --------
 8 files changed, 16 insertions(+), 10 deletions(-)
 rename hw/{ppc => pci-host}/ppc440_pcix.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index d7af23c1be..d727eab16b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1484,7 +1484,7 @@ L: qemu-ppc@nongnu.org
 S: Maintained
 F: hw/ppc/sam460ex.c
 F: hw/ppc/ppc440_uc.c
-F: hw/ppc/ppc440_pcix.c
+F: hw/pci-host/ppc440_pcix.c
 F: hw/display/sm501*
 F: hw/ide/sii3112.c
 F: hw/rtc/m41t80.c
diff --git a/hw/ppc/ppc440_pcix.c b/hw/pci-host/ppc440_pcix.c
similarity index 100%
rename from hw/ppc/ppc440_pcix.c
rename to hw/pci-host/ppc440_pcix.c
diff --git a/hw/pci-host/Kconfig b/hw/pci-host/Kconfig
index a9030a433b..19b25b2092 100644
--- a/hw/pci-host/Kconfig
+++ b/hw/pci-host/Kconfig
@@ -10,6 +10,10 @@ config PPC4XX_PCI
     bool
     select PCI
 
+config PPC440_PCI
+    bool
+    select PCI
+
 config RAVEN_PCI
     bool
     select PCI
diff --git a/hw/pci-host/meson.build b/hw/pci-host/meson.build
index 9cabac5d63..d724656f70 100644
--- a/hw/pci-host/meson.build
+++ b/hw/pci-host/meson.build
@@ -15,6 +15,7 @@ pci_ss.add(when: 'CONFIG_SH_PCI', if_true: files('sh_pci.c'))
 
 # PPC devices
 pci_ss.add(when: 'CONFIG_PPC4XX_PCI', if_true: files('ppc4xx_pci.c'))
+pci_ss.add(when: 'CONFIG_PPC440_PCI', if_true: files('ppc440_pcix.c'))
 pci_ss.add(when: 'CONFIG_RAVEN_PCI', if_true: files('raven.c'))
 pci_ss.add(when: 'CONFIG_GRACKLE_PCI', if_true: files('grackle.c'))
 # NewWorld PowerMac
diff --git a/hw/pci-host/trace-events b/hw/pci-host/trace-events
index f8afb28a01..c902f1cde6 100644
--- a/hw/pci-host/trace-events
+++ b/hw/pci-host/trace-events
@@ -41,6 +41,14 @@ unin_read(uint64_t addr, uint64_t value) "addr=0x%" PRIx64 " val=0x%"PRIx64
 ppc4xx_pci_map_irq(int32_t devfn, int irq_num, int slot) "devfn 0x%x irq %d -> %d"
 ppc4xx_pci_set_irq(int irq_num) "PCI irq %d"
 
+# ppc440_pcix.c
+ppc440_pcix_map_irq(int32_t devfn, int irq_num, int slot) "devfn 0x%x irq %d -> %d"
+ppc440_pcix_set_irq(int irq_num) "PCI irq %d"
+ppc440_pcix_update_pim(int idx, uint64_t size, uint64_t la) "Added window %d of size=0x%" PRIx64 " to CPU=0x%" PRIx64
+ppc440_pcix_update_pom(int idx, uint32_t size, uint64_t la, uint64_t pcia) "Added window %d of size=0x%x from CPU=0x%" PRIx64 " to PCI=0x%" PRIx64
+ppc440_pcix_reg_read(uint64_t addr, uint32_t val) "addr 0x%" PRIx64 " = 0x%" PRIx32
+ppc440_pcix_reg_write(uint64_t addr, uint32_t val, uint32_t size) "addr 0x%" PRIx64 " = 0x%" PRIx32 " size 0x%" PRIx32
+
 # pnv_phb4.c
 pnv_phb4_xive_notify(uint64_t notif_port, uint64_t data) "notif=@0x%"PRIx64" data=0x%"PRIx64
 pnv_phb4_xive_notify_ic(uint64_t addr, uint64_t data) "addr=@0x%"PRIx64" data=0x%"PRIx64
diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
index e4e76e87a2..fc26c775ab 100644
--- a/hw/ppc/Kconfig
+++ b/hw/ppc/Kconfig
@@ -46,6 +46,7 @@ config PPC440
     imply TEST_DEVICES
     imply E1000_PCI
     select PCI_EXPRESS
+    select PPC440_PCI
     select PPC4XX
     select SERIAL
     select FDT_PPC
diff --git a/hw/ppc/meson.build b/hw/ppc/meson.build
index a4821da094..09dfdafe79 100644
--- a/hw/ppc/meson.build
+++ b/hw/ppc/meson.build
@@ -57,7 +57,7 @@ ppc_ss.add(when: 'CONFIG_PPC405', if_true: files(
   'ppc405_uc.c'))
 ppc_ss.add(when: 'CONFIG_PPC440', if_true: files(
   'ppc440_bamboo.c',
-  'ppc440_pcix.c', 'ppc440_uc.c'))
+  'ppc440_uc.c'))
 ppc_ss.add(when: 'CONFIG_PPC4XX', if_true: files(
   'ppc4xx_devs.c',
   'ppc4xx_sdram.c'))
diff --git a/hw/ppc/trace-events b/hw/ppc/trace-events
index b59fbf340f..157ea756e9 100644
--- a/hw/ppc/trace-events
+++ b/hw/ppc/trace-events
@@ -146,14 +146,6 @@ rs6000mc_size_read(uint32_t addr, uint32_t val) "read addr=0x%x val=0x%x"
 rs6000mc_size_write(uint32_t addr, uint32_t val) "write addr=0x%x val=0x%x"
 rs6000mc_parity_read(uint32_t addr, uint32_t val) "read addr=0x%x val=0x%x"
 
-# ppc440_pcix.c
-ppc440_pcix_map_irq(int32_t devfn, int irq_num, int slot) "devfn 0x%x irq %d -> %d"
-ppc440_pcix_set_irq(int irq_num) "PCI irq %d"
-ppc440_pcix_update_pim(int idx, uint64_t size, uint64_t la) "Added window %d of size=0x%" PRIx64 " to CPU=0x%" PRIx64
-ppc440_pcix_update_pom(int idx, uint32_t size, uint64_t la, uint64_t pcia) "Added window %d of size=0x%x from CPU=0x%" PRIx64 " to PCI=0x%" PRIx64
-ppc440_pcix_reg_read(uint64_t addr, uint32_t val) "addr 0x%" PRIx64 " = 0x%" PRIx32
-ppc440_pcix_reg_write(uint64_t addr, uint32_t val, uint32_t size) "addr 0x%" PRIx64 " = 0x%" PRIx32 " size 0x%" PRIx32
-
 # ppc405_boards.c
 opba_readb(uint64_t addr, uint32_t val) "addr 0x%" PRIx64 " = 0x%" PRIx32
 opba_writeb(uint64_t addr, uint64_t val) "addr 0x%" PRIx64 " = 0x%" PRIx64
-- 
2.41.0


