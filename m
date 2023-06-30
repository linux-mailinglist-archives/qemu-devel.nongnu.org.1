Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 23BAF7443EB
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 23:30:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFLgI-0005jh-TJ; Fri, 30 Jun 2023 17:29:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qFLgD-0005j6-54
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 17:29:25 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qFLg2-0002gT-J5
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 17:29:22 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0B92B1F892;
 Fri, 30 Jun 2023 21:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1688160550; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OFVAiij/syx+awwRKklkAhV7xQ49QW2DYUUildyiQio=;
 b=S9u3FdNBoaYd/P065lYt50cXBbxhnWhwblxD701XhcIQ+4Y42dYrUkdf7ZKgKz0CkHVB3z
 BAYifztXsJdEXabCuBDLuHE4NttXdq25wMxsj5QpNJIQJ774jZrr9DPooo3a4WrlZ4stw/
 F7M4GYLsLYMyRoK1ppfzxvTzcik8tkM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1688160550;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OFVAiij/syx+awwRKklkAhV7xQ49QW2DYUUildyiQio=;
 b=u3zXSXjPgNeeqSBa0lKE9/PhsOgctDl574A5GFPOekf3WBZ6ZJLRehmnkx9qXsIV8GLyuf
 HFtTdW+gEFVnONAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9A88213915;
 Fri, 30 Jun 2023 21:29:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id kLEEGSNJn2TRKAAAMHmgww
 (envelope-from <farosas@suse.de>); Fri, 30 Jun 2023 21:29:07 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Leonardo Bras <leobras@redhat.com>
Subject: [PATCH v3 1/6] tests/qtest: migration: Expose migrate_set_capability
Date: Fri, 30 Jun 2023 18:28:57 -0300
Message-Id: <20230630212902.19925-2-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230630212902.19925-1-farosas@suse.de>
References: <20230630212902.19925-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=195.135.220.29; envelope-from=farosas@suse.de;
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

The following patch will make use of this function from within
migrate-helpers.c, so move it there.

Reviewed-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration-helpers.c | 11 +++++++++++
 tests/qtest/migration-helpers.h |  3 +++
 tests/qtest/migration-test.c    | 11 -----------
 3 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
index be00c52d00..2df198c99e 100644
--- a/tests/qtest/migration-helpers.c
+++ b/tests/qtest/migration-helpers.c
@@ -70,6 +70,17 @@ void migrate_qmp(QTestState *who, const char *uri, const char *fmt, ...)
                              "{ 'execute': 'migrate', 'arguments': %p}", args);
 }
 
+void migrate_set_capability(QTestState *who, const char *capability,
+                            bool value)
+{
+    qtest_qmp_assert_success(who,
+                             "{ 'execute': 'migrate-set-capabilities',"
+                             "'arguments': { "
+                             "'capabilities': [ { "
+                             "'capability': %s, 'state': %i } ] } }",
+                             capability, value);
+}
+
 /*
  * Note: caller is responsible to free the returned object via
  * qobject_unref() after use
diff --git a/tests/qtest/migration-helpers.h b/tests/qtest/migration-helpers.h
index 009e250e90..484d7c960f 100644
--- a/tests/qtest/migration-helpers.h
+++ b/tests/qtest/migration-helpers.h
@@ -23,6 +23,9 @@ bool migrate_watch_for_resume(QTestState *who, const char *name,
 G_GNUC_PRINTF(3, 4)
 void migrate_qmp(QTestState *who, const char *uri, const char *fmt, ...);
 
+void migrate_set_capability(QTestState *who, const char *capability,
+                            bool value);
+
 QDict *migrate_query(QTestState *who);
 QDict *migrate_query_not_failed(QTestState *who);
 
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 18bcfc04a6..df17bf431f 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -472,17 +472,6 @@ static void migrate_cancel(QTestState *who)
     qtest_qmp_assert_success(who, "{ 'execute': 'migrate_cancel' }");
 }
 
-static void migrate_set_capability(QTestState *who, const char *capability,
-                                   bool value)
-{
-    qtest_qmp_assert_success(who,
-                             "{ 'execute': 'migrate-set-capabilities',"
-                             "'arguments': { "
-                             "'capabilities': [ { "
-                             "'capability': %s, 'state': %i } ] } }",
-                             capability, value);
-}
-
 static void migrate_postcopy_start(QTestState *from, QTestState *to)
 {
     qtest_qmp_assert_success(from, "{ 'execute': 'migrate-start-postcopy' }");
-- 
2.35.3


