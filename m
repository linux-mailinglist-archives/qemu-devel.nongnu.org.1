Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A75B179C7EC
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 09:16:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfxaC-0003Bj-3p; Tue, 12 Sep 2023 03:13:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qfxaA-0003BQ-9C
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 03:13:10 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qfxa6-0006ff-Lo
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 03:13:10 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-68c576d35feso5123048b3a.2
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 00:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1694502785; x=1695107585;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o9oVdd+t06nDVDslKXpymgoxS7/FxbKmqvjq+wOi+FM=;
 b=T/h4KT3QcitXrn7BIUvizkP+3mf1EjU7m1mhBk6vN2FVpavRkybMfh8zwzbaG34T6U
 7PwuvEO/z24uOcqEYVICPIoAJkj6vaZuzF15Iv0avDmL3hM4YfXbrfVpzNq3ZWRo/PDO
 39/pQoWZDP6cEAaxi2dyJmVrbjrGCGGQNar7xu8l/cpYdg/5xvY6H9h95fkWC1bOEMBR
 YpYpQRLUBXCdvHD4K6wA0v/u1LFqNlSmbL/VQI9iq9Pq4zOmtxYIwHFysA7GLBW6HQIY
 748RK/ftf5te5WHuBQASKESmNzbD2klKzHNgiKF4TidLlBEvIwytebfKiS5cd8q0YrcO
 tHmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694502785; x=1695107585;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o9oVdd+t06nDVDslKXpymgoxS7/FxbKmqvjq+wOi+FM=;
 b=wVuSg7B/pPDvnqe9Wnb8ldWLNK6vAy00XvawfZDoU3sH5NoLhbOQxnsTBFrGJ89kg9
 wueWaMix7vdIg2+fRM5lUDeOIvrkP07nKXE5lQ7FXXSqNciqEgKie+/C9+thXaOQx4e7
 ym9qU6upyj9rUYt/P1/MXg0q6se0axjSavdNTz5Y3zGZKqE6mkEvDZX5GuSbRR1lylTn
 f21O6ZO2GTTUTmGzJxgrCbYUEwAgDvdAqoe1YILJhh/WiOjiYvyDK5OJPxkD3WYEC+YZ
 h5Iuj4wahojP28VtpeikvrHVxbd2BX+5osAtWQRfW1wuXHFfVngpyMvBhu0FXFKEZ5Qc
 v0Nw==
X-Gm-Message-State: AOJu0Yxjgg5chrTsjXHxyYctLfZM8mygn6NPiFfVM+kzu5INYIsG0zjn
 2SrZZYKJVQ7EUCpT9S9W9VlGqA==
X-Google-Smtp-Source: AGHT+IGwG7624LdctCwuuFLJvrUXLa/I/0ChrWz6YUW9+NB0AClEqooMhKr4h3SdJHRkIHV894Lx8w==
X-Received: by 2002:a05:6a00:cc1:b0:68a:5cf8:dac5 with SMTP id
 b1-20020a056a000cc100b0068a5cf8dac5mr14717527pfv.22.1694502785581; 
 Tue, 12 Sep 2023 00:13:05 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 f13-20020aa78b0d000000b0068be348e35fsm6647495pfd.166.2023.09.12.00.13.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Sep 2023 00:13:05 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH v7 15/18] plugins: Allow to read registers
Date: Tue, 12 Sep 2023 16:12:01 +0900
Message-ID: <20230912071206.30751-16-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230912071206.30751-1-akihiko.odaki@daynix.com>
References: <20230912071206.30751-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

It is based on GDB protocol to ensure interface stability.

The timing of the vcpu init hook is also changed so that the hook will
get called after GDB features are initialized.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1706
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/qemu/qemu-plugin.h   | 52 +++++++++++++++++++++++++++++++++---
 plugins/api.c                | 19 +++++++++++++
 plugins/qemu-plugins.symbols |  3 +++
 3 files changed, 71 insertions(+), 3 deletions(-)

diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index 50a9957279..40aae8db68 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -11,6 +11,7 @@
 #ifndef QEMU_QEMU_PLUGIN_H
 #define QEMU_QEMU_PLUGIN_H
 
+#include <glib.h>
 #include <inttypes.h>
 #include <stdbool.h>
 #include <stddef.h>
@@ -51,7 +52,7 @@ typedef uint64_t qemu_plugin_id_t;
 
 extern QEMU_PLUGIN_EXPORT int qemu_plugin_version;
 
-#define QEMU_PLUGIN_VERSION 1
+#define QEMU_PLUGIN_VERSION 2
 
 /**
  * struct qemu_info_t - system information for plugins
@@ -218,8 +219,8 @@ struct qemu_plugin_insn;
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
@@ -664,4 +665,49 @@ uint64_t qemu_plugin_end_code(void);
  */
 uint64_t qemu_plugin_entry_code(void);
 
+/**
+ * qemu_plugin_find_register_file() - find register file
+ *
+ * @vcpu_index: the index of the vcpu context
+ * @name: the name of the register file.
+ *
+ * Returns the identifier of the register file if it was found, and a negative
+ * value otherwise.
+ *
+ * The names of register files are identical with names of GDB's standard
+ * target features with some extensions. For details, see:
+ * https://sourceware.org/gdb/onlinedocs/gdb/Standard-Target-Features.html
+ */
+int qemu_plugin_find_register_file(unsigned int vcpu_index, const char *name);
+
+/**
+ * qemu_plugin_find_register() - find register
+ *
+ * @vcpu_index: the index of the vcpu context
+ * @file: the register file identifier determined with
+ *        qemu_plugin_find_register_file().
+ * @name: the name of the register.
+ *
+ * The names of register are identical with names used in GDB's standard
+ * target features with some extensions. For details, see:
+ * https://sourceware.org/gdb/onlinedocs/gdb/Standard-Target-Features.html
+ */
+int qemu_plugin_find_register(unsigned int vcpu_index, int file,
+                              const char *name);
+
+/**
+ * qemu_plugin_read_register() - read register
+ *
+ * @buf: the byte array to append the read register content to.
+ * @reg: the register identifier determined with
+ *       qemu_plugin_find_register().
+ *
+ * This function is only available in a context that register read access is
+ * explicitly requested.
+ *
+ * Returns the size of the read register. The content of @buf is in target byte
+ * order.
+ */
+int qemu_plugin_read_register(GByteArray *buf, int reg);
+
 #endif /* QEMU_QEMU_PLUGIN_H */
diff --git a/plugins/api.c b/plugins/api.c
index 2078b16edb..242a483884 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -35,6 +35,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/main-loop.h"
 #include "qemu/plugin.h"
 #include "qemu/log.h"
 #include "tcg/tcg.h"
@@ -442,3 +443,21 @@ uint64_t qemu_plugin_entry_code(void)
 #endif
     return entry;
 }
+
+int qemu_plugin_find_register_file(unsigned int vcpu_index, const char *name)
+{
+    QEMU_IOTHREAD_LOCK_GUARD();
+    return gdb_find_feature(qemu_get_cpu(vcpu_index), name);
+}
+
+int qemu_plugin_find_register(unsigned int vcpu_index, int file,
+                              const char *name)
+{
+    QEMU_IOTHREAD_LOCK_GUARD();
+    return gdb_find_feature_register(qemu_get_cpu(vcpu_index), file, name);
+}
+
+int qemu_plugin_read_register(GByteArray *buf, int reg)
+{
+    return gdb_read_register(current_cpu, buf, reg);
+}
diff --git a/plugins/qemu-plugins.symbols b/plugins/qemu-plugins.symbols
index 71f6c90549..977f1fcfcb 100644
--- a/plugins/qemu-plugins.symbols
+++ b/plugins/qemu-plugins.symbols
@@ -42,4 +42,7 @@
   qemu_plugin_tb_vaddr;
   qemu_plugin_uninstall;
   qemu_plugin_vcpu_for_each;
+  qemu_plugin_find_register_file;
+  qemu_plugin_find_register;
+  qemu_plugin_read_register;
 };
-- 
2.42.0


