Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7996B7B7ABF
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 10:52:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnxWv-0000Cc-0W; Wed, 04 Oct 2023 04:46:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxVF-00073Z-Jn
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:45:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxVD-00027I-A5
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:45:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696409105;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aRLGO3ROPe38Pozt/ElsPNnXhjDSsHIqbZ5GyEywNd0=;
 b=YWscxSb3zoDa+g9ocxIt8R+dmiQte3ECApQPhY3roX965+4X/7CdXlQ3PEcRA0qyqtFulh
 a+yx78oM+slwwnUBydUShk7PwwRzn0JZQyLJHarBfvi3b9hzqOO9DVx1mKdMxjhiJw6Pwb
 WMj9T6CsP1neY2kPu/hsAO5CvPuqabs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-7_ucfwpZO1eO3i_oEgxhJA-1; Wed, 04 Oct 2023 04:45:04 -0400
X-MC-Unique: 7_ucfwpZO1eO3i_oEgxhJA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-32320b3ee93so1407116f8f.3
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 01:45:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696409102; x=1697013902;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aRLGO3ROPe38Pozt/ElsPNnXhjDSsHIqbZ5GyEywNd0=;
 b=EZ2UJitHTCepWH1sMhZA0RwD13Mj8zeVFUxJ656RahMybeZkADuTEukJHwdpg7m2uZ
 0lT7VR+s77q8nIJAdfegBxZT0wyeGzaSGDjuXFHQPcukU9ReK8Ent8EQXS34npb0Az0h
 xinPr0zcMJKheI9j5PFGulPe675RIIZwE8+R/yLvgsTfXHJkDVHqCSstOIDh+zQ6Ybbv
 PDuWA/mDUOpetWiRVfvJgzdzCTokRXDdTtn5eqoOXYtP9wSg03qoP/+j6pvBe8AYZ8lk
 PBO3xu1Ly33qPHkKcHJC4yaZ0cAExgkBWqHk/4sD774IBPfRpXxkJxTX6pAg2WE8Sf+C
 TYmQ==
X-Gm-Message-State: AOJu0YyEEvBYdMz1sUkUHl44WRtI95Q9sfu7GyoYcy51WtIhDwVexxiN
 bmhtTUJjIqKL+Fs4bClwGl0qXo7ym1/rYxTHvT+TsbEVIJ1P7pw1HQnMj6woMuhT8vTQiPhvvjL
 BXlKIdofgj/GMRMn3n45WocBE5XJiWiDQ0tASOz81k/QLPd38m2qCN+Eo99RRiQ8Eu5hh
X-Received: by 2002:a5d:42c5:0:b0:31f:ddee:d216 with SMTP id
 t5-20020a5d42c5000000b0031fddeed216mr1470902wrr.69.1696409102476; 
 Wed, 04 Oct 2023 01:45:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRI5kWNu/ldB68vyZ2Wlw+828v3yqtUvItOgpSv/6oYsxfi3jMCupsCC0RRNZCWJYI2qAqaQ==
X-Received: by 2002:a5d:42c5:0:b0:31f:ddee:d216 with SMTP id
 t5-20020a5d42c5000000b0031fddeed216mr1470880wrr.69.1696409102193; 
 Wed, 04 Oct 2023 01:45:02 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 y22-20020a1c4b16000000b0040642a1df1csm929848wma.25.2023.10.04.01.45.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 01:45:01 -0700 (PDT)
Date: Wed, 4 Oct 2023 04:44:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 35/63] hw/i386/acpi-build: Use pc_madt_cpu_entry() directly
Message-ID: <e3eff26e9ebb4aab4045c3b934a2e00d3a8645c6.1696408966.git.mst@redhat.com>
References: <cover.1696408966.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1696408966.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Bernhard Beschow <shentey@gmail.com>

This is x86-specific code, so there is no advantage in using
pc_madt_cpu_entry() behind an architecture-agnostic interface.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230908084234.17642-2-shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
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
index 4fb18fee3c..1a7245bea4 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2548,8 +2548,7 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
 
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
MST


