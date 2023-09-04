Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 905257919C6
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 16:38:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdAhJ-00025B-Mb; Mon, 04 Sep 2023 10:37:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qdAhG-00021a-EX
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 10:36:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qdAhC-0001hv-Bj
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 10:36:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693838213;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MsQ3HflWiYvfuQhjIHSHWi5v85CZVE02KeejPri9Khw=;
 b=KsUg/Th7S9CplOUVVpAYuG7+riJ/7odST3VNnnNgeEQWZ4k6Z2Jcy51apx2lB3vPXOIP1V
 gapQXYwnZHUtqRnYMzqPw7RDYlhCUTuaLptMJkeTxQhBCmNpexZu9VuQr8ioI/34WJs7C8
 fhqHR+eIEmunSEyp2XbwPTu2aqR6UbU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-398-VYsNueDSP7iI_WQ474mclA-1; Mon, 04 Sep 2023 10:36:50 -0400
X-MC-Unique: VYsNueDSP7iI_WQ474mclA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 27D788008A4;
 Mon,  4 Sep 2023 14:36:50 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.193.211])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 86965493114;
 Mon,  4 Sep 2023 14:36:49 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 01/14] block/vpc: Avoid dynamic stack allocation
Date: Mon,  4 Sep 2023 16:36:30 +0200
Message-ID: <20230904143643.259916-2-kwolf@redhat.com>
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

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Use autofree heap allocation instead of variable-length array on the
stack. Here we don't expect the bitmap size to be enormous, and
since we're about to read/write it to disk the overhead of the
allocation should be fine.

The codebase has very few VLAs, and if we can get rid of them all we
can make the compiler error on new additions.  This is a defensive
measure against security bugs where an on-stack dynamic allocation
isn't correctly size-checked (e.g.  CVE-2021-3527).

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
[PMM: expanded commit message]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20230811175229.808139-1-peter.maydell@linaro.org>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/vpc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/vpc.c b/block/vpc.c
index 3810a601a3..ceb87dd3d8 100644
--- a/block/vpc.c
+++ b/block/vpc.c
@@ -510,7 +510,7 @@ get_image_offset(BlockDriverState *bs, uint64_t offset, bool write, int *err)
        miss sparse read optimization, but it's not a problem in terms of
        correctness. */
     if (write && (s->last_bitmap_offset != bitmap_offset)) {
-        uint8_t bitmap[s->bitmap_size];
+        g_autofree uint8_t *bitmap = g_malloc(s->bitmap_size);
         int r;
 
         s->last_bitmap_offset = bitmap_offset;
@@ -558,7 +558,7 @@ alloc_block(BlockDriverState *bs, int64_t offset)
     int64_t bat_offset;
     uint32_t index, bat_value;
     int ret;
-    uint8_t bitmap[s->bitmap_size];
+    g_autofree uint8_t *bitmap = g_malloc(s->bitmap_size);
 
     /* Check if sector_num is valid */
     if ((offset < 0) || (offset > bs->total_sectors * BDRV_SECTOR_SIZE)) {
-- 
2.41.0


