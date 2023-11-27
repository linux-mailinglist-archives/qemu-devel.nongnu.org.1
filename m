Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B377FAB90
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 21:31:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7iCX-0003cJ-MO; Mon, 27 Nov 2023 15:27:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1r7iCW-0003bs-Fn
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 15:27:28 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1r7iCU-0002tn-UD
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 15:27:28 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 906001FB54;
 Mon, 27 Nov 2023 20:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1701116845; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/G6ThC3N+nnfX7FJ2t0KT5ydaj0Xe0MiFJ+bC9uw3Bk=;
 b=UiQYTim5poxfOZq/qvYk5lHCePtyIKBGOIJMK6dwi32447452mOt+HoBi4kb8SS+bBvKrJ
 OhBIm2R/yPYMzg4GYh3mdINd+27RtT1qYB8pwSi2OlfsYGWE1tlXAihchw9pehtCmytOYY
 NAmbC3nAqHAmNe8A/h4RsuRrtqnBl4s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1701116845;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/G6ThC3N+nnfX7FJ2t0KT5ydaj0Xe0MiFJ+bC9uw3Bk=;
 b=qfhrvUHEVuvoZWz0GfBrz/NdOgS+9tBOhwgpFfifauS0d8zYtqCLPpJkdCXPtJntxA3fu0
 j9ZGtKTAaMlLexCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 813411379A;
 Mon, 27 Nov 2023 20:27:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MF4AEqv7ZGVfIQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 27 Nov 2023 20:27:23 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Claudio Fontana <cfontana@suse.de>
Subject: [RFC PATCH v3 25/30] monitor: Honor QMP request for fd removal
 immediately
Date: Mon, 27 Nov 2023 17:26:07 -0300
Message-Id: <20231127202612.23012-26-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231127202612.23012-1-farosas@suse.de>
References: <20231127202612.23012-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: 3.90
X-Spamd-Result: default: False [3.90 / 50.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 BROKEN_CONTENT_TYPE(1.50)[]; RCVD_COUNT_THREE(0.00)[3];
 RCPT_COUNT_SEVEN(0.00)[7]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

We're currently only removing an fd from the fdset if the VM is
running. This causes a QMP call to "remove-fd" to not actually remove
the fd if the VM happens to be stopped.

While the fd would eventually be removed when monitor_fdset_cleanup()
is called again, the user request should be honored and the fd
actually removed. Calling remove-fd + query-fdset shows a recently
removed fd still present.

The runstate_is_running() check was introduced by commit ebe52b592d
("monitor: Prevent removing fd from set during init"), which by the
shortlog indicates that they were trying to avoid removing an
yet-unduplicated fd too early.

I don't see why an fd explicitly removed with qmp_remove_fd() should
be under runstate_is_running(). I'm assuming this was a mistake when
adding the parenthesis around the expression.

Move the runstate_is_running() check to apply only to the
QLIST_EMPTY(dup_fds) side of the expression and ignore it when
mon_fdset_fd->removed has been explicitly set.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 monitor/fds.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/monitor/fds.c b/monitor/fds.c
index d86c2c674c..4ec3b7eea9 100644
--- a/monitor/fds.c
+++ b/monitor/fds.c
@@ -173,9 +173,9 @@ static void monitor_fdset_cleanup(MonFdset *mon_fdset)
     MonFdsetFd *mon_fdset_fd_next;
 
     QLIST_FOREACH_SAFE(mon_fdset_fd, &mon_fdset->fds, next, mon_fdset_fd_next) {
-        if ((mon_fdset_fd->removed ||
-                (QLIST_EMPTY(&mon_fdset->dup_fds) && mon_refcount == 0)) &&
-                runstate_is_running()) {
+        if (mon_fdset_fd->removed ||
+            (QLIST_EMPTY(&mon_fdset->dup_fds) && mon_refcount == 0 &&
+             runstate_is_running())) {
             close(mon_fdset_fd->fd);
             g_free(mon_fdset_fd->opaque);
             QLIST_REMOVE(mon_fdset_fd, next);
-- 
2.35.3


