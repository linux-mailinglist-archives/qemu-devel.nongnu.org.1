Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8C48331A3
	for <lists+qemu-devel@lfdr.de>; Sat, 20 Jan 2024 00:41:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQySV-0001yP-TT; Fri, 19 Jan 2024 18:39:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rQyST-0001wk-Ey
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 18:39:33 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rQySR-0001zB-Qd
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 18:39:33 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8938221C1A;
 Fri, 19 Jan 2024 23:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705707570; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XhVc2dXR8NXJ392xyDYZUM9zULcApz5F7NwouJvgobQ=;
 b=d0RfwWxq7B+rqJRrUqe7l9vQ5fq73fKIumss6KeRAeZgLIWKCbbBxy8PPbtrjYzPpFt+z2
 MYI0oFnwUq8nq4hBckcfQfFmFY3XdiB1yf2tOC2LVfrFpkoebxBU/sXQhdxPqUum6BTnvK
 6T40IqTG1KU1K2si53mwZ+wi1GXdLmc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705707570;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XhVc2dXR8NXJ392xyDYZUM9zULcApz5F7NwouJvgobQ=;
 b=+XGHBB2JMYGFGQmFGH34j2PWbeSs5zIPzzCOW/dOihMUK6PigTSvuqq8uVE+2GnfH56nqE
 310yDLYwY9lbNkDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705707570; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XhVc2dXR8NXJ392xyDYZUM9zULcApz5F7NwouJvgobQ=;
 b=d0RfwWxq7B+rqJRrUqe7l9vQ5fq73fKIumss6KeRAeZgLIWKCbbBxy8PPbtrjYzPpFt+z2
 MYI0oFnwUq8nq4hBckcfQfFmFY3XdiB1yf2tOC2LVfrFpkoebxBU/sXQhdxPqUum6BTnvK
 6T40IqTG1KU1K2si53mwZ+wi1GXdLmc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705707570;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XhVc2dXR8NXJ392xyDYZUM9zULcApz5F7NwouJvgobQ=;
 b=+XGHBB2JMYGFGQmFGH34j2PWbeSs5zIPzzCOW/dOihMUK6PigTSvuqq8uVE+2GnfH56nqE
 310yDLYwY9lbNkDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8EBA21375D;
 Fri, 19 Jan 2024 23:39:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2LIFFTEIq2VxVAAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 19 Jan 2024 23:39:29 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
Subject: [PATCH 3/5] migration: Reference migration state around
 loadvm_postcopy_handle_run_bh
Date: Fri, 19 Jan 2024 20:39:20 -0300
Message-Id: <20240119233922.32588-4-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240119233922.32588-1-farosas@suse.de>
References: <20240119233922.32588-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +++
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=d0RfwWxq;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=+XGHBB2J
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [3.47 / 50.00]; ARC_NA(0.00)[];
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
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.02)[54.90%]
X-Spam-Score: 3.47
X-Rspamd-Queue-Id: 8938221C1A
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
async calls to avoid it been freed while still in use. Even on this
load-side function, we might still use the MigrationState, e.g to
check for capabilities.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/savevm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/migration/savevm.c b/migration/savevm.c
index 6410705ebe..93387350c7 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2174,6 +2174,7 @@ static void loadvm_postcopy_handle_run_bh(void *opaque)
     qemu_bh_delete(mis->bh);
 
     trace_vmstate_downtime_checkpoint("dst-postcopy-bh-vm-started");
+    object_unref(OBJECT(migration_get_current()));
 }
 
 /* After all discards we can start running and asking for pages */
@@ -2189,6 +2190,7 @@ static int loadvm_postcopy_handle_run(MigrationIncomingState *mis)
 
     postcopy_state_set(POSTCOPY_INCOMING_RUNNING);
     mis->bh = qemu_bh_new(loadvm_postcopy_handle_run_bh, mis);
+    object_ref(OBJECT(migration_get_current()));
     qemu_bh_schedule(mis->bh);
 
     /* We need to finish reading the stream from the package
-- 
2.35.3


