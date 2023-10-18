Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7835F7CE7BC
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 21:30:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtCDP-0003Or-Da; Wed, 18 Oct 2023 15:28:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qtCDN-0003M3-AB
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 15:28:22 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qtCDL-00056c-Nu
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 15:28:21 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8B0FE1FD7E;
 Wed, 18 Oct 2023 19:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1697657298; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EfvZQLzghZRtIl6KJ4zsskowtUAaqfWlM7hlBkvPr1g=;
 b=KXGCOVoCGEHxbk1E6x7j89OGWnqk5SUTRZJh1/Cm+4ThkvN3OEvH3vjfZ0Lg2gE+bu2n2A
 gh7rNQzrigFN1yMRoLma39x8st67iQCUPBdPIjibNRZgB2C+V6UeDZmS2Jebsxb35W1OY3
 tVWRxUg0IYOGkqsia858gZH0h8PfT8Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1697657298;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EfvZQLzghZRtIl6KJ4zsskowtUAaqfWlM7hlBkvPr1g=;
 b=ffxRxq+Y16lyJ6Ex1JRE4h8fudeMxijWyyR9GcudAvJoYzS7aR3KtrkMbjwqWhMLW7x5zq
 1ZgXyJYJNUa1nqAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0FCC013780;
 Wed, 18 Oct 2023 19:28:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id +HMkM88xMGVLaAAAMHmgww
 (envelope-from <farosas@suse.de>); Wed, 18 Oct 2023 19:28:15 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v4 11/12] tests/qtest/migration: Allow user to specify a
 machine type
Date: Wed, 18 Oct 2023 16:27:40 -0300
Message-Id: <20231018192741.25885-12-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231018192741.25885-1-farosas@suse.de>
References: <20231018192741.25885-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: -1.66
X-Spamd-Result: default: False [-1.66 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_SEVEN(0.00)[10];
 MID_CONTAINS_FROM(1.00)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-2.56)[98.05%]
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

Accept the QTEST_QEMU_MACHINE_TYPE environment variable to take a
machine type to use in the tests.

The full machine type is recognized (e.g. pc-q35-8.2). Aliases
(e.g. pc) are also allowed and resolve to the latest machine version
for that alias, or, if using two QEMU binaries, to the latest common
machine version between the two.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration-helpers.c | 26 ++++++++++++++++++++++++++
 tests/qtest/migration-helpers.h |  2 ++
 tests/qtest/migration-test.c    |  5 +++--
 3 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
index 13449c1fe1..24fb7b3525 100644
--- a/tests/qtest/migration-helpers.c
+++ b/tests/qtest/migration-helpers.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/ctype.h"
 #include "qapi/qmp/qjson.h"
 
 #include "migration-helpers.h"
@@ -266,3 +267,28 @@ char *find_common_machine_version(const char *mtype, const char *var1,
                    "binaries %s and %s", mtype, getenv(var1), getenv(var2));
     g_assert_not_reached();
 }
+
+char *resolve_machine_version(const char *alias, const char *var1,
+                              const char *var2)
+{
+    const char *mname = g_getenv("QTEST_QEMU_MACHINE_TYPE");
+    g_autofree char *machine_name = NULL;
+
+    if (mname) {
+        const char *dash = strrchr(mname, '-');
+        const char *dot = strrchr(mname, '.');
+
+        machine_name = g_strdup(mname);
+
+        if (dash && dot) {
+            assert(qtest_has_machine(machine_name));
+            return g_steal_pointer(&machine_name);
+        }
+        /* else: probably an alias, let it be resolved below */
+    } else {
+        /* use the hardcoded alias */
+        machine_name = g_strdup(alias);
+    }
+
+    return find_common_machine_version(machine_name, var1, var2);
+}
diff --git a/tests/qtest/migration-helpers.h b/tests/qtest/migration-helpers.h
index d1c2351d33..e31dc85cc7 100644
--- a/tests/qtest/migration-helpers.h
+++ b/tests/qtest/migration-helpers.h
@@ -45,4 +45,6 @@ void wait_for_migration_fail(QTestState *from, bool allow_active);
 
 char *find_common_machine_version(const char *mtype, const char *var1,
                                   const char *var2);
+char *resolve_machine_version(const char *alias, const char *var1,
+                              const char *var2);
 #endif /* MIGRATION_HELPERS_H */
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 51f5603aac..e15ac3b353 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -825,8 +825,9 @@ static int test_migrate_start(QTestState **from, QTestState **to,
         kvm_opts = ",dirty-ring-size=4096";
     }
 
-    machine = find_common_machine_version(machine_alias, QEMU_ENV_SRC,
-                                          QEMU_ENV_DST);
+    machine = resolve_machine_version(machine_alias, QEMU_ENV_SRC,
+                                      QEMU_ENV_DST);
+
     g_test_message("Using machine type: %s", machine);
 
     cmd_source = g_strdup_printf("-accel kvm%s -accel tcg "
-- 
2.35.3


