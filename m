Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EAF47FAB5E
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 21:27:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7iCC-00031w-Jb; Mon, 27 Nov 2023 15:27:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1r7iCA-0002vc-LD
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 15:27:06 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1r7iC8-0002p1-Sk
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 15:27:06 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8D7B51FB79;
 Mon, 27 Nov 2023 20:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1701116823; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iG3ySoK+kjQLed5T1UGWfiBTuZNVuWrBdfLbg6Skwwk=;
 b=nrRJY+C1nYeZ/sGH++zrQvbRluH/4QOCKMWo3U79X3S50DuaA8shuxiRH7+LpNiNqzbi2k
 wsgz3fqBKUNRpsXAdp47HHjRpL/OyHA7ZKzTp74KfUMtoEWL+S6sCPdHHMhPXkdkkR+Cdg
 8LSW8dVZ2SMPcrVYHrqS7EdvNqleaGk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1701116823;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iG3ySoK+kjQLed5T1UGWfiBTuZNVuWrBdfLbg6Skwwk=;
 b=G9Ml0aZ0tRW5YKNALiedceEDzWQiUux3XpeyK15dNi4nhykEq+eRhwIjoJHc2abmHYPLfx
 pIBGUoXa5csyEfBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7C1921379A;
 Mon, 27 Nov 2023 20:27:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MN7HEJX7ZGVfIQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 27 Nov 2023 20:27:01 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Claudio Fontana <cfontana@suse.de>
Subject: [RFC PATCH v3 17/30] migration/multifd: Decouple recv method from
 pages
Date: Mon, 27 Nov 2023 17:25:59 -0300
Message-Id: <20231127202612.23012-18-farosas@suse.de>
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

Next patch will abstract the type of data being received by the
channels, so do some cleanup now to remove references to pages and
dependency on 'normal_num'.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/multifd-zlib.c |  2 +-
 migration/multifd-zstd.c |  2 +-
 migration/multifd.c      | 12 +++++++-----
 migration/multifd.h      |  5 ++---
 4 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/migration/multifd-zlib.c b/migration/multifd-zlib.c
index fd94e79dd9..e019d2d74e 100644
--- a/migration/multifd-zlib.c
+++ b/migration/multifd-zlib.c
@@ -314,7 +314,7 @@ static MultiFDMethods multifd_zlib_ops = {
     .send_prepare = zlib_send_prepare,
     .recv_setup = zlib_recv_setup,
     .recv_cleanup = zlib_recv_cleanup,
-    .recv_pages = zlib_recv_pages
+    .recv_data = zlib_recv_pages
 };
 
 static void multifd_zlib_register(void)
diff --git a/migration/multifd-zstd.c b/migration/multifd-zstd.c
index 238eebbf4b..0b8414df5b 100644
--- a/migration/multifd-zstd.c
+++ b/migration/multifd-zstd.c
@@ -305,7 +305,7 @@ static MultiFDMethods multifd_zstd_ops = {
     .send_prepare = zstd_send_prepare,
     .recv_setup = zstd_recv_setup,
     .recv_cleanup = zstd_recv_cleanup,
-    .recv_pages = zstd_recv_pages
+    .recv_data = zstd_recv_pages
 };
 
 static void multifd_zstd_register(void)
diff --git a/migration/multifd.c b/migration/multifd.c
index 3476fac49f..c1381bdc21 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -130,7 +130,7 @@ static void nocomp_recv_cleanup(MultiFDRecvParams *p)
 }
 
 /**
- * nocomp_recv_pages: read the data from the channel into actual pages
+ * nocomp_recv_data: read the data from the channel
  *
  * For no compression we just need to read things into the correct place.
  *
@@ -139,7 +139,7 @@ static void nocomp_recv_cleanup(MultiFDRecvParams *p)
  * @p: Params for the channel that we are using
  * @errp: pointer to an error
  */
-static int nocomp_recv_pages(MultiFDRecvParams *p, Error **errp)
+static int nocomp_recv_data(MultiFDRecvParams *p, Error **errp)
 {
     uint32_t flags = p->flags & MULTIFD_FLAG_COMPRESSION_MASK;
 
@@ -161,7 +161,7 @@ static MultiFDMethods multifd_nocomp_ops = {
     .send_prepare = nocomp_send_prepare,
     .recv_setup = nocomp_recv_setup,
     .recv_cleanup = nocomp_recv_cleanup,
-    .recv_pages = nocomp_recv_pages
+    .recv_data = nocomp_recv_data
 };
 
 static MultiFDMethods *multifd_ops[MULTIFD_COMPRESSION__MAX] = {
@@ -1126,6 +1126,7 @@ static void *multifd_recv_thread(void *opaque)
 
     while (true) {
         uint32_t flags = 0;
+        bool has_data = false;
         p->normal_num = 0;
 
         if (p->quit) {
@@ -1154,12 +1155,13 @@ static void *multifd_recv_thread(void *opaque)
                                p->next_packet_size);
 
             p->total_normal_pages += p->normal_num;
+            has_data = !!p->normal_num;
         }
 
         qemu_mutex_unlock(&p->mutex);
 
-        if (p->normal_num) {
-            ret = multifd_recv_state->ops->recv_pages(p, &local_err);
+        if (has_data) {
+            ret = multifd_recv_state->ops->recv_data(p, &local_err);
             if (ret != 0) {
                 break;
             }
diff --git a/migration/multifd.h b/migration/multifd.h
index 744b52762f..406d42dbae 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -203,11 +203,10 @@ typedef struct {
     int (*recv_setup)(MultiFDRecvParams *p, Error **errp);
     /* Cleanup for receiving side */
     void (*recv_cleanup)(MultiFDRecvParams *p);
-    /* Read all pages */
-    int (*recv_pages)(MultiFDRecvParams *p, Error **errp);
+    /* Read all data */
+    int (*recv_data)(MultiFDRecvParams *p, Error **errp);
 } MultiFDMethods;
 
 void multifd_register_ops(int method, MultiFDMethods *ops);
 
 #endif
-
-- 
2.35.3


