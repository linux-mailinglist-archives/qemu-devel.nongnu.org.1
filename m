Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF257D40FB
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 22:37:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qv1f9-0002l7-Th; Mon, 23 Oct 2023 16:36:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qv1f6-0002kh-OU
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 16:36:32 -0400
Received: from smtp-out1.suse.de ([195.135.220.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qv1f5-0001nr-1n
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 16:36:32 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 85DB621B29;
 Mon, 23 Oct 2023 20:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1698093389; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FpnhhvWkT5fjFh1pW+rIsNyZU3Z0zam/MWzdccJKKlc=;
 b=i98Hf1xC6hCPwH0njFqVXLuur93QAmp+QzWeLBWeaUrnMhpnNMrhSPfsZzaaTgPPkJ213x
 mw85cVsygJzUlp8eR/8H/j0azLkMDKmR2ctFoukqP9Z8rjDBNeVsszmXlYOIQdAzzb8ssE
 f4BlRu5gTpExFWYieWlweqsjgmIjzuA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1698093389;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FpnhhvWkT5fjFh1pW+rIsNyZU3Z0zam/MWzdccJKKlc=;
 b=ZG3VbFGQPapwfMp1w4BP1u32HxVzmVN+f/37KienqW1bT4LP1DKzaxTOVt8b3wUJkrebyk
 TDKj7HIXYdDrTVBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 67A6F132FD;
 Mon, 23 Oct 2023 20:36:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 4PQODUvZNmV1JQAAMHmgww
 (envelope-from <farosas@suse.de>); Mon, 23 Oct 2023 20:36:27 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Claudio Fontana <cfontana@suse.de>,
 Eric Blake <eblake@redhat.com>
Subject: [PATCH v2 06/29] migration: Add auto-pause capability
Date: Mon, 23 Oct 2023 17:35:45 -0300
Message-Id: <20231023203608.26370-7-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231023203608.26370-1-farosas@suse.de>
References: <20231023203608.26370-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
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
Received-SPF: pass client-ip=195.135.220.28; envelope-from=farosas@suse.de;
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

Add a capability that allows the management layer to delegate to QEMU
the decision of whether to pause a VM and perform a non-live
migration. Depending on the type of migration being performed, this
could bring performance benefits.

Note that the capability is enabled by default but at this moment no
migration scheme is making use of it.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c | 19 +++++++++++++++++++
 migration/options.c   |  9 +++++++++
 migration/options.h   |  1 +
 qapi/migration.json   |  6 +++++-
 4 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/migration/migration.c b/migration/migration.c
index a6efbd837a..8b0c3b0911 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -124,6 +124,20 @@ migration_channels_and_uri_compatible(const char *uri, Error **errp)
     return true;
 }
 
+static bool migration_should_pause(const char *uri)
+{
+    if (!migrate_auto_pause()) {
+        return false;
+    }
+
+    /*
+     * Return true for migration schemes that benefit from a nonlive
+     * migration.
+     */
+
+    return false;
+}
+
 static gint page_request_addr_cmp(gconstpointer ap, gconstpointer bp)
 {
     uintptr_t a = (uintptr_t) ap, b = (uintptr_t) bp;
@@ -1724,6 +1738,11 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
         }
     }
 
+    if (migration_should_pause(uri)) {
+        global_state_store();
+        vm_stop_force_state(RUN_STATE_PAUSED);
+    }
+
     if (strstart(uri, "tcp:", &p) ||
         strstart(uri, "unix:", NULL) ||
         strstart(uri, "vsock:", NULL)) {
diff --git a/migration/options.c b/migration/options.c
index 42fb818956..c3def757fe 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -200,6 +200,8 @@ Property migration_properties[] = {
     DEFINE_PROP_MIG_CAP("x-switchover-ack",
                         MIGRATION_CAPABILITY_SWITCHOVER_ACK),
     DEFINE_PROP_MIG_CAP("x-dirty-limit", MIGRATION_CAPABILITY_DIRTY_LIMIT),
+    DEFINE_PROP_BOOL("x-auto-pause", MigrationState,
+                     capabilities[MIGRATION_CAPABILITY_AUTO_PAUSE], true),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -210,6 +212,13 @@ bool migrate_auto_converge(void)
     return s->capabilities[MIGRATION_CAPABILITY_AUTO_CONVERGE];
 }
 
+bool migrate_auto_pause(void)
+{
+    MigrationState *s = migrate_get_current();
+
+    return s->capabilities[MIGRATION_CAPABILITY_AUTO_PAUSE];
+}
+
 bool migrate_background_snapshot(void)
 {
     MigrationState *s = migrate_get_current();
diff --git a/migration/options.h b/migration/options.h
index 237f2d6b4a..d1ba5c9de7 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -24,6 +24,7 @@ extern Property migration_properties[];
 /* capabilities */
 
 bool migrate_auto_converge(void);
+bool migrate_auto_pause(void);
 bool migrate_background_snapshot(void);
 bool migrate_block(void);
 bool migrate_colo(void);
diff --git a/qapi/migration.json b/qapi/migration.json
index db3df12d6c..74f12adc0e 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -523,6 +523,10 @@
 #     and can result in more stable read performance.  Requires KVM
 #     with accelerator property "dirty-ring-size" set.  (Since 8.1)
 #
+# @auto-pause: If enabled, allows QEMU to decide whether to pause the
+#     VM before migration for an optimal migration performance.
+#     Enabled by default. (since 8.1)
+#
 # Features:
 #
 # @unstable: Members @x-colo and @x-ignore-shared are experimental.
@@ -539,7 +543,7 @@
            { 'name': 'x-ignore-shared', 'features': [ 'unstable' ] },
            'validate-uuid', 'background-snapshot',
            'zero-copy-send', 'postcopy-preempt', 'switchover-ack',
-           'dirty-limit'] }
+           'dirty-limit', 'auto-pause'] }
 
 ##
 # @MigrationCapabilityStatus:
-- 
2.35.3


