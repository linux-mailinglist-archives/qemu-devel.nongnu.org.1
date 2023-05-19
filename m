Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9E7709D87
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 19:07:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q03Xe-0002HZ-Ez; Fri, 19 May 2023 13:05:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q03XQ-0002CL-4n
 for qemu-devel@nongnu.org; Fri, 19 May 2023 13:05:10 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q03XI-0005Uv-3j
 for qemu-devel@nongnu.org; Fri, 19 May 2023 13:05:07 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3095b1b6e02so245422f8f.2
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 10:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684515898; x=1687107898;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7F9Gx979+6Hkz/Du+/YB5Ayn8YHTGimM/bWSDeN1tW4=;
 b=ErnBAQ9hencXmZIjORoaDWajla1FsfI+TRGcNHaNhE4l9EBGQvdB/LgZjCDCWnENiO
 iw0awPVnP6hiBUhVxWMs458aztlDI/38uAbrNZt8Ws2s+VjLfcdJlDflOu8Trw3nHFP7
 laaED30pJ70HF1Ha0Y/ZEzaVA/ZvInKioR4IbajRPydWKGUC+QKvXbt1jZWXZl4DZVBQ
 312lvKabQPeITpegNHSR7eoiVM7Ata3Qg+d5mUq77/1P2vxtxSZebRQIZ4f9TVpObya1
 fwYmv3tv7eyaRAsU1YJ9qC/LOmuQSVOFLm8xUjyqwXnDVegSZQkHSJt/6uMPctueKZKQ
 KdTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684515898; x=1687107898;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7F9Gx979+6Hkz/Du+/YB5Ayn8YHTGimM/bWSDeN1tW4=;
 b=W5xIg0XpH726R+ZhhmimIHdn+g8Dc8zxX8FstgeoEPlWv14pjNs419ctjD4ylWgR2b
 aBn8hbfdTKXr0SC8VOPx5euxAxLylS72dixxp48iqmbOsVY7YgG6loWlbsJE5Xc86ipB
 5MEwVl1AdVPEvUinq6NFF3BuY2fZQfE8yEzgdnWgexTKnhvm0EnCMbg+YTryqpmE/MNI
 jkXlJnqhSo/ZeouTVd1YRFioEohCt6ujTbozAtAtrvpAH1X7u4lOrk9Ov12xkwLwJMnW
 yWKw4MuYF6k6lQRyKxudA+JBeArY16IDfiEQ+L1B29GcZpUPlUlJKJQH3v1v9yV9jCH2
 LVoA==
X-Gm-Message-State: AC+VfDwQF8bj36ETgLJyEwfMoWdNMA9x8X9Y0nK03pzicDX+ZDhiU5FB
 amGF/naEuUKpMZ3onyFaKp52lQ==
X-Google-Smtp-Source: ACHHUZ7Yyop3MUn44DlcqgrBzUIACE9XGMEo6QLg/TtB+1xVQbLr+RCME1kcBVcNuwgcE0/peCSmsw==
X-Received: by 2002:adf:f2d2:0:b0:307:977a:e693 with SMTP id
 d18-20020adff2d2000000b00307977ae693mr2107267wrp.59.1684515898515; 
 Fri, 19 May 2023 10:04:58 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 y18-20020adff152000000b002e61e002943sm5769093wro.116.2023.05.19.10.04.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 May 2023 10:04:57 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A71131FFC2;
 Fri, 19 May 2023 18:04:55 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <lvivier@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Marco Liebel <mliebel@qti.qualcomm.com>,
 Mark Burton <mburton@qti.qualcomm.com>, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [RFC PATCH 7/8] plugins: add time control API
Date: Fri, 19 May 2023 18:04:53 +0100
Message-Id: <20230519170454.2353945-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230519170454.2353945-1-alex.bennee@linaro.org>
References: <20230519170454.2353945-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x436.google.com
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

Expose the ability to control time through the plugin API. Only one
plugin can control time so it has to request control when loaded.
There are probably more corner cases to catch here.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/qemu/qemu-plugin.h   | 19 +++++++++++++++++++
 plugins/api.c                | 22 ++++++++++++++++++++++
 plugins/qemu-plugins.symbols |  2 ++
 3 files changed, 43 insertions(+)

diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index 50a9957279..8385670976 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -536,7 +536,26 @@ void qemu_plugin_register_vcpu_mem_inline(struct qemu_plugin_insn *insn,
                                           enum qemu_plugin_op op, void *ptr,
                                           uint64_t imm);
 
+/**
+ * qemu_plugin_request_time_control() - request the ability to control time
+ *
+ * This grants the plugin the ability to control system time. Only one
+ * plugin can control time so if multiple plugins request the ability
+ * all but the first will fail.
+ *
+ * Returns an opaque handle or NULL if fails
+ */
+const void * qemu_plugin_request_time_control(void);
 
+/**
+ * qemu_plugin_update_ns() - update system emulation time
+ * @handle: opaque handle returned by qemu_plugin_request_time_control()
+ * @time: time in nanoseconds
+ *
+ * This allows an appropriately authorised plugin (i.e. holding the
+ * time control handle) to move system time forward to @time.
+ */
+void qemu_plugin_update_ns(const void *handle, int64_t new_time);
 
 typedef void
 (*qemu_plugin_vcpu_syscall_cb_t)(qemu_plugin_id_t id, unsigned int vcpu_index,
diff --git a/plugins/api.c b/plugins/api.c
index 2078b16edb..8402b3a5f6 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -37,6 +37,7 @@
 #include "qemu/osdep.h"
 #include "qemu/plugin.h"
 #include "qemu/log.h"
+#include "qemu/timer.h"
 #include "tcg/tcg.h"
 #include "exec/exec-all.h"
 #include "exec/ram_addr.h"
@@ -442,3 +443,24 @@ uint64_t qemu_plugin_entry_code(void)
 #endif
     return entry;
 }
+
+/*
+ * Time control
+ */
+static bool has_control;
+
+const void * qemu_plugin_request_time_control(void)
+{
+    if (!has_control) {
+        has_control = true;
+        return &has_control;
+    }
+    return NULL;
+}
+
+void qemu_plugin_update_ns(const void *handle, int64_t new_time)
+{
+    if (handle == &has_control) {
+        qemu_clock_advance_virtual_time(new_time);
+    }
+}
diff --git a/plugins/qemu-plugins.symbols b/plugins/qemu-plugins.symbols
index 71f6c90549..91b882fecc 100644
--- a/plugins/qemu-plugins.symbols
+++ b/plugins/qemu-plugins.symbols
@@ -35,11 +35,13 @@
   qemu_plugin_register_vcpu_tb_exec_cb;
   qemu_plugin_register_vcpu_tb_exec_inline;
   qemu_plugin_register_vcpu_tb_trans_cb;
+  qemu_plugin_request_time_control;
   qemu_plugin_reset;
   qemu_plugin_start_code;
   qemu_plugin_tb_get_insn;
   qemu_plugin_tb_n_insns;
   qemu_plugin_tb_vaddr;
   qemu_plugin_uninstall;
+  qemu_plugin_update_ns;
   qemu_plugin_vcpu_for_each;
 };
-- 
2.39.2


