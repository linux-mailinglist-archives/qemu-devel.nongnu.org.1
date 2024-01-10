Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF168295B6
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 10:06:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNUQa-0003fE-G4; Wed, 10 Jan 2024 03:59:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rNUQX-0003V0-Hh
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 03:59:09 -0500
Received: from mail-oo1-xc36.google.com ([2607:f8b0:4864:20::c36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rNUQV-0003wE-PD
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 03:59:09 -0500
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-5957ede4deaso2418655eaf.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 00:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704877145; x=1705481945; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cppkaJ6wtACDZQcroMZndN9TOfbthCC6383SXg9WGrM=;
 b=B6rv2BsKezSmLUnE7ma9lN/vU9OgiwhOi2v98xQq1mCGauMDUYA8m56lk9JUMH5T9Q
 +NwqlOUOtWRMRulDluSPgj/nBooNGPtoJ4ZVTkWtvfYKpl/NdWMJ53Aq75cHAOPAv3cY
 pTiTYnpKWdZ6/G4gzVbzgUQO0vxrrWpcXWx8xo3x2yIj7nSs1nrEiY7Dh1N13Yg+HgDA
 us7dxmQISVCGIC1LJd5cadV5P0RRwcNnrH0yADEvmOKABveSFy21DLylr9VXYxRhr7fG
 LGTs5k1klAo5qMIwketBq7GotCx14HwpehZ7SmGfqZNDy2msn4TnITKQdh816cdsNTqC
 jLMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704877145; x=1705481945;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cppkaJ6wtACDZQcroMZndN9TOfbthCC6383SXg9WGrM=;
 b=hUAS6JfgdyoaaGGJv+z5Eq/ayRKImkq/Bgam7Nc6PjfJKFEV/1T/ebzOxbr5vw7y8H
 cqcOdwT/m883o1gW79fwD73rCMh4sryMexNl4Pue+axrLgBy3v/LyjhXsOg0l9brIYXh
 Gl0tmHSkANYm71oK84zQeRieZ00dVKbrSejYRDRzkuwTBcBuTWvR7kt+8mUmQS0UmuLl
 KG7zTHq5+SRgzhx7nkzFn6V1DIXPsu+vs+uUZKUdwz9339A2xDBlKQI3x6fMiUXblvhk
 4aE3eCifsvnC3hAMa2ApmMUtIkgLrtHiXms11hW5BCT5gLZdbcQvVDd67woV+zrtBDQL
 eKUA==
X-Gm-Message-State: AOJu0YwKUPo0P0x0KLyxJnQCeFoI/t1NBBG/IMomKmCMd3QTGyrZNHLB
 GMZprFMoHAKsprDSleGJ9+c6SFjOM9/ifrYl
X-Google-Smtp-Source: AGHT+IFBLGexlr9wm7jEtP2VWODz3y7bCvPd9ZZvm23noENn+OSPSuF+cHT39YywKK1nZPACQjwFuQ==
X-Received: by 2002:a05:6358:6f1b:b0:174:b61a:daa9 with SMTP id
 r27-20020a0563586f1b00b00174b61adaa9mr767584rwn.47.1704877144916; 
 Wed, 10 Jan 2024 00:59:04 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 t65-20020a628144000000b006d9879ba6besm3223814pfd.170.2024.01.10.00.59.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 00:59:04 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Sunil V L <sunilvl@ventanamicro.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PULL 21/65] hw/pci-host/gpex: Define properties for MMIO ranges
Date: Wed, 10 Jan 2024 18:56:49 +1000
Message-ID: <20240110085733.1607526-22-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240110085733.1607526-1-alistair.francis@wdc.com>
References: <20240110085733.1607526-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c36;
 envelope-from=alistair23@gmail.com; helo=mail-oo1-xc36.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Sunil V L <sunilvl@ventanamicro.com>

ACPI DSDT generator needs information like ECAM range, PIO range, 32-bit
and 64-bit PCI MMIO range etc related to the PCI host bridge. Instead of
making these values machine specific, create properties for the GPEX
host bridge with default value 0. During initialization, the firmware
can initialize these properties with correct values for the platform.
This basically allows DSDT generator code independent of the machine
specific memory map accesses.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20231218150247.466427-11-sunilvl@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/pci-host/gpex.h | 28 ++++++++++++++++++++--------
 hw/pci-host/gpex-acpi.c    | 13 +++++++++++++
 hw/pci-host/gpex.c         | 12 ++++++++++++
 3 files changed, 45 insertions(+), 8 deletions(-)

diff --git a/include/hw/pci-host/gpex.h b/include/hw/pci-host/gpex.h
index b0240bd768..dce883573b 100644
--- a/include/hw/pci-host/gpex.h
+++ b/include/hw/pci-host/gpex.h
@@ -40,6 +40,15 @@ struct GPEXRootState {
     /*< public >*/
 };
 
+struct GPEXConfig {
+    MemMapEntry ecam;
+    MemMapEntry mmio32;
+    MemMapEntry mmio64;
+    MemMapEntry pio;
+    int         irq;
+    PCIBus      *bus;
+};
+
 struct GPEXHost {
     /*< private >*/
     PCIExpressHost parent_obj;
@@ -55,19 +64,22 @@ struct GPEXHost {
     int irq_num[GPEX_NUM_IRQS];
 
     bool allow_unmapped_accesses;
-};
 
-struct GPEXConfig {
-    MemMapEntry ecam;
-    MemMapEntry mmio32;
-    MemMapEntry mmio64;
-    MemMapEntry pio;
-    int         irq;
-    PCIBus      *bus;
+    struct GPEXConfig gpex_cfg;
 };
 
 int gpex_set_irq_num(GPEXHost *s, int index, int gsi);
 
 void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg);
+void acpi_dsdt_add_gpex_host(Aml *scope, uint32_t irq);
+
+#define PCI_HOST_PIO_BASE               "x-pio-base"
+#define PCI_HOST_PIO_SIZE               "x-pio-size"
+#define PCI_HOST_ECAM_BASE              "x-ecam-base"
+#define PCI_HOST_ECAM_SIZE              "x-ecam-size"
+#define PCI_HOST_BELOW_4G_MMIO_BASE     "x-below-4g-mmio-base"
+#define PCI_HOST_BELOW_4G_MMIO_SIZE     "x-below-4g-mmio-size"
+#define PCI_HOST_ABOVE_4G_MMIO_BASE     "x-above-4g-mmio-base"
+#define PCI_HOST_ABOVE_4G_MMIO_SIZE     "x-above-4g-mmio-size"
 
 #endif /* HW_GPEX_H */
diff --git a/hw/pci-host/gpex-acpi.c b/hw/pci-host/gpex-acpi.c
index 1092dc3b70..f69413ea2c 100644
--- a/hw/pci-host/gpex-acpi.c
+++ b/hw/pci-host/gpex-acpi.c
@@ -281,3 +281,16 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
 
     crs_range_set_free(&crs_range_set);
 }
+
+void acpi_dsdt_add_gpex_host(Aml *scope, uint32_t irq)
+{
+    bool ambig;
+    Object *obj = object_resolve_path_type("", TYPE_GPEX_HOST, &ambig);
+
+    if (!obj || ambig) {
+        return;
+    }
+
+    GPEX_HOST(obj)->gpex_cfg.irq = irq;
+    acpi_dsdt_add_gpex(scope, &GPEX_HOST(obj)->gpex_cfg);
+}
diff --git a/hw/pci-host/gpex.c b/hw/pci-host/gpex.c
index e117e47fa7..e9cf455bf5 100644
--- a/hw/pci-host/gpex.c
+++ b/hw/pci-host/gpex.c
@@ -154,6 +154,18 @@ static Property gpex_host_properties[] = {
      */
     DEFINE_PROP_BOOL("allow-unmapped-accesses", GPEXHost,
                      allow_unmapped_accesses, true),
+    DEFINE_PROP_UINT64(PCI_HOST_ECAM_BASE, GPEXHost, gpex_cfg.ecam.base, 0),
+    DEFINE_PROP_SIZE(PCI_HOST_ECAM_SIZE, GPEXHost, gpex_cfg.ecam.size, 0),
+    DEFINE_PROP_UINT64(PCI_HOST_PIO_BASE, GPEXHost, gpex_cfg.pio.base, 0),
+    DEFINE_PROP_SIZE(PCI_HOST_PIO_SIZE, GPEXHost, gpex_cfg.pio.size, 0),
+    DEFINE_PROP_UINT64(PCI_HOST_BELOW_4G_MMIO_BASE, GPEXHost,
+                       gpex_cfg.mmio32.base, 0),
+    DEFINE_PROP_SIZE(PCI_HOST_BELOW_4G_MMIO_SIZE, GPEXHost,
+                     gpex_cfg.mmio32.size, 0),
+    DEFINE_PROP_UINT64(PCI_HOST_ABOVE_4G_MMIO_BASE, GPEXHost,
+                       gpex_cfg.mmio64.base, 0),
+    DEFINE_PROP_SIZE(PCI_HOST_ABOVE_4G_MMIO_SIZE, GPEXHost,
+                     gpex_cfg.mmio64.size, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.43.0


