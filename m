Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3932B70E782
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 23:40:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1Zj7-0000b9-0d; Tue, 23 May 2023 17:39:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1q1Zj5-0000aa-1k; Tue, 23 May 2023 17:39:27 -0400
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1q1Zj3-0004gE-HY; Tue, 23 May 2023 17:39:26 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 15A3422557;
 Tue, 23 May 2023 21:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1684877964; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MZRkBMV9CBMUFXLX/xkNC4zvHhFkiT+22nxJpPXJ7Lk=;
 b=Dg57z3XPQmfXOiDWsAqw2d8WXR+A2o4vC+KdPEPl4l1l8eemDiCB6wp0Y9xZCa8TBc3BWz
 0LfCyEkqAyNIHKHgShs6gWk7nNDy+3sn9N9mOoHvVfgQIr9EChAklOZVzZzymuefpdQ5Ws
 r9slKaMncw4qO10ybr3Pq+MTqcsZlRU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1684877964;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MZRkBMV9CBMUFXLX/xkNC4zvHhFkiT+22nxJpPXJ7Lk=;
 b=LCXhv7PLaXGnpztF8uCdM9T76Xiix3D9Im+gOIl4P+iIHSdFbggXn3GZ7jcQFoPimdIbTZ
 M8ZsPOSXEIB61TBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7A9A913588;
 Tue, 23 May 2023 21:39:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id iEE5EYkybWQ7CwAAMHmgww
 (envelope-from <farosas@suse.de>); Tue, 23 May 2023 21:39:21 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Jo=C3=A3o=20Silva?= <jsilva@suse.de>, Lin Ma <lma@suse.com>,
 Claudio Fontana <cfontana@suse.de>, Dario Faggioli <dfaggioli@suse.com>,
 Eric Blake <eblake@redhat.com>
Subject: [RFC PATCH 5/6] block: Allow bdrv_get_allocated_file_size to run in
 bdrv context
Date: Tue, 23 May 2023 18:39:02 -0300
Message-Id: <20230523213903.18418-6-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230523213903.18418-1-farosas@suse.de>
References: <20230523213903.18418-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:67c:2178:6::1c; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

We're about to move calls to 'fstat' into the thread-pool to avoid
blocking VCPU threads should the system call take too long.

To achieve that we first need to make sure none of its callers is
holding the aio_context lock, otherwise yielding before scheduling the
aiocb handler would result in a deadlock when the qemu_global_mutex is
released and another thread tries to acquire the aio_context.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 block/qapi.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/block/qapi.c b/block/qapi.c
index ae6cd1c2ff..cd197abf1f 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -222,6 +222,26 @@ int bdrv_query_snapshot_info_list(BlockDriverState *bs,
     return 0;
 }
 
+static int64_t bdrv_get_actual_size(BlockDriverState *bs)
+{
+    int64_t size;
+    AioContext *old_ctx = NULL;
+
+    if (qemu_in_coroutine()) {
+        aio_context_release(bdrv_get_aio_context(bs));
+        old_ctx = bdrv_co_enter(bs);
+    }
+
+    size = bdrv_get_allocated_file_size(bs);
+
+    if (qemu_in_coroutine() && old_ctx) {
+        bdrv_co_leave(bs, old_ctx);
+        aio_context_acquire(bdrv_get_aio_context(bs));
+    }
+
+    return size;
+}
+
 /**
  * Helper function for other query info functions.  Store information about @bs
  * in @info, setting @errp on error.
@@ -250,7 +270,7 @@ static void bdrv_do_query_node_info(BlockDriverState *bs,
     info->filename        = g_strdup(bs->filename);
     info->format          = g_strdup(bdrv_get_format_name(bs));
     info->virtual_size    = size;
-    info->actual_size     = bdrv_get_allocated_file_size(bs);
+    info->actual_size     = bdrv_get_actual_size(bs);
     info->has_actual_size = info->actual_size >= 0;
     if (bs->encrypted) {
         info->encrypted = true;
-- 
2.35.3


