Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB8F82ED36
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 11:56:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPh6j-0007ca-Ft; Tue, 16 Jan 2024 05:55:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rPh6g-0007cC-JD
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 05:55:46 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rPh6e-0008WK-7a
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 05:55:46 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-40e60e137aaso49373615e9.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jan 2024 02:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705402542; x=1706007342; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6Z/N//Cnzc5Uad5I2l9rZbNPtPeuC+YTxJKMvSHSdEI=;
 b=cdKH4mIpmyjqQQrLt83fo+5/KQca8wys0/WCZdLDXmNd6vbgJMli4tUDm7BLbc+GjK
 BoqkaIcLRRY/MQ1OZwn1ODEErHc3Rut8Z8VoJsqs55RNrGkF2BdlJx9Lrv2nj1kfAS3k
 pLbIDHVU5IEmkkCBM5ziyZCQE22LVfmEQxgeKG/HzPogaScfqfw1BOVTjDedudF2tfzN
 KK96zhkIhcJ6OD5cEsLWrzCbdNGZmFkSJwIIgNu/XLq5XKrt9TP+qf3lqQe5kdnt0s47
 Fo38yEvr2vW0lay+ZR6DsLUcAkSgmPtR4/pvuVo4DAfjdCsz8k9z2b7ZH/pFgp9GtaZ5
 7vMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705402542; x=1706007342;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6Z/N//Cnzc5Uad5I2l9rZbNPtPeuC+YTxJKMvSHSdEI=;
 b=pb6rGLYVvd2qu5ab3IyNrAiKhd+wLTT0bXS1+fcKaYGi0ROKVW3SL4axlfQ4W9GOmk
 pnTaNztIp2kTR1yhOI0kS6Ddx342NCuhX8zbVph8zCiM6KrX82N8y/0l+EBqecf/2I2+
 zNQ8BLpAz425mhMvNTUWoPyCZiWODolveopG710pf6Ss4lpH8Dwww7tlzZEmgNtDphB/
 ZGiD5uO2491yvgyvwphJdMuqbEY6WRU0AspCgajVaiKRJdnH/rZsNw/YAl6rGYzotxvS
 URjNF69mE/Chb5v/CWu6+hu+F8jZxM/08QsY4gtKlZSmxOXiFYbCqmOH80JdzXKJGW13
 kmNg==
X-Gm-Message-State: AOJu0Ywsy9Y8ctJbShfXCv9UYpEr/eHqfpJrEksomnYeqQvFFY6fjCUh
 h1dR5/QSBnrobCRER8e2FdL+MzAZinskK2LxdX2CkfESnEw=
X-Google-Smtp-Source: AGHT+IGpSxOVQG0Bi6Xid3pBBXIxJCh1t4eTVm6tsPdyJsO72s0kb2fjaNUT4KTLRt9n8F/urwdqPQ==
X-Received: by 2002:a7b:cb54:0:b0:40e:43f3:7e3b with SMTP id
 v20-20020a7bcb54000000b0040e43f37e3bmr3787728wmj.57.1705402542548; 
 Tue, 16 Jan 2024 02:55:42 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 fb11-20020a05600c520b00b0040e76228042sm7644690wmb.35.2024.01.16.02.55.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jan 2024 02:55:40 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2823B5F900;
 Tue, 16 Jan 2024 10:48:11 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PULL 17/22] plugins: add an API to read registers
Date: Tue, 16 Jan 2024 10:48:04 +0000
Message-Id: <20240116104809.250076-18-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240116104809.250076-1-alex.bennee@linaro.org>
References: <20240116104809.250076-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

We can only request a list of registers once the vCPU has been
initialised so the user needs to use either call the get function on
vCPU initialisation or during the translation phase.

We don't expose the reg number to the plugin instead hiding it behind
an opaque handle. This allows for a bit of future proofing should the
internals need to be changed while also being hashed against the
CPUClass so we can handle different register sets per-vCPU in
hetrogenous situations.

Having an internal state within the plugins also allows us to expand
the interface in future (for example providing callbacks on register
change if the translator can track changes).

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1706
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20240103173349.398526-39-alex.bennee@linaro.org>
Based-on: <20231025093128.33116-18-akihiko.odaki@daynix.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index 4daab6efd29..2c1930e7e45 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -11,6 +11,7 @@
 #ifndef QEMU_QEMU_PLUGIN_H
 #define QEMU_QEMU_PLUGIN_H
 
+#include <glib.h>
 #include <inttypes.h>
 #include <stdbool.h>
 #include <stddef.h>
@@ -227,8 +228,8 @@ struct qemu_plugin_insn;
  * @QEMU_PLUGIN_CB_R_REGS: callback reads the CPU's regs
  * @QEMU_PLUGIN_CB_RW_REGS: callback reads and writes the CPU's regs
  *
- * Note: currently unused, plugins cannot read or change system
- * register state.
+ * Note: currently QEMU_PLUGIN_CB_RW_REGS is unused, plugins cannot change
+ * system register state.
  */
 enum qemu_plugin_cb_flags {
     QEMU_PLUGIN_CB_NO_REGS,
@@ -708,4 +709,50 @@ uint64_t qemu_plugin_end_code(void);
 QEMU_PLUGIN_API
 uint64_t qemu_plugin_entry_code(void);
 
+/** struct qemu_plugin_register - Opaque handle for register access */
+struct qemu_plugin_register;
+
+/**
+ * typedef qemu_plugin_reg_descriptor - register descriptions
+ *
+ * @handle: opaque handle for retrieving value with qemu_plugin_read_register
+ * @name: register name
+ * @feature: optional feature descriptor, can be NULL
+ */
+typedef struct {
+    struct qemu_plugin_register *handle;
+    const char *name;
+    const char *feature;
+} qemu_plugin_reg_descriptor;
+
+/**
+ * qemu_plugin_get_registers() - return register list for vCPU
+ * @vcpu_index: vcpu to query
+ *
+ * Returns a GArray of qemu_plugin_reg_descriptor or NULL. Caller
+ * frees the array (but not the const strings).
+ *
+ * Should be used from a qemu_plugin_register_vcpu_init_cb() callback
+ * after the vCPU is initialised.
+ */
+GArray *qemu_plugin_get_registers(unsigned int vcpu_index);
+
+/**
+ * qemu_plugin_read_register() - read register
+ *
+ * @vcpu: vcpu index
+ * @handle: a @qemu_plugin_reg_handle handle
+ * @buf: A GByteArray for the data owned by the plugin
+ *
+ * This function is only available in a context that register read access is
+ * explicitly requested.
+ *
+ * Returns the size of the read register. The content of @buf is in target byte
+ * order. On failure returns -1
+ */
+int qemu_plugin_read_register(unsigned int vcpu,
+                              struct qemu_plugin_register *handle,
+                              GByteArray *buf);
+
+
 #endif /* QEMU_QEMU_PLUGIN_H */
diff --git a/plugins/api.c b/plugins/api.c
index ac39cdea0b3..8d5cca53295 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -8,6 +8,7 @@
  *
  *  qemu_plugin_tb
  *  qemu_plugin_insn
+ *  qemu_plugin_register
  *
  * Which can then be passed back into the API to do additional things.
  * As such all the public functions in here are exported in
@@ -35,10 +36,12 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/main-loop.h"
 #include "qemu/plugin.h"
 #include "qemu/log.h"
 #include "tcg/tcg.h"
 #include "exec/exec-all.h"
+#include "exec/gdbstub.h"
 #include "exec/ram_addr.h"
 #include "disas/disas.h"
 #include "plugin.h"
@@ -435,3 +438,111 @@ uint64_t qemu_plugin_entry_code(void)
 #endif
     return entry;
 }
+
+/*
+ * Register handles
+ *
+ * The plugin infrastructure keeps hold of these internal data
+ * structures which are presented to plugins as opaque handles. They
+ * are global to the system and therefor additions to the hash table
+ * must be protected by the @reg_handle_lock.
+ *
+ * In order to future proof for up-coming heterogeneous work we want
+ * different entries for each CPU type while sharing them in the
+ * common case of multiple cores of the same type.
+ */
+
+static QemuMutex reg_handle_lock;
+
+struct qemu_plugin_register {
+    const char *name;
+    int gdb_reg_num;
+};
+
+static GHashTable *reg_handles; /* hash table of PluginReg */
+
+/* Generate a stable key - would xxhash be overkill? */
+static gpointer cpu_plus_reg_to_key(CPUState *cs, int gdb_regnum)
+{
+    uintptr_t key = (uintptr_t) cs->cc;
+    key ^= gdb_regnum;
+    return GUINT_TO_POINTER(key);
+}
+
+/*
+ * Create register handles.
+ *
+ * We need to create a handle for each register so the plugin
+ * infrastructure can call gdbstub to read a register. We also
+ * construct a result array with those handles and some ancillary data
+ * the plugin might find useful.
+ */
+
+static GArray *create_register_handles(CPUState *cs, GArray *gdbstub_regs)
+{
+    GArray *find_data = g_array_new(true, true,
+                                    sizeof(qemu_plugin_reg_descriptor));
+
+    WITH_QEMU_LOCK_GUARD(&reg_handle_lock) {
+
+        if (!reg_handles) {
+            reg_handles = g_hash_table_new(g_direct_hash, g_direct_equal);
+        }
+
+        for (int i = 0; i < gdbstub_regs->len; i++) {
+            GDBRegDesc *grd = &g_array_index(gdbstub_regs, GDBRegDesc, i);
+            gpointer key = cpu_plus_reg_to_key(cs, grd->gdb_reg);
+            struct qemu_plugin_register *val = g_hash_table_lookup(reg_handles,
+                                                                   key);
+
+            /* skip "un-named" regs */
+            if (!grd->name) {
+                continue;
+            }
+
+            /* Doesn't exist, create one */
+            if (!val) {
+                val = g_new0(struct qemu_plugin_register, 1);
+                val->gdb_reg_num = grd->gdb_reg;
+                val->name = g_intern_string(grd->name);
+
+                g_hash_table_insert(reg_handles, key, val);
+            }
+
+            /* Create a record for the plugin */
+            qemu_plugin_reg_descriptor desc = {
+                .handle = val,
+                .name = val->name,
+                .feature = g_intern_string(grd->feature_name)
+            };
+            g_array_append_val(find_data, desc);
+        }
+    }
+
+    return find_data;
+}
+
+GArray *qemu_plugin_get_registers(unsigned int vcpu)
+{
+    CPUState *cs = qemu_get_cpu(vcpu);
+    if (cs) {
+        g_autoptr(GArray) regs = gdb_get_register_list(cs);
+        return regs->len ? create_register_handles(cs, regs) : NULL;
+    } else {
+        return NULL;
+    }
+}
+
+int qemu_plugin_read_register(unsigned int vcpu,
+                              struct qemu_plugin_register *reg, GByteArray *buf)
+{
+    CPUState *cs = qemu_get_cpu(vcpu);
+    /* assert with debugging on? */
+    return gdb_read_register(cs, buf, reg->gdb_reg_num);
+}
+
+static void __attribute__((__constructor__)) qemu_api_init(void)
+{
+    qemu_mutex_init(&reg_handle_lock);
+
+}
diff --git a/plugins/qemu-plugins.symbols b/plugins/qemu-plugins.symbols
index 71f6c90549d..6963585c1ea 100644
--- a/plugins/qemu-plugins.symbols
+++ b/plugins/qemu-plugins.symbols
@@ -3,6 +3,7 @@
   qemu_plugin_end_code;
   qemu_plugin_entry_code;
   qemu_plugin_get_hwaddr;
+  qemu_plugin_get_registers;
   qemu_plugin_hwaddr_device_name;
   qemu_plugin_hwaddr_is_io;
   qemu_plugin_hwaddr_phys_addr;
@@ -20,6 +21,7 @@
   qemu_plugin_n_vcpus;
   qemu_plugin_outs;
   qemu_plugin_path_to_binary;
+  qemu_plugin_read_register;
   qemu_plugin_register_atexit_cb;
   qemu_plugin_register_flush_cb;
   qemu_plugin_register_vcpu_exit_cb;
-- 
2.39.2


