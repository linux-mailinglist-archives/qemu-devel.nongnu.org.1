Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 92747722BDD
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 17:48:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6CPI-0007oR-IM; Mon, 05 Jun 2023 11:46:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1q6CP5-0007km-Ka
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 11:45:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1q6CP3-0001Iu-Sg
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 11:45:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685979953;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z8HstDAZVktTJkrB//J+fQO/MgjmPuN3y1/ZrbZM3A8=;
 b=gUc1UVyDjdVpmk8pPMguoPjOGvPNjLoWmGlTgndjTs4pyCPH4a00lbgXYlgWzeOlT4DI0k
 uzG2w6PZf+7DngCuNb4c8vBUJu/2aH5dbrokb0DY+NS8gbV3RQzgOwAVOPqkzTB5QHX7aQ
 1acn4PCbXUzC0ybQfDliwuMEgq1sU4k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-515-SPCaotr_MbCcIy92dSEmNQ-1; Mon, 05 Jun 2023 11:45:52 -0400
X-MC-Unique: SPCaotr_MbCcIy92dSEmNQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A7303801585;
 Mon,  5 Jun 2023 15:45:51 +0000 (UTC)
Received: from localhost (unknown [10.39.194.13])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 689881121314;
 Mon,  5 Jun 2023 15:45:51 +0000 (UTC)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 05/17] parallels: Out of image offset in BAT leads to image
 inflation
Date: Mon,  5 Jun 2023 17:45:29 +0200
Message-Id: <20230605154541.1043261-6-hreitz@redhat.com>
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

data_end field in BDRVParallelsState is set to the biggest offset present
in BAT. If this offset is outside of the image, any further write will
create the cluster at this offset and/or the image will be truncated to
this offset on close. This is definitely not correct.

Raise an error in parallels_open() if data_end points outside the image
and it is not a check (let the check to repaire the image). Set data_end
to the end of the cluster with the last correct offset.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Message-Id: <20230424093147.197643-2-alexander.ivanov@virtuozzo.com>
Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/parallels.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/block/parallels.c b/block/parallels.c
index d8a3f13e24..7b6d770f8e 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -733,6 +733,7 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
     BDRVParallelsState *s = bs->opaque;
     ParallelsHeader ph;
     int ret, size, i;
+    int64_t file_nb_sectors;
     QemuOpts *opts = NULL;
     Error *local_err = NULL;
     char *buf;
@@ -742,6 +743,11 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
         return ret;
     }
 
+    file_nb_sectors = bdrv_nb_sectors(bs->file->bs);
+    if (file_nb_sectors < 0) {
+        return -EINVAL;
+    }
+
     ret = bdrv_pread(bs->file, 0, sizeof(ph), &ph, 0);
     if (ret < 0) {
         goto fail;
@@ -806,6 +812,17 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
 
     for (i = 0; i < s->bat_size; i++) {
         int64_t off = bat2sect(s, i);
+        if (off >= file_nb_sectors) {
+            if (flags & BDRV_O_CHECK) {
+                continue;
+            }
+            error_setg(errp, "parallels: Offset %" PRIi64 " in BAT[%d] entry "
+                       "is larger than file size (%" PRIi64 ")",
+                       off << BDRV_SECTOR_BITS, i,
+                       file_nb_sectors << BDRV_SECTOR_BITS);
+            ret = -EINVAL;
+            goto fail;
+        }
         if (off >= s->data_end) {
             s->data_end = off + s->tracks;
         }
-- 
2.40.1


