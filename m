Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F89706EB9
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 18:52:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzKNM-00043k-Nd; Wed, 17 May 2023 12:51:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1pzKNI-0003zz-0o
 for qemu-devel@nongnu.org; Wed, 17 May 2023 12:51:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1pzKNG-0001SE-61
 for qemu-devel@nongnu.org; Wed, 17 May 2023 12:51:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684342297;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CNWzPU7pGQLYS7VpRfgExLTx8ajdrV+obUyytQcMbTE=;
 b=XhK9zjWiLOunSJUvhkl9SqsZWThwRZu4JJHSXIB7e29QV3PvM6RYjCjhZtmRAhCHM074Ew
 +maywOcuiiHEqCH+QTk4dx7bcwAuE/iByzEoSoW6BXXuuztFr1HixM+JUzUJjH9445SLsA
 vp3QT0b3qQlBK3XHzOG5skbWtn+tHIg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-42-prXHn0HjNK-W0K6EVhQDMQ-1; Wed, 17 May 2023 12:51:34 -0400
X-MC-Unique: prXHn0HjNK-W0K6EVhQDMQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 14F961824602;
 Wed, 17 May 2023 16:51:34 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5CE3640C6EC4;
 Wed, 17 May 2023 16:51:33 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 11/18] qemu-img: Take graph lock more selectively
Date: Wed, 17 May 2023 18:51:09 +0200
Message-Id: <20230517165116.475123-12-kwolf@redhat.com>
In-Reply-To: <20230517165116.475123-1-kwolf@redhat.com>
References: <20230517165116.475123-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
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

If we take a reader lock, we can't call any functions that take a writer
lock internally without causing deadlocks once the reader lock is
actually enforced in the main thread, too. Take the reader lock only
where it is actually needed.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <20230510203601.418015-5-kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qemu-img.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 9f9f0a7629..27f48051b0 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -2938,8 +2938,6 @@ static BlockGraphInfoList *collect_image_info_list(bool image_opts,
         }
         bs = blk_bs(blk);
 
-        GRAPH_RDLOCK_GUARD_MAINLOOP();
-
         /*
          * Note that the returned BlockGraphInfo object will not have
          * information about this image's backing node, because we have opened
@@ -2947,7 +2945,10 @@ static BlockGraphInfoList *collect_image_info_list(bool image_opts,
          * duplicate the backing chain information that we obtain by walking
          * the chain manually here.
          */
+        bdrv_graph_rdlock_main_loop();
         bdrv_query_block_graph_info(bs, &info, &err);
+        bdrv_graph_rdunlock_main_loop();
+
         if (err) {
             error_report_err(err);
             blk_unref(blk);
-- 
2.40.1


