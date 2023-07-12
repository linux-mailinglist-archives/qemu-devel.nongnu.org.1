Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C3D57510F7
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 21:08:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJfBv-0007pG-Fy; Wed, 12 Jul 2023 15:07:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qJfBq-0007i0-Th
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 15:07:55 -0400
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qJfBp-00084Q-Aa
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 15:07:54 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 28DAE220C9;
 Wed, 12 Jul 2023 19:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1689188872; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R1SHZsF68db/inYWGHfR1chTB37wYzoQ8LmRq7Fm1B0=;
 b=K6n5qlvEuUrg4ckP4XanYKbQDqd93Imdzp927NjjjLOKwUzcLjTS5u9g1dVX1Q6nnWx7hA
 lL8p8Lgt52bILhMQSc6xJz+UVTY7Itqz+IcDn+lPDNYVLP/TmgK38M4vXrY5WN/V2dteYj
 fitKpAgL4Byjc7P9heQY9qZz0NtdGFw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1689188872;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R1SHZsF68db/inYWGHfR1chTB37wYzoQ8LmRq7Fm1B0=;
 b=USOHJl/3BCEP06+p1eyXfw6Puh41jgbFH9qsT9onS0yfaA/Zf/jSOITTy01QqBI8d1X/tt
 2v7vJ4x8bxe5R4Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F313F13336;
 Wed, 12 Jul 2023 19:07:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id gAWrLgX6rmROOgAAMHmgww
 (envelope-from <farosas@suse.de>); Wed, 12 Jul 2023 19:07:49 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v5 2/6] tests/qtest: migration: Add migrate_incoming_qmp helper
Date: Wed, 12 Jul 2023 16:07:38 -0300
Message-Id: <20230712190742.22294-3-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230712190742.22294-1-farosas@suse.de>
References: <20230712190742.22294-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:67c:2178:6::1c; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

file-based migration requires the target to initiate its migration after
the source has finished writing out the data in the file. Currently
there's no easy way to initiate 'migrate-incoming', allow this by
introducing migrate_incoming_qmp helper, similarly to migrate_qmp.

Also make sure migration events are enabled and wait for the incoming
migration to start before returning. This avoid a race when querying
the migration status too soon after issuing the command.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration-helpers.c | 29 +++++++++++++++++++++++++++++
 tests/qtest/migration-helpers.h |  4 ++++
 2 files changed, 33 insertions(+)

diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
index 2df198c99e..08f5ee1179 100644
--- a/tests/qtest/migration-helpers.c
+++ b/tests/qtest/migration-helpers.c
@@ -81,6 +81,35 @@ void migrate_set_capability(QTestState *who, const char *capability,
                              capability, value);
 }
 
+void migrate_incoming_qmp(QTestState *to, const char *uri, const char *fmt, ...)
+{
+    va_list ap;
+    QDict *args, *rsp, *data;
+
+    va_start(ap, fmt);
+    args = qdict_from_vjsonf_nofail(fmt, ap);
+    va_end(ap);
+
+    g_assert(!qdict_haskey(args, "uri"));
+    qdict_put_str(args, "uri", uri);
+
+    migrate_set_capability(to, "events", true);
+
+    rsp = qtest_qmp(to, "{ 'execute': 'migrate-incoming', 'arguments': %p}",
+                    args);
+    g_assert(qdict_haskey(rsp, "return"));
+    qobject_unref(rsp);
+
+    rsp = qtest_qmp_eventwait_ref(to, "MIGRATION");
+    g_assert(qdict_haskey(rsp, "data"));
+
+    data = qdict_get_qdict(rsp, "data");
+    g_assert(qdict_haskey(data, "status"));
+    g_assert_cmpstr(qdict_get_str(data, "status"), ==, "setup");
+
+    qobject_unref(rsp);
+}
+
 /*
  * Note: caller is responsible to free the returned object via
  * qobject_unref() after use
diff --git a/tests/qtest/migration-helpers.h b/tests/qtest/migration-helpers.h
index 484d7c960f..57d295a4fe 100644
--- a/tests/qtest/migration-helpers.h
+++ b/tests/qtest/migration-helpers.h
@@ -23,6 +23,10 @@ bool migrate_watch_for_resume(QTestState *who, const char *name,
 G_GNUC_PRINTF(3, 4)
 void migrate_qmp(QTestState *who, const char *uri, const char *fmt, ...);
 
+G_GNUC_PRINTF(3, 4)
+void migrate_incoming_qmp(QTestState *who, const char *uri,
+                          const char *fmt, ...);
+
 void migrate_set_capability(QTestState *who, const char *capability,
                             bool value);
 
-- 
2.35.3


