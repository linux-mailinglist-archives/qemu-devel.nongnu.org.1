Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B342B7DBA91
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 14:23:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxSDi-0007Ot-3h; Mon, 30 Oct 2023 09:22:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1qxSDV-00074U-Fh
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 09:22:06 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1qxSDP-0002ul-IF
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 09:22:05 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2802e5ae23bso1513985a91.2
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 06:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1698672117; x=1699276917; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2vd4z02i5MUjS+md3dmfd4/u+HVQ03/wckr2cfGkWeU=;
 b=ghmFyvwn68lkuISEhWMAsIA3EkNl7OzbKlW0m6vVc+eSEdq3BWidiDYtq4jAfhlW4l
 MqXd29ddPvcC5NAKRc9Zs56cg9ZLSL++oz00O23/F5dqJBUFuiHYWb7N9OAPoJJcZGUs
 3tapIM245t58N0FNqRzDk3cNajlDTPxRut3mrd7y7v1njiNufsSYgthTjR5/mEvvBRBW
 NU3w2QIQdUs2SgsP1ueusCjHtdV9J2WR65Gj370kRvDKp26Lh3L4tqT+1LJrNKjFFeVk
 zYlAw7/Yh9gIr8/2zkxSqQ9abtsHlMh+cDohER3Ukp017GlaH+nN61hKmufaj7MsS9PD
 NkdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698672117; x=1699276917;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2vd4z02i5MUjS+md3dmfd4/u+HVQ03/wckr2cfGkWeU=;
 b=plOloYTgvLT+rhj0NDL/HueRrQR248M+k6DfGs6P+IXZM8+dHxs+2SfT6eaDtqhx/h
 5gYdEa7T3NCTrUMtPksnvvalnNyZGkWadzL9Gy+iUukNafAWPWDiZcFAl3/I4Avn6Zv1
 n87k3RZG2pQzFz2Y1pF689QOB4cq9695z0lyLkqz63lC2Jrk7V1fQ0kGO1VSq3V6C91X
 9Fa1Gf61wgjlZo0kEEY9kHCLW803dF2wkayBfHBgkJo4EcAqyaTBmo6bH29Tt3pf3VPi
 JH1QoPBt8fhD10Ktc5l7AysfUDF/Ul2HksonjxwB5lwIqERPVJbJO9tDp+loixyjXEmn
 ybkQ==
X-Gm-Message-State: AOJu0YyukX9GUUWcreAHyQc03hqCe2/tykzdBg6/zS2OjqLwg/jy2iqV
 q8ul04nT9Ur9VKYSKQxwVelV4g==
X-Google-Smtp-Source: AGHT+IHDn2wy02EXuXT0Z4Z9ussfO3Li6+pXvbXuj79ujZU3aZB55p46cV9v1FoQ+PeuLzhna42cJg==
X-Received: by 2002:a17:90a:d101:b0:280:3f37:f8a1 with SMTP id
 l1-20020a17090ad10100b002803f37f8a1mr3705355pju.12.1698672116904; 
 Mon, 30 Oct 2023 06:21:56 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.188.78])
 by smtp.gmail.com with ESMTPSA id
 15-20020a17090a000f00b0027ced921e80sm8122412pja.38.2023.10.30.06.21.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Oct 2023 06:21:56 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Anup Patel <apatel@ventanamicro.com>,
 Atish Kumar Patra <atishp@rivosinc.com>, Haibo Xu <haibo1.xu@intel.com>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>
Subject: [PATCH v5 08/13] hw/riscv/virt-acpi-build.c: Add CMO information in
 RHCT
Date: Mon, 30 Oct 2023 18:50:53 +0530
Message-Id: <20231030132058.763556-9-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231030132058.763556-1-sunilvl@ventanamicro.com>
References: <20231030132058.763556-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-pj1-x102d.google.com
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

When CMO related extensions like Zicboz, Zicbom and Zicbop are enabled, the
block size for those extensions need to be communicated via CMO node in
RHCT. Add CMO node in RHCT if any of those CMO extensions are detected.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/virt-acpi-build.c | 64 +++++++++++++++++++++++++++++++++-----
 1 file changed, 56 insertions(+), 8 deletions(-)

diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
index ec49c8804b..506d487ede 100644
--- a/hw/riscv/virt-acpi-build.c
+++ b/hw/riscv/virt-acpi-build.c
@@ -140,6 +140,7 @@ static void acpi_dsdt_add_cpus(Aml *scope, RISCVVirtState *s)
  * 5.2.36 RISC-V Hart Capabilities Table (RHCT)
  * REF: https://github.com/riscv-non-isa/riscv-acpi/issues/16
  *      https://drive.google.com/file/d/1nP3nFiH4jkPMp6COOxP6123DCZKR-tia/view
+ *      https://drive.google.com/file/d/1sKbOa8m1UZw1JkquZYe3F1zQBN1xXsaf/view
  */
 static void build_rhct(GArray *table_data,
                        BIOSLinker *linker,
@@ -149,8 +150,8 @@ static void build_rhct(GArray *table_data,
     MachineState *ms = MACHINE(s);
     const CPUArchIdList *arch_ids = mc->possible_cpu_arch_ids(ms);
     size_t len, aligned_len;
-    uint32_t isa_offset, num_rhct_nodes;
-    RISCVCPU *cpu;
+    uint32_t isa_offset, num_rhct_nodes, cmo_offset = 0;
+    RISCVCPU *cpu = &s->soc[0].harts[0];
     char *isa;
 
     AcpiTable table = { .sig = "RHCT", .rev = 1, .oem_id = s->oem_id,
@@ -166,6 +167,9 @@ static void build_rhct(GArray *table_data,
 
     /* ISA + N hart info */
     num_rhct_nodes = 1 + ms->smp.cpus;
+    if (cpu->cfg.ext_zicbom || cpu->cfg.ext_zicboz) {
+        num_rhct_nodes++;
+    }
 
     /* Number of RHCT nodes*/
     build_append_int_noprefix(table_data, num_rhct_nodes, 4);
@@ -177,7 +181,6 @@ static void build_rhct(GArray *table_data,
     isa_offset = table_data->len - table.table_offset;
     build_append_int_noprefix(table_data, 0, 2);   /* Type 0 */
 
-    cpu = &s->soc[0].harts[0];
     isa = riscv_isa_string(cpu);
     len = 8 + strlen(isa) + 1;
     aligned_len = (len % 2) ? (len + 1) : len;
@@ -193,14 +196,59 @@ static void build_rhct(GArray *table_data,
         build_append_int_noprefix(table_data, 0x0, 1);   /* Optional Padding */
     }
 
+    /* CMO node */
+    if (cpu->cfg.ext_zicbom || cpu->cfg.ext_zicboz) {
+        cmo_offset = table_data->len - table.table_offset;
+        build_append_int_noprefix(table_data, 1, 2);    /* Type */
+        build_append_int_noprefix(table_data, 10, 2);   /* Length */
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


