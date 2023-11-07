Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE6D7E3F89
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 14:05:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0LlG-0000Dm-QU; Tue, 07 Nov 2023 08:04:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1r0LkM-00088l-3c
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 08:03:59 -0500
Received: from smtp1.lauterbach.com ([62.154.241.196])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolas.eder@lauterbach.com>)
 id 1r0LkI-0005lm-Ng
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 08:03:56 -0500
Received: (qmail 30837 invoked by uid 484); 7 Nov 2023 13:03:35 -0000
X-Qmail-Scanner-Diagnostics: from nedpc1.intern.lauterbach.com by
 smtp1.lauterbach.com (envelope-from <nicolas.eder@lauterbach.com>,
 uid 484) with qmail-scanner-2.11 
 (mhr: 1.0. clamdscan: 0.99/21437. spamassassin: 3.4.0.  
 Clear:RC:1(10.2.11.92):. 
 Processed in 6e-06 secs); 07 Nov 2023 13:03:35 -0000
Received: from nedpc1.intern.lauterbach.com
 (Authenticated_SSL:neder@[10.2.11.92])
 (envelope-sender <nicolas.eder@lauterbach.com>)
 by smtp1.lauterbach.com (qmail-ldap-1.03) with TLS_AES_256_GCM_SHA384
 encrypted SMTP for <qemu-devel@nongnu.org>; 7 Nov 2023 13:03:32 -0000
From: Nicolas Eder <nicolas.eder@lauterbach.com>
To: qemu-devel@nongnu.org
Cc: "Nicolas Eder" <nicolas.eder@lauterbach.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Christian Boenig" <christian.boenig@lauterbach.com>
Subject: [PATCH v3 02/20] mcdstub gdbstub: new DebugClass and DebugState
 introduced. They are used to abstract the debugger details behind a QOM. This
 is currently used in the cpu_handle_guest_debug function
Date: Tue,  7 Nov 2023 14:03:05 +0100
Message-Id: <20231107130323.4126-3-nicolas.eder@lauterbach.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107130323.4126-1-nicolas.eder@lauterbach.com>
References: <20231107130323.4126-1-nicolas.eder@lauterbach.com>
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

---
 debug/debug-common.c    | 42 +++++++++++++++++++++++++++++++++++++++++
 debug/debug-gdb.c       | 24 +++++++++++++++++++++++
 debug/debug-mcd.c       | 25 ++++++++++++++++++++++++
 gdbstub/meson.build     |  4 ++--
 gdbstub/system.c        |  4 ++++
 gdbstub/user.c          |  2 ++
 include/exec/gdbstub.h  |  5 +++++
 include/hw/boards.h     |  1 +
 include/qemu/debug.h    | 19 +++++++++++++++++++
 include/qemu/typedefs.h |  2 ++
 system/cpus.c           |  9 ++++++++-
 11 files changed, 134 insertions(+), 3 deletions(-)
 create mode 100644 debug/debug-common.c
 create mode 100644 debug/debug-gdb.c
 create mode 100644 debug/debug-mcd.c
 create mode 100644 include/qemu/debug.h

diff --git a/debug/debug-common.c b/debug/debug-common.c
new file mode 100644
index 0000000000..8f41b4e6cb
--- /dev/null
+++ b/debug/debug-common.c
@@ -0,0 +1,42 @@
+#include "qemu/osdep.h"
+#include "qemu/ctype.h"
+#include "qemu/cutils.h"
+#include "qemu/module.h"
+#include "qemu/error-report.h"
+#include "hw/cpu/cluster.h"
+#include "hw/boards.h"
+#include "sysemu/hw_accel.h"
+#include "sysemu/runstate.h"
+#include "exec/replay-core.h"
+#include "exec/hwaddr.h"
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
diff --git a/debug/debug-gdb.c b/debug/debug-gdb.c
new file mode 100644
index 0000000000..9c7bcda95f
--- /dev/null
+++ b/debug/debug-gdb.c
@@ -0,0 +1,24 @@
+#include "qemu/osdep.h"
+#include "qemu/ctype.h"
+#include "qemu/cutils.h"
+#include "qemu/module.h"
+#include "qemu/error-report.h"
+#include "hw/cpu/cluster.h"
+#include "hw/boards.h"
+#include "sysemu/hw_accel.h"
+#include "sysemu/runstate.h"
+#include "exec/replay-core.h"
+#include "exec/hwaddr.h"
+#include "exec/gdbstub.h"
+#include "qemu/debug.h"
+
+void gdb_init_debug_class(void)
+{
+    Object *obj;
+    obj = object_new(TYPE_DEBUG);
+    DebugState *ds = DEBUG(obj);
+    DebugClass *dc = DEBUG_GET_CLASS(ds);
+    dc->set_stop_cpu = gdb_set_stop_cpu;
+    MachineState *ms = MACHINE(qdev_get_machine());
+    ms->debug_state = ds;
+}
diff --git a/debug/debug-mcd.c b/debug/debug-mcd.c
new file mode 100644
index 0000000000..2d3a31be15
--- /dev/null
+++ b/debug/debug-mcd.c
@@ -0,0 +1,25 @@
+#include "qemu/osdep.h"
+#include "qemu/ctype.h"
+#include "qemu/cutils.h"
+#include "qemu/module.h"
+#include "qemu/error-report.h"
+#include "hw/cpu/cluster.h"
+#include "hw/boards.h"
+#include "sysemu/hw_accel.h"
+#include "sysemu/runstate.h"
+#include "exec/replay-core.h"
+#include "exec/hwaddr.h"
+#include "mcdstub/mcdstub.h"
+#include "qemu/debug.h"
+#include "qom/object_interfaces.h"
+
+void mcd_init_debug_class(void)
+{
+    Object *obj;
+    obj = object_new(TYPE_DEBUG);
+    DebugState *ds = DEBUG(obj);
+    DebugClass *dc = DEBUG_GET_CLASS(ds);
+    dc->set_stop_cpu = mcd_set_stop_cpu;
+    MachineState *ms = MACHINE(qdev_get_machine());
+    ms->debug_state = ds;
+}
diff --git a/gdbstub/meson.build b/gdbstub/meson.build
index e5bccba34e..359234595a 100644
--- a/gdbstub/meson.build
+++ b/gdbstub/meson.build
@@ -11,8 +11,8 @@ gdb_user_ss = ss.source_set()
 gdb_system_ss = ss.source_set()
 
 # We build two versions of gdbstub, one for each mode
-gdb_user_ss.add(files('gdbstub.c', 'user.c'))
-gdb_system_ss.add(files('gdbstub.c', 'system.c'))
+gdb_user_ss.add(files('gdbstub.c', 'user.c', '../debug/debug-gdb.c'))
+gdb_system_ss.add(files('gdbstub.c', 'system.c', '../debug/debug-gdb.c'))
 
 gdb_user_ss = gdb_user_ss.apply(config_targetos, strict: false)
 gdb_system_ss = gdb_system_ss.apply(config_targetos, strict: false)
diff --git a/gdbstub/system.c b/gdbstub/system.c
index 783ac140b9..02ec4875f5 100644
--- a/gdbstub/system.c
+++ b/gdbstub/system.c
@@ -14,6 +14,7 @@
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/cutils.h"
+#include "qemu/debug.h"
 #include "exec/gdbstub.h"
 #include "gdbstub/syscalls.h"
 #include "exec/hwaddr.h"
@@ -405,6 +406,9 @@ int gdbserver_start(const char *device)
     gdbserver_system_state.mon_chr = mon_chr;
     gdb_syscall_reset();
 
+    /* create new debug object */
+    gdb_init_debug_class();
+
     return 0;
 }
 
diff --git a/gdbstub/user.c b/gdbstub/user.c
index dbe1d9b887..f8207aa9ef 100644
--- a/gdbstub/user.c
+++ b/gdbstub/user.c
@@ -332,8 +332,10 @@ int gdbserver_start(const char *port_or_path)
     }
 
     if (port > 0 && gdb_accept_tcp(gdb_fd)) {
+        gdb_init_debug_class();
         return 0;
     } else if (gdb_accept_socket(gdb_fd)) {
+        gdb_init_debug_class();
         gdbserver_user_state.socket_path = g_strdup(port_or_path);
         return 0;
     }
diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
index 1a01c35f8e..f696e29477 100644
--- a/include/exec/gdbstub.h
+++ b/include/exec/gdbstub.h
@@ -48,4 +48,9 @@ void gdb_set_stop_cpu(CPUState *cpu);
 /* in gdbstub-xml.c, generated by scripts/feature_to_c.py */
 extern const GDBFeature gdb_static_features[];
 
+/**
+ * gdb_init_debug_class() - initialize gdb-specific DebugClass
+ */
+void gdb_init_debug_class(void);
+
 #endif
diff --git a/include/hw/boards.h b/include/hw/boards.h
index a735999298..ffc7756b89 100644
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
new file mode 100644
index 0000000000..870f3ea152
--- /dev/null
+++ b/include/qemu/debug.h
@@ -0,0 +1,19 @@
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
index 0848e0dbdb..734173096a 100644
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
@@ -306,7 +307,13 @@ void cpu_handle_guest_debug(CPUState *cpu)
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


