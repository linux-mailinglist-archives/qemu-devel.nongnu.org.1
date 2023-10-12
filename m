Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB797C6ECA
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 15:08:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqvQ6-0003cY-Ga; Thu, 12 Oct 2023 09:08:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qqvPu-00033N-0Y
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 09:07:55 -0400
Received: from mail-io1-xd36.google.com ([2607:f8b0:4864:20::d36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qqvPo-0005N7-FX
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 09:07:52 -0400
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-7a2a3fb0713so34385139f.1
 for <qemu-devel@nongnu.org>; Thu, 12 Oct 2023 06:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697116067; x=1697720867;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=70r89jCdRbuTd1/1nQVTwclSWqpptHX49rQTcdIEjyE=;
 b=UyKYNxg9BYKuMntWl2bvVCkEhM0FWHvzXK7q+JKeNPtZLjtwSesAyuSF3f6DYq16yg
 +/b30xFtlAWQ9U9KlpYabeJUXo+vCerjtSAUaCdEKKhoKJvGcsjecx94HIg/TQuKjw+Q
 lCneSWNVaII9kWGA+ZJB1C6qQIzvcJF86xrGAiHE2vpeLqJ7A1xjkoAZvOvyZYYEjJNn
 qjQwhI5OxpAURZz+qsbGIrgqxOdrwaWl+P3jepbmnWVFk795LQw5WRb1JbPZDsNZrQbr
 vpYjZo0zbbLemXPbHzre9/hupxa+M+BsZafDLFknxA1+vwEMNvvuW1fOCOYAF1vm93Jr
 e4hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697116067; x=1697720867;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=70r89jCdRbuTd1/1nQVTwclSWqpptHX49rQTcdIEjyE=;
 b=BC/ppvuFzHEl8KPzC5Qu6vAOHxdFRvhPwVk5yvu0ErlZre9/m6L7AJidh1HufIPQF/
 03wH9+DZwvr7RMj+dkH3VT9Fp8whnZt2wlS3gLC6chLmkuJyCZYBllb4U8qWulH1zifi
 TaJgG0DUiCf+4oUIF20t+AVO6Tek7kvy2nz7bhgfWgeCTAwnCQlGTxfgANw8blf2O9vA
 tQI42LeblpBJAqzJoFapTrW02qPnHk5FEKVruZ9+WTbYpeG1dMd8QKs2RkEseSG/6NQn
 sa3lo9NVJI0E2tq5nDfPJFbHC5kaMeV/evp8nrqoYMqCvXss3vdse1ddjm9PxGHv+o+w
 kZ/g==
X-Gm-Message-State: AOJu0YzHEQL89ZgwZTDkLv+/RZbFaNzveD8nHC14k/tsAs2MbG+dz3LC
 aXB99hmV2PVkoS2nrAaT0bpPDw==
X-Google-Smtp-Source: AGHT+IE4PNaF1M+PnTPaPROeG8WRiIRsNRe7HfS4XJRLuUQVBOxBcOiO/ndJhhC0vjJNdN9r2Kr4pQ==
X-Received: by 2002:a05:6e02:20ef:b0:351:526a:4bc with SMTP id
 q15-20020a056e0220ef00b00351526a04bcmr31565227ilv.15.1697116066811; 
 Thu, 12 Oct 2023 06:07:46 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 h7-20020a63b007000000b0057412d84d25sm1660541pgf.4.2023.10.12.06.07.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Oct 2023 06:07:46 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH v11 17/18] plugins: Allow to read registers
Date: Thu, 12 Oct 2023 22:06:11 +0900
Message-ID: <20231012130616.7941-18-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231012130616.7941-1-akihiko.odaki@daynix.com>
References: <20231012130616.7941-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d36;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-io1-xd36.google.com
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


