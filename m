Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B85CA78F9E3
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 10:20:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbzNL-0000Lz-43; Fri, 01 Sep 2023 04:19:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qbzNJ-0000Ay-LY
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 04:19:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qbzNH-0001am-EO
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 04:19:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693556366;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ajkJ7QSSCOj7ltrUUZQo6v4aiLvqSb48FZH/P3w+vs0=;
 b=h18pPTwuWQetTb4TNyd8NI3RI8NevrHpELhjFFuheddG5DrYoafaQBuiomNJ4dVB7QXeSb
 Fma+5ALYpZvW2FiEx6AKluJuvisP0MWwB67RZ8oz1BOJ7jWj5aK0FFa2V8hmn3bxI+A0bW
 1qVWYkphUfJo2O+5OeWwxL7baK4L+Oc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-290-7pc9AkHNMpGrVrNy-vAtxw-1; Fri, 01 Sep 2023 04:19:25 -0400
X-MC-Unique: 7pc9AkHNMpGrVrNy-vAtxw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0E41C800303;
 Fri,  1 Sep 2023 08:19:25 +0000 (UTC)
Received: from localhost (unknown [10.39.194.146])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B2F11140E96E;
 Fri,  1 Sep 2023 08:19:24 +0000 (UTC)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 qemu-stable@nongnu.org
Subject: [PULL 10/14] file-posix: Clear bs->bl.zoned on error
Date: Fri,  1 Sep 2023 10:19:19 +0200
Message-ID: <20230901081923.31894-1-hreitz@redhat.com>
In-Reply-To: <20230901081804.31377-1-hreitz@redhat.com>
References: <20230901081804.31377-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

bs->bl.zoned is what indicates whether the zone information is present
and valid; it is the only thing that raw_refresh_zoned_limits() sets if
CONFIG_BLKZONED is not defined, and it is also the only thing that it
sets if CONFIG_BLKZONED is defined, but there are no zones.

Make sure that it is always set to BLK_Z_NONE if there is an error
anywhere in raw_refresh_zoned_limits() so that we do not accidentally
announce zones while our information is incomplete or invalid.

This also fixes a memory leak in the last error path in
raw_refresh_zoned_limits().

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
Message-Id: <20230824155345.109765-2-hreitz@redhat.com>
Reviewed-by: Sam Li <faithilikerun@gmail.com>
---
 block/file-posix.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index b16e9c21a1..2b88b9eefa 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1412,11 +1412,9 @@ static void raw_refresh_zoned_limits(BlockDriverState *bs, struct stat *st,
     BlockZoneModel zoned;
     int ret;
 
-    bs->bl.zoned = BLK_Z_NONE;
-
     ret = get_sysfs_zoned_model(st, &zoned);
     if (ret < 0 || zoned == BLK_Z_NONE) {
-        return;
+        goto no_zoned;
     }
     bs->bl.zoned = zoned;
 
@@ -1437,10 +1435,10 @@ static void raw_refresh_zoned_limits(BlockDriverState *bs, struct stat *st,
     if (ret < 0) {
         error_setg_errno(errp, -ret, "Unable to read chunk_sectors "
                                      "sysfs attribute");
-        return;
+        goto no_zoned;
     } else if (!ret) {
         error_setg(errp, "Read 0 from chunk_sectors sysfs attribute");
-        return;
+        goto no_zoned;
     }
     bs->bl.zone_size = ret << BDRV_SECTOR_BITS;
 
@@ -1448,10 +1446,10 @@ static void raw_refresh_zoned_limits(BlockDriverState *bs, struct stat *st,
     if (ret < 0) {
         error_setg_errno(errp, -ret, "Unable to read nr_zones "
                                      "sysfs attribute");
-        return;
+        goto no_zoned;
     } else if (!ret) {
         error_setg(errp, "Read 0 from nr_zones sysfs attribute");
-        return;
+        goto no_zoned;
     }
     bs->bl.nr_zones = ret;
 
@@ -1472,10 +1470,15 @@ static void raw_refresh_zoned_limits(BlockDriverState *bs, struct stat *st,
     ret = get_zones_wp(bs, s->fd, 0, bs->bl.nr_zones, 0);
     if (ret < 0) {
         error_setg_errno(errp, -ret, "report wps failed");
-        bs->wps = NULL;
-        return;
+        goto no_zoned;
     }
     qemu_co_mutex_init(&bs->wps->colock);
+    return;
+
+no_zoned:
+    bs->bl.zoned = BLK_Z_NONE;
+    g_free(bs->wps);
+    bs->wps = NULL;
 }
 #else /* !defined(CONFIG_BLKZONED) */
 static void raw_refresh_zoned_limits(BlockDriverState *bs, struct stat *st,
-- 
2.41.0


