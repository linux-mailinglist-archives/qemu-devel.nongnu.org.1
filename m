Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 09FE37CFAFA
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 15:29:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtT4L-000416-Jp; Thu, 19 Oct 2023 09:28:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1qtT4J-00040D-3h
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:28:07 -0400
Received: from mail-oo1-xc31.google.com ([2607:f8b0:4864:20::c31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1qtT4H-0006sC-H1
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:28:06 -0400
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-57be3d8e738so4459162eaf.1
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 06:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1697722084; x=1698326884; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qNazuk04HojMF1nRphdyDzYR62U+HLhiB0jdg6lni7I=;
 b=LUjumSN5vbhCfsrKJbQfAQ3ZfD5qt8ow5AGQunFx33tLNLNhILNBEh9Lzz4Jrlfab5
 qhaxsYdGoBUGdbuluV769Y9rLXlKXSJ1gJUWxXdyg5Y8zURHs6xYw3sjgrLc5ufTCUHz
 e/c2BNlazrKVaQbqfyzflqtFxR/NEe8ZNyTXPcYr7xYgG/i/FzIhr8HPyZBCVqhfyctR
 YylfOfTFFeOmamqIA1b1wjFcgEKu8089ZE7ojj3q07ANPLmuY0S3Rt/HPplqmYZSLwoF
 ct2eyL/OHuD6JiUsdDPTnk/WlROykAkQ2W7CDYSP5v+ppjJLMKHizOX/uc8MVvh9tcmE
 ioJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697722084; x=1698326884;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qNazuk04HojMF1nRphdyDzYR62U+HLhiB0jdg6lni7I=;
 b=mKiTIGJUPPS3gxbf8M5yYqs2Spcc5FKYBBilN4QYnmBLOXCTzfkNBFGHkKPI0lQ55X
 HIwNwRKPS72lgjIonx/qJGHeUrlLh2ZNNLGgc7hsWmQo9LERjyhTIPP/1w3a6iRaGIuk
 8QbEk8V+lrVqj84M0mewBWgZYwntUDGGzNyTyEDHrf/ujcVwFebk0Z6cEoJtjNun6MKX
 JSUU2Rw5KVLNFI3meeXVKd4Ian7+RXBx1amijeI5JyM13JeUdmgY7xzSMwUmaNA1zih8
 ZmGIaj6Jr56sKwDOAqKbd2cNt/mmucymD4bp9uvUdWzFpmriY59Fl2n77gtenM1AjjGp
 R1Jw==
X-Gm-Message-State: AOJu0YyN6ncZRECp3Pp6zPH4eqhaOshfBriTL2zsp/8eCEHCJNYdsRDg
 Msed+MX+XKnIy4zQZMHKlC2e2w==
X-Google-Smtp-Source: AGHT+IG2mnsY1gvT13rc/P5JpfTZdvmN0JVV+pgIb/Sn9UZIq0bKHkwKt7ine6bKBTpJxAlhhMIMKw==
X-Received: by 2002:a05:6358:e820:b0:142:fd2b:da2e with SMTP id
 gi32-20020a056358e82000b00142fd2bda2emr1823289rwb.31.1697722083991; 
 Thu, 19 Oct 2023 06:28:03 -0700 (PDT)
Received: from sunil-laptop.dc1.ventanamicro.com
 ([2409:4071:6e8b:3a98:dd76:4e82:7da6:44ab])
 by smtp.gmail.com with ESMTPSA id
 f11-20020a056a00228b00b0068feb378b89sm5273113pfe.171.2023.10.19.06.27.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 06:28:03 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: qemu-riscv@nongnu.org,
	qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Shannon Zhao <shannon.zhaosl@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Anup Patel <apatel@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Atish Kumar Patra <atishp@rivosinc.com>, Haibo Xu <haibo1.xu@intel.com>,
 Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v3 06/12] hw/riscv/virt-acpi-build.c: Add APLIC in the MADT
Date: Thu, 19 Oct 2023 18:56:42 +0530
Message-Id: <20231019132648.23703-7-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019132648.23703-1-sunilvl@ventanamicro.com>
References: <20231019132648.23703-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c31;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-oo1-xc31.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
---
 hw/riscv/virt-acpi-build.c | 36 ++++++++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
index 7f1a370e54..8fa358d034 100644
--- a/hw/riscv/virt-acpi-build.c
+++ b/hw/riscv/virt-acpi-build.c
@@ -277,9 +277,9 @@ static void build_madt(GArray *table_data,
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
@@ -341,6 +341,38 @@ static void build_madt(GArray *table_data,
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
2.34.1


