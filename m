Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F1FB48243B7
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 15:24:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLOcH-0001jn-RY; Thu, 04 Jan 2024 09:22:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rLOc5-0001NC-SG
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 09:22:26 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rLOc3-0008VK-Uu
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 09:22:25 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8FB641FD3A;
 Thu,  4 Jan 2024 14:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1704378142; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ds7ZD9fzeDswWxPM6SZXKq10tj+4KgcCp31XLiwDkXk=;
 b=X+kvww9dSF+D/FmVZ0OXXtl9uTSxv1nU2XGGzFiTvCKjHffn+G9k/6XZ00DcVqulaiuTTo
 vpJK3pKst1jA9km+tdY2TDKzTYV2xOycOMgRHOsd6JKbLBD03tKzDYsg2VgjU1V2zYw2A9
 OMMaNqwd/vJ7FfcQDDGG/fZpCQKwFH8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1704378142;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ds7ZD9fzeDswWxPM6SZXKq10tj+4KgcCp31XLiwDkXk=;
 b=RGTEgVvpxbkQNU5H4A7RFvhxBrj7IM6ke3aAXC3O9GdtmkmK0gH7r/2klywaOb4fBC7C3u
 zGrUjhkgWpNfaGCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1704378142; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ds7ZD9fzeDswWxPM6SZXKq10tj+4KgcCp31XLiwDkXk=;
 b=X+kvww9dSF+D/FmVZ0OXXtl9uTSxv1nU2XGGzFiTvCKjHffn+G9k/6XZ00DcVqulaiuTTo
 vpJK3pKst1jA9km+tdY2TDKzTYV2xOycOMgRHOsd6JKbLBD03tKzDYsg2VgjU1V2zYw2A9
 OMMaNqwd/vJ7FfcQDDGG/fZpCQKwFH8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1704378142;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ds7ZD9fzeDswWxPM6SZXKq10tj+4KgcCp31XLiwDkXk=;
 b=RGTEgVvpxbkQNU5H4A7RFvhxBrj7IM6ke3aAXC3O9GdtmkmK0gH7r/2klywaOb4fBC7C3u
 zGrUjhkgWpNfaGCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9B5EE137E8;
 Thu,  4 Jan 2024 14:22:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YPg+GB2/lmUfPAAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 04 Jan 2024 14:22:21 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
Subject: [PATCH v2 4/7] migration: Report error in incoming migration
Date: Thu,  4 Jan 2024 11:21:41 -0300
Message-Id: <20240104142144.9680-5-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240104142144.9680-1-farosas@suse.de>
References: <20240104142144.9680-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 8FB641FD3A
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=X+kvww9d;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=RGTEgVvp
X-Spam-Score: -1.44
X-Spamd-Result: default: False [-1.44 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain];
 DWL_DNSWL_HI(-3.50)[suse.de:dkim]; BROKEN_CONTENT_TYPE(1.50)[];
 URIBL_BLOCKED(0.00)[suse.de:email,suse.de:dkim];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; RCPT_COUNT_TWO(0.00)[2];
 MID_CONTAINS_FROM(1.00)[]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-2.63)[98.36%];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

We're not currently reporting the errors set with migrate_set_error()
when incoming migration fails.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/migration/migration.c b/migration/migration.c
index 454cd4ec1f..4e0fd24e14 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -699,6 +699,13 @@ process_incoming_migration_co(void *opaque)
     }
 
     if (ret < 0) {
+        MigrationState *s = migrate_get_current();
+
+        if (migrate_has_error(s)) {
+            WITH_QEMU_LOCK_GUARD(&s->error_mutex) {
+                error_report_err(s->error);
+            }
+        }
         error_report("load of migration failed: %s", strerror(-ret));
         goto fail;
     }
-- 
2.35.3


