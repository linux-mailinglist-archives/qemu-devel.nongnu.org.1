Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D636285CAED
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Feb 2024 23:43:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcYpN-0005RQ-Ar; Tue, 20 Feb 2024 17:43:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rcYpE-0005FZ-6c
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 17:42:56 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rcYpC-0006QF-Er
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 17:42:55 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 373EC1FB53;
 Tue, 20 Feb 2024 22:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708468973; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=teigS40Z9XH923OGo7nijlRjRuL+JJjtabkdVm33NUY=;
 b=lioPgZc2SveRk9lJJQs/PtMN88/CCwcQdhgZnQwsOqLaiCwZZlufaJ4j1+Bu0XnFmMMgez
 IELq/YtI5DoIYpBRJKD58qvfTxMCBQEDlqlVSG25DR90vvIKF2Q8A4dlT6YZFPrbGgX47Q
 zD+BZ6OMMeZkdECYpv+kT+TKLmeYbmI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708468973;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=teigS40Z9XH923OGo7nijlRjRuL+JJjtabkdVm33NUY=;
 b=f3RQxj+6waEXUXldKCMWYf9erv+zuT+MH/74b8essjunEb36CS31uXfRrrvGh9rE+JFTeK
 uAFjngFm7lD7AyDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708468973; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=teigS40Z9XH923OGo7nijlRjRuL+JJjtabkdVm33NUY=;
 b=lioPgZc2SveRk9lJJQs/PtMN88/CCwcQdhgZnQwsOqLaiCwZZlufaJ4j1+Bu0XnFmMMgez
 IELq/YtI5DoIYpBRJKD58qvfTxMCBQEDlqlVSG25DR90vvIKF2Q8A4dlT6YZFPrbGgX47Q
 zD+BZ6OMMeZkdECYpv+kT+TKLmeYbmI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708468973;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=teigS40Z9XH923OGo7nijlRjRuL+JJjtabkdVm33NUY=;
 b=f3RQxj+6waEXUXldKCMWYf9erv+zuT+MH/74b8essjunEb36CS31uXfRrrvGh9rE+JFTeK
 uAFjngFm7lD7AyDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8B0D1139D0;
 Tue, 20 Feb 2024 22:42:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MNqGFOsq1WUlKwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 20 Feb 2024 22:42:51 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Claudio Fontana <cfontana@suse.de>
Subject: [PATCH v4 31/34] monitor: Extract fdset fd flags comparison into a
 function
Date: Tue, 20 Feb 2024 19:41:35 -0300
Message-Id: <20240220224138.24759-32-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240220224138.24759-1-farosas@suse.de>
References: <20240220224138.24759-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: 3.70
X-Spamd-Result: default: False [3.70 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; RCPT_COUNT_FIVE(0.00)[5];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.00)[41.00%]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

We're about to add one more condition to the flags comparison that
requires an ifdef. Move the code into a separate function now to make
it cleaner after the next patch.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 monitor/fds.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/monitor/fds.c b/monitor/fds.c
index 4ec3b7eea9..9a28e4b72b 100644
--- a/monitor/fds.c
+++ b/monitor/fds.c
@@ -406,6 +406,19 @@ AddfdInfo *monitor_fdset_add_fd(int fd, bool has_fdset_id, int64_t fdset_id,
     return fdinfo;
 }
 
+#ifndef _WIN32
+static bool monitor_fdset_flags_match(int flags, int fd_flags)
+{
+    bool match = false;
+
+    if ((flags & O_ACCMODE) == (fd_flags & O_ACCMODE)) {
+        match = true;
+    }
+
+    return match;
+}
+#endif
+
 int monitor_fdset_dup_fd_add(int64_t fdset_id, int flags)
 {
 #ifdef _WIN32
@@ -431,7 +444,7 @@ int monitor_fdset_dup_fd_add(int64_t fdset_id, int flags)
                 return -1;
             }
 
-            if ((flags & O_ACCMODE) == (mon_fd_flags & O_ACCMODE)) {
+            if (monitor_fdset_flags_match(flags, mon_fd_flags)) {
                 fd = mon_fdset_fd->fd;
                 break;
             }
-- 
2.35.3


