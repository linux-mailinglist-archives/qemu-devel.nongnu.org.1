Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4346C7BB7E6
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 14:41:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qok7h-000290-N4; Fri, 06 Oct 2023 08:40:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qok7F-0001lF-Bu
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 08:39:38 -0400
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qok74-0007ok-7J
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 08:39:36 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C365F1F8A4;
 Fri,  6 Oct 2023 12:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1696595963; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HbmWr/eV8fXIGNrpkGJUUO8mOHIh/diRIjMFbYM3ncY=;
 b=TbXzrKsiH0CPYH+YFaWMfRXkqPwp6D8HGVoo9zNZ/kaBaIErE8strET0jps66zHucEt1i5
 6aXbdL6zRs6+cUCTuyCg3Pp6fCf6lErq0TTIrLXVZkgipDi7o0/Nc/NSJ86M6ZUza9LPfX
 opkijHSkjhWgbYxq2z3Uv8Zhi+HjILM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1696595963;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HbmWr/eV8fXIGNrpkGJUUO8mOHIh/diRIjMFbYM3ncY=;
 b=pdcDxYMHWEloe/WJBSmKZUkmy1gJIwOAUGP2i9F7NmIm+3vqGKlW7uWoQm8kD3Woz+5WZ/
 6nMw3mmJG4kl6nBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3E7F813A2E;
 Fri,  6 Oct 2023 12:39:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id wJnkAvn/H2ULIgAAMHmgww
 (envelope-from <farosas@suse.de>); Fri, 06 Oct 2023 12:39:21 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 3/9] tests/qtest: Allow qtest_get_machines to use an
 alternate QEMU binary
Date: Fri,  6 Oct 2023 09:39:04 -0300
Message-Id: <20231006123910.17759-4-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231006123910.17759-1-farosas@suse.de>
References: <20231006123910.17759-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:67c:2178:6::1d; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

We're adding support for using more than one QEMU binary in
tests. Modify qtest_get_machines() to take an environment variable
that contains the QEMU binary path.

Since the function keeps a cache of the machines list in the form of a
static variable, refresh it any time the environment variable changes.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/libqtest.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 88b79cb477..47c8b6d46f 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -1441,9 +1441,10 @@ struct MachInfo {
  * Returns an array with pointers to the available machine names.
  * The terminating entry has the name set to NULL.
  */
-static struct MachInfo *qtest_get_machines(void)
+static struct MachInfo *qtest_get_machines(const char *var)
 {
     static struct MachInfo *machines;
+    static char *qemu_var;
     QDict *response, *minfo;
     QList *list;
     const QListEntry *p;
@@ -1452,11 +1453,19 @@ static struct MachInfo *qtest_get_machines(void)
     QTestState *qts;
     int idx;
 
+    if (g_strcmp0(qemu_var, var)) {
+        qemu_var = g_strdup(var);
+
+        /* new qemu, clear the cache */
+        g_free(machines);
+        machines = NULL;
+    }
+
     if (machines) {
         return machines;
     }
 
-    qts = qtest_init("-machine none");
+    qts = qtest_init_with_env(qemu_var, "-machine none");
     response = qtest_qmp(qts, "{ 'execute': 'query-machines' }");
     g_assert(response);
     list = qdict_get_qlist(response, "return");
@@ -1497,7 +1506,7 @@ void qtest_cb_for_every_machine(void (*cb)(const char *machine),
     struct MachInfo *machines;
     int i;
 
-    machines = qtest_get_machines();
+    machines = qtest_get_machines(NULL);
 
     for (i = 0; machines[i].name != NULL; i++) {
         /* Ignore machines that cannot be used for qtests */
@@ -1518,7 +1527,7 @@ bool qtest_has_machine(const char *machine)
     struct MachInfo *machines;
     int i;
 
-    machines = qtest_get_machines();
+    machines = qtest_get_machines(NULL);
 
     for (i = 0; machines[i].name != NULL; i++) {
         if (g_str_equal(machine, machines[i].name) ||
-- 
2.35.3


