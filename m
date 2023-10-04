Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D24F37B7AAA
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 10:51:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnxWw-0000Oo-MB; Wed, 04 Oct 2023 04:46:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxVQ-0007IQ-PL
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:45:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxVJ-00028V-7s
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:45:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696409112;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xw6Bz6DtadtcXL1/+moz2S000URpeULig/IIPNM74no=;
 b=XAefjD7+g0KLp10lcggGAWkhQpiTCfF0kSyJB8AlXTSioqvmWCGAsNmky+yJ07ixLdBHaN
 EVtxPA/0tpOHcJv6HpAsCNiQOoVvQwIBRBoQRjGKwbhx1jSqpCHDUK1DzlnlkwIjDymwKc
 NdJcO/Cd2yv454UpnurCnKsLcdU8mcw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-J63PW465OHWFgqTl8RPgaw-1; Wed, 04 Oct 2023 04:45:07 -0400
X-MC-Unique: J63PW465OHWFgqTl8RPgaw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f42bcef2acso12566055e9.2
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 01:45:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696409106; x=1697013906;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xw6Bz6DtadtcXL1/+moz2S000URpeULig/IIPNM74no=;
 b=OOgBOyhuecNjGeZy94lYkbFSdfG1HUZXgUkzVtNe3MHl4sdNdCfk4bnrCwsvUuKTGG
 dFXYkigu0uaqJcfgq6dW6PkIdfJuPVI1FpQZhmwNM8i+upRNMVQ0i06watLY2GodRNQn
 prOVB4qxe6CoHDbXVX1QJnzrZ02PupSBX0ppHfHUJgb7UsOfrNdgaxPrufoIcoqa+/6m
 dPwi7T1bKxZ6cjVsQ//vJddMMsR1ODdVVyg0YyjJvVALnypVOpVDfGIyP+RbPo/KK9kv
 YXeGdXJ7EyrfTb7f7Uq6ICcDaKzhAIxEZjc9xWhLts8DbSle4kyRCF8jq4ytcdtHVip4
 Mn/w==
X-Gm-Message-State: AOJu0Yyh4Cm1BNTtIGKU1x501nWoB+MyuIN05DwNkvGmVvi3VuLcTuch
 79guPl7NwZqJf1xu+2wzFGVWVreirWALpuBa4+JR+xI4/P8cr85gQjkYbhf99fzQ9hV8nP8wfvg
 sGh+2hdV5+UNkDM0HFvVM5uUsfNZNIXyuAsKBYG2AJQtrZH5N6tA+PRX3czSEnI0Wad6m
X-Received: by 2002:a05:600c:2211:b0:402:fec4:fddc with SMTP id
 z17-20020a05600c221100b00402fec4fddcmr1749139wml.17.1696409106086; 
 Wed, 04 Oct 2023 01:45:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGK8sVrUQM4gN/P9BSqzwJCO19dCKiYHkMbcq7zWzk/x1Dkn+Cjrq4ValN7ib0wioKM4RoBqg==
X-Received: by 2002:a05:600c:2211:b0:402:fec4:fddc with SMTP id
 z17-20020a05600c221100b00402fec4fddcmr1749112wml.17.1696409105617; 
 Wed, 04 Oct 2023 01:45:05 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 e11-20020a05600c218b00b0040472ad9a3dsm936248wme.14.2023.10.04.01.45.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 01:45:05 -0700 (PDT)
Date: Wed, 4 Oct 2023 04:45:02 -0400
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
Subject: [PULL 36/63] hw/acpi/cpu: Have build_cpus_aml() take a
 build_madt_cpu_fn callback
Message-ID: <b46ecb2b76985ff6b8b6fc3ab4960bd10cb8708f.1696408966.git.mst@redhat.com>
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

build_cpus_aml() is architecture independent but needs to create architecture-
specific CPU AML. So far this was achieved by using a virtual method from
TYPE_ACPI_DEVICE_IF. However, build_cpus_aml() would resolve this interface from
global (!) state. This makes it quite incomprehensible where this interface
comes from (TYPE_PIIX4_PM?, TYPE_ICH9_LPC_DEVICE?, TYPE_ACPI_GED_X86?) an can
lead to crashes when the generic code is ported to new architectures.

So far, build_cpus_aml() is only called in architecture-specific code -- and
only in x86. We can therefore simply pass pc_madt_cpu_entry() as callback to
build_cpus_aml(). This is the same callback that would be used through
TYPE_ACPI_DEVICE_IF.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230908084234.17642-3-shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/acpi/cpu.h | 6 +++++-
 hw/acpi/cpu.c         | 8 ++------
 hw/i386/acpi-build.c  | 4 ++--
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/hw/acpi/cpu.h b/include/hw/acpi/cpu.h
index 999caaf510..bc901660fb 100644
--- a/include/hw/acpi/cpu.h
+++ b/include/hw/acpi/cpu.h
@@ -15,6 +15,7 @@
 #include "hw/qdev-core.h"
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/aml-build.h"
+#include "hw/boards.h"
 #include "hw/hotplug.h"
 
 typedef struct AcpiCpuStatus {
@@ -55,8 +56,11 @@ typedef struct CPUHotplugFeatures {
     const char *smi_path;
 } CPUHotplugFeatures;
 
+typedef void (*build_madt_cpu_fn)(int uid, const CPUArchIdList *apic_ids,
+                                  GArray *entry, bool force_enabled);
+
 void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
-                    hwaddr io_base,
+                    build_madt_cpu_fn build_madt_cpu, hwaddr io_base,
                     const char *res_root,
                     const char *event_handler_method);
 
diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
index 19c154d78f..65a3202d3f 100644
--- a/hw/acpi/cpu.c
+++ b/hw/acpi/cpu.c
@@ -338,7 +338,7 @@ const VMStateDescription vmstate_cpu_hotplug = {
 #define CPU_FW_EJECT_EVENT "CEJF"
 
 void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
-                    hwaddr io_base,
+                    build_madt_cpu_fn build_madt_cpu, hwaddr io_base,
                     const char *res_root,
                     const char *event_handler_method)
 {
@@ -353,8 +353,6 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
     MachineClass *mc = MACHINE_GET_CLASS(machine);
     const CPUArchIdList *arch_ids = mc->possible_cpu_arch_ids(machine);
     char *cphp_res_path = g_strdup_printf("%s." CPUHP_RES_DEVICE, res_root);
-    Object *obj = object_resolve_path_type("", TYPE_ACPI_DEVICE_IF, NULL);
-    AcpiDeviceIfClass *adevc = ACPI_DEVICE_IF_GET_CLASS(obj);
 
     cpu_ctrl_dev = aml_device("%s", cphp_res_path);
     {
@@ -664,9 +662,7 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
             aml_append(dev, method);
 
             /* build _MAT object */
-            assert(adevc && adevc->madt_cpu);
-            adevc->madt_cpu(i, arch_ids, madt_buf,
-                            true); /* set enabled flag */
+            build_madt_cpu(i, arch_ids, madt_buf, true); /* set enabled flag */
             aml_append(dev, aml_name_decl("_MAT",
                 aml_buffer(madt_buf->len, (uint8_t *)madt_buf->data)));
             g_array_free(madt_buf, true);
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 1a7245bea4..dd94154f2b 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1550,8 +1550,8 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
             .smi_path = pm->smi_on_cpuhp ? "\\_SB.PCI0.SMI0.SMIC" : NULL,
             .fw_unplugs_cpu = pm->smi_on_cpu_unplug,
         };
-        build_cpus_aml(dsdt, machine, opts, pm->cpu_hp_io_base,
-                       "\\_SB.PCI0", "\\_GPE._E02");
+        build_cpus_aml(dsdt, machine, opts, pc_madt_cpu_entry,
+                       pm->cpu_hp_io_base, "\\_SB.PCI0", "\\_GPE._E02");
     }
 
     if (pcms->memhp_io_base && nr_mem) {
-- 
MST


