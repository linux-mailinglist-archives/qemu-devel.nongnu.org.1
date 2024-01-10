Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6754A8295FD
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 10:14:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNURn-0006CO-8N; Wed, 10 Jan 2024 04:00:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rNUQl-0004IE-Hq
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 03:59:24 -0500
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rNUQi-00043i-KR
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 03:59:22 -0500
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-5c6ce4dffb5so1682195a12.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 00:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704877158; x=1705481958; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3Q6iYlmLxD9jVbf8N9yvAKHeyz19R8diaTSJCzl7nvQ=;
 b=TssZR9cjo5wnZ8mrNs19N2Nuf9WvzL4+rgpkLKHgc+GBfFEeCKC1xlIDcOATnqFcgM
 wEoFiGAZXOUG0H6sYioZrJXToGXKAnlrtV94x4z4G5/Mv/9ouPDeakJheUgI21bsHMGX
 55h3efYyUi+UpKkBUcSanIFslMhVWemB/8Edk5WQ6ZZwObdQX75gX+FnB3GO12IXLp82
 QdxIlJtY7df27to6y1ARnPjodcTm5Om07n0Se9UFFKgWEamXf7M+D1nA3YCMBWsDWOdy
 nZhF32Ka0vBDBlHFuzwSjn5cT7aJNPn0hplP/YqPzXvq3cDulZpkkcVm3klc3ean4/Be
 5Vmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704877158; x=1705481958;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3Q6iYlmLxD9jVbf8N9yvAKHeyz19R8diaTSJCzl7nvQ=;
 b=i0GK5T52KXey6caymEoWnVd06M1UJB+w5BT2crSNJStaFHjdfEyQYT4judrcjEkKue
 tzutV5iSb2TgURkiAreJY6U9Vxwyj6dSfgOQ1ydEUayiTq81ypEre/6RecFsjFbaIFmF
 zFXqH/UC03/dBWlPDrKQokzAaIICgxfxpyeafjI2Sby6uwSV3yfVRrdZQtAYkxO6YMFc
 zvMpS+E0vUxBXcLEyK/mmCTEl8ektbkjgW3jsReRh/MO6PFC6L6/GQUp/6ctneHD2hXk
 tscbKNmvD8ruReZ+DzXpXkq6d3XhOS1aBp1Ty/Tx2Ys0kVfwPyzRHdOLydW7FRjtIRyG
 ertg==
X-Gm-Message-State: AOJu0Yw+ZaShaQJnPoffFQ9q+LLu5SEJ0FEfwASAYF3q5TiUpPnKmxFL
 qYa9jrhkLMRISDmX6bq2nXbK8qOvmf3HJm2K
X-Google-Smtp-Source: AGHT+IFEDb6Q5xc+VVS04moLX35cEGM2alRi0jgnCeHCO+Bb8OVCGuG9wY31UaGvscH/KZyY7IsB+Q==
X-Received: by 2002:a05:6a20:1192:b0:19a:324e:c4f0 with SMTP id
 v18-20020a056a20119200b0019a324ec4f0mr54428pze.101.1704877131683; 
 Wed, 10 Jan 2024 00:58:51 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 t65-20020a628144000000b006d9879ba6besm3223814pfd.170.2024.01.10.00.58.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 00:58:51 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Sunil V L <sunilvl@ventanamicro.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PULL 18/65] hw/riscv/virt-acpi-build.c: Add APLIC in the MADT
Date: Wed, 10 Jan 2024 18:56:46 +1000
Message-ID: <20240110085733.1607526-19-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240110085733.1607526-1-alistair.francis@wdc.com>
References: <20240110085733.1607526-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52e.google.com
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

Add APLIC structures for each socket in the MADT when system is configured
with APLIC as the external wired interrupt controller.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20231218150247.466427-8-sunilvl@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/virt-acpi-build.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
index 32b5795f09..f50f022dc2 100644
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
2.43.0


