Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 83763750ECA
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 18:41:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJctT-0004Q1-Qs; Wed, 12 Jul 2023 12:40:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1qJctG-0004Bo-J7
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 12:40:38 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1qJctD-00050k-FA
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 12:40:34 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1b9c368f4b5so6896585ad.0
 for <qemu-devel@nongnu.org>; Wed, 12 Jul 2023 09:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1689180030; x=1691772030;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DOMVpaL+RUza3NN3jRAWhjrw9yLkxz5cT87TbrWj/BE=;
 b=flmk1n2Ems3go+mSyZG2Wl0LYZxcjgy1QvAtlmgGuKZqFozaXBiRuu34enP0a45PHK
 uGXVvyd1Q0E/Oqvk7Omx2BwounXtaSYN8VKCYB+t++TDF3pmxzZkSrtl6uPGiMzByZ3I
 KOxBG3KvOmrPkLPB4oAIS1iwQhjViLDEPmsDfdwSkQG8xFM0mrAC7mKz64tX5OjaNO0X
 tozgznmWjd+v8jGjKeLCtb25VSnSSGhOMvtgucb0SYYI2OwyBtA38jdD1VCKUfvBmLAK
 9m6eMWgqF5lmqt07wrV9q2j+TIDMmn6sxVmnaBUbZ9E5LJxmIfKKyD7W+3Xb8IYgeTsr
 4S7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689180030; x=1691772030;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DOMVpaL+RUza3NN3jRAWhjrw9yLkxz5cT87TbrWj/BE=;
 b=Zh9vzMXF3VmVonymt0NGXEqsd3CkpjbSjVlgad1S+Eb694HY5e/hugp6gJrUUVaxlR
 NvcTjn5HAv08if1kh3Kg2pSyUuYYMIIYU8Q6mTvlvmuKnxfnIc1u+yml5MCk1J6k3lig
 szM/HZud7+Du26kfmMwiYONtJrErYVHkdlATum+4e4KIpq85n0tvKslqQp3kP5GdrjNq
 cyz5C2hUCed057xt/8Nft5XnkEGayjky7ZAvllS6LtZkc5o6kkZbhc9frJ4Cm+/tOacS
 OvcEg+1TMHZzTlfecFdqRf8Jfla4zYxaqIH4BFpvpvW/3IPaLWvclQ/SJ2ofBmxp3bxM
 T7hw==
X-Gm-Message-State: ABy/qLbfzcfWH5TRYps90jiNXM0kaX1/0imdbHPZMIVwSnDmR/NLH330
 9IRLXlgN4/Yft4M0GVmf18MjuiVUshYhgM9q3zA=
X-Google-Smtp-Source: APBJJlES0dprVrhIbsWfwIIeVwP+sy6i1gw90QTG/6l4sgwo2YIwxZoYomC82a+weYfHedopvLHhkQ==
X-Received: by 2002:a17:903:22c7:b0:1b8:870c:4ce8 with SMTP id
 y7-20020a17090322c700b001b8870c4ce8mr3421951plg.18.1689180029562; 
 Wed, 12 Jul 2023 09:40:29 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.190.25])
 by smtp.gmail.com with ESMTPSA id
 a18-20020a1709027d9200b001ac7f583f72sm4172824plm.209.2023.07.12.09.40.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jul 2023 09:40:29 -0700 (PDT)
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
Subject: [PATCH 08/10] hw/riscv/virt-acpi-build.c: Add CMO information in RHCT
Date: Wed, 12 Jul 2023 22:09:41 +0530
Message-Id: <20230712163943.98994-9-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230712163943.98994-1-sunilvl@ventanamicro.com>
References: <20230712163943.98994-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-pl1-x635.google.com
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

When CMO related extensions like Zicboz, Zicbom and Zicbop
are enabled, the block size for those extensions need to be
communicated via CMO node in RHCT. Add CMO node in RHCT if
any of those CMO extensions are detected.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 hw/riscv/virt-acpi-build.c | 64 +++++++++++++++++++++++++++++++++-----
 1 file changed, 56 insertions(+), 8 deletions(-)

diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
index 9f2d0c92b0..2d2bd3b970 100644
--- a/hw/riscv/virt-acpi-build.c
+++ b/hw/riscv/virt-acpi-build.c
@@ -146,6 +146,7 @@ static void acpi_dsdt_add_cpus(Aml *scope, RISCVVirtState *s)
  * 5.2.36 RISC-V Hart Capabilities Table (RHCT)
  * REF: https://github.com/riscv-non-isa/riscv-acpi/issues/16
  *      https://drive.google.com/file/d/1nP3nFiH4jkPMp6COOxP6123DCZKR-tia/view
+ *      https://drive.google.com/file/d/1sKbOa8m1UZw1JkquZYe3F1zQBN1xXsaf/view
  */
 static void build_rhct(GArray *table_data,
                        BIOSLinker *linker,
@@ -155,8 +156,8 @@ static void build_rhct(GArray *table_data,
     MachineState *ms = MACHINE(s);
     const CPUArchIdList *arch_ids = mc->possible_cpu_arch_ids(ms);
     size_t len, aligned_len;
-    uint32_t isa_offset, num_rhct_nodes;
-    RISCVCPU *cpu;
+    uint32_t isa_offset, num_rhct_nodes, cmo_offset = 0;
+    RISCVCPU *cpu = &s->soc[0].harts[0];
     char *isa;
 
     AcpiTable table = { .sig = "RHCT", .rev = 1, .oem_id = s->oem_id,
@@ -172,6 +173,9 @@ static void build_rhct(GArray *table_data,
 
     /* ISA + N hart info */
     num_rhct_nodes = 1 + ms->smp.cpus;
+    if (cpu->cfg.ext_icbom || cpu->cfg.ext_icboz) {
+        num_rhct_nodes++;
+    }
 
     /* Number of RHCT nodes*/
     build_append_int_noprefix(table_data, num_rhct_nodes, 4);
@@ -183,7 +187,6 @@ static void build_rhct(GArray *table_data,
     isa_offset = table_data->len - table.table_offset;
     build_append_int_noprefix(table_data, 0, 2);   /* Type 0 */
 
-    cpu = &s->soc[0].harts[0];
     isa = riscv_isa_string(cpu);
     len = 8 + strlen(isa) + 1;
     aligned_len = (len % 2) ? (len + 1) : len;
@@ -199,14 +202,59 @@ static void build_rhct(GArray *table_data,
         build_append_int_noprefix(table_data, 0x0, 1);   /* Optional Padding */
     }
 
+    /* CMO node */
+    if (cpu->cfg.ext_icbom || cpu->cfg.ext_icboz) {
+        cmo_offset = table_data->len - table.table_offset;
+        build_append_int_noprefix(table_data, 1, 2);    /* Type */
+        build_append_int_noprefix(table_data, 10, 2);   /* Total Length */
+        build_append_int_noprefix(table_data, 0x1, 2);  /* Revision */
+        build_append_int_noprefix(table_data, 0, 1);    /* Reserved */
+
+        /* CBOM block size */
+        if (cpu->cfg.cbom_blocksize) {
+            build_append_int_noprefix(table_data,
+                                      __builtin_ctz(cpu->cfg.cbom_blocksize),
+                                      1);
+        } else {
+            build_append_int_noprefix(table_data, 0, 1);
+        }
+
+        /* CBOP block size */
+        build_append_int_noprefix(table_data, 0, 1);
+
+        /* CBOZ block size */
+        if (cpu->cfg.cboz_blocksize) {
+            build_append_int_noprefix(table_data,
+                                      __builtin_ctz(cpu->cfg.cboz_blocksize),
+                                      1);
+        } else {
+            build_append_int_noprefix(table_data, 0, 1);
+        }
+    }
+
     /* Hart Info Node */
     for (int i = 0; i < arch_ids->len; i++) {
+        len = 16;
+        int num_offsets = 1;
         build_append_int_noprefix(table_data, 0xFFFF, 2);  /* Type */
-        build_append_int_noprefix(table_data, 16, 2);      /* Length */
-        build_append_int_noprefix(table_data, 0x1, 2);     /* Revision */
-        build_append_int_noprefix(table_data, 1, 2);    /* Number of offsets */
-        build_append_int_noprefix(table_data, i, 4);    /* ACPI Processor UID */
-        build_append_int_noprefix(table_data, isa_offset, 4); /* Offsets[0] */
+
+        /* Length */
+        if (cmo_offset) {
+            len += 4;
+            num_offsets++;
+        }
+
+        build_append_int_noprefix(table_data, len, 2);
+        build_append_int_noprefix(table_data, 0x1, 2); /* Revision */
+        /* Number of offsets */
+        build_append_int_noprefix(table_data, num_offsets, 2);
+        build_append_int_noprefix(table_data, i, 4);   /* ACPI Processor UID */
+
+        /* Offsets */
+        build_append_int_noprefix(table_data, isa_offset, 4);
+        if (cmo_offset) {
+            build_append_int_noprefix(table_data, cmo_offset, 4);
+        }
     }
 
     acpi_table_end(linker, &table);
-- 
2.39.2


