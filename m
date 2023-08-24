Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 060847874A3
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 17:54:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZCeh-0000et-RN; Thu, 24 Aug 2023 11:53:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qZCef-0000eL-Ld
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 11:53:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qZCed-0007hv-Eu
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 11:53:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692892430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jwVV5TePIHkoFIpzaWOERMFTI2IIumj97EfBAgYurRU=;
 b=c60C8w1Lm41E8SqPNNg0Fzjn1P4fWtICx4ABGHj82+mAuc1U+jTbNC6pvcg9XBRAoBELiS
 mzF87Gv9W84zxqGwP9wKcvuGSaLCTHnZzFrXwVfCyO9kURH1h8hlNvNBwFhSOgiilhedkL
 rhMJBIQVgtXfPESoNHxpulXOkwg3Pa4=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-237-yyJSG7tLMdGknbkLZ6miRg-1; Thu, 24 Aug 2023 11:53:48 -0400
X-MC-Unique: yyJSG7tLMdGknbkLZ6miRg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4FE8829AB3E1;
 Thu, 24 Aug 2023 15:53:48 +0000 (UTC)
Received: from localhost (unknown [10.39.193.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 01060112131B;
 Thu, 24 Aug 2023 15:53:47 +0000 (UTC)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Sam Li <faithilikerun@gmail.com>
Subject: [PATCH 1/5] file-posix: Clear bs->bl.zoned on error
Date: Thu, 24 Aug 2023 17:53:40 +0200
Message-ID: <20230824155345.109765-2-hreitz@redhat.com>
In-Reply-To: <20230824155345.109765-1-hreitz@redhat.com>
References: <20230824155345.109765-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
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


