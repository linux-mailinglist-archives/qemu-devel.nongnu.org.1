Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EACA86E736
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Mar 2024 18:30:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg6h7-0003pN-1Z; Fri, 01 Mar 2024 12:29:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1rg6h3-0003nb-8P
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 12:29:09 -0500
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1rg6gx-0005d2-Vb
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 12:29:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-Id:Date:Subject:From:
 Content-Type; bh=TCjNFTmDj5adwMm8mWkF67k/DsXhNQZYrvO3a6rbjt8=; b=s9G+joeXG388
 rOyPVvjEvjBmzFXLv3zJNu5/RNebrLi9R+PR7JJ/n1FbmHmdtL17u2ppGVn8+MxE+BfQpfQ149zY6
 Iz802ZkYn/d6S6KwAuzKNch9SVYoGVOcz71IEW0orJVy5l4Bmpe8ryXwpgruaJ3y82O47g2fX6jKE
 /kBLoInB+Trq3tgm1jDPBAj7ETdrAMz4wDI/LjbLfB/SVCJjn8dZP88O5Td6JGiBro5Ij0RC+dSkN
 9siavpHCs1iWf+zk8noMMhGOXPjMqlG3LB0mCPpfeBT7HqDJih8lSXxlLPuStdzEfwnLSdMmafFEX
 hJAh+0JKdTiLffqmSnj4jQ==;
Received: from [130.117.225.1] (helo=dev005.ch-qa.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <andrey.drobyshev@virtuozzo.com>) id 1rg6fM-0022sZ-1X;
 Fri, 01 Mar 2024 18:28:57 +0100
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: michael.roth@amd.com, kkostiuk@redhat.com, marcandre.lureau@redhat.com,
 philmd@linaro.org, andrey.drobyshev@virtuozzo.com, den@virtuozzo.com
Subject: [PATCH v2 7/7] qga/commands-posix: qmp_guest_set_user_password: use
 ga_run_command helper
Date: Fri,  1 Mar 2024 19:28:58 +0200
Message-Id: <20240301172858.665135-8-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240301172858.665135-1-andrey.drobyshev@virtuozzo.com>
References: <20240301172858.665135-1-andrey.drobyshev@virtuozzo.com>
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

There's no need to check for the existence of the "chpasswd", "pw"
executables, as the exec() call will do that for us.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 qga/commands-posix.c | 96 ++++++--------------------------------------
 1 file changed, 13 insertions(+), 83 deletions(-)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index f3f4a05e2d..f2e9496b80 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -2144,14 +2144,8 @@ void qmp_guest_set_user_password(const char *username,
                                  Error **errp)
 {
     Error *local_err = NULL;
-    char *passwd_path = NULL;
-    pid_t pid;
-    int status;
-    int datafd[2] = { -1, -1 };
-    char *rawpasswddata = NULL;
+    g_autofree char *rawpasswddata = NULL;
     size_t rawpasswdlen;
-    char *chpasswddata = NULL;
-    size_t chpasswdlen;
 
     rawpasswddata = (char *)qbase64_decode(password, -1, &rawpasswdlen, errp);
     if (!rawpasswddata) {
@@ -2162,95 +2156,31 @@ void qmp_guest_set_user_password(const char *username,
 
     if (strchr(rawpasswddata, '\n')) {
         error_setg(errp, "forbidden characters in raw password");
-        goto out;
+        return;
     }
 
     if (strchr(username, '\n') ||
         strchr(username, ':')) {
         error_setg(errp, "forbidden characters in username");
-        goto out;
+        return;
     }
 
 #ifdef __FreeBSD__
-    chpasswddata = g_strdup(rawpasswddata);
-    passwd_path = g_find_program_in_path("pw");
+    g_autofree char *chpasswdata = g_strdup(rawpasswddata);
+    const char *crypt_flag = (crypted) ? "-H" : "-h";
+    const char *argv[] = {"pw", "usermod", "-n", username,
+                          crypt_flag, "0", NULL};
 #else
-    chpasswddata = g_strdup_printf("%s:%s\n", username, rawpasswddata);
-    passwd_path = g_find_program_in_path("chpasswd");
+    g_autofree char *chpasswddata = g_strdup_printf("%s:%s\n", username,
+                                                    rawpasswddata);
+    const char *crypt_flag = (crypted) ? "-e" : NULL;
+    const char *argv[] = {"chpasswd", crypt_flag, NULL};
 #endif
 
-    chpasswdlen = strlen(chpasswddata);
-
-    if (!passwd_path) {
-        error_setg(errp, "cannot find 'passwd' program in PATH");
-        goto out;
-    }
-
-    if (!g_unix_open_pipe(datafd, FD_CLOEXEC, NULL)) {
-        error_setg(errp, "cannot create pipe FDs");
-        goto out;
-    }
-
-    pid = fork();
-    if (pid == 0) {
-        close(datafd[1]);
-        /* child */
-        setsid();
-        dup2(datafd[0], 0);
-        reopen_fd_to_null(1);
-        reopen_fd_to_null(2);
-
-#ifdef __FreeBSD__
-        const char *h_arg;
-        h_arg = (crypted) ? "-H" : "-h";
-        execl(passwd_path, "pw", "usermod", "-n", username, h_arg, "0", NULL);
-#else
-        if (crypted) {
-            execl(passwd_path, "chpasswd", "-e", NULL);
-        } else {
-            execl(passwd_path, "chpasswd", NULL);
-        }
-#endif
-        _exit(EXIT_FAILURE);
-    } else if (pid < 0) {
-        error_setg_errno(errp, errno, "failed to create child process");
-        goto out;
-    }
-    close(datafd[0]);
-    datafd[0] = -1;
-
-    if (qemu_write_full(datafd[1], chpasswddata, chpasswdlen) != chpasswdlen) {
-        error_setg_errno(errp, errno, "cannot write new account password");
-        goto out;
-    }
-    close(datafd[1]);
-    datafd[1] = -1;
-
-    ga_wait_child(pid, &status, &local_err);
+    ga_run_command(argv, chpasswddata, "set user password", &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
-        goto out;
-    }
-
-    if (!WIFEXITED(status)) {
-        error_setg(errp, "child process has terminated abnormally");
-        goto out;
-    }
-
-    if (WEXITSTATUS(status)) {
-        error_setg(errp, "child process has failed to set user password");
-        goto out;
-    }
-
-out:
-    g_free(chpasswddata);
-    g_free(rawpasswddata);
-    g_free(passwd_path);
-    if (datafd[0] != -1) {
-        close(datafd[0]);
-    }
-    if (datafd[1] != -1) {
-        close(datafd[1]);
+        return;
     }
 }
 #else /* __linux__ || __FreeBSD__ */
-- 
2.39.3


