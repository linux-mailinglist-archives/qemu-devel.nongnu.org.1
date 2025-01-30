Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C17A23295
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Jan 2025 18:14:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdY6d-0000lu-Qz; Thu, 30 Jan 2025 12:13:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tdY6Y-0000jG-AC
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 12:13:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tdY6V-0003G2-3Z
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 12:13:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738257200;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dk2VJkbp/ESsuXG+uATmLQktP5CdnzP9cX78wLplU4E=;
 b=YV4OqDgMhY+sRrWDJoVKBp31KU8wsMjs4sugax0pl/md0WvaLqhglRdjUquuvW35NUW3ue
 XTahcxaSUnDYGLUkFCFiNZeCNg1QvdcvFNdg9/4p6YdGf1r6oHDnJyHfESpH7B7CvSr4+/
 lDCFOnI87oJSnVjLc1YBjEkZff0EMWg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-68-vd9MIpHANNSgWtEdsRYP_g-1; Thu,
 30 Jan 2025 12:13:17 -0500
X-MC-Unique: vd9MIpHANNSgWtEdsRYP_g-1
X-Mimecast-MFC-AGG-ID: vd9MIpHANNSgWtEdsRYP_g
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D61A918009F5; Thu, 30 Jan 2025 17:13:15 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.193.13])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 691293003FD1; Thu, 30 Jan 2025 17:13:13 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com,
 pkrempa@redhat.com, peterx@redhat.com, farosas@suse.de,
 qemu-devel@nongnu.org
Subject: [PATCH v2 09/15] block: Support inactive nodes in blk_insert_bs()
Date: Thu, 30 Jan 2025 18:12:40 +0100
Message-ID: <20250130171240.286878-10-kwolf@redhat.com>
In-Reply-To: <20250130171240.286878-1-kwolf@redhat.com>
References: <20250130171240.286878-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Device models have a relatively complex way to set up their block
backends, in which blk_attach_dev() sets blk->disable_perm = true.
We want to support inactive images in exports, too, so that
qemu-storage-daemon can be used with migration. Because they don't use
blk_attach_dev(), they need another way to set this flag. The most
convenient is to do this automatically when an inactive node is attached
to a BlockBackend that can be inactivated.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/block-backend.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index cc6f58ae78..9288f7e1c6 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -900,14 +900,24 @@ void blk_remove_bs(BlockBackend *blk)
 int blk_insert_bs(BlockBackend *blk, BlockDriverState *bs, Error **errp)
 {
     ThrottleGroupMember *tgm = &blk->public.throttle_group_member;
+    uint64_t perm, shared_perm;
 
     GLOBAL_STATE_CODE();
     bdrv_ref(bs);
     bdrv_graph_wrlock();
+
+    if ((bs->open_flags & BDRV_O_INACTIVE) && blk_can_inactivate(blk)) {
+        blk->disable_perm = true;
+        perm = 0;
+        shared_perm = BLK_PERM_ALL;
+    } else {
+        perm = blk->perm;
+        shared_perm = blk->shared_perm;
+    }
+
     blk->root = bdrv_root_attach_child(bs, "root", &child_root,
                                        BDRV_CHILD_FILTERED | BDRV_CHILD_PRIMARY,
-                                       blk->perm, blk->shared_perm,
-                                       blk, errp);
+                                       perm, shared_perm, blk, errp);
     bdrv_graph_wrunlock();
     if (blk->root == NULL) {
         return -EPERM;
-- 
2.48.1


