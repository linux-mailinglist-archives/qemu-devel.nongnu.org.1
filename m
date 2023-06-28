Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C5FC47413D9
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 16:34:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEWDz-0002Co-Gw; Wed, 28 Jun 2023 10:32:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qEWDx-0002Bj-D3
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 10:32:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qEWDv-0003aD-Ki
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 10:32:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687962766;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3j+hhTptTggf5J+DDhyLyXHSjXAxspgBKeAwWKCpJHo=;
 b=ARQD5Xi1HPEwq2q/KhOqlMFj7zvkyNZs1DsV8xtSQcY4DSQzqDyU/BdAQdRbL///57IuKp
 b47GpSsaq6UOoLn93n3WaYY0sqzLO301QpRxI9jtdWGSKge02P02zDIrFDd9m8hxYUh7vW
 OuzwWLlPkNxxLKip8ufmwnH3ztah7xk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-611-X4yJAGupPwiy2bQKHQs8ug-1; Wed, 28 Jun 2023 10:32:38 -0400
X-MC-Unique: X4yJAGupPwiy2bQKHQs8ug-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EAD2A3C11A29;
 Wed, 28 Jun 2023 14:15:57 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.195.21])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 442AF40C2063;
 Wed, 28 Jun 2023 14:15:57 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 18/23] dmg: mark more functions as coroutine_fns and
 GRAPH_RDLOCK
Date: Wed, 28 Jun 2023 16:15:21 +0200
Message-ID: <20230628141526.293104-19-kwolf@redhat.com>
In-Reply-To: <20230628141526.293104-1-kwolf@redhat.com>
References: <20230628141526.293104-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Paolo Bonzini <pbonzini@redhat.com>

Mark functions as coroutine_fn when they are only called by other coroutine_fns
and they can suspend.  Change calls to co_wrappers to use the non-wrapped
functions, which in turn requires adding GRAPH_RDLOCK annotations.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20230601115145.196465-8-pbonzini@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/dmg.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/block/dmg.c b/block/dmg.c
index 2769900359..06a0244a9c 100644
--- a/block/dmg.c
+++ b/block/dmg.c
@@ -616,7 +616,8 @@ err:
     return s->n_chunks; /* error */
 }
 
-static inline int dmg_read_chunk(BlockDriverState *bs, uint64_t sector_num)
+static int coroutine_fn GRAPH_RDLOCK
+dmg_read_chunk(BlockDriverState *bs, uint64_t sector_num)
 {
     BDRVDMGState *s = bs->opaque;
 
@@ -633,8 +634,8 @@ static inline int dmg_read_chunk(BlockDriverState *bs, uint64_t sector_num)
         case UDZO: { /* zlib compressed */
             /* we need to buffer, because only the chunk as whole can be
              * inflated. */
-            ret = bdrv_pread(bs->file, s->offsets[chunk], s->lengths[chunk],
-                             s->compressed_chunk, 0);
+            ret = bdrv_co_pread(bs->file, s->offsets[chunk], s->lengths[chunk],
+                                s->compressed_chunk, 0);
             if (ret < 0) {
                 return -1;
             }
@@ -659,8 +660,8 @@ static inline int dmg_read_chunk(BlockDriverState *bs, uint64_t sector_num)
             }
             /* we need to buffer, because only the chunk as whole can be
              * inflated. */
-            ret = bdrv_pread(bs->file, s->offsets[chunk], s->lengths[chunk],
-                             s->compressed_chunk, 0);
+            ret = bdrv_co_pread(bs->file, s->offsets[chunk], s->lengths[chunk],
+                                s->compressed_chunk, 0);
             if (ret < 0) {
                 return -1;
             }
@@ -680,8 +681,8 @@ static inline int dmg_read_chunk(BlockDriverState *bs, uint64_t sector_num)
             }
             /* we need to buffer, because only the chunk as whole can be
              * inflated. */
-            ret = bdrv_pread(bs->file, s->offsets[chunk], s->lengths[chunk],
-                             s->compressed_chunk, 0);
+            ret = bdrv_co_pread(bs->file, s->offsets[chunk], s->lengths[chunk],
+                                s->compressed_chunk, 0);
             if (ret < 0) {
                 return -1;
             }
@@ -696,8 +697,8 @@ static inline int dmg_read_chunk(BlockDriverState *bs, uint64_t sector_num)
             }
             break;
         case UDRW: /* copy */
-            ret = bdrv_pread(bs->file, s->offsets[chunk], s->lengths[chunk],
-                             s->uncompressed_chunk, 0);
+            ret = bdrv_co_pread(bs->file, s->offsets[chunk], s->lengths[chunk],
+                                s->uncompressed_chunk, 0);
             if (ret < 0) {
                 return -1;
             }
@@ -713,7 +714,7 @@ static inline int dmg_read_chunk(BlockDriverState *bs, uint64_t sector_num)
     return 0;
 }
 
-static int coroutine_fn
+static int coroutine_fn GRAPH_RDLOCK
 dmg_co_preadv(BlockDriverState *bs, int64_t offset, int64_t bytes,
               QEMUIOVector *qiov, BdrvRequestFlags flags)
 {
-- 
2.41.0


