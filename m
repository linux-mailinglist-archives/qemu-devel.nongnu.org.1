Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E9049911458
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jun 2024 23:22:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKPDj-0000s2-2S; Thu, 20 Jun 2024 17:21:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sKPDf-0000r8-Et
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 17:21:24 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sKPDc-0007FK-EC
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 17:21:22 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A562A1F8B5;
 Thu, 20 Jun 2024 21:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718918476; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xGBOlwSV+lcB+dUpCAZJoCxv+H6GGTT7Mw7AvJjicx0=;
 b=RKehQw2HogyjeziGa2jjoFOcM/we3MruJMAlHRMI6bP9UlauUx14rObprRD0RPcRW7mXgP
 jnqKtzSCsGdy6Vepq7Dja4k/RkmxItyTB7dFZMTOxeChzUou6SzoPOr87s8Ol+qMaN/JFm
 tvkwdH1gFUu5D2fDLkre2CfKGIBAZvI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718918476;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xGBOlwSV+lcB+dUpCAZJoCxv+H6GGTT7Mw7AvJjicx0=;
 b=igC6MGfO1W4En/8DSMW7CXkGIY5Xde4JO/I7qDkbVa+uz7+7amy9yW1CMOSyztuvPurDDL
 f6rJKUkDvZpI2hAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718918476; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xGBOlwSV+lcB+dUpCAZJoCxv+H6GGTT7Mw7AvJjicx0=;
 b=RKehQw2HogyjeziGa2jjoFOcM/we3MruJMAlHRMI6bP9UlauUx14rObprRD0RPcRW7mXgP
 jnqKtzSCsGdy6Vepq7Dja4k/RkmxItyTB7dFZMTOxeChzUou6SzoPOr87s8Ol+qMaN/JFm
 tvkwdH1gFUu5D2fDLkre2CfKGIBAZvI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718918476;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xGBOlwSV+lcB+dUpCAZJoCxv+H6GGTT7Mw7AvJjicx0=;
 b=igC6MGfO1W4En/8DSMW7CXkGIY5Xde4JO/I7qDkbVa+uz7+7amy9yW1CMOSyztuvPurDDL
 f6rJKUkDvZpI2hAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 728F613ACA;
 Thu, 20 Jun 2024 21:21:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0IZ8DkuddGabYAAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 20 Jun 2024 21:21:15 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
Subject: [RFC PATCH 1/7] migration/multifd: Reduce access to p->pages
Date: Thu, 20 Jun 2024 18:21:05 -0300
Message-Id: <20240620212111.29319-2-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240620212111.29319-1-farosas@suse.de>
References: <20240620212111.29319-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.998];
 MIME_GOOD(-0.10)[text/plain]; FUZZY_BLOCKED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Score: -2.80
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

I'm about to replace the p->pages pointer with an opaque pointer, so
do a cleanup now to reduce direct accesses to p->page, which makes the
next diffs cleaner.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/multifd-qpl.c  |  8 +++++---
 migration/multifd-uadk.c |  9 +++++----
 migration/multifd-zlib.c |  2 +-
 migration/multifd-zstd.c |  2 +-
 migration/multifd.c      | 13 +++++++------
 5 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/migration/multifd-qpl.c b/migration/multifd-qpl.c
index 9265098ee7..f8c84c52cf 100644
--- a/migration/multifd-qpl.c
+++ b/migration/multifd-qpl.c
@@ -404,13 +404,14 @@ retry:
 static void multifd_qpl_compress_pages_slow_path(MultiFDSendParams *p)
 {
     QplData *qpl = p->compress_data;
+    MultiFDPages_t *pages = p->pages;
     uint32_t size = p->page_size;
     qpl_job *job = qpl->sw_job;
     uint8_t *zbuf = qpl->zbuf;
     uint8_t *buf;
 
-    for (int i = 0; i < p->pages->normal_num; i++) {
-        buf = p->pages->block->host + p->pages->offset[i];
+    for (int i = 0; i < pages->normal_num; i++) {
+        buf = pages->block->host + pages->offset[i];
         multifd_qpl_prepare_comp_job(job, buf, zbuf, size);
         if (qpl_execute_job(job) == QPL_STS_OK) {
             multifd_qpl_fill_packet(i, p, zbuf, job->total_out);
@@ -498,6 +499,7 @@ static void multifd_qpl_compress_pages(MultiFDSendParams *p)
 static int multifd_qpl_send_prepare(MultiFDSendParams *p, Error **errp)
 {
     QplData *qpl = p->compress_data;
+    MultiFDPages_t *pages = p->pages;
     uint32_t len = 0;
 
     if (!multifd_send_prepare_common(p)) {
@@ -505,7 +507,7 @@ static int multifd_qpl_send_prepare(MultiFDSendParams *p, Error **errp)
     }
 
     /* The first IOV is used to store the compressed page lengths */
-    len = p->pages->normal_num * sizeof(uint32_t);
+    len = pages->normal_num * sizeof(uint32_t);
     multifd_qpl_fill_iov(p, (uint8_t *) qpl->zlen, len);
     if (qpl->hw_avail) {
         multifd_qpl_compress_pages(p);
diff --git a/migration/multifd-uadk.c b/migration/multifd-uadk.c
index d12353fb21..b8ba3cd9c1 100644
--- a/migration/multifd-uadk.c
+++ b/migration/multifd-uadk.c
@@ -174,19 +174,20 @@ static int multifd_uadk_send_prepare(MultiFDSendParams *p, Error **errp)
     uint32_t hdr_size;
     uint8_t *buf = uadk_data->buf;
     int ret = 0;
+    MultiFDPages_t *pages = p->pages;
 
     if (!multifd_send_prepare_common(p)) {
         goto out;
     }
 
-    hdr_size = p->pages->normal_num * sizeof(uint32_t);
+    hdr_size = pages->normal_num * sizeof(uint32_t);
     /* prepare the header that stores the lengths of all compressed data */
     prepare_next_iov(p, uadk_data->buf_hdr, hdr_size);
 
-    for (int i = 0; i < p->pages->normal_num; i++) {
+    for (int i = 0; i < pages->normal_num; i++) {
         struct wd_comp_req creq = {
             .op_type = WD_DIR_COMPRESS,
-            .src     = p->pages->block->host + p->pages->offset[i],
+            .src     = pages->block->host + pages->offset[i],
             .src_len = p->page_size,
             .dst     = buf,
             /* Set dst_len to double the src in case compressed out >= page_size */
@@ -214,7 +215,7 @@ static int multifd_uadk_send_prepare(MultiFDSendParams *p, Error **errp)
          */
         if (!uadk_data->handle || creq.dst_len >= p->page_size) {
             uadk_data->buf_hdr[i] = cpu_to_be32(p->page_size);
-            prepare_next_iov(p, p->pages->block->host + p->pages->offset[i],
+            prepare_next_iov(p, pages->block->host + pages->offset[i],
                              p->page_size);
             buf += p->page_size;
         }
diff --git a/migration/multifd-zlib.c b/migration/multifd-zlib.c
index 2ced69487e..65f8aba5c8 100644
--- a/migration/multifd-zlib.c
+++ b/migration/multifd-zlib.c
@@ -147,7 +147,7 @@ static int zlib_send_prepare(MultiFDSendParams *p, Error **errp)
          * with compression. zlib does not guarantee that this is safe,
          * therefore copy the page before calling deflate().
          */
-        memcpy(z->buf, p->pages->block->host + pages->offset[i], p->page_size);
+        memcpy(z->buf, pages->block->host + pages->offset[i], p->page_size);
         zs->avail_in = p->page_size;
         zs->next_in = z->buf;
 
diff --git a/migration/multifd-zstd.c b/migration/multifd-zstd.c
index ca17b7e310..cb6075a9a5 100644
--- a/migration/multifd-zstd.c
+++ b/migration/multifd-zstd.c
@@ -138,7 +138,7 @@ static int zstd_send_prepare(MultiFDSendParams *p, Error **errp)
         if (i == pages->normal_num - 1) {
             flush = ZSTD_e_flush;
         }
-        z->in.src = p->pages->block->host + pages->offset[i];
+        z->in.src = pages->block->host + pages->offset[i];
         z->in.size = p->page_size;
         z->in.pos = 0;
 
diff --git a/migration/multifd.c b/migration/multifd.c
index d82885fdbb..506f42e124 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -114,11 +114,11 @@ static void multifd_set_file_bitmap(MultiFDSendParams *p)
 
     assert(pages->block);
 
-    for (int i = 0; i < p->pages->normal_num; i++) {
+    for (int i = 0; i < pages->normal_num; i++) {
         ramblock_set_file_bmap_atomic(pages->block, pages->offset[i], true);
     }
 
-    for (int i = p->pages->normal_num; i < p->pages->num; i++) {
+    for (int i = pages->normal_num; i < pages->num; i++) {
         ramblock_set_file_bmap_atomic(pages->block, pages->offset[i], false);
     }
 }
@@ -417,7 +417,7 @@ void multifd_send_fill_packet(MultiFDSendParams *p)
     int i;
 
     packet->flags = cpu_to_be32(p->flags);
-    packet->pages_alloc = cpu_to_be32(p->pages->allocated);
+    packet->pages_alloc = cpu_to_be32(pages->allocated);
     packet->normal_pages = cpu_to_be32(pages->normal_num);
     packet->zero_pages = cpu_to_be32(zero_num);
     packet->next_packet_size = cpu_to_be32(p->next_packet_size);
@@ -953,7 +953,7 @@ static void *multifd_send_thread(void *opaque)
 
             if (migrate_mapped_ram()) {
                 ret = file_write_ramblock_iov(p->c, p->iov, p->iovs_num,
-                                              p->pages->block, &local_err);
+                                              pages->block, &local_err);
             } else {
                 ret = qio_channel_writev_full_all(p->c, p->iov, p->iovs_num,
                                                   NULL, 0, p->write_flags,
@@ -969,7 +969,7 @@ static void *multifd_send_thread(void *opaque)
             stat64_add(&mig_stats.normal_pages, pages->normal_num);
             stat64_add(&mig_stats.zero_pages, pages->num - pages->normal_num);
 
-            multifd_pages_reset(p->pages);
+            multifd_pages_reset(pages);
             p->next_packet_size = 0;
 
             /*
@@ -1684,9 +1684,10 @@ void multifd_recv_new_channel(QIOChannel *ioc, Error **errp)
 
 bool multifd_send_prepare_common(MultiFDSendParams *p)
 {
+    MultiFDPages_t *pages = p->pages;
     multifd_send_zero_page_detect(p);
 
-    if (!p->pages->normal_num) {
+    if (!pages->normal_num) {
         p->next_packet_size = 0;
         return false;
     }
-- 
2.35.3


