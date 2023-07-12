Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 54596750EC8
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 18:41:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJctS-0004HK-FJ; Wed, 12 Jul 2023 12:40:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1qJct9-00044F-VQ
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 12:40:29 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1qJct8-0004xg-5i
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 12:40:27 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-666e5f0d60bso4318879b3a.3
 for <qemu-devel@nongnu.org>; Wed, 12 Jul 2023 09:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1689180025; x=1691772025;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UDJklPWbpmzjeGlIoYoqWiW3V0w+91rmuRkvLrG1pXI=;
 b=TvF/gay2JCiOrKJF6eDNO5PQMaTtYQ4BcZwFCfv4uhc9GA6pJU1JYvjB0Z5wU/UJu7
 7CqIMVAxyIeOphmtuASngvHCn1AYWKkg2q65wmSG0DC9Jmjm+ImxhL7UOm7u+YkRfOyw
 mHRhRSXfMu9mbnhQyECf0zUCAHFHXoDl0nR6eCq5MgzYADjLtsj3nd0Vz/pGiX8SKex0
 +w4y1AKSJYFHqfHC4cr+rheF3dy5c68R6bfC1eFuPmq2eP66EQV2KKJalXW3kpMYssnD
 +Q0+KAQOgPnETP1vTI7btbdDvOGQbyafjKfwja16QE7CQObgOrb+W19Kg30q8g9lWS7/
 Pcow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689180025; x=1691772025;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UDJklPWbpmzjeGlIoYoqWiW3V0w+91rmuRkvLrG1pXI=;
 b=c3+e5xZUVmjepTCsya5k4LJxY9UR345Op+3d4eUrc6meOj72rEmAYXR7sGWvZjQh6d
 s0VuANkVH2ozyybylUCNBDuBPpFjwnsQIPcHtJO38qcWaC/tY5jTz3IfFN4zbHNwU9V8
 7ZwNBtxnDIN/EhiGqcs/VHgJH39iHQio1wrWqcKKtVNdv9Sq3i7VqtSORTeIhjfXtkkB
 CYB+IDIx6tU2PDIbKyEQFCwPCbaIsPfYqI2ccNGnWrH6T3DzscTSytnZ6mgHOV/5HgE+
 tWp31rJAGUgsaRXDnU1r8AxIphrvU8+AF9d9yaqbK0/rqoO+M7W3grbtFH9D0kpAzovZ
 7Dvg==
X-Gm-Message-State: ABy/qLa57cwByTfdy/h1Trwgg2PwSRXoTZqAJCM2XGUOBt0Ub6Bpi7cr
 eM1A+mmzzYTRbOWMnJK2ZfaAQv5LExc/hHUep7o=
X-Google-Smtp-Source: APBJJlHAbyYhk8r0g3E+WzHTGvkI3ORNlHJtAe0lACozxmHBjwLIa6KbnMSbnqVqEECqLzKBeSHQ4Q==
X-Received: by 2002:a05:6a20:440a:b0:12f:1d09:f1c3 with SMTP id
 ce10-20020a056a20440a00b0012f1d09f1c3mr19085127pzb.54.1689180024856; 
 Wed, 12 Jul 2023 09:40:24 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.190.25])
 by smtp.gmail.com with ESMTPSA id
 a18-20020a1709027d9200b001ac7f583f72sm4172824plm.209.2023.07.12.09.40.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jul 2023 09:40:24 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	qemu-riscv@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Anup Patel <apatel@ventanamicro.com>, Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH 07/10] hw/riscv/virt-acpi-build.c: Add APLIC in the MADT
Date: Wed, 12 Jul 2023 22:09:40 +0530
Message-Id: <20230712163943.98994-8-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230712163943.98994-1-sunilvl@ventanamicro.com>
References: <20230712163943.98994-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Add APLIC structures for each socket in the MADT when
system is configured with APLIC as the external wired
interrupt controller.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 hw/riscv/virt-acpi-build.c | 36 ++++++++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
index ebdc3bffea..9f2d0c92b0 100644
--- a/hw/riscv/virt-acpi-build.c
+++ b/hw/riscv/virt-acpi-build.c
@@ -276,9 +276,9 @@ static void build_madt(GArray *table_data,
     MachineClass *mc = MACHINE_GET_CLASS(s);
     MachineState *ms = MACHINE(s);
     const CPUArchIdList *arch_ids = mc->possible_cpu_arch_ids(ms);
-    uint64_t imsic_socket_addr, imsic_addr;
+    uint64_t imsic_socket_addr, imsic_addr, aplic_addr;
+    uint32_t imsic_size, gsi_base;
     uint8_t  guest_index_bits;
-    uint32_t imsic_size;
     uint32_t local_cpu_id, socket_id;
     uint8_t  hart_index_bits, group_index_bits, group_index_shift;
     uint16_t imsic_max_hart_per_socket = 0;
@@ -340,6 +340,38 @@ static void build_madt(GArray *table_data,
         build_append_int_noprefix(table_data, group_index_shift, 1);
     }
 
+    if (s->aia_type != VIRT_AIA_TYPE_NONE) {
+        /* APLICs */
+        for (socket = 0; socket < riscv_socket_count(ms); socket++) {
+            aplic_addr = s->memmap[VIRT_APLIC_S].base +
+                             s->memmap[VIRT_APLIC_S].size * socket;
+            gsi_base = VIRT_IRQCHIP_NUM_SOURCES * socket;
+            build_append_int_noprefix(table_data, 0x1A, 1);    /* Type */
+            build_append_int_noprefix(table_data, 36, 1);      /* Length */
+            build_append_int_noprefix(table_data, 1, 1);       /* Version */
+            build_append_int_noprefix(table_data, socket, 1);  /* APLIC ID */
+            build_append_int_noprefix(table_data, 0, 4);       /* Flags */
+            build_append_int_noprefix(table_data, 0, 8);       /* Hardware ID */
+            /* Number of IDCs */
+            if (s->aia_type == VIRT_AIA_TYPE_APLIC) {
+                build_append_int_noprefix(table_data,
+                                          s->soc[socket].num_harts,
+                                          2);
+            } else {
+                build_append_int_noprefix(table_data, 0, 2);
+            }
+            /* Total External Interrupt Sources Supported */
+            build_append_int_noprefix(table_data, VIRT_IRQCHIP_NUM_SOURCES, 2);
+            /* Global System Interrupt Base */
+            build_append_int_noprefix(table_data, gsi_base, 4);
+            /* APLIC Address */
+            build_append_int_noprefix(table_data, aplic_addr, 8);
+            /* APLIC size */
+            build_append_int_noprefix(table_data,
+                                      s->memmap[VIRT_APLIC_S].size, 4);
+        }
+    }
+
     acpi_table_end(linker, &table);
 }
 
-- 
2.39.2


