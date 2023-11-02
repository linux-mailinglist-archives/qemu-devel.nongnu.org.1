Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E02E77DF843
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 18:04:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyb6J-0003Hj-K5; Thu, 02 Nov 2023 13:03:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1qyb6H-0003Fs-Iz
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 13:03:21 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1qyb6F-0004Dz-FG
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 13:03:21 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-5bd33abbb90so424342a12.2
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 10:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1698944597; x=1699549397; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KcgJ4FRc9yz2b5H8HRo0vnvqFidecDDHMaAJ2DLpido=;
 b=Z2OptI4sgRafIIbi69i4bdd5mY6jXWBKlpThmuEAYx1W37VASTyBOEjjdoBBZZv4Xs
 0g/bVLKDrriZ84aneqmOeHCrxCPqzaa1Sg4cuNQt9cPEir5Nj4b5L1Ja8GUMEHWjjANX
 voJlEIobWEtAC01ub/bMl66aJLIDihFS/cHHyPDO+W9ZwAqhnluzJI/RcK0UP5qNtAY1
 CbplZQ/MWYm0yyxmYN4BKfaGl7FeUZiqz/drS7fLk89GQvkkCwmvRIfPah9TuAidkiW5
 f+wz/XvQfL1i/RsXvu1SgTNYyELebtl17Y70ROdfcXsuSTz3UCMZw6LS4/1oHyy9L+oA
 eTsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698944597; x=1699549397;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KcgJ4FRc9yz2b5H8HRo0vnvqFidecDDHMaAJ2DLpido=;
 b=W177evVo+pnoxaTBPAeFJd3+M+WrWf820bJJxTkIP9CxeXimVv0DUSSkAXcWj6r/ug
 IhnaWRpNM71tFIeMvqiGSSXDCfhvwmu6X/CDkHvr0Nzb/jpdVLWL9aSQHglAIkYS7ZkC
 JDcctjn+xn2hjZQGdQ+W6zUqkboCnHbfPtQmSEnLuNojIT4aJlBugBQFxEy0Oiv4y5Eo
 qprMnnto+Kbd4hzeGGZ4DxzZ9lWslU3mgBoGI5GlMRnZJB1DVl7KMl7DJaN9hnEiF19F
 r9LHbCtnu5R6DnkOxFHH8f35X08ldwIqSd427iSKX9CFvi2GW+jl5g04RMLJOVbHsqaV
 l8oQ==
X-Gm-Message-State: AOJu0YwLriS9A9eiAK5ejCHqkRGbwuatXDUw52DBmv2J8UReEcGEpC2v
 IVwqPfNjptCd9cgMvmq07lF30Q==
X-Google-Smtp-Source: AGHT+IHouuBNz+HxNQHrYIn+JGTEPnmzg5mjqGXSuydlUbhhNYuPNcyXSDpfqXzEorrlpwgY0fblTQ==
X-Received: by 2002:a17:90a:357:b0:27c:f9e7:30fd with SMTP id
 23-20020a17090a035700b0027cf9e730fdmr15559333pjf.7.1698944596970; 
 Thu, 02 Nov 2023 10:03:16 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.188.78])
 by smtp.gmail.com with ESMTPSA id
 18-20020a17090a031200b0026b70d2a8a2sm25098pje.29.2023.11.02.10.03.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Nov 2023 10:03:16 -0700 (PDT)
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
Subject: [PATCH v6 07/13] hw/riscv/virt-acpi-build.c: Add APLIC in the MADT
Date: Thu,  2 Nov 2023 22:32:17 +0530
Message-Id: <20231102170223.2619260-8-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231102170223.2619260-1-sunilvl@ventanamicro.com>
References: <20231102170223.2619260-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-pg1-x535.google.com
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

Add APLIC structures for each socket in the MADT when system is configured
with APLIC as the external wired interrupt controller.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/riscv/virt-acpi-build.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
index 6bb21014fd..ec49c8804b 100644
--- a/hw/riscv/virt-acpi-build.c
+++ b/hw/riscv/virt-acpi-build.c
@@ -274,6 +274,8 @@ static void build_madt(GArray *table_data,
     uint8_t  guest_index_bits = imsic_num_bits(s->aia_guests + 1);
     uint16_t imsic_max_hart_per_socket = 0;
     uint8_t  hart_index_bits;
+    uint64_t aplic_addr;
+    uint32_t gsi_base;
     uint8_t  socket;
 
     for (socket = 0; socket < riscv_socket_count(ms); socket++) {
@@ -319,6 +321,38 @@ static void build_madt(GArray *table_data,
         build_append_int_noprefix(table_data, IMSIC_MMIO_GROUP_MIN_SHIFT, 1);
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


