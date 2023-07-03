Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A65A9745DFB
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 15:56:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGK01-0000r7-8A; Mon, 03 Jul 2023 09:53:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGJzj-0000YG-HY
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 09:53:35 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGJzh-00083P-PJ
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 09:53:35 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3110ab7110aso5171568f8f.3
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 06:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688392412; x=1690984412;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sa+wfZu+Nea0/Jly4iHaBSQb1C7qOF4WA65LCb+E1bE=;
 b=H6+sjVpMtyJgDkrpuWBa8TZDL8eqFuD3F0QZwLyApRSmCMwf8vYPtM+56oxmLAYOky
 zOUiqsu/obBJYrM4OhKl4BnxOfWCp3/mqQtUlfSfUFxq3DtwlB5rywBJOuWXlPEWkliu
 KKquyfA3biRf/j0oZ8GOapyU1VsBRJ92Obcsp3xO2vcwpQvSsnqkdb7g8VQBNH6YQ0nW
 utt0Be4LcpQGoEf7K8C1IMuH6nBuIWyexi+mSsPBQdkVhe+XwK3Y8RSn1Mo1Iv8cAr0j
 u9ak4XkFS83RaXmjcD4LfnnEo2dtKcARWSa35QrYeRbexnwDwvA5FRATVp1kwisEB37d
 T1KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688392412; x=1690984412;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Sa+wfZu+Nea0/Jly4iHaBSQb1C7qOF4WA65LCb+E1bE=;
 b=XCpc1n5RpB40U5vzuQUO8Jwe/2fhGoVX8oG+3wXRTTb+8rLf4teOAAsdRNZk6uBnuR
 myqjhr5jpwNhuvG+JfXOp3d+9u422oXBBGWLWOojJAJbIDDywS24HeIOfVBz99Wh+omz
 skgvxOBugkjdmByskiW6YL8vAohbo8rTPqHmxNphWFvwk6iJNLhqeT/5OBVYHLkKT2DL
 75V/C/dNYxItelrd89NeF0mdWQJsdk4Ja1SbWXPpuZ3o/y7EMFu0NtlL1pZTrAzuycil
 Pz4Fz6RkA9EEuNSBecx/nOY97mKgd4qeca+to9FSXqHAUIDkP123Xf+kngCFHw4Cibz4
 x4Yg==
X-Gm-Message-State: ABy/qLZbH0CfOJgiq6oAml+ijoD+y7uze0n0tf/+19xXhWVw+5pyZy7R
 UeGf6p5FZJ6whTJ5AhDRwFZ1uQ==
X-Google-Smtp-Source: APBJJlGaR7W1Y0I+l++kxgWd/Nut2Fv4fGcybvp/ptVolf1Cg2GXfwLoJPs3n0a+UPTyBUr17VJPpQ==
X-Received: by 2002:a05:6000:1250:b0:313:e526:f6dc with SMTP id
 j16-20020a056000125000b00313e526f6dcmr8256973wrx.48.1688392412482; 
 Mon, 03 Jul 2023 06:53:32 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 a11-20020a056000050b00b003110dc7f408sm25801998wrf.41.2023.07.03.06.53.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jul 2023 06:53:31 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B22551FFD9;
 Mon,  3 Jul 2023 14:44:31 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 34/38] gdbstub: Expose gdb_get_process() and
 gdb_get_first_cpu_in_process()
Date: Mon,  3 Jul 2023 14:44:23 +0100
Message-Id: <20230703134427.1389440-35-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230703134427.1389440-1-alex.bennee@linaro.org>
References: <20230703134427.1389440-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42f.google.com
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
Message-Id: <20230630180423.558337-35-alex.bennee@linaro.org>

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


