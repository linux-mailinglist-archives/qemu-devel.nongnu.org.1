Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 552507D612D
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 07:30:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvWST-0005Xw-MP; Wed, 25 Oct 2023 01:29:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qvWSM-0005T1-HR
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 01:29:26 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qvWSK-0001HV-Ll
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 01:29:26 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1ca6809fb8aso37564675ad.1
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 22:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1698211763; x=1698816563;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5qFVsQ0PFMMSXumcvtdQRqcd0KaHJxUyAQq+RKUvxuM=;
 b=hTmn6lY6Oe4ymN6APq5s386+ROsRLTeh86OKCYaWMoASzZyREC8h0mGtcxDvI35dKs
 /qzohDlwPGkAM6HZwGcUs5aLbXu+GMSteoHLjPWyh+sTpJZN8KG6uyJm24GC8oMDurpp
 tgmqqUk+SgV2P5hzSBwSRS1HxdCdPcH30d8NgEUtDS58u59u7TLzuV4RxiIcv8eEgspw
 yrDrBBvv4eDqjyEoYmKfYUOEmB8XG3ufqguOYS9EsdKhWOlqmZNAkY7M+4vtOJQCm8X6
 g14CR1QFcLKt1u1ncC0AMTsTwMslEXnHw94jqKKb0tAMVB21+U2g2onJUIgMlTfuXYjQ
 5y/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698211763; x=1698816563;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5qFVsQ0PFMMSXumcvtdQRqcd0KaHJxUyAQq+RKUvxuM=;
 b=Xr1AOQayDmetQqeUVwvC7ItDCj6LkB6aDYhHds9KjT2pTlExh6O1glOtsKkkOpWF8t
 xziHUHsuBagV2ATlaCNCWn2ZxTCwjgzCbd3jhvfyQ1R6CarCirZAUCGKU7M9+aSopx4J
 OooJdwFjJtarmuZGJB+msqCjDRYCYg3pCfLMhxbVpJgmZSz+mKP1hLQQAKhlgRrTKP3P
 yTXtghukE1+Zr8cMzcrdirU06Qs4xt//3w8VNHMKC5nAwUeBxehh4QqZScneAEjL/xCn
 mfv15efPBZvDQVuw2xbKgqJZv/JJBxPsPuIaLInBICpwp3eZGZp3p2KI/8aSVzxRGCJu
 33Og==
X-Gm-Message-State: AOJu0YxFGhceqnNy73VnJsfFVojvDP4JiXuOfuSRyU1gFcYmjoixvVU9
 RGGKyinvVZi1kdUt0BioRV4Q6A==
X-Google-Smtp-Source: AGHT+IH81f0ohf2fqs8zP+nlQ5+j9MTh0h1vAFOExwbILXtTIOgL/KiQwlJPhotMtrg/G7/2xRJKwg==
X-Received: by 2002:a17:902:f542:b0:1ca:1c89:9acf with SMTP id
 h2-20020a170902f54200b001ca1c899acfmr13901938plf.53.1698211763091; 
 Tue, 24 Oct 2023 22:29:23 -0700 (PDT)
Received: from localhost ([157.82.204.207])
 by smtp.gmail.com with UTF8SMTPSA id
 n17-20020a170902e55100b001bb1f0605b2sm8271983plf.214.2023.10.24.22.29.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Oct 2023 22:29:22 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH v15 18/19] plugins: Allow to read registers
Date: Wed, 25 Oct 2023 14:27:40 +0900
Message-ID: <20231025052744.20697-19-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231025052744.20697-1-akihiko.odaki@daynix.com>
References: <20231025052744.20697-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::631;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x631.google.com
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
index 29c6fc788f..2a6c6054a0 100644
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


