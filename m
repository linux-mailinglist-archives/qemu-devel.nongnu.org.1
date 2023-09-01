Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C13C79023E
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 20:48:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qc9A1-00046b-4Q; Fri, 01 Sep 2023 14:46:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1qc99r-00045k-WF; Fri, 01 Sep 2023 14:46:19 -0400
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1qc99p-0004YT-Pl; Fri, 01 Sep 2023 14:46:15 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4A2A21F74B;
 Fri,  1 Sep 2023 18:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1693593971; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RXj0EuXOLKtqtlvBCvBMqLRUqLmYf6zo5k0zO0GeMwE=;
 b=s8DI6As8tvoow1aez7fY+55jPVnarjVoDkdfepKy33fco2s1K+nydJrfLFKtBpvTuF0iyQ
 YOQ+U1JJKPehmLANCifUYPiL1OhYQE3/lvjQjI8rvJ3unQ6Uk9GdZPl9ijAB5+42XSfzMX
 PhyfHfCmkeRZPsRn6lRiUXQ7M1KMtNU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1693593971;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RXj0EuXOLKtqtlvBCvBMqLRUqLmYf6zo5k0zO0GeMwE=;
 b=O+ln7/q+5jTto4+tdcWpG6qt4db1tjwYQLBeId9I9TqC+BQAPqTRwNktWR71YpUHGhrS+F
 0kGHI2W+Uv8We8Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BC5A213582;
 Fri,  1 Sep 2023 18:46:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id wCxRIXEx8mSQVgAAMHmgww
 (envelope-from <farosas@suse.de>); Fri, 01 Sep 2023 18:46:09 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Claudio Fontana <cfontana@suse.de>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH RESEND 1/2] block: Remove bdrv_query_block_node_info
Date: Fri,  1 Sep 2023 15:46:04 -0300
Message-Id: <20230901184605.32260-2-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230901184605.32260-1-farosas@suse.de>
References: <20230901184605.32260-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:67c:2178:6::1d; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

The last call site of this function has been removed by commit
c04d0ab026 ("qemu-img: Let info print block graph").

Reviewed-by: Claudio Fontana <cfontana@suse.de>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 block/qapi.c         | 27 ---------------------------
 include/block/qapi.h |  3 ---
 2 files changed, 30 deletions(-)

diff --git a/block/qapi.c b/block/qapi.c
index f34f95e0ef..79bf80c503 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -309,33 +309,6 @@ out:
     aio_context_release(bdrv_get_aio_context(bs));
 }
 
-/**
- * bdrv_query_block_node_info:
- * @bs: block node to examine
- * @p_info: location to store node information
- * @errp: location to store error information
- *
- * Store image information about @bs in @p_info.
- *
- * @p_info will be set only on success. On error, store error in @errp.
- */
-void bdrv_query_block_node_info(BlockDriverState *bs,
-                                BlockNodeInfo **p_info,
-                                Error **errp)
-{
-    BlockNodeInfo *info;
-    ERRP_GUARD();
-
-    info = g_new0(BlockNodeInfo, 1);
-    bdrv_do_query_node_info(bs, info, errp);
-    if (*errp) {
-        qapi_free_BlockNodeInfo(info);
-        return;
-    }
-
-    *p_info = info;
-}
-
 /**
  * bdrv_query_image_info:
  * @bs: block node to examine
diff --git a/include/block/qapi.h b/include/block/qapi.h
index 18d48ddb70..8663971c58 100644
--- a/include/block/qapi.h
+++ b/include/block/qapi.h
@@ -36,9 +36,6 @@ BlockDeviceInfo *bdrv_block_device_info(BlockBackend *blk,
 int bdrv_query_snapshot_info_list(BlockDriverState *bs,
                                   SnapshotInfoList **p_list,
                                   Error **errp);
-void bdrv_query_block_node_info(BlockDriverState *bs,
-                                BlockNodeInfo **p_info,
-                                Error **errp);
 void bdrv_query_image_info(BlockDriverState *bs,
                            ImageInfo **p_info,
                            bool flat,
-- 
2.35.3


