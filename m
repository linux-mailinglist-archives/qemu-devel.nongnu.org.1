Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 061627DF846
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 18:04:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyb6V-0003SL-1N; Thu, 02 Nov 2023 13:03:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1qyb6T-0003Rd-0i
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 13:03:33 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1qyb6Q-0004I4-HL
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 13:03:32 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2800bdf888dso931146a91.1
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 10:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1698944609; x=1699549409; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BsgIu9p85jZ07rKaDYYcGl5EF2P5MOIWw3LEVA7+ZiY=;
 b=lN6hq39h8ubw9YH2jdQHVCRISHDL7DeeCMy+7irWPn3/LKKI+QPCNnTscYvJ0F4IvG
 I5rBBNC+9BFvlvnVfLoVtJbUUP9IXtFWIAhCKPAlCE8EoPnln78VVjsHEhWHAT65vJuB
 1tcMyjj1Zk/tCFHKu6BD8Y6MLez8yCoq4VP6I5sebxZxZvERBVEowLyAqq3v7A7GXxMk
 kqbHa7laWlKnrw2eB/dgUI8sb/7PgRnfsSqAMn4NV9TgO4zWvoOE0IuDk0HC62Ym2ugR
 7f5noQpUO65iptToSURDye5Cq3U7RqPUus1eMxcXsX3U3HbAD1osxAtpuKB2Mwdbgjih
 70+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698944609; x=1699549409;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BsgIu9p85jZ07rKaDYYcGl5EF2P5MOIWw3LEVA7+ZiY=;
 b=izqJrikFAQbi/kRGqV3qf6aoIu4kz8GN5Ah+fPQuLEpGGWjgEDIzovsEIFRV/YE/e3
 y9CxDxDorj6fVMRHWNbOeXvC+mZreIMTIWOpIxo7Sxcw73IwLoHsJRQEUAPKjOtWRB/i
 Bgtrk9yEFOL6cCxKCGUdGdyLATOMOiRJj7opOIDkN2djw3rm234nnsy0vbuRCmZsCDwG
 oXSlIZ78L43l+6qLq+XeTgzo2zJhg4R+KJp3lknT5E9cjZFrRvcZPHiYw0LWNE3gfZ77
 ag/exdi44g97u6Ci5xEHRiA/Z8VMrUx1f4aDHsMdetnpF1n6lSMHc1z2oA5QTKY0Tte8
 djMg==
X-Gm-Message-State: AOJu0YxPdb2SDk+mcXFgLEYHn819MK7wLAxtaTQ4mTgRn/N/yBtSo6M7
 Kvn/Wl3jJFfRge3biGahfqyvlA==
X-Google-Smtp-Source: AGHT+IEsePAKzpjq5aQQNlSoyCMzC29HXg/sBsRatB4MTfI/LcoqWtRd7fJ32PYuni1aXORuEVYoDw==
X-Received: by 2002:a17:90a:fb94:b0:280:4796:59b8 with SMTP id
 cp20-20020a17090afb9400b00280479659b8mr105463pjb.9.1698944609260; 
 Thu, 02 Nov 2023 10:03:29 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.188.78])
 by smtp.gmail.com with ESMTPSA id
 18-20020a17090a031200b0026b70d2a8a2sm25098pje.29.2023.11.02.10.03.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Nov 2023 10:03:28 -0700 (PDT)
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
Subject: [PATCH v6 09/13] hw/riscv/virt-acpi-build.c: Add MMU node in RHCT
Date: Thu,  2 Nov 2023 22:32:19 +0530
Message-Id: <20231102170223.2619260-10-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231102170223.2619260-1-sunilvl@ventanamicro.com>
References: <20231102170223.2619260-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-pj1-x1030.google.com
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

MMU type information is available via MMU node in RHCT. Add this node in
RHCT.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/riscv/virt-acpi-build.c | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
index 506d487ede..86c38f7c2b 100644
--- a/hw/riscv/virt-acpi-build.c
+++ b/hw/riscv/virt-acpi-build.c
@@ -152,6 +152,8 @@ static void build_rhct(GArray *table_data,
     size_t len, aligned_len;
     uint32_t isa_offset, num_rhct_nodes, cmo_offset = 0;
     RISCVCPU *cpu = &s->soc[0].harts[0];
+    uint32_t mmu_offset = 0;
+    uint8_t satp_mode_max;
     char *isa;
 
     AcpiTable table = { .sig = "RHCT", .rev = 1, .oem_id = s->oem_id,
@@ -171,6 +173,10 @@ static void build_rhct(GArray *table_data,
         num_rhct_nodes++;
     }
 
+    if (cpu->cfg.satp_mode.supported != 0) {
+        num_rhct_nodes++;
+    }
+
     /* Number of RHCT nodes*/
     build_append_int_noprefix(table_data, num_rhct_nodes, 4);
 
@@ -226,6 +232,26 @@ static void build_rhct(GArray *table_data,
         }
     }
 
+    /* MMU node structure */
+    if (cpu->cfg.satp_mode.supported != 0) {
+        satp_mode_max = satp_mode_max_from_map(cpu->cfg.satp_mode.map);
+        mmu_offset = table_data->len - table.table_offset;
+        build_append_int_noprefix(table_data, 2, 2);    /* Type */
+        build_append_int_noprefix(table_data, 8, 2);    /* Length */
+        build_append_int_noprefix(table_data, 0x1, 2);  /* Revision */
+        build_append_int_noprefix(table_data, 0, 1);    /* Reserved */
+        /* MMU Type */
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
     /* Hart Info Node */
     for (int i = 0; i < arch_ids->len; i++) {
         len = 16;
@@ -238,17 +264,25 @@ static void build_rhct(GArray *table_data,
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
         build_append_int_noprefix(table_data, num_offsets, 2);
         build_append_int_noprefix(table_data, i, 4);   /* ACPI Processor UID */
-
         /* Offsets */
         build_append_int_noprefix(table_data, isa_offset, 4);
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


