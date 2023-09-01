Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6891578F9D2
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 10:19:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbzNS-0001BX-56; Fri, 01 Sep 2023 04:19:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qbzNQ-00018w-DP
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 04:19:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qbzNL-0001bw-26
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 04:19:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693556370;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dHku117QqRyf7FRE7NtEVqkqrLmJCrstkiHX3CC9xrY=;
 b=SNL3RevaEdYpDLuByJGFXe0modpa+YOhaaI6RLObETdtFxG+AMZpo82xB2agE+AizuVKds
 7HjAsOZEjqQlYfKFRBN53XPXjZQvCS7cKEfbmRmiO8IhEInMxLlbFVliTm1WMd2ea8jPdP
 y7xsf6oY112rPqcuINX6xliagkPb9tQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-336-8XxRZe7gP-aiqQaeUCtgQw-1; Fri, 01 Sep 2023 04:19:27 -0400
X-MC-Unique: 8XxRZe7gP-aiqQaeUCtgQw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E358A2999B3A;
 Fri,  1 Sep 2023 08:19:26 +0000 (UTC)
Received: from localhost (unknown [10.39.194.146])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A541963F7A;
 Fri,  1 Sep 2023 08:19:26 +0000 (UTC)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 qemu-stable@nongnu.org
Subject: [PULL 11/14] file-posix: Check bs->bl.zoned for zone info
Date: Fri,  1 Sep 2023 10:19:20 +0200
Message-ID: <20230901081923.31894-2-hreitz@redhat.com>
In-Reply-To: <20230901081804.31377-1-hreitz@redhat.com>
References: <20230901081804.31377-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
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
Message-Id: <20230824155345.109765-3-hreitz@redhat.com>
Reviewed-by: Sam Li <faithilikerun@gmail.com>
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


