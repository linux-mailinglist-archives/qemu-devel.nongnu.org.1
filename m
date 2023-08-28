Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5423478A69C
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 09:38:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaWna-0006Wk-OH; Mon, 28 Aug 2023 03:36:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qaWnR-0006T6-41
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 03:36:25 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qaWnO-0004Iu-Np
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 03:36:24 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3fe4cdb72b9so28123425e9.0
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 00:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693208181; x=1693812981;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=StfMQ7yyQc/VnKac7occRcBTAIqflJOOrES/qO1oM/8=;
 b=muUz4l0kTvSuN5c1gbwG0df980lCN9N6lz+dyO5c4wfFup6yjQGd2W4b1/94T+mf/Z
 ztcCzuuvSCUSSZC3+2Yn/krN8NBrKfBJMeyKjhh44IPZxNQD4Nzdwc3sIhiFIkH+w9Lm
 tAcOE6ltk6ZX+ub1ahGTR0tJg/P4EEuUwMr/CzpiORqc2xOE/Z4LK6QM411lAUBLJZJ2
 xMeuOaVlfUTo3AJWVXC2YuK1xpiCP0nppP8zFMV4mnO/UP2jbDvOOm+J9i7m6zljma1I
 5o8iyrR0wfwVeymF4BJC0f4rAw6clajDqTr90Xo60c/xcCm0827i7oSjYVAviraIR1Kn
 VNgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693208181; x=1693812981;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=StfMQ7yyQc/VnKac7occRcBTAIqflJOOrES/qO1oM/8=;
 b=d/XFgxWJVeOXv9OU7D1FSaZkn/HNrkI4sQA5o1XuACqyz3u2nIu15WJNJkK1RARGIU
 CwRAI5hKjxr8DaH6/iM74C+t+srVO6+79iPyErqTtV5Dy3/l8tbqm5suhKbpMEx5A3Ck
 Gql/L5jUQQoqznFgGZrEk6M0E44CcdV4L/jTGaV7aTb5KjH9B6cROfiTysiGgKw7xovN
 SGz2siuuysxL+wwZ7Gv4Gf2arrTKYQUh9Wg3NvVV3MdKRxeDUGQCpWo1F7uZRDLEJzcH
 ioItLJsmmqGYIeNCgnKLG/0xHrATmNFsnEZCHsyQhiC9aJhGYZnazG53HavFW6K063r+
 S6cw==
X-Gm-Message-State: AOJu0YwWIaBAkTKcznFdQC8Wg3leev+WQeU0n+11V6WUMGNK6HJ4o4lV
 h21ak4cCgtT8hnsJhh0Qhy2CxQUo5hMnoA==
X-Google-Smtp-Source: AGHT+IFOqYXoWSTUI6oWvT6T5IjrKxpv3B9wY2GXyBKjs1cxLm965S/vPGhKcZ5YFhXu03ptPFDEFA==
X-Received: by 2002:a1c:7303:0:b0:3fe:19cf:93c9 with SMTP id
 d3-20020a1c7303000000b003fe19cf93c9mr18754669wmb.1.1693208180796; 
 Mon, 28 Aug 2023 00:36:20 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-078-055-055-138.78.55.pool.telefonica.de. [78.55.55.138])
 by smtp.gmail.com with ESMTPSA id
 m17-20020a05600c281100b003fef19bb55csm9795285wmb.34.2023.08.28.00.36.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 00:36:20 -0700 (PDT)
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
Subject: [PATCH 2/8] hw/acpi/cpu: Have build_cpus_aml() take a
 build_madt_cpu_fn callback
Date: Mon, 28 Aug 2023 09:36:03 +0200
Message-ID: <20230828073609.5710-3-shentey@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828073609.5710-1-shentey@gmail.com>
References: <20230828073609.5710-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x329.google.com
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


