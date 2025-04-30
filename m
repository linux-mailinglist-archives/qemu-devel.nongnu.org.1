Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A65AA426A
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Apr 2025 07:33:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uA008-0002WF-F2; Wed, 30 Apr 2025 01:28:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mario.fleischmann@lauterbach.com>)
 id 1u9zzi-0002CM-LE
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 01:28:30 -0400
Received: from smtp1.lauterbach.com ([62.154.241.196])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mario.fleischmann@lauterbach.com>)
 id 1u9zzb-0006iH-3o
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 01:28:30 -0400
Received: (qmail 1814 invoked by uid 484); 30 Apr 2025 05:28:04 -0000
X-Qmail-Scanner-Diagnostics: from 10.2.13.100 by smtp1.lauterbach.com
 (envelope-from <mario.fleischmann@lauterbach.com>,
 uid 484) with qmail-scanner-2.11 
 (mhr: 1.0. clamdscan: 0.99/21437. spamassassin: 3.4.0.  
 Clear:RC:1(10.2.13.100):. 
 Processed in 0.013225 secs); 30 Apr 2025 05:28:04 -0000
Received: from unknown (HELO mflpc1.LTB.LAN)
 (Authenticated_SSL:mfleischmann@[10.2.13.100])
 (envelope-sender <mario.fleischmann@lauterbach.com>)
 by smtp1.lauterbach.com (qmail-ldap-1.03) with TLS_AES_256_GCM_SHA384
 encrypted SMTP
 for <qemu-devel@nongnu.org>; 30 Apr 2025 05:28:04 -0000
From: Mario Fleischmann <mario.fleischmann@lauterbach.com>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, philmd@linaro.org, armbru@redhat.com,
 christian.boenig@lauterbach.com,
 Mario Fleischmann <mario.fleischmann@lauterbach.com>
Subject: [PATCH v2 09/20] mcd: Implement target system query
Date: Wed, 30 Apr 2025 07:27:30 +0200
Message-Id: <20250430052741.21145-10-mario.fleischmann@lauterbach.com>
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

In MCD, the target system is divided into system, devices and cores:

[ system ] 1-* [ devices ] 1-* [cores]

This commit implements the necessary functions to query information
about the target system.

Signed-off-by: Mario Fleischmann <mario.fleischmann@lauterbach.com>
---
 mcd/mcd_qapi.c         |  48 ++++++
 mcd/mcd_qapi.h         |   4 +
 mcd/mcd_server.c       | 165 ++++++++++++++++++-
 mcd/mcd_stub.c         | 116 ++++++++++++++
 qapi/mcd.json          | 356 +++++++++++++++++++++++++++++++++++++++++
 tests/qtest/mcd-test.c |  83 ++++++++++
 tests/qtest/mcd-util.c |  67 ++++++++
 tests/qtest/mcd-util.h |  11 ++
 8 files changed, 847 insertions(+), 3 deletions(-)

diff --git a/mcd/mcd_qapi.c b/mcd/mcd_qapi.c
index d2a2926..a1122f2 100644
--- a/mcd/mcd_qapi.c
+++ b/mcd/mcd_qapi.c
@@ -77,3 +77,51 @@ MCDServerInfo *marshal_mcd_server_info(const mcd_server_info_st *server_info)
 
     return marshal;
 }
+
+MCDCoreConInfo *marshal_mcd_core_con_info(const mcd_core_con_info_st *con_info)
+{
+    MCDCoreConInfo *marshal = g_malloc0(sizeof(*marshal));
+
+    *marshal = (MCDCoreConInfo) {
+        .host = g_strdup(con_info->host),
+        .server_port = con_info->server_port,
+        .server_key = g_strdup(con_info->server_key),
+        .system_key = g_strdup(con_info->system_key),
+        .device_key = g_strdup(con_info->device_key),
+        .system = g_strdup(con_info->system),
+        .system_instance = g_strdup(con_info->system_instance),
+        .acc_hw = g_strdup(con_info->acc_hw),
+        .device_type = con_info->device_type,
+        .device = g_strdup(con_info->device),
+        .device_id = con_info->device_id,
+        .core = g_strdup(con_info->core),
+        .core_type = con_info->core_type,
+        .core_id = con_info->core_id,
+    };
+
+    return marshal;
+}
+
+mcd_core_con_info_st unmarshal_mcd_core_con_info(MCDCoreConInfo *con_info)
+{
+    mcd_core_con_info_st unmarshal = {
+        .server_port = con_info->server_port,
+        .device_type = con_info->device_type,
+        .device_id = con_info->device_id,
+        .core_type = con_info->core_type,
+        .core_id = con_info->core_id,
+    };
+
+    strncpy(unmarshal.host, con_info->host, MCD_HOSTNAME_LEN - 1);
+    strncpy(unmarshal.server_key, con_info->server_key, MCD_KEY_LEN - 1);
+    strncpy(unmarshal.system_key, con_info->system_key, MCD_KEY_LEN - 1);
+    strncpy(unmarshal.device_key, con_info->device_key, MCD_KEY_LEN - 1);
+    strncpy(unmarshal.system, con_info->system, MCD_UNIQUE_NAME_LEN - 1);
+    strncpy(unmarshal.system_instance, con_info->system_instance,
+            MCD_UNIQUE_NAME_LEN - 1);
+    strncpy(unmarshal.acc_hw, con_info->acc_hw, MCD_UNIQUE_NAME_LEN - 1);
+    strncpy(unmarshal.device, con_info->device, MCD_UNIQUE_NAME_LEN - 1);
+    strncpy(unmarshal.core, con_info->core, MCD_UNIQUE_NAME_LEN - 1);
+
+    return unmarshal;
+}
diff --git a/mcd/mcd_qapi.h b/mcd/mcd_qapi.h
index e515a37..45b3ac4 100644
--- a/mcd/mcd_qapi.h
+++ b/mcd/mcd_qapi.h
@@ -23,6 +23,10 @@ MCDErrorInfo *marshal_mcd_error_info(const mcd_error_info_st *error_info);
 
 MCDServerInfo *marshal_mcd_server_info(const mcd_server_info_st *server_info);
 
+MCDCoreConInfo *marshal_mcd_core_con_info(const mcd_core_con_info_st *con_info);
+
 mcd_api_version_st unmarshal_mcd_api_version(MCDAPIVersion *api_version);
 
+mcd_core_con_info_st unmarshal_mcd_core_con_info(MCDCoreConInfo *con_info);
+
 #endif /* MCD_QAPI_H */
diff --git a/mcd/mcd_server.c b/mcd/mcd_server.c
index 4d06c25..9cc7ec0 100644
--- a/mcd/mcd_server.c
+++ b/mcd/mcd_server.c
@@ -9,7 +9,9 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/cutils.h"
 #include "mcd_api.h"
+#include "hw/boards.h"
 
 static const mcd_error_info_st MCD_ERROR_NOT_IMPLEMENTED = {
     .return_status = MCD_RET_ACT_HANDLE_ERROR,
@@ -25,6 +27,13 @@ static const mcd_error_info_st MCD_ERROR_INVALID_NULL_PARAM = {
     .error_str = "null was invalidly passed as a parameter",
 };
 
+static const mcd_error_info_st MCD_ERROR_SERVER_NOT_OPEN = {
+    .return_status = MCD_RET_ACT_HANDLE_ERROR,
+    .error_code = MCD_ERR_CONNECTION,
+    .error_events = MCD_ERR_EVT_NONE,
+    .error_str = "server is not open",
+};
+
 static const mcd_error_info_st MCD_ERROR_NONE = {
     .return_status = MCD_RET_ACT_NONE,
     .error_code = MCD_ERR_NONE,
@@ -40,15 +49,21 @@ static mcd_error_info_st custom_mcd_error;
  *
  * @last_error:  Error info of most recent executed function.
  * @open_server: Open server instance as allocated in mcd_open_server_f().
+ * @system_key:  System key as provided in mcd_open_server_f()
+ * @cores:       Internal core information database.
  */
 typedef struct mcdserver_state {
     const mcd_error_info_st *last_error;
     mcd_server_st *open_server;
+    char system_key[MCD_KEY_LEN];
+    GArray *cores;
 } mcdserver_state;
 
 static mcdserver_state g_server_state = {
     .last_error = &MCD_ERROR_NONE,
     .open_server = NULL,
+    .system_key = "",
+    .cores = NULL,
 };
 
 mcd_return_et mcd_initialize_f(const mcd_api_version_st *version_req,
@@ -153,6 +168,8 @@ mcd_return_et mcd_open_server_f(const char *system_key,
                                 const char *config_string,
                                 mcd_server_st **server)
 {
+    CPUState *cpu;
+
     if (g_server_state.open_server) {
         custom_mcd_error = (mcd_error_info_st) {
             .return_status = MCD_RET_ACT_HANDLE_ERROR,
@@ -178,6 +195,23 @@ mcd_return_et mcd_open_server_f(const char *system_key,
 
     *server = g_server_state.open_server;
 
+    if (system_key) {
+        pstrcpy(g_server_state.system_key, MCD_KEY_LEN, system_key);
+    }
+
+    /* update the internal core information data base */
+    g_server_state.cores = g_array_new(false, true,
+                                       sizeof(mcd_core_con_info_st));
+    CPU_FOREACH(cpu) {
+        ObjectClass *oc = object_get_class(OBJECT(cpu));
+        const char *cpu_model = object_class_get_name(oc);
+        mcd_core_con_info_st info = {
+            .core_id = g_server_state.cores->len,
+        };
+        pstrcpy(info.core, MCD_UNIQUE_NAME_LEN, cpu_model);
+        g_array_append_val(g_server_state.cores, info);
+    }
+
     g_server_state.last_error = &MCD_ERROR_NONE;
     return g_server_state.last_error->return_status;
 }
@@ -206,8 +240,10 @@ mcd_return_et mcd_close_server_f(const mcd_server_st *server)
         return g_server_state.last_error->return_status;
     }
 
+    g_array_free(g_server_state.cores, true);
     g_free(g_server_state.open_server);
     g_server_state.open_server = NULL;
+    g_server_state.system_key[0] = '\0';
 
     g_server_state.last_error = &MCD_ERROR_NONE;
     return g_server_state.last_error->return_status;
@@ -231,7 +267,45 @@ mcd_return_et mcd_qry_server_config_f(const mcd_server_st *server,
 mcd_return_et mcd_qry_systems_f(uint32_t start_index, uint32_t *num_systems,
                                 mcd_core_con_info_st *system_con_info)
 {
-    g_server_state.last_error = &MCD_ERROR_NOT_IMPLEMENTED;
+    if (!num_systems) {
+        g_server_state.last_error = &MCD_ERROR_INVALID_NULL_PARAM;
+        return g_server_state.last_error->return_status;
+    }
+
+    if (*num_systems == 0) {
+        *num_systems = 1;
+        g_server_state.last_error = &MCD_ERROR_NONE;
+        return g_server_state.last_error->return_status;
+    }
+
+    if (start_index >= 1) {
+        custom_mcd_error = (mcd_error_info_st) {
+            .return_status = MCD_RET_ACT_HANDLE_ERROR,
+            .error_code = MCD_ERR_PARAM,
+            .error_events = MCD_ERR_EVT_NONE,
+            .error_str = "QEMU only emulates one system",
+        };
+        g_server_state.last_error = &custom_mcd_error;
+        return g_server_state.last_error->return_status;
+    }
+
+    /* num_systems != 0 => return system information */
+
+    if (!system_con_info) {
+        g_server_state.last_error = &MCD_ERROR_INVALID_NULL_PARAM;
+        return g_server_state.last_error->return_status;
+    }
+
+    *system_con_info = (mcd_core_con_info_st) {};
+    pstrcpy(system_con_info->system, MCD_UNIQUE_NAME_LEN, g_get_prgname());
+    pstrcpy(system_con_info->system_key, MCD_KEY_LEN,
+            g_server_state.system_key);
+    snprintf(system_con_info->system_instance, MCD_UNIQUE_NAME_LEN ,
+             "Process ID: %d", (int) getpid());
+
+    *num_systems = 1;
+
+    g_server_state.last_error = &MCD_ERROR_NONE;
     return g_server_state.last_error->return_status;
 }
 
@@ -239,7 +313,41 @@ mcd_return_et mcd_qry_devices_f(const mcd_core_con_info_st *system_con_info,
                                 uint32_t start_index, uint32_t *num_devices,
                                 mcd_core_con_info_st *device_con_info)
 {
-    g_server_state.last_error = &MCD_ERROR_NOT_IMPLEMENTED;
+    MachineClass *mc = MACHINE_GET_CLASS(current_machine);
+
+    if (!system_con_info || !num_devices) {
+        g_server_state.last_error = &MCD_ERROR_INVALID_NULL_PARAM;
+        return g_server_state.last_error->return_status;
+    }
+
+    if (*num_devices == 0) {
+        *num_devices = 1;
+        g_server_state.last_error = &MCD_ERROR_NONE;
+        return g_server_state.last_error->return_status;
+    }
+
+    if (start_index >= 1) {
+        custom_mcd_error = (mcd_error_info_st) {
+            .return_status = MCD_RET_ACT_HANDLE_ERROR,
+            .error_code = MCD_ERR_PARAM,
+            .error_events = MCD_ERR_EVT_NONE,
+            .error_str = "QEMU only emulates one machine",
+        };
+        g_server_state.last_error = &custom_mcd_error;
+        return g_server_state.last_error->return_status;
+    }
+
+    if (!device_con_info) {
+        g_server_state.last_error = &MCD_ERROR_INVALID_NULL_PARAM;
+        return g_server_state.last_error->return_status;
+    }
+
+    *device_con_info = *system_con_info;
+    pstrcpy(device_con_info->device, MCD_UNIQUE_NAME_LEN, mc->name);
+
+    *num_devices = 1;
+
+    g_server_state.last_error = &MCD_ERROR_NONE;
     return g_server_state.last_error->return_status;
 }
 
@@ -247,7 +355,58 @@ mcd_return_et mcd_qry_cores_f(const mcd_core_con_info_st *connection_info,
                               uint32_t start_index, uint32_t *num_cores,
                               mcd_core_con_info_st *core_con_info)
 {
-    g_server_state.last_error = &MCD_ERROR_NOT_IMPLEMENTED;
+    uint32_t i;
+
+    if (!g_server_state.open_server) {
+        g_server_state.last_error = &MCD_ERROR_SERVER_NOT_OPEN;
+        return g_server_state.last_error->return_status;
+    }
+
+    if (!connection_info || !num_cores) {
+        g_server_state.last_error = &MCD_ERROR_INVALID_NULL_PARAM;
+        return g_server_state.last_error->return_status;
+    }
+
+    /* array is allocated during core database update in mcd_server_open_f */
+    g_assert(g_server_state.cores);
+
+    if (*num_cores == 0) {
+        *num_cores = g_server_state.cores->len;
+        g_server_state.last_error = &MCD_ERROR_NONE;
+        return g_server_state.last_error->return_status;
+    }
+
+    if (start_index >= g_server_state.cores->len) {
+        custom_mcd_error = (mcd_error_info_st) {
+            .return_status = MCD_RET_ACT_HANDLE_ERROR,
+            .error_code = MCD_ERR_PARAM,
+            .error_events = MCD_ERR_EVT_NONE,
+            .error_str = "start_index exceeds the number of cores",
+        };
+        g_server_state.last_error = &custom_mcd_error;
+        return g_server_state.last_error->return_status;
+    }
+
+    if (!core_con_info) {
+        g_server_state.last_error = &MCD_ERROR_INVALID_NULL_PARAM;
+        return g_server_state.last_error->return_status;
+    }
+
+    for (i = 0;
+         i < *num_cores && start_index + i < g_server_state.cores->len;
+         i++) {
+
+        mcd_core_con_info_st *info = &g_array_index(g_server_state.cores,
+                                                    mcd_core_con_info_st,
+                                                    start_index + i);
+        core_con_info[i] = *connection_info;
+        core_con_info[i].core_id = info->core_id;
+        pstrcpy(core_con_info[i].core, MCD_UNIQUE_NAME_LEN, info->core);
+    }
+
+    *num_cores = i;
+
+    g_server_state.last_error = &MCD_ERROR_NONE;
     return g_server_state.last_error->return_status;
 }
 
diff --git a/mcd/mcd_stub.c b/mcd/mcd_stub.c
index b237f9a..02d16b4 100644
--- a/mcd/mcd_stub.c
+++ b/mcd/mcd_stub.c
@@ -134,6 +134,122 @@ MCDCloseServerResult *qmp_mcd_close_server(uint32_t server_uid, Error **errp)
     return result;
 }
 
+MCDQrySystemsResult *qmp_mcd_qry_systems(uint32_t start_index,
+                                         uint32_t num_systems, Error **errp)
+{
+    MCDCoreConInfoList **tailp;
+    MCDCoreConInfo *info;
+    mcd_core_con_info_st *system_con_info = NULL;
+    bool query_num_only = num_systems == 0;
+    MCDQrySystemsResult *result = g_malloc0(sizeof(*result));
+
+    if (!query_num_only) {
+        system_con_info = g_malloc0(num_systems * sizeof(*system_con_info));
+    }
+
+    result->return_status = mcd_qry_systems_f(start_index, &num_systems,
+                                              system_con_info);
+
+    if (result->return_status == MCD_RET_ACT_NONE) {
+        result->has_num_systems = true;
+        result->num_systems = num_systems;
+        if (!query_num_only) {
+            result->has_system_con_info = true;
+            tailp = &(result->system_con_info);
+            for (uint32_t i = 0; i < num_systems; i++) {
+                info = marshal_mcd_core_con_info(system_con_info + i);
+                QAPI_LIST_APPEND(tailp, info);
+            }
+        }
+    }
+
+    if (!query_num_only) {
+        g_free(system_con_info);
+    }
+
+    return result;
+}
+
+MCDQryDevicesResult *qmp_mcd_qry_devices(MCDCoreConInfo *system_con_info,
+                                         uint32_t start_index,
+                                         uint32_t num_devices, Error **errp)
+{
+    MCDCoreConInfoList **tailp;
+    MCDCoreConInfo *info;
+    mcd_core_con_info_st *device_con_info = NULL;
+    bool query_num_only = num_devices == 0;
+    MCDQryDevicesResult *result = g_malloc0(sizeof(*result));
+    mcd_core_con_info_st system_con_info_unmarshalled =
+        unmarshal_mcd_core_con_info(system_con_info);
+
+    if (!query_num_only) {
+        device_con_info = g_malloc0(num_devices * sizeof(*device_con_info));
+    }
+
+    result->return_status = mcd_qry_devices_f(&system_con_info_unmarshalled,
+                                              start_index, &num_devices,
+                                              device_con_info);
+
+    if (result->return_status == MCD_RET_ACT_NONE) {
+        result->has_num_devices = true;
+        result->num_devices = num_devices;
+        if (!query_num_only) {
+            result->has_device_con_info = true;
+            tailp = &(result->device_con_info);
+            for (uint32_t i = 0; i < num_devices; i++) {
+                info = marshal_mcd_core_con_info(device_con_info + i);
+                QAPI_LIST_APPEND(tailp, info);
+            }
+        }
+    }
+
+    if (!query_num_only) {
+        g_free(device_con_info);
+    }
+
+    return result;
+}
+
+MCDQryCoresResult *qmp_mcd_qry_cores(MCDCoreConInfo *connection_info,
+                                     uint32_t start_index, uint32_t num_cores,
+                                     Error **errp)
+{
+    MCDCoreConInfoList **tailp;
+    MCDCoreConInfo *info;
+    mcd_core_con_info_st *core_con_info = NULL;
+    bool query_num_only = num_cores == 0;
+    MCDQryCoresResult *result = g_malloc0(sizeof(*result));
+    mcd_core_con_info_st connection_info_unmarshalled =
+        unmarshal_mcd_core_con_info(connection_info);
+
+    if (!query_num_only) {
+        core_con_info = g_malloc0(num_cores * sizeof(*core_con_info));
+    }
+
+    result->return_status = mcd_qry_cores_f(&connection_info_unmarshalled,
+                                            start_index, &num_cores,
+                                            core_con_info);
+
+    if (result->return_status == MCD_RET_ACT_NONE) {
+        result->has_num_cores = true;
+        result->num_cores = num_cores;
+        if (!query_num_only) {
+            result->has_core_con_info = true;
+            tailp = &(result->core_con_info);
+            for (uint32_t i = 0; i < num_cores; i++) {
+                info = marshal_mcd_core_con_info(core_con_info + i);
+                QAPI_LIST_APPEND(tailp, info);
+            }
+        }
+    }
+
+    if (!query_num_only) {
+        g_free(core_con_info);
+    }
+
+    return result;
+}
+
 MCDErrorInfo *qmp_mcd_qry_error_info(Error **errp)
 {
     MCDErrorInfo *result;
diff --git a/qapi/mcd.json b/qapi/mcd.json
index 3cdfd5d..2d581b9 100644
--- a/qapi/mcd.json
+++ b/qapi/mcd.json
@@ -91,6 +91,62 @@
     'acc-hw'         : 'str' } }
 
 
+##
+# @MCDCoreConInfo:
+#
+# Structure type containing the core connection information.
+#
+# @host:            String containing the IP host name.
+# @server-port:     Port number of the server.
+# @server-key:      String containing the server key as provided by
+#                   mcd_open_server_f().
+# @system-key:      String containing the system key as provided by
+#                   mcd_open_server_f().
+# @device-key:      String containing the device key, optional for
+#                   mcd_open_core_f().
+# @system:          String containing the system name. Predefined value is
+#                   "Real HW" for physical devices. Note that in case of "Real
+#                   HW" the @acc-hw always needs to be defined.
+# @system-instance: String containing the unique system instance identifier.
+#                   Allows to differentiate between several system instances
+#                   with the same name. A typical use case is a simulator where
+#                   different instances can be distinguished by their process
+#                   ID. (For example @system-instance could be: "Process ID:
+#                   1234")
+# @acc-hw:          String containing the unique device access hardware name.
+# @device-type:     Device type identifier (IEEE 1149.1 device ID)
+# @device:          String containing the system unique device instance name.
+#                   For Real HW this is usually the sales name of the device.
+#                   If the access hardware operates a multi device target
+#                   system (e.g. over IEEE1149.7), this device string can
+#                   contain an index to differentiate between several devices
+#                   of the same type.
+# @device-id:       Unique device ID.
+# @core:            String containing the device unique core name.
+# @core-type:       Core type identifier (taken from ELF predefined
+#                   architecture)
+# @core-id:         Unique core ID representing the core version.
+#
+# Since: 9.1
+##
+{ 'struct': 'MCDCoreConInfo',
+  'data': {
+    'host'           : 'str',
+    'server-port'    : 'uint32',
+    'server-key'     : 'str',
+    'system-key'     : 'str',
+    'device-key'     : 'str',
+    'system'         : 'str',
+    'system-instance': 'str',
+    'acc-hw'         : 'str',
+    'device-type'    : 'uint32',
+    'device'         : 'str',
+    'device-id'      : 'uint32',
+    'core'           : 'str',
+    'core-type'      : 'uint32',
+    'core-id'        : 'uint32' } }
+
+
 ##
 # == Target Initialization API
 ##
@@ -353,6 +409,306 @@
   'returns': 'MCDCloseServerResult' }
 
 
+##
+# == Target System Features API
+##
+
+
+##
+# @MCDQrySystemsResult:
+#
+# Return value of @mcd-qry-systems.
+#
+# @return-status:   Return code.
+# @num-systems:     The number of systems the core connection info was returned
+#                   for. In case the input value of @num-systems is '0', this is
+#                   the number of all available systems.
+# @system-con-info: Core connection information of the requested systems.
+#
+# Since: 9.1
+##
+{ 'struct': 'MCDQrySystemsResult',
+  'data': {
+    'return-status'   : 'uint32',
+    '*num-systems'    : 'uint32',
+    '*system-con-info': [ 'MCDCoreConInfo' ] }}
+
+
+##
+# @mcd-qry-systems:
+#
+# Function querying the core connection information of a specified number of
+# systems.
+#
+# @start-index: Start index of the queried systems. This refers to an
+#               internal list of the target side implementation.
+# @num-systems: The number of queried systems starting from the defined
+#               @start-index. If it is set to '0', no core connection
+#               information is returned but the number of available systems.
+#
+# Returns: @MCDQrySystemsResult
+#
+# Since: 9.1
+#
+# .. qmp-example::
+#
+#     -> { "execute": "mcd-qry-systems",
+#          "arguments": { "start-index": 0,
+#                         "num-systems": 1 } }
+#     <- {
+#            "return": {
+#                "num-systems": 1,
+#                "system-con-info": [
+#                    {
+#                        "core-id": 0,
+#                        "device": "",
+#                        "device-id": 0,
+#                        "device-key": "",
+#                        "system": "qemu-system-aarch64",
+#                        "core": "",
+#                        "host": "",
+#                        "system-key": "",
+#                        "system-instance": "Process ID: 21591",
+#                        "acc-hw": "",
+#                        "core-type": 0,
+#                        "device-type": 0,
+#                        "server-key": "",
+#                        "server-port": 0
+#                    }
+#                ],
+#                "return-status": 0
+#            }
+#        }
+##
+{ 'command': 'mcd-qry-systems',
+  'data': {
+    'start-index': 'uint32',
+    'num-systems': 'uint32' },
+  'returns': 'MCDQrySystemsResult' }
+
+
+##
+# @MCDQryDevicesResult:
+#
+# Return value of @mcd-qry-devices.
+#
+# @return-status:   Return code.
+# @num-devices:     The number of devices the core connection information was
+#                   returned for. In case the input value of @num-devices is
+#                   '0', this is the number of all available devices for the
+#                   selected system.
+# @device-con-info: Core connection information of the requested devices.
+#
+# Since: 9.1
+##
+{ 'struct': 'MCDQryDevicesResult',
+  'data': {
+    'return-status'   : 'uint32',
+    '*num-devices'    : 'uint32',
+    '*device-con-info': [ 'MCDCoreConInfo' ] }}
+
+
+##
+# @mcd-qry-devices:
+#
+# Function querying the core connection information of a specified number of
+# devices of a system.
+#
+# @system-con-info: Core connection information of the system the devices
+#                   are queried from.
+# @start-index:     Start index of the requested devices. This refers to
+#                   an internal list of the target side implementation.
+# @num-devices:     The number of queried devices (e.g. simulated on or
+#                   connected to this host computer) starting from the defined
+#                   @start-index. If it is set to '0', no core connection
+#                   information is returned but the number of all available
+#                   devices.
+#
+# Returns: @MCDQryDevicesResult
+#
+# Since: 9.1
+#
+# .. qmp-example::
+#
+#     -> { "execute": "mcd-qry-devices",
+#          "arguments": {
+#              "start-index": 0,
+#               "num-devices": 1,
+#               "system-con-info": {
+#                   "core-id": 0,
+#                   "device": "",
+#                   "device-id": 0,
+#                   "device-key": "",
+#                   "system": "qemu-system-aarch64",
+#                   "core": "",
+#                   "host": "",
+#                   "system-key": "",
+#                   "system-instance": "",
+#                   "acc-hw": "",
+#                   "core-type": 0,
+#                   "device-type": 0,
+#                   "server-key": "",
+#                   "server-port": 0 } } }
+#     <- {
+#            "return": {
+#                "return-status": 0,
+#                "num-devices": 1,
+#                "device-con-info": [
+#                    {
+#                        "core-id": 0,
+#                        "device": "virt-10.0",
+#                        "device-id": 0,
+#                        "device-key": "",
+#                        "system": "qemu-system-aarch64",
+#                        "core": "",
+#                        "host": "",
+#                        "system-key": "",
+#                        "system-instance": "",
+#                        "acc-hw": "",
+#                        "core-type": 0,
+#                        "device-type": 0,
+#                        "server-key": "",
+#                        "server-port": 0
+#                    }
+#                ]
+#            }
+#        }
+##
+{ 'command': 'mcd-qry-devices',
+  'data': {
+    'system-con-info': 'MCDCoreConInfo',
+    'start-index'    : 'uint32',
+    'num-devices'    : 'uint32' },
+  'returns': 'MCDQryDevicesResult' }
+
+
+##
+# @MCDQryCoresResult:
+#
+# Return value of @mcd-qry-cores.
+#
+# @return-status: Return code.
+#
+# @num-cores:     The number of cores the core connection information
+#                 is returned for. In case the input value of @num-cores is '0',
+#                 this is the number of all available cores for the selected
+#                 system or device.
+# @core-con-info: Core connection information of the requested cores.
+#
+# Since: 9.1
+##
+{ 'struct': 'MCDQryCoresResult',
+  'data': {
+  'return-status' : 'uint32',
+  '*num-cores'    : 'uint32',
+  '*core-con-info': [ 'MCDCoreConInfo' ] }}
+
+
+##
+# @mcd-qry-cores:
+#
+# Function querying the core connection information of a specified number of
+# cores of a system/device.
+#
+# @connection-info: Core connection information of the system or device
+#                   the cores are queried from.
+# @start-index:     Start index of the requested cores. This refers to an
+#                   internal list of the target side implementation.
+# @num-cores:       The number of queried cores starting from the defined
+#                   @start-index. If it is set to '0', no core connection
+#                   information is returned but the number of all available
+#                   cores.
+#
+# Returns: @MCDQryCoresResult
+#
+# Since: 9.1
+#
+# .. qmp-example::
+#    :title: Multicore
+#
+#     -> { "execute": "mcd-qry-cores",
+#          "arguments": {
+#              "start-index": 0,
+#               "num-cores": 3,
+#               "connection-info": {
+#                   "core-id": 0,
+#                   "device": "virt-10.0",
+#                   "device-id": 0,
+#                   "device-key": "",
+#                   "system": "",
+#                   "core": "",
+#                   "host": "",
+#                   "system-key": "qemu-system-aarch64",
+#                   "system-instance": "",
+#                   "acc-hw": "",
+#                   "core-type": 0,
+#                   "device-type": 0,
+#                   "server-key": "",
+#                   "server-port": 0 } } }
+#     <- {
+#            "return": {
+#                "num-cores": 3,
+#                "core-con-info": [
+#                    {
+#                        "core-id": 0,
+#                        "device": "virt-10.0",
+#                        "device-id": 0,
+#                        "device-key": "",
+#                        "system": "",
+#                        "core": "cortex-a53-arm-cpu",
+#                        "host": "",
+#                        "system-key": "qemu-system-aarch64",
+#                        "system-instance": "",
+#                        "acc-hw": "",
+#                        "core-type": 0,
+#                        "device-type": 0,
+#                        "server-key": "",
+#                        "server-port": 0
+#                    },
+#                    {
+#                        "core-id": 1,
+#                        "device": "virt-10.0",
+#                        "device-id": 0,
+#                        "device-key": "",
+#                        "system": "",
+#                        "core": "cortex-a53-arm-cpu",
+#                        "host": "",
+#                        "system-key": "qemu-system-aarch64",
+#                        "system-instance": "",
+#                        "acc-hw": "",
+#                        "core-type": 0,
+#                        "device-type": 0,
+#                        "server-key": "",
+#                        "server-port": 0
+#                    },
+#                    {
+#                        "core-id": 2,
+#                        "device": "virt-10.0",
+#                        "device-id": 0,
+#                        "device-key": "",
+#                        "system": "",
+#                        "core": "cortex-a53-arm-cpu",
+#                        "host": "",
+#                        "system-key": "qemu-system-aarch64",
+#                        "system-instance": "",
+#                        "acc-hw": "",
+#                        "core-type": 0,
+#                        "device-type": 0,
+#                        "server-key": "",
+#                        "server-port": 0
+#                    }
+#                ],
+#                "return-status": 0
+#            }
+#        }
+##
+{ 'command': 'mcd-qry-cores',
+  'data': {
+    'connection-info': 'MCDCoreConInfo',
+    'start-index'    : 'uint32',
+    'num-cores'      : 'uint32' },
+  'returns': 'MCDQryCoresResult' }
+
 ##
 # == Core Connection API
 ##
diff --git a/tests/qtest/mcd-test.c b/tests/qtest/mcd-test.c
index 708a474..b1b36d9 100644
--- a/tests/qtest/mcd-test.c
+++ b/tests/qtest/mcd-test.c
@@ -226,6 +226,88 @@ static void test_open_server(void)
     mcdtest_quit(&qts);
 }
 
+static void test_qry_cores(void)
+{
+    QTestStateMCD qts = mcdtest_init(QEMU_EXTRA_ARGS);
+
+    char empty_string[] = "";
+
+    q_obj_mcd_open_server_arg open_server_args = {
+        .system_key = empty_string,
+        .config_string = empty_string,
+    };
+
+    q_obj_mcd_qry_systems_arg qry_systems_args = {
+        .start_index = 0,
+        .num_systems = 1,
+    };
+
+    q_obj_mcd_qry_devices_arg qry_devices_args = {
+        .start_index = 0,
+        .num_devices = 1,
+    };
+
+    q_obj_mcd_qry_cores_arg qry_cores_args = {
+        .start_index = 0,
+        /* first, only query the number of cores */
+        .num_cores = 0,
+    };
+
+    MCDOpenServerResult *open_server_result;
+    MCDQrySystemsResult *qry_systems_result;
+    MCDQryDevicesResult *qry_devices_result;
+    MCDQryCoresResult *qry_cores_result;
+
+    open_server_result = qtest_mcd_open_server(&qts, &open_server_args);
+    g_assert(open_server_result->return_status == MCD_RET_ACT_NONE);
+    g_assert(open_server_result->has_server_uid);
+    qapi_free_MCDOpenServerResult(open_server_result);
+
+    qry_systems_result = qtest_mcd_qry_systems(&qts, &qry_systems_args);
+    g_assert(qry_systems_result->return_status == MCD_RET_ACT_NONE);
+    g_assert(qry_systems_result->has_system_con_info);
+
+    qry_devices_args.system_con_info =
+        qry_systems_result->system_con_info->value;
+
+    qry_devices_result = qtest_mcd_qry_devices(&qts, &qry_devices_args);
+    g_assert(qry_devices_result->return_status == MCD_RET_ACT_NONE);
+    g_assert(qry_devices_result->has_device_con_info);
+    qapi_free_MCDQrySystemsResult(qry_systems_result);
+
+    qry_cores_args.connection_info =
+        qry_devices_result->device_con_info->value;
+
+    qry_cores_result = qtest_mcd_qry_cores(&qts, &qry_cores_args);
+    g_assert(qry_cores_result->return_status == MCD_RET_ACT_NONE);
+    g_assert(qry_cores_result->has_num_cores);
+    g_assert(qry_cores_result->num_cores > 0);
+    qry_cores_args.num_cores = qry_cores_result->num_cores;
+    qapi_free_MCDQryCoresResult(qry_cores_result);
+    qry_cores_result = qtest_mcd_qry_cores(&qts, &qry_cores_args);
+    qapi_free_MCDQryDevicesResult(qry_devices_result);
+
+    if (verbose) {
+        MCDCoreConInfoList *core_head = qry_cores_result->core_con_info;
+        for (uint32_t c = 0; c < qry_cores_result->num_cores; c++) {
+            MCDCoreConInfo *core_con = core_head->value;
+            if (verbose) {
+                fprintf(stderr, "[INFO]\tSystem: %s\n"
+                                "\tDevice: %s\n"
+                                "\tCore:   %s (#%d)\n",
+                                core_con->system,
+                                core_con->device,
+                                core_con->core, core_con->core_id);
+            }
+            core_head = core_head->next;
+        }
+    }
+
+    qapi_free_MCDQryCoresResult(qry_cores_result);
+    qtest_mcd_exit(&qts);
+    mcdtest_quit(&qts);
+}
+
 int main(int argc, char *argv[])
 {
     char *v_env = getenv("V");
@@ -236,5 +318,6 @@ int main(int argc, char *argv[])
     qtest_add_func("mcd/initialize", test_initialize);
     qtest_add_func("mcd/qry-servers", test_qry_servers);
     qtest_add_func("mcd/open-server", test_open_server);
+    qtest_add_func("mcd/qry-cores", test_qry_cores);
     return g_test_run();
 }
diff --git a/tests/qtest/mcd-util.c b/tests/qtest/mcd-util.c
index 3926b33..d37b44e 100644
--- a/tests/qtest/mcd-util.c
+++ b/tests/qtest/mcd-util.c
@@ -98,6 +98,13 @@ MCDErrorInfo *qtest_mcd_qry_error_info(QTestStateMCD *qts)
     return unmarshal;
 }
 
+void qtest_mcd_exit(QTestStateMCD *qts)
+{
+    QDict *resp = qtest_mcd(qts, "{'execute': 'mcd-exit' }");
+    qobject_unref(resp);
+}
+
+
 MCDQryServersResult *qtest_mcd_qry_servers(QTestStateMCD *qts,
                                            q_obj_mcd_qry_servers_arg *args)
 {
@@ -157,3 +164,63 @@ MCDCloseServerResult *qtest_mcd_close_server(QTestStateMCD *qts,
 
     return unmarshal;
 }
+
+MCDQrySystemsResult *qtest_mcd_qry_systems(QTestStateMCD *qts,
+                                            q_obj_mcd_qry_systems_arg *args)
+{
+    Visitor *v;
+    QObject *marshal;
+    QDict *arg, *resp;
+    QObject *ret;
+    bool ok;
+    MCDQrySystemsResult *unmarshal;
+
+    MARSHAL_ARGS(q_obj_mcd_qry_systems_arg);
+
+    resp = qtest_mcd(qts, "{'execute': 'mcd-qry-systems',"
+                          "'arguments': %p}", arg);
+
+    UNMARSHAL_RESULT(MCDQrySystemsResult);
+
+    return unmarshal;
+}
+
+MCDQryDevicesResult *qtest_mcd_qry_devices(QTestStateMCD *qts,
+                                           q_obj_mcd_qry_devices_arg *args)
+{
+    Visitor *v;
+    QObject *marshal;
+    QDict *arg, *resp;
+    QObject *ret;
+    bool ok;
+    MCDQryDevicesResult *unmarshal;
+
+    MARSHAL_ARGS(q_obj_mcd_qry_devices_arg);
+
+    resp = qtest_mcd(qts, "{'execute': 'mcd-qry-devices',"
+                          "'arguments': %p}", arg);
+
+    UNMARSHAL_RESULT(MCDQryDevicesResult);
+
+    return unmarshal;
+}
+
+MCDQryCoresResult *qtest_mcd_qry_cores(QTestStateMCD *qts,
+                                       q_obj_mcd_qry_cores_arg *args)
+{
+    Visitor *v;
+    QObject *marshal;
+    QDict *arg, *resp;
+    QObject *ret;
+    bool ok;
+    MCDQryCoresResult *unmarshal;
+
+    MARSHAL_ARGS(q_obj_mcd_qry_cores_arg);
+
+    resp = qtest_mcd(qts, "{'execute': 'mcd-qry-cores',"
+                          "'arguments': %p}", arg);
+
+    UNMARSHAL_RESULT(MCDQryCoresResult);
+
+    return unmarshal;
+}
diff --git a/tests/qtest/mcd-util.h b/tests/qtest/mcd-util.h
index 8ffafaa..fbac3b7 100644
--- a/tests/qtest/mcd-util.h
+++ b/tests/qtest/mcd-util.h
@@ -24,6 +24,8 @@ MCDInitializeResult *qtest_mcd_initialize(QTestStateMCD *qts,
 
 MCDErrorInfo *qtest_mcd_qry_error_info(QTestStateMCD *qts);
 
+void qtest_mcd_exit(QTestStateMCD *qts);
+
 MCDQryServersResult *qtest_mcd_qry_servers(QTestStateMCD *qts,
                                            q_obj_mcd_qry_servers_arg *args);
 
@@ -33,4 +35,13 @@ MCDOpenServerResult *qtest_mcd_open_server(QTestStateMCD *qts,
 MCDCloseServerResult *qtest_mcd_close_server(QTestStateMCD *qts,
                                              q_obj_mcd_close_server_arg *args);
 
+MCDQrySystemsResult *qtest_mcd_qry_systems(QTestStateMCD *qts,
+                                           q_obj_mcd_qry_systems_arg *args);
+
+MCDQryDevicesResult *qtest_mcd_qry_devices(QTestStateMCD *qts,
+                                           q_obj_mcd_qry_devices_arg *args);
+
+MCDQryCoresResult *qtest_mcd_qry_cores(QTestStateMCD *qts,
+                                       q_obj_mcd_qry_cores_arg *args);
+
 #endif /* TEST_MCD_UTILS_H */
-- 
2.34.1


