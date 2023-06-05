Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C497221A4
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 10:59:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6622-0005ft-09; Mon, 05 Jun 2023 04:57:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1q661s-0005cq-Ki
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 04:57:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1q661o-0004sZ-6z
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 04:57:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685955447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lRNJTSSNSAXDnrhqddr90/q7AO+amHqWivhyPshnE64=;
 b=KDcTuMSd4MaNHHMkdEMiQKNRY0N4FAAxZ3QT90EDTYfX9tr8gWqeJzh7bwCYRtPKWxS1gN
 Fqegv8dXkUg77p0irPUX2q8t9IszUXs+DawPM/5ni8p8pSOCYNfEL+NQWdEUulTbu3bNJl
 NrsQzxrt2irY4v/NW3IuS/ooihjQwak=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-252-FvWKG5sgPbOqI08vXv5AKw-1; Mon, 05 Jun 2023 04:57:26 -0400
X-MC-Unique: FvWKG5sgPbOqI08vXv5AKw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BAB368032EF;
 Mon,  5 Jun 2023 08:57:25 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.193.25])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C240A40C6EC4;
 Mon,  5 Jun 2023 08:57:24 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, hreitz@redhat.com,
 eblake@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v2 08/11] block: Fix AioContext locking in
 bdrv_open_backing_file()
Date: Mon,  5 Jun 2023 10:57:08 +0200
Message-Id: <20230605085711.21261-9-kwolf@redhat.com>
In-Reply-To: <20230605085711.21261-1-kwolf@redhat.com>
References: <20230605085711.21261-1-kwolf@redhat.com>
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

bdrv_set_backing() requires the caller to hold the AioContext lock for
@backing_hd. Take it in bdrv_open_backing_file() before calling the
function.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/block.c b/block.c
index 954b9923d9..d5f8231f31 100644
--- a/block.c
+++ b/block.c
@@ -3526,6 +3526,7 @@ int bdrv_open_backing_file(BlockDriverState *bs, QDict *parent_options,
     int ret = 0;
     bool implicit_backing = false;
     BlockDriverState *backing_hd;
+    AioContext *backing_hd_ctx;
     QDict *options;
     QDict *tmp_parent_options = NULL;
     Error *local_err = NULL;
@@ -3610,8 +3611,12 @@ int bdrv_open_backing_file(BlockDriverState *bs, QDict *parent_options,
 
     /* Hook up the backing file link; drop our reference, bs owns the
      * backing_hd reference now */
+    backing_hd_ctx = bdrv_get_aio_context(backing_hd);
+    aio_context_acquire(backing_hd_ctx);
     ret = bdrv_set_backing_hd(bs, backing_hd, errp);
     bdrv_unref(backing_hd);
+    aio_context_release(backing_hd_ctx);
+
     if (ret < 0) {
         goto free_exit;
     }
-- 
2.40.1


