Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D71A97CE7B6
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 21:29:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtCD2-0003It-PA; Wed, 18 Oct 2023 15:28:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qtCD0-0003IJ-JN
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 15:27:58 -0400
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qtCCz-00053u-3K
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 15:27:58 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DE1D821BB1;
 Wed, 18 Oct 2023 19:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1697657274; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LTkMFah9Q0ALD9A1kKvXuweVQgAvBfi4eSpOb8dEb5Q=;
 b=Ojvp9s8lJAGlwMcmkiRFh8kNpjrZHm5CbHbbJUkmEFUydMXCF9DYsCijclafk2GT+2e4mt
 42Xvc5+ko5EVJnwDbBjnwXRD5XLnhpuA+k7B/nLIG4xGVWaJ3psq+BYVYhgIQn7EcceSMp
 27Yiop4YBIpBJ+8ay0/SegNIdrFpAt0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1697657274;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LTkMFah9Q0ALD9A1kKvXuweVQgAvBfi4eSpOb8dEb5Q=;
 b=a5p1ee0g011J1l+6cjJ/gapcCHsQW+c2LNdyxZ5+3ZGRCSnFK8GA3syFDBOhLYI5mcpjXH
 Zs1xlHY8xOn7YvAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6050813780;
 Wed, 18 Oct 2023 19:27:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id gAhEC7gxMGVLaAAAMHmgww
 (envelope-from <farosas@suse.de>); Wed, 18 Oct 2023 19:27:52 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v4 03/12] tests/qtest: Allow qtest_get_machines to use an
 alternate QEMU binary
Date: Wed, 18 Oct 2023 16:27:32 -0300
Message-Id: <20231018192741.25885-4-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231018192741.25885-1-farosas@suse.de>
References: <20231018192741.25885-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: -1.13
X-Spamd-Result: default: False [-1.13 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_SEVEN(0.00)[10];
 MID_CONTAINS_FROM(1.00)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-2.03)[95.25%]
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

We're adding support for using more than one QEMU binary in
tests. Modify qtest_get_machines() to take an environment variable
that contains the QEMU binary path.

Since the function keeps a cache of the machines list in the form of a
static variable, refresh it any time the environment variable changes.

Reviewed-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/libqtest.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 9eebba8767..3cc7bf3076 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -1468,13 +1468,26 @@ struct MachInfo {
     char *alias;
 };
 
+static void qtest_free_machine_list(struct MachInfo *machines)
+{
+    if (machines) {
+        for (int i = 0; machines[i].name != NULL; i++) {
+            g_free(machines[i].name);
+            g_free(machines[i].alias);
+        }
+
+        g_free(machines);
+    }
+}
+
 /*
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
@@ -1483,11 +1496,19 @@ static struct MachInfo *qtest_get_machines(void)
     QTestState *qts;
     int idx;
 
+    if (g_strcmp0(qemu_var, var)) {
+        qemu_var = g_strdup(var);
+
+        /* new qemu, clear the cache */
+        qtest_free_machine_list(machines);
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
@@ -1528,7 +1549,7 @@ void qtest_cb_for_every_machine(void (*cb)(const char *machine),
     struct MachInfo *machines;
     int i;
 
-    machines = qtest_get_machines();
+    machines = qtest_get_machines(NULL);
 
     for (i = 0; machines[i].name != NULL; i++) {
         /* Ignore machines that cannot be used for qtests */
@@ -1549,7 +1570,7 @@ bool qtest_has_machine(const char *machine)
     struct MachInfo *machines;
     int i;
 
-    machines = qtest_get_machines();
+    machines = qtest_get_machines(NULL);
 
     for (i = 0; machines[i].name != NULL; i++) {
         if (g_str_equal(machine, machines[i].name) ||
-- 
2.35.3


