Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A1B7D40FD
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 22:38:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qv1fX-00037h-08; Mon, 23 Oct 2023 16:36:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qv1fS-00030F-FM
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 16:36:54 -0400
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qv1fP-0001pq-94
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 16:36:53 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 36D091FE3B;
 Mon, 23 Oct 2023 20:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1698093410; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4G/cHUxn6iGZmUsTZYq/RXjW4IQMnPKPDGRmRoZnArQ=;
 b=STAJKGlh90ilMmpdhhabSXVA1VdV6Gep5p1zVmIHSnYyimfffyxuHBQQuIvu2E4I9lkrml
 zIWPGqGd8LnqHQg1oNJgC29RlZU7XHgFtTbsTeQNrA9L+FJ1aDc1bDEAL9TakR40z+6Aa0
 zrjMsj7HVxblMy5c9fGldVXKaZRhU3k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1698093410;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4G/cHUxn6iGZmUsTZYq/RXjW4IQMnPKPDGRmRoZnArQ=;
 b=EaG+CeKDVXLHxCyka8Z4lzz6tWjNR3O05CqQcx5Bu4yiZfTmdIzEjBGnoQhEW9HEIrk8B1
 sW+DtZdsaBo6UnBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1C926132FD;
 Mon, 23 Oct 2023 20:36:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id OAoUNl/ZNmV1JQAAMHmgww
 (envelope-from <farosas@suse.de>); Mon, 23 Oct 2023 20:36:47 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Claudio Fontana <cfontana@suse.de>,
 Eric Blake <eblake@redhat.com>
Subject: [PATCH v2 14/29] migration/ram: Introduce 'fixed-ram' migration
 capability
Date: Mon, 23 Oct 2023 17:35:53 -0300
Message-Id: <20231023203608.26370-15-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231023203608.26370-1-farosas@suse.de>
References: <20231023203608.26370-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: -2.10
X-Spamd-Result: default: False [-2.10 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_SEVEN(0.00)[8];
 MID_CONTAINS_FROM(1.00)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
Received-SPF: pass client-ip=2001:67c:2178:6::1d; envelope-from=farosas@suse.de;
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

Add a new migration capability 'fixed-ram'.

The core of the feature is to ensure that each ram page has a specific
offset in the resulting migration stream. The reason why we'd want
such behavior are two fold:

 - When doing a 'fixed-ram' migration the resulting file will have a
   bounded size, since pages which are dirtied multiple times will
   always go to a fixed location in the file, rather than constantly
   being added to a sequential stream. This eliminates cases where a vm
   with, say, 1G of ram can result in a migration file that's 10s of
   GBs, provided that the workload constantly redirties memory.

 - It paves the way to implement DIRECT_IO-enabled save/restore of the
   migration stream as the pages are ensured to be written at aligned
   offsets.

For now, enabling the capability has no effect. The next couple of
patches implement the core funcionality.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 docs/devel/migration.rst | 14 ++++++++++++++
 migration/options.c      | 37 +++++++++++++++++++++++++++++++++++++
 migration/options.h      |  1 +
 migration/savevm.c       |  1 +
 qapi/migration.json      |  5 ++++-
 5 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/docs/devel/migration.rst b/docs/devel/migration.rst
index c3e1400c0c..6f898b5dbd 100644
--- a/docs/devel/migration.rst
+++ b/docs/devel/migration.rst
@@ -566,6 +566,20 @@ Others (especially either older devices or system devices which for
 some reason don't have a bus concept) make use of the ``instance id``
 for otherwise identically named devices.
 
+Fixed-ram format
+----------------
+
+When the ``fixed-ram`` capability is enabled, a slightly different
+stream format is used for the RAM section. Instead of having a
+sequential stream of pages that follow the RAMBlock headers, the dirty
+pages for a RAMBlock follow its header. This ensures that each RAM
+page has a fixed offset in the resulting migration stream.
+
+The ``fixed-ram`` capaility can be enabled in both source and
+destination with:
+
+    ``migrate_set_capability fixed-ram on``
+
 Return path
 -----------
 
diff --git a/migration/options.c b/migration/options.c
index c3def757fe..2622d8c483 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -202,6 +202,7 @@ Property migration_properties[] = {
     DEFINE_PROP_MIG_CAP("x-dirty-limit", MIGRATION_CAPABILITY_DIRTY_LIMIT),
     DEFINE_PROP_BOOL("x-auto-pause", MigrationState,
                      capabilities[MIGRATION_CAPABILITY_AUTO_PAUSE], true),
+    DEFINE_PROP_MIG_CAP("x-fixed-ram", MIGRATION_CAPABILITY_FIXED_RAM),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -268,6 +269,16 @@ bool migrate_events(void)
     return s->capabilities[MIGRATION_CAPABILITY_EVENTS];
 }
 
+bool migrate_fixed_ram(void)
+{
+/*
+    MigrationState *s = migrate_get_current();
+
+    return s->capabilities[MIGRATION_CAPABILITY_FIXED_RAM];
+*/
+    return false;
+}
+
 bool migrate_ignore_shared(void)
 {
     MigrationState *s = migrate_get_current();
@@ -627,6 +638,32 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
         }
     }
 
+    if (new_caps[MIGRATION_CAPABILITY_FIXED_RAM]) {
+        if (new_caps[MIGRATION_CAPABILITY_MULTIFD]) {
+            error_setg(errp,
+                       "Fixed-ram migration is incompatible with multifd");
+            return false;
+        }
+
+        if (new_caps[MIGRATION_CAPABILITY_XBZRLE]) {
+            error_setg(errp,
+                       "Fixed-ram migration is incompatible with xbzrle");
+            return false;
+        }
+
+        if (new_caps[MIGRATION_CAPABILITY_COMPRESS]) {
+            error_setg(errp,
+                       "Fixed-ram migration is incompatible with compression");
+            return false;
+        }
+
+        if (new_caps[MIGRATION_CAPABILITY_POSTCOPY_RAM]) {
+            error_setg(errp,
+                       "Fixed-ram migration is incompatible with postcopy ram");
+            return false;
+        }
+    }
+
     return true;
 }
 
diff --git a/migration/options.h b/migration/options.h
index d1ba5c9de7..2a9e0e9e13 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -32,6 +32,7 @@ bool migrate_compress(void);
 bool migrate_dirty_bitmaps(void);
 bool migrate_dirty_limit(void);
 bool migrate_events(void);
+bool migrate_fixed_ram(void);
 bool migrate_ignore_shared(void);
 bool migrate_late_block_activate(void);
 bool migrate_multifd(void);
diff --git a/migration/savevm.c b/migration/savevm.c
index 8622f229e5..54e084122a 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -243,6 +243,7 @@ static bool should_validate_capability(int capability)
     /* Validate only new capabilities to keep compatibility. */
     switch (capability) {
     case MIGRATION_CAPABILITY_X_IGNORE_SHARED:
+    case MIGRATION_CAPABILITY_FIXED_RAM:
         return true;
     default:
         return false;
diff --git a/qapi/migration.json b/qapi/migration.json
index 74f12adc0e..1317dd32ab 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -527,6 +527,9 @@
 #     VM before migration for an optimal migration performance.
 #     Enabled by default. (since 8.1)
 #
+# @fixed-ram: Migrate using fixed offsets for each RAM page. Requires
+#             a seekable transport such as a file.  (since 8.1)
+#
 # Features:
 #
 # @unstable: Members @x-colo and @x-ignore-shared are experimental.
@@ -543,7 +546,7 @@
            { 'name': 'x-ignore-shared', 'features': [ 'unstable' ] },
            'validate-uuid', 'background-snapshot',
            'zero-copy-send', 'postcopy-preempt', 'switchover-ack',
-           'dirty-limit', 'auto-pause'] }
+           'dirty-limit', 'auto-pause', 'fixed-ram'] }
 
 ##
 # @MigrationCapabilityStatus:
-- 
2.35.3


