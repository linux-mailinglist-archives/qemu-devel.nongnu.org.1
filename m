Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F7A8311BC
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 04:24:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQJ10-0003XX-6h; Wed, 17 Jan 2024 22:24:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rQJ0y-0003X9-2M
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 22:24:24 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rQJ0v-0002WT-UY
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 22:24:23 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40e80046264so38494705e9.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 19:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705548259; x=1706153059; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z1Wm3BuytIxY9I50Ihr9Vi6BnC2ipwOgCPrtejpdauQ=;
 b=O5ySr9os8TLR/qM4/TA+ces7YWDh+QJJ3N1meCTKQducr4CwgVI2IRyKoxK0qyv4pA
 JpXccWnT0bekvVMJQH4KoQjpXi+13tG3dhCHNBuzHfmyAGeyQICy7Ss1EQvVm1dDvHE8
 fMJkCUnuVdNtSGwKI/I+C45lD3jUGgHerQaRLmFWGMsJM/q5hNybMLlnATRTP7NVPsxi
 xCbu0dtblIRgWccbP6/I+zH2XiJM3Gi8I/sjYSI1yGshbYRMwaYnpH2ZvcO2PJwesr7o
 HPyiZVZFjdYRGdyC6yHDSMa82i4ndgYo8qn9UBdMse+jnhX0BTd0K9wmTTbSyNHN+cH1
 nE2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705548259; x=1706153059;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z1Wm3BuytIxY9I50Ihr9Vi6BnC2ipwOgCPrtejpdauQ=;
 b=cdqlkTlsegh+u4WdOxfQhQQX2QTyDGJntsdjUw4luiz28sxd1XC2n7F4fiorWwBtK2
 +/sP7O7ySk/hEbG+SS/fITAMX7UWDYG9pN3LjzR1C0guEhlP+4tiFbNaafEqRhMgZyk2
 XGOTP6Xv4zIPnKI9b0Er7dI5OhxmFMYHB44zyJ/5XVMC7ocutZEqj9LN35+15IQqNeQ+
 yc60s7yMcIrLJfvI3pAaCmpMigfXufCKwXV2c/CwhqQfWz4Xxdm9b2Bb+/Sdgr/x1KBx
 qvHVkszkbrWQ0DpSHh+nCSt2D5o37GMB4sl5LUnyzMSbsVc3sjHuWDco9NvZ3twc6r+u
 TAkw==
X-Gm-Message-State: AOJu0Ywom3LMvPOI2egvGYZoP0jxO9k9avklHLTFzePgz4fJE33TYBDR
 8aMAXBRkvdasEJEJMD9kU1quoGenegUK0HplNmGP2mNYqj6aZJJ/uul77ZYOdJKoiqeDc4dwgYx
 4VkA=
X-Google-Smtp-Source: AGHT+IE+MXoQIAc6RqJjwcJXwy+fu2U38ishVeuiM66Xy3VHgYOjWKXXrZ45/FN0Ppjh5g6BiFijEQ==
X-Received: by 2002:a05:6000:1086:b0:337:2940:ab7b with SMTP id
 y6-20020a056000108600b003372940ab7bmr98965wrw.1.1705548259665; 
 Wed, 17 Jan 2024 19:24:19 -0800 (PST)
Received: from linaro.. ([102.35.208.160]) by smtp.gmail.com with ESMTPSA id
 i2-20020adff302000000b0033788e357e1sm2894292wro.108.2024.01.17.19.24.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jan 2024 19:24:19 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH v2 02/14] plugins: scoreboard API
Date: Thu, 18 Jan 2024 07:23:47 +0400
Message-ID: <20240118032400.3762658-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240118032400.3762658-1-pierrick.bouvier@linaro.org>
References: <20240118032400.3762658-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wm1-x335.google.com
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

We introduce a cpu local storage, automatically managed (and extended)
by QEMU itself. Plugin allocate a scoreboard, and don't have to deal
with how many cpus are launched.

This API will be used by new inline functions but callbacks can benefit
from this as well. This way, they can operate without a global lock for
simple operations.

New functions:
- qemu_plugin_scoreboard_free
- qemu_plugin_scoreboard_get
- qemu_plugin_scoreboard_new
- qemu_plugin_scoreboard_size

In more, we define a qemu_plugin_u64_t, which is a simple struct holding
a pointer to a scoreboard, and a given offset.
This allows to have a scoreboard containing structs, without having to
bring offset for all operations on a specific field.

Since most of the plugins are simply collecting a sum of per-cpu values,
qemu_plugin_u64_t directly support this operation as well.

New functions:
- qemu_plugin_u64_get
- qemu_plugin_u64_sum
New macros:
- qemu_plugin_u64
- qemu_plugin_u64_struct

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/qemu/plugin.h        |  7 +++
 include/qemu/qemu-plugin.h   | 75 ++++++++++++++++++++++++++++
 plugins/api.c                | 39 +++++++++++++++
 plugins/core.c               | 97 ++++++++++++++++++++++++++++++++++++
 plugins/plugin.h             |  8 +++
 plugins/qemu-plugins.symbols |  6 +++
 6 files changed, 232 insertions(+)

diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
index 9346249145d..5f340192e56 100644
--- a/include/qemu/plugin.h
+++ b/include/qemu/plugin.h
@@ -115,6 +115,13 @@ struct qemu_plugin_insn {
     bool mem_only;
 };
 
+/* A scoreboard is an array of values, indexed by vcpu_index */
+struct qemu_plugin_scoreboard {
+    GArray *data;
+    size_t size;
+    size_t element_size;
+};
+
 /*
  * qemu_plugin_insn allocate and cleanup functions. We don't expect to
  * cleanup many of these structures. They are reused for each fresh
diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index 2c1930e7e45..934059d64c2 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -220,6 +220,23 @@ void qemu_plugin_register_vcpu_resume_cb(qemu_plugin_id_t id,
 struct qemu_plugin_tb;
 /** struct qemu_plugin_insn - Opaque handle for a translated instruction */
 struct qemu_plugin_insn;
+/**
+ * struct qemu_plugin_scoreboard - Opaque handle for a scoreboard
+ *
+ * A scoreboard is an array of data, indexed by vcpu_index.
+ **/
+struct qemu_plugin_scoreboard;
+
+/**
+ * qemu_plugin_u64_t - uint64_t member of an entry in a scoreboard
+ *
+ * This field allows to access a specific uint64_t member in one given entry,
+ * located at a specified offset. Inline operations expect this as entry.
+ */
+typedef struct qemu_plugin_u64 {
+    struct qemu_plugin_scoreboard *score;
+    size_t offset;
+} qemu_plugin_u64_t;
 
 /**
  * enum qemu_plugin_cb_flags - type of callback
@@ -754,5 +771,63 @@ int qemu_plugin_read_register(unsigned int vcpu,
                               struct qemu_plugin_register *handle,
                               GByteArray *buf);
 
+/**
+ * qemu_plugin_scoreboard_new() - alloc a new scoreboard
+ *
+ * Returns a pointer to a new scoreboard. It must be freed using
+ * qemu_plugin_scoreboard_free.
+ */
+QEMU_PLUGIN_API
+struct qemu_plugin_scoreboard *qemu_plugin_scoreboard_new(size_t element_size);
+
+/**
+ * qemu_plugin_scoreboard_free() - free a scoreboard
+ * @score: scoreboard to free
+ */
+QEMU_PLUGIN_API
+void qemu_plugin_scoreboard_free(struct qemu_plugin_scoreboard *score);
+
+/**
+ * qemu_plugin_scoreboard_size() - return size of a scoreboard
+ * @score: scoreboard to query
+ */
+QEMU_PLUGIN_API
+size_t qemu_plugin_scoreboard_size(struct qemu_plugin_scoreboard *score);
+
+/**
+ * qemu_plugin_scoreboard_get() - access value from a scoreboard
+ * @score: scoreboard to query
+ * @vcpu_index: entry index
+ *
+ * Returns address of entry of a scoreboard matching a given vcpu_index. This
+ * address can be modified later if scoreboard is resized.
+ */
+QEMU_PLUGIN_API
+void *qemu_plugin_scoreboard_get(struct qemu_plugin_scoreboard *score,
+                                 unsigned int vcpu_index);
+
+/* Macros to define a qemu_plugin_u64_t */
+#define qemu_plugin_u64(score) \
+    (qemu_plugin_u64_t){score, 0}
+#define qemu_plugin_u64_struct(score, type, member) \
+    (qemu_plugin_u64_t){score, offsetof(type, member)}
+
+/**
+ * qemu_plugin_u64_get() - access specific uint64_t in a scoreboard
+ * @entry: entry to query
+ * @vcpu_index: entry index
+ *
+ * Returns address of a specific member in a scoreboard entry, matching a given
+ * vcpu_index.
+ */
+QEMU_PLUGIN_API
+uint64_t *qemu_plugin_u64_get(qemu_plugin_u64_t entry, unsigned int vcpu_index);
+
+/**
+ * qemu_plugin_u64_sum() - return sum of all values in a scoreboard
+ * @entry: entry to sum
+ */
+QEMU_PLUGIN_API
+uint64_t qemu_plugin_u64_sum(qemu_plugin_u64_t entry);
 
 #endif /* QEMU_QEMU_PLUGIN_H */
diff --git a/plugins/api.c b/plugins/api.c
index e777eb4e9fc..4de94e798c6 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -547,3 +547,42 @@ static void __attribute__((__constructor__)) qemu_api_init(void)
     qemu_mutex_init(&reg_handle_lock);
 
 }
+
+struct qemu_plugin_scoreboard *qemu_plugin_scoreboard_new(size_t element_size)
+{
+    return plugin_scoreboard_new(element_size);
+}
+
+void qemu_plugin_scoreboard_free(struct qemu_plugin_scoreboard *score)
+{
+    plugin_scoreboard_free(score);
+}
+
+size_t qemu_plugin_scoreboard_size(struct qemu_plugin_scoreboard *score)
+{
+    return score->size;
+}
+
+void *qemu_plugin_scoreboard_get(struct qemu_plugin_scoreboard *score,
+                                 unsigned int vcpu_index)
+{
+    g_assert(vcpu_index < qemu_plugin_scoreboard_size(score));
+    char *ptr = score->data->data;
+    return ptr + vcpu_index * score->element_size;
+}
+
+uint64_t *qemu_plugin_u64_get(qemu_plugin_u64_t entry,
+                                         unsigned int vcpu_index)
+{
+    char *ptr = (char *) qemu_plugin_scoreboard_get(entry.score, vcpu_index);
+    return (uint64_t *)(ptr + entry.offset);
+}
+
+uint64_t qemu_plugin_u64_sum(qemu_plugin_u64_t entry)
+{
+    uint64_t total = 0;
+    for (int i = 0; i < qemu_plugin_scoreboard_size(entry.score); ++i) {
+        total += *qemu_plugin_u64_get(entry, i);
+    }
+    return total;
+}
diff --git a/plugins/core.c b/plugins/core.c
index e07b9cdf229..0286a127810 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -209,6 +209,71 @@ plugin_register_cb_udata(qemu_plugin_id_t id, enum qemu_plugin_event ev,
     do_plugin_register_cb(id, ev, func, udata);
 }
 
+struct resize_scoreboard_args {
+    size_t new_alloc_size;
+    size_t new_size;
+};
+
+static void plugin_resize_one_scoreboard(gpointer key,
+                                         gpointer value,
+                                         gpointer user_data)
+{
+    struct qemu_plugin_scoreboard *score =
+        (struct qemu_plugin_scoreboard *) value;
+    struct resize_scoreboard_args *args =
+        (struct resize_scoreboard_args *) user_data;
+    if (score->data->len != args->new_alloc_size) {
+        g_array_set_size(score->data, args->new_alloc_size);
+    }
+    score->size = args->new_size;
+}
+
+static void plugin_grow_scoreboards__locked(CPUState *cpu)
+{
+    if (cpu->cpu_index < plugin.scoreboard_size) {
+        return;
+    }
+
+    bool need_realloc = FALSE;
+    while (cpu->cpu_index >= plugin.scoreboard_alloc_size) {
+        plugin.scoreboard_alloc_size *= 2;
+        need_realloc = TRUE;
+    }
+    plugin.scoreboard_size = cpu->cpu_index + 1;
+    g_assert(plugin.scoreboard_size <= plugin.scoreboard_alloc_size);
+
+    if (g_hash_table_size(plugin.scoreboards) == 0) {
+        /* nothing to do, we just updated sizes for future scoreboards */
+        return;
+    }
+
+    if (need_realloc) {
+#ifdef CONFIG_USER_ONLY
+        /**
+         * cpus must be stopped, as some tb might still use an existing
+         * scoreboard.
+         */
+        start_exclusive();
+#endif
+    }
+
+    struct resize_scoreboard_args args = {
+        .new_alloc_size = plugin.scoreboard_alloc_size,
+        .new_size = plugin.scoreboard_size
+    };
+    g_hash_table_foreach(plugin.scoreboards,
+                         &plugin_resize_one_scoreboard,
+                         &args);
+
+    if (need_realloc) {
+        /* force all tb to be flushed, as scoreboard pointers were changed. */
+        tb_flush(cpu);
+#ifdef CONFIG_USER_ONLY
+        end_exclusive();
+#endif
+    }
+}
+
 void qemu_plugin_vcpu_init_hook(CPUState *cpu)
 {
     bool success;
@@ -218,6 +283,7 @@ void qemu_plugin_vcpu_init_hook(CPUState *cpu)
     success = g_hash_table_insert(plugin.cpu_ht, &cpu->cpu_index,
                                   &cpu->cpu_index);
     g_assert(success);
+    plugin_grow_scoreboards__locked(cpu);
     qemu_rec_mutex_unlock(&plugin.lock);
 
     plugin_vcpu_cb__simple(cpu, QEMU_PLUGIN_EV_VCPU_INIT);
@@ -576,8 +642,39 @@ static void __attribute__((__constructor__)) plugin_init(void)
     qemu_rec_mutex_init(&plugin.lock);
     plugin.id_ht = g_hash_table_new(g_int64_hash, g_int64_equal);
     plugin.cpu_ht = g_hash_table_new(g_int_hash, g_int_equal);
+    plugin.scoreboards = g_hash_table_new(g_int64_hash, g_int64_equal);
+    plugin.scoreboard_size = 1;
+    plugin.scoreboard_alloc_size = 16; /* avoid frequent reallocation */
     QTAILQ_INIT(&plugin.ctxs);
     qht_init(&plugin.dyn_cb_arr_ht, plugin_dyn_cb_arr_cmp, 16,
              QHT_MODE_AUTO_RESIZE);
     atexit(qemu_plugin_atexit_cb);
 }
+
+struct qemu_plugin_scoreboard *plugin_scoreboard_new(size_t element_size)
+{
+    struct qemu_plugin_scoreboard *score =
+        g_malloc0(sizeof(struct qemu_plugin_scoreboard));
+    score->data = g_array_new(FALSE, TRUE, element_size);
+    g_array_set_size(score->data, plugin.scoreboard_alloc_size);
+    score->size = plugin.scoreboard_size;
+    score->element_size = element_size;
+
+    qemu_rec_mutex_lock(&plugin.lock);
+    bool inserted = g_hash_table_insert(plugin.scoreboards, score, score);
+    g_assert(inserted);
+    qemu_rec_mutex_unlock(&plugin.lock);
+
+    return score;
+}
+
+void plugin_scoreboard_free(struct qemu_plugin_scoreboard *score)
+{
+    qemu_rec_mutex_lock(&plugin.lock);
+    bool removed = g_hash_table_remove(plugin.scoreboards, score);
+    g_assert(removed);
+    qemu_rec_mutex_unlock(&plugin.lock);
+
+    g_array_free(score->data, TRUE);
+    g_free(score);
+}
diff --git a/plugins/plugin.h b/plugins/plugin.h
index 2c278379b70..99829c40886 100644
--- a/plugins/plugin.h
+++ b/plugins/plugin.h
@@ -31,6 +31,10 @@ struct qemu_plugin_state {
      * but with the HT we avoid adding a field to CPUState.
      */
     GHashTable *cpu_ht;
+    /* Scoreboards, indexed by their addresses. */
+    GHashTable *scoreboards;
+    size_t scoreboard_size;
+    size_t scoreboard_alloc_size;
     DECLARE_BITMAP(mask, QEMU_PLUGIN_EV_MAX);
     /*
      * @lock protects the struct as well as ctx->uninstalling.
@@ -99,4 +103,8 @@ void plugin_register_vcpu_mem_cb(GArray **arr,
 
 void exec_inline_op(struct qemu_plugin_dyn_cb *cb, int cpu_index);
 
+struct qemu_plugin_scoreboard *plugin_scoreboard_new(size_t element_size);
+
+void plugin_scoreboard_free(struct qemu_plugin_scoreboard *score);
+
 #endif /* PLUGIN_H */
diff --git a/plugins/qemu-plugins.symbols b/plugins/qemu-plugins.symbols
index 6963585c1ea..93866d1b5f2 100644
--- a/plugins/qemu-plugins.symbols
+++ b/plugins/qemu-plugins.symbols
@@ -38,10 +38,16 @@
   qemu_plugin_register_vcpu_tb_exec_inline;
   qemu_plugin_register_vcpu_tb_trans_cb;
   qemu_plugin_reset;
+  qemu_plugin_scoreboard_free;
+  qemu_plugin_scoreboard_get;
+  qemu_plugin_scoreboard_new;
+  qemu_plugin_scoreboard_size;
   qemu_plugin_start_code;
   qemu_plugin_tb_get_insn;
   qemu_plugin_tb_n_insns;
   qemu_plugin_tb_vaddr;
+  qemu_plugin_u64_get;
+  qemu_plugin_u64_sum;
   qemu_plugin_uninstall;
   qemu_plugin_vcpu_for_each;
 };
-- 
2.43.0


