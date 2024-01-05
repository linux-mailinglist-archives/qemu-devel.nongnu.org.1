Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 291298259A4
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 19:05:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLoZ8-0006Ro-Dn; Fri, 05 Jan 2024 13:05:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rLoZ5-0006PZ-2Y
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 13:05:03 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rLoZ3-0001Jo-7h
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 13:05:02 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8EA8A1FB4D;
 Fri,  5 Jan 2024 18:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1704477899; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dtaFiv8X0V9VCT7I2z0ZdF00xXngGQH4Wxm+vv7nx2Y=;
 b=IMEE4cCsz8SKAvDZ+yOc582UNJVuk9X/Ta5Vhb0QxY//cbo5nbmYlzP0qblHII52tmGoqb
 DPgOfjVuxm0OIsKgj+ufCKYz/Mf3jQCndR51+9hl6vubcuFObL/50ekBElzwPtUpuZntp/
 E21WwKP4Jo0qL1QG82dql2DJ/DNuHXQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1704477899;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dtaFiv8X0V9VCT7I2z0ZdF00xXngGQH4Wxm+vv7nx2Y=;
 b=Verc8SZ6FED+BuRISXOAp4RpnRIZTVEaDzluwVM7qVcSGxlEN2ykH0sWQlG5K6rY4qr5Bc
 vV9mQ5b5k5DaqLCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1704477899; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dtaFiv8X0V9VCT7I2z0ZdF00xXngGQH4Wxm+vv7nx2Y=;
 b=IMEE4cCsz8SKAvDZ+yOc582UNJVuk9X/Ta5Vhb0QxY//cbo5nbmYlzP0qblHII52tmGoqb
 DPgOfjVuxm0OIsKgj+ufCKYz/Mf3jQCndR51+9hl6vubcuFObL/50ekBElzwPtUpuZntp/
 E21WwKP4Jo0qL1QG82dql2DJ/DNuHXQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1704477899;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dtaFiv8X0V9VCT7I2z0ZdF00xXngGQH4Wxm+vv7nx2Y=;
 b=Verc8SZ6FED+BuRISXOAp4RpnRIZTVEaDzluwVM7qVcSGxlEN2ykH0sWQlG5K6rY4qr5Bc
 vV9mQ5b5k5DaqLCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7B139137E8;
 Fri,  5 Jan 2024 18:04:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8J55EMlEmGXFWAAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 05 Jan 2024 18:04:57 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 2/4] tests/qtest/migration: Add infrastructure to skip
 tests on older QEMUs
Date: Fri,  5 Jan 2024 15:04:47 -0300
Message-Id: <20240105180449.11562-3-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240105180449.11562-1-farosas@suse.de>
References: <20240105180449.11562-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=IMEE4cCs;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Verc8SZ6
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 BROKEN_CONTENT_TYPE(1.50)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 RCPT_COUNT_SEVEN(0.00)[7]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 BAYES_HAM(-3.00)[100.00%]; ARC_NA(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DWL_DNSWL_HI(-3.50)[suse.de:dkim];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Score: -3.01
X-Rspamd-Queue-Id: 8EA8A1FB4D
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

We can run the migration tests with two different QEMU binaries to
test migration compatibility between QEMU versions. This means we'll
be running the tests with an older QEMU in either source or
destination.

We need to avoid trying to test functionality that is unknown to the
older QEMU. This could mean new features, bug fixes, error message
changes, QEMU command line changes, migration API changes, etc.

Add a 'since' argument to the tests that inform when the functionality
that is being test has been added to QEMU so we can skip the test on
older versions.

Also add a version comparison function so we can adapt test code
depending on the QEMU binary version being used.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration-helpers.h |  1 +
 tests/qtest/migration-helpers.c | 48 +++++++++++++++++++++++++++++++++
 tests/qtest/migration-test.c    | 29 ++++++++++++++++++++
 3 files changed, 78 insertions(+)

diff --git a/tests/qtest/migration-helpers.h b/tests/qtest/migration-helpers.h
index e31dc85cc7..7b4f8e851e 100644
--- a/tests/qtest/migration-helpers.h
+++ b/tests/qtest/migration-helpers.h
@@ -47,4 +47,5 @@ char *find_common_machine_version(const char *mtype, const char *var1,
                                   const char *var2);
 char *resolve_machine_version(const char *alias, const char *var1,
                               const char *var2);
+int migration_vercmp(QTestState *who, const char *tgt_version);
 #endif /* MIGRATION_HELPERS_H */
diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
index 24fb7b3525..bc4fd93e8c 100644
--- a/tests/qtest/migration-helpers.c
+++ b/tests/qtest/migration-helpers.c
@@ -292,3 +292,51 @@ char *resolve_machine_version(const char *alias, const char *var1,
 
     return find_common_machine_version(machine_name, var1, var2);
 }
+
+int migration_vercmp(QTestState *who, const char *tgt_version)
+{
+    g_autofree char *version = g_strdup(tgt_version);
+    int major = 0, minor = 0, micro = 0;
+    int tgt_major = 0, tgt_minor = 0, tgt_micro = 0;
+    const char *delim = ".";
+    char *tok;
+
+    qtest_query_version(who, &major, &minor, &micro);
+
+    tok = strtok(version, delim);
+    assert(tok);
+    tgt_major = atoi(tok);
+    assert(tgt_major);
+
+    if (major > tgt_major) {
+        return -1;
+    }
+    if (major < tgt_major) {
+        return 1;
+    }
+
+    tok = strtok(NULL, delim);
+    assert(tok);
+    tgt_minor = atoi(tok);
+
+    if (minor > tgt_minor) {
+        return -1;
+    }
+    if (minor < tgt_minor) {
+        return 1;
+    }
+
+    tok = strtok(NULL, delim);
+    if (tok) {
+        tgt_micro = atoi(tok);
+    }
+
+    if (micro > tgt_micro) {
+        return -1;
+    }
+    if (micro < tgt_micro) {
+        return 1;
+    }
+
+    return 0;
+}
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index d520c587f7..001470238b 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -637,6 +637,12 @@ typedef struct {
     bool use_dirty_ring;
     const char *opts_source;
     const char *opts_target;
+    /*
+     * If a test checks against new functionality that might not be
+     * present in older QEMUs this needs to be set so we can skip
+     * running it when doing compatibility testing.
+     */
+    const char *since;
 } MigrateStart;
 
 /*
@@ -850,6 +856,17 @@ static int test_migrate_start(QTestState **from, QTestState **to,
         qtest_qmp_set_event_callback(*from,
                                      migrate_watch_for_stop,
                                      &got_src_stop);
+
+        if (args->since && migration_vercmp(*from, args->since) < 0) {
+            g_autofree char *msg = NULL;
+
+            msg = g_strdup_printf("Test requires at least QEMU version %s",
+                                  args->since);
+            g_test_skip(msg);
+            qtest_quit(*from);
+
+            return -1;
+        }
     }
 
     cmd_target = g_strdup_printf("-accel kvm%s -accel tcg "
@@ -872,6 +889,18 @@ static int test_migrate_start(QTestState **from, QTestState **to,
                                  migrate_watch_for_resume,
                                  &got_dst_resume);
 
+    if (args->since && migration_vercmp(*to, args->since) < 0) {
+        g_autofree char *msg = NULL;
+
+        msg = g_strdup_printf("Test requires at least QEMU version %s",
+                              args->since);
+        g_test_skip(msg);
+        qtest_quit(*to);
+        qtest_quit(*from);
+
+        return -1;
+    }
+
     /*
      * Remove shmem file immediately to avoid memory leak in test failed case.
      * It's valid because QEMU has already opened this file
-- 
2.35.3


