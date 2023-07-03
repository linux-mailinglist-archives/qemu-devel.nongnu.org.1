Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F1556745DFE
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 15:56:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGK01-0000q5-8t; Mon, 03 Jul 2023 09:53:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGJzl-0000Zh-MC
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 09:53:37 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGJzj-00084b-Hx
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 09:53:37 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-31434226a2eso2184446f8f.1
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 06:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688392414; x=1690984414;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0VsK9/3tU0+hejhhrfU2ALG7tWi27m7Wvg/SQNXP0qo=;
 b=ZK2dmClZmO7T6iHa8m2roJx+Y13+jY1ze2Fo67g7n2cTZCzyPHTECWp5AEA9aTB+lT
 ZZt+woYbpx47UvbFvClrt3jaakLPfpnEUIH0NnkrrKwZRBzizHW+MSQYb8AwfL+Tce5i
 6R0OpafgtaDW3WWtPDk9jGmTvtL647bFDb2nHXbBnkLJ+9ipeLwtmSEqn7rhXGXhrSud
 Vcla9NNUOv15CKwEl3hw0MRynesrJpmUlgKql53wFaQX3P9icsHv6PpOL7JKueRJ9/jo
 IwbmcM7vk7CzVuV46UQF8EDDmRbYGeEtLlTlimzQ817xadi2qrT66DfwUrdLGP934CUr
 NjMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688392414; x=1690984414;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0VsK9/3tU0+hejhhrfU2ALG7tWi27m7Wvg/SQNXP0qo=;
 b=cXLu30SXZjiQhT7gINFchwRa7uccPT0iD73hyjNNak1Ds+j77Ri2LN0wGK4eeiHUEr
 y69hjTv3UljUMSFSv0wyu9n1Vmg66iVWykKMeZY8ogGf8qJyZhA0hvcABPWaAlsjrsyo
 5The+oc3o8MozytN1SgWgBn3E+YaZJYfuS6Uk4UD9E/f6NbozwrU74V1UG/TShgoLr9u
 2sU66DAygU4KZBvMLV8E/03swb2LY9cmWmsS6eJd3J6YSfN8SAuWwwfC1uXlA3m5d3gf
 m8A0TfWYiE6FGThqtjXUvsOc4vXkMbDdghqImreuViIi19uQXx7I2sxczP3tkyu+Dfl5
 5MDA==
X-Gm-Message-State: ABy/qLbaZOoD+c2Y9LdOEq2r3ts6NkwIYAjyEtj+pRWpQ8m8D8vRwDgt
 MpcY8rOs2KzeQ67u2iVslt+L/g==
X-Google-Smtp-Source: APBJJlGfVIU99Se0E2g8fr6wgC966wyaDGMdBTULMV+/K3uJSPaJpQ3l7uKhFTP1gVhLS0yEhgFr8A==
X-Received: by 2002:adf:f08f:0:b0:314:c7d:78aa with SMTP id
 n15-20020adff08f000000b003140c7d78aamr13017804wro.62.1688392414151; 
 Mon, 03 Jul 2023 06:53:34 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 v2-20020a5d6782000000b00313f5babb18sm19714523wru.9.2023.07.03.06.53.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jul 2023 06:53:31 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E7C7E1FFBB;
 Mon,  3 Jul 2023 14:44:31 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 Dominik 'Disconnect3d' Czarnota <dominik.b.czarnota@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 36/38] gdbstub: Add support for info proc mappings
Date: Mon,  3 Jul 2023 14:44:25 +0100
Message-Id: <20230703134427.1389440-37-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230703134427.1389440-1-alex.bennee@linaro.org>
References: <20230703134427.1389440-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x430.google.com
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

Currently the GDB's generate-core-file command doesn't work well with
qemu-user: the resulting dumps are huge [1] and at the same time
incomplete (argv and envp are missing). The reason is that GDB has no
access to proc mappings and therefore has to fall back to using
heuristics for discovering them. This is, in turn, because qemu-user
does not implement the Host I/O feature of the GDB Remote Serial
Protocol.

Implement vFile:{open,close,pread,readlink} and also
qXfer:exec-file:read+. With that, generate-core-file begins to work on
aarch64 and s390x.

[1] https://sourceware.org/pipermail/gdb-patches/2023-May/199432.html

Co-developed-by: Dominik 'Disconnect3d' Czarnota <dominik.b.czarnota@gmail.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-Id: <20230621203627.1808446-7-iii@linux.ibm.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20230630180423.558337-37-alex.bennee@linaro.org>

diff --git a/gdbstub/internals.h b/gdbstub/internals.h
index 25e4d5eeaa..f2b46cce41 100644
--- a/gdbstub/internals.h
+++ b/gdbstub/internals.h
@@ -189,6 +189,11 @@ typedef union GdbCmdVariant {
 void gdb_handle_query_rcmd(GArray *params, void *user_ctx); /* softmmu */
 void gdb_handle_query_offsets(GArray *params, void *user_ctx); /* user */
 void gdb_handle_query_xfer_auxv(GArray *params, void *user_ctx); /*user */
+void gdb_handle_v_file_open(GArray *params, void *user_ctx); /* user */
+void gdb_handle_v_file_close(GArray *params, void *user_ctx); /* user */
+void gdb_handle_v_file_pread(GArray *params, void *user_ctx); /* user */
+void gdb_handle_v_file_readlink(GArray *params, void *user_ctx); /* user */
+void gdb_handle_query_xfer_exec_file(GArray *params, void *user_ctx); /* user */
 
 void gdb_handle_query_attached(GArray *params, void *user_ctx); /* both */
 
diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 697dd4bbad..6911b73c07 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -1327,6 +1327,36 @@ static const GdbCmdParseEntry gdb_v_commands_table[] = {
         .cmd = "Kill;",
         .cmd_startswith = 1
     },
+#ifdef CONFIG_USER_ONLY
+    /*
+     * Host I/O Packets. See [1] for details.
+     * [1] https://sourceware.org/gdb/onlinedocs/gdb/Host-I_002fO-Packets.html
+     */
+    {
+        .handler = gdb_handle_v_file_open,
+        .cmd = "File:open:",
+        .cmd_startswith = 1,
+        .schema = "s,L,L0"
+    },
+    {
+        .handler = gdb_handle_v_file_close,
+        .cmd = "File:close:",
+        .cmd_startswith = 1,
+        .schema = "l0"
+    },
+    {
+        .handler = gdb_handle_v_file_pread,
+        .cmd = "File:pread:",
+        .cmd_startswith = 1,
+        .schema = "l,L,L0"
+    },
+    {
+        .handler = gdb_handle_v_file_readlink,
+        .cmd = "File:readlink:",
+        .cmd_startswith = 1,
+        .schema = "s0"
+    },
+#endif
 };
 
 static void handle_v_commands(GArray *params, void *user_ctx)
@@ -1472,11 +1502,14 @@ static void handle_query_supported(GArray *params, void *user_ctx)
             ";ReverseStep+;ReverseContinue+");
     }
 
-#if defined(CONFIG_USER_ONLY) && defined(CONFIG_LINUX)
+#if defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_LINUX)
     if (gdbserver_state.c_cpu->opaque) {
         g_string_append(gdbserver_state.str_buf, ";qXfer:auxv:read+");
     }
 #endif
+    g_string_append(gdbserver_state.str_buf, ";qXfer:exec-file:read+");
+#endif
 
     if (params->len &&
         strstr(get_param(params, 0)->data, "multiprocess+")) {
@@ -1615,13 +1648,21 @@ static const GdbCmdParseEntry gdb_gen_query_table[] = {
         .cmd_startswith = 1,
         .schema = "s:l,l0"
     },
-#if defined(CONFIG_USER_ONLY) && defined(CONFIG_LINUX)
+#if defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_LINUX)
     {
         .handler = gdb_handle_query_xfer_auxv,
         .cmd = "Xfer:auxv:read::",
         .cmd_startswith = 1,
         .schema = "l,l0"
     },
+#endif
+    {
+        .handler = gdb_handle_query_xfer_exec_file,
+        .cmd = "Xfer:exec-file:read:",
+        .cmd_startswith = 1,
+        .schema = "l:l,l0"
+    },
 #endif
     {
         .handler = gdb_handle_query_attached,
diff --git a/gdbstub/user-target.c b/gdbstub/user-target.c
index fa0e59ec9a..6e21c3161c 100644
--- a/gdbstub/user-target.c
+++ b/gdbstub/user-target.c
@@ -11,6 +11,10 @@
 #include "exec/gdbstub.h"
 #include "qemu.h"
 #include "internals.h"
+#ifdef CONFIG_LINUX
+#include "linux-user/loader.h"
+#include "linux-user/qemu.h"
+#endif
 
 /*
  * Map target signal numbers to GDB protocol signal numbers and vice
@@ -281,3 +285,136 @@ void gdb_handle_query_xfer_auxv(GArray *params, void *user_ctx)
                       gdbserver_state.str_buf->len, true);
 }
 #endif
+
+static const char *get_filename_param(GArray *params, int i)
+{
+    const char *hex_filename = get_param(params, i)->data;
+    gdb_hextomem(gdbserver_state.mem_buf, hex_filename,
+                 strlen(hex_filename) / 2);
+    g_byte_array_append(gdbserver_state.mem_buf, (const guint8 *)"", 1);
+    return (const char *)gdbserver_state.mem_buf->data;
+}
+
+static void hostio_reply_with_data(const void *buf, size_t n)
+{
+    g_string_printf(gdbserver_state.str_buf, "F%zx;", n);
+    gdb_memtox(gdbserver_state.str_buf, buf, n);
+    gdb_put_packet_binary(gdbserver_state.str_buf->str,
+                          gdbserver_state.str_buf->len, true);
+}
+
+void gdb_handle_v_file_open(GArray *params, void *user_ctx)
+{
+    const char *filename = get_filename_param(params, 0);
+    uint64_t flags = get_param(params, 1)->val_ull;
+    uint64_t mode = get_param(params, 2)->val_ull;
+
+#ifdef CONFIG_LINUX
+    int fd = do_guest_openat(gdbserver_state.g_cpu->env_ptr, 0, filename,
+                             flags, mode, false);
+#else
+    int fd = open(filename, flags, mode);
+#endif
+    if (fd < 0) {
+        g_string_printf(gdbserver_state.str_buf, "F-1,%d", errno);
+    } else {
+        g_string_printf(gdbserver_state.str_buf, "F%d", fd);
+    }
+    gdb_put_strbuf();
+}
+
+void gdb_handle_v_file_close(GArray *params, void *user_ctx)
+{
+    int fd = get_param(params, 0)->val_ul;
+
+    if (close(fd) == -1) {
+        g_string_printf(gdbserver_state.str_buf, "F-1,%d", errno);
+        gdb_put_strbuf();
+        return;
+    }
+
+    gdb_put_packet("F00");
+}
+
+void gdb_handle_v_file_pread(GArray *params, void *user_ctx)
+{
+    int fd = get_param(params, 0)->val_ul;
+    size_t count = get_param(params, 1)->val_ull;
+    off_t offset = get_param(params, 2)->val_ull;
+
+    size_t bufsiz = MIN(count, BUFSIZ);
+    g_autofree char *buf = g_try_malloc(bufsiz);
+    if (buf == NULL) {
+        gdb_put_packet("E12");
+        return;
+    }
+
+    ssize_t n = pread(fd, buf, bufsiz, offset);
+    if (n < 0) {
+        g_string_printf(gdbserver_state.str_buf, "F-1,%d", errno);
+        gdb_put_strbuf();
+        return;
+    }
+    hostio_reply_with_data(buf, n);
+}
+
+void gdb_handle_v_file_readlink(GArray *params, void *user_ctx)
+{
+    const char *filename = get_filename_param(params, 0);
+
+    g_autofree char *buf = g_try_malloc(BUFSIZ);
+    if (buf == NULL) {
+        gdb_put_packet("E12");
+        return;
+    }
+
+#ifdef CONFIG_LINUX
+    ssize_t n = do_guest_readlink(filename, buf, BUFSIZ);
+#else
+    ssize_t n = readlink(filename, buf, BUFSIZ);
+#endif
+    if (n < 0) {
+        g_string_printf(gdbserver_state.str_buf, "F-1,%d", errno);
+        gdb_put_strbuf();
+        return;
+    }
+    hostio_reply_with_data(buf, n);
+}
+
+void gdb_handle_query_xfer_exec_file(GArray *params, void *user_ctx)
+{
+    uint32_t pid = get_param(params, 0)->val_ul;
+    uint32_t offset = get_param(params, 1)->val_ul;
+    uint32_t length = get_param(params, 2)->val_ul;
+
+    GDBProcess *process = gdb_get_process(pid);
+    if (!process) {
+        gdb_put_packet("E00");
+        return;
+    }
+
+    CPUState *cpu = gdb_get_first_cpu_in_process(process);
+    if (!cpu) {
+        gdb_put_packet("E00");
+        return;
+    }
+
+    TaskState *ts = cpu->opaque;
+    if (!ts || !ts->bprm || !ts->bprm->filename) {
+        gdb_put_packet("E00");
+        return;
+    }
+
+    size_t total_length = strlen(ts->bprm->filename);
+    if (offset > total_length) {
+        gdb_put_packet("E00");
+        return;
+    }
+    if (offset + length > total_length) {
+        length = total_length - offset;
+    }
+
+    g_string_printf(gdbserver_state.str_buf, "l%.*s", length,
+                    ts->bprm->filename + offset);
+    gdb_put_strbuf();
+}
-- 
2.39.2


