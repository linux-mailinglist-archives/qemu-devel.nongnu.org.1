Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0277DBBF4
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 15:41:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxTRd-0001Zi-9j; Mon, 30 Oct 2023 10:40:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qxTRZ-0001XO-GB
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 10:40:42 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qxTRW-0001vl-Ee
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 10:40:40 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-40842752c6eso35899315e9.1
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 07:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698676837; x=1699281637; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/nhttjW6fGHzpzQpigFGqu2RntvPUsap0hdm5++FEtY=;
 b=cQnsIBwTGOCL8PNbdaQcoUC7/0JGnA0D6wwfQ5IR4o27pKECWfSird8cAPSpmKdHpc
 +tNrerin0zl9f/nZRXF5y5N9pciqtlLdnU8l6th5XNwKeK1ZkZDXxNivltQMTzhuDk9Q
 ZSPgfcE6FNnU5m57gMFdKj1q6JxIJ7q7FyVAZDKZSjWsw57/unz0oHe3tBBif/EIUSM5
 hAXeQATnnhehqhbHGkjr9b/wEjmppcy6BHpVZQFxeSfO+e52yeL7Xg1RYcBqYND93tty
 1rIchvmCZPvyPYyYGX6CgYLVcfg/65bhPxlIZYFc5koVK9ctHLZCekfBwgzKwjmibDUG
 6ehw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698676837; x=1699281637;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/nhttjW6fGHzpzQpigFGqu2RntvPUsap0hdm5++FEtY=;
 b=ffGNxi3YxwDauIIuDBFk7tooO4pJ693RRip9hFasnctiIP/tonVJcKFeo4IVgcOO6x
 48OdN1oPXq4trSdFGQYO+V6qHooaQuln2sNfZigKpexyfso4F3XZstFwfmkJ56/yPUfi
 6wbWKPSVbEMlWs+pfK/xUNi7Onchu1XjWQzxIGddvYcpZrsv0TfW/CllYALVZJAXxCBf
 2nAexUyRgYrf+OoEaB5tMq8Wuz+p2LGLozWFOOK53RkZP4bL2Arn+BfiMZFE3zV6p39d
 jOLlpprOKTBjGNkp+NBHtlM72y3Q+njGsff9bbZkd4h40jAvUSCQRek4pVFAZwjnmf6A
 IJFg==
X-Gm-Message-State: AOJu0YyGISUzZUzmMqyNcokDeBgAI8iYD1QDg4uG3QWUKOr/U+08xmJ0
 s1LG6f8P4NsMf01tPzrVIc/H2K8Dmzj8LSJqF78=
X-Google-Smtp-Source: AGHT+IGw9Zw4AVLpyPMNpYfQu9hgU/YdqWs9X0eAyGX2njs86nUMWzRYvqTUsWcSj4e5L7KzOkRn4w==
X-Received: by 2002:a5d:4ccb:0:b0:32d:a0d9:2124 with SMTP id
 c11-20020a5d4ccb000000b0032da0d92124mr7575851wrt.35.1698676836704; 
 Mon, 30 Oct 2023 07:40:36 -0700 (PDT)
Received: from m1x-phil.lan ([176.170.212.50])
 by smtp.gmail.com with ESMTPSA id
 z8-20020adfe548000000b0031c52e81490sm8432316wrm.72.2023.10.30.07.40.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 30 Oct 2023 07:40:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Cc: Luc Michel <luc.michel@amd.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Bernhard Beschow <shentey@gmail.com>, qemu-ppc@nongnu.org,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH 5/5] hw/ppc/e500: Pass array of CPUs as array of canonical
 QOM paths
Date: Mon, 30 Oct 2023 15:39:56 +0100
Message-ID: <20231030143957.82988-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231030143957.82988-1-philmd@linaro.org>
References: <20231030143957.82988-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Devices should avoid calling qemu_get_cpu() because this call
doesn't work as expected with heterogeneous machines. Such
devices often iterate over a cluster of CPUs, which the device's
parent has direct access (when creating the child device).

We can pass QOM as 'link' between objects, but we can't pass an
array of links. Here we exploits QAPI simplicity, by using
DEFINE_PROP_ARRAY and a list of strings, each string being the
CPU canonical path in QOM tree (which is constant and unique).
When the device realizes itself, the original CPU pointer is
recovered via a object_resolve_path() call.

Inspired-by: Peter Maydell <peter.maydell@linaro.org>
Inspired-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Tested with:
$ make check-qtest-ppc{,64}
$ make check-avocado AVOCADO_TAGS='machine:ppce500 machine:mpc8544ds'

RFC: See cover

FIXME: Should we free spin_cpu_list using g_autoptr(QList)?
---
 hw/ppc/e500.c         |  6 ++++++
 hw/ppc/ppce500_spin.c | 48 ++++++++++++++++++++++++++++++++++++-------
 2 files changed, 47 insertions(+), 7 deletions(-)

diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index e38f46df38..8b31143dca 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -18,6 +18,7 @@
 #include "qemu/datadir.h"
 #include "qemu/units.h"
 #include "qemu/guest-random.h"
+#include "qapi/qmp/qlist.h"
 #include "qapi/error.h"
 #include "e500.h"
 #include "e500-ccsr.h"
@@ -930,11 +931,13 @@ void ppce500_init(MachineState *machine)
     SysBusDevice *s;
     PPCE500CCSRState *ccsr;
     I2CBus *i2c;
+    QList *spin_cpu_list = qlist_new();
 
     irqs = g_new0(IrqLines, smp_cpus);
     for (i = 0; i < smp_cpus; i++) {
         PowerPCCPU *cpu;
         CPUState *cs;
+        g_autofree char *cpu_qompath;
 
         cpu = POWERPC_CPU(object_new(machine->cpu_type));
         env = &cpu->env;
@@ -954,6 +957,8 @@ void ppce500_init(MachineState *machine)
         object_property_set_bool(OBJECT(cs), "start-powered-off", i != 0,
                                  &error_fatal);
         qdev_realize_and_unref(DEVICE(cs), NULL, &error_fatal);
+        cpu_qompath = object_get_canonical_path(OBJECT(cs));
+        qlist_append_str(spin_cpu_list, cpu_qompath);
 
         if (!firstenv) {
             firstenv = env;
@@ -1083,6 +1088,7 @@ void ppce500_init(MachineState *machine)
 
     /* Register spinning region */
     dev = qdev_new("e500-spin");
+    qdev_prop_set_array(dev, "cpus-qom-path", spin_cpu_list);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, pmc->spin_base);
 
diff --git a/hw/ppc/ppce500_spin.c b/hw/ppc/ppce500_spin.c
index e3608d8c16..a67046b2ea 100644
--- a/hw/ppc/ppce500_spin.c
+++ b/hw/ppc/ppce500_spin.c
@@ -30,11 +30,13 @@
 #include "qemu/osdep.h"
 #include "qemu/module.h"
 #include "qemu/units.h"
+#include "qapi/error.h"
 #include "hw/hw.h"
 #include "hw/sysbus.h"
 #include "sysemu/hw_accel.h"
 #include "e500.h"
 #include "qom/object.h"
+#include "hw/qdev-properties.h"
 
 #define MAX_CPUS 32
 
@@ -46,6 +48,10 @@ typedef struct spin_info {
     uint64_t reserved;
 } QEMU_PACKED SpinInfo;
 
+/*
+ * QEMU interface:
+ *  + QOM array property "cpus-qom-path": QOM canonical path of each CPU.
+ */
 #define TYPE_E500_SPIN "e500-spin"
 OBJECT_DECLARE_SIMPLE_TYPE(SpinState, E500_SPIN)
 
@@ -54,6 +60,9 @@ struct SpinState {
 
     MemoryRegion iomem;
     SpinInfo spin[MAX_CPUS];
+    uint32_t cpu_count;
+    char **cpu_canonical_path;
+    CPUState **cpu;
 };
 
 static void spin_reset(DeviceState *dev)
@@ -121,16 +130,10 @@ static void spin_write(void *opaque, hwaddr addr, uint64_t value,
 {
     SpinState *s = opaque;
     int env_idx = addr / sizeof(SpinInfo);
-    CPUState *cpu;
+    CPUState *cpu = s->cpu[env_idx];
     SpinInfo *curspin = &s->spin[env_idx];
     uint8_t *curspin_p = (uint8_t*)curspin;
 
-    cpu = qemu_get_cpu(env_idx);
-    if (cpu == NULL) {
-        /* Unknown CPU */
-        return;
-    }
-
     if (cpu->cpu_index == 0) {
         /* primary CPU doesn't spin */
         return;
@@ -188,11 +191,42 @@ static void ppce500_spin_initfn(Object *obj)
     sysbus_init_mmio(dev, &s->iomem);
 }
 
+static void ppce500_spin_realize(DeviceState *dev, Error **errp)
+{
+    SpinState *s = E500_SPIN(dev);
+
+    if (s->cpu_count == 0) {
+        error_setg(errp, "'cpus-qom-path' property array must be set");
+        return;
+    } else if (s->cpu_count > MAX_CPUS) {
+        error_setg(errp, "at most %d CPUs are supported", MAX_CPUS);
+        return;
+    }
+
+    s->cpu = g_new(CPUState *, s->cpu_count);
+    for (unsigned i = 0; i < s->cpu_count; i++) {
+        bool ambiguous;
+        Object *obj;
+
+        obj = object_resolve_path(s->cpu_canonical_path[i], &ambiguous);
+        assert(!ambiguous);
+        s->cpu[i] = CPU(obj);
+    }
+}
+
+static Property ppce500_spin_properties[] = {
+    DEFINE_PROP_ARRAY("cpus-qom-path", SpinState, cpu_count,
+                      cpu_canonical_path, qdev_prop_string, char *),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void ppce500_spin_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->reset = spin_reset;
+    dc->realize = ppce500_spin_realize;
+    device_class_set_props(dc, ppce500_spin_properties);
 }
 
 static const TypeInfo ppce500_spin_types[] = {
-- 
2.41.0


