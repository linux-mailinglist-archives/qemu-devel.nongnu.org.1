Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9F37C9299
	for <lists+qemu-devel@lfdr.de>; Sat, 14 Oct 2023 05:42:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrVWe-0005GY-FD; Fri, 13 Oct 2023 23:41:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qrVWb-0005FS-CD
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 23:41:13 -0400
Received: from mail-oo1-xc2e.google.com ([2607:f8b0:4864:20::c2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qrVWY-00052Q-Gj
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 23:41:12 -0400
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-57ad95c555eso1580298eaf.3
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 20:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697254869; x=1697859669;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=70r89jCdRbuTd1/1nQVTwclSWqpptHX49rQTcdIEjyE=;
 b=G0gnmInhpWEQTEG7zHsAYzIRijcWKXk5xbL/mWzFDcnvsXuX/Yw7bxpaQXFqh9oWwQ
 VqMFpnJKgcsJ75pvYSh/i0ExfR7UfxdOOje79YfyZ57L2BEUmVH3wZrtKa3nNzX7X/G6
 bieLalrt4bnmj3gDk9wX6X0L1CN98LAG3JXl+5myg4MaD2Ws3I8GX5v5U4gSm6tDCr+Y
 AiC07rsQDVmH/skJuaRug6ZIPDxHVnt9TUI5KBlPyuRyQbIKHqsek8Vlh08yBnVav6PW
 zOsgCMljof95vUWhv1TJPtYKd6a0At3LsKxT92eWuTSN1JgU0ax04I1Q2L8LkHrfs6Ts
 5RfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697254869; x=1697859669;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=70r89jCdRbuTd1/1nQVTwclSWqpptHX49rQTcdIEjyE=;
 b=ag/kEbMkBInEz9TZfVxkWg3SZHoGSxaaf3czWKBaN0YJ3xqdQg/CtAFIaun2A+ZmE/
 xCMXwqTZQPc36JsM18jlPUMSZULXeSxF9Wuu1jip6uzCw/APXa4w7xm1WRE/0MVXB/aY
 hOVdKxhbrtuzcLvz9kCikaj7ltB1gyLrYmgW+Hrc5JDADUl8ds0680446+6oMASM63Aw
 OrPJzxdyQBl0gJiPt/MOXz/mVcg/nhX3rQ0P6ri+HV+AYau5wflgny1OHPuoY4y/eNZf
 3OwPizGAOllnTbhkWaH1xQ1yVB6n+hOa4f/dyIRHKhzSCQK3yg5wwtlqqgKGjC14z3Pc
 cdxQ==
X-Gm-Message-State: AOJu0YyL3NlskGV7xv75VYyGjaLrwdrI7te49YF09EVviwK4pJlBsScy
 SkLcfbqyUe8HawSiEchwEf6teA==
X-Google-Smtp-Source: AGHT+IF67SXZ19w1rNcK0a2joysZF1O74VwAm5pigWDT7CKGTb2Tq6DdywHLEWWt0d41CuFmWPpu2w==
X-Received: by 2002:a05:6358:7e92:b0:143:5383:af8b with SMTP id
 o18-20020a0563587e9200b001435383af8bmr29034965rwn.11.1697254869405; 
 Fri, 13 Oct 2023 20:41:09 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 m26-20020a056a00165a00b0068fb4f5f38fsm14315784pfc.30.2023.10.13.20.41.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Oct 2023 20:41:09 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH v12 17/18] plugins: Allow to read registers
Date: Sat, 14 Oct 2023 12:39:36 +0900
Message-ID: <20231014033940.15679-18-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231014033940.15679-1-akihiko.odaki@daynix.com>
References: <20231014033940.15679-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::c2e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oo1-xc2e.google.com
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
 include/qemu/qemu-plugin.h   | 50 ++++++++++++++++++++++++++++++++++--
 plugins/api.c                | 20 +++++++++++++++
 plugins/qemu-plugins.symbols |  3 +++
 3 files changed, 71 insertions(+), 2 deletions(-)

diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index 50a9957279..c0ce700258 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -11,6 +11,7 @@
 #ifndef QEMU_QEMU_PLUGIN_H
 #define QEMU_QEMU_PLUGIN_H
 
+#include <glib.h>
 #include <inttypes.h>
 #include <stdbool.h>
 #include <stddef.h>
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
index 326e37cb73..89144a2dec 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -35,10 +35,12 @@
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
@@ -437,3 +439,21 @@ uint64_t qemu_plugin_entry_code(void)
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


