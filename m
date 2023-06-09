Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1296772A4A3
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 22:21:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7iaZ-00026y-PL; Fri, 09 Jun 2023 16:20:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1q7iaU-00024T-Lv; Fri, 09 Jun 2023 16:19:58 -0400
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1q7iaR-0000Dt-HY; Fri, 09 Jun 2023 16:19:58 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 43C771FE13;
 Fri,  9 Jun 2023 20:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1686341983; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IAYfXytPDBRwVP2G0FvkZTp/QNZh8w1vC/I5UdCl9Qc=;
 b=z/RTtIPWgmTXDVaU/tHMliLe15sUelYljhui202FrVHLxtZbT/BAz9J+4k+iEe1THo8sK8
 ywg+WbF/ZJsgqWr/sgTbC8dJ8blhfPAFS3L9Yp9TgOXzgnMhU1mZYyy8fYkk1xRiF7kmnI
 cxxYTbc5eZJeWDyDICCIRmyq+RkgyVw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1686341983;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IAYfXytPDBRwVP2G0FvkZTp/QNZh8w1vC/I5UdCl9Qc=;
 b=EChQqPKF1mEE8Uzme6jGqT3VPrCCn7UdMqF5P/dwDfZpqYzuZhc3K72eNhFQSk1gNUKmzn
 Ms/Pem9yzchvG0CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 60712139C8;
 Fri,  9 Jun 2023 20:19:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id YN1eCVyJg2R/SwAAMHmgww
 (envelope-from <farosas@suse.de>); Fri, 09 Jun 2023 20:19:40 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Jo=C3=A3o=20Silva?= <jsilva@suse.de>, Lin Ma <lma@suse.com>,
 Claudio Fontana <cfontana@suse.de>, Dario Faggioli <dfaggioli@suse.com>,
 Eric Blake <eblake@redhat.com>
Subject: [PATCH v2 08/10] block: Don't query all block devices at
 hmp_nbd_server_start
Date: Fri,  9 Jun 2023 17:19:08 -0300
Message-Id: <20230609201910.12100-9-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230609201910.12100-1-farosas@suse.de>
References: <20230609201910.12100-1-farosas@suse.de>
MIME-Version: 1.0
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

We're currently doing a full query-block just to enumerate the devices
for qmp_nbd_server_add and then discarding the BlockInfoList
afterwards. Alter hmp_nbd_server_start to instead iterate explicitly
over the block_backends list.

This allows the removal of the dependency on qmp_query_block from
hmp_nbd_server_start. This is desirable because we're about to move
qmp_query_block into a coroutine and don't need to change the NBD code
at the same time.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 block/monitor/block-hmp-cmds.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmds.c
index ca2599de44..26116fe831 100644
--- a/block/monitor/block-hmp-cmds.c
+++ b/block/monitor/block-hmp-cmds.c
@@ -394,7 +394,7 @@ void hmp_nbd_server_start(Monitor *mon, const QDict *qdict)
     bool writable = qdict_get_try_bool(qdict, "writable", false);
     bool all = qdict_get_try_bool(qdict, "all", false);
     Error *local_err = NULL;
-    BlockInfoList *block_list, *info;
+    BlockBackend *blk;
     SocketAddress *addr;
     NbdServerAddOptions export;
 
@@ -419,18 +419,24 @@ void hmp_nbd_server_start(Monitor *mon, const QDict *qdict)
         return;
     }
 
-    /* Then try adding all block devices.  If one fails, close all and
+    /*
+     * Then try adding all block devices.  If one fails, close all and
      * exit.
      */
-    block_list = qmp_query_block(NULL);
+    for (blk = blk_all_next(NULL); blk; blk = blk_all_next(blk)) {
+        BlockDriverState *bs = blk_bs(blk);
 
-    for (info = block_list; info; info = info->next) {
-        if (!info->value->inserted) {
+        if (!*blk_name(blk) && !blk_get_attached_dev(blk)) {
+            continue;
+        }
+
+        bs = bdrv_skip_implicit_filters(bs);
+        if (!bs || !bs->drv) {
             continue;
         }
 
         export = (NbdServerAddOptions) {
-            .device         = info->value->device,
+            .device         = g_strdup(blk_name(blk)),
             .has_writable   = true,
             .writable       = writable,
         };
@@ -443,8 +449,6 @@ void hmp_nbd_server_start(Monitor *mon, const QDict *qdict)
         }
     }
 
-    qapi_free_BlockInfoList(block_list);
-
 exit:
     hmp_handle_error(mon, local_err);
 }
-- 
2.35.3


