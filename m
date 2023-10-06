Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D83D7BB7E4
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 14:40:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qok79-0001ei-Cy; Fri, 06 Oct 2023 08:39:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qok72-0001d6-B9
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 08:39:24 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qok70-0007oI-Lz
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 08:39:24 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D36BE1F74A;
 Fri,  6 Oct 2023 12:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1696595960; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lyPnX1wJ4JI1OFVMxYtIdxKlHRKGrEgKaf8Kmsr9yUo=;
 b=RoC5xX1Xt/qNdqHzEFq5h1Qt77JkyqPKHV7BpS3Pjoq82XO9efBLXLdOSXdEm14LgHUxgC
 5pze9Hv9XE117iCmKHpM7/s3cQMFtf1VX4EL9+fx6oWQt19OIz4OCzUPKMYj01B5j2WWn/
 nTdmWJvkv/33oRYLmAK6OaAvj6GKr/E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1696595960;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lyPnX1wJ4JI1OFVMxYtIdxKlHRKGrEgKaf8Kmsr9yUo=;
 b=2SVDBJYU14ivqn5xRh8akvI/jbLur9A/UqX0dvkvzWZvLXWoO9XCWE8bitGkvJFDAQg02B
 imB45lSJKHpAAXAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 467E913A2E;
 Fri,  6 Oct 2023 12:39:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id kCKFBPb/H2ULIgAAMHmgww
 (envelope-from <farosas@suse.de>); Fri, 06 Oct 2023 12:39:18 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 2/9] tests/qtest: Introduce qtest_init_with_env
Date: Fri,  6 Oct 2023 09:39:03 -0300
Message-Id: <20231006123910.17759-3-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231006123910.17759-1-farosas@suse.de>
References: <20231006123910.17759-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=195.135.220.29; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add a version of qtest_init() that takes an environment variable
containing the path of the QEMU binary. This allows tests to use more
than one QEMU binary.

If no variable is provided or the environment variable does not exist,
that is not an error. Fallback to using QTEST_QEMU_BINARY.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/libqtest.c | 26 +++++++++++++++++++-------
 tests/qtest/libqtest.h | 13 +++++++++++++
 2 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 1f971b98e0..88b79cb477 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -388,7 +388,8 @@ static pid_t qtest_create_process(char *cmd)
 }
 #endif /* _WIN32 */
 
-static QTestState *G_GNUC_PRINTF(1, 2) qtest_spawn_qemu(const char *fmt, ...)
+static QTestState *G_GNUC_PRINTF(2, 3) qtest_spawn_qemu(const char *qemu_bin,
+                                                        const char *fmt, ...)
 {
     va_list ap;
     QTestState *s = g_new0(QTestState, 1);
@@ -398,8 +399,7 @@ static QTestState *G_GNUC_PRINTF(1, 2) qtest_spawn_qemu(const char *fmt, ...)
     g_autoptr(GString) command = g_string_new("");
 
     va_start(ap, fmt);
-    g_string_append_printf(command, CMD_EXEC "%s %s",
-                           qtest_qemu_binary(NULL), tracearg);
+    g_string_append_printf(command, CMD_EXEC "%s %s", qemu_bin, tracearg);
     g_string_append_vprintf(command, fmt, ap);
     va_end(ap);
 
@@ -441,7 +441,8 @@ static QTestState *G_GNUC_PRINTF(1, 2) qtest_spawn_qemu(const char *fmt, ...)
     return s;
 }
 
-QTestState *qtest_init_without_qmp_handshake(const char *extra_args)
+static QTestState *qtest_init_internal(const char *qemu_bin,
+                                       const char *extra_args)
 {
     QTestState *s;
     int sock, qmpsock, i;
@@ -466,7 +467,8 @@ QTestState *qtest_init_without_qmp_handshake(const char *extra_args)
     sock = init_socket(socket_path);
     qmpsock = init_socket(qmp_socket_path);
 
-    s = qtest_spawn_qemu("-qtest unix:%s "
+    s = qtest_spawn_qemu(qemu_bin,
+                         "-qtest unix:%s "
                          "-qtest-log %s "
                          "-chardev socket,path=%s,id=char0 "
                          "-mon chardev=char0,mode=control "
@@ -518,9 +520,14 @@ QTestState *qtest_init_without_qmp_handshake(const char *extra_args)
     return s;
 }
 
-QTestState *qtest_init(const char *extra_args)
+QTestState *qtest_init_without_qmp_handshake(const char *extra_args)
 {
-    QTestState *s = qtest_init_without_qmp_handshake(extra_args);
+    return qtest_init_internal(qtest_qemu_binary(NULL), extra_args);
+}
+
+QTestState *qtest_init_with_env(const char *var, const char *extra_args)
+{
+    QTestState *s = qtest_init_internal(qtest_qemu_binary(var), extra_args);
     QDict *greeting;
 
     /* Read the QMP greeting and then do the handshake */
@@ -531,6 +538,11 @@ QTestState *qtest_init(const char *extra_args)
     return s;
 }
 
+QTestState *qtest_init(const char *extra_args)
+{
+    return qtest_init_with_env(NULL, extra_args);
+}
+
 QTestState *qtest_vinitf(const char *fmt, va_list ap)
 {
     char *args = g_strdup_vprintf(fmt, ap);
diff --git a/tests/qtest/libqtest.h b/tests/qtest/libqtest.h
index e53e350e3a..eef3a11ca4 100644
--- a/tests/qtest/libqtest.h
+++ b/tests/qtest/libqtest.h
@@ -55,6 +55,19 @@ QTestState *qtest_vinitf(const char *fmt, va_list ap) G_GNUC_PRINTF(1, 0);
  */
 QTestState *qtest_init(const char *extra_args);
 
+/**
+ * qtest_init_with_env:
+ * @var: Environment variable from where to take the QEMU binary
+ * @extra_args: Other arguments to pass to QEMU.  CAUTION: these
+ * arguments are subject to word splitting and shell evaluation.
+ *
+ * Like qtest_init(), but use a different environment variable for the
+ * QEMU binary.
+ *
+ * Returns: #QTestState instance.
+ */
+QTestState *qtest_init_with_env(const char *var, const char *extra_args);
+
 /**
  * qtest_init_without_qmp_handshake:
  * @extra_args: other arguments to pass to QEMU.  CAUTION: these
-- 
2.35.3


