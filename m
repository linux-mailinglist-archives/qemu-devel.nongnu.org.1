Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F3C7441F9
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 20:16:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFIdA-0005oS-M7; Fri, 30 Jun 2023 14:14:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qFIcj-0005RB-3d
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 14:13:37 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qFIcf-0003We-3o
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 14:13:36 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-313e12db357so2606714f8f.0
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 11:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688148811; x=1690740811;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SoVkw0L+f6XIdwSZ6FAqdyofp7PL2+Kglo7DXQJdr40=;
 b=AP/Rlf6e99gv9BooQEC/vc572Klz3nz+Bny+hh3EX9qq0l9DFDq0HQm16l/UNFORvY
 qJyH2ibQ+/DhXEpdh1XxAW97Tl1eOtB7NrSpi4TKtKoOdWgguTXtB1hT7fNfdb3zWiWZ
 mCrz/e8KZQrjmmPlC+nolasAZG88UZiWWSDIXsxlj+jxpW6t9Ap568npycZZ5kD3Wbxu
 TZqLmHFoP+89k8xsbhi249P4wPHkZ+HIxGI6/vouSfN5fWemIgVIdtX71up6CvGPs8i9
 pFlyTDpwhYvv6GQEXISs0K5gzlYRReXphcu4VZLSbB9ryBusCJJ2VliqlNXFCnV9j0iq
 Ag4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688148811; x=1690740811;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SoVkw0L+f6XIdwSZ6FAqdyofp7PL2+Kglo7DXQJdr40=;
 b=a0MNl9Uq1nfGkKyPrLHo+5w5h/3Fzwp0JKB2j438ylljhL/SOzjsVdkyq1bNLj98eA
 XmOlT4OlldBD+0MfHmLs9WxY0HOTAPkzh1l3IqTBpVy5+V+sqSStUIvsZCWBR8EjcNsB
 76OydRybsiQ6ccIuUmzH5jQ6CR0o6ZThFvYv8k3agcY8I8tM9uPUu2YEC4iveH80lxyb
 RKR7kp3OwP5Mj0DZAVl4HYh2B5+f9hrJwdK+xJu77odX9HwT3pUuMZlKjTH6zUEltMBo
 Nb6YWh0oZXcsHmVbGbIEE/gYd8O3WGx6S8i1DQMP19ZXZbh8Rbd2Y8ZLB+bXzpPm1p+X
 gklw==
X-Gm-Message-State: ABy/qLZoY1oGCtyWtujBh6tIvbAlTexf+dOgRlHb4OksLP87/Uo4PHBB
 bBewE2w2fZdSVviU67Mjiapd/A==
X-Google-Smtp-Source: APBJJlGgclgUa8kE/4ZBYXa5up0oUuQMmVDUy2fo3NKYm4bZTmfE+f8ZEIrbeZnuqpnLvHQeNHwyXA==
X-Received: by 2002:adf:dfcf:0:b0:313:f783:262a with SMTP id
 q15-20020adfdfcf000000b00313f783262amr3122266wrn.21.1688148811385; 
 Fri, 30 Jun 2023 11:13:31 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 c13-20020adfe74d000000b0030ae499da59sm3805869wrn.111.2023.06.30.11.13.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jun 2023 11:13:30 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1A9831FFE1;
 Fri, 30 Jun 2023 19:04:28 +0100 (BST)
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
 Darren Kenny <darren.kenny@oracle.com>, Alexander Bulekov <alxndr@bu.edu>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Dominik 'Disconnect3d' Czarnota <dominik.b.czarnota@gmail.com>
Subject: [PATCH v4 36/38] gdbstub: Add support for info proc mappings
Date: Fri, 30 Jun 2023 19:04:21 +0100
Message-Id: <20230630180423.558337-37-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230630180423.558337-1-alex.bennee@linaro.org>
References: <20230630180423.558337-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x433.google.com
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

---
v3
  - remove #define BUFSIZ (both linux and BSD define it but BSD complains if
  you redefine it)
---
 gdbstub/internals.h   |   5 ++
 gdbstub/gdbstub.c     |  45 +++++++++++++-
 gdbstub/user-target.c | 137 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 185 insertions(+), 2 deletions(-)

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


