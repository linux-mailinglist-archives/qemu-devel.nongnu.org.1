Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE30F8CDA69
	for <lists+qemu-devel@lfdr.de>; Thu, 23 May 2024 21:07:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sADlU-000280-2F; Thu, 23 May 2024 15:06:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sADlR-00025A-3T
 for qemu-devel@nongnu.org; Thu, 23 May 2024 15:06:09 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sADlP-0004Ge-Fp
 for qemu-devel@nongnu.org; Thu, 23 May 2024 15:06:08 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 232F622B78;
 Thu, 23 May 2024 19:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716491166; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ntI6Ev69Q4/AWtXPMvGfO4VO9JtK9Spzna77OmuCw9c=;
 b=Go53YdA1SA6+a5WbRJO+pUKq/veH8Xx+iV1z5aWdhfkKeMA/XyErsdweaBp2qR/3Jr1fpm
 OVaIwm07bnuiaYErIat9zE0Cb/TB/J0sFQqLnXxLoqUK7Kd+R4th/LGaTTkYrP8X0ZuKV8
 AsF96vFzmAFpbmXfSW4RnQcPAw29+lk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716491166;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ntI6Ev69Q4/AWtXPMvGfO4VO9JtK9Spzna77OmuCw9c=;
 b=V7CytLSLPBfezC7lkOZC2Gf1Qmv99sdXLILUsRSmntGqJQF9pFQ/GnQroZUQhKRWh4YH8j
 1Rr2LrDA/JOyPMAA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Go53YdA1;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=V7CytLSL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716491166; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ntI6Ev69Q4/AWtXPMvGfO4VO9JtK9Spzna77OmuCw9c=;
 b=Go53YdA1SA6+a5WbRJO+pUKq/veH8Xx+iV1z5aWdhfkKeMA/XyErsdweaBp2qR/3Jr1fpm
 OVaIwm07bnuiaYErIat9zE0Cb/TB/J0sFQqLnXxLoqUK7Kd+R4th/LGaTTkYrP8X0ZuKV8
 AsF96vFzmAFpbmXfSW4RnQcPAw29+lk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716491166;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ntI6Ev69Q4/AWtXPMvGfO4VO9JtK9Spzna77OmuCw9c=;
 b=V7CytLSLPBfezC7lkOZC2Gf1Qmv99sdXLILUsRSmntGqJQF9pFQ/GnQroZUQhKRWh4YH8j
 1Rr2LrDA/JOyPMAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4BB8F13A6B;
 Thu, 23 May 2024 19:06:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0JvzBJyTT2bUEQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 23 May 2024 19:06:04 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Claudio Fontana <cfontana@suse.de>, Jim Fehlig <jfehlig@suse.com>
Subject: [PATCH v2 05/18] monitor: Introduce monitor_fdset_*free
Date: Thu, 23 May 2024 16:05:35 -0300
Message-Id: <20240523190548.23977-6-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240523190548.23977-1-farosas@suse.de>
References: <20240523190548.23977-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.03 / 50.00]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 BAYES_HAM(-0.02)[54.66%]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 RCPT_COUNT_FIVE(0.00)[6]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 232F622B78
X-Spam-Score: -0.03
X-Spamd-Bar: /
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

Introduce two new functions to remove and free no longer used fds and
fdsets.

We need those to decouple the remove/free routines from
monitor_fdset_cleanup() which will go away in the next patches.

The new functions:

- monitor_fdset_free() will be used when a monitor connection closes
  and when an fd is removed to cleanup any fdset that is now empty.

- monitor_fdset_fd_free() will be used to remove one or more fds that
  have been explicitly targeted by qmp_remove_fd().

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 monitor/fds.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/monitor/fds.c b/monitor/fds.c
index fb9f58c056..101e21720d 100644
--- a/monitor/fds.c
+++ b/monitor/fds.c
@@ -167,6 +167,22 @@ int monitor_get_fd(Monitor *mon, const char *fdname, Error **errp)
     return -1;
 }
 
+static void monitor_fdset_free(MonFdset *mon_fdset)
+{
+    if (QLIST_EMPTY(&mon_fdset->fds) && QLIST_EMPTY(&mon_fdset->dup_fds)) {
+        QLIST_REMOVE(mon_fdset, next);
+        g_free(mon_fdset);
+    }
+}
+
+static void monitor_fdset_fd_free(MonFdsetFd *mon_fdset_fd)
+{
+    close(mon_fdset_fd->fd);
+    g_free(mon_fdset_fd->opaque);
+    QLIST_REMOVE(mon_fdset_fd, next);
+    g_free(mon_fdset_fd);
+}
+
 static void monitor_fdset_cleanup(MonFdset *mon_fdset)
 {
     MonFdsetFd *mon_fdset_fd;
@@ -176,17 +192,11 @@ static void monitor_fdset_cleanup(MonFdset *mon_fdset)
         if ((mon_fdset_fd->removed ||
                 (QLIST_EMPTY(&mon_fdset->dup_fds) && mon_refcount == 0)) &&
                 runstate_is_running()) {
-            close(mon_fdset_fd->fd);
-            g_free(mon_fdset_fd->opaque);
-            QLIST_REMOVE(mon_fdset_fd, next);
-            g_free(mon_fdset_fd);
+            monitor_fdset_fd_free(mon_fdset_fd);
         }
     }
 
-    if (QLIST_EMPTY(&mon_fdset->fds) && QLIST_EMPTY(&mon_fdset->dup_fds)) {
-        QLIST_REMOVE(mon_fdset, next);
-        g_free(mon_fdset);
-    }
+    monitor_fdset_free(mon_fdset);
 }
 
 void monitor_fdsets_cleanup(void)
-- 
2.35.3


