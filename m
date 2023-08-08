Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A691B773C16
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 18:00:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTP7Y-00063L-Ow; Tue, 08 Aug 2023 11:59:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qTP7X-00062n-6I
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 11:59:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qTP7U-0004ff-Hm
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 11:59:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691510359;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TZZK1Ap++4u7+KzE8rEBXDH9rtBtUGrW9eW+QToq0m4=;
 b=CUFFbmvyHEhi7qXlkgfPHA7c+O2hlR7XD/v+BIs3dFaDwpukXQ3luIKRjaPZIOrVIxJMJ6
 w6LtWgby3li4XLgiP8hxPLvDYzPgghx87wyeAaXJV0Os3O+FW1TxhN2bT/j6ArznlVy/Ee
 83UEsBtSD7N2+VXw0kyWthMpmEDCKXc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-625-njCPr4LdMz-rWMw_moMSgA-1; Tue, 08 Aug 2023 11:59:12 -0400
X-MC-Unique: njCPr4LdMz-rWMw_moMSgA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 90902185A7A4;
 Tue,  8 Aug 2023 15:59:12 +0000 (UTC)
Received: from localhost (unknown [10.39.193.72])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D1C6E492C14;
 Tue,  8 Aug 2023 15:59:11 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 1/2] block: minimize bs->reqs_lock section in
 tracked_request_end()
Date: Tue,  8 Aug 2023 11:58:51 -0400
Message-ID: <20230808155852.2745350-2-stefanha@redhat.com>
In-Reply-To: <20230808155852.2745350-1-stefanha@redhat.com>
References: <20230808155852.2745350-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
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

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/io.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/block/io.c b/block/io.c
index 055fcf7438..85d5176256 100644
--- a/block/io.c
+++ b/block/io.c
@@ -593,8 +593,14 @@ static void coroutine_fn tracked_request_end(BdrvTrackedRequest *req)
 
     qemu_co_mutex_lock(&req->bs->reqs_lock);
     QLIST_REMOVE(req, list);
+    qemu_co_mutex_unlock(&req->bs->reqs_lock);
+
+    /*
+     * At this point qemu_co_queue_wait(&req->wait_queue, ...) won't be called
+     * anymore because the request has been removed from the list, so it's safe
+     * to restart the queue outside reqs_lock to minimize the critical section.
+     */
     qemu_co_queue_restart_all(&req->wait_queue);
-    qemu_co_mutex_unlock(&req->bs->reqs_lock);
 }
 
 /**
-- 
2.41.0


