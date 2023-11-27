Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 477837FAB8A
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 21:30:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7iBs-0002Vd-6O; Mon, 27 Nov 2023 15:26:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1r7iBh-0002TN-8g
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 15:26:38 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1r7iBe-0002kI-G9
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 15:26:37 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5D5D01FB71;
 Mon, 27 Nov 2023 20:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1701116793; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s3xNLf0T59698o5pwcOOswB8tpTOmTYEsBTx8/X3ZJI=;
 b=g9xVl8T+J4UuvoWidO7j6b/e0lYoihgko+kdB8rqNuHjGCdYyxq5PayGCJ47dIvt8VYn+J
 N5odBGsLATCNOltbPxbylsm111tKsDhoWyNIuxcz5IXkYAyCG7b+O9EmuNZp1JLTK/pI0k
 dlMgJ3GrG6rPCsJ5zObwYPzYgCoFp5A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1701116793;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s3xNLf0T59698o5pwcOOswB8tpTOmTYEsBTx8/X3ZJI=;
 b=I68yqGmrcMm/BKgdk4cBUjUzg2yBwGjgxo6TsM1PGgyLpGaxODxhnBlgdPk/a/fzqwE4dk
 KneBwDoEqskqGlDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0FD991379A;
 Mon, 27 Nov 2023 20:26:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WMDxMXb7ZGVfIQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 27 Nov 2023 20:26:30 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Claudio Fontana <cfontana@suse.de>,
 Eric Blake <eblake@redhat.com>
Subject: [RFC PATCH v3 06/30] migration/ram: Introduce 'fixed-ram' migration
 capability
Date: Mon, 27 Nov 2023 17:25:48 -0300
Message-Id: <20231127202612.23012-7-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231127202612.23012-1-farosas@suse.de>
References: <20231127202612.23012-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: 0.90
X-Spamd-Result: default: False [0.90 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_SEVEN(0.00)[8]; MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The core of the feature is to ensure that each RAM page has a specific
offset in the resulting migration stream. The reasons why we'd want
such behavior are:

 - The resulting file will have a bounded size, since pages which are
   dirtied multiple times will always go to a fixed location in the
   file, rather than constantly being added to a sequential
   stream. This eliminates cases where a VM with, say, 1G of RAM can
   result in a migration file that's 10s of GBs, provided that the
   workload constantly redirties memory.

 - It paves the way to implement O_DIRECT-enabled save/restore of the
   migration stream as the pages are ensured to be written at aligned
   offsets.

 - It allows the usage of multifd so we can write RAM pages to the
   migration file in parallel.

For now, enabling the capability has no effect. The next couple of
patches implement the core functionality.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
- mentioned seeking on docs
---
 docs/devel/migration.rst | 21 +++++++++++++++++++++
 migration/options.c      | 34 ++++++++++++++++++++++++++++++++++
 migration/options.h      |  1 +
 migration/savevm.c       |  1 +
 qapi/migration.json      |  6 +++++-
 5 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/docs/devel/migration.rst b/docs/devel/migration.rst
index ec55089b25..eeb4fec31f 100644
--- a/docs/devel/migration.rst
+++ b/docs/devel/migration.rst
@@ -572,6 +572,27 @@ Others (especially either older devices or system devices which for
 some reason don't have a bus concept) make use of the ``instance id``
 for otherwise identically named devices.
 
+Fixed-ram format
+----------------
+
+When the ``fixed-ram`` capability is enabled, a slightly different
+stream format is used for the RAM section. Instead of having a
+sequential stream of pages that follow the RAMBlock headers, the dirty
+pages for a RAMBlock follow its header. This ensures that each RAM
+page has a fixed offset in the resulting migration file.
+
+The ``fixed-ram`` capability must be enabled in both source and
+destination with:
+
+    ``migrate_set_capability fixed-ram on``
+
+Since pages are written to their relative offsets and out of order
+(due to the memory dirtying patterns), streaming channels such as
+sockets are not supported. A seekable channel such as a file is
+required. This can be verified in the QIOChannel by the presence of
+the QIO_CHANNEL_FEATURE_SEEKABLE. In more practical terms, this
+migration format requires the ``file:`` URI when migrating.
+
 Return path
 -----------
 
diff --git a/migration/options.c b/migration/options.c
index 8d8ec73ad9..775428a8a5 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -204,6 +204,7 @@ Property migration_properties[] = {
     DEFINE_PROP_MIG_CAP("x-switchover-ack",
                         MIGRATION_CAPABILITY_SWITCHOVER_ACK),
     DEFINE_PROP_MIG_CAP("x-dirty-limit", MIGRATION_CAPABILITY_DIRTY_LIMIT),
+    DEFINE_PROP_MIG_CAP("x-fixed-ram", MIGRATION_CAPABILITY_FIXED_RAM),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -263,6 +264,13 @@ bool migrate_events(void)
     return s->capabilities[MIGRATION_CAPABILITY_EVENTS];
 }
 
+bool migrate_fixed_ram(void)
+{
+    MigrationState *s = migrate_get_current();
+
+    return s->capabilities[MIGRATION_CAPABILITY_FIXED_RAM];
+}
+
 bool migrate_ignore_shared(void)
 {
     MigrationState *s = migrate_get_current();
@@ -645,6 +653,32 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
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
index 246c160aee..8680a10b79 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -31,6 +31,7 @@ bool migrate_compress(void);
 bool migrate_dirty_bitmaps(void);
 bool migrate_dirty_limit(void);
 bool migrate_events(void);
+bool migrate_fixed_ram(void);
 bool migrate_ignore_shared(void);
 bool migrate_late_block_activate(void);
 bool migrate_multifd(void);
diff --git a/migration/savevm.c b/migration/savevm.c
index eec5503a42..48c37bd198 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -245,6 +245,7 @@ static bool should_validate_capability(int capability)
     /* Validate only new capabilities to keep compatibility. */
     switch (capability) {
     case MIGRATION_CAPABILITY_X_IGNORE_SHARED:
+    case MIGRATION_CAPABILITY_FIXED_RAM:
         return true;
     default:
         return false;
diff --git a/qapi/migration.json b/qapi/migration.json
index eb2f883513..3b93e13743 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -531,6 +531,10 @@
 #     and can result in more stable read performance.  Requires KVM
 #     with accelerator property "dirty-ring-size" set.  (Since 8.1)
 #
+# @fixed-ram: Migrate using fixed offsets for each RAM page.  Requires
+#     a migration URI that supports seeking, such as a file.  (since
+#     8.2)
+#
 # Features:
 #
 # @deprecated: Member @block is deprecated.  Use blockdev-mirror with
@@ -555,7 +559,7 @@
            { 'name': 'x-ignore-shared', 'features': [ 'unstable' ] },
            'validate-uuid', 'background-snapshot',
            'zero-copy-send', 'postcopy-preempt', 'switchover-ack',
-           'dirty-limit'] }
+           'dirty-limit', 'fixed-ram'] }
 
 ##
 # @MigrationCapabilityStatus:
-- 
2.35.3


