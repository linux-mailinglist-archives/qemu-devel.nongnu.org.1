Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D0EB7871C1
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 16:37:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZBNV-0003Pg-IS; Thu, 24 Aug 2023 10:32:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1qZBNS-0003EW-Vn
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 10:32:03 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1qZBNQ-0000zc-HW
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 10:32:02 -0400
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-6bc9811558cso4824001a34.0
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 07:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1692887519; x=1693492319;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SCpS0dTsmFNvxODyTbWGlW3/nXcvoDxX4WhvDIxc6OE=;
 b=eOyXZXbfqhs8GkrvqOKdjw/GyjSmTKN+tv7mS/8exdQ1JWZS/BbtqsldT66OqxkURE
 PHbvejpbCPY4h/YiRQN2u3io4XFwL2fCPIl9mqoBqrl6BQUvgHHDUr89v0SLNU8PnCVr
 eLgbYmssJYvSSlv4pu77sdDnn5GDT7L9I9OvTfvQEkUpW1vWY4ECfDBvPw2POsw7qzjO
 Zrn2xq5auXhhlk+QX4hvVVn2xvO8LC6ePrHsD6lCKeqmWPvc9UJSdu5zwnIH+Ns2hGrR
 6+y1tC/7Qr+SMzUO7F1yor3SxJZ3T4fRoug4nFAhPwXSehnIKETWxm+N+/Npkux0L6oD
 mgmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692887519; x=1693492319;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SCpS0dTsmFNvxODyTbWGlW3/nXcvoDxX4WhvDIxc6OE=;
 b=iLbdkYGir2E2U5vmwNJMo4btZ4lJpwpT06t26sYY6XwkF892Jo5JI3rs5EZzptaO9l
 kNzOXP8Qn/R3ZpFQi8gz7gkvDQi800r895CkRpJC2kYk0AJhuNIY0M4z2L4WT5bdB4Pg
 XCcE3ZM8B0jum9GtgGNSbgL+ZAdhEmVlHf10AyqA0ovSwXtUT6tqL4u+biAiGBZmFpyn
 kaI3IFOTjU+6vAP6D0Am9Be753dVO8sY4V3EK7tW3AQGLmuCqOmTDdebx/SrvUqd5D4L
 u0hy34CfJVssqYV9TQlDd+2bDZleJFAhcSrg+tPpBf0gU5wipavqOFBGwH30jrfDcvU2
 KiYA==
X-Gm-Message-State: AOJu0YxhThT8enh+OcjiZHk4FkxhF9mw/mvghjQxyiJEAR0WeTBCCQiE
 ypPHNHejaQAWlCitarAl31p4Vw==
X-Google-Smtp-Source: AGHT+IG55lI4NbTk/RLhcO0yJsAtogsPx+Oifwpp5PHot1G6++sOrMFxEX2HU8NpEXgIXmQJopj9zw==
X-Received: by 2002:a05:6870:d28d:b0:1c8:baa5:a50f with SMTP id
 d13-20020a056870d28d00b001c8baa5a50fmr20533432oae.27.1692887519325; 
 Thu, 24 Aug 2023 07:31:59 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.191.205])
 by smtp.gmail.com with ESMTPSA id
 n6-20020a17090a2bc600b00262fc3d911esm1666864pje.28.2023.08.24.07.31.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 07:31:57 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
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
Subject: [PATCH v2 12/12] hw/riscv/virt-acpi-build.c: Add PLIC in MADT
Date: Thu, 24 Aug 2023 19:59:42 +0530
Message-Id: <20230824142942.3983650-13-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230824142942.3983650-1-sunilvl@ventanamicro.com>
References: <20230824142942.3983650-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::334;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-ot1-x334.google.com
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

Add PLIC structures for each socket in the MADT when system is configured
with PLIC as the external interrupt controller.

Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 hw/riscv/virt-acpi-build.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
index bd0f9f3d87..62914565bd 100644
--- a/hw/riscv/virt-acpi-build.c
+++ b/hw/riscv/virt-acpi-build.c
@@ -85,6 +85,12 @@ static void riscv_acpi_madt_add_rintc(uint32_t uid,
                                       arch_ids->cpus[uid].props.node_id,
                                       local_cpu_id),
                                   4);
+    } else if (aia_type == VIRT_AIA_TYPE_NONE) {
+        build_append_int_noprefix(entry,
+                                  ACPI_BUILD_INTC_ID(
+                                      arch_ids->cpus[uid].props.node_id,
+                                      2 * local_cpu_id + 1),
+                                  4);
     } else {
         build_append_int_noprefix(entry, 0, 4);
     }
@@ -513,6 +519,29 @@ static void build_madt(GArray *table_data,
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
+            build_append_int_noprefix(table_data, 0, 2);     /* Max priority */
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
2.39.2


