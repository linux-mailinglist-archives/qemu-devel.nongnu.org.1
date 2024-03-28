Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D43D387CD42
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Mar 2024 13:30:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl6hR-0002DM-Ly; Fri, 15 Mar 2024 08:30:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1rl6h9-0002CN-Vv
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 08:29:56 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1rl6h6-0006OT-Hn
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 08:29:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-Id:Date:Subject:From:
 Content-Type; bh=LI4Zjt2kmsotdBVKwkUebV826YtkKLl6ksUtmYYkisA=; b=h2EHbiHxZbOW
 926K4H1p/nZouq1o0yST2h3iNqfjYxOOpL1EXnpBaQEbdP+b17f0Z+3fVJq2l+59/FNunvw9cQLkf
 llpwmDreF6h5zI7108p2lS65wsb2Ax6bDtW87dBL9N9mHjt47++MIgjePlda5+4ijBwzro++y33U8
 tDx6vOBg/1XX36zRzA6CmpMYUEIlAGVjftMTKJqpP3o4a4pT645vitwC1TUg7Pl/NiqvgTESIuuON
 XeTwZKJNXM7pyuRx8AFp6FcQmbpbt+JIWSx0FncaoM6cfMjp21M/7iRYJ38Gdj5iVny5V8t0cbu9I
 Dxt6lTS/alEWjsLIwZqHaQ==;
Received: from [130.117.225.1] (helo=dev005.ch-qa.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <andrey.drobyshev@virtuozzo.com>) id 1rl6f5-005Caf-06;
 Fri, 15 Mar 2024 13:29:46 +0100
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, michael.roth@amd.com, kkostiuk@redhat.com,
 marcandre.lureau@redhat.com, philmd@linaro.org,
 andrey.drobyshev@virtuozzo.com, den@virtuozzo.com
Subject: [PATCH v3 2/7] qga: introduce ga_run_command() helper for guest cmd
 execution
Date: Fri, 15 Mar 2024 14:29:41 +0200
Message-Id: <20240315122946.39168-3-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240315122946.39168-1-andrey.drobyshev@virtuozzo.com>
References: <20240315122946.39168-1-andrey.drobyshev@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=130.117.225.111;
 envelope-from=andrey.drobyshev@virtuozzo.com; helo=relay.virtuozzo.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

When executing guest commands in *nix environment, we repeat the same
fork/exec pattern multiple times.  Let's just separate it into a single
helper which would also be able to feed input data into the launched
process' stdin.  This way we can avoid code duplication.

To keep the history more bisectable, let's replace qmp commands
implementations one by one.  Also add G_GNUC_UNUSED attribute to the
helper and remove it in the next commit.

Originally-by: Yuri Pudgorodskiy <yur@virtuozzo.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 qga/commands-posix.c | 150 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 150 insertions(+)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 8207c4c47e..ad05630086 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -76,6 +76,156 @@ static void ga_wait_child(pid_t pid, int *status, Error **errp)
     g_assert(rpid == pid);
 }
 
+static ssize_t ga_pipe_read_str(int fd[2], char **str)
+{
+    ssize_t n, len = 0;
+    char buf[1024];
+
+    close(fd[1]);
+    fd[1] = -1;
+    while ((n = read(fd[0], buf, sizeof(buf))) != 0) {
+        if (n < 0) {
+            if (errno == EINTR) {
+                continue;
+            } else {
+                len = -errno;
+                break;
+            }
+        }
+        *str = g_realloc(*str, len + n + 1);
+        memcpy(*str + len, buf, n);
+        len += n;
+        *str[len] = '\0';
+    }
+    close(fd[0]);
+    fd[0] = -1;
+
+    return len;
+}
+
+/*
+ * Helper to run command with input/output redirection,
+ * sending string to stdin and taking error message from
+ * stdout/err.
+ */
+G_GNUC_UNUSED
+static int ga_run_command(const char *argv[], const char *in_str,
+                          const char *action, Error **errp)
+{
+    pid_t pid;
+    int status;
+    int retcode = -1;
+    int infd[2] = { -1, -1 };
+    int outfd[2] = { -1, -1 };
+    char *str = NULL;
+    ssize_t len = 0;
+
+    if ((in_str && !g_unix_open_pipe(infd, FD_CLOEXEC, NULL)) ||
+        !g_unix_open_pipe(outfd, FD_CLOEXEC, NULL)) {
+        error_setg(errp, "cannot create pipe FDs");
+        goto out;
+    }
+
+    pid = fork();
+    if (pid == 0) {
+        char *cherr = NULL;
+
+        setsid();
+
+        if (in_str) {
+            /* Redirect stdin to infd. */
+            close(infd[1]);
+            dup2(infd[0], 0);
+            close(infd[0]);
+        } else {
+            reopen_fd_to_null(0);
+        }
+
+        /* Redirect stdout/stderr to outfd. */
+        close(outfd[0]);
+        dup2(outfd[1], 1);
+        dup2(outfd[1], 2);
+        close(outfd[1]);
+
+        execvp(argv[0], (char *const *)argv);
+
+        /* Write the cause of failed exec to pipe for the parent to read it. */
+        cherr = g_strdup_printf("failed to exec '%s'", argv[0]);
+        perror(cherr);
+        g_free(cherr);
+        _exit(EXIT_FAILURE);
+    } else if (pid < 0) {
+        error_setg_errno(errp, errno, "failed to create child process");
+        goto out;
+    }
+
+    if (in_str) {
+        close(infd[0]);
+        infd[0] = -1;
+        if (qemu_write_full(infd[1], in_str, strlen(in_str)) !=
+                strlen(in_str)) {
+            error_setg_errno(errp, errno, "%s: cannot write to stdin pipe",
+                             action);
+            goto out;
+        }
+        close(infd[1]);
+        infd[1] = -1;
+    }
+
+    len = ga_pipe_read_str(outfd, &str);
+    if (len < 0) {
+        error_setg_errno(errp, -len, "%s: cannot read from stdout/stderr pipe",
+                         action);
+        goto out;
+    }
+
+    ga_wait_child(pid, &status, errp);
+    if (*errp) {
+        goto out;
+    }
+
+    if (!WIFEXITED(status)) {
+        if (len) {
+            error_setg(errp, "child process has terminated abnormally: %s",
+                       str);
+        } else {
+            error_setg(errp, "child process has terminated abnormally");
+        }
+        goto out;
+    }
+
+    retcode = WEXITSTATUS(status);
+
+    if (WEXITSTATUS(status)) {
+        if (len) {
+            error_setg(errp, "child process has failed to %s: %s",
+                       action, str);
+        } else {
+            error_setg(errp, "child process has failed to %s: exit status %d",
+                       action, WEXITSTATUS(status));
+        }
+        goto out;
+    }
+
+out:
+    g_free(str);
+
+    if (infd[0] != -1) {
+        close(infd[0]);
+    }
+    if (infd[1] != -1) {
+        close(infd[1]);
+    }
+    if (outfd[0] != -1) {
+        close(outfd[0]);
+    }
+    if (outfd[1] != -1) {
+        close(outfd[1]);
+    }
+
+    return retcode;
+}
+
 void qmp_guest_shutdown(const char *mode, Error **errp)
 {
     const char *shutdown_flag;
-- 
2.39.3


