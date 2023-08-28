Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F3178A6A6
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 09:38:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaWna-0006Vc-0J; Mon, 28 Aug 2023 03:36:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qaWnQ-0006Sc-Jd
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 03:36:25 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qaWnN-0004Iq-J5
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 03:36:24 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3fe24dd8898so26475975e9.2
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 00:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693208179; x=1693812979;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E8WIkk+1VabMp7gLpv0o+qQaUPvZ3MkvWgBvwO/E//8=;
 b=NbaWg0GCpnL5kaTMxiRBQVUkGoz2rvXV4PgqgJ8gyGaNTx+RJTsYJlaXbmlsVpG+16
 8wIi+orImZRRgpRHSYWmuMZVkGrPy2KhZavCecjzYkyGZCgb+P1D6E20lAYAWvi428Pg
 yp/PE8yRPKFYScM1poyBYoX8og4Azc37uFkuIswQq9mmCPDi5NLsdCho6gHn++BsybGb
 BsYM7NgcrZTPPTuD/elmfNLAizN0nXd6A6ODDI1G4fGVdT0U33MUrSm29f+6acaHgBgL
 njQGpNMxGmCCJ8eZhECjnuoCsCHayQW3BQyqN+u5oF4yyI8pKMppx71LJ2gTSE+GVXZI
 fWCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693208179; x=1693812979;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E8WIkk+1VabMp7gLpv0o+qQaUPvZ3MkvWgBvwO/E//8=;
 b=T8vVbFpR8HvMIzt+VPeZONPQ/vGH7kmiyoH1gSscIY9kbc7M1e4t0pv31YDEhNJTwy
 KDHzgJn1rBe9SH5lgZ4vHdkv/MwCr+WswG5u0NlRBQGgv1kav4eOADmf6hYzbFTcB/Wl
 5vrsTqoIN3IbuHJqBGku8a0Pdku5VnDIfGrwbdQyfHGdHxmAH9YU2nPQbgbKleFxWNxE
 1AwfLvPScgZ3eAwHnMVkhCpoURs10WI2yYLkDPe5Yuhdxf/aGkRC3vhdB8Fr+pXCxWmd
 xBYK/JUvVBwBWR8SyS/dKMtFmnVivSJDlvUx5QhY2/Qcz739/QV33gmdEvGweMYR77ly
 kicQ==
X-Gm-Message-State: AOJu0YzYLzYWJ4/tJPDafYWHlq/VhWCJP9yr0CY94pKoYmOWCHC5P/Wu
 KfL/UFzHrQBfLnZ7sj9WKNQ9DYZqjd59TA==
X-Google-Smtp-Source: AGHT+IFovM9OvG7QNGtahimpYhtHp82bdfx1EUZhB8/ADTV/lDZU7vJUehpJLW2JsMT+6MkgNYyu3A==
X-Received: by 2002:a7b:c7d4:0:b0:401:b908:85a2 with SMTP id
 z20-20020a7bc7d4000000b00401b90885a2mr5351329wmk.23.1693208179265; 
 Mon, 28 Aug 2023 00:36:19 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-078-055-055-138.78.55.pool.telefonica.de. [78.55.55.138])
 by smtp.gmail.com with ESMTPSA id
 m17-20020a05600c281100b003fef19bb55csm9795285wmb.34.2023.08.28.00.36.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 00:36:18 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>, Sergio Lopez <slp@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 1/8] hw/i386/acpi-build: Use pc_madt_cpu_entry() directly
Date: Mon, 28 Aug 2023 09:36:02 +0200
Message-ID: <20230828073609.5710-2-shentey@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828073609.5710-1-shentey@gmail.com>
References: <20230828073609.5710-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

This is x86-specific code, so there is no advantage in using
pc_madt_cpu_entry() behind an architecture-agnostic interface.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
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


