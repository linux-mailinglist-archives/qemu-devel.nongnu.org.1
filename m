Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F7F37C700D
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 16:08:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqwLk-0000Ky-T4; Thu, 12 Oct 2023 10:07:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qqwLA-0008LO-VK
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 10:07:06 -0400
Received: from smtp-out1.suse.de ([195.135.220.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qqwL6-0008EK-E8
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 10:07:03 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E304C21860;
 Thu, 12 Oct 2023 14:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1697119618; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=82J1vnQaM/EdCBU+c/qhxC6JWBgn08RqMNZW4Q/6FH4=;
 b=vkQWg1Lc9zSkCgqUlwka+WknzITqPB1/ehXDUC17b+0vDHp77i6wBtl8vbmUV7sFkUAOKo
 nVqZ52Y3kjCDMz4u2o3/5EMupGuGLkLmxsmWsM6ktoTV7qSeBxOWqruN13ZznNysA4LR28
 BE7Sd4+sCQ3MVJxEbGk5Q8L7+tuMig0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1697119618;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=82J1vnQaM/EdCBU+c/qhxC6JWBgn08RqMNZW4Q/6FH4=;
 b=93okaGq17N+H2WdiRrc1ENp484TQPsk7n/mbvu+KWYXnzoJjwfjxN++em1HLe0DgGTin4R
 6PWLex5wQB6CmbBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6A46E139ED;
 Thu, 12 Oct 2023 14:06:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 8EqZDYH9J2U5CgAAMHmgww
 (envelope-from <farosas@suse.de>); Thu, 12 Oct 2023 14:06:57 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>
Subject: [RFC PATCH v2 2/6] migration/multifd: Stop checking p->quit in
 multifd_send_thread
Date: Thu, 12 Oct 2023 11:06:47 -0300
Message-Id: <20231012140651.13122-3-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231012140651.13122-1-farosas@suse.de>
References: <20231012140651.13122-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: 0.88
X-Spamd-Result: default: False [0.88 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; RCPT_COUNT_FIVE(0.00)[5];
 NEURAL_HAM_LONG(-3.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.02)[51.65%]
Received-SPF: pass client-ip=195.135.220.28; envelope-from=farosas@suse.de;
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

We don't need to check p->quit in the multifd_send_thread() because it
is shadowed by the 'exiting' flag. Ever since that flag was added
p->quit became obsolete as a way to stop the thread.

Since p->quit is set at multifd_send_terminate_threads() under the
p->mutex lock, the thread will only see it once it loops, so 'exiting'
will always be seen first.

Note that setting p->quit at multifd_send_terminate_threads() still
makes sense because we need a way to inform multifd_send_pages() that
the channel has stopped.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/multifd.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index e26f5f246d..92ae61a50f 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -731,9 +731,6 @@ static void *multifd_send_thread(void *opaque)
             if (flags & MULTIFD_FLAG_SYNC) {
                 qemu_sem_post(&p->sem_sync);
             }
-        } else if (p->quit) {
-            qemu_mutex_unlock(&p->mutex);
-            break;
         } else {
             qemu_mutex_unlock(&p->mutex);
             /* sometimes there are spurious wakeups */
-- 
2.35.3


