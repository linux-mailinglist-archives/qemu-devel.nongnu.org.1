Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B00BD7C4B26
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 09:05:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqTHY-0001hZ-08; Wed, 11 Oct 2023 03:05:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qqTHW-0001gP-8U
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 03:05:22 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qqTHU-00063d-DG
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 03:05:22 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1c735473d1aso45390185ad.1
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 00:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697007919; x=1697612719;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5CDoG163yygyTEEj9sb60NTGdsH5TibpgoA0kSi6Swc=;
 b=STcbGz46ayhZDQFt3mxGyi65NjOLxDArt4OhHNCZagJhAfwrRmv8rzip/PClz/PqU/
 5QXBKd5jK21J240XHuKDLruhaqEObKOjo1kmufdLO/J/zsIQdYtnLHRiSaADqnPJPVkM
 NX94k5DV2+B0ylZeYz7R8heZ3DQaPGiOGrsDHURAHFKbX00Wv5Ylfz7Fnxf7m6VEGuPs
 ZS/vsTQUHYD2FVz1ZHwAsPwlIEp6Uu2N2v0Rh4Viu5YwS+jnq8lIUEvx5h15xgVxm5A1
 j4lOX/vCPyZ6hX+iekUv/93fLMbUjaYtDWFmpdN3I/C09lCVjXaxLDnONMk7XmW6ovXh
 N9eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697007919; x=1697612719;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5CDoG163yygyTEEj9sb60NTGdsH5TibpgoA0kSi6Swc=;
 b=gfZyofyW9fObrwg2c1FBrkhRVs6cYZ/Ge/0QsB43oS1/92ajGPae/2k02sjs6V2fDh
 fg6qP9YTsOTqYtfMIujdanFxW9s+ZCkO0XSWQR+hym9L+2IW6M1eL4g1DdJEtB+u/I8F
 ctUtXJRx+ohS0SleoQHIsA23xFeUXjiPXQS1zXVYHRiLVeQju2BfFG3CpWJYmr0mfv8z
 jaOCOADBwgubsC/ZKB8yp2PU+tzoVLJ0tT1LngjZh8ikMmavhtPNWWMP5GFwu0Fr2t5S
 OTfJOAw53udciKwlB7K5e+OnNGSJffX2BixwCNQ0aToC3bVZrcYaQU0ju9gv9KgWTGQr
 KOnw==
X-Gm-Message-State: AOJu0YzKrTAn+g6mkoTS8ALbnz/MydsHUIkDmUdgYscQYNvpEqVsLo5f
 zPi6GcdFTf4GokOtDPfOJlnU8g==
X-Google-Smtp-Source: AGHT+IGweCLU756+A7vwyaakGsCLkdMw4hw+e/9pNRNBstY+PlN82D2/ELQ7aLBXXK9nTY1KoUAp3g==
X-Received: by 2002:a17:902:d2c3:b0:1c2:218c:3762 with SMTP id
 n3-20020a170902d2c300b001c2218c3762mr20765489plc.42.1697007919255; 
 Wed, 11 Oct 2023 00:05:19 -0700 (PDT)
Received: from localhost ([157.82.206.10]) by smtp.gmail.com with UTF8SMTPSA id
 s2-20020a170902ea0200b001ba066c589dsm13029804plg.137.2023.10.11.00.05.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Oct 2023 00:05:19 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH v9 21/23] plugins: Allow to read registers
Date: Wed, 11 Oct 2023 16:03:07 +0900
Message-ID: <20231011070335.14398-22-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231011070335.14398-1-akihiko.odaki@daynix.com>
References: <20231011070335.14398-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62b.google.com
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
 plugins/api.c                | 20 ++++++++++++++
 plugins/qemu-plugins.symbols |  3 +++
 3 files changed, 72 insertions(+), 3 deletions(-)

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
index 3f7b5bbfdd..6c7343edfe 100644
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
@@ -433,3 +435,21 @@ uint64_t qemu_plugin_entry_code(void)
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


