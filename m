Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C50B7B9A4E
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 05:44:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoFHz-0006Bg-Ek; Wed, 04 Oct 2023 23:44:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qoFHk-0004yz-KK
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 23:44:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qoFHi-0000G1-R2
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 23:44:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696477462;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lsmr9uE1xRXPM9KOL778YFqc28uXJQm8cgVPqwE4uHY=;
 b=gzPVl9QGpVKQY3PSCV65lXvV1i/+rI8es0W5DME4zfu8ZL8Ywf1Qo+4fvwkW8FGTqm/+bn
 Ue+9bHY8pRdREkuuImfBYFpOLHLZ5yZXjOe1ForIr1X6nqxTEajBgf+ZFGCK4k7SGsVeof
 MyW+maZar3eKBDHc97V7h91AZLWQDC0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-7Zx1uVLPMTiESzDfs_wphA-1; Wed, 04 Oct 2023 23:44:10 -0400
X-MC-Unique: 7Zx1uVLPMTiESzDfs_wphA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3217fdf913dso406704f8f.3
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 20:44:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696477449; x=1697082249;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Lsmr9uE1xRXPM9KOL778YFqc28uXJQm8cgVPqwE4uHY=;
 b=kjU/SR0JMtxJqEw9r4Q5AcT7jBOdFOaewX+yrqVaEb9b0ZkIlE/Bc+jlKdPRJRpg/V
 7HUR0wsezMoz2zuFsqLgq1XyRvAAsWOUyOPEXldnlpD35EkaAUVg+S2hJKm/ZNLz46WS
 QW/NpNePplS9A2NNMmk7H+Wkx6zoq6KS5wW3OIT6NVxEuP2U+5ao+z/CDlKD8IFRnYxN
 a3D73sMDIPmE9ZdPBj8dmKyqRdefVyHKbx/Ow5Ai5DLlj1PJaYu2egIfWwO+Bk9qd2Ng
 BrayPHB4CBza9WpUEFFRHTuYbh94R8rViCdEaWwcM329PniGjYiQN4cp3JTEpH46KBER
 5cqQ==
X-Gm-Message-State: AOJu0YwPSuIeEkFslHkA/F1POZLSKYv7N+7QdJt1G7ffxRSqMAs0vgA3
 ms/R3a3uTGfXCf8xxjCjTo8G10mQZeGYyr9jRrZQv58fGlGVkBiNe4v3aBoZH0VnA9zGwb4pW0G
 Ljw2YUn6EJI78zwxeSzOKuuPYOwuV4pvIBv9d3VbumtHJrxVpeq/1XtUoOtlHV4MLyNJY
X-Received: by 2002:adf:ee04:0:b0:31f:fcee:afcf with SMTP id
 y4-20020adfee04000000b0031ffceeafcfmr3454394wrn.71.1696477448946; 
 Wed, 04 Oct 2023 20:44:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7/fBRSZMnex7Pf6Vt0/iplQJ7CJmVP/B9A0RX1f7nitJpOoMdCZxH0jhFFpTt8l8RKnY3fw==
X-Received: by 2002:adf:ee04:0:b0:31f:fcee:afcf with SMTP id
 y4-20020adfee04000000b0031ffceeafcfmr3454379wrn.71.1696477448701; 
 Wed, 04 Oct 2023 20:44:08 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 e13-20020a5d500d000000b003259b068ba6sm636913wrt.7.2023.10.04.20.44.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 20:44:08 -0700 (PDT)
Date: Wed, 4 Oct 2023 23:44:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL v2 25/53] hw/i386/acpi-build: Use pc_madt_cpu_entry() directly
Message-ID: <f4a06e5921ec93bbb8baeca59f662672077535c3.1696477105.git.mst@redhat.com>
References: <cover.1696477105.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1696477105.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
index 4d2d40bab5..2879e0d555 100644
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
MST


