Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 17044A311C2
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Feb 2025 17:38:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thtGx-00034M-EN; Tue, 11 Feb 2025 11:38:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1thtG7-0002IT-GK
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:37:17 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1thtG5-0008TD-4b
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:37:15 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D02F137C1A;
 Tue, 11 Feb 2025 15:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1739286111; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w6zyp1OJxPRBDtAMlQSuXOqySwtjEkwC0rRKYi096zg=;
 b=ZX5qYRm1FS/wF77KYd2YcDfoXj532gMAhocbSMxu5NWtNkXcrr3rxyFhbUoDx2knYbntIy
 XXnFkHTIfWSDYWn6r/YHBYOVI9iPtkWnjkmppFKZAk9Mh3nS5sVc+YkpMXMPphZDg7Yl+b
 7mXPXNTzNuWs3B5Ue6H/oMMC78swymw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1739286111;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w6zyp1OJxPRBDtAMlQSuXOqySwtjEkwC0rRKYi096zg=;
 b=dV9G/r0vgec8eW6FCNHYeiUfi9i/sufHxKStpADFIjqKCdE9A0ldxFwSncWhjTi7498wp0
 wJ05/p78tWw69dAA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ZX5qYRm1;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="dV9G/r0v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1739286111; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w6zyp1OJxPRBDtAMlQSuXOqySwtjEkwC0rRKYi096zg=;
 b=ZX5qYRm1FS/wF77KYd2YcDfoXj532gMAhocbSMxu5NWtNkXcrr3rxyFhbUoDx2knYbntIy
 XXnFkHTIfWSDYWn6r/YHBYOVI9iPtkWnjkmppFKZAk9Mh3nS5sVc+YkpMXMPphZDg7Yl+b
 7mXPXNTzNuWs3B5Ue6H/oMMC78swymw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1739286111;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w6zyp1OJxPRBDtAMlQSuXOqySwtjEkwC0rRKYi096zg=;
 b=dV9G/r0vgec8eW6FCNHYeiUfi9i/sufHxKStpADFIjqKCdE9A0ldxFwSncWhjTi7498wp0
 wJ05/p78tWw69dAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 88F6A13715;
 Tue, 11 Feb 2025 15:01:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KM6wEl5mq2c8WwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 11 Feb 2025 15:01:50 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 6/9] migration: Don't set FAILED state when cancelling
Date: Tue, 11 Feb 2025 12:01:33 -0300
Message-Id: <20250211150136.6781-7-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250211150136.6781-1-farosas@suse.de>
References: <20250211150136.6781-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D02F137C1A
X-Spamd-Result: default: False [-3.00 / 50.00]; BAYES_HAM(-2.99)[99.97%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.00
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

It's possible that the migration is cancelled during
migration_switchover_start(). In that case, don't set the migration
state FAILED in migration_completion().

Fixes: 3dde8fdbad ("migration: Merge precopy/postcopy on switchover start")
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/migration/migration.c b/migration/migration.c
index 375de6d460..5dc43bcdc0 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2986,7 +2986,9 @@ fail:
         error_free(local_err);
     }
 
-    migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
+    if (s->state != MIGRATION_STATUS_CANCELLING) {
+        migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
+    }
 }
 
 /**
-- 
2.35.3


