Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A8FC3750ED0
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 18:42:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJctW-0004bW-TA; Wed, 12 Jul 2023 12:40:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1qJctK-0004D6-Sf
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 12:40:40 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1qJctI-00051P-4f
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 12:40:38 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-55b0e7efb1cso3812808a12.1
 for <qemu-devel@nongnu.org>; Wed, 12 Jul 2023 09:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1689180035; x=1691772035;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jso/j+63oBqdVRx3pDSKT/j8yNOcjXEUIlYkCeW99DQ=;
 b=WY9NzGTHmIQvLhoOqK7OoQNHNJxx0514Z4zB1XapcM+ydX99hN34dlvs0qOQEI786j
 UQzXQv5TbhuVwk1XibUgn2M7qxNgbL+tNpryr2AwegQ4jtBo0FVXhRWE++aF9/iHGt/6
 7kxFideVXiZAcowiG6U7+gZQRK7NHlb/+tx/LS1TU5alRus+zYVsjC7YOMCj8avhtlO4
 uySel5GM1BcK/fJoVIHSA8AQVEF3RGW3IgwuTEesZogeY8pRKrr8ou4IKTXCfzsQv7Zb
 obQ4CzKFL9I/NiVCQuOzwO8THewh2o+5CFG1NfUmqNye+YUK1SqukcvUZXbia4gQnKki
 nDmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689180035; x=1691772035;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jso/j+63oBqdVRx3pDSKT/j8yNOcjXEUIlYkCeW99DQ=;
 b=gPKFHZQLwDlv+iHyha+7SZRbu0zQpglIDN+lmvE8xiJUnLmgNyJOAfqcje/HKoP/0i
 ryEC8oEhZzM2t50ZjBow04ldpB5ar6DmhCfliwm/QpRwX1sJgu1RWRc/mvLBXvsb0Pgg
 ZgDma+5CXqHcE9Rh3k0wJxrfgIS42+vUrpARrsyylR7sjIrGJVVWjt4VgogvM9Tjktg5
 SNvSrbrwWHZil5DcHX8EbclSGXAMfFphARjews92Y8Y+SF/wGrnWduXWKKsQ1xPv0M9O
 zXUjsfT3r/AmfKvJuEuWmM3mOcxJKNzHrpRJT1c9/s4sfM031j2i4gJ/1XKwllzKvpOw
 6sSw==
X-Gm-Message-State: ABy/qLZOHXRhjw3SpXZCo1E3n7rHNbZ30MvyXmJEZTnpHJFCeTy519Kk
 04bAl5JYdhNjYknaWeDnd9+s3BMI6X0kOJufSIk=
X-Google-Smtp-Source: APBJJlGDGcwaVDg/ZS5uxTcNru0qAQc5JAIv51+kelAk07eLCg5SYcSdckVrwPH2ASzdFnCLRFuEdg==
X-Received: by 2002:a17:903:25d3:b0:1b8:a328:c1e6 with SMTP id
 jc19-20020a17090325d300b001b8a328c1e6mr5373527plb.63.1689180034742; 
 Wed, 12 Jul 2023 09:40:34 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.190.25])
 by smtp.gmail.com with ESMTPSA id
 a18-20020a1709027d9200b001ac7f583f72sm4172824plm.209.2023.07.12.09.40.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jul 2023 09:40:34 -0700 (PDT)
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
Subject: [PATCH 09/10] hw/riscv/virt-acpi-build.c: Add MMU node in RHCT
Date: Wed, 12 Jul 2023 22:09:42 +0530
Message-Id: <20230712163943.98994-10-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230712163943.98994-1-sunilvl@ventanamicro.com>
References: <20230712163943.98994-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-pg1-x52b.google.com
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

MMU type information is available via MMU node in RHCT.
Add this node in RHCT.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 hw/riscv/virt-acpi-build.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
index 2d2bd3b970..25745eee4c 100644
--- a/hw/riscv/virt-acpi-build.c
+++ b/hw/riscv/virt-acpi-build.c
@@ -158,6 +158,8 @@ static void build_rhct(GArray *table_data,
     size_t len, aligned_len;
     uint32_t isa_offset, num_rhct_nodes, cmo_offset = 0;
     RISCVCPU *cpu = &s->soc[0].harts[0];
+    uint32_t mmu_offset = 0;
+    uint8_t satp_mode_max;
     char *isa;
 
     AcpiTable table = { .sig = "RHCT", .rev = 1, .oem_id = s->oem_id,
@@ -177,6 +179,10 @@ static void build_rhct(GArray *table_data,
         num_rhct_nodes++;
     }
 
+    if (cpu->cfg.satp_mode.supported != 0) {
+        num_rhct_nodes++;
+    }
+
     /* Number of RHCT nodes*/
     build_append_int_noprefix(table_data, num_rhct_nodes, 4);
 
@@ -202,6 +208,26 @@ static void build_rhct(GArray *table_data,
         build_append_int_noprefix(table_data, 0x0, 1);   /* Optional Padding */
     }
 
+    /* MMU node structure */
+    if (cpu->cfg.satp_mode.supported != 0) {
+        satp_mode_max = satp_mode_max_from_map(cpu->cfg.satp_mode.map);
+        mmu_offset = table_data->len - table.table_offset;
+        build_append_int_noprefix(table_data, 1, 2);    /* Type */
+        build_append_int_noprefix(table_data, 8, 2);    /* Total Length */
+        build_append_int_noprefix(table_data, 0x1, 2);  /* Revision */
+        build_append_int_noprefix(table_data, 0, 1);    /* Reserved */
+        /* Virtual Address Scheme */
+        if (satp_mode_max == VM_1_10_SV57) {
+            build_append_int_noprefix(table_data, 2, 1);    /* Sv57 */
+        } else if (satp_mode_max == VM_1_10_SV48) {
+            build_append_int_noprefix(table_data, 1, 1);    /* Sv48 */
+        } else if (satp_mode_max == VM_1_10_SV39) {
+            build_append_int_noprefix(table_data, 0, 1);    /* Sv39 */
+        } else {
+            assert(1);
+        }
+    }
+
     /* CMO node */
     if (cpu->cfg.ext_icbom || cpu->cfg.ext_icboz) {
         cmo_offset = table_data->len - table.table_offset;
@@ -244,6 +270,11 @@ static void build_rhct(GArray *table_data,
             num_offsets++;
         }
 
+        if (mmu_offset) {
+            len += 4;
+            num_offsets++;
+        }
+
         build_append_int_noprefix(table_data, len, 2);
         build_append_int_noprefix(table_data, 0x1, 2); /* Revision */
         /* Number of offsets */
@@ -252,9 +283,14 @@ static void build_rhct(GArray *table_data,
 
         /* Offsets */
         build_append_int_noprefix(table_data, isa_offset, 4);
+
         if (cmo_offset) {
             build_append_int_noprefix(table_data, cmo_offset, 4);
         }
+
+        if (mmu_offset) {
+            build_append_int_noprefix(table_data, mmu_offset, 4);
+        }
     }
 
     acpi_table_end(linker, &table);
-- 
2.39.2


