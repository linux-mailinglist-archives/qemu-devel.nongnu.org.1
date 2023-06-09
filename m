Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B854729344
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 10:34:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7XYp-0006gD-9w; Fri, 09 Jun 2023 04:33:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1q7XYl-0006fK-A0
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 04:33:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1q7XYg-0001as-JG
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 04:33:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686299601;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=LUXLXSIWCQiyBkWDzd6UH+EOhCZYuSba0DY96TgXjLs=;
 b=EcEskdzWSfUA+vWZnjWUHJeKKuETLJbTWSC4luy0rLgFIJxe1O8D05Hr/qw7t2XJlhnjre
 NDhWxC6aqFIJ9UdVNkgGVjBV/xvkfSxldRFvFwnkHKULo4TGnnL830T5W+RyAuhWrfhROw
 5FLMNp1lbnngXDhOp+Or3kTA5sY2SEo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-57-T9NCRVhTOGmrfCx5DFMY2A-1; Fri, 09 Jun 2023 04:33:18 -0400
X-MC-Unique: T9NCRVhTOGmrfCx5DFMY2A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 14558384CC64;
 Fri,  9 Jun 2023 08:33:18 +0000 (UTC)
Received: from localhost (unknown [10.39.193.251])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BADEE40C1282;
 Fri,  9 Jun 2023 08:33:17 +0000 (UTC)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH] block: Fix pad_request's request restriction
Date: Fri,  9 Jun 2023 10:33:16 +0200
Message-Id: <20230609083316.24629-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

bdrv_pad_request() relies on requests' lengths not to exceed SIZE_MAX,
which bdrv_check_qiov_request() does not guarantee.

bdrv_check_request32() however will guarantee this, and both of
bdrv_pad_request()'s callers (bdrv_co_preadv_part() and
bdrv_co_pwritev_part()) already run it before calling
bdrv_pad_request().  Therefore, bdrv_pad_request() can safely call
bdrv_check_request32() without expecting error, too.

There is one difference between bdrv_check_qiov_request() and
bdrv_check_request32(): The former takes an errp, the latter does not,
so we can no longer just pass &error_abort.  Instead, we need to check
the returned value.  While we do expect success (because the callers
have already run this function), an assert(ret == 0) is not much simpler
than just to return an error if it occurs, so let us handle errors by
returning them up the stack now.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Fixes: 18743311b829cafc1737a5f20bc3248d5f91ee2a
       ("block: Collapse padded I/O vecs exceeding IOV_MAX")
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/io.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/block/io.c b/block/io.c
index 30748f0b59..e43b4ad09b 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1710,7 +1710,11 @@ static int bdrv_pad_request(BlockDriverState *bs,
     int sliced_niov;
     size_t sliced_head, sliced_tail;
 
-    bdrv_check_qiov_request(*offset, *bytes, *qiov, *qiov_offset, &error_abort);
+    /* Should have been checked by the caller already */
+    ret = bdrv_check_request32(*offset, *bytes, *qiov, *qiov_offset);
+    if (ret < 0) {
+        return ret;
+    }
 
     if (!bdrv_init_padding(bs, *offset, *bytes, write, pad)) {
         if (padded) {
@@ -1723,7 +1727,7 @@ static int bdrv_pad_request(BlockDriverState *bs,
                                   &sliced_head, &sliced_tail,
                                   &sliced_niov);
 
-    /* Guaranteed by bdrv_check_qiov_request() */
+    /* Guaranteed by bdrv_check_request32() */
     assert(*bytes <= SIZE_MAX);
     ret = bdrv_create_padded_qiov(bs, pad, sliced_iov, sliced_niov,
                                   sliced_head, *bytes);
-- 
2.40.1


