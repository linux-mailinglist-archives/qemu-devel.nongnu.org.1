Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 202257FAB77
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 21:28:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7iCA-0002lY-2y; Mon, 27 Nov 2023 15:27:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1r7iC8-0002jb-0o
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 15:27:04 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1r7iC6-0002of-CM
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 15:27:03 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 048D71FB71;
 Mon, 27 Nov 2023 20:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1701116821; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rzjmm5ywc7HVTleLe9Pn0I3d48q28auF6LLuQc7e3mU=;
 b=x2Wxz7+X41UVDBe+O5Ch6qar9SE1e7FYCnqJGNXcxPdoUr4hP0iNej7MOXToGdsk0sIe7s
 LFkQ60ucZSQ9CAyXDZ5C9lhTH2BKVscU0jjFGfATBGyMVFH+1EskGHR+A61US1hilolZzA
 YSr1S61g6p2TslCTnPR/YYrwh4BQvL4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1701116821;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rzjmm5ywc7HVTleLe9Pn0I3d48q28auF6LLuQc7e3mU=;
 b=zGxge5kl4HpKZx7jSt1dCPDG5hxT8QCEmV1GGD1x/KP8k2ims0sinm3IVWtcK4QCs3MCQu
 93vRMEyxslRPS9DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E32201379A;
 Mon, 27 Nov 2023 20:26:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MFLvKZL7ZGVfIQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 27 Nov 2023 20:26:58 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Claudio Fontana <cfontana@suse.de>
Subject: [RFC PATCH v3 16/30] multifd: Rename MultiFDSendParams::data to
 compress_data
Date: Mon, 27 Nov 2023 17:25:58 -0300
Message-Id: <20231127202612.23012-17-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231127202612.23012-1-farosas@suse.de>
References: <20231127202612.23012-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: 0.90
X-Spamd-Result: default: False [0.90 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_SEVEN(0.00)[7]; MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
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

Use a more specific name for the compression data so we can use the
generic for the multifd core code.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/multifd-zlib.c | 20 ++++++++++----------
 migration/multifd-zstd.c | 20 ++++++++++----------
 migration/multifd.h      |  4 ++--
 3 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/migration/multifd-zlib.c b/migration/multifd-zlib.c
index 37ce48621e..fd94e79dd9 100644
--- a/migration/multifd-zlib.c
+++ b/migration/multifd-zlib.c
@@ -69,7 +69,7 @@ static int zlib_send_setup(MultiFDSendParams *p, Error **errp)
         err_msg = "out of memory for buf";
         goto err_free_zbuff;
     }
-    p->data = z;
+    p->compress_data = z;
     return 0;
 
 err_free_zbuff:
@@ -92,15 +92,15 @@ err_free_z:
  */
 static void zlib_send_cleanup(MultiFDSendParams *p, Error **errp)
 {
-    struct zlib_data *z = p->data;
+    struct zlib_data *z = p->compress_data;
 
     deflateEnd(&z->zs);
     g_free(z->zbuff);
     z->zbuff = NULL;
     g_free(z->buf);
     z->buf = NULL;
-    g_free(p->data);
-    p->data = NULL;
+    g_free(p->compress_data);
+    p->compress_data = NULL;
 }
 
 /**
@@ -116,7 +116,7 @@ static void zlib_send_cleanup(MultiFDSendParams *p, Error **errp)
  */
 static int zlib_send_prepare(MultiFDSendParams *p, Error **errp)
 {
-    struct zlib_data *z = p->data;
+    struct zlib_data *z = p->compress_data;
     z_stream *zs = &z->zs;
     uint32_t out_size = 0;
     int ret;
@@ -189,7 +189,7 @@ static int zlib_recv_setup(MultiFDRecvParams *p, Error **errp)
     struct zlib_data *z = g_new0(struct zlib_data, 1);
     z_stream *zs = &z->zs;
 
-    p->data = z;
+    p->compress_data = z;
     zs->zalloc = Z_NULL;
     zs->zfree = Z_NULL;
     zs->opaque = Z_NULL;
@@ -219,13 +219,13 @@ static int zlib_recv_setup(MultiFDRecvParams *p, Error **errp)
  */
 static void zlib_recv_cleanup(MultiFDRecvParams *p)
 {
-    struct zlib_data *z = p->data;
+    struct zlib_data *z = p->compress_data;
 
     inflateEnd(&z->zs);
     g_free(z->zbuff);
     z->zbuff = NULL;
-    g_free(p->data);
-    p->data = NULL;
+    g_free(p->compress_data);
+    p->compress_data = NULL;
 }
 
 /**
@@ -241,7 +241,7 @@ static void zlib_recv_cleanup(MultiFDRecvParams *p)
  */
 static int zlib_recv_pages(MultiFDRecvParams *p, Error **errp)
 {
-    struct zlib_data *z = p->data;
+    struct zlib_data *z = p->compress_data;
     z_stream *zs = &z->zs;
     uint32_t in_size = p->next_packet_size;
     /* we measure the change of total_out */
diff --git a/migration/multifd-zstd.c b/migration/multifd-zstd.c
index b471daadcd..238eebbf4b 100644
--- a/migration/multifd-zstd.c
+++ b/migration/multifd-zstd.c
@@ -52,7 +52,7 @@ static int zstd_send_setup(MultiFDSendParams *p, Error **errp)
     struct zstd_data *z = g_new0(struct zstd_data, 1);
     int res;
 
-    p->data = z;
+    p->compress_data = z;
     z->zcs = ZSTD_createCStream();
     if (!z->zcs) {
         g_free(z);
@@ -90,14 +90,14 @@ static int zstd_send_setup(MultiFDSendParams *p, Error **errp)
  */
 static void zstd_send_cleanup(MultiFDSendParams *p, Error **errp)
 {
-    struct zstd_data *z = p->data;
+    struct zstd_data *z = p->compress_data;
 
     ZSTD_freeCStream(z->zcs);
     z->zcs = NULL;
     g_free(z->zbuff);
     z->zbuff = NULL;
-    g_free(p->data);
-    p->data = NULL;
+    g_free(p->compress_data);
+    p->compress_data = NULL;
 }
 
 /**
@@ -113,7 +113,7 @@ static void zstd_send_cleanup(MultiFDSendParams *p, Error **errp)
  */
 static int zstd_send_prepare(MultiFDSendParams *p, Error **errp)
 {
-    struct zstd_data *z = p->data;
+    struct zstd_data *z = p->compress_data;
     int ret;
     uint32_t i;
 
@@ -178,7 +178,7 @@ static int zstd_recv_setup(MultiFDRecvParams *p, Error **errp)
     struct zstd_data *z = g_new0(struct zstd_data, 1);
     int ret;
 
-    p->data = z;
+    p->compress_data = z;
     z->zds = ZSTD_createDStream();
     if (!z->zds) {
         g_free(z);
@@ -216,14 +216,14 @@ static int zstd_recv_setup(MultiFDRecvParams *p, Error **errp)
  */
 static void zstd_recv_cleanup(MultiFDRecvParams *p)
 {
-    struct zstd_data *z = p->data;
+    struct zstd_data *z = p->compress_data;
 
     ZSTD_freeDStream(z->zds);
     z->zds = NULL;
     g_free(z->zbuff);
     z->zbuff = NULL;
-    g_free(p->data);
-    p->data = NULL;
+    g_free(p->compress_data);
+    p->compress_data = NULL;
 }
 
 /**
@@ -243,7 +243,7 @@ static int zstd_recv_pages(MultiFDRecvParams *p, Error **errp)
     uint32_t out_size = 0;
     uint32_t expected_size = p->normal_num * p->page_size;
     uint32_t flags = p->flags & MULTIFD_FLAG_COMPRESSION_MASK;
-    struct zstd_data *z = p->data;
+    struct zstd_data *z = p->compress_data;
     int ret;
     int i;
 
diff --git a/migration/multifd.h b/migration/multifd.h
index a112ec7ac6..744b52762f 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -132,7 +132,7 @@ typedef struct {
     /* num of non zero pages */
     uint32_t normal_num;
     /* used for compression methods */
-    void *data;
+    void *compress_data;
 }  MultiFDSendParams;
 
 typedef struct {
@@ -189,7 +189,7 @@ typedef struct {
     /* num of non zero pages */
     uint32_t normal_num;
     /* used for de-compression methods */
-    void *data;
+    void *compress_data;
 } MultiFDRecvParams;
 
 typedef struct {
-- 
2.35.3


