Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B42BB95D48F
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Aug 2024 19:41:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shYGO-0000oQ-FG; Fri, 23 Aug 2024 13:39:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1shYGH-0000SG-Uu
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 13:39:47 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1shYGC-00004z-GW
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 13:39:44 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 081EB20362;
 Fri, 23 Aug 2024 17:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724434778; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LCjCzrduGEUqbZyjamj2hG1MAOxC9/h2OVO/C+74oxs=;
 b=03hW16KJSq44/X2+4S9j0acohoVD09rflAbH0tSgYIRyLaZksPXA+RGn9+nEKyHsynvdfB
 NwJ/GMGi7tD2yjrSyVI35P3iHqxsDZDywmVgBCE/xxIYmLuAP/Sdpp9EDYIIORXDMBS4DN
 oskuiDN8snP6+pCwULjvrJZqIad9TJU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724434778;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LCjCzrduGEUqbZyjamj2hG1MAOxC9/h2OVO/C+74oxs=;
 b=zHFKDLnPtsUJfoV7irf9SaJyxUG2hhU4/Wx39paZYJp4a6/h2JGBeytJltp9yV81AFG7Xk
 B4RhuGXgJTpcfhDw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=03hW16KJ;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=zHFKDLnP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724434778; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LCjCzrduGEUqbZyjamj2hG1MAOxC9/h2OVO/C+74oxs=;
 b=03hW16KJSq44/X2+4S9j0acohoVD09rflAbH0tSgYIRyLaZksPXA+RGn9+nEKyHsynvdfB
 NwJ/GMGi7tD2yjrSyVI35P3iHqxsDZDywmVgBCE/xxIYmLuAP/Sdpp9EDYIIORXDMBS4DN
 oskuiDN8snP6+pCwULjvrJZqIad9TJU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724434778;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LCjCzrduGEUqbZyjamj2hG1MAOxC9/h2OVO/C+74oxs=;
 b=zHFKDLnPtsUJfoV7irf9SaJyxUG2hhU4/Wx39paZYJp4a6/h2JGBeytJltp9yV81AFG7Xk
 B4RhuGXgJTpcfhDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C61981333E;
 Fri, 23 Aug 2024 17:39:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sEKpIljJyGb2LwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 23 Aug 2024 17:39:36 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
Subject: [PATCH v4 14/16] migration/multifd: Standardize on multifd ops names
Date: Fri, 23 Aug 2024 14:39:09 -0300
Message-Id: <20240823173911.6712-15-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240823173911.6712-1-farosas@suse.de>
References: <20240823173911.6712-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 081EB20362
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 ARC_NA(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Add the multifd_ prefix to all functions and remove the useless
docstrings.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/multifd-qpl.c  | 57 ----------------------------
 migration/multifd-uadk.c | 55 ---------------------------
 migration/multifd-zlib.c | 81 ++++++----------------------------------
 migration/multifd-zstd.c | 81 ++++++----------------------------------
 migration/multifd.c      | 78 ++++++--------------------------------
 5 files changed, 36 insertions(+), 316 deletions(-)

diff --git a/migration/multifd-qpl.c b/migration/multifd-qpl.c
index 21153f1987..75041a4c4d 100644
--- a/migration/multifd-qpl.c
+++ b/migration/multifd-qpl.c
@@ -220,16 +220,6 @@ static void multifd_qpl_deinit(QplData *qpl)
     }
 }
 
-/**
- * multifd_qpl_send_setup: set up send side
- *
- * Set up the channel with QPL compression.
- *
- * Returns 0 on success or -1 on error
- *
- * @p: Params for the channel being used
- * @errp: pointer to an error
- */
 static int multifd_qpl_send_setup(MultiFDSendParams *p, Error **errp)
 {
     QplData *qpl;
@@ -251,14 +241,6 @@ static int multifd_qpl_send_setup(MultiFDSendParams *p, Error **errp)
     return 0;
 }
 
-/**
- * multifd_qpl_send_cleanup: clean up send side
- *
- * Close the channel and free memory.
- *
- * @p: Params for the channel being used
- * @errp: pointer to an error
- */
 static void multifd_qpl_send_cleanup(MultiFDSendParams *p, Error **errp)
 {
     multifd_qpl_deinit(p->compress_data);
@@ -487,17 +469,6 @@ static void multifd_qpl_compress_pages(MultiFDSendParams *p)
     }
 }
 
-/**
- * multifd_qpl_send_prepare: prepare data to be able to send
- *
- * Create a compressed buffer with all the pages that we are going to
- * send.
- *
- * Returns 0 on success or -1 on error
- *
- * @p: Params for the channel being used
- * @errp: pointer to an error
- */
 static int multifd_qpl_send_prepare(MultiFDSendParams *p, Error **errp)
 {
     QplData *qpl = p->compress_data;
@@ -523,16 +494,6 @@ out:
     return 0;
 }
 
-/**
- * multifd_qpl_recv_setup: set up receive side
- *
- * Create the compressed channel and buffer.
- *
- * Returns 0 on success or -1 on error
- *
- * @p: Params for the channel being used
- * @errp: pointer to an error
- */
 static int multifd_qpl_recv_setup(MultiFDRecvParams *p, Error **errp)
 {
     QplData *qpl;
@@ -547,13 +508,6 @@ static int multifd_qpl_recv_setup(MultiFDRecvParams *p, Error **errp)
     return 0;
 }
 
-/**
- * multifd_qpl_recv_cleanup: set up receive side
- *
- * Close the channel and free memory.
- *
- * @p: Params for the channel being used
- */
 static void multifd_qpl_recv_cleanup(MultiFDRecvParams *p)
 {
     multifd_qpl_deinit(p->compress_data);
@@ -694,17 +648,6 @@ static int multifd_qpl_decompress_pages(MultiFDRecvParams *p, Error **errp)
     }
     return 0;
 }
-/**
- * multifd_qpl_recv: read the data from the channel into actual pages
- *
- * Read the compressed buffer, and uncompress it into the actual
- * pages.
- *
- * Returns 0 on success or -1 on error
- *
- * @p: Params for the channel being used
- * @errp: pointer to an error
- */
 static int multifd_qpl_recv(MultiFDRecvParams *p, Error **errp)
 {
     QplData *qpl = p->compress_data;
diff --git a/migration/multifd-uadk.c b/migration/multifd-uadk.c
index 9d99807af5..db2549f59b 100644
--- a/migration/multifd-uadk.c
+++ b/migration/multifd-uadk.c
@@ -103,14 +103,6 @@ static void multifd_uadk_uninit_sess(struct wd_data *wd)
     g_free(wd);
 }
 
-/**
- * multifd_uadk_send_setup: setup send side
- *
- * Returns 0 for success or -1 for error
- *
- * @p: Params for the channel that we are using
- * @errp: pointer to an error
- */
 static int multifd_uadk_send_setup(MultiFDSendParams *p, Error **errp)
 {
     struct wd_data *wd;
@@ -134,14 +126,6 @@ static int multifd_uadk_send_setup(MultiFDSendParams *p, Error **errp)
     return 0;
 }
 
-/**
- * multifd_uadk_send_cleanup: cleanup send side
- *
- * Close the channel and return memory.
- *
- * @p: Params for the channel that we are using
- * @errp: pointer to an error
- */
 static void multifd_uadk_send_cleanup(MultiFDSendParams *p, Error **errp)
 {
     struct wd_data *wd = p->compress_data;
@@ -159,17 +143,6 @@ static inline void prepare_next_iov(MultiFDSendParams *p, void *base,
     p->iovs_num++;
 }
 
-/**
- * multifd_uadk_send_prepare: prepare data to be able to send
- *
- * Create a compressed buffer with all the pages that we are going to
- * send.
- *
- * Returns 0 for success or -1 for error
- *
- * @p: Params for the channel that we are using
- * @errp: pointer to an error
- */
 static int multifd_uadk_send_prepare(MultiFDSendParams *p, Error **errp)
 {
     struct wd_data *uadk_data = p->compress_data;
@@ -229,16 +202,6 @@ out:
     return 0;
 }
 
-/**
- * multifd_uadk_recv_setup: setup receive side
- *
- * Create the compressed channel and buffer.
- *
- * Returns 0 for success or -1 for error
- *
- * @p: Params for the channel that we are using
- * @errp: pointer to an error
- */
 static int multifd_uadk_recv_setup(MultiFDRecvParams *p, Error **errp)
 {
     struct wd_data *wd;
@@ -253,13 +216,6 @@ static int multifd_uadk_recv_setup(MultiFDRecvParams *p, Error **errp)
     return 0;
 }
 
-/**
- * multifd_uadk_recv_cleanup: cleanup receive side
- *
- * Close the channel and return memory.
- *
- * @p: Params for the channel that we are using
- */
 static void multifd_uadk_recv_cleanup(MultiFDRecvParams *p)
 {
     struct wd_data *wd = p->compress_data;
@@ -268,17 +224,6 @@ static void multifd_uadk_recv_cleanup(MultiFDRecvParams *p)
     p->compress_data = NULL;
 }
 
-/**
- * multifd_uadk_recv: read the data from the channel into actual pages
- *
- * Read the compressed buffer, and uncompress it into the actual
- * pages.
- *
- * Returns 0 for success or -1 for error
- *
- * @p: Params for the channel that we are using
- * @errp: pointer to an error
- */
 static int multifd_uadk_recv(MultiFDRecvParams *p, Error **errp)
 {
     struct wd_data *uadk_data = p->compress_data;
diff --git a/migration/multifd-zlib.c b/migration/multifd-zlib.c
index 66517c1067..6787538762 100644
--- a/migration/multifd-zlib.c
+++ b/migration/multifd-zlib.c
@@ -34,17 +34,7 @@ struct zlib_data {
 
 /* Multifd zlib compression */
 
-/**
- * zlib_send_setup: setup send side
- *
- * Setup each channel with zlib compression.
- *
- * Returns 0 for success or -1 for error
- *
- * @p: Params for the channel that we are using
- * @errp: pointer to an error
- */
-static int zlib_send_setup(MultiFDSendParams *p, Error **errp)
+static int multifd_zlib_send_setup(MultiFDSendParams *p, Error **errp)
 {
     struct zlib_data *z = g_new0(struct zlib_data, 1);
     z_stream *zs = &z->zs;
@@ -86,15 +76,7 @@ err_free_z:
     return -1;
 }
 
-/**
- * zlib_send_cleanup: cleanup send side
- *
- * Close the channel and return memory.
- *
- * @p: Params for the channel that we are using
- * @errp: pointer to an error
- */
-static void zlib_send_cleanup(MultiFDSendParams *p, Error **errp)
+static void multifd_zlib_send_cleanup(MultiFDSendParams *p, Error **errp)
 {
     struct zlib_data *z = p->compress_data;
 
@@ -110,18 +92,7 @@ static void zlib_send_cleanup(MultiFDSendParams *p, Error **errp)
     p->iov = NULL;
 }
 
-/**
- * zlib_send_prepare: prepare date to be able to send
- *
- * Create a compressed buffer with all the pages that we are going to
- * send.
- *
- * Returns 0 for success or -1 for error
- *
- * @p: Params for the channel that we are using
- * @errp: pointer to an error
- */
-static int zlib_send_prepare(MultiFDSendParams *p, Error **errp)
+static int multifd_zlib_send_prepare(MultiFDSendParams *p, Error **errp)
 {
     MultiFDPages_t *pages = &p->data->u.ram;
     struct zlib_data *z = p->compress_data;
@@ -189,17 +160,7 @@ out:
     return 0;
 }
 
-/**
- * zlib_recv_setup: setup receive side
- *
- * Create the compressed channel and buffer.
- *
- * Returns 0 for success or -1 for error
- *
- * @p: Params for the channel that we are using
- * @errp: pointer to an error
- */
-static int zlib_recv_setup(MultiFDRecvParams *p, Error **errp)
+static int multifd_zlib_recv_setup(MultiFDRecvParams *p, Error **errp)
 {
     struct zlib_data *z = g_new0(struct zlib_data, 1);
     z_stream *zs = &z->zs;
@@ -225,14 +186,7 @@ static int zlib_recv_setup(MultiFDRecvParams *p, Error **errp)
     return 0;
 }
 
-/**
- * zlib_recv_cleanup: setup receive side
- *
- * For no compression this function does nothing.
- *
- * @p: Params for the channel that we are using
- */
-static void zlib_recv_cleanup(MultiFDRecvParams *p)
+static void multifd_zlib_recv_cleanup(MultiFDRecvParams *p)
 {
     struct zlib_data *z = p->compress_data;
 
@@ -243,18 +197,7 @@ static void zlib_recv_cleanup(MultiFDRecvParams *p)
     p->compress_data = NULL;
 }
 
-/**
- * zlib_recv: read the data from the channel into actual pages
- *
- * Read the compressed buffer, and uncompress it into the actual
- * pages.
- *
- * Returns 0 for success or -1 for error
- *
- * @p: Params for the channel that we are using
- * @errp: pointer to an error
- */
-static int zlib_recv(MultiFDRecvParams *p, Error **errp)
+static int multifd_zlib_recv(MultiFDRecvParams *p, Error **errp)
 {
     struct zlib_data *z = p->compress_data;
     z_stream *zs = &z->zs;
@@ -335,12 +278,12 @@ static int zlib_recv(MultiFDRecvParams *p, Error **errp)
 }
 
 static MultiFDMethods multifd_zlib_ops = {
-    .send_setup = zlib_send_setup,
-    .send_cleanup = zlib_send_cleanup,
-    .send_prepare = zlib_send_prepare,
-    .recv_setup = zlib_recv_setup,
-    .recv_cleanup = zlib_recv_cleanup,
-    .recv = zlib_recv
+    .send_setup = multifd_zlib_send_setup,
+    .send_cleanup = multifd_zlib_send_cleanup,
+    .send_prepare = multifd_zlib_send_prepare,
+    .recv_setup = multifd_zlib_recv_setup,
+    .recv_cleanup = multifd_zlib_recv_cleanup,
+    .recv = multifd_zlib_recv
 };
 
 static void multifd_zlib_register(void)
diff --git a/migration/multifd-zstd.c b/migration/multifd-zstd.c
index 04ac711cf4..1576b1e2ad 100644
--- a/migration/multifd-zstd.c
+++ b/migration/multifd-zstd.c
@@ -37,17 +37,7 @@ struct zstd_data {
 
 /* Multifd zstd compression */
 
-/**
- * zstd_send_setup: setup send side
- *
- * Setup each channel with zstd compression.
- *
- * Returns 0 for success or -1 for error
- *
- * @p: Params for the channel that we are using
- * @errp: pointer to an error
- */
-static int zstd_send_setup(MultiFDSendParams *p, Error **errp)
+static int multifd_zstd_send_setup(MultiFDSendParams *p, Error **errp)
 {
     struct zstd_data *z = g_new0(struct zstd_data, 1);
     int res;
@@ -83,15 +73,7 @@ static int zstd_send_setup(MultiFDSendParams *p, Error **errp)
     return 0;
 }
 
-/**
- * zstd_send_cleanup: cleanup send side
- *
- * Close the channel and return memory.
- *
- * @p: Params for the channel that we are using
- * @errp: pointer to an error
- */
-static void zstd_send_cleanup(MultiFDSendParams *p, Error **errp)
+static void multifd_zstd_send_cleanup(MultiFDSendParams *p, Error **errp)
 {
     struct zstd_data *z = p->compress_data;
 
@@ -106,18 +88,7 @@ static void zstd_send_cleanup(MultiFDSendParams *p, Error **errp)
     p->iov = NULL;
 }
 
-/**
- * zstd_send_prepare: prepare date to be able to send
- *
- * Create a compressed buffer with all the pages that we are going to
- * send.
- *
- * Returns 0 for success or -1 for error
- *
- * @p: Params for the channel that we are using
- * @errp: pointer to an error
- */
-static int zstd_send_prepare(MultiFDSendParams *p, Error **errp)
+static int multifd_zstd_send_prepare(MultiFDSendParams *p, Error **errp)
 {
     MultiFDPages_t *pages = &p->data->u.ram;
     struct zstd_data *z = p->compress_data;
@@ -176,17 +147,7 @@ out:
     return 0;
 }
 
-/**
- * zstd_recv_setup: setup receive side
- *
- * Create the compressed channel and buffer.
- *
- * Returns 0 for success or -1 for error
- *
- * @p: Params for the channel that we are using
- * @errp: pointer to an error
- */
-static int zstd_recv_setup(MultiFDRecvParams *p, Error **errp)
+static int multifd_zstd_recv_setup(MultiFDRecvParams *p, Error **errp)
 {
     struct zstd_data *z = g_new0(struct zstd_data, 1);
     int ret;
@@ -220,14 +181,7 @@ static int zstd_recv_setup(MultiFDRecvParams *p, Error **errp)
     return 0;
 }
 
-/**
- * zstd_recv_cleanup: setup receive side
- *
- * For no compression this function does nothing.
- *
- * @p: Params for the channel that we are using
- */
-static void zstd_recv_cleanup(MultiFDRecvParams *p)
+static void multifd_zstd_recv_cleanup(MultiFDRecvParams *p)
 {
     struct zstd_data *z = p->compress_data;
 
@@ -239,18 +193,7 @@ static void zstd_recv_cleanup(MultiFDRecvParams *p)
     p->compress_data = NULL;
 }
 
-/**
- * zstd_recv: read the data from the channel into actual pages
- *
- * Read the compressed buffer, and uncompress it into the actual
- * pages.
- *
- * Returns 0 for success or -1 for error
- *
- * @p: Params for the channel that we are using
- * @errp: pointer to an error
- */
-static int zstd_recv(MultiFDRecvParams *p, Error **errp)
+static int multifd_zstd_recv(MultiFDRecvParams *p, Error **errp)
 {
     uint32_t in_size = p->next_packet_size;
     uint32_t out_size = 0;
@@ -323,12 +266,12 @@ static int zstd_recv(MultiFDRecvParams *p, Error **errp)
 }
 
 static MultiFDMethods multifd_zstd_ops = {
-    .send_setup = zstd_send_setup,
-    .send_cleanup = zstd_send_cleanup,
-    .send_prepare = zstd_send_prepare,
-    .recv_setup = zstd_recv_setup,
-    .recv_cleanup = zstd_recv_cleanup,
-    .recv = zstd_recv
+    .send_setup = multifd_zstd_send_setup,
+    .send_cleanup = multifd_zstd_send_cleanup,
+    .send_prepare = multifd_zstd_send_prepare,
+    .recv_setup = multifd_zstd_recv_setup,
+    .recv_cleanup = multifd_zstd_recv_cleanup,
+    .recv = multifd_zstd_recv
 };
 
 static void multifd_zstd_register(void)
diff --git a/migration/multifd.c b/migration/multifd.c
index ce08257706..9f40bb2f16 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -167,15 +167,7 @@ static void multifd_set_file_bitmap(MultiFDSendParams *p)
     }
 }
 
-/* Multifd without compression */
-
-/**
- * nocomp_send_setup: setup send side
- *
- * @p: Params for the channel that we are using
- * @errp: pointer to an error
- */
-static int nocomp_send_setup(MultiFDSendParams *p, Error **errp)
+static int multifd_nocomp_send_setup(MultiFDSendParams *p, Error **errp)
 {
     uint32_t page_count = multifd_ram_page_count();
 
@@ -193,15 +185,7 @@ static int nocomp_send_setup(MultiFDSendParams *p, Error **errp)
     return 0;
 }
 
-/**
- * nocomp_send_cleanup: cleanup send side
- *
- * For no compression this function does nothing.
- *
- * @p: Params for the channel that we are using
- * @errp: pointer to an error
- */
-static void nocomp_send_cleanup(MultiFDSendParams *p, Error **errp)
+static void multifd_nocomp_send_cleanup(MultiFDSendParams *p, Error **errp)
 {
     g_free(p->iov);
     p->iov = NULL;
@@ -222,18 +206,7 @@ static void multifd_send_prepare_iovs(MultiFDSendParams *p)
     p->next_packet_size = pages->normal_num * page_size;
 }
 
-/**
- * nocomp_send_prepare: prepare date to be able to send
- *
- * For no compression we just have to calculate the size of the
- * packet.
- *
- * Returns 0 for success or -1 for error
- *
- * @p: Params for the channel that we are using
- * @errp: pointer to an error
- */
-static int nocomp_send_prepare(MultiFDSendParams *p, Error **errp)
+static int multifd_nocomp_send_prepare(MultiFDSendParams *p, Error **errp)
 {
     bool use_zero_copy_send = migrate_zero_copy_send();
     int ret;
@@ -272,46 +245,19 @@ static int nocomp_send_prepare(MultiFDSendParams *p, Error **errp)
     return 0;
 }
 
-/**
- * nocomp_recv_setup: setup receive side
- *
- * For no compression this function does nothing.
- *
- * Returns 0 for success or -1 for error
- *
- * @p: Params for the channel that we are using
- * @errp: pointer to an error
- */
-static int nocomp_recv_setup(MultiFDRecvParams *p, Error **errp)
+static int multifd_nocomp_recv_setup(MultiFDRecvParams *p, Error **errp)
 {
     p->iov = g_new0(struct iovec, multifd_ram_page_count());
     return 0;
 }
 
-/**
- * nocomp_recv_cleanup: setup receive side
- *
- * For no compression this function does nothing.
- *
- * @p: Params for the channel that we are using
- */
-static void nocomp_recv_cleanup(MultiFDRecvParams *p)
+static void multifd_nocomp_recv_cleanup(MultiFDRecvParams *p)
 {
     g_free(p->iov);
     p->iov = NULL;
 }
 
-/**
- * nocomp_recv: read the data from the channel
- *
- * For no compression we just need to read things into the correct place.
- *
- * Returns 0 for success or -1 for error
- *
- * @p: Params for the channel that we are using
- * @errp: pointer to an error
- */
-static int nocomp_recv(MultiFDRecvParams *p, Error **errp)
+static int multifd_nocomp_recv(MultiFDRecvParams *p, Error **errp)
 {
     uint32_t flags;
 
@@ -342,12 +288,12 @@ static int nocomp_recv(MultiFDRecvParams *p, Error **errp)
 }
 
 static MultiFDMethods multifd_nocomp_ops = {
-    .send_setup = nocomp_send_setup,
-    .send_cleanup = nocomp_send_cleanup,
-    .send_prepare = nocomp_send_prepare,
-    .recv_setup = nocomp_recv_setup,
-    .recv_cleanup = nocomp_recv_cleanup,
-    .recv = nocomp_recv
+    .send_setup = multifd_nocomp_send_setup,
+    .send_cleanup = multifd_nocomp_send_cleanup,
+    .send_prepare = multifd_nocomp_send_prepare,
+    .recv_setup = multifd_nocomp_recv_setup,
+    .recv_cleanup = multifd_nocomp_recv_cleanup,
+    .recv = multifd_nocomp_recv
 };
 
 static MultiFDMethods *multifd_ops[MULTIFD_COMPRESSION__MAX] = {
-- 
2.35.3


