Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 122458CDA7D
	for <lists+qemu-devel@lfdr.de>; Thu, 23 May 2024 21:08:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sADlW-00029O-F9; Thu, 23 May 2024 15:06:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sADlT-00028G-TF
 for qemu-devel@nongnu.org; Thu, 23 May 2024 15:06:11 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sADlR-0004H0-VK
 for qemu-devel@nongnu.org; Thu, 23 May 2024 15:06:11 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A716022B79;
 Thu, 23 May 2024 19:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716491168; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3zM6yJwrUnBGwhUnSZK8j874ter6lal7RTb8Pv37dNs=;
 b=Wg3LQHahoag2mLxT2rDJ/FJolYa/JcopKAgRUY1L4CJbaYSpC7OYTwluC8qaLPLjzPNUf1
 5B9yPLkDt62tmqnruns2vOnX6UwrfefG0131OAUaxC99R+Qdg5i95egGCFaO/mid7VejdI
 a6Io0b5D+ZhOyDlmZuXr70M+xeJf+Ew=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716491168;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3zM6yJwrUnBGwhUnSZK8j874ter6lal7RTb8Pv37dNs=;
 b=8xy3hrevmWTi0iR6zU+5N62Jhc/h77jL7qy7B+fOulx6hpUeKAlQ2D0YU6upafhc0sxEqN
 /5v7/vFKoOR5xZBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716491168; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3zM6yJwrUnBGwhUnSZK8j874ter6lal7RTb8Pv37dNs=;
 b=Wg3LQHahoag2mLxT2rDJ/FJolYa/JcopKAgRUY1L4CJbaYSpC7OYTwluC8qaLPLjzPNUf1
 5B9yPLkDt62tmqnruns2vOnX6UwrfefG0131OAUaxC99R+Qdg5i95egGCFaO/mid7VejdI
 a6Io0b5D+ZhOyDlmZuXr70M+xeJf+Ew=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716491168;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3zM6yJwrUnBGwhUnSZK8j874ter6lal7RTb8Pv37dNs=;
 b=8xy3hrevmWTi0iR6zU+5N62Jhc/h77jL7qy7B+fOulx6hpUeKAlQ2D0YU6upafhc0sxEqN
 /5v7/vFKoOR5xZBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 984FA13A6B;
 Thu, 23 May 2024 19:06:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yLbXF56TT2bUEQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 23 May 2024 19:06:06 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Claudio Fontana <cfontana@suse.de>, Jim Fehlig <jfehlig@suse.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH v2 06/18] monitor: Stop removing non-duplicated fds
Date: Thu, 23 May 2024 16:05:36 -0300
Message-Id: <20240523190548.23977-7-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240523190548.23977-1-farosas@suse.de>
References: <20240523190548.23977-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_SEVEN(0.00)[7];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email];
 RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
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

We've been up until now cleaning up any file descriptors that have
been passed into QEMU and never duplicated[1,2]. A file descriptor
without duplicates indicates that no part of QEMU has made use of
it. This approach is starting to show some cracks now that we're
starting to consume fds from the migration code:

- Doing cleanup every time the last monitor connection closes works to
  reap unused fds, but also has the side effect of forcing the
  management layer to pass the file descriptors again in case of a
  disconnect/re-connect, if that happened to be the only monitor
  connection.

  Another side effect is that removing an fd with qmp_remove_fd() is
  effectively delayed until the last monitor connection closes.

  The reliance on mon_refcount is also problematic because it's racy.

- Checking runstate_is_running() skips the cleanup unless the VM is
  running and avoids premature cleanup of the fds, but also has the
  side effect of blocking the legitimate removal of an fd via
  qmp_remove_fd() if the VM happens to be in another state.

  This affects qmp_remove_fd() and qmp_query_fdsets() in particular
  because requesting a removal at a bad time (guest stopped) might
  cause an fd to never be removed, or to be removed at a much later
  point in time, causing the query command to continue showing the
  supposedly removed fd/fdset.

Note that file descriptors that *have* been duplicated are owned by
the code that uses them and will be removed after qemu_close() is
called. Therefore we've decided that the best course of action to
avoid the undesired side-effects is to stop managing non-duplicated
file descriptors.

1- efb87c1697 ("monitor: Clean up fd sets on monitor disconnect")
2- ebe52b592d ("monitor: Prevent removing fd from set during init")

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 monitor/fds.c              | 15 ++++++++-------
 monitor/hmp.c              |  2 --
 monitor/monitor-internal.h |  1 -
 monitor/qmp.c              |  2 --
 4 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/monitor/fds.c b/monitor/fds.c
index 101e21720d..f7b98814fa 100644
--- a/monitor/fds.c
+++ b/monitor/fds.c
@@ -169,6 +169,11 @@ int monitor_get_fd(Monitor *mon, const char *fdname, Error **errp)
 
 static void monitor_fdset_free(MonFdset *mon_fdset)
 {
+    /*
+     * Only remove an empty fdset. The fds are owned by the user and
+     * should have been removed with qmp_remove_fd(). The dup_fds are
+     * owned by QEMU and should have been removed with qemu_close().
+     */
     if (QLIST_EMPTY(&mon_fdset->fds) && QLIST_EMPTY(&mon_fdset->dup_fds)) {
         QLIST_REMOVE(mon_fdset, next);
         g_free(mon_fdset);
@@ -189,9 +194,7 @@ static void monitor_fdset_cleanup(MonFdset *mon_fdset)
     MonFdsetFd *mon_fdset_fd_next;
 
     QLIST_FOREACH_SAFE(mon_fdset_fd, &mon_fdset->fds, next, mon_fdset_fd_next) {
-        if ((mon_fdset_fd->removed ||
-                (QLIST_EMPTY(&mon_fdset->dup_fds) && mon_refcount == 0)) &&
-                runstate_is_running()) {
+        if (mon_fdset_fd->removed) {
             monitor_fdset_fd_free(mon_fdset_fd);
         }
     }
@@ -206,7 +209,7 @@ void monitor_fdsets_cleanup(void)
 
     QEMU_LOCK_GUARD(&mon_fdsets_lock);
     QLIST_FOREACH_SAFE(mon_fdset, &mon_fdsets, next, mon_fdset_next) {
-        monitor_fdset_cleanup(mon_fdset);
+        monitor_fdset_free(mon_fdset);
     }
 }
 
@@ -479,9 +482,7 @@ void monitor_fdset_dup_fd_remove(int dup_fd)
             if (mon_fdset_fd_dup->fd == dup_fd) {
                 QLIST_REMOVE(mon_fdset_fd_dup, next);
                 g_free(mon_fdset_fd_dup);
-                if (QLIST_EMPTY(&mon_fdset->dup_fds)) {
-                    monitor_fdset_cleanup(mon_fdset);
-                }
+                monitor_fdset_free(mon_fdset);
                 return;
             }
         }
diff --git a/monitor/hmp.c b/monitor/hmp.c
index 69c1b7e98a..460e8832f6 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -1437,11 +1437,9 @@ static void monitor_event(void *opaque, QEMUChrEvent event)
             monitor_resume(mon);
         }
         qemu_mutex_unlock(&mon->mon_lock);
-        mon_refcount++;
         break;
 
     case CHR_EVENT_CLOSED:
-        mon_refcount--;
         monitor_fdsets_cleanup();
         break;
 
diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
index 252de85681..cb628f681d 100644
--- a/monitor/monitor-internal.h
+++ b/monitor/monitor-internal.h
@@ -168,7 +168,6 @@ extern bool qmp_dispatcher_co_shutdown;
 extern QmpCommandList qmp_commands, qmp_cap_negotiation_commands;
 extern QemuMutex monitor_lock;
 extern MonitorList mon_list;
-extern int mon_refcount;
 
 extern HMPCommand hmp_cmds[];
 
diff --git a/monitor/qmp.c b/monitor/qmp.c
index a239945e8d..5e538f34c0 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -466,7 +466,6 @@ static void monitor_qmp_event(void *opaque, QEMUChrEvent event)
         data = qmp_greeting(mon);
         qmp_send_response(mon, data);
         qobject_unref(data);
-        mon_refcount++;
         break;
     case CHR_EVENT_CLOSED:
         /*
@@ -479,7 +478,6 @@ static void monitor_qmp_event(void *opaque, QEMUChrEvent event)
         json_message_parser_destroy(&mon->parser);
         json_message_parser_init(&mon->parser, handle_qmp_command,
                                  mon, NULL);
-        mon_refcount--;
         monitor_fdsets_cleanup();
         break;
     case CHR_EVENT_BREAK:
-- 
2.35.3


