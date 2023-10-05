Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D895A7B9A6D
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 05:49:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoFHs-0005Gm-Ib; Wed, 04 Oct 2023 23:44:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qoFHf-0004v6-FD
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 23:44:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qoFHd-0000Fg-Tj
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 23:44:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696477457;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h5eWtGUZ1Sz0a7PtH5EXwS3f64jDeuvdbuje94iZaYI=;
 b=ePRtqr4cpgWF7TnaahTHdBUgT0WdU4zrBFrj11uK75aPQ93XHF5ykTLYEaba+MDE08dQ99
 H4oSG3mu2ym3Vc1IoMDxFcKuCaCbwn/+P9x67FuPJxRghdcE2uIP92okOQILOK85aWk/s/
 3uCMpKEW2c0sfi9LeMnVlWNs6pdE8iU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-Tj4R8C7lPJSBW0h33FUlDw-1; Wed, 04 Oct 2023 23:44:16 -0400
X-MC-Unique: Tj4R8C7lPJSBW0h33FUlDw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4065d52a83aso4026805e9.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 20:44:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696477454; x=1697082254;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=h5eWtGUZ1Sz0a7PtH5EXwS3f64jDeuvdbuje94iZaYI=;
 b=ETA1sjQ7Y7mHSsSOu434vagE2IcCAUr8MaHB3tzY68y84FiaclbAESg+YLPijJGbXi
 xgV7Rmd4Gek58nWZHZrkfwaDq5DplYgPfOv8GnWMNsMGgdkNw9cWJoMlVrPpZ84nkaWC
 IEuxdkRDM+lV+KLB6wO7BloahPIi7BJo4JBi85k9YIAD4FzGSTrFokWZ20c96+WjMkW3
 TzFPkfctcAAVpc2zYaash6FlL7WuuwtEwJpJtj1bjVjLNGFJirE/PMEV7CL+j/zFEgAT
 FdEnhTyqC18jqYlQ+loGJ0dTLf6QFH96DrL8m5bR6TVVmmnI0FA1BvHv8lvWP3+rgZp2
 1bMw==
X-Gm-Message-State: AOJu0YxJKv8TV/qyFCkN7dIAyYbgPfHpDhyYrQ3vYOv3n31C+WOkEqPx
 VFlL+Fzq7YFyS4UdYNiJoJTrpoosOwrKVV9PqthEsSbKFDMtpfT+kaYLQH21SyQmYWKNmzjOqoF
 cZ2hedid+ijnnhFXl2FmDFwc6pvdu5o6fL7/JP1IqDSDb7V0CGN51dyC6P+J5+0ldNdSH
X-Received: by 2002:a05:600c:2219:b0:405:1c19:b747 with SMTP id
 z25-20020a05600c221900b004051c19b747mr3650759wml.15.1696477454370; 
 Wed, 04 Oct 2023 20:44:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHg6cErA8fFS56a0+kNkfyzZ9RFgwqK96cUyhGJcJmspkwR+nEtTMVRXxa4IEj9HrusZo89BA==
X-Received: by 2002:a05:600c:2219:b0:405:1c19:b747 with SMTP id
 z25-20020a05600c221900b004051c19b747mr3650742wml.15.1696477453931; 
 Wed, 04 Oct 2023 20:44:13 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 c5-20020a05600c0ac500b0040586360a36sm2766997wmr.17.2023.10.04.20.44.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 20:44:13 -0700 (PDT)
Date: Wed, 4 Oct 2023 23:44:09 -0400
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
Subject: [PULL v2 26/53] hw/acpi/cpu: Have build_cpus_aml() take a
 build_madt_cpu_fn callback
Message-ID: <9a4fedcf12ae388722fa5430df92d0f41e3ba9be.1696477105.git.mst@redhat.com>
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
index 2879e0d555..76581d51aa 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1549,8 +1549,8 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
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


