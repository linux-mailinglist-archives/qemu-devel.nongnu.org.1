Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AB94C86B30B
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Feb 2024 16:24:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfLkk-0006Xa-IT; Wed, 28 Feb 2024 10:21:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rfLkj-0006X5-Ed
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 10:21:49 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rfLke-0004vp-QF
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 10:21:49 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4AC661F79A;
 Wed, 28 Feb 2024 15:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709133703; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yei0QUkdknw0DkZwKKRyp+HpBHZX5C0CfiFOhKXCH40=;
 b=rJDJQesUMca6NWzHoml4wMxJ/eklkUKBzUVHZHVzvqprkxm/UGbRFiEgb4Q36asScgGNoP
 tTbmqJ5wfZ23nl7wzv/QmbFpNSmldH72xBSGkko1GGwSWS1peEAUd+BzoknVcYScKFsZD6
 3DqliJ215+4orb8ZKMOUkCsNdeNkpYs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709133703;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yei0QUkdknw0DkZwKKRyp+HpBHZX5C0CfiFOhKXCH40=;
 b=YDYxikAbMgTkryqW6JO38laq1lXeHdQ3jFOB1rwi00OjrKMAJjpcFhbgVp1ZIaVrejt3fN
 PYHP1sHu14L76+BQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709133703; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yei0QUkdknw0DkZwKKRyp+HpBHZX5C0CfiFOhKXCH40=;
 b=rJDJQesUMca6NWzHoml4wMxJ/eklkUKBzUVHZHVzvqprkxm/UGbRFiEgb4Q36asScgGNoP
 tTbmqJ5wfZ23nl7wzv/QmbFpNSmldH72xBSGkko1GGwSWS1peEAUd+BzoknVcYScKFsZD6
 3DqliJ215+4orb8ZKMOUkCsNdeNkpYs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709133703;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yei0QUkdknw0DkZwKKRyp+HpBHZX5C0CfiFOhKXCH40=;
 b=YDYxikAbMgTkryqW6JO38laq1lXeHdQ3jFOB1rwi00OjrKMAJjpcFhbgVp1ZIaVrejt3fN
 PYHP1sHu14L76+BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AC94513A5D;
 Wed, 28 Feb 2024 15:21:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kNp9HIVP32UPAwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 28 Feb 2024 15:21:41 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Claudio Fontana <cfontana@suse.de>
Subject: [PATCH v5 05/23] io: fsync before closing a file channel
Date: Wed, 28 Feb 2024 12:21:09 -0300
Message-Id: <20240228152127.18769-6-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240228152127.18769-1-farosas@suse.de>
References: <20240228152127.18769-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=rJDJQesU;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=YDYxikAb
X-Spamd-Result: default: False [-1.52 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-2.21)[96.23%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 4AC661F79A
X-Spam-Score: -1.52
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

Make sure the data is flushed to disk before closing file
channels. This is to ensure data is on disk and not lost in the event
of a host crash.

This is currently being implemented to affect the migration code when
migrating to a file, but all QIOChannelFile users should benefit from
the change.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Acked-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 io/channel-file.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/io/channel-file.c b/io/channel-file.c
index a6ad7770c6..d4706fa592 100644
--- a/io/channel-file.c
+++ b/io/channel-file.c
@@ -242,6 +242,11 @@ static int qio_channel_file_close(QIOChannel *ioc,
 {
     QIOChannelFile *fioc = QIO_CHANNEL_FILE(ioc);
 
+    if (qemu_fdatasync(fioc->fd) < 0) {
+        error_setg_errno(errp, errno,
+                         "Unable to synchronize file data with storage device");
+        return -1;
+    }
     if (qemu_close(fioc->fd) < 0) {
         error_setg_errno(errp, errno,
                          "Unable to close file");
-- 
2.35.3


