Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF96482B09B
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 15:25:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNvyu-0004UK-Hp; Thu, 11 Jan 2024 09:24:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rNvyl-0004Q2-Ib
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 09:24:20 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rNvyh-0002lF-8F
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 09:24:17 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-336897b6bd6so5067136f8f.2
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 06:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704983050; x=1705587850; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8ZO5SKzeIPzFy5xT17BpWpFDUdZJfOe9VoGxrmodP4k=;
 b=gH8qm+1uRwTu1hinB1nS2dyaevmEh3hXNsHgVzyh0R/NAt8n3ssN6VxX0I3ysmbGQD
 Z9P+OQwh6Zvq8nOq5rIWJQEepIcE6mTsSx/Y6g70QjXzaK4N2hzuYMla5znxYF/qrLKM
 EiGIatKzNX1uPJTURw869fAyt3Z1vF17vBlhpSYvpSYqhMfwYnP+40qtSiay6OpJl4+i
 UOSONm1ufnDY8kMSI3MreazzODI9CdyH2xQauAJvbgTTXMUq9v9H2o2bznDOze9He1DG
 DHrbT7D8ltMO/ppM0OckxktPM8hG1nstCzp0i7O+Bgma8YXPsolWgNJf1ZzoJN0NxC5M
 NOEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704983050; x=1705587850;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8ZO5SKzeIPzFy5xT17BpWpFDUdZJfOe9VoGxrmodP4k=;
 b=tF5muU/Pg7SXS4YUPBshu7vAzT7jTqwA86Wm23ameZp68T+8ekvu0oODqV1jHPM71R
 lOnpRAlBlfp7sae9gIiI9ViV9NCYOQxrXZrz+P5HRRFiyTbSn2iXEFXw2zhuTMrVGnXV
 ssBjXaZe8St+6pjEhSGv4UWdRUAdARxckreBu8yapPloehZ4SjBaZ3sJfYzbJnWqoBvF
 OdJYhNxnxDQgPk1BEIzpWpmAT8ZhG6JbqzJqBc/Fh3kfaIblJXL0BFOUVd0ejm39ZF6x
 uPa1gpDAnwliqjeAHDCRjQLv8UW7o/MUBfWuMC55tdz/tXEbt7nefhypgxS6yE9bixbR
 yTLA==
X-Gm-Message-State: AOJu0YzFBN9RhJ06/QrY8C5euB4QfkAIz/7ymDZTUf29bDRUSjz9FuwS
 ZII8/NFX6dH3P0bRo5gMPsZxkqgIn2hZcfuvf6+AF8yjUF+TIQ==
X-Google-Smtp-Source: AGHT+IHAwaDo1QprEHcY4Gs7xzhHvdVLPO99Qss3H52sVwUJy51FoudvHw0i15WLH6jlYeklsM7YwA==
X-Received: by 2002:a5d:490a:0:b0:337:3f72:3de2 with SMTP id
 x10-20020a5d490a000000b003373f723de2mr641930wrq.36.1704983050508; 
 Thu, 11 Jan 2024 06:24:10 -0800 (PST)
Received: from linaro.. ([102.35.208.160]) by smtp.gmail.com with ESMTPSA id
 h7-20020adff4c7000000b0033677aae2e2sm1349000wrp.107.2024.01.11.06.24.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jan 2024 06:24:10 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH 10/12] contrib/plugins/howvec: migrate to new per_vcpu API
Date: Thu, 11 Jan 2024 18:23:23 +0400
Message-ID: <20240111142326.1743444-11-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240111142326.1743444-1-pierrick.bouvier@linaro.org>
References: <20240111142326.1743444-1-pierrick.bouvier@linaro.org>
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
 contrib/plugins/howvec.c | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/contrib/plugins/howvec.c b/contrib/plugins/howvec.c
index 644a7856bb2..46230a43927 100644
--- a/contrib/plugins/howvec.c
+++ b/contrib/plugins/howvec.c
@@ -22,8 +22,18 @@
 
 QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
 
+#define MAX_CPUS 8
 #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
 
+static uint64_t count(uint64_t *arr)
+{
+    uint64_t res = 0;
+    for (int i = 0; i < MAX_CPUS; ++i) {
+        res += arr[i];
+    }
+    return res;
+}
+
 typedef enum {
     COUNT_CLASS,
     COUNT_INDIVIDUAL,
@@ -43,13 +53,13 @@ typedef struct {
     uint32_t mask;
     uint32_t pattern;
     CountType what;
-    uint64_t count;
+    uint64_t count[MAX_CPUS];
 } InsnClassExecCount;
 
 typedef struct {
     char *insn;
     uint32_t opcode;
-    uint64_t count;
+    uint64_t count[MAX_CPUS];
     InsnClassExecCount *class;
 } InsnExecCount;
 
@@ -159,7 +169,7 @@ static gint cmp_exec_count(gconstpointer a, gconstpointer b)
 {
     InsnExecCount *ea = (InsnExecCount *) a;
     InsnExecCount *eb = (InsnExecCount *) b;
-    return ea->count > eb->count ? -1 : 1;
+    return count(ea->count) > count(eb->count) ? -1 : 1;
 }
 
 static void free_record(gpointer data)
@@ -180,11 +190,11 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
         class = &class_table[i];
         switch (class->what) {
         case COUNT_CLASS:
-            if (class->count || verbose) {
+            if (count(class->count) || verbose) {
                 g_string_append_printf(report,
                                        "Class: %-24s\t(%" PRId64 " hits)\n",
                                        class->class,
-                                       class->count);
+                                       count(class->count));
             }
             break;
         case COUNT_INDIVIDUAL:
@@ -212,7 +222,7 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
                                    "Instr: %-24s\t(%" PRId64 " hits)"
                                    "\t(op=0x%08x/%s)\n",
                                    rec->insn,
-                                   rec->count,
+                                   count(rec->count),
                                    rec->opcode,
                                    rec->class ?
                                    rec->class->class : "un-categorised");
@@ -233,7 +243,7 @@ static void plugin_init(void)
 static void vcpu_insn_exec_before(unsigned int cpu_index, void *udata)
 {
     uint64_t *count = (uint64_t *) udata;
-    (*count)++;
+    count[cpu_index]++;
 }
 
 static uint64_t *find_counter(struct qemu_plugin_insn *insn)
@@ -265,7 +275,7 @@ static uint64_t *find_counter(struct qemu_plugin_insn *insn)
     case COUNT_NONE:
         return NULL;
     case COUNT_CLASS:
-        return &class->count;
+        return class->count;
     case COUNT_INDIVIDUAL:
     {
         InsnExecCount *icount;
@@ -285,7 +295,7 @@ static uint64_t *find_counter(struct qemu_plugin_insn *insn)
         }
         g_mutex_unlock(&lock);
 
-        return &icount->count;
+        return icount->count;
     }
     default:
         g_assert_not_reached();
@@ -306,8 +316,9 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
 
         if (cnt) {
             if (do_inline) {
-                qemu_plugin_register_vcpu_insn_exec_inline(
-                    insn, QEMU_PLUGIN_INLINE_ADD_U64, cnt, 1);
+                qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
+                    insn, QEMU_PLUGIN_INLINE_ADD_U64,
+                    cnt, sizeof(uint64_t), 1);
             } else {
                 qemu_plugin_register_vcpu_insn_exec_cb(
                     insn, vcpu_insn_exec_before, QEMU_PLUGIN_CB_NO_REGS, cnt);
-- 
2.43.0


