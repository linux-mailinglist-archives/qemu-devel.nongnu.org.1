Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B26745E00
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 15:56:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGJzv-0000bX-NZ; Mon, 03 Jul 2023 09:53:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGJzj-0000YA-B8
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 09:53:35 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGJzh-00082s-38
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 09:53:35 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-314172bb818so5153877f8f.1
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 06:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688392411; x=1690984411;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zNMPVNXEa7UqeTcFlr3/SM98KrOm4fYZhU+BaBqT8mY=;
 b=uV9ZPLS81d0MTVEY2cXnk2V+85sjXaItitw7BNEe0vITv33afOl6HFjqmyV8LC912u
 8J4ONws8InNEoZ7jXMdLonNXnd/ledyMXbioCq8y0G5DWrlWheBJJRuu2pK/JS4DJWpm
 8jMEHcH9F4ekDUddaTIVCA8o5mZ7xzZg/6hMs2dtAKg/xpqIzMSI/YWAytml6gabZ64L
 eqhI+rlYq6KFU7fzwMZnRFKewmNijj0IIaivjJQUrqLX1U7EmvzIvtGtd4o68ECNgCR1
 p4HRyC1ChOiYd1uDWlzBsMGcsbT8ULupwp+Oa/GzaS0VVHcozwwUNyenlDr3p5YGdzZ8
 YnzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688392411; x=1690984411;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zNMPVNXEa7UqeTcFlr3/SM98KrOm4fYZhU+BaBqT8mY=;
 b=h+rHrX64cfAc49CBY3PoEEMqKU7utLxpm0dvz63CRafADD4Kv9a5Lh5FosmkdIQZXT
 N4xJ75yxAqL9RP0b+E9pH+UdBLbwHAiJBETVkKxGNGXnXNw+D7TSmOzXk/Zb/6gq5Nzw
 z6XdaqId8n7E0Zs49EAj7shU1dtTF68p3fd+kKOjwmmif4E93jL4m0h/hNDuMz3hGpep
 mhB/kcDyZ/8zp0cPlFEwCto5lOwwB3Yd3wXKy7ya4R+JUvEREaD2XrEbgsJRxX0X8Cnz
 kRfJAXe/C3OpVEeEnI8yK4qIfGEjNarorRyXb9ztqP32LVQwRXUyfQtKWHp5yPEuhQBx
 5zeA==
X-Gm-Message-State: ABy/qLaooFA2dQwfdI9KMl6SCHQEKgznEJBNFwwtrmbNXJC6Wi23lRFS
 PSID28BWL1YLhxBGEwz8huKPIA==
X-Google-Smtp-Source: APBJJlF1hDSDIHbWsmZ7oSZQR7ecBNg+bE6k6dYf0ghtct1fE4AnPWe2xcUPhSIYeulgnc57ThT5BA==
X-Received: by 2002:adf:fc08:0:b0:314:824:378c with SMTP id
 i8-20020adffc08000000b003140824378cmr8597854wrr.20.1688392411749; 
 Mon, 03 Jul 2023 06:53:31 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 w10-20020adfcd0a000000b003141f96ed36sm9420092wrm.0.2023.07.03.06.53.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jul 2023 06:53:29 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 49DB21FFC1;
 Mon,  3 Jul 2023 14:44:31 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 30/38] gdbstub: clean-up vcont handling to avoid goto
Date: Mon,  3 Jul 2023 14:44:19 +0100
Message-Id: <20230703134427.1389440-31-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230703134427.1389440-1-alex.bennee@linaro.org>
References: <20230703134427.1389440-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42c.google.com
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

We can handle all the error exit cases by using g_autofree() for the
one thing that needs cleaning up on the exit.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20230630180423.558337-31-alex.bennee@linaro.org>

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 9496d7b175..49143c7d83 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -573,7 +573,6 @@ static int gdb_handle_vcont(const char *p)
 {
     int res, signal = 0;
     char cur_action;
-    char *newstates;
     unsigned long tmp;
     uint32_t pid, tid;
     GDBProcess *process;
@@ -581,7 +580,7 @@ static int gdb_handle_vcont(const char *p)
     GDBThreadIdKind kind;
     unsigned int max_cpus = gdb_get_max_cpus();
     /* uninitialised CPUs stay 0 */
-    newstates = g_new0(char, max_cpus);
+    g_autofree char *newstates = g_new0(char, max_cpus);
 
     /* mark valid CPUs with 1 */
     CPU_FOREACH(cpu) {
@@ -597,8 +596,7 @@ static int gdb_handle_vcont(const char *p)
     res = 0;
     while (*p) {
         if (*p++ != ';') {
-            res = -ENOTSUP;
-            goto out;
+            return -ENOTSUP;
         }
 
         cur_action = *p++;
@@ -606,13 +604,12 @@ static int gdb_handle_vcont(const char *p)
             cur_action = qemu_tolower(cur_action);
             res = qemu_strtoul(p, &p, 16, &tmp);
             if (res) {
-                goto out;
+                return res;
             }
             signal = gdb_signal_to_target(tmp);
         } else if (cur_action != 'c' && cur_action != 's') {
             /* unknown/invalid/unsupported command */
-            res = -ENOTSUP;
-            goto out;
+            return -ENOTSUP;
         }
 
         if (*p == '\0' || *p == ';') {
@@ -625,14 +622,12 @@ static int gdb_handle_vcont(const char *p)
         } else if (*p++ == ':') {
             kind = read_thread_id(p, &p, &pid, &tid);
         } else {
-            res = -ENOTSUP;
-            goto out;
+            return -ENOTSUP;
         }
 
         switch (kind) {
         case GDB_READ_THREAD_ERR:
-            res = -EINVAL;
-            goto out;
+            return -EINVAL;
 
         case GDB_ALL_PROCESSES:
             cpu = gdb_first_attached_cpu();
@@ -649,8 +644,7 @@ static int gdb_handle_vcont(const char *p)
             process = gdb_get_process(pid);
 
             if (!process->attached) {
-                res = -EINVAL;
-                goto out;
+                return -EINVAL;
             }
 
             cpu = get_first_cpu_in_process(process);
@@ -668,8 +662,7 @@ static int gdb_handle_vcont(const char *p)
 
             /* invalid CPU/thread specified */
             if (!cpu) {
-                res = -EINVAL;
-                goto out;
+                return -EINVAL;
             }
 
             /* only use if no previous match occourred */
@@ -679,12 +672,9 @@ static int gdb_handle_vcont(const char *p)
             break;
         }
     }
+
     gdbserver_state.signal = signal;
     gdb_continue_partial(newstates);
-
-out:
-    g_free(newstates);
-
     return res;
 }
 
-- 
2.39.2


