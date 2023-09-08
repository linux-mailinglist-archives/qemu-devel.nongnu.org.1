Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A49479845E
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 10:45:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeX4r-0002xt-Sb; Fri, 08 Sep 2023 04:42:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qeX4k-0002dX-8d
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 04:42:50 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qeX4h-0004nq-Kt
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 04:42:50 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-402cc6b8bedso20649765e9.1
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 01:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694162565; x=1694767365; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2M1a6xWHtcznkl3KHecraUUuAOpcAOWpgKcMmqLgxMw=;
 b=M2f3yN1Y0fIAOwAOHgydgKHA5MWh/49ysQKb/5bEAFzn+taKfGkNK14W66UP+k14VS
 99xxwjd1xR8btd/L19pq/PdOSYv7w/1o4UIcGFfYw92FPwh7RLGQo0kZydlxJqKW+pO3
 MO5fM0TNCV4P1nTeHzvyGadCqm3I6b2dREE0aaKPH52U5fbfkzcpS/vzbn9u2bSmcSHR
 HRWsCX+tXlUK4i66JlDRxzTPtQEOtyuoxslflAGNHL10RiXjcKNMgwXW83h7hzZwu49Z
 PuQ/swgR6POChAgvxFWHUjLtKdLexu4TpXJ1lWY9UX2WEE0uzyDDbhOlRXtlBzUBJeam
 AxMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694162565; x=1694767365;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2M1a6xWHtcznkl3KHecraUUuAOpcAOWpgKcMmqLgxMw=;
 b=QrahczS3DAtvVCitBxtigcGajmo0b9ed+31hTOg9QuWxgOntE2e2+v0eg6MplU1AL4
 veGD0G9ceX3Gh/frSJN91BMppCoGFu1Pth/ZG5q+8oBKTfD7CtOd9O3/JU1tVOUTf9VH
 EOYVV1uh0jJx9NbJS+V4u+8qVqUIlCcaiekcsgi6b9nIeXWpAU3iOMPAww+QUsP3Suaz
 nWHem1sAPKp3EttiMPnTHLX2mirDMyteKhBUR6GSW6Sov4ilRX3nIlK9EWZ42qghaGgO
 qKWJc4gu+X8iNZGwbsKeBPm5cKoUpG3UGpXiOacXMqWIIAFJ5PfKyTuSVdCBFrflyCui
 rv+g==
X-Gm-Message-State: AOJu0YwWZuZv9ChSVczegcJCVyS8qzhMEkDbX9X27uEcipxpErRFaM1g
 HLoTevmn74/SYefPemegf/4NrE04Lb8=
X-Google-Smtp-Source: AGHT+IE9hp86a1ppdHAhZWI7X/khI1AxdgIQdsKxSzwJoEMNmBSKgVYV9P+5dV+oGFbH4YIHZpk+Cg==
X-Received: by 2002:a05:600c:364c:b0:3fe:16f4:d865 with SMTP id
 y12-20020a05600c364c00b003fe16f4d865mr1542874wmq.23.1694162564664; 
 Fri, 08 Sep 2023 01:42:44 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-078-054-093-170.78.54.pool.telefonica.de. [78.54.93.170])
 by smtp.gmail.com with ESMTPSA id
 h17-20020a056000001100b003197c2316ecsm1462139wrx.112.2023.09.08.01.42.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Sep 2023 01:42:43 -0700 (PDT)
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
Subject: [PATCH v2 2/8] hw/acpi/cpu: Have build_cpus_aml() take a
 build_madt_cpu_fn callback
Date: Fri,  8 Sep 2023 10:42:28 +0200
Message-ID: <20230908084234.17642-3-shentey@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230908084234.17642-1-shentey@gmail.com>
References: <20230908084234.17642-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x334.google.com
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
index 09586b8d9b..c8ac665d36 100644
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
2.42.0


