Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2553D836409
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 14:09:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRu2V-0000QU-K5; Mon, 22 Jan 2024 08:08:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1rRu2T-0000PR-8p
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 08:08:33 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1rRu2Q-00014o-Ck
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 08:08:33 -0500
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id DD65A40C7D
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 13:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1705928904;
 bh=b7X2gRLH2+ioJPNZlKzeQQwfouAWlJRwXIBwib944hk=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=uTv/BUZCXNYrWfwQwqOzQJLIQuKMJjwfCIQ+vhFBx+aR0obbie2dOyNZ4WwYFbIUt
 k2cFrGs9Rr5YRbRSworWnoJEHv0BUGAR4PGAFQeQqN04XSouZ5CqnSaInb1RpE6Exr
 0/3oJdqYR8vqaNcKf1LmSZMrEPwW+DVJtXnUGPYrhrNqEzVb63PdeQIu7tc6rT11IX
 cfgPBYzHkEsrfTFME9NHzpRe15XIHU6mjjnqikKv3lsLQD8xSFj3Y9jgx7Veq94oxk
 5MtT/zleIMsGO2b54hfv8qJmd1FkQjwGU9NhEPAU2KUQ0Pb4umDGOJVK/9GMT7xuJS
 eG9KGbzDs0ZiA==
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-40e435a606aso24459485e9.3
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 05:08:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705928904; x=1706533704;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b7X2gRLH2+ioJPNZlKzeQQwfouAWlJRwXIBwib944hk=;
 b=SYPiDYGe313SXfQoSuEoR6u+wUJN0CWw1fUCJ2GS7Qr8o58etz2sY3S28JIBoJQIS2
 3LaTIfdx2FP91r+34CRPLXP3swaRe2WDOvmZ1mdHMGWCHt/LeXuh/oNb1PYgu3aTo/Y4
 fWfn1dk4iKpC9VhNn7pf7npUDHKmWj9jSGwaigeXTtLTiq7lPmJNFYB1Myyg+kUT7p99
 KrrBIbxkW6uLRscrC5FTVRrVi6XOdziRuL9mk9Nomngq7WrssrZ9slPNlh1EJq981SnZ
 2u0ULqX83NrNRFwGOZfIIx+44x4XrTraZ7d9RMk2ipK259hb3k6IEtdVUSMfRR8tPQRv
 BOrQ==
X-Gm-Message-State: AOJu0YxdUIhwCsC1+67RR71I719uqs8q/Bvo7O5vD8xW61JSNKDbYrS+
 0Zsj8XK4ku1jO/yrNevOR1QyC12rLRAH+NQLt8wSSgnKym1gY2ngU3dg7Fl8vU9Gdxmhqxs5ser
 +rFeR60OzikrB31TFOypEP3Po+no7cvx3SQzRwfg02fBDNo7k34Wi3Pj9xGGkK2uXAiUQ
X-Received: by 2002:a05:600c:198a:b0:40e:761d:a553 with SMTP id
 t10-20020a05600c198a00b0040e761da553mr2520396wmq.37.1705928903764; 
 Mon, 22 Jan 2024 05:08:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHKbjlXrSXSJepVT35Gjc2LU0DDw+dNQ9IwGbJmzfdStcDczA/bTCWkZCwkHSWcajaW3uvCjw==
X-Received: by 2002:a05:600c:198a:b0:40e:761d:a553 with SMTP id
 t10-20020a05600c198a00b0040e761da553mr2520384wmq.37.1705928903498; 
 Mon, 22 Jan 2024 05:08:23 -0800 (PST)
Received: from workstation5.fritz.box
 (ip-178-202-040-247.um47.pools.vodafone-ip.de. [178.202.40.247])
 by smtp.gmail.com with ESMTPSA id
 v21-20020a05600c445500b0040d62f89381sm39214456wmn.35.2024.01.22.05.08.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jan 2024 05:08:23 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>
Cc: Andrew Jones <ajones@ventanamicro.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Bin Meng <bin.meng@windriver.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v3 3/4] target/riscv: SMBIOS support for RISC-V virt machine
Date: Mon, 22 Jan 2024 14:07:57 +0100
Message-ID: <20240122130758.74051-4-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122130758.74051-1-heinrich.schuchardt@canonical.com>
References: <20240122130758.74051-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.125.188.123;
 envelope-from=heinrich.schuchardt@canonical.com;
 helo=smtp-relay-internal-1.canonical.com
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.289,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Generate SMBIOS tables for the RISC-V mach-virt.
Add CONFIG_SMBIOS=y to the RISC-V default config.
Set the default processor family in the type 4 table.

The implementation is based on the corresponding ARM and Loongson code.

With the patch the following firmware tables are provided:

    etc/smbios/smbios-anchor
    etc/smbios/smbios-tables

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v3:
	use misa_mxl_max to determine bitness
v2:
	set processor family
---
 hw/riscv/Kconfig |  1 +
 hw/riscv/virt.c  | 44 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index a50717be87..5d644eb7b1 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -41,6 +41,7 @@ config RISCV_VIRT
     select RISCV_IMSIC
     select SIFIVE_PLIC
     select SIFIVE_TEST
+    select SMBIOS
     select VIRTIO_MMIO
     select FW_CFG_DMA
     select PLATFORM_BUS
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index f9fd1341fc..1b333af4f0 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -36,6 +36,7 @@
 #include "hw/riscv/boot.h"
 #include "hw/riscv/numa.h"
 #include "kvm/kvm_riscv.h"
+#include "hw/firmware/smbios.h"
 #include "hw/intc/riscv_aclint.h"
 #include "hw/intc/riscv_aplic.h"
 #include "hw/intc/sifive_plic.h"
@@ -1263,6 +1264,47 @@ static void create_platform_bus(RISCVVirtState *s, DeviceState *irqchip)
                                 sysbus_mmio_get_region(sysbus, 0));
 }
 
+static void virt_build_smbios(RISCVVirtState *s)
+{
+    MachineClass *mc = MACHINE_GET_CLASS(s);
+    MachineState *ms = MACHINE(s);
+    uint8_t *smbios_tables, *smbios_anchor;
+    size_t smbios_tables_len, smbios_anchor_len;
+    struct smbios_phys_mem_area mem_array;
+    const char *product = "QEMU Virtual Machine";
+
+    if (kvm_enabled()) {
+        product = "KVM Virtual Machine";
+    }
+
+    smbios_set_defaults("QEMU", product, mc->name, false,
+                        true, SMBIOS_ENTRY_POINT_TYPE_64);
+
+    if (riscv_is_32bit(&s->soc[0])) {
+        smbios_set_default_processor_family(0x200);
+#if defined(TARGET_RISCV64)
+    } else {
+        smbios_set_default_processor_family(0x201);
+#endif
+    }
+
+    /* build the array of physical mem area from base_memmap */
+    mem_array.address = s->memmap[VIRT_DRAM].base;
+    mem_array.length = ms->ram_size;
+
+    smbios_get_tables(ms, &mem_array, 1,
+                      &smbios_tables, &smbios_tables_len,
+                      &smbios_anchor, &smbios_anchor_len,
+                      &error_fatal);
+
+    if (smbios_anchor) {
+        fw_cfg_add_file(s->fw_cfg, "etc/smbios/smbios-tables",
+                        smbios_tables, smbios_tables_len);
+        fw_cfg_add_file(s->fw_cfg, "etc/smbios/smbios-anchor",
+                        smbios_anchor, smbios_anchor_len);
+    }
+}
+
 static void virt_machine_done(Notifier *notifier, void *data)
 {
     RISCVVirtState *s = container_of(notifier, RISCVVirtState,
@@ -1351,6 +1393,8 @@ static void virt_machine_done(Notifier *notifier, void *data)
         riscv_setup_direct_kernel(kernel_entry, fdt_load_addr);
     }
 
+    virt_build_smbios(s);
+
     if (virt_is_acpi_enabled(s)) {
         virt_acpi_setup(s);
     }
-- 
2.43.0


