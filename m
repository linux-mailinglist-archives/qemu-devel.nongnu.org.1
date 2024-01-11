Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4911382B0A1
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 15:26:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNvys-0004QZ-K9; Thu, 11 Jan 2024 09:24:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rNvyV-0004MO-8C
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 09:24:03 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rNvyT-0002Ye-8S
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 09:24:02 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-40e60e137aaso5433935e9.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 06:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704983039; x=1705587839; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Aq5DjSOiw7b/OxzS4nPd0JW8zSf3ntDpqvE/K8se7oQ=;
 b=eSPgyD8CXHMRwKAEQhTj6eIVTxjd7eOkOTniWJcBVsBmGrEqD33/QSoxv1yOz4G8RE
 EBEI8p8/Ei8LKjL9OmQuJbbItZHEGcnGIHeZgO8tRtzahFd5l4DQq4PI0GQXMrr3cVpG
 INNtoywVk9lCEAqWtFruB8U6sODXQsJp2HMno+gdMhVHGasanzldcsX5D9jU5lXP66r8
 wgLUO9xQ1FPNc38adyb7DscS6PYvV6yCXcr6p26AREL464a2y9tpNp5gI4j22BCwYWMU
 05OTn/SMuRzh0fDb59ylryu/FHjkb11/ow0cyTXfW65TX2V8JXkV5i7cPyXS1Z91Ep/F
 gZHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704983039; x=1705587839;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Aq5DjSOiw7b/OxzS4nPd0JW8zSf3ntDpqvE/K8se7oQ=;
 b=mLPX3fmed+XsUOFxmNRL+PI/XHQuWuCvLHbp0yM/C7ah0F8l819zJqXnCI2WXJhkXO
 4g1oqUBetzAiyXEuzuLwKnRZWtM/fyPTOFD42Tj582p4s9s4EG0TFZuyZlA657rhL+DE
 ziunCBggZCtEJGveOIi/DWnttl9h6obBwzXW6cODuMEUGEK4yINhWgsHe2yG55YgmuB4
 OexUdISku+s5HinSGi2CzCIjLRXZCTrQogvxzWviz+Z75ak9l5sNB8hTXKXNzdJ6OgKz
 WPqtlZE3LNUFIt6ofvS1ciW33jb1qZjUL8GxDI7IBBU9rrFla8hI9FhtCIMOo0K1vhnb
 Ydwg==
X-Gm-Message-State: AOJu0Yzm78LjoqoyqEiDfnAUAEVUzB/pEnSdycsXFaZaEa50QnWLSHD0
 8BukgB7IdniA7ZHI87dUV+mGK0u2cIsiJL0ppHMjJz+hTGr8TA==
X-Google-Smtp-Source: AGHT+IGw/9BoY+T5Rx/XF42N3stGpW3rFROeoDBtVIpfUoQhBWCOEsNGA90C/tcBDp2s3NhRCrg5nA==
X-Received: by 2002:a05:600c:54ed:b0:40e:5996:2291 with SMTP id
 jb13-20020a05600c54ed00b0040e59962291mr511531wmb.138.1704983038931; 
 Thu, 11 Jan 2024 06:23:58 -0800 (PST)
Received: from linaro.. ([102.35.208.160]) by smtp.gmail.com with ESMTPSA id
 h7-20020adff4c7000000b0033677aae2e2sm1349000wrp.107.2024.01.11.06.23.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jan 2024 06:23:58 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH 06/12] tests/plugin/mem: migrate to new per_vcpu API
Date: Thu, 11 Jan 2024 18:23:19 +0400
Message-ID: <20240111142326.1743444-7-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240111142326.1743444-1-pierrick.bouvier@linaro.org>
References: <20240111142326.1743444-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wm1-x32e.google.com
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
 tests/plugin/mem.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/tests/plugin/mem.c b/tests/plugin/mem.c
index beca8232342..06f2d80d0ec 100644
--- a/tests/plugin/mem.c
+++ b/tests/plugin/mem.c
@@ -16,7 +16,9 @@
 
 QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
 
-static uint64_t inline_mem_count;
+#define MAX_CPUS 8
+
+static uint64_t inline_mem_count[MAX_CPUS];
 static uint64_t cb_mem_count;
 static uint64_t io_count;
 static bool do_inline, do_callback;
@@ -29,7 +31,11 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
     g_autoptr(GString) out = g_string_new("");
 
     if (do_inline) {
-        g_string_printf(out, "inline mem accesses: %" PRIu64 "\n", inline_mem_count);
+        uint64_t total = 0;
+        for (int i = 0; i < MAX_CPUS; ++i) {
+            total += inline_mem_count[i];
+        }
+        g_string_printf(out, "inline mem accesses: %" PRIu64 "\n", total);
     }
     if (do_callback) {
         g_string_append_printf(out, "callback mem accesses: %" PRIu64 "\n", cb_mem_count);
@@ -67,9 +73,10 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
         struct qemu_plugin_insn *insn = qemu_plugin_tb_get_insn(tb, i);
 
         if (do_inline) {
-            qemu_plugin_register_vcpu_mem_inline(insn, rw,
-                                                 QEMU_PLUGIN_INLINE_ADD_U64,
-                                                 &inline_mem_count, 1);
+            qemu_plugin_register_vcpu_mem_inline_per_vcpu(
+                insn, rw,
+                QEMU_PLUGIN_INLINE_ADD_U64,
+                inline_mem_count, sizeof(uint64_t), 1);
         }
         if (do_callback) {
             qemu_plugin_register_vcpu_mem_cb(insn, vcpu_mem,
@@ -109,6 +116,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
                 fprintf(stderr, "boolean argument parsing failed: %s\n", opt);
                 return -1;
             }
+            g_assert(info->system.smp_vcpus <= MAX_CPUS);
         } else if (g_strcmp0(tokens[0], "callback") == 0) {
             if (!qemu_plugin_bool_parse(tokens[0], tokens[1], &do_callback)) {
                 fprintf(stderr, "boolean argument parsing failed: %s\n", opt);
-- 
2.43.0


