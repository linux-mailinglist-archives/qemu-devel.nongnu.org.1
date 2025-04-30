Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C329AA4273
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Apr 2025 07:33:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uA006-0002PR-C7; Wed, 30 Apr 2025 01:28:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mario.fleischmann@lauterbach.com>)
 id 1u9zzi-0002C7-EM
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 01:28:30 -0400
Received: from smtp1.lauterbach.com ([62.154.241.196])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mario.fleischmann@lauterbach.com>)
 id 1u9zzc-0006l6-W3
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 01:28:30 -0400
Received: (qmail 1999 invoked by uid 484); 30 Apr 2025 05:28:07 -0000
X-Qmail-Scanner-Diagnostics: from 10.2.13.100 by smtp1.lauterbach.com
 (envelope-from <mario.fleischmann@lauterbach.com>,
 uid 484) with qmail-scanner-2.11 
 (mhr: 1.0. clamdscan: 0.99/21437. spamassassin: 3.4.0.  
 Clear:RC:1(10.2.13.100):. 
 Processed in 0.013411 secs); 30 Apr 2025 05:28:07 -0000
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
Subject: [PATCH v2 17/20] mcd: Implement register/memory access
Date: Wed, 30 Apr 2025 07:27:38 +0200
Message-Id: <20250430052741.21145-18-mario.fleischmann@lauterbach.com>
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

In MCD, all accesses to register or memory are issued over transaction lists.
This commit implements three types of transactions:

* register access
* logical memory access (with MMU)
* physical memory access (no MMU)

In contrast to GDB's remote serial protocol, MCD supports specifying an
access width for memory transactions.

Signed-off-by: Mario Fleischmann <mario.fleischmann@lauterbach.com>
---
 mcd/mcd_qapi.c   | 128 +++++++++++++++++++++++++++++
 mcd/mcd_qapi.h   |  14 ++++
 mcd/mcd_server.c | 207 ++++++++++++++++++++++++++++++++++++++++++++++-
 mcd/mcd_stub.c   |  26 ++++++
 qapi/mcd.json    |  83 +++++++++++++++++++
 5 files changed, 456 insertions(+), 2 deletions(-)

diff --git a/mcd/mcd_qapi.c b/mcd/mcd_qapi.c
index 11e28d3..1cbf61e 100644
--- a/mcd/mcd_qapi.c
+++ b/mcd/mcd_qapi.c
@@ -126,6 +126,18 @@ mcd_core_con_info_st unmarshal_mcd_core_con_info(MCDCoreConInfo *con_info)
     return unmarshal;
 }
 
+mcd_addr_st unmarshal_mcd_addr(MCDAddr *addr)
+{
+    mcd_addr_st unmarshal = {
+        .address = addr->address,
+        .mem_space_id = addr->mem_space_id,
+        .addr_space_id = addr->addr_space_id,
+        .addr_space_type = addr->addr_space_type,
+    };
+
+    return unmarshal;
+}
+
 MCDMemspace *marshal_mcd_memspace(const mcd_memspace_st *mem_space)
 {
     MCDMemspace *marshal = g_malloc0(sizeof(*marshal));
@@ -211,3 +223,119 @@ MCDCoreState *marshal_mcd_core_state(const mcd_core_state_st *state)
 
     return marshal;
 }
+
+MCDTx *marshal_mcd_tx(const mcd_tx_st *tx)
+{
+    MCDTx *marshal = g_malloc0(sizeof(*marshal));
+
+    *marshal = (MCDTx) {
+        .addr = marshal_mcd_addr(&tx->addr),
+        .access_type = tx->access_type,
+        .options = tx->options,
+        .access_width = tx->access_width,
+        .core_mode = tx->core_mode,
+        .num_bytes = tx->num_bytes,
+        .num_bytes_ok = tx->num_bytes_ok,
+    };
+
+    if (tx->num_bytes == 0) {
+        return marshal;
+    }
+
+    g_assert(tx->data);
+
+    uint8List *head = marshal->data;
+    for (int i = tx->num_bytes - 1; i >= 0; i--) {
+        QAPI_LIST_PREPEND(head, tx->data[i]);
+    }
+    marshal->data = head;
+    return marshal;
+}
+
+mcd_tx_st unmarshal_mcd_tx(MCDTx *tx)
+{
+    mcd_tx_st unmarshal = {
+        .addr = unmarshal_mcd_addr(tx->addr),
+        .access_type = tx->access_type,
+        .options = tx->options,
+        .access_width = tx->access_width,
+        .core_mode = tx->core_mode,
+        .data = NULL,
+        .num_bytes = tx->num_bytes,
+        .num_bytes_ok = tx->num_bytes_ok,
+    };
+
+    if (tx->num_bytes == 0) {
+        return unmarshal;
+    }
+
+    unmarshal.data = g_malloc(tx->num_bytes);
+    uint8List *current_data = tx->data;
+    for (uint32_t i = 0; i < tx->num_bytes; i++) {
+        g_assert(current_data);
+        unmarshal.data[i] = current_data->value;
+        current_data = current_data->next;
+    }
+
+    return unmarshal;
+}
+
+void free_mcd_tx(mcd_tx_st *tx)
+{
+    g_free(tx->data);
+}
+
+MCDTxlist *marshal_mcd_txlist(const mcd_txlist_st *txlist)
+{
+    MCDTxlist *marshal = g_malloc0(sizeof(*marshal));
+
+    *marshal = (MCDTxlist) {
+        .num_tx = txlist->num_tx,
+        .num_tx_ok = txlist->num_tx_ok,
+    };
+
+    if (txlist->num_tx == 0) {
+        return marshal;
+    }
+
+    g_assert(txlist->tx);
+
+    MCDTxList **tailp = &(marshal->tx);
+    for (uint32_t i = 0; i < txlist->num_tx; i++) {
+        MCDTx *tx = marshal_mcd_tx(txlist->tx + i);
+        QAPI_LIST_APPEND(tailp, tx);
+    }
+
+    return marshal;
+}
+
+mcd_txlist_st unmarshal_mcd_txlist(MCDTxlist *txlist)
+{
+    mcd_txlist_st unmarshal = {
+        .tx = g_malloc(txlist->num_tx * sizeof(mcd_tx_st)),
+        .num_tx = txlist->num_tx,
+        .num_tx_ok = txlist->num_tx_ok,
+    };
+
+    MCDTxList *current_tx = txlist->tx;
+    for (uint32_t i = 0; i < txlist->num_tx; i++) {
+        g_assert(current_tx);
+        unmarshal.tx[i] = unmarshal_mcd_tx(current_tx->value);
+        current_tx = current_tx->next;
+    }
+
+    return unmarshal;
+}
+
+void free_mcd_txlist(mcd_txlist_st *txlist)
+{
+    if (!txlist->tx) {
+        return;
+    }
+
+    for (uint32_t i = 0; i < txlist->num_tx; i++) {
+        free_mcd_tx(txlist->tx + i);
+    }
+
+    g_free(txlist->tx);
+}
diff --git a/mcd/mcd_qapi.h b/mcd/mcd_qapi.h
index 00c1393..8e94c47 100644
--- a/mcd/mcd_qapi.h
+++ b/mcd/mcd_qapi.h
@@ -37,8 +37,22 @@ MCDRegisterInfo *marshal_mcd_register_info(
 
 MCDCoreState *marshal_mcd_core_state(const mcd_core_state_st *state);
 
+MCDTx *marshal_mcd_tx(const mcd_tx_st *tx);
+
+MCDTxlist *marshal_mcd_txlist(const mcd_txlist_st *txlist);
+
 mcd_api_version_st unmarshal_mcd_api_version(MCDAPIVersion *api_version);
 
 mcd_core_con_info_st unmarshal_mcd_core_con_info(MCDCoreConInfo *con_info);
 
+mcd_addr_st unmarshal_mcd_addr(MCDAddr *addr);
+
+mcd_tx_st unmarshal_mcd_tx(MCDTx *tx);
+
+mcd_txlist_st unmarshal_mcd_txlist(MCDTxlist *txlist);
+
+void free_mcd_tx(mcd_tx_st *tx);
+
+void free_mcd_txlist(mcd_txlist_st *txlist);
+
 #endif /* MCD_QAPI_H */
diff --git a/mcd/mcd_server.c b/mcd/mcd_server.c
index b0cf1b1..e1f90ab 100644
--- a/mcd/mcd_server.c
+++ b/mcd/mcd_server.c
@@ -1081,11 +1081,214 @@ mcd_return_et mcd_qry_trig_set_state_f(const mcd_core_st *core,
     return g_server_state.last_error->return_status;
 }
 
+static mcd_return_et execute_memory_tx(mcdcore_state *core_state, mcd_tx_st *tx,
+                                       mcd_mem_type_et type)
+{
+    MemTxResult result = MEMTX_ERROR;
+
+    /* each address space has one physical and one virtual memory */
+    int address_space_id = (tx->addr.mem_space_id - 1) / 2;
+    AddressSpace *as = cpu_get_address_space(core_state->cpu, address_space_id);
+
+    hwaddr addr = tx->addr.address;
+    hwaddr len = tx->access_width > 0 ? tx->access_width : tx->num_bytes;
+    bool is_write;
+
+    if (tx->access_type == MCD_TX_AT_R) {
+        is_write = false;
+    } else if (tx->access_type == MCD_TX_AT_W) {
+        is_write = true;
+    } else {
+        core_state->custom_error = (mcd_error_info_st) {
+            .return_status = MCD_RET_ACT_HANDLE_ERROR,
+            .error_code = MCD_ERR_TXLIST_TX,
+            .error_events = MCD_ERR_EVT_NONE,
+            .error_str = "tx access type not supported",
+        };
+        core_state->last_error = &core_state->custom_error;
+        return core_state->last_error->return_status;
+    }
+
+    if (type & MCD_MEM_SPACE_IS_PHYSICAL) {
+        MemTxAttrs attrs = {
+            .secure = !!(type & MCD_MEM_SPACE_IS_SECURE),
+            .space = address_space_id,
+        };
+
+        for (tx->num_bytes_ok = 0;
+             tx->num_bytes_ok < tx->num_bytes;
+             tx->num_bytes_ok += len) {
+            void *buf = tx->data + tx->num_bytes_ok;
+            result = address_space_rw(as, addr + tx->num_bytes_ok, attrs,
+                                      buf, len, is_write);
+            if (result != MEMTX_OK) {
+                break;
+            }
+        }
+    } else if (type & MCD_MEM_SPACE_IS_LOGICAL) {
+        for (tx->num_bytes_ok = 0;
+             tx->num_bytes_ok < tx->num_bytes;
+             tx->num_bytes_ok += len) {
+            void *buf = tx->data + tx->num_bytes_ok;
+            int ret = cpu_memory_rw_debug(core_state->cpu,
+                                          addr + tx->num_bytes_ok,
+                                          buf, len, is_write);
+            result = (ret == 0) ? MEMTX_OK : MEMTX_ERROR;
+            if (result != MEMTX_OK) {
+                break;
+            }
+        }
+    } else {
+        core_state->custom_error = (mcd_error_info_st) {
+            .return_status = MCD_RET_ACT_HANDLE_ERROR,
+            .error_code = MCD_ERR_TXLIST_TX,
+            .error_events = MCD_ERR_EVT_NONE,
+            .error_str = "unknown mem space type",
+        };
+        core_state->last_error = &core_state->custom_error;
+        return core_state->last_error->return_status;
+    }
+
+    if (result != MEMTX_OK) {
+        core_state->custom_error = (mcd_error_info_st) {
+            .return_status = MCD_RET_ACT_HANDLE_ERROR,
+            .error_code = is_write ? MCD_ERR_TXLIST_WRITE : MCD_ERR_TXLIST_READ,
+            .error_events = MCD_ERR_EVT_NONE,
+            .error_str = "",
+        };
+        snprintf(core_state->custom_error.error_str, MCD_INFO_STR_LEN,
+                 "Memory tx failed with error code %d", result);
+        core_state->last_error = &core_state->custom_error;
+        return core_state->last_error->return_status;
+    }
+
+    tx->num_bytes_ok = tx->num_bytes;
+    core_state->last_error = &MCD_ERROR_NONE;
+    return core_state->last_error->return_status;
+}
+
+static mcd_return_et execute_register_tx(mcdcore_state *core_state,
+                                         mcd_tx_st *tx)
+{
+    if (tx->access_type == MCD_TX_AT_R) {
+        GByteArray *mem_buf = g_byte_array_new();
+        int read_bytes = gdb_read_register(core_state->cpu, mem_buf,
+                                           tx->addr.address);
+        if (read_bytes > tx->num_bytes) {
+            g_byte_array_free(mem_buf, true);
+            core_state->custom_error = (mcd_error_info_st) {
+                .return_status = MCD_RET_ACT_HANDLE_ERROR,
+                .error_code = MCD_ERR_TXLIST_READ,
+                .error_events = MCD_ERR_EVT_NONE,
+                .error_str = "too many bytes read",
+            };
+            core_state->last_error = &core_state->custom_error;
+            return core_state->last_error->return_status;
+        }
+        memcpy(tx->data, mem_buf->data, read_bytes);
+        g_byte_array_free(mem_buf, true);
+        tx->num_bytes_ok = read_bytes;
+    } else if (tx->access_type == MCD_TX_AT_W) {
+        int written_bytes = gdb_write_register(core_state->cpu, tx->data,
+                                               tx->addr.address);
+        if (written_bytes > tx->num_bytes) {
+            core_state->custom_error = (mcd_error_info_st) {
+                .return_status = MCD_RET_ACT_HANDLE_ERROR,
+                .error_code = MCD_ERR_TXLIST_READ,
+                .error_events = MCD_ERR_EVT_NONE,
+                .error_str = "too many bytes written",
+            };
+            core_state->last_error = &core_state->custom_error;
+            return core_state->last_error->return_status;
+        }
+        tx->num_bytes_ok = written_bytes;
+    } else {
+        core_state->custom_error = (mcd_error_info_st) {
+            .return_status = MCD_RET_ACT_HANDLE_ERROR,
+            .error_code = MCD_ERR_TXLIST_TX,
+            .error_events = MCD_ERR_EVT_NONE,
+            .error_str = "tx access type not supported",
+        };
+        core_state->last_error = &core_state->custom_error;
+        return core_state->last_error->return_status;
+    }
+
+    core_state->last_error = &MCD_ERROR_NONE;
+    return core_state->last_error->return_status;
+}
+
+static mcd_return_et execute_tx(mcdcore_state *core_state, mcd_tx_st *tx)
+{
+    mcd_memspace_st *ms;
+
+    uint32_t ms_id = tx->addr.mem_space_id;
+    if (ms_id == 0 || ms_id > core_state->memory_spaces->len) {
+        core_state->custom_error = (mcd_error_info_st) {
+            .return_status = MCD_RET_ACT_HANDLE_ERROR,
+            .error_code = MCD_ERR_PARAM,
+            .error_events = MCD_ERR_EVT_NONE,
+            .error_str = "unknown memory space ID",
+        };
+        core_state->last_error = &core_state->custom_error;
+        return core_state->last_error->return_status;
+    }
+
+    if (tx->access_width > 0 && tx->num_bytes % tx->access_width != 0) {
+        core_state->custom_error = (mcd_error_info_st) {
+            .return_status = MCD_RET_ACT_HANDLE_ERROR,
+            .error_code = MCD_ERR_TXLIST_TX,
+            .error_events = MCD_ERR_EVT_NONE,
+            .error_str = "alignment error",
+        };
+        core_state->last_error = &core_state->custom_error;
+        return core_state->last_error->return_status;
+    }
+
+    ms = &g_array_index(core_state->memory_spaces, mcd_memspace_st, ms_id - 1);
+    if (ms->mem_type & MCD_MEM_SPACE_IS_PHYSICAL ||
+        ms->mem_type & MCD_MEM_SPACE_IS_LOGICAL) {
+        return execute_memory_tx(core_state, tx, ms->mem_type);
+    } else if (ms->mem_type & MCD_MEM_SPACE_IS_REGISTERS) {
+        return execute_register_tx(core_state, tx);
+    } else {
+        core_state->custom_error = (mcd_error_info_st) {
+            .return_status = MCD_RET_ACT_HANDLE_ERROR,
+            .error_code = MCD_ERR_TXLIST_TX,
+            .error_events = MCD_ERR_EVT_NONE,
+            .error_str = "unknown memory space type",
+        };
+        core_state->last_error = &core_state->custom_error;
+        return core_state->last_error->return_status;
+    }
+}
+
 mcd_return_et mcd_execute_txlist_f(const mcd_core_st *core,
                                    mcd_txlist_st *txlist)
 {
-    g_server_state.last_error = &MCD_ERROR_NOT_IMPLEMENTED;
-    return g_server_state.last_error->return_status;
+    mcdcore_state *core_state;
+
+    if (!core || !txlist) {
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
+    for (uint32_t i = 0; i < txlist->num_tx; i++) {
+        mcd_tx_st *tx = txlist->tx + i;
+        if (execute_tx(core_state, tx) != MCD_RET_ACT_NONE) {
+            return core_state->last_error->return_status;
+        } else {
+            txlist->num_tx_ok++;
+        }
+    }
+
+    core_state->last_error = &MCD_ERROR_NONE;
+    return core_state->last_error->return_status;
 }
 
 mcd_return_et mcd_run_f(const mcd_core_st *core, bool global)
diff --git a/mcd/mcd_stub.c b/mcd/mcd_stub.c
index 1385d6c..13bd2d0 100644
--- a/mcd/mcd_stub.c
+++ b/mcd/mcd_stub.c
@@ -517,6 +517,32 @@ MCDQryRegMapResult *qmp_mcd_qry_reg_map(uint32_t core_uid,
     return result;
 }
 
+MCDExecuteTxlistResult *qmp_mcd_execute_txlist(uint32_t core_uid,
+                                               MCDTxlist *txlist,
+                                               Error **errp)
+{
+    MCDExecuteTxlistResult *result = g_malloc0(sizeof(*result));
+    mcd_core_st *core = NULL;
+
+    result->return_status = retrieve_open_core(core_uid, &core);
+    if (result->return_status != MCD_RET_ACT_NONE) {
+        g_stub_state.on_error_ask_server = false;
+        return result;
+    }
+
+    mcd_txlist_st txlist_unmarshalled = unmarshal_mcd_txlist(txlist);
+
+    result->return_status = mcd_execute_txlist_f(core, &txlist_unmarshalled);
+
+    if (result->return_status == MCD_RET_ACT_NONE) {
+        result->txlist = marshal_mcd_txlist(&txlist_unmarshalled);
+    }
+
+    free_mcd_txlist(&txlist_unmarshalled);
+    g_stub_state.on_error_ask_server = true;
+    return result;
+}
+
 MCDRunResult *qmp_mcd_run(uint32_t core_uid, bool global, Error **errp)
 {
     MCDRunResult *result = g_malloc0(sizeof(*result));
diff --git a/qapi/mcd.json b/qapi/mcd.json
index 3560658..fabb3ee 100644
--- a/qapi/mcd.json
+++ b/qapi/mcd.json
@@ -306,6 +306,54 @@
     'reg-type'            : 'uint32',
     'hw-thread-id'        : 'uint32' } }
 
+##
+# @MCDTx:
+#
+# Structure type containing information about a single transaction.
+#
+# @addr:         The address of the first memory cell/register.
+# @access-type:  Type of access: Read/Write/Read+Write/Write+Verify.
+# @options:      Access options: burst, side-effects, alternate path, cache,
+#                etc.
+# @access-width: Access size in bytes (or 0 if access size does not matter).
+# @core-mode:    The core mode in which the access should be performed (or 0
+#                for most permissive mode).
+# @data:         Byte array of size @num-bytes storing the access data.
+# @num-bytes:    Size of the memory/register access. The buffer @data needs to
+#                be of this size.
+# @num-bytes-ok: Number of successfully received/sent bytes.
+#
+# Since: 9.1
+##
+{ 'struct': 'MCDTx',
+  'data': {
+    'addr'        : 'MCDAddr',
+    'access-type' : 'uint32',
+    'options'     : 'uint32',
+    'access-width': 'uint8',
+    'core-mode'   : 'uint8',
+    'data'        : ['uint8'],
+    'num-bytes'   : 'uint32',
+    'num-bytes-ok': 'uint32' } }
+
+
+##
+# @MCDTxlist:
+#
+# Structure type containing a transaction list.
+#
+# @tx:        Array of size @num-tx storing the transactions.
+# @num-tx:    Number of transactions.
+# @num-tx-ok: Number of transactions which succeeded without any errors.
+#
+# Since: 9.1
+##
+{ 'struct': 'MCDTxlist',
+  'data': {
+    'tx'       : ['MCDTx'],
+    'num-tx'   : 'uint32',
+    'num-tx-ok': 'uint32' } }
+
 
 ##
 # @MCDCoreState:
@@ -1403,6 +1451,41 @@
 ##
 
 
+##
+# @MCDExecuteTxlistResult:
+#
+# Return value of @mcd-execute-txlist.
+#
+# @return-status: Return code.
+# @txlist:        Transaction list after execution.
+#
+# Since: 9.1
+##
+{ 'struct': 'MCDExecuteTxlistResult',
+  'data': {
+    'return-status': 'uint32',
+    '*txlist'      : 'MCDTxlist' }}
+
+
+##
+# @mcd-execute-txlist:
+#
+# Function executing a transaction list on the target.
+#
+# @core-uid: Unique identifier of the open core as returned by @mcd-open-core.
+# @txlist:   Transaction list for execution.
+#
+# Returns: @MCDExecuteTxlistResult
+#
+# Since: 9.1
+##
+{ 'command': 'mcd-execute-txlist',
+  'data': {
+    'core-uid': 'uint32',
+    'txlist'  : 'MCDTxlist' },
+  'returns': 'MCDExecuteTxlistResult' }
+
+
 ##
 # @MCDRunResult:
 #
-- 
2.34.1


