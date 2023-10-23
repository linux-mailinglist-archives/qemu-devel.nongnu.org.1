Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EB3E7D4116
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 22:40:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qv1gN-0004ie-M4; Mon, 23 Oct 2023 16:37:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qv1fx-0003pU-4j
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 16:37:27 -0400
Received: from smtp-out1.suse.de ([195.135.220.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qv1fu-0001uS-AX
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 16:37:23 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8CF5121B0E;
 Mon, 23 Oct 2023 20:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1698093440; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TvFX52MvFl8uE+na5ThDGfRCvVD8CmpSVUukn+S2dHg=;
 b=2GL0D2nfhhR4UjIKmI/FMj7I/2aRQYP1miSwkJb7wpet3nnBc7r1CgH3kpdwZ+Vqi+9Hk6
 fGgniuHYt3mEnUx06I/+BrBg5A8Fuu3cwQyhagl08bQPNbOxfOTXAK1z7IVIP8/qUBWyla
 FTeriPHK8kNWxtrgxRn+A/L3qe475+E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1698093440;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TvFX52MvFl8uE+na5ThDGfRCvVD8CmpSVUukn+S2dHg=;
 b=6NlwyTIEvTTPfSiLg4sivI7+uAhCQaGMV6EQbU5QRC1eRYRzoTllFfRzEjcMs2TycQO79V
 MFkqXOFIJJ01vrCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 97FE4132FD;
 Mon, 23 Oct 2023 20:37:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id uMy4F37ZNmV1JQAAMHmgww
 (envelope-from <farosas@suse.de>); Mon, 23 Oct 2023 20:37:18 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Claudio Fontana <cfontana@suse.de>
Subject: [PATCH v2 26/29] migration/multifd: Support incoming fixed-ram stream
 format
Date: Mon, 23 Oct 2023 17:36:05 -0300
Message-Id: <20231023203608.26370-27-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231023203608.26370-1-farosas@suse.de>
References: <20231023203608.26370-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: -2.10
X-Spamd-Result: default: False [-2.10 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_SEVEN(0.00)[7];
 MID_CONTAINS_FROM(1.00)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
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

For the incoming fixed-ram migration we need to read the ramblock
headers, get the pages bitmap and send the host address of each
non-zero page to the multifd channel thread for writing.

To read from the migration file we need a preadv function that can
read into the iovs in segments of contiguous pages because (as in the
writing case) the file offset applies to the entire iovec.

Usage on HMP is:

(qemu) migrate_set_capability multifd on
(qemu) migrate_set_capability fixed-ram on
(qemu) migrate_set_parameter max-bandwidth 0
(qemu) migrate_set_parameter multifd-channels 8
(qemu) migrate_incoming file:migfile
(qemu) info status
(qemu) c

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/multifd.c | 13 ++++++++++++-
 migration/ram.c     |  9 +++++++--
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index 3f95a41ee9..3b6053ae5a 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -142,6 +142,7 @@ static void nocomp_recv_cleanup(MultiFDRecvParams *p)
 static int nocomp_recv_pages(MultiFDRecvParams *p, Error **errp)
 {
     uint32_t flags = p->flags & MULTIFD_FLAG_COMPRESSION_MASK;
+    uint64_t read_base = 0;
 
     if (flags != MULTIFD_FLAG_NOCOMP) {
         error_setg(errp, "multifd %u: flags received %x flags expected %x",
@@ -152,7 +153,13 @@ static int nocomp_recv_pages(MultiFDRecvParams *p, Error **errp)
         p->iov[i].iov_base = p->host + p->normal[i];
         p->iov[i].iov_len = p->page_size;
     }
-    return qio_channel_readv_all(p->c, p->iov, p->normal_num, errp);
+
+    if (migrate_fixed_ram()) {
+        read_base = p->pages->block->pages_offset - (uint64_t) p->host;
+    }
+
+    return qio_channel_read_full_all(p->c, p->iov, p->normal_num, read_base,
+                                     p->read_flags, errp);
 }
 
 static MultiFDMethods multifd_nocomp_ops = {
@@ -1225,6 +1232,7 @@ void multifd_recv_sync_main(void)
     if (!migrate_multifd() || !migrate_multifd_packets()) {
         return;
     }
+
     for (i = 0; i < migrate_multifd_channels(); i++) {
         MultiFDRecvParams *p = &multifd_recv_state->params[i];
 
@@ -1257,6 +1265,7 @@ static void *multifd_recv_thread(void *opaque)
 
     while (true) {
         uint32_t flags;
+        p->normal_num = 0;
 
         if (p->quit) {
             break;
@@ -1378,6 +1387,8 @@ int multifd_load_setup(Error **errp)
             p->packet_len = sizeof(MultiFDPacket_t)
                 + sizeof(uint64_t) * page_count;
             p->packet = g_malloc0(p->packet_len);
+        } else {
+            p->read_flags |= QIO_CHANNEL_READ_FLAG_WITH_OFFSET;
         }
         p->name = g_strdup_printf("multifdrecv_%d", i);
         p->iov = g_new0(struct iovec, page_count);
diff --git a/migration/ram.c b/migration/ram.c
index 5c67e30e55..9a5ee4767b 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3985,8 +3985,13 @@ static void read_ramblock_fixed_ram(QEMUFile *f, RAMBlock *block,
             host = host_from_ram_block_offset(block, offset);
             read_len = MIN(len, TARGET_PAGE_SIZE);
 
-            read = qemu_get_buffer_at(f, host, read_len,
-                                      block->pages_offset + offset);
+            if (migrate_multifd()) {
+                multifd_recv_queue_page(f, block, offset);
+                read = read_len;
+            } else {
+                read = qemu_get_buffer_at(f, host, read_len,
+                                          block->pages_offset + offset);
+            }
             completed += read;
         }
     }
-- 
2.35.3


