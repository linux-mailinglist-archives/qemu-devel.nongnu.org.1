Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE297D3F1C
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 20:22:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quzYn-0005C1-En; Mon, 23 Oct 2023 14:21:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1quzYk-0004z3-No
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:21:50 -0400
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1quzYj-0001F6-2H
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:21:50 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BE93221B0C;
 Mon, 23 Oct 2023 18:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1698085307; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8VREoUcre2b0Zd2fBDDwAYzz/iOqM+jPcSsusIwLH2I=;
 b=f1bxb3B4jP1oi6K0FnDAVVYZ8ecLjj7xWNslJ4Y+H0yySxkl1pNdm0zM7JlxkQrX+RahrF
 a2G4346jjjk0cZWMGwMaTiVCFathPKIZEWiTdtn22tSzK6DJfRhWSqAuPR4gjcBkZAu7kv
 BK3tUtM8JHnjiDf2tB+kJKpXK0a0L3s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1698085307;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8VREoUcre2b0Zd2fBDDwAYzz/iOqM+jPcSsusIwLH2I=;
 b=hIwYxvfaAE7JGZKNZCJONGZHNZiVTGPZSTIB4T75qYlus37iZC6yQWlF+tw7yYiN+QSxJg
 UkV2gekVScby/cBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 994BC132FD;
 Mon, 23 Oct 2023 18:21:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id kCEcGbi5NmX8ZwAAMHmgww
 (envelope-from <farosas@suse.de>); Mon, 23 Oct 2023 18:21:44 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, dgilbert@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com, armbru@redhat.com, eblake@redhat.com,
 manish.mishra@nutanix.com, aravind.retnakaran@nutanix.com,
 Het Gala <het.gala@nutanix.com>, Juan Quintela <quintela@redhat.com>,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>
Subject: [PATCH v15 13/14] migration: Implement MigrateChannelList to hmp
 migration flow.
Date: Mon, 23 Oct 2023 15:20:52 -0300
Message-Id: <20231023182053.8711-14-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231023182053.8711-1-farosas@suse.de>
References: <20231023182053.8711-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: -2.08
X-Spamd-Result: default: False [-2.08 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_TWELVE(0.00)[13];
 MID_CONTAINS_FROM(1.00)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-2.98)[99.91%]
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

From: Het Gala <het.gala@nutanix.com>

Integrate MigrateChannelList with all transport backends
(socket, exec and rdma) for both src and dest migration
endpoints for hmp migration.

Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
Signed-off-by: Het Gala <het.gala@nutanix.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration-hmp-cmds.c | 27 ++++++++++++++++++++++-----
 migration/migration.c          |  5 ++---
 migration/migration.h          |  3 ++-
 3 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index c1a73df7c0..ffe32e3b9b 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -446,9 +446,18 @@ void hmp_migrate_incoming(Monitor *mon, const QDict *qdict)
 {
     Error *err = NULL;
     const char *uri = qdict_get_str(qdict, "uri");
+    MigrationChannelList *caps = NULL;
+    g_autoptr(MigrationChannel) channel = NULL;
 
-    qmp_migrate_incoming(uri, false, NULL, &err);
+    if (!migrate_uri_parse(uri, &channel, &err)) {
+        goto end;
+    }
+    QAPI_LIST_PREPEND(caps, g_steal_pointer(&channel));
 
+    qmp_migrate_incoming(NULL, true, caps, &err);
+    qapi_free_MigrationChannelList(caps);
+
+end:
     hmp_handle_error(mon, err);
 }
 
@@ -744,12 +753,17 @@ void hmp_migrate(Monitor *mon, const QDict *qdict)
     bool resume = qdict_get_try_bool(qdict, "resume", false);
     const char *uri = qdict_get_str(qdict, "uri");
     Error *err = NULL;
+    MigrationChannelList *caps = NULL;
+    g_autoptr(MigrationChannel) channel = NULL;
 
-    qmp_migrate(uri, false, NULL, !!blk, blk, !!inc, inc,
+    if (!migrate_uri_parse(uri, &channel, &err)) {
+        goto end;
+    }
+    QAPI_LIST_PREPEND(caps, g_steal_pointer(&channel));
+
+    qmp_migrate(NULL, true, caps, !!blk, blk, !!inc, inc,
                  false, false, true, resume, &err);
-    if (hmp_handle_error(mon, err)) {
-        return;
-    }
+    qapi_free_MigrationChannelList(caps);
 
     if (!detach) {
         HMPMigrationStatus *status;
@@ -766,6 +780,9 @@ void hmp_migrate(Monitor *mon, const QDict *qdict)
                                           status);
         timer_mod(status->timer, qemu_clock_get_ms(QEMU_CLOCK_REALTIME));
     }
+
+end:
+    hmp_handle_error(mon, err);
 }
 
 void migrate_set_capability_completion(ReadLineState *rs, int nb_args,
diff --git a/migration/migration.c b/migration/migration.c
index c4c2f3a266..427965099b 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -432,9 +432,8 @@ void migrate_add_address(SocketAddress *address)
                       QAPI_CLONE(SocketAddress, address));
 }
 
-static bool migrate_uri_parse(const char *uri,
-                              MigrationChannel **channel,
-                              Error **errp)
+bool migrate_uri_parse(const char *uri, MigrationChannel **channel,
+                       Error **errp)
 {
     g_autoptr(MigrationChannel) val = g_new0(MigrationChannel, 1);
     g_autoptr(MigrationAddress) addr = g_new0(MigrationAddress, 1);
diff --git a/migration/migration.h b/migration/migration.h
index ae82004892..c2a5333e0e 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -520,7 +520,8 @@ bool check_dirty_bitmap_mig_alias_map(const BitmapMigrationNodeAliasList *bbm,
                                       Error **errp);
 
 void migrate_add_address(SocketAddress *address);
-
+bool migrate_uri_parse(const char *uri, MigrationChannel **channel,
+                       Error **errp);
 int foreach_not_ignored_block(RAMBlockIterFunc func, void *opaque);
 
 #define qemu_ram_foreach_block \
-- 
2.35.3


