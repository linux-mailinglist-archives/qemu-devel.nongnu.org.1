Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E457CDE64
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 16:09:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt7DR-0003kS-Ln; Wed, 18 Oct 2023 10:08:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qt7DD-0003hI-Ok
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 10:07:54 -0400
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qt7DA-0003cp-WF
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 10:07:51 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5F22D21BB0;
 Wed, 18 Oct 2023 14:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1697638067; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PJphBX2SVeUPL2ih3YcFse6s0kg7Z1caqZ8S2fs3WDA=;
 b=Bg3D6qPMBL6iw/duyLsJHo86DY7wDZKyVOYN6O51q92Cib6qhARxk1QArxr508rS9H7AVi
 s2oPSFa7m/Z0YdmWg+iNNlnyC3C4RVGqF+b0Su3x0s3ak+bxyaTVWbfKJrQsI8WUx4uzjE
 HLx5kXSKrpRYXeRbDcJiA5ysKu1YBj0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1697638067;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PJphBX2SVeUPL2ih3YcFse6s0kg7Z1caqZ8S2fs3WDA=;
 b=hGhldDCocJTRz0EIWgBge7l+2NxAA603GJIS4OePWlDaSoX6BkCqQuRZ8OvdbuKPEe41zf
 +34QwLpd/LHi9qAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D2D5913915;
 Wed, 18 Oct 2023 14:07:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 0I8jJ7DmL2WuTQAAMHmgww
 (envelope-from <farosas@suse.de>); Wed, 18 Oct 2023 14:07:44 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 02/11] tests/qtest: Introduce qtest_init_with_env
Date: Wed, 18 Oct 2023 11:07:27 -0300
Message-Id: <20231018140736.3618-3-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231018140736.3618-1-farosas@suse.de>
References: <20231018140736.3618-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: -2.10
X-Spamd-Result: default: False [-2.10 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_SEVEN(0.00)[10];
 MID_CONTAINS_FROM(1.00)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
Received-SPF: pass client-ip=2001:67c:2178:6::1c; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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
index 03fa644663..9eebba8767 100644
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
 
@@ -438,7 +438,8 @@ static QTestState *G_GNUC_PRINTF(1, 2) qtest_spawn_qemu(const char *fmt, ...)
     return s;
 }
 
-QTestState *qtest_init_without_qmp_handshake(const char *extra_args)
+static QTestState *qtest_init_internal(const char *qemu_bin,
+                                       const char *extra_args)
 {
     QTestState *s;
     int sock, qmpsock, i;
@@ -463,7 +464,8 @@ QTestState *qtest_init_without_qmp_handshake(const char *extra_args)
     sock = init_socket(socket_path);
     qmpsock = init_socket(qmp_socket_path);
 
-    s = qtest_spawn_qemu("-qtest unix:%s "
+    s = qtest_spawn_qemu(qemu_bin,
+                         "-qtest unix:%s "
                          "-qtest-log %s "
                          "-chardev socket,path=%s,id=char0 "
                          "-mon chardev=char0,mode=control "
@@ -516,9 +518,14 @@ QTestState *qtest_init_without_qmp_handshake(const char *extra_args)
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
@@ -529,6 +536,11 @@ QTestState *qtest_init(const char *extra_args)
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
index 5fe3d13466..76fc195f1c 100644
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


