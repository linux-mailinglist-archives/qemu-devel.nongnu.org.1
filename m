Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE052798451
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 10:44:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeX4y-0003LD-Ow; Fri, 08 Sep 2023 04:43:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qeX4t-000366-Sc
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 04:42:59 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qeX4f-0004iT-7J
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 04:42:59 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-400a087b0bfso19097815e9.2
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 01:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694162563; x=1694767363; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wI4+BqMSbzHC8yyv0Ubo5u82RwK3QnkP912SIXWOALs=;
 b=JT4GvbVVPUtyUru+mxvKeaZtL5rg0AKIXHbfEJZwnXOGYsUHF1KqvHTrxoCOfcSPqy
 IFUJ2+xUy7R+x7MkkuK66jIal9GbY+EC98PbSuDYCKCajXJEJW6GLAzMaBCupjdcauCk
 zZtMtKxM+eYCMixbKwrRAhc4pvlBVlHgce90lk9X1igromdtz8++x2MBKJ6A+QGxPoca
 RdmBQjXV9UAXaDPPx6s85eX0cCHgwJ60QrPYy5OzBSsUbjPbFrA18/v1kYFaGNeJ1kj1
 kZNiCWM6ocj7W3YU5PxpZ3PiFq0q9wcThkB07d9YYRnbDX6EMjxiXZsto3q5OGNh2AHl
 S5QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694162563; x=1694767363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wI4+BqMSbzHC8yyv0Ubo5u82RwK3QnkP912SIXWOALs=;
 b=XPgKyyz2922IDl4qp/Nfd71tFrRHXWbza53xsyFr/hvEfPQjMS0yx4VTnp3oZ5s3jT
 jICsQCalaJKxwW3i05FOgy5tjy6dIGTVs7Jrl7UfsL9NZzeMTSh+o9akmPkBGWajww51
 D+3sK8p5FBhSGmOsedEpuL63aqI530N7RTR1Lew65QkfaCY4QA9Das/rbgghD40pwy33
 d2YFEErlK7qN/G04Q7ZSIN4t02y15GW9L46gPNIwaRYfedbmqPCaFJ7bV7+yyApBsatK
 pXph+r6lHQ+G6/n3yRQvqeJrbSqM5f5JOkaKDHP55Z/ymK2c6WC298D5itiMpOwzrjrk
 2hOQ==
X-Gm-Message-State: AOJu0YyNHwk7nZpFtlUJ1iBbLWubxfef45tuyQcWCsIirKrOOQCnkxRS
 M7Gpn9y7JC79xW0nj7Ap03NukYph+a8=
X-Google-Smtp-Source: AGHT+IEUXBksrd4StwoY1G65OKbw/qBDbfNoVfOTyYn7bfG9KwvuLoANR1MnDziYrcOeOlEHThSEew==
X-Received: by 2002:a05:600c:204c:b0:401:23fc:1f92 with SMTP id
 p12-20020a05600c204c00b0040123fc1f92mr1544523wmg.25.1694162563249; 
 Fri, 08 Sep 2023 01:42:43 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-078-054-093-170.78.54.pool.telefonica.de. [78.54.93.170])
 by smtp.gmail.com with ESMTPSA id
 h17-20020a056000001100b003197c2316ecsm1462139wrx.112.2023.09.08.01.42.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Sep 2023 01:42:42 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Aurelien Jarno <aurelien@aurel32.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sergio Lopez <slp@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v2 1/8] hw/i386/acpi-build: Use pc_madt_cpu_entry() directly
Date: Fri,  8 Sep 2023 10:42:27 +0200
Message-ID: <20230908084234.17642-2-shentey@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230908084234.17642-1-shentey@gmail.com>
References: <20230908084234.17642-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_FROM=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This is x86-specific code, so there is no advantage in using
pc_madt_cpu_entry() behind an architecture-agnostic interface.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/acpi-common.h  | 3 +--
 hw/i386/acpi-build.c   | 3 +--
 hw/i386/acpi-common.c  | 5 ++---
 hw/i386/acpi-microvm.c | 3 +--
 4 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/hw/i386/acpi-common.h b/hw/i386/acpi-common.h
index a68825acf5..b3c56ee014 100644
--- a/hw/i386/acpi-common.h
+++ b/hw/i386/acpi-common.h
@@ -1,7 +1,6 @@
 #ifndef HW_I386_ACPI_COMMON_H
 #define HW_I386_ACPI_COMMON_H
 
-#include "hw/acpi/acpi_dev_interface.h"
 #include "hw/acpi/bios-linker-loader.h"
 #include "hw/i386/x86.h"
 
@@ -9,7 +8,7 @@
 #define ACPI_BUILD_IOAPIC_ID 0x0
 
 void acpi_build_madt(GArray *table_data, BIOSLinker *linker,
-                     X86MachineState *x86ms, AcpiDeviceIf *adev,
+                     X86MachineState *x86ms,
                      const char *oem_id, const char *oem_table_id);
 
 #endif
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index bb12b0ad43..09586b8d9b 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2547,8 +2547,7 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
 
     acpi_add_table(table_offsets, tables_blob);
     acpi_build_madt(tables_blob, tables->linker, x86ms,
-                    ACPI_DEVICE_IF(x86ms->acpi_dev), x86ms->oem_id,
-                    x86ms->oem_table_id);
+                    x86ms->oem_id, x86ms->oem_table_id);
 
 #ifdef CONFIG_ACPI_ERST
     {
diff --git a/hw/i386/acpi-common.c b/hw/i386/acpi-common.c
index 8a0932fe84..43dc23f7e0 100644
--- a/hw/i386/acpi-common.c
+++ b/hw/i386/acpi-common.c
@@ -94,14 +94,13 @@ build_xrupt_override(GArray *entry, uint8_t src, uint32_t gsi, uint16_t flags)
  * 5.2.8 Multiple APIC Description Table
  */
 void acpi_build_madt(GArray *table_data, BIOSLinker *linker,
-                     X86MachineState *x86ms, AcpiDeviceIf *adev,
+                     X86MachineState *x86ms,
                      const char *oem_id, const char *oem_table_id)
 {
     int i;
     bool x2apic_mode = false;
     MachineClass *mc = MACHINE_GET_CLASS(x86ms);
     const CPUArchIdList *apic_ids = mc->possible_cpu_arch_ids(MACHINE(x86ms));
-    AcpiDeviceIfClass *adevc = ACPI_DEVICE_IF_GET_CLASS(adev);
     AcpiTable table = { .sig = "APIC", .rev = 3, .oem_id = oem_id,
                         .oem_table_id = oem_table_id };
 
@@ -111,7 +110,7 @@ void acpi_build_madt(GArray *table_data, BIOSLinker *linker,
     build_append_int_noprefix(table_data, 1 /* PCAT_COMPAT */, 4); /* Flags */
 
     for (i = 0; i < apic_ids->len; i++) {
-        adevc->madt_cpu(i, apic_ids, table_data, false);
+        pc_madt_cpu_entry(i, apic_ids, table_data, false);
         if (apic_ids->cpus[i].arch_id > 254) {
             x2apic_mode = true;
         }
diff --git a/hw/i386/acpi-microvm.c b/hw/i386/acpi-microvm.c
index a075360d85..fec22d85c1 100644
--- a/hw/i386/acpi-microvm.c
+++ b/hw/i386/acpi-microvm.c
@@ -214,8 +214,7 @@ static void acpi_build_microvm(AcpiBuildTables *tables,
 
     acpi_add_table(table_offsets, tables_blob);
     acpi_build_madt(tables_blob, tables->linker, X86_MACHINE(machine),
-                    ACPI_DEVICE_IF(x86ms->acpi_dev), x86ms->oem_id,
-                    x86ms->oem_table_id);
+                    x86ms->oem_id, x86ms->oem_table_id);
 
 #ifdef CONFIG_ACPI_ERST
     {
-- 
2.42.0


