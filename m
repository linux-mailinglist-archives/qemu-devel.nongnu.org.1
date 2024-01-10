Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F36548295A0
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 10:04:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNUQE-0002HN-JA; Wed, 10 Jan 2024 03:58:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rNUQB-00026i-R9
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 03:58:47 -0500
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rNUQ9-0003kN-Tp
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 03:58:47 -0500
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-6dc025dd9a9so2559729a34.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 00:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704877123; x=1705481923; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9d/TYW3E9SH0fGv9BZLabKIv535/lV9pcT9R9tUm+Ek=;
 b=EMNwnJLjnOKzhK/Eaq+yq7cXNZjNRZGiSfI72etqTBBKfSfEuz5qF5mAxJOmUSx070
 f3BAoautrDU0vZFIJuTk8km3mYFhDLsKdKc+KfdFPL66QVnF5KLTG8VM5vGOqjN3+Xxs
 KqXOXH5OOATqQRxWxmFbGAhvJW7tJEgnAbljQUbvY3rFiJd8Xq+/xsKuP2mZwsgI8f9V
 EaWt8HNai1SbY1KR3GWG9AMX7S7GiHC2m7hxTZtY8JU4t+gYRaPqmB+qSAwlQqajVZGm
 pAVTihrZzPgpLvMnCikBGOd8HOLR0/LjVpE4fOuCxcL+gEaE/Ru/DRA+lFIi1f0pPd26
 mD1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704877123; x=1705481923;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9d/TYW3E9SH0fGv9BZLabKIv535/lV9pcT9R9tUm+Ek=;
 b=DHLhiPjZnE8lMgPslY0pM/jOX9QgXDX5YWMDCv3iHKJjyYnmjGP7Dzk76VQEJ0fynD
 KSw2/YSQd5Rr34GNdusVTMUj7Zpb1j+wqKtKEer1DlvqzX39+eP+145a4bvnEc5Jsg0b
 RjJpWLQ7D2CzyEQuVuhQ2FhcStYjtx7qIQSX9TmFJhIBbxrvBFr2Rhh0heTooJiVhFiu
 JHdbWq269qELINmWKFOXz4s1rD2Ct33piD11xa7b9bVjfjSyzFN7uLYpnffa07UenuBB
 CSYrQhzqaogWE8S6oDM3ktBmIWAvkTfD7FM3r6Fsf1x3KfU5Kn04iZTSizwL+Q0I6LnI
 2miQ==
X-Gm-Message-State: AOJu0YwF44OrFDyWuYAoOExPrB9WfmK/NFKaWxCWEYVDTUqqM2CFad9l
 qoaPYR+zhxXc0uadtwKh5EdhtfaS8nORj5Ce
X-Google-Smtp-Source: AGHT+IEE+6lz4Uao3m3JN2th9RNuwhmR5JqpdAZGc6KX7h8jOawRCZv9Yc+woQVnEDnwJDuKXsIvAQ==
X-Received: by 2002:a9d:6857:0:b0:6dd:e799:1d27 with SMTP id
 c23-20020a9d6857000000b006dde7991d27mr403156oto.26.1704877123036; 
 Wed, 10 Jan 2024 00:58:43 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 t65-20020a628144000000b006d9879ba6besm3223814pfd.170.2024.01.10.00.58.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 00:58:42 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Sunil V L <sunilvl@ventanamicro.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PULL 16/65] hw/riscv/virt-acpi-build.c: Add AIA support in RINTC
Date: Wed, 10 Jan 2024 18:56:44 +1000
Message-ID: <20240110085733.1607526-17-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240110085733.1607526-1-alistair.francis@wdc.com>
References: <20240110085733.1607526-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=alistair23@gmail.com; helo=mail-ot1-x32c.google.com
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

Update the RINTC structure in MADT with AIA related fields.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20231218150247.466427-6-sunilvl@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/virt-acpi-build.c | 43 ++++++++++++++++++++++++++++++++++----
 1 file changed, 39 insertions(+), 4 deletions(-)

diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
index fc04d1defa..8f61fd63eb 100644
--- a/hw/riscv/virt-acpi-build.c
+++ b/hw/riscv/virt-acpi-build.c
@@ -38,6 +38,7 @@
 #include "hw/intc/riscv_aclint.h"
 
 #define ACPI_BUILD_TABLE_SIZE             0x20000
+#define ACPI_BUILD_INTC_ID(socket, index) ((socket << 24) | (index))
 
 typedef struct AcpiBuildState {
     /* Copy of table in RAM (for patching) */
@@ -59,17 +60,50 @@ static void acpi_align_size(GArray *blob, unsigned align)
 
 static void riscv_acpi_madt_add_rintc(uint32_t uid,
                                       const CPUArchIdList *arch_ids,
-                                      GArray *entry)
+                                      GArray *entry,
+                                      RISCVVirtState *s)
 {
+    uint8_t  guest_index_bits = imsic_num_bits(s->aia_guests + 1);
     uint64_t hart_id = arch_ids->cpus[uid].arch_id;
+    uint32_t imsic_size, local_cpu_id, socket_id;
+    uint64_t imsic_socket_addr, imsic_addr;
+    MachineState *ms = MACHINE(s);
 
+    socket_id = arch_ids->cpus[uid].props.node_id;
+    local_cpu_id = (arch_ids->cpus[uid].arch_id -
+                    riscv_socket_first_hartid(ms, socket_id)) %
+                    riscv_socket_hart_count(ms, socket_id);
+    imsic_socket_addr = s->memmap[VIRT_IMSIC_S].base +
+                        (socket_id * VIRT_IMSIC_GROUP_MAX_SIZE);
+    imsic_size = IMSIC_HART_SIZE(guest_index_bits);
+    imsic_addr = imsic_socket_addr + local_cpu_id * imsic_size;
     build_append_int_noprefix(entry, 0x18, 1);       /* Type     */
-    build_append_int_noprefix(entry, 20, 1);         /* Length   */
+    build_append_int_noprefix(entry, 36, 1);         /* Length   */
     build_append_int_noprefix(entry, 1, 1);          /* Version  */
     build_append_int_noprefix(entry, 0, 1);          /* Reserved */
     build_append_int_noprefix(entry, 0x1, 4);        /* Flags    */
     build_append_int_noprefix(entry, hart_id, 8);    /* Hart ID  */
     build_append_int_noprefix(entry, uid, 4);        /* ACPI Processor UID */
+    /* External Interrupt Controller ID */
+    if (s->aia_type == VIRT_AIA_TYPE_APLIC) {
+        build_append_int_noprefix(entry,
+                                  ACPI_BUILD_INTC_ID(
+                                      arch_ids->cpus[uid].props.node_id,
+                                      local_cpu_id),
+                                  4);
+    } else {
+        build_append_int_noprefix(entry, 0, 4);
+    }
+
+    if (s->aia_type == VIRT_AIA_TYPE_APLIC_IMSIC) {
+        /* IMSIC Base address */
+        build_append_int_noprefix(entry, imsic_addr, 8);
+        /* IMSIC Size */
+        build_append_int_noprefix(entry, imsic_size, 4);
+    } else {
+        build_append_int_noprefix(entry, 0, 8);
+        build_append_int_noprefix(entry, 0, 4);
+    }
 }
 
 static void acpi_dsdt_add_cpus(Aml *scope, RISCVVirtState *s)
@@ -88,7 +122,7 @@ static void acpi_dsdt_add_cpus(Aml *scope, RISCVVirtState *s)
                        aml_int(arch_ids->cpus[i].arch_id)));
 
             /* build _MAT object */
-            riscv_acpi_madt_add_rintc(i, arch_ids, madt_buf);
+            riscv_acpi_madt_add_rintc(i, arch_ids, madt_buf, s);
             aml_append(dev, aml_name_decl("_MAT",
                                           aml_buffer(madt_buf->len,
                                           (uint8_t *)madt_buf->data)));
@@ -227,6 +261,7 @@ static void build_dsdt(GArray *table_data,
  * 5.2.12 Multiple APIC Description Table (MADT)
  * REF: https://github.com/riscv-non-isa/riscv-acpi/issues/15
  *      https://drive.google.com/file/d/1R6k4MshhN3WTT-hwqAquu5nX6xSEqK2l/view
+ *      https://drive.google.com/file/d/1oMGPyOD58JaPgMl1pKasT-VKsIKia7zR/view
  */
 static void build_madt(GArray *table_data,
                        BIOSLinker *linker,
@@ -246,7 +281,7 @@ static void build_madt(GArray *table_data,
 
     /* RISC-V Local INTC structures per HART */
     for (int i = 0; i < arch_ids->len; i++) {
-        riscv_acpi_madt_add_rintc(i, arch_ids, table_data);
+        riscv_acpi_madt_add_rintc(i, arch_ids, table_data, s);
     }
 
     acpi_table_end(linker, &table);
-- 
2.43.0


