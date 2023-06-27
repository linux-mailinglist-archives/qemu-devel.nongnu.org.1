Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 745667400B1
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 18:18:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEBML-00016A-1J; Tue, 27 Jun 2023 12:16:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qEBMH-00011M-2x
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 12:16:01 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qEBMA-00088u-Gp
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 12:16:00 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3fba64d9296so9233325e9.3
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 09:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687882552; x=1690474552;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=81Ksm8uVTMPnt2+cnp4q2zmd0NQ6258gRF87FUOPn3E=;
 b=e08SsTOg9xG2QdllDTmBh4BxNQ34xDnN0WEvIFDik4Q7Sb+otfh8AvdGlmDM8VbHNe
 6U+RgzKtR9LLnI/QKhmLSGLFok6CiCzjWVfnW6TQyPUG4CXBgAmknPzD6NS8c7YB2Xd0
 JaQUSBW7A5mGSUC8k2HGpnBJMNVyHM5QdrVcbNNO2d5P53aLflnDBAkGEvzXz7/UBwnk
 gXssVnwHV7OhGIgVYyBSYY61yDlMJRhdHPGsoEJtqZx5ALSxSktjBtxARKjoCgFbP3X5
 9H6aG40AjAoRyiiB+JKSqHpIQfbjwAPh44ThRvVCqMkR6AqSQlb9qRpMcBQ3c1XlWnFE
 VZSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687882552; x=1690474552;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=81Ksm8uVTMPnt2+cnp4q2zmd0NQ6258gRF87FUOPn3E=;
 b=UU8HTAhtzQwDJjr7p58BCqxW9NE8bFZLZFhD1GpWXqFfYEL5lFNXjQSm7lV3MX6Fuv
 pNHZKTBkjQc8kxkzvfviMaefV7UN5iGp27OWKbpR8SlA2qnPjkvGdWr5fl05AIqhML/B
 mB364CBNJJelxtuQ9HqFvwsqSgHrCSc4lFs0V7BX/N32c+n7O0l7YoTs1wWgcVefE3Kx
 E34JRdc+bMVyG/iKQz1FqkiL5MEW5xM2jRAmbGkZG0ZfaaAjQx4Kab6S1jqdTZ9IgA79
 8C3s9V0eVqLPbz7VU57u584Mz+4sPTgbCQ8cSyAcSq8rnLYs2Yqrp3eJhsNqoOkuaheU
 PJ7g==
X-Gm-Message-State: AC+VfDyww3LUCxVrTh9T8n0voCnZgVkaWSA+JMK+x+N7J5RNupHgokcL
 xjq1p2SMkCuRq4cbTrUP0aC3gw==
X-Google-Smtp-Source: ACHHUZ6nc3rX2BXRflcFq1kVX7972jAEjN026t2SoqecuUCXuQAlo5JbDlJI8lFBht7RCRJx+bDLFQ==
X-Received: by 2002:a05:600c:219a:b0:3fa:993f:acc1 with SMTP id
 e26-20020a05600c219a00b003fa993facc1mr4264819wme.2.1687882552620; 
 Tue, 27 Jun 2023 09:15:52 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 a16-20020adfdd10000000b00313ef2150dcsm7136675wrm.45.2023.06.27.09.15.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jun 2023 09:15:50 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A75691FFD9;
 Tue, 27 Jun 2023 17:09:47 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Yanan Wang <wangyanan55@huawei.com>,
 Darren Kenny <darren.kenny@oracle.com>, Alexander Bulekov <alxndr@bu.edu>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Radoslaw Biernacki <rad@semihalf.com>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-arm@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bandan Das <bsd@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Laurent Vivier <lvivier@redhat.com>, Qiuhao Li <Qiuhao.Li@outlook.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v3 32/36] gdbstub: Expose gdb_get_process() and
 gdb_get_first_cpu_in_process()
Date: Tue, 27 Jun 2023 17:09:39 +0100
Message-Id: <20230627160943.2956928-33-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230627160943.2956928-1-alex.bennee@linaro.org>
References: <20230627160943.2956928-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

These functions will be needed by user-target.c in order to retrieve
the name of the executable.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-Id: <20230621203627.1808446-5-iii@linux.ibm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 gdbstub/internals.h |  2 ++
 gdbstub/gdbstub.c   | 16 ++++++++--------
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/gdbstub/internals.h b/gdbstub/internals.h
index 33d21d6488..25e4d5eeaa 100644
--- a/gdbstub/internals.h
+++ b/gdbstub/internals.h
@@ -129,6 +129,8 @@ void gdb_read_byte(uint8_t ch);
  */
 bool gdb_got_immediate_ack(void);
 /* utility helpers */
+GDBProcess *gdb_get_process(uint32_t pid);
+CPUState *gdb_get_first_cpu_in_process(GDBProcess *process);
 CPUState *gdb_first_attached_cpu(void);
 void gdb_append_thread_id(CPUState *cpu, GString *buf);
 int gdb_get_cpu_index(CPUState *cpu);
diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 49143c7d83..ce3e4a2671 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -211,7 +211,7 @@ static uint32_t gdb_get_cpu_pid(CPUState *cpu)
     return cpu->cluster_index + 1;
 }
 
-static GDBProcess *gdb_get_process(uint32_t pid)
+GDBProcess *gdb_get_process(uint32_t pid)
 {
     int i;
 
@@ -247,7 +247,7 @@ static CPUState *find_cpu(uint32_t thread_id)
     return NULL;
 }
 
-static CPUState *get_first_cpu_in_process(GDBProcess *process)
+CPUState *gdb_get_first_cpu_in_process(GDBProcess *process)
 {
     CPUState *cpu;
 
@@ -325,7 +325,7 @@ static CPUState *gdb_get_cpu(uint32_t pid, uint32_t tid)
             return NULL;
         }
 
-        return get_first_cpu_in_process(process);
+        return gdb_get_first_cpu_in_process(process);
     } else {
         /* a specific thread */
         cpu = find_cpu(tid);
@@ -354,7 +354,7 @@ static const char *get_feature_xml(const char *p, const char **newp,
     size_t len;
     int i;
     const char *name;
-    CPUState *cpu = get_first_cpu_in_process(process);
+    CPUState *cpu = gdb_get_first_cpu_in_process(process);
     CPUClass *cc = CPU_GET_CLASS(cpu);
 
     len = 0;
@@ -490,7 +490,7 @@ void gdb_register_coprocessor(CPUState *cpu,
 
 static void gdb_process_breakpoint_remove_all(GDBProcess *p)
 {
-    CPUState *cpu = get_first_cpu_in_process(p);
+    CPUState *cpu = gdb_get_first_cpu_in_process(p);
 
     while (cpu) {
         gdb_breakpoint_remove_all(cpu);
@@ -647,7 +647,7 @@ static int gdb_handle_vcont(const char *p)
                 return -EINVAL;
             }
 
-            cpu = get_first_cpu_in_process(process);
+            cpu = gdb_get_first_cpu_in_process(process);
             while (cpu) {
                 if (newstates[cpu->cpu_index] == 1) {
                     newstates[cpu->cpu_index] = cur_action;
@@ -1270,7 +1270,7 @@ static void handle_v_attach(GArray *params, void *user_ctx)
         goto cleanup;
     }
 
-    cpu = get_first_cpu_in_process(process);
+    cpu = gdb_get_first_cpu_in_process(process);
     if (!cpu) {
         goto cleanup;
     }
@@ -1393,7 +1393,7 @@ static void handle_query_curr_tid(GArray *params, void *user_ctx)
      * first thread).
      */
     process = gdb_get_cpu_process(gdbserver_state.g_cpu);
-    cpu = get_first_cpu_in_process(process);
+    cpu = gdb_get_first_cpu_in_process(process);
     g_string_assign(gdbserver_state.str_buf, "QC");
     gdb_append_thread_id(cpu, gdbserver_state.str_buf);
     gdb_put_strbuf();
-- 
2.39.2


