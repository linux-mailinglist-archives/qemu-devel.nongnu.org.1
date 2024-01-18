Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A62AA8311BB
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 04:24:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQJ1C-0003ia-1j; Wed, 17 Jan 2024 22:24:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rQJ18-0003eh-Gz
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 22:24:35 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rQJ16-0002eq-RI
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 22:24:34 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-337c4f0f9daso957687f8f.2
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 19:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705548270; x=1706153070; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=llai94LBCUTj3dfHKAUWRulZm20ERaPuqBXTHgqZDnw=;
 b=SbP0lnJdwDmTQap5ZyDxSsa0JxdL3rMLnaZtXreTBmTajfEqkFq7g1mHvCRl0zIh0f
 vQsPR9jiHBsKqNa7ZSI0r8vejJNdXEBI0OlOaP10zn8Kq3hI1oz3jr8YIbQU9oTvGnYW
 7nknhyaqjA/4YmenEvsBLd/9ugOk9qu+6UBUXJb6LVqKf4IZ8VM6zs1XqKoos+jujUlh
 L95gvEV0mDg8Cmln83U2Dz08w9iCohxKAkFOF4c3TK++Pxv5bJZCecVO0tOd9aXIfyb4
 bIK/D8KphvaDHxOUdaEjL4tBZEcWUE9BwV6jYrGDQmlLNlS3dgrjMxHn7bQ5UJbL4Ut1
 2vsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705548270; x=1706153070;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=llai94LBCUTj3dfHKAUWRulZm20ERaPuqBXTHgqZDnw=;
 b=Je2Yk57HNMJ9eYUiTxCErPh//MzPgSOhjIcWs/bMxIKp849QRnxXz7dnrU993X0wh0
 hxQYE+zxFaY0lCe7bsbT6mRvW9v03bn1A0ZTWVPDkYMqK5gTrVp0vsAZekg2ZD/kLo5F
 TyIR6d8cScTI6+guM6aLnbvb8Pzn/1fIv8rSHxxS0+2e1fqIICHVgrX4Hl2VPJa/Vq3c
 cjKiCiU5I4Jjxpq+YSP8WfAAPPcEYZHc1p2hlKqT7Ja3LKvwGoPdkWH7mIcslLCqv3dU
 zZ56ZORdtYgoyo66MdKisPZBTuGNCgw4oyBgf3mhoTfS9A2IxgqJPeN6FX8ywjV/1GH/
 yGfQ==
X-Gm-Message-State: AOJu0Yw5SRXhq36FiNFNsLtpCO/pw4Uav7zwCoQrndCLAia72Ab3XXio
 Q12Jiayj/TNyLq1wjHA7BN3V3hmX/cruM3FzgISlqbh6Bn1/RUKDb1nBBtmK3M1oRvYoF53WuXm
 M8kw=
X-Google-Smtp-Source: AGHT+IHr8LujjqKgsTARQGfi9vk7DuZpM7YMWXOGxV0WVSGcGXZuCvtDMI6Who+yMMIMIABsYu4dpg==
X-Received: by 2002:adf:ea4a:0:b0:337:b4db:321f with SMTP id
 j10-20020adfea4a000000b00337b4db321fmr78819wrn.110.1705548270402; 
 Wed, 17 Jan 2024 19:24:30 -0800 (PST)
Received: from linaro.. ([102.35.208.160]) by smtp.gmail.com with ESMTPSA id
 i2-20020adff302000000b0033788e357e1sm2894292wro.108.2024.01.17.19.24.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jan 2024 19:24:30 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH v2 06/14] tests/plugin/mem: migrate to new per_vcpu API
Date: Thu, 18 Jan 2024 07:23:51 +0400
Message-ID: <20240118032400.3762658-7-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240118032400.3762658-1-pierrick.bouvier@linaro.org>
References: <20240118032400.3762658-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wr1-x430.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 tests/plugin/mem.c | 39 ++++++++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/tests/plugin/mem.c b/tests/plugin/mem.c
index 44e91065ba7..83b7fa1f187 100644
--- a/tests/plugin/mem.c
+++ b/tests/plugin/mem.c
@@ -16,9 +16,14 @@
 
 QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
 
-static uint64_t inline_mem_count;
-static uint64_t cb_mem_count;
-static uint64_t io_count;
+typedef struct {
+    uint64_t mem_count;
+    uint64_t io_count;
+} CPUCount;
+
+static struct qemu_plugin_scoreboard *counts;
+static qemu_plugin_u64_t mem_count;
+static qemu_plugin_u64_t io_count;
 static bool do_inline, do_callback;
 static bool do_haddr;
 static enum qemu_plugin_mem_rw rw = QEMU_PLUGIN_MEM_RW;
@@ -27,16 +32,16 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
 {
     g_autoptr(GString) out = g_string_new("");
 
-    if (do_inline) {
-        g_string_printf(out, "inline mem accesses: %" PRIu64 "\n", inline_mem_count);
-    }
-    if (do_callback) {
-        g_string_append_printf(out, "callback mem accesses: %" PRIu64 "\n", cb_mem_count);
+    if (do_inline || do_callback) {
+        g_string_printf(out, "mem accesses: %" PRIu64 "\n",
+                        qemu_plugin_u64_sum(mem_count));
     }
     if (do_haddr) {
-        g_string_append_printf(out, "io accesses: %" PRIu64 "\n", io_count);
+        g_string_append_printf(out, "io accesses: %" PRIu64 "\n",
+                               qemu_plugin_u64_sum(io_count));
     }
     qemu_plugin_outs(out->str);
+    qemu_plugin_scoreboard_free(counts);
 }
 
 static void vcpu_mem(unsigned int cpu_index, qemu_plugin_meminfo_t meminfo,
@@ -46,12 +51,12 @@ static void vcpu_mem(unsigned int cpu_index, qemu_plugin_meminfo_t meminfo,
         struct qemu_plugin_hwaddr *hwaddr;
         hwaddr = qemu_plugin_get_hwaddr(meminfo, vaddr);
         if (qemu_plugin_hwaddr_is_io(hwaddr)) {
-            io_count++;
+            (*qemu_plugin_u64_get(io_count, cpu_index))++;
         } else {
-            cb_mem_count++;
+            (*qemu_plugin_u64_get(mem_count, cpu_index))++;
         }
     } else {
-        cb_mem_count++;
+        (*qemu_plugin_u64_get(mem_count, cpu_index))++;
     }
 }
 
@@ -64,9 +69,10 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
         struct qemu_plugin_insn *insn = qemu_plugin_tb_get_insn(tb, i);
 
         if (do_inline) {
-            qemu_plugin_register_vcpu_mem_inline(insn, rw,
-                                                 QEMU_PLUGIN_INLINE_ADD_U64,
-                                                 &inline_mem_count, 1);
+            qemu_plugin_register_vcpu_mem_inline_per_vcpu(
+                insn, rw,
+                QEMU_PLUGIN_INLINE_ADD_U64,
+                mem_count, 1);
         }
         if (do_callback) {
             qemu_plugin_register_vcpu_mem_cb(insn, vcpu_mem,
@@ -117,6 +123,9 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
         }
     }
 
+    counts = qemu_plugin_scoreboard_new(sizeof(CPUCount));
+    mem_count = qemu_plugin_u64_struct(counts, CPUCount, mem_count);
+    io_count = qemu_plugin_u64_struct(counts, CPUCount, io_count);
     qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
     qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
     return 0;
-- 
2.43.0


