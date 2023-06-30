Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6B874420B
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 20:18:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFIch-0005Na-EO; Fri, 30 Jun 2023 14:13:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qFIcf-0005MZ-5C
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 14:13:33 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qFIcb-0003VM-Rh
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 14:13:32 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3fbc6ab5ff5so11409535e9.1
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 11:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688148808; x=1690740808;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=noOnfZ3FZdhjlEdVG7JVDMqP/nuQCMSustvyazImnlo=;
 b=VI98akRwt+XRNJczc8Rm7Mri7D3wdEaxHfy4i2FpSwkGWFOT8c9z4uJY0nCScc+yTL
 8nt47fOni/djJJkt9WHOTT38BjH1v7A+MSafLkL3bX2Z4ZGdT43Z4muuu8D8jKRH6zSF
 +Mx8TUE8OIw7JhgUASMh4ni3Iwr/i+b6B5pxL6YV6BjOAW9NzWCKHnzRXN+TBIiEa9eg
 NzgeMCiAhVetkSluWlUv4mVJfL2m4SWloAtFylnE+EKQnyt5/mptFgj+KJYbvKdrjrTv
 6ElS6LNDloaGwnd1h86THJvP5+25SrlDQBRpuzndP8YHXtd9dkzdIO0fZ7XB+P0dpcYO
 1/mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688148808; x=1690740808;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=noOnfZ3FZdhjlEdVG7JVDMqP/nuQCMSustvyazImnlo=;
 b=cjni8wDgvSjUyHXVZQrrDBvxfoMoDwuoRr3kULq90a53rUxKf5pSr7sepTc2Wj0Utc
 XkXiAQbbmtvOLgsGNnW0yn/MTBf9bb2+HIHEAF2ZtZsH12AFuhjr64tSl0h/RIKwok6B
 hmw0yTfLZKCk8tsbDS8oImS7rzE2euZauRtxwSPX3Bn5Rh6jbPldosm+IjoR9qYFluVp
 dTsDl1+Szuaw1YqsDKWOOWyBJoWeAapBTJ4e15YP5ivcARJ+dLMwkZaWGPProSPBXJpv
 Z8+2PKNbPNYQggK9WpSJtzzD3bNR/0/l4X5GxAw+v8t8oUgFH0AvTsaO27MbUgB5lbxs
 x/sg==
X-Gm-Message-State: AC+VfDwws34sHCaiW8lToibj8qjZ2k5xzskWP60RgVAdQGZTKQdnDXpe
 bZuNQk92Dv+3+ARlZos2CSMhzg==
X-Google-Smtp-Source: ACHHUZ48XT9nFT8Wj8row2H1nw673vwJncEMDp6jKdT6UW9ER2k5PEpNi5PrfLHFIpvdfZTVTw7VGg==
X-Received: by 2002:a05:600c:b52:b0:3fb:afc0:56c5 with SMTP id
 k18-20020a05600c0b5200b003fbafc056c5mr2699745wmr.12.1688148807936; 
 Fri, 30 Jun 2023 11:13:27 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 l21-20020a7bc455000000b003fa95c466a1sm15232380wmi.5.2023.06.30.11.13.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jun 2023 11:13:27 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 696FD1FFD5;
 Fri, 30 Jun 2023 19:04:27 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Peter Xu <peterx@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Radoslaw Biernacki <rad@semihalf.com>,
 Qiuhao Li <Qiuhao.Li@outlook.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Riku Voipio <riku.voipio@iki.fi>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Bandan Das <bsd@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, qemu-arm@nongnu.org,
 Darren Kenny <darren.kenny@oracle.com>, Alexander Bulekov <alxndr@bu.edu>
Subject: [PATCH v4 30/38] gdbstub: clean-up vcont handling to avoid goto
Date: Fri, 30 Jun 2023 19:04:15 +0100
Message-Id: <20230630180423.558337-31-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230630180423.558337-1-alex.bennee@linaro.org>
References: <20230630180423.558337-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Message-Id: <20230627160943.2956928-29-alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 gdbstub/gdbstub.c | 28 +++++++++-------------------
 1 file changed, 9 insertions(+), 19 deletions(-)

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


