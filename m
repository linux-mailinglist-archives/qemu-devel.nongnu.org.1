Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE3E58331A2
	for <lists+qemu-devel@lfdr.de>; Sat, 20 Jan 2024 00:41:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQySV-0001xi-9V; Fri, 19 Jan 2024 18:39:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rQyST-0001wL-1o
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 18:39:33 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rQySR-0001y5-F5
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 18:39:32 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1CE7F21EE6;
 Fri, 19 Jan 2024 23:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705707569; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=snCPKhWz5iT0VVGFWUIMW8Z2VOebuj6omp6fgSQpOOM=;
 b=mNIo/SnBvQmpxyxy/rC6it7ty23+z6DT7RBXsKqOzzssguK58buOOvFIHYuioBtZHn/7w5
 oonmHHdzjKlVbqlXH61IZL64jlZ8b22Txcth1TYrTDtVKFxU3VDAMN6IIqA45/790w4ER9
 pGIfk2gO65bbw/bHXThpYh+J84F+cGo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705707569;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=snCPKhWz5iT0VVGFWUIMW8Z2VOebuj6omp6fgSQpOOM=;
 b=L60njkGPgqkiHJOGMqFG415Kad2HjIGInbnikRS4/ESjqWo6PBXs54MtTwv4VTjjwWeiNu
 gkLi3jh/PzSlDKBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705707569; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=snCPKhWz5iT0VVGFWUIMW8Z2VOebuj6omp6fgSQpOOM=;
 b=mNIo/SnBvQmpxyxy/rC6it7ty23+z6DT7RBXsKqOzzssguK58buOOvFIHYuioBtZHn/7w5
 oonmHHdzjKlVbqlXH61IZL64jlZ8b22Txcth1TYrTDtVKFxU3VDAMN6IIqA45/790w4ER9
 pGIfk2gO65bbw/bHXThpYh+J84F+cGo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705707569;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=snCPKhWz5iT0VVGFWUIMW8Z2VOebuj6omp6fgSQpOOM=;
 b=L60njkGPgqkiHJOGMqFG415Kad2HjIGInbnikRS4/ESjqWo6PBXs54MtTwv4VTjjwWeiNu
 gkLi3jh/PzSlDKBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2B0441375D;
 Fri, 19 Jan 2024 23:39:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uCSLOC8Iq2VxVAAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 19 Jan 2024 23:39:27 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
Subject: [PATCH 2/5] migration: Take reference to migration state around
 bg_migration_vm_start_bh
Date: Fri, 19 Jan 2024 20:39:19 -0300
Message-Id: <20240119233922.32588-3-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240119233922.32588-1-farosas@suse.de>
References: <20240119233922.32588-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: /
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="mNIo/SnB";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=L60njkGP
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.57 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; BROKEN_CONTENT_TYPE(1.50)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; RCPT_COUNT_TWO(0.00)[2];
 MID_CONTAINS_FROM(1.00)[]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-2.92)[99.66%]
X-Spam-Score: 0.57
X-Rspamd-Queue-Id: 1CE7F21EE6
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

We need to hold a reference to the current_migration object around
async calls to avoid it been freed while still in use.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/migration/migration.c b/migration/migration.c
index cf17b68e57..b1213b59ce 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3382,6 +3382,7 @@ static void bg_migration_vm_start_bh(void *opaque)
 
     vm_resume(s->vm_old_state);
     migration_downtime_end(s);
+    object_unref(OBJECT(s));
 }
 
 /**
@@ -3486,6 +3487,7 @@ static void *bg_migration_thread(void *opaque)
      * writes to virtio VQs memory which is in write-protected region.
      */
     s->vm_start_bh = qemu_bh_new(bg_migration_vm_start_bh, s);
+    object_ref(OBJECT(s));
     qemu_bh_schedule(s->vm_start_bh);
 
     bql_unlock();
-- 
2.35.3


