Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D9E719B4F
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 13:56:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4gqq-0001To-81; Thu, 01 Jun 2023 07:52:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q4gqi-0001Oi-IP
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 07:52:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q4gqf-0000OU-9A
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 07:52:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685620328;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=swRLIgFHvUeySROi5KlkYuivHMcmETHAy6qF2wWS6zw=;
 b=XglNizX+fEn3s0gaiuQsJeQBv/2fOy+b1VzXZonRMMviOYmSUdtaBCCbnnWcYqoPfHQWG4
 O9dEQIvqrBYDiogIeebWvAKX6EA38kQbezE7B9X0SIbUA/wyN34GLSNxJCYqDIDqJUnl6u
 Ruodt+mReQ1PjEXbgUjEjSA4jbsgSPM=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-456-nNmgzhnvNN6gzSEjKrpI2Q-1; Thu, 01 Jun 2023 07:52:07 -0400
X-MC-Unique: nNmgzhnvNN6gzSEjKrpI2Q-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-94a34e35f57so52148366b.3
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 04:52:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685620325; x=1688212325;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=swRLIgFHvUeySROi5KlkYuivHMcmETHAy6qF2wWS6zw=;
 b=aKDXA+gf/RO2swgC0ZZKWhGQQr0ByvBF9pmjUaIu2McHA2WsRxEDbvMOUltVRsqOmH
 XWEqPx2P0r8xyMuF2k5bLRv/ASjp+fVm9FIKt68WdQQc7NKaG8WEmIMk0yG4lfmFFWgI
 P/WGv0f8ED+AYpn/vi8UKVLtSICu8n+DlTw+MEo3m2HZXn/9E4SeoQYy6KgabIcbiZrM
 ggzE4GPItWdCzMDjLPkMT4fX+AJaYH7ZxPzVY9gSt9rq7V+s21p3LBywNKOweZfbgo5t
 IJFk8UV5bhxgp317WczgaRBn7scNSOmKw1+/Fh6rCmYW36/T1pVS9djqNd9ubmM4T5lp
 1YEQ==
X-Gm-Message-State: AC+VfDwxmK5MTjS2SoDE8dlS+D+saiL+ebAEOft8owNAnb6rKs3Brk2M
 Da0CrA5WtORxvZtKFQJivUYsPMoOSr5CdCbutzJ2DVHuZAQzEs8AHaxst/eXRa9VB3cnBgx+Pej
 x4dcKY7on9jQLH0beMMX330/GIRTNgNmylUEwRKwW3Oa5IO7aLuhqDVAke5nAfsPwuMBtf7wifS
 w=
X-Received: by 2002:a17:907:7d94:b0:973:e184:e0fd with SMTP id
 oz20-20020a1709077d9400b00973e184e0fdmr7835792ejc.70.1685620325143; 
 Thu, 01 Jun 2023 04:52:05 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ41wcrSGeGkervzkn+/Ykp+mclNstKeKgXfLzExigOohsJJVB3df2KQ9+PWH9ZFz3txLXtxOQ==
X-Received: by 2002:a17:907:7d94:b0:973:e184:e0fd with SMTP id
 oz20-20020a1709077d9400b00973e184e0fdmr7835772ejc.70.1685620324835; 
 Thu, 01 Jun 2023 04:52:04 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 j23-20020a17090643d700b0095850aef138sm10473906ejn.6.2023.06.01.04.52.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jun 2023 04:52:04 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com,
	qemu-block@nongnu.org
Subject: [PATCH 11/12] block: use bdrv_co_getlength in coroutine context
Date: Thu,  1 Jun 2023 13:51:44 +0200
Message-Id: <20230601115145.196465-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601115145.196465-1-pbonzini@redhat.com>
References: <20230601115145.196465-1-pbonzini@redhat.com>
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

bdrv_co_getlength was recently introduced, with bdrv_getlength becoming
a wrapper for use in unknown context.  Switch to bdrv_co_getlength when
possible.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/io.c        | 10 +++++-----
 block/parallels.c |  4 ++--
 block/qcow.c      |  6 +++---
 block/vmdk.c      |  4 ++--
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/block/io.c b/block/io.c
index 3bd4c7de97f0..f537421ef523 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1379,7 +1379,7 @@ bdrv_aligned_preadv(BdrvChild *child, BdrvTrackedRequest *req,
     }
 
     /* Forward the request to the BlockDriver, possibly fragmenting it */
-    total_bytes = bdrv_getlength(bs);
+    total_bytes = bdrv_co_getlength(bs);
     if (total_bytes < 0) {
         ret = total_bytes;
         goto out;
@@ -2252,7 +2252,7 @@ bdrv_co_do_block_status(BlockDriverState *bs, bool want_zero,
     assert(pnum);
     assert_bdrv_graph_readable();
     *pnum = 0;
-    total_size = bdrv_getlength(bs);
+    total_size = bdrv_co_getlength(bs);
     if (total_size < 0) {
         ret = total_size;
         goto early_out;
@@ -2272,7 +2272,7 @@ bdrv_co_do_block_status(BlockDriverState *bs, bool want_zero,
         bytes = n;
     }
 
-    /* Must be non-NULL or bdrv_getlength() would have failed */
+    /* Must be non-NULL or bdrv_co_getlength() would have failed */
     assert(bs->drv);
     has_filtered_child = bdrv_filter_child(bs);
     if (!bs->drv->bdrv_co_block_status && !has_filtered_child) {
@@ -2410,7 +2410,7 @@ bdrv_co_do_block_status(BlockDriverState *bs, bool want_zero,
         if (!cow_bs) {
             ret |= BDRV_BLOCK_ZERO;
         } else if (want_zero) {
-            int64_t size2 = bdrv_getlength(cow_bs);
+            int64_t size2 = bdrv_co_getlength(cow_bs);
 
             if (size2 >= 0 && offset >= size2) {
                 ret |= BDRV_BLOCK_ZERO;
@@ -3445,7 +3445,7 @@ int coroutine_fn bdrv_co_truncate(BdrvChild *child, int64_t offset, bool exact,
         return ret;
     }
 
-    old_size = bdrv_getlength(bs);
+    old_size = bdrv_co_getlength(bs);
     if (old_size < 0) {
         error_setg_errno(errp, -old_size, "Failed to get old image size");
         return old_size;
diff --git a/block/parallels.c b/block/parallels.c
index 190406ba2e3d..91247cb157f6 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -193,7 +193,7 @@ allocate_clusters(BlockDriverState *bs, int64_t sector_num,
     assert(idx < s->bat_size && idx + to_allocate <= s->bat_size);
 
     space = to_allocate * s->tracks;
-    len = bdrv_getlength(bs->file->bs);
+    len = bdrv_co_getlength(bs->file->bs);
     if (len < 0) {
         return len;
     }
@@ -426,7 +426,7 @@ parallels_co_check(BlockDriverState *bs, BdrvCheckResult *res,
     uint32_t i;
     bool flush_bat = false;
 
-    size = bdrv_getlength(bs->file->bs);
+    size = bdrv_co_getlength(bs->file->bs);
     if (size < 0) {
         res->check_errors++;
         return size;
diff --git a/block/qcow.c b/block/qcow.c
index 823e931cea2d..4aee835e8c36 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -370,7 +370,7 @@ get_cluster_offset(BlockDriverState *bs, uint64_t offset, int allocate,
         if (!allocate)
             return 0;
         /* allocate a new l2 entry */
-        l2_offset = bdrv_getlength(bs->file->bs);
+        l2_offset = bdrv_co_getlength(bs->file->bs);
         if (l2_offset < 0) {
             return l2_offset;
         }
@@ -445,7 +445,7 @@ get_cluster_offset(BlockDriverState *bs, uint64_t offset, int allocate,
             if (decompress_cluster(bs, cluster_offset) < 0) {
                 return -EIO;
             }
-            cluster_offset = bdrv_getlength(bs->file->bs);
+            cluster_offset = bdrv_co_getlength(bs->file->bs);
             if ((int64_t) cluster_offset < 0) {
                 return cluster_offset;
             }
@@ -458,7 +458,7 @@ get_cluster_offset(BlockDriverState *bs, uint64_t offset, int allocate,
                 return ret;
             }
         } else {
-            cluster_offset = bdrv_getlength(bs->file->bs);
+            cluster_offset = bdrv_co_getlength(bs->file->bs);
             if ((int64_t) cluster_offset < 0) {
                 return cluster_offset;
             }
diff --git a/block/vmdk.c b/block/vmdk.c
index 419868a42ae2..c64f2eacc03f 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -2132,7 +2132,7 @@ vmdk_co_pwritev_compressed(BlockDriverState *bs, int64_t offset, int64_t bytes,
         int64_t length;
 
         for (i = 0; i < s->num_extents; i++) {
-            length = bdrv_getlength(s->extents[i].file->bs);
+            length = bdrv_co_getlength(s->extents[i].file->bs);
             if (length < 0) {
                 return length;
             }
@@ -2939,7 +2939,7 @@ vmdk_co_check(BlockDriverState *bs, BdrvCheckResult *result, BdrvCheckMode fix)
             break;
         }
         if (ret == VMDK_OK) {
-            int64_t extent_len = bdrv_getlength(extent->file->bs);
+            int64_t extent_len = bdrv_co_getlength(extent->file->bs);
             if (extent_len < 0) {
                 fprintf(stderr,
                         "ERROR: could not get extent file length for sector %"
-- 
2.40.1


