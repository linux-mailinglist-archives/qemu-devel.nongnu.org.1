Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D56467919C2
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 16:38:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdAhT-0002Kf-8L; Mon, 04 Sep 2023 10:37:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qdAhR-0002Hy-IY
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 10:37:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qdAhN-0001mn-G6
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 10:37:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693838224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UnBnXbDFQSzMihNTk0UgBZT7Q2m3zJCm4ZBJ+7ReXKM=;
 b=MeQkmv1fC+V98qFcdyuW2NvCpnXI3bLDapi9rpzorAASYheumPYeu8xOtSvE6m+j3uICVf
 +I7cram7Llg7HWAf+NCAbpGKQDWwBn+0kKPs8VpJ9SRRVnrhxCbyuEWn/i/xY+v4P5CyRw
 nOaTAgECKPh/+QuBMWy8MZHfhDqMsBw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-588-Fy8ShID_M8Ga3VC6f05_RQ-1; Mon, 04 Sep 2023 10:37:01 -0400
X-MC-Unique: Fy8ShID_M8Ga3VC6f05_RQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C68998015AA;
 Mon,  4 Sep 2023 14:37:00 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.193.211])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 371E4493114;
 Mon,  4 Sep 2023 14:37:00 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 14/14] block: Remove unnecessary variable in
 bdrv_block_device_info
Date: Mon,  4 Sep 2023 16:36:43 +0200
Message-ID: <20230904143643.259916-15-kwolf@redhat.com>
In-Reply-To: <20230904143643.259916-1-kwolf@redhat.com>
References: <20230904143643.259916-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Fabiano Rosas <farosas@suse.de>

The commit 5d8813593f ("block/qapi: Let bdrv_query_image_info()
recurse") removed the loop where we set the 'bs0' variable, so now it
is just the same as 'bs'.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20230901184605.32260-3-farosas@suse.de>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qapi.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/block/qapi.c b/block/qapi.c
index 79bf80c503..1cbb0935ff 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -48,7 +48,7 @@ BlockDeviceInfo *bdrv_block_device_info(BlockBackend *blk,
 {
     ImageInfo **p_image_info;
     ImageInfo *backing_info;
-    BlockDriverState *bs0, *backing;
+    BlockDriverState *backing;
     BlockDeviceInfo *info;
     ERRP_GUARD();
 
@@ -145,7 +145,6 @@ BlockDeviceInfo *bdrv_block_device_info(BlockBackend *blk,
 
     info->write_threshold = bdrv_write_threshold_get(bs);
 
-    bs0 = bs;
     p_image_info = &info->image;
     info->backing_file_depth = 0;
 
@@ -153,7 +152,7 @@ BlockDeviceInfo *bdrv_block_device_info(BlockBackend *blk,
      * Skip automatically inserted nodes that the user isn't aware of for
      * query-block (blk != NULL), but not for query-named-block-nodes
      */
-    bdrv_query_image_info(bs0, p_image_info, flat, blk != NULL, errp);
+    bdrv_query_image_info(bs, p_image_info, flat, blk != NULL, errp);
     if (*errp) {
         qapi_free_BlockDeviceInfo(info);
         return NULL;
-- 
2.41.0


