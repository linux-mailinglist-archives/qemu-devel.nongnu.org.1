Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6D37DD684
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 20:05:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxtyP-0004Jd-Bj; Tue, 31 Oct 2023 15:00:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qxty5-00047d-GT
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 15:00:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qxtxk-00068H-9j
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 15:00:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698778778;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4CuwuVHIzzuQHItZTvM9/+Limg0335MhIuSQTwYUEIM=;
 b=ICkuCHqhdlR3lX8zanLjlQqfFYRbVlv6c5MpXX8rN2BrRtYy2eUBsuSBQtKmwquH3PeC9Y
 MAua123Yez9v3nuYTQuKYQexWLFk6r3BVSngd/kaYsQ4N053whGB01IPOucyccc4N6RkE9
 8Ya0jWqApxUqqna2+l8fpgG+bOJ7wsg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-695-oADW7jDpOmqv_xn17SBbrg-1; Tue,
 31 Oct 2023 14:59:37 -0400
X-MC-Unique: oADW7jDpOmqv_xn17SBbrg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EA7173C0BE54;
 Tue, 31 Oct 2023 18:59:36 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.218])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5697D2E0;
 Tue, 31 Oct 2023 18:59:36 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 20/27] block/mirror: move dirty bitmap to filter
Date: Tue, 31 Oct 2023 19:59:11 +0100
Message-ID: <20231031185918.346940-21-kwolf@redhat.com>
In-Reply-To: <20231031185918.346940-1-kwolf@redhat.com>
References: <20231031185918.346940-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.481,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Fiona Ebner <f.ebner@proxmox.com>

In preparation to allow switching to active mode without draining.
Initialization of the bitmap in mirror_dirty_init() still happens with
the original/backing BlockDriverState, which should be fine, because
the mirror top has the same length.

Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Message-ID: <20231031135431.393137-4-f.ebner@proxmox.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/mirror.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index 1c2c00ee1d..914d723446 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1500,6 +1500,11 @@ bdrv_mirror_top_do_write(BlockDriverState *bs, MirrorMethod method,
         abort();
     }
 
+    if (!copy_to_target && s->job && s->job->dirty_bitmap) {
+        s->job->actively_synced = false;
+        bdrv_set_dirty_bitmap(s->job->dirty_bitmap, offset, bytes);
+    }
+
     if (ret < 0) {
         goto out;
     }
@@ -1823,13 +1828,17 @@ static BlockJob *mirror_start_job(
         s->should_complete = true;
     }
 
-    s->dirty_bitmap = bdrv_create_dirty_bitmap(bs, granularity, NULL, errp);
+    s->dirty_bitmap = bdrv_create_dirty_bitmap(s->mirror_top_bs, granularity,
+                                               NULL, errp);
     if (!s->dirty_bitmap) {
         goto fail;
     }
-    if (s->copy_mode == MIRROR_COPY_MODE_WRITE_BLOCKING) {
-        bdrv_disable_dirty_bitmap(s->dirty_bitmap);
-    }
+
+    /*
+     * The dirty bitmap is set by bdrv_mirror_top_do_write() when not in active
+     * mode.
+     */
+    bdrv_disable_dirty_bitmap(s->dirty_bitmap);
 
     ret = block_job_add_bdrv(&s->common, "source", bs, 0,
                              BLK_PERM_WRITE_UNCHANGED | BLK_PERM_WRITE |
-- 
2.41.0


