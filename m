Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F3F996BCDF
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Sep 2024 14:48:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slpNW-0004lF-U6; Wed, 04 Sep 2024 08:44:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1slpNS-0004X1-GF
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 08:44:52 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1slpNQ-0005YH-UX
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 08:44:50 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7F37A2119F;
 Wed,  4 Sep 2024 12:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1725453887; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NlMmLQqIoc99biOand2+mbxP6OE6deuFa9cOXS8yzLU=;
 b=BChTr/bfqDsjQ2KvK5/paAfb7xX++sh2ZPLapQTgu7b4mUmxdR7jq3KOFpnZp5roU1xMnW
 ghnK8yl4n2naPOZmv3cAguTQIpsYHa9mKb+13/pyfrZCm1JMiqL8o0QmVwTOOQBmYXCw+J
 O0BtoldNmHHEDX6wsiBS78HwuErdB5Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1725453887;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NlMmLQqIoc99biOand2+mbxP6OE6deuFa9cOXS8yzLU=;
 b=ncbl+zSke2QAy8QqVoQDbX9crbSHqIOsHaE1Gop8Mstul6bXdxJ/RD2Kfqaunub8qNk9dp
 mJh4yKo73IeVNaCw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="BChTr/bf";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ncbl+zSk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1725453887; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NlMmLQqIoc99biOand2+mbxP6OE6deuFa9cOXS8yzLU=;
 b=BChTr/bfqDsjQ2KvK5/paAfb7xX++sh2ZPLapQTgu7b4mUmxdR7jq3KOFpnZp5roU1xMnW
 ghnK8yl4n2naPOZmv3cAguTQIpsYHa9mKb+13/pyfrZCm1JMiqL8o0QmVwTOOQBmYXCw+J
 O0BtoldNmHHEDX6wsiBS78HwuErdB5Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1725453887;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NlMmLQqIoc99biOand2+mbxP6OE6deuFa9cOXS8yzLU=;
 b=ncbl+zSke2QAy8QqVoQDbX9crbSHqIOsHaE1Gop8Mstul6bXdxJ/RD2Kfqaunub8qNk9dp
 mJh4yKo73IeVNaCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 56DCE139D2;
 Wed,  4 Sep 2024 12:44:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sGezBz5W2GZuVQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 04 Sep 2024 12:44:46 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 15/34] migration/multifd: Pass in MultiFDPages_t to
 file_write_ramblock_iov
Date: Wed,  4 Sep 2024 09:43:58 -0300
Message-Id: <20240904124417.14565-16-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240904124417.14565-1-farosas@suse.de>
References: <20240904124417.14565-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7F37A2119F
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 RCPT_COUNT_THREE(0.00)[3]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

We want to stop dereferencing 'pages' so it can be replaced by an
opaque pointer in the next patches.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/file.c    | 3 ++-
 migration/file.h    | 2 +-
 migration/multifd.c | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/migration/file.c b/migration/file.c
index 6451a21c86..7f11e26f5c 100644
--- a/migration/file.c
+++ b/migration/file.c
@@ -196,12 +196,13 @@ void file_start_incoming_migration(FileMigrationArgs *file_args, Error **errp)
 }
 
 int file_write_ramblock_iov(QIOChannel *ioc, const struct iovec *iov,
-                            int niov, RAMBlock *block, Error **errp)
+                            int niov, MultiFDPages_t *pages, Error **errp)
 {
     ssize_t ret = 0;
     int i, slice_idx, slice_num;
     uintptr_t base, next, offset;
     size_t len;
+    RAMBlock *block = pages->block;
 
     slice_idx = 0;
     slice_num = 1;
diff --git a/migration/file.h b/migration/file.h
index 9f71e87f74..1a1115f7f1 100644
--- a/migration/file.h
+++ b/migration/file.h
@@ -21,6 +21,6 @@ int file_parse_offset(char *filespec, uint64_t *offsetp, Error **errp);
 void file_cleanup_outgoing_migration(void);
 bool file_send_channel_create(gpointer opaque, Error **errp);
 int file_write_ramblock_iov(QIOChannel *ioc, const struct iovec *iov,
-                            int niov, RAMBlock *block, Error **errp);
+                            int niov, MultiFDPages_t *pages, Error **errp);
 int multifd_file_recv_data(MultiFDRecvParams *p, Error **errp);
 #endif
diff --git a/migration/multifd.c b/migration/multifd.c
index 30e5c687d3..640e4450ff 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -956,7 +956,7 @@ static void *multifd_send_thread(void *opaque)
 
             if (migrate_mapped_ram()) {
                 ret = file_write_ramblock_iov(p->c, p->iov, p->iovs_num,
-                                              pages->block, &local_err);
+                                              pages, &local_err);
             } else {
                 ret = qio_channel_writev_full_all(p->c, p->iov, p->iovs_num,
                                                   NULL, 0, p->write_flags,
-- 
2.35.3


