Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 913177BB7DF
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 14:40:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qok7c-0001sL-Lk; Fri, 06 Oct 2023 08:40:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qok7A-0001kY-Eu
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 08:39:37 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qok76-0007pF-3G
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 08:39:30 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BDC551F74A;
 Fri,  6 Oct 2023 12:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1696595966; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CBZYxTpzwzoUNOB2Lyoa4STF4QMYRPmQcqQlOpnGiDs=;
 b=lk1ramHs0uP0/38ZgQmu046UEjSGwSyzn8pD7Ig4+NOysi3X/J/qFBfrihy2HnJN/CZC16
 Ngs/GW+oMyC2vOk6A2OjQDxX94/F14V9hOPFiFzYy3NSSgIDmh95BHAlTsS0HLIoZtm7lJ
 lM3tttPwfm77jev81tf0m6ClNZf6sao=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1696595966;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CBZYxTpzwzoUNOB2Lyoa4STF4QMYRPmQcqQlOpnGiDs=;
 b=Vq17YiBjCfX8a6IcB3deWa809QMhyzcWPlYO9fp4J212tvpcnweN1ddoQorZcxONc4PEOJ
 XqNeRnFn0TCWWcBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 390E613A2E;
 Fri,  6 Oct 2023 12:39:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 2PRyAfz/H2ULIgAAMHmgww
 (envelope-from <farosas@suse.de>); Fri, 06 Oct 2023 12:39:24 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 4/9] tests/qtest: Introduce qtest_has_machine_with_env
Date: Fri,  6 Oct 2023 09:39:05 -0300
Message-Id: <20231006123910.17759-5-farosas@suse.de>
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

Add a variant of qtest_has_machine() that receives an environment
variable containing an alternate QEMU binary path.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/libqtest.c | 9 +++++++--
 tests/qtest/libqtest.h | 9 +++++++++
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 47c8b6d46f..c0e4f05979 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -1522,12 +1522,12 @@ void qtest_cb_for_every_machine(void (*cb)(const char *machine),
     }
 }
 
-bool qtest_has_machine(const char *machine)
+bool qtest_has_machine_with_env(const char *var, const char *machine)
 {
     struct MachInfo *machines;
     int i;
 
-    machines = qtest_get_machines(NULL);
+    machines = qtest_get_machines(var);
 
     for (i = 0; machines[i].name != NULL; i++) {
         if (g_str_equal(machine, machines[i].name) ||
@@ -1539,6 +1539,11 @@ bool qtest_has_machine(const char *machine)
     return false;
 }
 
+bool qtest_has_machine(const char *machine)
+{
+    return qtest_has_machine_with_env(NULL, machine);
+}
+
 bool qtest_has_device(const char *device)
 {
     static QList *list;
diff --git a/tests/qtest/libqtest.h b/tests/qtest/libqtest.h
index eef3a11ca4..083b2a6520 100644
--- a/tests/qtest/libqtest.h
+++ b/tests/qtest/libqtest.h
@@ -902,6 +902,15 @@ void qtest_cb_for_every_machine(void (*cb)(const char *machine),
  */
 bool qtest_has_machine(const char *machine);
 
+/**
+ * qtest_has_machine_with_env:
+ * @var: Environment variable from where to take the QEMU binary
+ * @machine: The machine to look for
+ *
+ * Returns: true if the machine is available in the specified binary.
+ */
+bool qtest_has_machine_with_env(const char *var, const char *machine);
+
 /**
  * qtest_has_device:
  * @device: The device to look for
-- 
2.35.3


