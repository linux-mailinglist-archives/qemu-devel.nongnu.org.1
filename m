Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4596A8CDA78
	for <lists+qemu-devel@lfdr.de>; Thu, 23 May 2024 21:08:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sADlT-00025F-GG; Thu, 23 May 2024 15:06:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sADlO-00023p-V7
 for qemu-devel@nongnu.org; Thu, 23 May 2024 15:06:06 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sADlN-0004GT-8J
 for qemu-devel@nongnu.org; Thu, 23 May 2024 15:06:06 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D14BE22B73;
 Thu, 23 May 2024 19:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716491164; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JHN+EgKe2ZmfVVqlpa/J85xjZ9uaHa7RSXl4aXKQzw0=;
 b=SG0YyFYY7dFSGX9mjIcSrycgRi/QGXIT4kP8VWTx4bekMH3nCFxELK3ijxkMolN7LmdVGW
 83otzAadOodyWSkolFk4orv4SuPlBWkDzmjdt21YTCc2jaxKtsbjSlLcojl/EBJw9D4oWu
 BiGSZzyvDlDTiTCbpFVcE+j8jJ4kStQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716491164;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JHN+EgKe2ZmfVVqlpa/J85xjZ9uaHa7RSXl4aXKQzw0=;
 b=/U36flAp6HWTV1BkmFgFX7Hyoh/vZdp0amFZYFjKoKOu5/wE96Sk95yJvKzeKm2KsJDuic
 NHoIneetTes0RqBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716491163; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JHN+EgKe2ZmfVVqlpa/J85xjZ9uaHa7RSXl4aXKQzw0=;
 b=RQ6HTyDpatvmR7GI6EZREr6OCjNKb8tp0Flj6E7EN7kilVcRlKjNbFE3uzD8xDzn73MJ2O
 kImLrsoijjmM7Jtz81NfIUHKuhuS6lnmg+n+5Wxs+ZwVns/M4zQAQ+pHmq8bvc3amBQH6F
 JaWzl2Wyv5dvaLlPJgiTAY60vSAig7A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716491163;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JHN+EgKe2ZmfVVqlpa/J85xjZ9uaHa7RSXl4aXKQzw0=;
 b=Rex4bWw+3bwFzlgJjReAztETL9VaMoDotDiQxjy4Fz98egWT5SHtU6HGx5frDhgcPw0INs
 EhFHM5X3D7/3uFCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 519C813A6B;
 Thu, 23 May 2024 19:06:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oMuNBpmTT2bUEQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 23 May 2024 19:06:01 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Claudio Fontana <cfontana@suse.de>, Jim Fehlig <jfehlig@suse.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 04/18] monitor: Drop monitor_fdset_dup_fd_add()
Date: Thu, 23 May 2024 16:05:34 -0300
Message-Id: <20240523190548.23977-5-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240523190548.23977-1-farosas@suse.de>
References: <20240523190548.23977-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_SEVEN(0.00)[9];
 RCVD_TLS_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Score: -3.30
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

From: Peter Xu <peterx@redhat.com>

This function is not needed, one remove function should already work.
Clean it up.

Here the code doesn't really care about whether we need to keep that dupfd
around if close() failed: when that happens something got very wrong,
keeping the dup_fd around the fdsets may not help that situation so far.

Cc: Dr. David Alan Gilbert <dave@treblig.org>
Cc: Markus Armbruster <armbru@redhat.com>
Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
[add missing return statement, removal during traversal is not safe]
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 include/monitor/monitor.h |  1 -
 monitor/fds.c             | 28 ++++++----------------------
 stubs/fdset.c             |  5 -----
 util/osdep.c              | 15 +--------------
 4 files changed, 7 insertions(+), 42 deletions(-)

diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
index 965f5d5450..fd9b3f538c 100644
--- a/include/monitor/monitor.h
+++ b/include/monitor/monitor.h
@@ -53,7 +53,6 @@ AddfdInfo *monitor_fdset_add_fd(int fd, bool has_fdset_id, int64_t fdset_id,
                                 const char *opaque, Error **errp);
 int monitor_fdset_dup_fd_add(int64_t fdset_id, int flags);
 void monitor_fdset_dup_fd_remove(int dup_fd);
-int64_t monitor_fdset_dup_fd_find(int dup_fd);
 
 void monitor_register_hmp(const char *name, bool info,
                           void (*cmd)(Monitor *mon, const QDict *qdict));
diff --git a/monitor/fds.c b/monitor/fds.c
index d86c2c674c..fb9f58c056 100644
--- a/monitor/fds.c
+++ b/monitor/fds.c
@@ -458,7 +458,7 @@ int monitor_fdset_dup_fd_add(int64_t fdset_id, int flags)
 #endif
 }
 
-static int64_t monitor_fdset_dup_fd_find_remove(int dup_fd, bool remove)
+void monitor_fdset_dup_fd_remove(int dup_fd)
 {
     MonFdset *mon_fdset;
     MonFdsetFd *mon_fdset_fd_dup;
@@ -467,31 +467,15 @@ static int64_t monitor_fdset_dup_fd_find_remove(int dup_fd, bool remove)
     QLIST_FOREACH(mon_fdset, &mon_fdsets, next) {
         QLIST_FOREACH(mon_fdset_fd_dup, &mon_fdset->dup_fds, next) {
             if (mon_fdset_fd_dup->fd == dup_fd) {
-                if (remove) {
-                    QLIST_REMOVE(mon_fdset_fd_dup, next);
-                    g_free(mon_fdset_fd_dup);
-                    if (QLIST_EMPTY(&mon_fdset->dup_fds)) {
-                        monitor_fdset_cleanup(mon_fdset);
-                    }
-                    return -1;
-                } else {
-                    return mon_fdset->id;
+                QLIST_REMOVE(mon_fdset_fd_dup, next);
+                g_free(mon_fdset_fd_dup);
+                if (QLIST_EMPTY(&mon_fdset->dup_fds)) {
+                    monitor_fdset_cleanup(mon_fdset);
                 }
+                return;
             }
         }
     }
-
-    return -1;
-}
-
-int64_t monitor_fdset_dup_fd_find(int dup_fd)
-{
-    return monitor_fdset_dup_fd_find_remove(dup_fd, false);
-}
-
-void monitor_fdset_dup_fd_remove(int dup_fd)
-{
-    monitor_fdset_dup_fd_find_remove(dup_fd, true);
 }
 
 int monitor_fd_param(Monitor *mon, const char *fdname, Error **errp)
diff --git a/stubs/fdset.c b/stubs/fdset.c
index d7c39a28ac..389e368a29 100644
--- a/stubs/fdset.c
+++ b/stubs/fdset.c
@@ -9,11 +9,6 @@ int monitor_fdset_dup_fd_add(int64_t fdset_id, int flags)
     return -1;
 }
 
-int64_t monitor_fdset_dup_fd_find(int dup_fd)
-{
-    return -1;
-}
-
 void monitor_fdset_dup_fd_remove(int dupfd)
 {
 }
diff --git a/util/osdep.c b/util/osdep.c
index e996c4744a..2d9749d060 100644
--- a/util/osdep.c
+++ b/util/osdep.c
@@ -393,21 +393,8 @@ int qemu_open_old(const char *name, int flags, ...)
 
 int qemu_close(int fd)
 {
-    int64_t fdset_id;
-
     /* Close fd that was dup'd from an fdset */
-    fdset_id = monitor_fdset_dup_fd_find(fd);
-    if (fdset_id != -1) {
-        int ret;
-
-        ret = close(fd);
-        if (ret == 0) {
-            monitor_fdset_dup_fd_remove(fd);
-        }
-
-        return ret;
-    }
-
+    monitor_fdset_dup_fd_remove(fd);
     return close(fd);
 }
 
-- 
2.35.3


