Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5828311CC
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 04:26:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQJ1H-0003l5-Po; Wed, 17 Jan 2024 22:24:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rQJ1F-0003kO-MC
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 22:24:41 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rQJ1D-0002rh-T3
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 22:24:41 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-337cf4ac600so138213f8f.3
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 19:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705548278; x=1706153078; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OpYndL8vLGdfYul3boxTKF+u6iZVN8VJoSivXt39QS0=;
 b=nJHf9Dv2t6oBYZc3jlNmt/Q8n6gscNK8gtwjbifA2EgKbEXcUsk/HSf92tfSRG7JVH
 lDO/7wknyuGm4sFWcCPS7WQ3p7Z/y+XM2yxBUpsDBh4l/hARTC6fmuRjhgZa3WrBFfOM
 BCwLGP9sQJ2Ix5FSv10swf2Iw4AJg75CMSJmqb2HPjGSwEvDl3ANajPgZwO40S8rdWGr
 0qaq5llkj4OuvH0YPIwoX74kmDfSmYhqqzQA1WNq4Jqlrcb47SykM6/d4T76buprQzkD
 ya6Kv/8EGK36FXtBDFR+eyBS4L/bPyKNu/1Kb4Rey4peTx0NNqh6kvKekwGvltTfwS9S
 eG0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705548278; x=1706153078;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OpYndL8vLGdfYul3boxTKF+u6iZVN8VJoSivXt39QS0=;
 b=PcjK7YAkKYcbc5Xz3K+Wp6HbcT6KT59aampZMQIqlsJkMdqam6GTPJrXlUIKccgJcL
 9ONQ735QN0qEB4/HsB8nnJANtyo8x+BUhCucmzpxluiX+Ka9zHPc2vF6AfTLpi/uva1L
 as3Yj83LSQpP/WfUb0EbF1gYCSpGmVV+4shYekHFKITOBConA/dpGfec9P4HZkXBnKqk
 kc8pQtVsANO0NoM1XvXmv36c7d4B7NmWo4tjSxwZV7P1sMm6xnniwGVZewzvuN4xyD6T
 CiOsHea2l9KcwzWzloTsFZ22R+DpT7ZF7KMQvxTNK2UwzBAc+IRLsUaAgMMvbdMshAqc
 q8Eg==
X-Gm-Message-State: AOJu0YzHb8/fhrVFmJsbX4GY42U8tykU4aRTk2NvmqFKeCCdYBYr0JeC
 z5eODjeUyDQ4pnXa0IQBPhJIY9FRLiT0RL5knMblbUaxLcK9+8WBkL0VIm8Egb1s7mCxImGow/x
 LcBM=
X-Google-Smtp-Source: AGHT+IGSZ22z8wOU3luGE+66npr0jJm+T+TaGwphsd/Z33EwiBKs4Hm3OAliG8GaMPBc7d4rUxe+9A==
X-Received: by 2002:adf:9790:0:b0:337:c554:9987 with SMTP id
 s16-20020adf9790000000b00337c5549987mr106492wrb.45.1705548278378; 
 Wed, 17 Jan 2024 19:24:38 -0800 (PST)
Received: from linaro.. ([102.35.208.160]) by smtp.gmail.com with ESMTPSA id
 i2-20020adff302000000b0033788e357e1sm2894292wro.108.2024.01.17.19.24.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jan 2024 19:24:38 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH v2 09/14] contrib/plugins/hotblocks: migrate to new per_vcpu
 API
Date: Thu, 18 Jan 2024 07:23:54 +0400
Message-ID: <20240118032400.3762658-10-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240118032400.3762658-1-pierrick.bouvier@linaro.org>
References: <20240118032400.3762658-1-pierrick.bouvier@linaro.org>
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
 contrib/plugins/hotblocks.c | 46 +++++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 20 deletions(-)

diff --git a/contrib/plugins/hotblocks.c b/contrib/plugins/hotblocks.c
index 4de1b134944..fa1e2f02178 100644
--- a/contrib/plugins/hotblocks.c
+++ b/contrib/plugins/hotblocks.c
@@ -34,8 +34,8 @@ static guint64 limit = 20;
  */
 typedef struct {
     uint64_t start_addr;
-    uint64_t exec_count;
-    int      trans_count;
+    struct qemu_plugin_scoreboard *exec_count;
+    int trans_count;
     unsigned long insns;
 } ExecCount;
 
@@ -43,7 +43,15 @@ static gint cmp_exec_count(gconstpointer a, gconstpointer b)
 {
     ExecCount *ea = (ExecCount *) a;
     ExecCount *eb = (ExecCount *) b;
-    return ea->exec_count > eb->exec_count ? -1 : 1;
+    uint64_t count_a = qemu_plugin_u64_sum(qemu_plugin_u64(ea->exec_count));
+    uint64_t count_b = qemu_plugin_u64_sum(qemu_plugin_u64(eb->exec_count));
+    return count_a > count_b ? -1 : 1;
+}
+
+static void exec_count_free(gpointer key, gpointer value, gpointer user_data)
+{
+    ExecCount *cnt = value;
+    qemu_plugin_scoreboard_free(cnt->exec_count);
 }
 
 static void plugin_exit(qemu_plugin_id_t id, void *p)
@@ -52,7 +60,6 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
     GList *counts, *it;
     int i;
 
-    g_mutex_lock(&lock);
     g_string_append_printf(report, "%d entries in the hash table\n",
                            g_hash_table_size(hotblocks));
     counts = g_hash_table_get_values(hotblocks);
@@ -63,16 +70,20 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
 
         for (i = 0; i < limit && it->next; i++, it = it->next) {
             ExecCount *rec = (ExecCount *) it->data;
-            g_string_append_printf(report, "0x%016"PRIx64", %d, %ld, %"PRId64"\n",
-                                   rec->start_addr, rec->trans_count,
-                                   rec->insns, rec->exec_count);
+            g_string_append_printf(
+                report, "0x%016"PRIx64", %d, %ld, %"PRId64"\n",
+                rec->start_addr, rec->trans_count,
+                rec->insns,
+                qemu_plugin_u64_sum(qemu_plugin_u64(rec->exec_count)));
         }
 
         g_list_free(it);
     }
-    g_mutex_unlock(&lock);
 
     qemu_plugin_outs(report->str);
+
+    g_hash_table_foreach(hotblocks, exec_count_free, NULL);
+    g_hash_table_destroy(hotblocks);
 }
 
 static void plugin_init(void)
@@ -82,15 +93,8 @@ static void plugin_init(void)
 
 static void vcpu_tb_exec(unsigned int cpu_index, void *udata)
 {
-    ExecCount *cnt;
-    uint64_t hash = (uint64_t) udata;
-
-    g_mutex_lock(&lock);
-    cnt = (ExecCount *) g_hash_table_lookup(hotblocks, (gconstpointer) hash);
-    /* should always succeed */
-    g_assert(cnt);
-    cnt->exec_count++;
-    g_mutex_unlock(&lock);
+    ExecCount *cnt = (ExecCount *)udata;
+    (*qemu_plugin_u64_get(qemu_plugin_u64(cnt->exec_count), cpu_index))++;
 }
 
 /*
@@ -114,18 +118,20 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
         cnt->start_addr = pc;
         cnt->trans_count = 1;
         cnt->insns = insns;
+        cnt->exec_count = qemu_plugin_scoreboard_new(sizeof(uint64_t));
         g_hash_table_insert(hotblocks, (gpointer) hash, (gpointer) cnt);
     }
 
     g_mutex_unlock(&lock);
 
     if (do_inline) {
-        qemu_plugin_register_vcpu_tb_exec_inline(tb, QEMU_PLUGIN_INLINE_ADD_U64,
-                                                 &cnt->exec_count, 1);
+        qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu(
+            tb, QEMU_PLUGIN_INLINE_ADD_U64,
+            qemu_plugin_u64(cnt->exec_count), 1);
     } else {
         qemu_plugin_register_vcpu_tb_exec_cb(tb, vcpu_tb_exec,
                                              QEMU_PLUGIN_CB_NO_REGS,
-                                             (void *)hash);
+                                             (void *)cnt);
     }
 }
 
-- 
2.43.0


