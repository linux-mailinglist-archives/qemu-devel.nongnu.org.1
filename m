Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 41024722BDA
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 17:48:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6CPh-00080u-6x; Mon, 05 Jun 2023 11:46:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1q6CPG-0007pr-21
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 11:46:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1q6CPD-0001LX-0n
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 11:46:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685979960;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=04pv5oWfRMY/HzoR/mhhjMw1YcRoMEudYrFfPVYCe2g=;
 b=iEpVGNp9IvT6dBAZdDN0n4eU2phF2e3CeBAmlaJd4NZJKdHYyzYFCX7+1crM7DjbKA4ogr
 EWpyGAV0dnSRXliRkYdImRGfFcUKd8G5UssDjVrMzni/7Tsb1GzEzCY5DBy07SUzGM/6Rr
 jG+7k5rbRPxuef6yaWpyGlzFVKBHyRM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-317-2m2rymClOIOgFr2mh87Gpw-1; Mon, 05 Jun 2023 11:45:56 -0400
X-MC-Unique: 2m2rymClOIOgFr2mh87Gpw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0F1663801ED8;
 Mon,  5 Jun 2023 15:45:56 +0000 (UTC)
Received: from localhost (unknown [10.39.194.13])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C47391121314;
 Mon,  5 Jun 2023 15:45:55 +0000 (UTC)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 07/17] parallels: Fix image_end_offset and data_end after
 out-of-image check
Date: Mon,  5 Jun 2023 17:45:31 +0200
Message-Id: <20230605154541.1043261-8-hreitz@redhat.com>
In-Reply-To: <20230605154541.1043261-1-hreitz@redhat.com>
References: <20230605154541.1043261-1-hreitz@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>

Set data_end to the end of the last cluster inside the image. In such a
way we can be sure that corrupted offsets in the BAT can't affect on the
image size. If there are no allocated clusters set image_end_offset by
data_end.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Reviewed-by: Denis V. Lunev <den@openvz.org>
Message-Id: <20230424093147.197643-4-alexander.ivanov@virtuozzo.com>
Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/parallels.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/block/parallels.c b/block/parallels.c
index 204d20685b..ea382e8382 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -490,7 +490,13 @@ parallels_co_check(BlockDriverState *bs, BdrvCheckResult *res,
         }
     }
 
-    res->image_end_offset = high_off + s->cluster_size;
+    if (high_off == 0) {
+        res->image_end_offset = s->data_end << BDRV_SECTOR_BITS;
+    } else {
+        res->image_end_offset = high_off + s->cluster_size;
+        s->data_end = res->image_end_offset >> BDRV_SECTOR_BITS;
+    }
+
     if (size > res->image_end_offset) {
         int64_t count;
         count = DIV_ROUND_UP(size - res->image_end_offset, s->cluster_size);
-- 
2.40.1


