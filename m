Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F11719B3D
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 13:53:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4gqJ-0008Di-9D; Thu, 01 Jun 2023 07:51:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q4gqG-00087U-It
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 07:51:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q4gqE-0000Fj-Pg
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 07:51:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685620302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f1UBhFw34ApEps/B/fnqpGUx59SAnlUvm0IN7PFtPoA=;
 b=YldsEvPoplUOeE6DHqTBMlbgsGBdEGWGLAvDqlev7njgh2O68LO9X292f1XmXJJkDmfhce
 0Z3oAdIxvqlXx5OyIGXbBFyhVXFYmTXOQ7GBH/hTLUtLvtmxRxzcPVdmBaSm0B19tLjlEx
 oUZMtq6Te+zhEJSKi5MjsNXlcgK7Wdg=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-DcD6s_cANpKwoJ-bI5N7pA-1; Thu, 01 Jun 2023 07:51:41 -0400
X-MC-Unique: DcD6s_cANpKwoJ-bI5N7pA-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-9715654ab36so51570566b.0
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 04:51:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685620299; x=1688212299;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f1UBhFw34ApEps/B/fnqpGUx59SAnlUvm0IN7PFtPoA=;
 b=TuUOh1q7cjgmq/Uq15qaLdHbtur5I8XV5zGluPsjNSKJQKGBtBBSyg2ZEiFqZRsnn2
 +GsOZdYd5T3l6b1JdRWMMvp1mmh13+Kv2EBr/AxwPIwgEs9TXGLYmBUgvs5QuZ0q+DPg
 X90+MkFTF/9EYpvgj2zc4necgqKD53stNxXs+JGrQLjcXPwLwK25C+UJmDLYrgpETERf
 iochNptOzGO1aOfzoj2zvsP5SAFgpbew7k/+kg6qy0BSMmaLUvSsB0cjeU/i+X7LF7LN
 kshfwneDRw6vWb1fxysekx2W/0T9DaHKiZaGUUf1h9gO+y+vP3Vzp+S2W/L7epIqgUnr
 q81w==
X-Gm-Message-State: AC+VfDy8gwLnONhAe1NJRMpj0L8Hl4JyEFrB21QaPjY8RTlnpIuWxHAI
 BE8gXn+DMf3TGB6TCmBzmfNkYsh9EYDyDec7cXJ9s82oMy9CSdAKbSTJqGIYBBhpBBpCRFpiX2I
 w1yADy4pwKeGV8BTC6VPx0wRILtmu0/dSdbDb26o6HXXM7j6yxxjm/rEW7E2+PIv/jpghvS+Anr
 Q=
X-Received: by 2002:a17:907:7d9f:b0:974:1c92:a7aa with SMTP id
 oz31-20020a1709077d9f00b009741c92a7aamr6919767ejc.5.1685620299361; 
 Thu, 01 Jun 2023 04:51:39 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5WKuMh+Vs6vfSJM0DlEW+/hzmT+yeNFwP1vFpiTMUFYKdckm/evOKTQT2c2KMPKDsqRCLzMA==
X-Received: by 2002:a17:907:7d9f:b0:974:1c92:a7aa with SMTP id
 oz31-20020a1709077d9f00b009741c92a7aamr6919754ejc.5.1685620299061; 
 Thu, 01 Jun 2023 04:51:39 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 kq12-20020a170906abcc00b009596e7e0dbasm10446252ejb.162.2023.06.01.04.51.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jun 2023 04:51:38 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com,
	qemu-block@nongnu.org,
	Eric Blake <eblake@redhat.com>
Subject: [PATCH v2 4/4] block: convert more bdrv_is_allocated* and
 bdrv_block_status* calls to coroutine versions
Date: Thu,  1 Jun 2023 13:51:31 +0200
Message-Id: <20230601115131.196234-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601115131.196234-1-pbonzini@redhat.com>
References: <20230601115131.196234-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/copy-before-write.c |  2 +-
 block/copy-on-read.c      |  8 ++++----
 block/io.c                |  6 +++---
 block/mirror.c            | 10 +++++-----
 block/qcow2.c             |  5 +++--
 block/replication.c       |  8 ++++----
 block/stream.c            |  8 ++++----
 block/vvfat.c             | 18 +++++++++---------
 8 files changed, 33 insertions(+), 32 deletions(-)

diff --git a/block/copy-before-write.c b/block/copy-before-write.c
index b866e42271d0..2711d95718f7 100644
--- a/block/copy-before-write.c
+++ b/block/copy-before-write.c
@@ -305,7 +305,7 @@ cbw_co_snapshot_block_status(BlockDriverState *bs,
         return -EACCES;
     }
 
-    ret = bdrv_block_status(child->bs, offset, cur_bytes, pnum, map, file);
+    ret = bdrv_co_block_status(child->bs, offset, cur_bytes, pnum, map, file);
     if (child == s->target) {
         /*
          * We refer to s->target only for areas that we've written to it.
diff --git a/block/copy-on-read.c b/block/copy-on-read.c
index b4d6b7efc30f..5149fcf63adc 100644
--- a/block/copy-on-read.c
+++ b/block/copy-on-read.c
@@ -146,11 +146,11 @@ cor_co_preadv_part(BlockDriverState *bs, int64_t offset, int64_t bytes,
         local_flags = flags;
 
         /* In case of failure, try to copy-on-read anyway */
-        ret = bdrv_is_allocated(bs->file->bs, offset, bytes, &n);
+        ret = bdrv_co_is_allocated(bs->file->bs, offset, bytes, &n);
         if (ret <= 0) {
-            ret = bdrv_is_allocated_above(bdrv_backing_chain_next(bs->file->bs),
-                                          state->bottom_bs, true, offset,
-                                          n, &n);
+            ret = bdrv_co_is_allocated_above(bdrv_backing_chain_next(bs->file->bs),
+                                             state->bottom_bs, true, offset,
+                                             n, &n);
             if (ret > 0 || ret < 0) {
                 local_flags |= BDRV_REQ_COPY_ON_READ;
             }
diff --git a/block/io.c b/block/io.c
index 2fae64ad1eb6..3bd4c7de97f0 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1216,8 +1216,8 @@ bdrv_co_do_copy_on_readv(BdrvChild *child, int64_t offset, int64_t bytes,
             ret = 1; /* "already allocated", so nothing will be copied */
             pnum = MIN(cluster_bytes, max_transfer);
         } else {
-            ret = bdrv_is_allocated(bs, cluster_offset,
-                                    MIN(cluster_bytes, max_transfer), &pnum);
+            ret = bdrv_co_is_allocated(bs, cluster_offset,
+                                       MIN(cluster_bytes, max_transfer), &pnum);
             if (ret < 0) {
                 /*
                  * Safe to treat errors in querying allocation as if
@@ -1364,7 +1364,7 @@ bdrv_aligned_preadv(BdrvChild *child, BdrvTrackedRequest *req,
         /* The flag BDRV_REQ_COPY_ON_READ has reached its addressee */
         flags &= ~BDRV_REQ_COPY_ON_READ;
 
-        ret = bdrv_is_allocated(bs, offset, bytes, &pnum);
+        ret = bdrv_co_is_allocated(bs, offset, bytes, &pnum);
         if (ret < 0) {
             goto out;
         }
diff --git a/block/mirror.c b/block/mirror.c
index d3cacd170860..c0f40e696072 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -559,9 +559,9 @@ static void coroutine_fn mirror_iteration(MirrorBlockJob *s)
 
         assert(!(offset % s->granularity));
         WITH_GRAPH_RDLOCK_GUARD() {
-            ret = bdrv_block_status_above(source, NULL, offset,
-                                        nb_chunks * s->granularity,
-                                        &io_bytes, NULL, NULL);
+            ret = bdrv_co_block_status_above(source, NULL, offset,
+                                             nb_chunks * s->granularity,
+                                             &io_bytes, NULL, NULL);
         }
         if (ret < 0) {
             io_bytes = MIN(nb_chunks * s->granularity, max_io_bytes);
@@ -875,8 +875,8 @@ static int coroutine_fn mirror_dirty_init(MirrorBlockJob *s)
         }
 
         WITH_GRAPH_RDLOCK_GUARD() {
-            ret = bdrv_is_allocated_above(bs, s->base_overlay, true, offset,
-                                          bytes, &count);
+            ret = bdrv_co_is_allocated_above(bs, s->base_overlay, true, offset,
+                                             bytes, &count);
         }
         if (ret < 0) {
             return ret;
diff --git a/block/qcow2.c b/block/qcow2.c
index 7f3948360d05..5a27740223b4 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3968,7 +3968,8 @@ finish:
 }
 
 
-static bool is_zero(BlockDriverState *bs, int64_t offset, int64_t bytes)
+static bool coroutine_fn GRAPH_RDLOCK
+is_zero(BlockDriverState *bs, int64_t offset, int64_t bytes)
 {
     int64_t nr;
     int res;
@@ -3989,7 +3990,7 @@ static bool is_zero(BlockDriverState *bs, int64_t offset, int64_t bytes)
      * backing file. So, we need a loop.
      */
     do {
-        res = bdrv_block_status_above(bs, NULL, offset, bytes, &nr, NULL, NULL);
+        res = bdrv_co_block_status_above(bs, NULL, offset, bytes, &nr, NULL, NULL);
         offset += nr;
         bytes -= nr;
     } while (res >= 0 && (res & BDRV_BLOCK_ZERO) && nr && bytes);
diff --git a/block/replication.c b/block/replication.c
index ea4bf1aa8012..f44b2631ae00 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -276,10 +276,10 @@ replication_co_writev(BlockDriverState *bs, int64_t sector_num,
     while (remaining_sectors > 0) {
         int64_t count;
 
-        ret = bdrv_is_allocated_above(top->bs, base->bs, false,
-                                      sector_num * BDRV_SECTOR_SIZE,
-                                      remaining_sectors * BDRV_SECTOR_SIZE,
-                                      &count);
+        ret = bdrv_co_is_allocated_above(top->bs, base->bs, false,
+                                         sector_num * BDRV_SECTOR_SIZE,
+                                         remaining_sectors * BDRV_SECTOR_SIZE,
+                                         &count);
         if (ret < 0) {
             goto out1;
         }
diff --git a/block/stream.c b/block/stream.c
index e522bbdec547..f0ef58c8997b 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -162,7 +162,7 @@ static int coroutine_fn stream_run(Job *job, Error **errp)
         copy = false;
 
         WITH_GRAPH_RDLOCK_GUARD() {
-            ret = bdrv_is_allocated(unfiltered_bs, offset, STREAM_CHUNK, &n);
+            ret = bdrv_co_is_allocated(unfiltered_bs, offset, STREAM_CHUNK, &n);
             if (ret == 1) {
                 /* Allocated in the top, no need to copy.  */
             } else if (ret >= 0) {
@@ -170,9 +170,9 @@ static int coroutine_fn stream_run(Job *job, Error **errp)
                  * Copy if allocated in the intermediate images.  Limit to the
                  * known-unallocated area [offset, offset+n*BDRV_SECTOR_SIZE).
                  */
-                ret = bdrv_is_allocated_above(bdrv_cow_bs(unfiltered_bs),
-                                            s->base_overlay, true,
-                                            offset, n, &n);
+                ret = bdrv_co_is_allocated_above(bdrv_cow_bs(unfiltered_bs),
+                                                 s->base_overlay, true,
+                                                 offset, n, &n);
                 /* Finish early if end of backing file has been reached */
                 if (ret == 0 && n == 0) {
                     n = len - offset;
diff --git a/block/vvfat.c b/block/vvfat.c
index 0ddc91fc096a..5df2d6b1c64d 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -1481,8 +1481,8 @@ vvfat_read(BlockDriverState *bs, int64_t sector_num, uint8_t *buf, int nb_sector
         if (s->qcow) {
             int64_t n;
             int ret;
-            ret = bdrv_is_allocated(s->qcow->bs, sector_num * BDRV_SECTOR_SIZE,
-                                    (nb_sectors - i) * BDRV_SECTOR_SIZE, &n);
+            ret = bdrv_co_is_allocated(s->qcow->bs, sector_num * BDRV_SECTOR_SIZE,
+                                       (nb_sectors - i) * BDRV_SECTOR_SIZE, &n);
             if (ret < 0) {
                 return ret;
             }
@@ -1807,10 +1807,10 @@ cluster_was_modified(BDRVVVFATState *s, uint32_t cluster_num)
     }
 
     for (i = 0; !was_modified && i < s->sectors_per_cluster; i++) {
-        was_modified = bdrv_is_allocated(s->qcow->bs,
-                                         (cluster2sector(s, cluster_num) +
-                                          i) * BDRV_SECTOR_SIZE,
-                                         BDRV_SECTOR_SIZE, NULL);
+        was_modified = bdrv_co_is_allocated(s->qcow->bs,
+                                            (cluster2sector(s, cluster_num) +
+                                             i) * BDRV_SECTOR_SIZE,
+                                            BDRV_SECTOR_SIZE, NULL);
     }
 
     /*
@@ -1968,9 +1968,9 @@ get_cluster_count_for_direntry(BDRVVVFATState* s, direntry_t* direntry, const ch
                 for (i = 0; i < s->sectors_per_cluster; i++) {
                     int res;
 
-                    res = bdrv_is_allocated(s->qcow->bs,
-                                            (offset + i) * BDRV_SECTOR_SIZE,
-                                            BDRV_SECTOR_SIZE, NULL);
+                    res = bdrv_co_is_allocated(s->qcow->bs,
+                                               (offset + i) * BDRV_SECTOR_SIZE,
+                                               BDRV_SECTOR_SIZE, NULL);
                     if (res < 0) {
                         return -1;
                     }
-- 
2.40.1


