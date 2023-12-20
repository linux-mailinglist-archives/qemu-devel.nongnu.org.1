Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7AD81A4FA
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Dec 2023 17:27:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFzP9-0000TQ-DR; Wed, 20 Dec 2023 11:26:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1rFzP3-0000PZ-F5
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 11:26:37 -0500
Received: from smtp1.lauterbach.com ([62.154.241.196])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1rFzOz-0004hS-Ap
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 11:26:36 -0500
Received: (qmail 15145 invoked by uid 484); 20 Dec 2023 16:26:07 -0000
X-Qmail-Scanner-Diagnostics: from nedpc1.intern.lauterbach.com by
 smtp1.lauterbach.com (envelope-from <nicolas.eder@lauterbach.com>,
 uid 484) with qmail-scanner-2.11 
 (mhr: 1.0. clamdscan: 0.99/21437. spamassassin: 3.4.0.  
 Clear:RC:1(10.2.11.92):. 
 Processed in 0.070998 secs); 20 Dec 2023 16:26:07 -0000
Received: from nedpc1.intern.lauterbach.com
 (Authenticated_SSL:neder@[10.2.11.92])
 (envelope-sender <nicolas.eder@lauterbach.com>)
 by smtp1.lauterbach.com (qmail-ldap-1.03) with TLS_AES_256_GCM_SHA384
 encrypted SMTP
 for <qemu-devel@nongnu.org>; 20 Dec 2023 16:26:06 -0000
From: Nicolas Eder <nicolas.eder@lauterbach.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Christian Boenig" <christian.boenig@lauterbach.com>,
 "Nicolas Eder" <nicolas.eder@lauterbach.com>
Subject: [PATCH v5 04/18] gdbstub: DebugClass added to system mode.
Date: Wed, 20 Dec 2023 17:25:41 +0100
Message-Id: <20231220162555.19545-5-nicolas.eder@lauterbach.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231220162555.19545-1-nicolas.eder@lauterbach.com>
References: <20231220162555.19545-1-nicolas.eder@lauterbach.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Qmail-Scanner-2.11: added fake Content-Type header
Content-Type: text/plain
Received-SPF: pass client-ip=62.154.241.196;
 envelope-from=nicolas.eder@lauterbach.com; helo=smtp1.lauterbach.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This class is used to abstract debug features between different debuggers
---
 debug/common/debug.c     | 33 +++++++++++++++++++++++++++++++++
 debug/common/meson.build |  1 +
 debug/gdbstub/system.c   | 18 ++++++++++++++++++
 debug/meson.build        |  1 +
 include/hw/boards.h      |  1 +
 include/qemu/debug.h     | 20 ++++++++++++++++++++
 include/qemu/typedefs.h  |  2 ++
 system/cpus.c            |  9 ++++++++-
 8 files changed, 84 insertions(+), 1 deletion(-)

diff --git a/debug/common/debug.c b/debug/common/debug.c
index c24aaf1202..476c969c98 100644
--- a/debug/common/debug.c
+++ b/debug/common/debug.c
@@ -16,3 +16,36 @@
  *
  * SPDX-License-Identifier: LGPL-2.0+
  */
+
+#include "qemu/osdep.h"
+#include "qemu/debug.h"
+#include "qom/object_interfaces.h"
+
+static void debug_instance_init(Object *obj)
+{
+}
+
+static void debug_finalize(Object *obj)
+{
+}
+
+static void debug_class_init(ObjectClass *oc, void *data)
+{
+}
+
+static const TypeInfo debug_info = {
+    .name = TYPE_DEBUG,
+    .parent = TYPE_OBJECT,
+    .instance_size = sizeof(DebugState),
+    .instance_init = debug_instance_init,
+    .instance_finalize = debug_finalize,
+    .class_size = sizeof(DebugClass),
+    .class_init = debug_class_init
+};
+
+static void debug_register_types(void)
+{
+    type_register_static(&debug_info);
+}
+
+type_init(debug_register_types);
diff --git a/debug/common/meson.build b/debug/common/meson.build
index e69de29bb2..815cb6f0fc 100644
--- a/debug/common/meson.build
+++ b/debug/common/meson.build
@@ -0,0 +1 @@
+system_ss.add(files('debug.c'))
diff --git a/debug/gdbstub/system.c b/debug/gdbstub/system.c
index 83fd452800..06bc580147 100644
--- a/debug/gdbstub/system.c
+++ b/debug/gdbstub/system.c
@@ -14,6 +14,7 @@
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/cutils.h"
+#include "qemu/debug.h"
 #include "exec/gdbstub.h"
 #include "gdbstub/syscalls.h"
 #include "exec/hwaddr.h"
@@ -46,6 +47,20 @@ static void reset_gdbserver_state(void)
     gdbserver_state.allow_stop_reply = false;
 }
 
+/**
+ * gdb_init_debug_class() - initialize gdb-specific DebugClass
+ */
+static void gdb_init_debug_class(void)
+{
+    Object *obj;
+    obj = object_new(TYPE_DEBUG);
+    DebugState *ds = DEBUG(obj);
+    DebugClass *dc = DEBUG_GET_CLASS(ds);
+    dc->set_stop_cpu = gdb_set_stop_cpu;
+    MachineState *ms = MACHINE(qdev_get_machine());
+    ms->debug_state = ds;
+}
+
 /*
  * Return the GDB index for a given vCPU state.
  *
@@ -405,6 +420,9 @@ int gdbserver_start(const char *device)
     gdbserver_system_state.mon_chr = mon_chr;
     gdb_syscall_reset();
 
+    /* create new debug object */
+    gdb_init_debug_class();
+
     return 0;
 }
 
diff --git a/debug/meson.build b/debug/meson.build
index a5b093f31e..f46ab14af9 100644
--- a/debug/meson.build
+++ b/debug/meson.build
@@ -1 +1,2 @@
+subdir('common')
 subdir('gdbstub')
diff --git a/include/hw/boards.h b/include/hw/boards.h
index da85f86efb..2e28913afc 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -400,6 +400,7 @@ struct MachineState {
     CpuTopology smp;
     struct NVDIMMState *nvdimms_state;
     struct NumaState *numa_state;
+    DebugState *debug_state;
 };
 
 #define DEFINE_MACHINE(namestr, machine_initfn) \
diff --git a/include/qemu/debug.h b/include/qemu/debug.h
index c24aaf1202..9526f9fb48 100644
--- a/include/qemu/debug.h
+++ b/include/qemu/debug.h
@@ -16,3 +16,23 @@
  *
  * SPDX-License-Identifier: LGPL-2.0+
  */
+
+#ifndef QEMU_DEBUG_H
+#define QEMU_DEBUG_H
+
+#include "qom/object.h"
+#include "qemu/typedefs.h"
+
+struct DebugClass {
+    ObjectClass parent_class;
+    void (*set_stop_cpu)(CPUState *cpu);
+};
+
+struct DebugState {
+    Object parent_obj;
+};
+
+#define TYPE_DEBUG "debug"
+OBJECT_DECLARE_TYPE(DebugState, DebugClass, DEBUG)
+
+#endif /* QEMU_DEBUG_H */
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 5abdbc3874..e48b544173 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -46,6 +46,8 @@ typedef struct CpuInfoFast CpuInfoFast;
 typedef struct CPUJumpCache CPUJumpCache;
 typedef struct CPUState CPUState;
 typedef struct CPUTLBEntryFull CPUTLBEntryFull;
+typedef struct DebugClass DebugClass;
+typedef struct DebugState DebugState;
 typedef struct DeviceListener DeviceListener;
 typedef struct DeviceState DeviceState;
 typedef struct DirtyBitmapSnapshot DirtyBitmapSnapshot;
diff --git a/system/cpus.c b/system/cpus.c
index a444a747f0..7a7fff14bc 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -25,6 +25,7 @@
 #include "qemu/osdep.h"
 #include "monitor/monitor.h"
 #include "qemu/coroutine-tls.h"
+#include "qemu/debug.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-machine.h"
 #include "qapi/qapi-commands-misc.h"
@@ -313,7 +314,13 @@ void cpu_handle_guest_debug(CPUState *cpu)
             cpu_single_step(cpu, 0);
         }
     } else {
-        gdb_set_stop_cpu(cpu);
+        MachineState *ms = MACHINE(qdev_get_machine());
+        DebugState *ds = ms->debug_state;
+        DebugClass *dc = DEBUG_GET_CLASS(ds);
+
+        if (dc->set_stop_cpu) {
+            dc->set_stop_cpu(cpu);
+        }
         qemu_system_debug_request();
         cpu->stopped = true;
     }
-- 
2.34.1


