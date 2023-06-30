Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C6B17443ED
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 23:30:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFLgP-0005lC-JR; Fri, 30 Jun 2023 17:29:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qFLgE-0005jF-Fm
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 17:29:26 -0400
Received: from smtp-out1.suse.de ([195.135.220.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qFLgC-0002gh-QD
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 17:29:26 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A654A2189B;
 Fri, 30 Jun 2023 21:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1688160552; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HEurKajWSfdNRpAdi3RX95ppS9UuAw7D7F88tDITYl8=;
 b=vlNuthTXrsV7Iiflr6ZUrdWv5QZGOPSWXljDcM86nBOmF/kC/eLMB8HBqxuifPUnYC9t4L
 jim1DGcw6DgU0QoYnatVTOADFzA9Oe6FWK85lirPAN3qt/+XZzFHKcDI6j1q88G5ykeiOe
 UsYv78fihQ4kZ1eNI1G3ad+JMHV1G/Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1688160552;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HEurKajWSfdNRpAdi3RX95ppS9UuAw7D7F88tDITYl8=;
 b=PE3STOCYUk6JRga1fH68EOKWRMFxRPcEhkbQ2uYQzfHOvvighyofsrHVQ1cFIQVZSmSPY4
 psgRFZwOqbmo2NBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7D96713915;
 Fri, 30 Jun 2023 21:29:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id CFl+ESZJn2TRKAAAMHmgww
 (envelope-from <farosas@suse.de>); Fri, 30 Jun 2023 21:29:10 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 2/6] tests/qtest: migration: Add migrate_incoming_qmp helper
Date: Fri, 30 Jun 2023 18:28:58 -0300
Message-Id: <20230630212902.19925-3-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230630212902.19925-1-farosas@suse.de>
References: <20230630212902.19925-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=195.135.220.28; envelope-from=farosas@suse.de;
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


