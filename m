Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB2281FF52
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Dec 2023 13:08:56 +0100 (CET)
Received: from [::1] (helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJBeZ-0007uP-8M; Fri, 29 Dec 2023 07:07:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1rJBeR-0007nJ-1a
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 07:07:43 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heinrich.schuchardt@canonical.com>)
 id 1rJBeP-00053U-7h
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 07:07:42 -0500
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 236243F62F
 for <qemu-devel@nongnu.org>; Fri, 29 Dec 2023 12:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1703851658;
 bh=vemdfnw4fuVMX6G6P9tHcMdWkK1pe467+6wedQ7UONs=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=Low88jdCimMODqu9PcrokdOX9DjvHJqz+WRXm1b5wbSRfHNkJk+eEcU+GwWqWWRP/
 SRzMrBiv/+aSxwi4BRKkfUyKPgfEpyiSeL9GjmQ08hgtF5xH3c+3ABfqYe9ZihrUkS
 kaHcpA4RE7jiLbEGsPqvwvHtNTaQU6n+PcgH8u08prWrPGXyckntOI2/Vv0D+wX1QM
 PIM3Fv99nCKK19vN9EBwkMi0eMviyRf5otX4WMfqeVHct0ZqEHqeRD+9rFjKVvMc7y
 od06mWWj1XJLCQLo8YOZjhE6WiF6QZeU02Z6pvfByJMNtV3nKtBKEM0xUCB4tEpnU2
 EaJfIkn7P5ChQ==
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-554db6c03daso2267086a12.2
 for <qemu-devel@nongnu.org>; Fri, 29 Dec 2023 04:07:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703851651; x=1704456451;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vemdfnw4fuVMX6G6P9tHcMdWkK1pe467+6wedQ7UONs=;
 b=HjMt6ZiuXAyd7xFUAr5RugEHIonWA7Akppv9W1sWyneGHibQGqLNCvBsIgkDsNUsoP
 HgGIibnakVzJonqTs208QZtup3BdiAdk1R5Wzfz/6g2vvq/VC5ea7K5LC+e9v29rtb/U
 tleKexTPzfXnrlmRmLTFUzZR2VS/O2PN7rHz65gTTxJyZW0Sn2ynWeCER7bKEVv9frJj
 mFhramelAtacax13MNWyul5u5HOIoVTLbtnoDLkjprs1LSdf6kSjqvUm/9ioF0AFMG5u
 SbJVDFSj0Nf4AUH/VmKE9yDEl0pE6DHuKWyz+Y/XZkHQvLrPRowoa1AhhgDDbLtlEg2t
 lviA==
X-Gm-Message-State: AOJu0YyA4bMNdFoe6W4fkerDMiPWOklYjVCQ1FWVedyNM5zI4EbQpbgd
 dBXLPj9w6l7hagnUVHKQTaNmNBeWqP2mqLOaZGGOSe+ojX/uyNWDCni6jByGWPgrkaskcGyxs8j
 z3mtt/Dzcyg8pYPuEmzEN2LmsrpB7VgsUFTb1ejA=
X-Received: by 2002:aa7:d592:0:b0:553:8a0a:f053 with SMTP id
 r18-20020aa7d592000000b005538a0af053mr5134882edq.39.1703851651056; 
 Fri, 29 Dec 2023 04:07:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF9JKnUW3UpSebinoLxEPUFyKK44kliTvqEam9lUE/DJ2bFkoorpyotsfBbD5KpKg9TibBpnA==
X-Received: by 2002:aa7:d592:0:b0:553:8a0a:f053 with SMTP id
 r18-20020aa7d592000000b005538a0af053mr5134871edq.39.1703851650825; 
 Fri, 29 Dec 2023 04:07:30 -0800 (PST)
Received: from x13s.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de.
 [178.202.40.247]) by smtp.gmail.com with ESMTPSA id
 j20-20020aa7c0d4000000b005527de2aecfsm10943344edp.42.2023.12.29.04.07.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Dec 2023 04:07:30 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Bin Meng <bin.meng@windriver.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 3/4] target/riscv: SMBIOS support for RISC-V virt machine
Date: Fri, 29 Dec 2023 13:07:23 +0100
Message-ID: <20231229120724.41383-4-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231229120724.41383-1-heinrich.schuchardt@canonical.com>
References: <20231229120724.41383-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.125.188.123;
 envelope-from=heinrich.schuchardt@canonical.com;
 helo=smtp-relay-internal-1.canonical.com
X-Spam_score_int: -69
X-Spam_score: -7.0
X-Spam_bar: -------
X-Spam_report: (-7.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.553,
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
v2:
	set processor family
---
 hw/riscv/Kconfig |  1 +
 hw/riscv/virt.c  | 42 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index b6a5eb4452..1e11ac9432 100644
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
index d2eac24156..a876dd8f34 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -36,6 +36,7 @@
 #include "hw/riscv/boot.h"
 #include "hw/riscv/numa.h"
 #include "kvm/kvm_riscv.h"
+#include "hw/firmware/smbios.h"
 #include "hw/intc/riscv_aclint.h"
 #include "hw/intc/riscv_aplic.h"
 #include "hw/intc/riscv_imsic.h"
@@ -1249,6 +1250,45 @@ static void create_platform_bus(RISCVVirtState *s, DeviceState *irqchip)
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
+#if defined(TARGET_RISCV32)
+    smbios_set_default_processor_family(0x200);
+#elif defined(TARGET_RISCV64)
+    smbios_set_default_processor_family(0x201);
+#endif
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
@@ -1337,6 +1377,8 @@ static void virt_machine_done(Notifier *notifier, void *data)
         riscv_setup_direct_kernel(kernel_entry, fdt_load_addr);
     }
 
+    virt_build_smbios(s);
+
     if (virt_is_acpi_enabled(s)) {
         virt_acpi_setup(s);
     }
-- 
2.43.0


