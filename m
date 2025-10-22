Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1C8BFA596
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Oct 2025 08:54:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBSjN-00062d-Is; Wed, 22 Oct 2025 02:53:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <functioner@sjtu.edu.cn>)
 id 1vBSjI-0005sf-Es
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 02:53:52 -0400
Received: from smtp233.sjtu.edu.cn ([202.120.2.233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <functioner@sjtu.edu.cn>)
 id 1vBSjF-0007RF-QH
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 02:53:52 -0400
Received: from mta91.sjtu.edu.cn (unknown [10.118.0.91])
 by smtp233.sjtu.edu.cn (Postfix) with ESMTPS id 58F02101B694A;
 Wed, 22 Oct 2025 14:53:42 +0800 (CST)
Received: from mstore136.sjtu.edu.cn (unknown [10.118.0.136])
 by mta91.sjtu.edu.cn (Postfix) with ESMTP id 1DBBF37C8FB;
 Wed, 22 Oct 2025 14:53:42 +0800 (CST)
Date: Wed, 22 Oct 2025 14:53:41 +0800 (CST)
From: Ziyang Zhang <functioner@sjtu.edu.cn>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, 
 alex bennee <alex.bennee@linaro.org>, 
 Alexandre Iooss <erdnaxe@crans.org>, 
 Mahmoud Mandour <ma.mandourr@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 richard henderson <richard.henderson@linaro.org>, 
 Zhengwei Qi <qizhwei@sjtu.edu.cn>, Yun Wang <yunwang94@sjtu.edu.cn>, 
 Mingyuan Xia <xiamy@ultrarisc.com>, Kailiang Xu <xukl2019@sjtu.edu.cn>
Message-ID: <1236223604.5812631.1761116021855.JavaMail.zimbra@sjtu.edu.cn>
In-Reply-To: <1341969682.5812455.1761115945695.JavaMail.zimbra@sjtu.edu.cn>
References: <1341969682.5812455.1761115945695.JavaMail.zimbra@sjtu.edu.cn>
Subject: [RFC PATCH V2 1/2] linux-user: add a plugin API to filter syscalls
MIME-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
X-Originating-IP: [119.237.255.163]
X-Mailer: Zimbra 10.0.14_GA_4767 (ZimbraWebClient - GC141
 (Win)/10.0.15_GA_4781)
Thread-Topic: linux-user: add a plugin API to filter syscalls
Thread-Index: O8UVQ/TJHmck9snQ4N2r1rVTqb8mpN2MhtjX
Received-SPF: pass client-ip=202.120.2.233;
 envelope-from=functioner@sjtu.edu.cn; helo=smtp233.sjtu.edu.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

This commit adds a syscall filter API to the TCG plugin API set.
Plugins can register a filter callback to QEMU to decide whether
to intercept a syscall, process it and bypass the QEMU syscall
handler.

Signed-off-by: Ziyang Zhang <functioner@sjtu.edu.cn>
---
 include/qemu/plugin-event.h  |  1 +
 include/qemu/plugin.h        | 28 ++++++++++++++++++++--------
 include/qemu/qemu-plugin.h   | 24 ++++++++++++++++++++++++
 include/user/syscall-trace.h | 16 ++++++++++++++++
 linux-user/syscall.c         |  7 +++++--
 plugins/api.c                |  7 +++++++
 plugins/core.c               | 34 ++++++++++++++++++++++++++++++++++
 7 files changed, 107 insertions(+), 10 deletions(-)

diff --git a/include/qemu/plugin-event.h b/include/qemu/plugin-event.h
index 7056d8427b..bbb1c2b91f 100644
--- a/include/qemu/plugin-event.h
+++ b/include/qemu/plugin-event.h
@@ -20,6 +20,7 @@ enum qemu_plugin_event {
     QEMU_PLUGIN_EV_VCPU_SYSCALL_RET,
     QEMU_PLUGIN_EV_FLUSH,
     QEMU_PLUGIN_EV_ATEXIT,
+    QEMU_PLUGIN_EV_VCPU_SYSCALL_FILTER,
     QEMU_PLUGIN_EV_MAX, /* total number of plugin events we support */
 };
 
diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
index f355c7cb8a..adba2ac49c 100644
--- a/include/qemu/plugin.h
+++ b/include/qemu/plugin.h
@@ -55,14 +55,15 @@ void qemu_plugin_opt_parse(const char *optstr, QemuPluginList *head);
 int qemu_plugin_load_list(QemuPluginList *head, Error **errp);
 
 union qemu_plugin_cb_sig {
-    qemu_plugin_simple_cb_t          simple;
-    qemu_plugin_udata_cb_t           udata;
-    qemu_plugin_vcpu_simple_cb_t     vcpu_simple;
-    qemu_plugin_vcpu_udata_cb_t      vcpu_udata;
-    qemu_plugin_vcpu_tb_trans_cb_t   vcpu_tb_trans;
-    qemu_plugin_vcpu_mem_cb_t        vcpu_mem;
-    qemu_plugin_vcpu_syscall_cb_t    vcpu_syscall;
-    qemu_plugin_vcpu_syscall_ret_cb_t vcpu_syscall_ret;
+    qemu_plugin_simple_cb_t              simple;
+    qemu_plugin_udata_cb_t               udata;
+    qemu_plugin_vcpu_simple_cb_t         vcpu_simple;
+    qemu_plugin_vcpu_udata_cb_t          vcpu_udata;
+    qemu_plugin_vcpu_tb_trans_cb_t       vcpu_tb_trans;
+    qemu_plugin_vcpu_mem_cb_t            vcpu_mem;
+    qemu_plugin_vcpu_syscall_cb_t        vcpu_syscall;
+    qemu_plugin_vcpu_syscall_ret_cb_t    vcpu_syscall_ret;
+    qemu_plugin_vcpu_syscall_filter_cb_t vcpu_syscall_filter;
     void *generic;
 };
 
@@ -165,6 +166,10 @@ qemu_plugin_vcpu_syscall(CPUState *cpu, int64_t num, uint64_t a1,
                          uint64_t a2, uint64_t a3, uint64_t a4, uint64_t a5,
                          uint64_t a6, uint64_t a7, uint64_t a8);
 void qemu_plugin_vcpu_syscall_ret(CPUState *cpu, int64_t num, int64_t ret);
+bool
+qemu_plugin_vcpu_syscall_filter(CPUState *cpu, int64_t num, uint64_t a1,
+                         uint64_t a2, uint64_t a3, uint64_t a4, uint64_t a5,
+                         uint64_t a6, uint64_t a7, uint64_t a8, uint64_t *ret);
 
 void qemu_plugin_vcpu_mem_cb(CPUState *cpu, uint64_t vaddr,
                              uint64_t value_low,
@@ -267,6 +272,13 @@ static inline
 void qemu_plugin_vcpu_syscall_ret(CPUState *cpu, int64_t num, int64_t ret)
 { }
 
+static inline bool
+qemu_plugin_vcpu_syscall_filter(CPUState *cpu, int64_t num, uint64_t a1,
+                                uint64_t a2, uint64_t a3, uint64_t a4,
+                                uint64_t a5, uint64_t a6, uint64_t a7,
+                                uint64_t a8, uint64_t *ret)
+{ }
+
 static inline void qemu_plugin_vcpu_mem_cb(CPUState *cpu, uint64_t vaddr,
                                            uint64_t value_low,
                                            uint64_t value_high,
diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index c450106af1..719b070e32 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -738,6 +738,25 @@ typedef void
                                  uint64_t a3, uint64_t a4, uint64_t a5,
                                  uint64_t a6, uint64_t a7, uint64_t a8);
 
+/*
+ * typedef qemu_plugin_vcpu_syscall_filter_cb_t - vCPU syscall filter callback
+ * function type
+ * @vcpu_index: the executing vCPU
+ * @num: the syscall number
+ * @a1-a8: the syscall arguments
+ * @ret: the address of the syscall return value, set this if filtered
+ *
+ * Returns: true if you want to filter this syscall (i.e. stop it being handled
+ * further), otherwise return false.
+ */
+typedef bool
+(*qemu_plugin_vcpu_syscall_filter_cb_t)(qemu_plugin_id_t id,
+                                unsigned int vcpu_index,
+                                int64_t num, uint64_t a1, uint64_t a2,
+                                uint64_t a3, uint64_t a4, uint64_t a5,
+                                uint64_t a6, uint64_t a7, uint64_t a8,
+                                uint64_t *ret);
+
 QEMU_PLUGIN_API
 void qemu_plugin_register_vcpu_syscall_cb(qemu_plugin_id_t id,
                                           qemu_plugin_vcpu_syscall_cb_t cb);
@@ -751,6 +770,11 @@ void
 qemu_plugin_register_vcpu_syscall_ret_cb(qemu_plugin_id_t id,
                                          qemu_plugin_vcpu_syscall_ret_cb_t cb);
 
+QEMU_PLUGIN_API
+void
+qemu_plugin_register_vcpu_syscall_filter_cb(qemu_plugin_id_t id,
+                                    qemu_plugin_vcpu_syscall_filter_cb_t cb);
+
 
 /**
  * qemu_plugin_insn_disas() - return disassembly string for instruction
diff --git a/include/user/syscall-trace.h b/include/user/syscall-trace.h
index 9bd7ca19c8..34f7d6c7d4 100644
--- a/include/user/syscall-trace.h
+++ b/include/user/syscall-trace.h
@@ -39,5 +39,21 @@ static inline void record_syscall_return(CPUState *cpu, int num, abi_long ret)
     gdb_syscall_return(cpu, num);
 }
 
+static inline bool send_through_syscall_filters(CPUState *cpu, int num,
+                                  abi_long arg1, abi_long arg2,
+                                  abi_long arg3, abi_long arg4,
+                                  abi_long arg5, abi_long arg6,
+                                  abi_long arg7, abi_long arg8, abi_long *ret)
+{
+    uint64_t sysret64 = 0;
+    bool filtered = qemu_plugin_vcpu_syscall_filter(cpu, num,
+                             arg1, arg2, arg3, arg4,
+                             arg5, arg6, arg7, arg8, &sysret64);
+    if (filtered) {
+        *ret = sysret64;
+    }
+    return filtered;
+}
+
 
 #endif /* SYSCALL_TRACE_H */
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index d78b2029fa..b8225f838f 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -14084,8 +14084,11 @@ abi_long do_syscall(CPUArchState *cpu_env, int num, abi_long arg1,
         print_syscall(cpu_env, num, arg1, arg2, arg3, arg4, arg5, arg6);
     }
 
-    ret = do_syscall1(cpu_env, num, arg1, arg2, arg3, arg4,
-                      arg5, arg6, arg7, arg8);
+    if (!send_through_syscall_filters(cpu, num, arg1, arg2, arg3, arg4, arg5,
+        arg6, arg7, arg8, &ret)) {
+        ret = do_syscall1(cpu_env, num, arg1, arg2, arg3, arg4,
+                        arg5, arg6, arg7, arg8);
+    }
 
     if (unlikely(qemu_loglevel_mask(LOG_STRACE))) {
         print_syscall_ret(cpu_env, num, ret, arg1, arg2,
diff --git a/plugins/api.c b/plugins/api.c
index eac04cc1f6..478d0c8889 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -208,6 +208,13 @@ qemu_plugin_register_vcpu_syscall_ret_cb(qemu_plugin_id_t id,
     plugin_register_cb(id, QEMU_PLUGIN_EV_VCPU_SYSCALL_RET, cb);
 }
 
+void
+qemu_plugin_register_vcpu_syscall_filter_cb(qemu_plugin_id_t id,
+                                            qemu_plugin_vcpu_syscall_filter_cb_t cb)
+{
+    plugin_register_cb(id, QEMU_PLUGIN_EV_VCPU_SYSCALL_FILTER, cb);
+}
+
 /*
  * Plugin Queries
  *
diff --git a/plugins/core.c b/plugins/core.c
index ead09fd2f1..1b2f875fb1 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -538,6 +538,40 @@ void qemu_plugin_vcpu_syscall_ret(CPUState *cpu, int64_t num, int64_t ret)
     }
 }
 
+/*
+ * Disable CFI checks.
+ * The callback function has been loaded from an external library so we do not
+ * have type information
+ */
+QEMU_DISABLE_CFI
+bool
+qemu_plugin_vcpu_syscall_filter(CPUState *cpu, int64_t num, uint64_t a1,
+                         uint64_t a2, uint64_t a3, uint64_t a4, uint64_t a5,
+                         uint64_t a6, uint64_t a7, uint64_t a8, uint64_t *ret)
+{
+    struct qemu_plugin_cb *cb, *next;
+    enum qemu_plugin_event ev = QEMU_PLUGIN_EV_VCPU_SYSCALL_FILTER;
+
+    if (!test_bit(ev, cpu->plugin_state->event_mask)) {
+        return false;
+    }
+
+    bool filtered = false;
+    QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
+        qemu_plugin_vcpu_syscall_filter_cb_t func = cb->f.vcpu_syscall_filter;
+
+        qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS);
+        if (func(cb->ctx->id, cpu->cpu_index, num, a1, a2, a3, a4,
+            a5, a6, a7, a8, ret)) {
+            filtered = true;
+            qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_NO_REGS);
+            break;
+        }
+        qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_NO_REGS);
+    }
+    return filtered;
+}
+
 void qemu_plugin_vcpu_idle_cb(CPUState *cpu)
 {
     /* idle and resume cb may be called before init, ignore in this case */

-- 
2.25.1


