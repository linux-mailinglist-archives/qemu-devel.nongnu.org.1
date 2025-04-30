Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A4FAA4259
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Apr 2025 07:30:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uA00J-0002jZ-KU; Wed, 30 Apr 2025 01:29:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mario.fleischmann@lauterbach.com>)
 id 1u9zzt-0002Kq-VK
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 01:28:42 -0400
Received: from smtp1.lauterbach.com ([62.154.241.196])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mario.fleischmann@lauterbach.com>)
 id 1u9zzp-0006kg-4K
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 01:28:40 -0400
Received: (qmail 1927 invoked by uid 484); 30 Apr 2025 05:28:06 -0000
X-Qmail-Scanner-Diagnostics: from 10.2.13.100 by smtp1.lauterbach.com
 (envelope-from <mario.fleischmann@lauterbach.com>,
 uid 484) with qmail-scanner-2.11 
 (mhr: 1.0. clamdscan: 0.99/21437. spamassassin: 3.4.0.  
 Clear:RC:1(10.2.13.100):. 
 Processed in 0.014182 secs); 30 Apr 2025 05:28:06 -0000
Received: from unknown (HELO mflpc1.LTB.LAN)
 (Authenticated_SSL:mfleischmann@[10.2.13.100])
 (envelope-sender <mario.fleischmann@lauterbach.com>)
 by smtp1.lauterbach.com (qmail-ldap-1.03) with TLS_AES_256_GCM_SHA384
 encrypted SMTP
 for <qemu-devel@nongnu.org>; 30 Apr 2025 05:28:06 -0000
From: Mario Fleischmann <mario.fleischmann@lauterbach.com>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, philmd@linaro.org, armbru@redhat.com,
 christian.boenig@lauterbach.com,
 Mario Fleischmann <mario.fleischmann@lauterbach.com>
Subject: [PATCH v2 14/20] mcd: Implement runstate control
Date: Wed, 30 Apr 2025 07:27:35 +0200
Message-Id: <20250430052741.21145-15-mario.fleischmann@lauterbach.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250430052741.21145-1-mario.fleischmann@lauterbach.com>
References: <20250430052741.21145-1-mario.fleischmann@lauterbach.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Qmail-Scanner-2.11: added fake Content-Type header
Content-Type: text/plain
Received-SPF: pass client-ip=62.154.241.196;
 envelope-from=mario.fleischmann@lauterbach.com; helo=smtp1.lauterbach.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Currently, only global stop is implemented

Signed-off-by: Mario Fleischmann <mario.fleischmann@lauterbach.com>
---
 mcd/mcd_server.c |  74 +++++++++++++++++++++++++++++++++--
 mcd/mcd_stub.c   |  52 ++++++++++++++++++++++++
 qapi/mcd.json    | 100 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 222 insertions(+), 4 deletions(-)

diff --git a/mcd/mcd_server.c b/mcd/mcd_server.c
index fd62811..041b97e 100644
--- a/mcd/mcd_server.c
+++ b/mcd/mcd_server.c
@@ -14,6 +14,8 @@
 #include "hw/boards.h"
 #include "exec/tswap.h"
 #include "exec/gdbstub.h"
+#include "hw/core/cpu.h"
+#include "system/runstate.h"
 
 /* Custom memory space type */
 static const mcd_mem_type_et MCD_MEM_SPACE_IS_SECURE = 0x00010000;
@@ -1087,13 +1089,53 @@ mcd_return_et mcd_execute_txlist_f(const mcd_core_st *core,
 
 mcd_return_et mcd_run_f(const mcd_core_st *core, bool global)
 {
-    g_server_state.last_error = &MCD_ERROR_NOT_IMPLEMENTED;
-    return g_server_state.last_error->return_status;
+    mcdcore_state *core_state;
+
+    if (g_server_state.cores->len > 1 && global) {
+        vm_start();
+        g_server_state.last_error = &MCD_ERROR_NONE;
+        return g_server_state.last_error->return_status;
+    }
+
+    if (!core) {
+        g_server_state.last_error = &MCD_ERROR_INVALID_NULL_PARAM;
+        return g_server_state.last_error->return_status;
+    }
+
+    core_state = find_core(core->core_con_info);
+    if (!core_state || core_state->open_core != core) {
+        g_server_state.last_error = &MCD_ERROR_UNKNOWN_CORE;
+        return g_server_state.last_error->return_status;
+    }
+
+    if (!runstate_needs_reset() && !runstate_is_running() &&
+        !vm_prepare_start(false)) {
+        cpu_resume(core_state->cpu);
+        qemu_clock_enable(QEMU_CLOCK_VIRTUAL, true);
+    }
+
+    core_state->last_error = &MCD_ERROR_NONE;
+    return core_state->last_error->return_status;
 }
 
 mcd_return_et mcd_stop_f(const mcd_core_st *core, bool global)
 {
-    g_server_state.last_error = &MCD_ERROR_NOT_IMPLEMENTED;
+    if (g_server_state.cores->len > 1 && !global) {
+        g_server_state.custom_error = (mcd_error_info_st) {
+            .return_status = MCD_RET_ACT_HANDLE_ERROR,
+            .error_code = MCD_ERR_FN_UNIMPLEMENTED,
+            .error_events = MCD_ERR_EVT_NONE,
+            .error_str = "core-specific stop not implemented",
+        };
+        g_server_state.last_error = &g_server_state.custom_error;
+        return g_server_state.last_error->return_status;
+    }
+
+    if (runstate_is_running()) {
+        vm_stop(RUN_STATE_DEBUG);
+    }
+
+    g_server_state.last_error = &MCD_ERROR_NONE;
     return g_server_state.last_error->return_status;
 }
 
@@ -1120,7 +1162,31 @@ mcd_return_et mcd_step_f(const mcd_core_st *core, bool global,
 
 mcd_return_et mcd_set_global_f(const mcd_core_st *core, bool enable)
 {
-    g_server_state.last_error = &MCD_ERROR_NOT_IMPLEMENTED;
+    mcdcore_state *core_state;
+
+    if (!core) {
+        g_server_state.last_error = &MCD_ERROR_INVALID_NULL_PARAM;
+        return g_server_state.last_error->return_status;
+    }
+
+    core_state = find_core(core->core_con_info);
+    if (!core_state || core_state->open_core != core) {
+        g_server_state.last_error = &MCD_ERROR_UNKNOWN_CORE;
+        return g_server_state.last_error->return_status;
+    }
+
+    if (!enable) {
+        core_state->custom_error = (mcd_error_info_st) {
+            .return_status = MCD_RET_ACT_HANDLE_ERROR,
+            .error_code = MCD_ERR_GENERAL,
+            .error_events = MCD_ERR_EVT_NONE,
+            .error_str = "global stop activities cannot be disabled",
+        };
+        core_state->last_error = &core_state->custom_error;
+        return core_state->last_error->return_status;
+    }
+
+    g_server_state.last_error = &MCD_ERROR_NONE;
     return g_server_state.last_error->return_status;
 }
 
diff --git a/mcd/mcd_stub.c b/mcd/mcd_stub.c
index f7aadc6..76911b4 100644
--- a/mcd/mcd_stub.c
+++ b/mcd/mcd_stub.c
@@ -516,3 +516,55 @@ MCDQryRegMapResult *qmp_mcd_qry_reg_map(uint32_t core_uid,
     g_stub_state.on_error_ask_server = true;
     return result;
 }
+
+MCDRunResult *qmp_mcd_run(uint32_t core_uid, bool global, Error **errp)
+{
+    MCDRunResult *result = g_malloc0(sizeof(*result));
+    mcd_core_st *core = NULL;
+
+    result->return_status = retrieve_open_core(core_uid, &core);
+    if (result->return_status != MCD_RET_ACT_NONE) {
+        g_stub_state.on_error_ask_server = false;
+        return result;
+    }
+
+    result->return_status = mcd_run_f(core, global);
+
+    g_stub_state.on_error_ask_server = true;
+    return result;
+}
+
+MCDStopResult *qmp_mcd_stop(uint32_t core_uid, bool global, Error **errp)
+{
+    MCDStopResult *result = g_malloc0(sizeof(*result));
+    mcd_core_st *core = NULL;
+
+    result->return_status = retrieve_open_core(core_uid, &core);
+    if (result->return_status != MCD_RET_ACT_NONE) {
+        g_stub_state.on_error_ask_server = false;
+        return result;
+    }
+
+    result->return_status = mcd_stop_f(core, global);
+
+    g_stub_state.on_error_ask_server = true;
+    return result;
+}
+
+MCDSetGlobalResult *qmp_mcd_set_global(uint32_t core_uid, bool enable,
+                                       Error **errp)
+{
+    MCDSetGlobalResult *result = g_malloc0(sizeof(*result));
+    mcd_core_st *core = NULL;
+
+    result->return_status = retrieve_open_core(core_uid, &core);
+    if (result->return_status != MCD_RET_ACT_NONE) {
+        g_stub_state.on_error_ask_server = false;
+        return result;
+    }
+
+    result->return_status = mcd_set_global_f(core, enable);
+
+    g_stub_state.on_error_ask_server = true;
+    return result;
+}
diff --git a/qapi/mcd.json b/qapi/mcd.json
index 936016d..c8b82e7 100644
--- a/qapi/mcd.json
+++ b/qapi/mcd.json
@@ -1373,3 +1373,103 @@
     'start-index': 'uint32',
     'num-regs': 'uint32' },
   'returns': 'MCDQryRegMapResult' }
+
+
+##
+# == Target Execution Control API
+##
+
+
+##
+# @MCDRunResult:
+#
+# Return value of @MCDRunResult.
+#
+# @return-status: Return code.
+#
+# Since: 9.1
+##
+{ 'struct': 'MCDRunResult', 'data': { 'return-status': 'uint32' } }
+
+
+##
+# @mcd-run:
+#
+# Function starting execution on a particular core.
+#
+# @core-uid: Unique identifier of the open core as returned by @mcd-open-core.
+# @global:   Set to "TRUE" if all cores of a system shall start execution.
+#            Otherwise, starting execution of selected core only.
+#
+# Returns: @MCDRunResult
+#
+# Since: 9.1
+##
+{ 'command': 'mcd-run',
+  'data': {
+    'core-uid': 'uint32',
+    'global'  : 'bool' },
+  'returns': 'MCDRunResult' }
+
+
+##
+# @MCDStopResult:
+#
+# Return value of @mcd-stop.
+#
+# @return-status: Return code.
+#
+# Since: 9.1
+##
+{ 'struct': 'MCDStopResult', 'data': { 'return-status': 'uint32' } }
+
+
+##
+# @mcd-stop:
+#
+# Function stopping execution on a particular core.
+#
+# @core-uid: Unique identifier of the open core as returned by @mcd-open-core.
+# @global:   Set to "TRUE" if all cores of a system shall stop execution.
+#            Otherwise, stopping execution of selected core only.
+#
+# Returns: @MCDStopResult
+#
+# Since: 9.1
+##
+{ 'command': 'mcd-stop',
+  'data': {
+    'core-uid': 'uint32',
+    'global'  : 'bool' },
+  'returns': 'MCDStopResult' }
+
+##
+# @MCDSetGlobalResult:
+#
+# Return value of @mcd-set-global.
+#
+# @return-status: Return code.
+#
+# Since: 9.1
+##
+{ 'struct': 'MCDSetGlobalResult', 'data': { 'return-status': 'uint32' } }
+
+
+##
+# @mcd-set-global:
+#
+# Function enabling/disabling global stop and run activities on this core.
+#
+# @core-uid: Unique identifier of the open core as returned by @mcd-open-core.
+# @enable:   Set to "TRUE" if this core should perform global run or stop
+#            activities.
+#
+# Returns: @MCDSetGlobalResult
+#
+# Since: 9.1
+##
+{ 'command': 'mcd-set-global',
+  'data': {
+    'core-uid': 'uint32',
+    'enable'  : 'bool' },
+  'returns': 'MCDSetGlobalResult' }
-- 
2.34.1


