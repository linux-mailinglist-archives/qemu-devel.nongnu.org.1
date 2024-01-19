Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B64DA83319F
	for <lists+qemu-devel@lfdr.de>; Sat, 20 Jan 2024 00:41:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQySW-0001zY-H0; Fri, 19 Jan 2024 18:39:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rQySU-0001xL-CV
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 18:39:34 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rQySS-0001xg-1u
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 18:39:34 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id ACFCF1F818;
 Fri, 19 Jan 2024 23:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705707567; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eLYCl+gMT4ddn1mw8JU4xXGW6AvL44IdTtwI3nWSa3s=;
 b=dArSd9/HT7rX4iC0YQHPlX+Wg099lstvvaHxnIdXiHAmOaGO/3Xi8HcCFmdDS15vXCyGON
 yC/2+bOehhHahtwTJr8+84IYS2I99eug4HbsA82mnr35S/scksatUthLWM844uX++0nkYS
 k6lMOfWx/BpznYrhU5ofm29lMLz7L0w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705707567;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eLYCl+gMT4ddn1mw8JU4xXGW6AvL44IdTtwI3nWSa3s=;
 b=VxzwgKPYU1IL4Y1ng9F05rH/VJtGg4Xh6NihVavlEYw7gjzdsvpp5n3NnjvnWhbTUuQv+j
 FmfuwXZNRVkFgdDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705707567; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eLYCl+gMT4ddn1mw8JU4xXGW6AvL44IdTtwI3nWSa3s=;
 b=dArSd9/HT7rX4iC0YQHPlX+Wg099lstvvaHxnIdXiHAmOaGO/3Xi8HcCFmdDS15vXCyGON
 yC/2+bOehhHahtwTJr8+84IYS2I99eug4HbsA82mnr35S/scksatUthLWM844uX++0nkYS
 k6lMOfWx/BpznYrhU5ofm29lMLz7L0w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705707567;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eLYCl+gMT4ddn1mw8JU4xXGW6AvL44IdTtwI3nWSa3s=;
 b=VxzwgKPYU1IL4Y1ng9F05rH/VJtGg4Xh6NihVavlEYw7gjzdsvpp5n3NnjvnWhbTUuQv+j
 FmfuwXZNRVkFgdDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BBF171375D;
 Fri, 19 Jan 2024 23:39:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id CLBUIC4Iq2VxVAAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 19 Jan 2024 23:39:26 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
Subject: [PATCH 1/5] migration: Fix use-after-free of migration state object
Date: Fri, 19 Jan 2024 20:39:18 -0300
Message-Id: <20240119233922.32588-2-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240119233922.32588-1-farosas@suse.de>
References: <20240119233922.32588-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: /
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="dArSd9/H";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=VxzwgKPY
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.54 / 50.00]; ARC_NA(0.00)[];
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
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-2.95)[99.77%]
X-Spam-Score: 0.54
X-Rspamd-Queue-Id: ACFCF1F818
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

We're currently allowing the process_incoming_migration_bh bottom-half
to run without holding a reference to the 'current_migration' object,
which leads to a segmentation fault if the BH is still live after
migration_shutdown() has dropped the last reference to
current_migration.

In my system the bug manifests as migrate_multifd() returning true
when it shouldn't and multifd_load_shutdown() calling
multifd_recv_terminate_threads() which crashes due to an uninitialized
multifd_recv_state.

Fix the issue by holding a reference to the object when scheduling the
BH and dropping it before returning from the BH. The same is already
done for the cleanup_bh at migrate_fd_cleanup_schedule().

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/migration/migration.c b/migration/migration.c
index 219447dea1..cf17b68e57 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -648,6 +648,7 @@ static void process_incoming_migration_bh(void *opaque)
                       MIGRATION_STATUS_COMPLETED);
     qemu_bh_delete(mis->bh);
     migration_incoming_state_destroy();
+    object_unref(OBJECT(migrate_get_current()));
 }
 
 static void coroutine_fn
@@ -713,6 +714,7 @@ process_incoming_migration_co(void *opaque)
     }
 
     mis->bh = qemu_bh_new(process_incoming_migration_bh, mis);
+    object_ref(OBJECT(migrate_get_current()));
     qemu_bh_schedule(mis->bh);
     return;
 fail:
-- 
2.35.3


