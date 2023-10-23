Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CACFA7D3F2A
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 20:24:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quzYf-0004fF-RK; Mon, 23 Oct 2023 14:21:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1quzYd-0004XM-Sw
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:21:43 -0400
Received: from smtp-out1.suse.de ([195.135.220.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1quzYc-0001EO-8V
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:21:43 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 88B7E21B0B;
 Mon, 23 Oct 2023 18:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1698085300; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p3R0+Jms/ZcB0/ntU88sLc494xgmO7OohZhNqG+UJ1o=;
 b=Lw/sNgAFxrUJRtf32sLKKdY1mQPdCNMjBSxmU5jm1ZzfTUPQl0KfLnpQ/Rqdh4JCr/ddi4
 1S7X55kHkSrOFaKM4gYHt+DFDFz+RdKTO4XDYC/0OeJky3qgZgDxn7pgu8ekgEt/2c4FzQ
 1TnIqdO+ljowr2KnYxG5RbL7sqX9IFM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1698085300;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p3R0+Jms/ZcB0/ntU88sLc494xgmO7OohZhNqG+UJ1o=;
 b=IVKIhzUBKaWOHex0CdBgD9USLZaeuEsmPEBxFLBsx15jJv1anKJXKDgVbTL+pXSiGYnCXN
 3E1aMlbUx9OH+LAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 54CFB132FD;
 Mon, 23 Oct 2023 18:21:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 6F4pCLG5NmX8ZwAAMHmgww
 (envelope-from <farosas@suse.de>); Mon, 23 Oct 2023 18:21:37 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, dgilbert@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com, armbru@redhat.com, eblake@redhat.com,
 manish.mishra@nutanix.com, aravind.retnakaran@nutanix.com,
 Het Gala <het.gala@nutanix.com>, Juan Quintela <quintela@redhat.com>,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>
Subject: [PATCH v15 11/14] migration: modify
 migration_channels_and_uri_compatible() for new QAPI syntax
Date: Mon, 23 Oct 2023 15:20:50 -0300
Message-Id: <20231023182053.8711-12-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231023182053.8711-1-farosas@suse.de>
References: <20231023182053.8711-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: -6.09
X-Spamd-Result: default: False [-6.09 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-3.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_TWELVE(0.00)[13];
 MID_CONTAINS_FROM(1.00)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-2.99)[99.93%]
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

From: Het Gala <het.gala@nutanix.com>

migration_channels_and_uri_compatible() check for transport mechanism
suitable for multifd migration gets executed when the caller calls old
uri syntax. It needs it to be run when using the modern MigrateChannel
QAPI syntax too.

After URI -> 'MigrateChannel' :
migration_channels_and_uri_compatible() ->
migration_channels_and_transport_compatible() passes object as argument
and check for valid transport mechanism.

Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
Signed-off-by: Het Gala <het.gala@nutanix.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 4356d9e701..192b7a97be 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -107,17 +107,20 @@ static bool migration_needs_multiple_sockets(void)
     return migrate_multifd() || migrate_postcopy_preempt();
 }
 
-static bool uri_supports_multi_channels(const char *uri)
+static bool transport_supports_multi_channels(SocketAddress *saddr)
 {
-    return strstart(uri, "tcp:", NULL) || strstart(uri, "unix:", NULL) ||
-           strstart(uri, "vsock:", NULL);
+    return saddr->type == SOCKET_ADDRESS_TYPE_INET ||
+           saddr->type == SOCKET_ADDRESS_TYPE_UNIX ||
+           saddr->type == SOCKET_ADDRESS_TYPE_VSOCK;
 }
 
 static bool
-migration_channels_and_uri_compatible(const char *uri, Error **errp)
+migration_channels_and_transport_compatible(MigrationAddress *addr,
+                                            Error **errp)
 {
     if (migration_needs_multiple_sockets() &&
-        !uri_supports_multi_channels(uri)) {
+        (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET) &&
+        !transport_supports_multi_channels(&addr->u.socket)) {
         error_setg(errp, "Migration requires multi-channel URIs (e.g. tcp)");
         return false;
     }
@@ -509,15 +512,15 @@ static void qemu_start_incoming_migration(const char *uri, bool has_channels,
         return;
     }
 
-    /* URI is not suitable for migration? */
-    if (!migration_channels_and_uri_compatible(uri, errp)) {
-        return;
-    }
-
     if (uri && !migrate_uri_parse(uri, &channel, errp)) {
         return;
     }
 
+    /* transport mechanism not suitable for migration? */
+    if (!migration_channels_and_transport_compatible(channel, errp)) {
+        return;
+    }
+
     migrate_set_state(&mis->state, MIGRATION_STATUS_NONE,
                       MIGRATION_STATUS_SETUP);
 
@@ -1812,15 +1815,15 @@ void qmp_migrate(const char *uri, bool has_channels,
         return;
     }
 
-    /* URI is not suitable for migration? */
-    if (!migration_channels_and_uri_compatible(uri, errp)) {
-        return;
-    }
-
     if (!migrate_uri_parse(uri, &channel, errp)) {
         return;
     }
 
+    /* transport mechanism not suitable for migration? */
+    if (!migration_channels_and_transport_compatible(channel, errp)) {
+        return;
+    }
+
     resume_requested = has_resume && resume;
     if (!migrate_prepare(s, has_blk && blk, has_inc && inc,
                          resume_requested, errp)) {
-- 
2.35.3


