Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 66286B0E743
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Jul 2025 01:44:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueMdM-0002Xw-SD; Tue, 22 Jul 2025 19:42:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1ueMdK-0002Vv-HB
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 19:42:54 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1ueMdI-0007sT-KS
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 19:42:54 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2AEBA1F7B2;
 Tue, 22 Jul 2025 23:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1753227751; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KPHQdKOsJoUO2aXXmjAa2hdW3VeBDD42pfqDwCgqC8g=;
 b=MTNzmeNmiZ0gtd+9DPTuvFcbUr38sLaiVCzjdkIkZWOtoqNRNUkV7bZo6Tujl9gi40dgFc
 gK3m4JwBYZocZahpLfB0uYnLv1Lq/33nSXgCdNSEBn5zBMKPtssVVeRD68vwQWb6td2Ip2
 tKa6EK70NEO8yX+pPd57n58YIzxn23c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1753227751;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KPHQdKOsJoUO2aXXmjAa2hdW3VeBDD42pfqDwCgqC8g=;
 b=srA5TPjydkAoJM2pk8ng1qMBPdGKUM41v5VFaFcfx6ivKCEIJZ5RkP8Z/GKNLwO7zQ+yiS
 kdS8UyTgXi/OqFAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1753227751; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KPHQdKOsJoUO2aXXmjAa2hdW3VeBDD42pfqDwCgqC8g=;
 b=MTNzmeNmiZ0gtd+9DPTuvFcbUr38sLaiVCzjdkIkZWOtoqNRNUkV7bZo6Tujl9gi40dgFc
 gK3m4JwBYZocZahpLfB0uYnLv1Lq/33nSXgCdNSEBn5zBMKPtssVVeRD68vwQWb6td2Ip2
 tKa6EK70NEO8yX+pPd57n58YIzxn23c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1753227751;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KPHQdKOsJoUO2aXXmjAa2hdW3VeBDD42pfqDwCgqC8g=;
 b=srA5TPjydkAoJM2pk8ng1qMBPdGKUM41v5VFaFcfx6ivKCEIJZ5RkP8Z/GKNLwO7zQ+yiS
 kdS8UyTgXi/OqFAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CD03513A32;
 Tue, 22 Jul 2025 23:42:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id AG5vIuUhgGiqOgAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 22 Jul 2025 23:42:29 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 6/7] migration: activate TLS thread safety workaround
Date: Tue, 22 Jul 2025 20:42:14 -0300
Message-Id: <20250722234215.6807-7-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250722234215.6807-1-farosas@suse.de>
References: <20250722234215.6807-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:email,
 imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.30
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

From: Daniel P. Berrangé <berrange@redhat.com>

When either the postcopy or return path capabilities are
enabled, the migration code will use the primary channel
for bidirectional I/O.

If either of those capabilities are enabled, the migration
code needs to mark the channel as expecting concurrent I/O
in order to activate the thread safety workarounds for
GNUTLS bug 1717

Closes: https://gitlab.com/qemu-project/qemu/-/issues/1937
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/qemu-devel/20250718150514.2635338-4-berrange@redhat.com
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/tls.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/migration/tls.c b/migration/tls.c
index 5cbf952383..284a6194b2 100644
--- a/migration/tls.c
+++ b/migration/tls.c
@@ -90,6 +90,10 @@ void migration_tls_channel_process_incoming(MigrationState *s,
 
     trace_migration_tls_incoming_handshake_start();
     qio_channel_set_name(QIO_CHANNEL(tioc), "migration-tls-incoming");
+    if (migrate_postcopy_ram() || migrate_return_path()) {
+        qio_channel_set_feature(QIO_CHANNEL(tioc),
+                                QIO_CHANNEL_FEATURE_CONCURRENT_IO);
+    }
     qio_channel_tls_handshake(tioc,
                               migration_tls_incoming_handshake,
                               NULL,
@@ -149,6 +153,11 @@ void migration_tls_channel_connect(MigrationState *s,
     s->hostname = g_strdup(hostname);
     trace_migration_tls_outgoing_handshake_start(hostname);
     qio_channel_set_name(QIO_CHANNEL(tioc), "migration-tls-outgoing");
+
+    if (migrate_postcopy_ram() || migrate_return_path()) {
+        qio_channel_set_feature(QIO_CHANNEL(tioc),
+                                QIO_CHANNEL_FEATURE_CONCURRENT_IO);
+    }
     qio_channel_tls_handshake(tioc,
                               migration_tls_outgoing_handshake,
                               s,
-- 
2.35.3


