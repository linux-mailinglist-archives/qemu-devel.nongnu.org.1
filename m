Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EC547B1DA2D
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Aug 2025 16:43:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uk1nj-0007fO-NH; Thu, 07 Aug 2025 10:41:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1uk1nf-0007WJ-Ov
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 10:41:00 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1uk1nd-0000xd-MO
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 10:40:59 -0400
Received: from localhost.localdomain (unknown [167.220.208.72])
 by linux.microsoft.com (Postfix) with ESMTPSA id 822DC201BC72;
 Thu,  7 Aug 2025 07:40:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 822DC201BC72
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1754577655;
 bh=sxcdffU9Fs8P+PvT1bCv7XNkZsAB+E65hqgnj7AV1dw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=fqVKFGhCn03JsZCYZPJaZzYnQssD2zbKXh7AMuxbXtxA74swaQnQK+J2pruGXPKA6
 2WJjfhETFvSSVchmRB1xjhfGTlAXQUp+HviWqWZuzdhtCvjdk4ljspE15JPneMCRmZ
 /VRuItxwa7dKb0AhK/p5LFh7VeH2dKojv7Ez+v+g=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Magnus Kulke <magnus.kulke@linux.microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Magnus Kulke <magnus.kulke@microsoft.com>,
 Cornelia Huck <cohuck@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Thomas Huth <thuth@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Cameron Esfahani <dirty@apple.com>, Wei Liu <wei.liu@kernel.org>,
 Wei Liu <liuwe@microsoft.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 07/26] accel/mshv: Add accelerator skeleton
Date: Thu,  7 Aug 2025 16:39:32 +0200
Message-Id: <20250807143951.1154713-8-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250807143951.1154713-1-magnuskulke@linux.microsoft.com>
References: <20250807143951.1154713-1-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

Introduce the initial scaffold for the MSHV (Microsoft Hypervisor)
accelerator backend. This includes the basic directory structure and
stub implementations needed to integrate with QEMU's accelerator
framework.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 accel/meson.build      |   1 +
 accel/mshv/meson.build |   6 ++
 accel/mshv/mshv-all.c  | 143 +++++++++++++++++++++++++++++++++++++++++
 include/system/mshv.h  |  35 ++++++++++
 4 files changed, 185 insertions(+)
 create mode 100644 accel/mshv/meson.build
 create mode 100644 accel/mshv/mshv-all.c

diff --git a/accel/meson.build b/accel/meson.build
index 6349efe682..983dfd0bd5 100644
--- a/accel/meson.build
+++ b/accel/meson.build
@@ -10,6 +10,7 @@ if have_system
   subdir('kvm')
   subdir('xen')
   subdir('stubs')
+  subdir('mshv')
 endif
 
 # qtest
diff --git a/accel/mshv/meson.build b/accel/mshv/meson.build
new file mode 100644
index 0000000000..4c03ac7921
--- /dev/null
+++ b/accel/mshv/meson.build
@@ -0,0 +1,6 @@
+mshv_ss = ss.source_set()
+mshv_ss.add(if_true: files(
+  'mshv-all.c'
+))
+
+specific_ss.add_all(when: 'CONFIG_MSHV', if_true: mshv_ss)
diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
new file mode 100644
index 0000000000..f548b1187b
--- /dev/null
+++ b/accel/mshv/mshv-all.c
@@ -0,0 +1,143 @@
+/*
+ * QEMU MSHV support
+ *
+ * Copyright Microsoft, Corp. 2025
+ *
+ * Authors:
+ *  Ziqiao Zhou       <ziqiaozhou@microsoft.com>
+ *  Magnus Kulke      <magnuskulke@microsoft.com>
+ *  Jinank Jain       <jinankjain@microsoft.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu/error-report.h"
+#include "qemu/event_notifier.h"
+#include "qemu/module.h"
+#include "qemu/main-loop.h"
+#include "hw/boards.h"
+
+#include "hw/hyperv/hvhdk.h"
+#include "hw/hyperv/hvhdk_mini.h"
+#include "hw/hyperv/hvgdk.h"
+#include "linux/mshv.h"
+
+#include "qemu/accel.h"
+#include "qemu/guest-random.h"
+#include "accel/accel-ops.h"
+#include "accel/accel-cpu-ops.h"
+#include "system/cpus.h"
+#include "system/runstate.h"
+#include "system/accel-blocker.h"
+#include "system/address-spaces.h"
+#include "system/mshv.h"
+#include "system/reset.h"
+#include "trace.h"
+#include <err.h>
+#include <stdint.h>
+#include <sys/ioctl.h>
+
+#define TYPE_MSHV_ACCEL ACCEL_CLASS_NAME("mshv")
+
+DECLARE_INSTANCE_CHECKER(MshvState, MSHV_STATE, TYPE_MSHV_ACCEL)
+
+bool mshv_allowed;
+
+MshvState *mshv_state;
+
+static int mshv_init(AccelState *as, MachineState *ms)
+{
+    error_report("unimplemented");
+    abort();
+}
+
+static void mshv_start_vcpu_thread(CPUState *cpu)
+{
+    error_report("unimplemented");
+    abort();
+}
+
+static void mshv_cpu_synchronize_post_init(CPUState *cpu)
+{
+    error_report("unimplemented");
+    abort();
+}
+
+static void mshv_cpu_synchronize_post_reset(CPUState *cpu)
+{
+    error_report("unimplemented");
+    abort();
+}
+
+static void mshv_cpu_synchronize_pre_loadvm(CPUState *cpu)
+{
+    error_report("unimplemented");
+    abort();
+}
+
+static void mshv_cpu_synchronize(CPUState *cpu)
+{
+    error_report("unimplemented");
+    abort();
+}
+
+static bool mshv_cpus_are_resettable(void)
+{
+    error_report("unimplemented");
+    abort();
+}
+
+static void mshv_accel_class_init(ObjectClass *oc, const void *data)
+{
+    AccelClass *ac = ACCEL_CLASS(oc);
+
+    ac->name = "MSHV";
+    ac->init_machine = mshv_init;
+    ac->allowed = &mshv_allowed;
+}
+
+static void mshv_accel_instance_init(Object *obj)
+{
+    MshvState *s = MSHV_STATE(obj);
+
+    s->vm = 0;
+}
+
+static const TypeInfo mshv_accel_type = {
+    .name = TYPE_MSHV_ACCEL,
+    .parent = TYPE_ACCEL,
+    .instance_init = mshv_accel_instance_init,
+    .class_init = mshv_accel_class_init,
+    .instance_size = sizeof(MshvState),
+};
+
+static void mshv_accel_ops_class_init(ObjectClass *oc, const void *data)
+{
+    AccelOpsClass *ops = ACCEL_OPS_CLASS(oc);
+
+    ops->create_vcpu_thread = mshv_start_vcpu_thread;
+    ops->synchronize_post_init = mshv_cpu_synchronize_post_init;
+    ops->synchronize_post_reset = mshv_cpu_synchronize_post_reset;
+    ops->synchronize_state = mshv_cpu_synchronize;
+    ops->synchronize_pre_loadvm = mshv_cpu_synchronize_pre_loadvm;
+    ops->cpus_are_resettable = mshv_cpus_are_resettable;
+    ops->handle_interrupt = generic_handle_interrupt;
+}
+
+static const TypeInfo mshv_accel_ops_type = {
+    .name = ACCEL_OPS_NAME("mshv"),
+    .parent = TYPE_ACCEL_OPS,
+    .class_init = mshv_accel_ops_class_init,
+    .abstract = true,
+};
+
+static void mshv_type_init(void)
+{
+    type_register_static(&mshv_accel_type);
+    type_register_static(&mshv_accel_ops_type);
+}
+
+type_init(mshv_type_init);
diff --git a/include/system/mshv.h b/include/system/mshv.h
index a358691428..45808c5c50 100644
--- a/include/system/mshv.h
+++ b/include/system/mshv.h
@@ -14,6 +14,15 @@
 #ifndef QEMU_MSHV_INT_H
 #define QEMU_MSHV_INT_H
 
+#include "qemu/osdep.h"
+#include "qemu/accel.h"
+#include "hw/hyperv/hyperv-proto.h"
+#include "linux/mshv.h"
+#include "hw/hyperv/hvhdk.h"
+#include "qapi/qapi-types-common.h"
+#include "system/memory.h"
+#include "accel/accel-ops.h"
+
 #ifdef COMPILING_PER_TARGET
 #ifdef CONFIG_MSHV
 #define CONFIG_MSHV_IS_POSSIBLE
@@ -25,6 +34,32 @@
 #ifdef CONFIG_MSHV_IS_POSSIBLE
 extern bool mshv_allowed;
 #define mshv_enabled() (mshv_allowed)
+
+typedef struct MshvMemoryListener {
+    MemoryListener listener;
+    int as_id;
+} MshvMemoryListener;
+
+typedef struct MshvAddressSpace {
+    MshvMemoryListener *ml;
+    AddressSpace *as;
+} MshvAddressSpace;
+
+typedef struct MshvState {
+    AccelState parent_obj;
+    int vm;
+    MshvMemoryListener memory_listener;
+    /* number of listeners */
+    int nr_as;
+    MshvAddressSpace *as;
+} MshvState;
+extern MshvState *mshv_state;
+
+struct AccelCPUState {
+    int cpufd;
+    bool dirty;
+};
+
 #else /* CONFIG_MSHV_IS_POSSIBLE */
 #define mshv_enabled() false
 #endif
-- 
2.34.1


