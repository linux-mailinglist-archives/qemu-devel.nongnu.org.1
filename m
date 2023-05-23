Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F1A70E781
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 23:40:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1ZjB-0000c2-0d; Tue, 23 May 2023 17:39:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1q1Zj8-0000bS-6w; Tue, 23 May 2023 17:39:30 -0400
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1q1Zj6-0004gg-IV; Tue, 23 May 2023 17:39:29 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1B6DA1FDCB;
 Tue, 23 May 2023 21:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1684877967; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8UtTA4VS+v6RK2oMpfABPplNec6WNdoTQcTTtAspvnQ=;
 b=ZFN45fZ8pNmgR39ZjjnpZOXw63X4QHuDxlraulPSEdmbwpyNBjan6nyjuIlz9y+NZZujKp
 MKpcM9axn0OiqNzhHwi7ZGMXCfline18ToIEtVdE44gzTTFuN58ev1zU5BHbM17TNTEvDq
 2z5kCJ7woZ24LtRPhYbjqZoJDrfMWv0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1684877967;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8UtTA4VS+v6RK2oMpfABPplNec6WNdoTQcTTtAspvnQ=;
 b=6V1fACaHflbVjqW1vmCNkItt+YcjBXhkjBWFnetDu6HejqKvv3KUY1KN/Rqip+Duida0Ah
 pJ0pCYHpHxsOAjAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8241413588;
 Tue, 23 May 2023 21:39:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id aDshE4wybWQ7CwAAMHmgww
 (envelope-from <farosas@suse.de>); Tue, 23 May 2023 21:39:24 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Jo=C3=A3o=20Silva?= <jsilva@suse.de>, Lin Ma <lma@suse.com>,
 Claudio Fontana <cfontana@suse.de>, Dario Faggioli <dfaggioli@suse.com>,
 Eric Blake <eblake@redhat.com>
Subject: [RFC PATCH 6/6] block: Add a thread-pool version of fstat
Date: Tue, 23 May 2023 18:39:03 -0300
Message-Id: <20230523213903.18418-7-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230523213903.18418-1-farosas@suse.de>
References: <20230523213903.18418-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:67c:2178:6::1d; envelope-from=farosas@suse.de;
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

From: João Silva <jsilva@suse.de>

The fstat call can take a long time to finish when running over
NFS. Add a version of it that runs in the thread pool.

Adapt one of its users, raw_co_get_allocated_file size to use the new
version. That function is called via QMP under the qemu_global_mutex
so it has a large chance of blocking VCPU threads in case it takes too
long to finish.

Signed-off-by: João Silva <jsilva@suse.de>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 block/file-posix.c      | 40 +++++++++++++++++++++++++++++++++++++---
 include/block/raw-aio.h |  4 +++-
 2 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 0ab158efba..0a29a6cc43 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -227,6 +227,9 @@ typedef struct RawPosixAIOData {
         struct {
             unsigned long op;
         } zone_mgmt;
+        struct {
+            struct stat *st;
+        } fstat;
     };
 } RawPosixAIOData;
 
@@ -2644,6 +2647,34 @@ static void raw_close(BlockDriverState *bs)
     }
 }
 
+static int handle_aiocb_fstat(void *opaque)
+{
+    RawPosixAIOData *aiocb = opaque;
+
+    if (fstat(aiocb->aio_fildes, aiocb->fstat.st) < 0) {
+        return -errno;
+    }
+
+    return 0;
+}
+
+static int coroutine_fn raw_co_fstat(BlockDriverState *bs, struct stat *st)
+{
+    BDRVRawState *s = bs->opaque;
+    RawPosixAIOData acb;
+
+    acb = (RawPosixAIOData) {
+        .bs             = bs,
+        .aio_fildes     = s->fd,
+        .aio_type       = QEMU_AIO_FSTAT,
+        .fstat          = {
+            .st = st,
+        },
+    };
+
+    return raw_thread_pool_submit(handle_aiocb_fstat, &acb);
+}
+
 /**
  * Truncates the given regular file @fd to @offset and, when growing, fills the
  * new space according to @prealloc.
@@ -2883,11 +2914,14 @@ static int64_t coroutine_fn raw_co_getlength(BlockDriverState *bs)
 static int64_t coroutine_fn raw_co_get_allocated_file_size(BlockDriverState *bs)
 {
     struct stat st;
-    BDRVRawState *s = bs->opaque;
+    int ret;
 
-    if (fstat(s->fd, &st) < 0) {
-        return -errno;
+    ret = raw_co_fstat(bs, &st);
+
+    if (ret) {
+        return ret;
     }
+
     return (int64_t)st.st_blocks * 512;
 }
 
diff --git a/include/block/raw-aio.h b/include/block/raw-aio.h
index 0fe85ade77..7dc6d24e21 100644
--- a/include/block/raw-aio.h
+++ b/include/block/raw-aio.h
@@ -31,6 +31,7 @@
 #define QEMU_AIO_ZONE_REPORT  0x0100
 #define QEMU_AIO_ZONE_MGMT    0x0200
 #define QEMU_AIO_ZONE_APPEND  0x0400
+#define QEMU_AIO_FSTAT        0x0800
 #define QEMU_AIO_TYPE_MASK \
         (QEMU_AIO_READ | \
          QEMU_AIO_WRITE | \
@@ -42,7 +43,8 @@
          QEMU_AIO_TRUNCATE | \
          QEMU_AIO_ZONE_REPORT | \
          QEMU_AIO_ZONE_MGMT | \
-         QEMU_AIO_ZONE_APPEND)
+         QEMU_AIO_ZONE_APPEND | \
+         QEMU_AIO_FSTAT)
 
 /* AIO flags */
 #define QEMU_AIO_MISALIGNED   0x1000
-- 
2.35.3


