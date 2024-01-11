Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B8C82B097
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 15:25:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNvyt-0004U3-Pq; Thu, 11 Jan 2024 09:24:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rNvyl-0004Pu-QQ
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 09:24:20 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rNvyh-0002kr-8g
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 09:24:17 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3376f71fcbbso3419644f8f.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 06:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704983047; x=1705587847; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uKEHWzAFUZUFQemWuP8DkGrbgCslhiVNabDeLsILYDs=;
 b=IY+4PP3RRnYODzQ4PCuWOUaoD/2tBQUyeKp4EfDY8W10tK9bXGmkV3FPsmfEWWoZwe
 mEXUyZCLTqZjXkzQKJLPj0WNwtrhTRQIquwhjVjCJaOoz9zdXWABAjjMZHgCltOsPlUj
 kuqsdLm7kp+62uZVoq6q//MJRguQadrBGXhV1gEsOwADcMuH1jwata35rMn0hfQfcQPq
 iWRyGbbbs8n0wDaGYDNW613mexlmtc0jRQQR4EfdVUSRsPBnqYg2Zwia34rHvWojDu0E
 RfpcilZTTrshAC4JZNxXGoVZ0pBywropKD/tuT6soDECq2RSY7ZBnmvNsgj5Q5rN8aT8
 pxFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704983047; x=1705587847;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uKEHWzAFUZUFQemWuP8DkGrbgCslhiVNabDeLsILYDs=;
 b=aBXpwVBkH2L9miWWTjFM6m/Af0rpStdtqjtELKrVqaAXLY7ZIHvI1L/tpKRXX117Z9
 7bFlTGbznLkUDvyRfDP/svMBwwoDTn9cE3bj2WBCEiU8mk9PHYhNfGi4D2tIvvdlISbK
 kgm81fifTvfw4dAbvkEfIQPMtmPL7+Otma2en3j50PvwR/+GZSftxeyg/QF3M/eG0WIn
 fURWpdfmN2jcL8cYzx/Td/Fhqt0VHqeEUHDzDGKKRCylyoQYmM6h1VKScV8TNg2anPRS
 Sy61GN7T+R3lw5Mju8vM+g4Lrz5lmmlNsfOxw4BrtzqlCPDriGOXqSm3j4J3vmOwXznV
 digg==
X-Gm-Message-State: AOJu0YyXIJTtm6wfprhg2qrZCnfVexMtCkHLfOqb8ITOmLx1ZhxnQz4E
 KCIiRq194JQj/2xl+uWH5O4RQzdsGfDUYMd5OAwRseq6hZr42g==
X-Google-Smtp-Source: AGHT+IHbPTEMjQMFFOGAUXRWSV7rQCYyOTrnOQJQNB1DxsXcMgl8Q/xBdybDqw35azx938773nTiYw==
X-Received: by 2002:a05:6000:1090:b0:337:68aa:c63d with SMTP id
 y16-20020a056000109000b0033768aac63dmr495790wrw.37.1704983047533; 
 Thu, 11 Jan 2024 06:24:07 -0800 (PST)
Received: from linaro.. ([102.35.208.160]) by smtp.gmail.com with ESMTPSA id
 h7-20020adff4c7000000b0033677aae2e2sm1349000wrp.107.2024.01.11.06.24.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jan 2024 06:24:07 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH 09/12] contrib/plugins/hotblocks: migrate to new per_vcpu API
Date: Thu, 11 Jan 2024 18:23:22 +0400
Message-ID: <20240111142326.1743444-10-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240111142326.1743444-1-pierrick.bouvier@linaro.org>
References: <20240111142326.1743444-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wr1-x436.google.com
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
 contrib/plugins/hotblocks.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/contrib/plugins/hotblocks.c b/contrib/plugins/hotblocks.c
index 4de1b134944..1d95ac53143 100644
--- a/contrib/plugins/hotblocks.c
+++ b/contrib/plugins/hotblocks.c
@@ -17,6 +17,8 @@
 
 QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
 
+#define MAX_CPUS 8
+
 static bool do_inline;
 
 /* Plugins need to take care of their own locking */
@@ -34,16 +36,25 @@ static guint64 limit = 20;
  */
 typedef struct {
     uint64_t start_addr;
-    uint64_t exec_count;
+    uint64_t exec_count[MAX_CPUS];
     int      trans_count;
     unsigned long insns;
 } ExecCount;
 
+static uint64_t exec_count(ExecCount *e)
+{
+    uint64_t res = 0;
+    for (int i = 0; i < MAX_CPUS; ++i) {
+        res += e->exec_count[i];
+    }
+    return res;
+}
+
 static gint cmp_exec_count(gconstpointer a, gconstpointer b)
 {
     ExecCount *ea = (ExecCount *) a;
     ExecCount *eb = (ExecCount *) b;
-    return ea->exec_count > eb->exec_count ? -1 : 1;
+    return exec_count(ea) > exec_count(eb) ? -1 : 1;
 }
 
 static void plugin_exit(qemu_plugin_id_t id, void *p)
@@ -65,7 +76,7 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
             ExecCount *rec = (ExecCount *) it->data;
             g_string_append_printf(report, "0x%016"PRIx64", %d, %ld, %"PRId64"\n",
                                    rec->start_addr, rec->trans_count,
-                                   rec->insns, rec->exec_count);
+                                   rec->insns, exec_count(rec));
         }
 
         g_list_free(it);
@@ -89,7 +100,7 @@ static void vcpu_tb_exec(unsigned int cpu_index, void *udata)
     cnt = (ExecCount *) g_hash_table_lookup(hotblocks, (gconstpointer) hash);
     /* should always succeed */
     g_assert(cnt);
-    cnt->exec_count++;
+    cnt->exec_count[cpu_index]++;
     g_mutex_unlock(&lock);
 }
 
@@ -120,8 +131,9 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
     g_mutex_unlock(&lock);
 
     if (do_inline) {
-        qemu_plugin_register_vcpu_tb_exec_inline(tb, QEMU_PLUGIN_INLINE_ADD_U64,
-                                                 &cnt->exec_count, 1);
+        qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu(
+            tb, QEMU_PLUGIN_INLINE_ADD_U64,
+            cnt->exec_count, sizeof(uint64_t), 1);
     } else {
         qemu_plugin_register_vcpu_tb_exec_cb(tb, vcpu_tb_exec,
                                              QEMU_PLUGIN_CB_NO_REGS,
@@ -149,6 +161,7 @@ int qemu_plugin_install(qemu_plugin_id_t id, const qemu_info_t *info,
 
     plugin_init();
 
+    g_assert(info->system.smp_vcpus <= MAX_CPUS);
     qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans);
     qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
     return 0;
-- 
2.43.0


