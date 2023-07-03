Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC36745DEC
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 15:54:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGJzo-0000aO-73; Mon, 03 Jul 2023 09:53:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGJzk-0000ZR-OY
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 09:53:36 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGJzj-00084J-5z
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 09:53:36 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3fbac8b01b3so36818035e9.1
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 06:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688392414; x=1690984414;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8cD1juvMLwUrVgA78Nj95KzI+qlKYsgqazsEWOJa4kM=;
 b=ne/oC3459NmHqDNO0SQtOOCxAL7b/YaAKykEFoo4m9WWY0Vcuztse0cMB4UKZ3V/PU
 6f4WAgaggdog8fzA3ByRUCN9oQeYY4IaN9+zMhi7/9T5DGegiGVj0lxGxt+77AkSVvB2
 X0y8iKj9axsQuU0PvLNkV+pSG47SiNo+fS5WaT1Or9RMYiLb8x+Wf5RKTO/rV/HpaUjX
 qXxJfXcjaWA7e+EwQ8LIgSiEP4owbKUv+oCCYwgVHDpkaxXpArTqejoH5Hb/gJq3Wb2p
 HW/IJAwRpYgjONuGo9T+Drr4dJhvHgszfZXM/rmjAjhFl5+W5oZkPPK00+4wTxwY+Wsj
 0DEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688392414; x=1690984414;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8cD1juvMLwUrVgA78Nj95KzI+qlKYsgqazsEWOJa4kM=;
 b=Lys5tjofcrQKgJCKwKY6IiAfGLH7Emk6PEHXW7xNajii0qVkgr+mk0GIKPH6xnQfcG
 ohMLs5ERTdFlmSe//m4cI+s0WM80lsY+q4JuaktW/uu1KVjP/45O/9loCzit3JNhlcFQ
 3wB2A/ft+fzY+hU71r2OGFvoU7GtMDFUXw8DOYWyk6yO9faWxcYeDRzX9m6QV7OWWVSK
 lh1wbO/osHOpJnn4npGYyTAQ1d3/qQovXF1GTuUfa+juOxcDMfr49GWmqJb1l5U5KP2p
 9tj66dYQq7jPOoJiUQuVW//WXDp/QjVjah66wFTU+Uyth/v78LX2NAO9++BF5vebaKYx
 R5Wg==
X-Gm-Message-State: AC+VfDzlDw+3DOkAZyutEsFu9oPuJAM+RexqLgPcWlim04GucaNiF/p/
 zEeX8EiijIKf5uBCJXySrjadhA==
X-Google-Smtp-Source: ACHHUZ6cvN3McEbazb9Zi2FnxYT6PBnD6AWvrCoAqZOyWzqNOD1mLF2RIT08j0TOmftbX37g93vWmA==
X-Received: by 2002:a1c:6a1a:0:b0:3fb:2d92:ecf1 with SMTP id
 f26-20020a1c6a1a000000b003fb2d92ecf1mr9020465wmc.7.1688392413921; 
 Mon, 03 Jul 2023 06:53:33 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 d13-20020adfe88d000000b0031438257aa9sm2236910wrm.36.2023.07.03.06.53.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jul 2023 06:53:31 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C9F7F1FFDD;
 Mon,  3 Jul 2023 14:44:31 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 35/38] gdbstub: Report the actual qemu-user pid
Date: Mon,  3 Jul 2023 14:44:24 +0100
Message-Id: <20230703134427.1389440-36-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230703134427.1389440-1-alex.bennee@linaro.org>
References: <20230703134427.1389440-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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

Currently qemu-user reports pid 1 to GDB. Resolve the TODO and report
the actual PID. Using getpid() relies on the assumption that there is
only one GDBProcess. Add an assertion to make sure that future changes
don't break it.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-Id: <20230621203627.1808446-6-iii@linux.ibm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20230630180423.558337-36-alex.bennee@linaro.org>

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index ce3e4a2671..697dd4bbad 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -202,13 +202,16 @@ void gdb_memtox(GString *buf, const char *mem, int len)
 
 static uint32_t gdb_get_cpu_pid(CPUState *cpu)
 {
-    /* TODO: In user mode, we should use the task state PID */
+#ifdef CONFIG_USER_ONLY
+    return getpid();
+#else
     if (cpu->cluster_index == UNASSIGNED_CLUSTER_INDEX) {
         /* Return the default process' PID */
         int index = gdbserver_state.process_num - 1;
         return gdbserver_state.processes[index].pid;
     }
     return cpu->cluster_index + 1;
+#endif
 }
 
 GDBProcess *gdb_get_process(uint32_t pid)
@@ -2137,19 +2140,25 @@ void gdb_read_byte(uint8_t ch)
 void gdb_create_default_process(GDBState *s)
 {
     GDBProcess *process;
-    int max_pid = 0;
+    int pid;
 
+#ifdef CONFIG_USER_ONLY
+    assert(gdbserver_state.process_num == 0);
+    pid = getpid();
+#else
     if (gdbserver_state.process_num) {
-        max_pid = s->processes[s->process_num - 1].pid;
+        pid = s->processes[s->process_num - 1].pid;
+    } else {
+        pid = 0;
     }
+    /* We need an available PID slot for this process */
+    assert(pid < UINT32_MAX);
+    pid++;
+#endif
 
     s->processes = g_renew(GDBProcess, s->processes, ++s->process_num);
     process = &s->processes[s->process_num - 1];
-
-    /* We need an available PID slot for this process */
-    assert(max_pid < UINT32_MAX);
-
-    process->pid = max_pid + 1;
+    process->pid = pid;
     process->attached = false;
     process->target_xml[0] = '\0';
 }
-- 
2.39.2


