Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D11549E6864
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Dec 2024 09:01:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJTG6-0007em-3v; Fri, 06 Dec 2024 03:00:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1tJTG2-0007bq-73
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 03:00:14 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1tJTFz-0005mc-Ft
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 03:00:13 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-7252b7326f4so1521433b3a.2
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 00:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733472009; x=1734076809; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cip0LPHBoehxlgnIZ9C55yYW9ZMranVZsujGiSNdgNE=;
 b=gvYV6u3jFjm51ljvOKzhApKFBk8cbrkAmJ+IzgEnYLwPpAZQXkkbz3KCUHck1rveOs
 bPC+P0LNKVnhDHUdU9c7fZWCs5RvC0CcEhinSsNomumlawZYBdLGMq+YnYeBAho3A5X0
 OhUN858jKkbHgf17snAQjdJdPT7K5MDoon/eV4h0rSWtlNzcy+hS98g9pAcyO332aMNt
 qYQkRhN20WuA8eib/4jwc37h84c2W6nXe9YmZabNQ0janCU1P3dfNyl4HLfpbq7P1dkk
 f2LUKBepq4zNlr10a7S3MXIh0BYA9X7+H+3OeRxGEoOeS8GM3q5QDlpGIPKuOM9z5iXl
 vC2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733472009; x=1734076809;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cip0LPHBoehxlgnIZ9C55yYW9ZMranVZsujGiSNdgNE=;
 b=R8QN9olgz2oSst0c77EPSMHvf8hOjnsvXuKDZkwT8pCwUVzdqdYqiaOIUyk7yZGyAT
 MF4BKydeqGdwC3fAE7h9JDEpXftUKKqx+VFnGb7yDrhE++hmbkvfEWKj1A5NyGm0a0/6
 nYZ68Oya/v1ZSm1DIgCc/lJOFAGqCkrnlQ6pBAPdpx4OeYmNYWmz47ot/yMyrZGoC3Cz
 YDOrtOUyfc2kgwTrLefMgcg1upd1MD2T3v6NqppozOu0ID4ubMJUuVOpoVa+U2k0l9rq
 wOZp7Lhkq25z3BEFvZgmKzM5C5MEn1eDGKF8u4I7xOw5mjFjgu6aBoO+XE/XsskTJrXH
 o9wQ==
X-Gm-Message-State: AOJu0YzQPoibHMXkWwZp+WqTThT/7Jo8fQP4tg6PkU2JoiZJPm3SewnO
 wXqX8HCKvanewlMMAbUbmhmEu1pjXmn6H9M/KKU0ijU4d3fVkxEQ014dyCck6mg=
X-Gm-Gg: ASbGncsN6OnQJjYMrUe3Fit+61GAoOenF55ALx7zoYObCjfvD5+xEb992bcpRDAz8cd
 BAnjxUyjBCwBL2ioM8sTzPdSy4h4Q2+asqIrYHaj2a8FyBjSjf6q1R+Zz3YUsYEEjG9esLbUQey
 gQSdPlfwm+99sUarSXwaThQ4tIolah3CNGNNmErMkwdE834UcO9FdFiig8D3jU8EOaMOls0P+yt
 XStTahiken5RB9iaHkrhprgr9YsyqN9cWtj6fm2y/JNpyU=
X-Google-Smtp-Source: AGHT+IFeaI/+19fft7Y2bFyT8MXQ9gsNU9IbLO9oT4FUPqczxYi60aa2fiGlXb7b+ErgqcpvYcvZiA==
X-Received: by 2002:a17:903:11c8:b0:215:4a31:47d8 with SMTP id
 d9443c01a7336-21614d1ef5emr29395825ad.9.1733472008636; 
 Fri, 06 Dec 2024 00:00:08 -0800 (PST)
Received: from chaos.lan ([50.39.253.148]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-215f8e5f601sm23527525ad.73.2024.12.06.00.00.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 00:00:08 -0800 (PST)
From: Rowan Hart <rowanbhart@gmail.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, novafacing <rowanbhart@gmail.com>
Subject: [PATCH 2/2] Add plugin API functions for register R/W, hwaddr R/W,
 vaddr W
Date: Fri,  6 Dec 2024 00:00:04 -0800
Message-ID: <20241206080005.775275-3-rowanbhart@gmail.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241206080005.775275-1-rowanbhart@gmail.com>
References: <20241206080005.775275-1-rowanbhart@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=rowanbhart@gmail.com; helo=mail-pf1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: novafacing <rowanbhart@gmail.com>

---
 include/qemu/qemu-plugin.h | 116 +++++++++++++++++++++++++++++++++----
 plugins/api.c              |  66 ++++++++++++++++++++-
 2 files changed, 168 insertions(+), 14 deletions(-)

diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index 0fba36ae02..b812593e7f 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -65,11 +65,18 @@ typedef uint64_t qemu_plugin_id_t;
  *
  * version 4:
  * - added qemu_plugin_read_memory_vaddr
+ *
+ * version 5:
+ * - added qemu_plugin_write_memory_vaddr
+ * - added qemu_plugin_read_memory_hwaddr
+ * - added qemu_plugin_write_memory_hwaddr
+ * - added qemu_plugin_write_register
+ *
  */
 
 extern QEMU_PLUGIN_EXPORT int qemu_plugin_version;
 
-#define QEMU_PLUGIN_VERSION 4
+#define QEMU_PLUGIN_VERSION 5
 
 /**
  * struct qemu_info_t - system information for plugins
@@ -255,8 +262,6 @@ typedef struct {
  * @QEMU_PLUGIN_CB_R_REGS: callback reads the CPU's regs
  * @QEMU_PLUGIN_CB_RW_REGS: callback reads and writes the CPU's regs
  *
- * Note: currently QEMU_PLUGIN_CB_RW_REGS is unused, plugins cannot change
- * system register state.
  */
 enum qemu_plugin_cb_flags {
     QEMU_PLUGIN_CB_NO_REGS,
@@ -893,6 +898,41 @@ typedef struct {
 QEMU_PLUGIN_API
 GArray *qemu_plugin_get_registers(void);
 
+/**
+ * qemu_plugin_read_register() - read register for current vCPU
+ *
+ * @handle: a @qemu_plugin_reg_handle handle
+ * @buf: A GByteArray for the data owned by the plugin
+ *
+ * This function is only available in a context that register read access is
+ * explicitly requested via the QEMU_PLUGIN_CB_R_REGS flag.
+ *
+ * Returns the size of the read register. The content of @buf is in target byte
+ * order. On failure returns -1.
+ */
+QEMU_PLUGIN_API
+int qemu_plugin_read_register(struct qemu_plugin_register *handle,
+                              GByteArray *buf);
+
+/**
+ * qemu_plugin_write_register() - write register for current vCPU
+ *
+ * @handle: a @qemu_plugin_reg_handle handle
+ * @buf: A GByteArray for the data owned by the plugin
+ *
+ * This function is only available in a context that register write access is
+ * explicitly requested via the QEMU_PLUGIN_CB_W_REGS flag.
+ *
+ * The size of @buf must be at least the size of the requested register.
+ * Attempting to write a register with @buf smaller than the register size
+ * will result in a crash or other undesired behavior.
+ *
+ * Returns the number of bytes written. On failure returns 0.
+ */
+QEMU_PLUGIN_API
+int qemu_plugin_write_register(struct qemu_plugin_register *handle,
+                              GByteArray *buf);
+
 /**
  * qemu_plugin_read_memory_vaddr() - read from memory using a virtual address
  *
@@ -916,20 +956,72 @@ bool qemu_plugin_read_memory_vaddr(uint64_t addr,
                                    GByteArray *data, size_t len);
 
 /**
- * qemu_plugin_read_register() - read register for current vCPU
+ * qemu_plugin_write_memory_vaddr() - write to memory using a virtual address
  *
- * @handle: a @qemu_plugin_reg_handle handle
- * @buf: A GByteArray for the data owned by the plugin
+ * @addr: A virtual address to write to 
+ * @data: A byte array containing the data to write
  *
- * This function is only available in a context that register read access is
- * explicitly requested via the QEMU_PLUGIN_CB_R_REGS flag.
+ * The contents of @data will be written to memory starting at the virtual
+ * address @addr.
  *
- * Returns the size of the read register. The content of @buf is in target byte
- * order. On failure returns -1.
+ * This function does not guarantee consistency of writes, nor does it ensure
+ * that pending writes are flushed either before or after the write takes
+ * place, so callers should take care when calling this function in plugin
+ * callbacks to avoid depending on the existence of data written using this
+ * function which may be overwritten afterward.
+ *
+ * Returns true on success and false on failure.
  */
 QEMU_PLUGIN_API
-int qemu_plugin_read_register(struct qemu_plugin_register *handle,
-                              GByteArray *buf);
+bool qemu_plugin_write_memory_vaddr(uint64_t addr,
+                                   GByteArray *data);
+
+/**
+ * qemu_plugin_read_memory_vaddr() - read from memory using a hardware address
+ *
+ * @addr: A virtual address to read from
+ * @data: A byte array to store data into
+ * @len: The number of bytes to read, starting from @addr
+ *
+ * @len bytes of data is read starting at @addr and stored into @data. If @data
+ * is not large enough to hold @len bytes, it will be expanded to the necessary
+ * size, reallocating if necessary. @len must be greater than 0.
+ *
+ * This function does not ensure writes are flushed prior to reading, so
+ * callers should take care when calling this function in plugin callbacks to
+ * avoid attempting to read data which may not yet be written and should use
+ * the memory callback API instead.
+ *
+ * This function is only valid for softmmu targets.
+ *
+ * Returns true on success and false on failure.
+ */
+QEMU_PLUGIN_API
+bool qemu_plugin_read_memory_hwaddr(uint64_t addr,
+                                   GByteArray *data, size_t len);
+
+/**
+ * qemu_plugin_write_memory_vaddr() - write to memory using a hardware address
+ *
+ * @addr: A virtual address to write to 
+ * @data: A byte array containing the data to write
+ *
+ * The contents of @data will be written to memory starting at the hardware
+ * address @addr.
+ *
+ * This function does not guarantee consistency of writes, nor does it ensure
+ * that pending writes are flushed either before or after the write takes
+ * place, so callers should take care when calling this function in plugin
+ * callbacks to avoid depending on the existence of data written using this
+ * function which may be overwritten afterward.
+ *
+ * This function is only valid for softmmu targets.
+ *
+ * Returns true on success and false on failure.
+ */
+QEMU_PLUGIN_API
+bool qemu_plugin_write_memory_hwaddr(uint64_t addr,
+                                   GByteArray *data);
 
 /**
  * qemu_plugin_scoreboard_new() - alloc a new scoreboard
diff --git a/plugins/api.c b/plugins/api.c
index 24ea64e2de..4a84cf4dfe 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -560,6 +560,24 @@ GArray *qemu_plugin_get_registers(void)
     return create_register_handles(regs);
 }
 
+int qemu_plugin_read_register(struct qemu_plugin_register *reg, GByteArray *buf)
+{
+    g_assert(current_cpu);
+
+    return gdb_read_register(current_cpu, buf, GPOINTER_TO_INT(reg) - 1);
+}
+
+int qemu_plugin_write_register(struct qemu_plugin_register *reg, GByteArray *buf)
+{
+    g_assert(current_cpu);
+
+    if (buf->len == 0) {
+        return 0;
+    }
+
+    return gdb_write_register(current_cpu, buf->data, GPOINTER_TO_INT(reg) - 1);
+}
+
 bool qemu_plugin_read_memory_vaddr(vaddr addr, GByteArray *data, size_t len)
 {
     g_assert(current_cpu);
@@ -580,13 +598,57 @@ bool qemu_plugin_read_memory_vaddr(vaddr addr, GByteArray *data, size_t len)
     return true;
 }
 
-int qemu_plugin_read_register(struct qemu_plugin_register *reg, GByteArray *buf)
+bool qemu_plugin_write_memory_vaddr(vaddr addr, GByteArray *data)
 {
     g_assert(current_cpu);
 
-    return gdb_read_register(current_cpu, buf, GPOINTER_TO_INT(reg) - 1);
+    if (data->len == 0) {
+        return false;
+    }
+
+    int result = cpu_memory_rw_debug(current_cpu, addr, data->data,
+                                     data->len, true);
+
+    if (result < 0) {
+        return false;
+    }
+
+    return true;
+}
+
+bool qemu_plugin_read_memory_hwaddr(hwaddr addr, GByteArray *data, size_t len)
+{
+#ifdef CONFIG_SOFTMMU
+    if (len == 0) {
+        return false;
+    }
+
+    g_byte_array_set_size(data, len);
+
+    cpu_physical_memory_rw(addr, data->data, data->len, false);
+
+    return true;
+#else
+    return false;
+#endif
 }
 
+bool qemu_plugin_write_memory_hwaddr(hwaddr addr, GByteArray *data)
+{
+#ifdef CONFIG_SOFTMMU
+    if (data->len == 0) {
+        return false;
+    }
+
+    cpu_physical_memory_rw(addr, data->data, data->len, true);
+
+    return true;
+#else
+    return false;
+#endif
+}
+
+
 struct qemu_plugin_scoreboard *qemu_plugin_scoreboard_new(size_t element_size)
 {
     return plugin_scoreboard_new(element_size);
-- 
2.46.1


