Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ADE6829599
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 10:03:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNUR0-0004hm-Vb; Wed, 10 Jan 2024 03:59:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rNUQj-0004GK-I1
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 03:59:22 -0500
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rNUQg-00043L-GS
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 03:59:19 -0500
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3bbd6e37a9bso3589687b6e.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 00:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704877157; x=1705481957; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vE0lP4Axpm3DKHCpKngN4Z227iLi4LYcdoCtXFWpHHA=;
 b=WElou32n0i2qqIDioMkBey7NINgaouTsw92OyxqikqWKh2dBGq3Qwsfz51a/t80SBd
 XsgXdSK8Al5voJPPxw9gdQKrcbun/n7pizpp47HEmkFFZ+OhX0d2bmI28FlvuRDdzmw+
 vWwHIjx43BS+EX5wCPs+iembxmahwaRP1UQ5fBCJr8zQyI6afRE/sWVO1MTX7zo3KOqK
 2r4TLy9IvcljoedITlCjdh2ukcrSgqOc0QmcFlit/8pDhHuyO3OmCuCixLkWssY6lmTj
 g08PtjuJ7g3tTIk6FlohI9ACcI+K4YKQDWFb9mrs5tT95W15NuySNZ5uVg3i2T3Q/RY/
 G2Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704877157; x=1705481957;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vE0lP4Axpm3DKHCpKngN4Z227iLi4LYcdoCtXFWpHHA=;
 b=J1o+WUu1zBKUPNQQ5O4DUJAAJaAsr8X6IRQ8qrRvJjPjleDImZ722vIU7pgJcrBf8f
 66M52s49ykssX6wWH+Nzc19VU948SZgiUuDGYOtxcy8hNrHXaI1TQQ2kVZqctJlpJJcQ
 k38P2Esef2uvsFobsHHBFP1hDfI3/d2ApXjHr1e7SfIYqCMtFfYULWzlVLP0qcXGdh1e
 bwNqRCW5Nq47h/P48230P9V/4oVrfR0erlJwz0EEwaUfC8qqTpq3kl5p4trCp78kCFbt
 puDtmkVnBFz7U0UatP4UwqtECH6mFN2z8ka+5WHXbvjlEZcPiwfC5F0FFqy8mL02lWsH
 WrDQ==
X-Gm-Message-State: AOJu0YyEzMIhzndrovAhJ5soWGdTotsBfzBLb6LmTJ6Sm/qaijpMcZJM
 dkpwfHQelENpFReIolNzzCRUxlW36Lph70IF
X-Google-Smtp-Source: AGHT+IFQjTkLP+lq1C0hCJheEpUvOeZR5d2l4VbBaTO8gdhpQ9ULzpznQ/RxTSFR56defhO7x0Q0lA==
X-Received: by 2002:a05:6358:18e:b0:175:13f0:a5bf with SMTP id
 d14-20020a056358018e00b0017513f0a5bfmr668154rwa.62.1704877157076; 
 Wed, 10 Jan 2024 00:59:17 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 t65-20020a628144000000b006d9879ba6besm3223814pfd.170.2024.01.10.00.59.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 00:59:16 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Sunil V L <sunilvl@ventanamicro.com>,
 Haibo Xu <haibo1.xu@intel.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PULL 24/65] hw/riscv/virt-acpi-build.c: Add PLIC in MADT
Date: Wed, 10 Jan 2024 18:56:52 +1000
Message-ID: <20240110085733.1607526-25-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240110085733.1607526-1-alistair.francis@wdc.com>
References: <20240110085733.1607526-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22a;
 envelope-from=alistair23@gmail.com; helo=mail-oi1-x22a.google.com
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

Add PLIC structures for each socket in the MADT when system is
configured with PLIC as the external interrupt controller.

Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20231218150247.466427-14-sunilvl@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/virt-acpi-build.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
index 536e6b0243..26c7e4482d 100644
--- a/hw/riscv/virt-acpi-build.c
+++ b/hw/riscv/virt-acpi-build.c
@@ -94,6 +94,12 @@ static void riscv_acpi_madt_add_rintc(uint32_t uid,
                                       arch_ids->cpus[uid].props.node_id,
                                       local_cpu_id),
                                   4);
+    } else if (s->aia_type == VIRT_AIA_TYPE_NONE) {
+        build_append_int_noprefix(entry,
+                                  ACPI_BUILD_INTC_ID(
+                                      arch_ids->cpus[uid].props.node_id,
+                                      2 * local_cpu_id + 1),
+                                  4);
     } else {
         build_append_int_noprefix(entry, 0, 4);
     }
@@ -494,6 +500,29 @@ static void build_madt(GArray *table_data,
             build_append_int_noprefix(table_data,
                                       s->memmap[VIRT_APLIC_S].size, 4);
         }
+    } else {
+        /* PLICs */
+        for (socket = 0; socket < riscv_socket_count(ms); socket++) {
+            aplic_addr = s->memmap[VIRT_PLIC].base +
+                         s->memmap[VIRT_PLIC].size * socket;
+            gsi_base = VIRT_IRQCHIP_NUM_SOURCES * socket;
+            build_append_int_noprefix(table_data, 0x1B, 1);   /* Type */
+            build_append_int_noprefix(table_data, 36, 1);     /* Length */
+            build_append_int_noprefix(table_data, 1, 1);      /* Version */
+            build_append_int_noprefix(table_data, socket, 1); /* PLIC ID */
+            build_append_int_noprefix(table_data, 0, 8);      /* Hardware ID */
+            /* Total External Interrupt Sources Supported */
+            build_append_int_noprefix(table_data,
+                                      VIRT_IRQCHIP_NUM_SOURCES - 1, 2);
+            build_append_int_noprefix(table_data, 0, 2);     /* Max Priority */
+            build_append_int_noprefix(table_data, 0, 4);     /* Flags */
+            /* PLIC Size */
+            build_append_int_noprefix(table_data, s->memmap[VIRT_PLIC].size, 4);
+            /* PLIC Address */
+            build_append_int_noprefix(table_data, aplic_addr, 8);
+            /* Global System Interrupt Vector Base */
+            build_append_int_noprefix(table_data, gsi_base, 4);
+        }
     }
 
     acpi_table_end(linker, &table);
-- 
2.43.0


