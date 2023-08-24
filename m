Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE0B7874A5
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 17:54:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZCel-0000hZ-Ep; Thu, 24 Aug 2023 11:53:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qZCej-0000gA-8g
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 11:53:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qZCeh-0007iz-5Y
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 11:53:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692892434;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b7Xua2Lk+aSIMgufvg61qfBjy9eIpooltJ+fwTb6Oqw=;
 b=HcLSw4IGsrOxl8kECII4quey3ZX53SgT8uXCxKCo6LmTVZakM5lPviUQ9iAkmVdtjBfFxS
 M2ky9oVOGMJKz8U8FwxvyYo9XL9wfMkoXRz3QvSSwoR7KLOsHwdMMKlLUR24jRNFdKqIaM
 2yTRnz+gzxjjv9YZMjb8qPDVx9XUw9s=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-382-Q6OyxnIJMDeJC1OyCD7S6Q-1; Thu, 24 Aug 2023 11:53:50 -0400
X-MC-Unique: Q6OyxnIJMDeJC1OyCD7S6Q-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D499E3C0F68E;
 Thu, 24 Aug 2023 15:53:49 +0000 (UTC)
Received: from localhost (unknown [10.39.193.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 83E6740282C;
 Thu, 24 Aug 2023 15:53:49 +0000 (UTC)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Sam Li <faithilikerun@gmail.com>
Subject: [PATCH 2/5] file-posix: Check bs->bl.zoned for zone info
Date: Thu, 24 Aug 2023 17:53:41 +0200
Message-ID: <20230824155345.109765-3-hreitz@redhat.com>
In-Reply-To: <20230824155345.109765-1-hreitz@redhat.com>
References: <20230824155345.109765-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
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

Instead of checking bs->wps or bs->bl.zone_size for whether zone
information is present, check bs->bl.zoned.  That is the flag that
raw_refresh_zoned_limits() reliably sets to indicate zone support.  If
it is set to something other than BLK_Z_NONE, other values and objects
like bs->wps and bs->bl.zone_size must be non-null/zero and valid; if it
is not, we cannot rely on their validity.

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/file-posix.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 2b88b9eefa..46e22403fe 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -2455,9 +2455,10 @@ static int coroutine_fn raw_co_prw(BlockDriverState *bs, uint64_t offset,
     if (fd_open(bs) < 0)
         return -EIO;
 #if defined(CONFIG_BLKZONED)
-    if ((type & (QEMU_AIO_WRITE | QEMU_AIO_ZONE_APPEND)) && bs->wps) {
+    if ((type & (QEMU_AIO_WRITE | QEMU_AIO_ZONE_APPEND)) &&
+        bs->bl.zoned != BLK_Z_NONE) {
         qemu_co_mutex_lock(&bs->wps->colock);
-        if (type & QEMU_AIO_ZONE_APPEND && bs->bl.zone_size) {
+        if (type & QEMU_AIO_ZONE_APPEND) {
             int index = offset / bs->bl.zone_size;
             offset = bs->wps->wp[index];
         }
@@ -2508,8 +2509,8 @@ out:
 {
     BlockZoneWps *wps = bs->wps;
     if (ret == 0) {
-        if ((type & (QEMU_AIO_WRITE | QEMU_AIO_ZONE_APPEND))
-            && wps && bs->bl.zone_size) {
+        if ((type & (QEMU_AIO_WRITE | QEMU_AIO_ZONE_APPEND)) &&
+            bs->bl.zoned != BLK_Z_NONE) {
             uint64_t *wp = &wps->wp[offset / bs->bl.zone_size];
             if (!BDRV_ZT_IS_CONV(*wp)) {
                 if (type & QEMU_AIO_ZONE_APPEND) {
@@ -2529,7 +2530,8 @@ out:
         }
     }
 
-    if ((type & (QEMU_AIO_WRITE | QEMU_AIO_ZONE_APPEND)) && wps) {
+    if ((type & (QEMU_AIO_WRITE | QEMU_AIO_ZONE_APPEND)) &&
+        bs->blk.zoned != BLK_Z_NONE) {
         qemu_co_mutex_unlock(&wps->colock);
     }
 }
-- 
2.41.0


