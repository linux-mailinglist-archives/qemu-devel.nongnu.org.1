Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CAEA681BFFF
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 22:24:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGQWu-00089K-My; Thu, 21 Dec 2023 16:24:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rGQWr-000838-Mz
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 16:24:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rGQWq-00087b-36
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 16:24:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703193867;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a9YCFYBe/wtK2m20SEqqnM/xkwczPqhlKI9voVD+mLY=;
 b=WHw36vyMynh4NYGc+hyhUa72QObRxAr6WovqCTBUIZCbhaCpLfXIq8cua7s6i4CXsfcQir
 4CdO8g4+42veufa7wCJ8cEmg/PYsBnpZqxbpYGnnxiGLqUQDPGs1hHyGY9vkqISglYT/Tu
 Nawr04dmqt/ICC419EvQlXn3FGoDbkQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-MacXL3UjMqiVYip6G14u2g-1; Thu, 21 Dec 2023 16:24:26 -0500
X-MC-Unique: MacXL3UjMqiVYip6G14u2g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D733A833A06;
 Thu, 21 Dec 2023 21:24:25 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.193.128])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E0827C15968;
 Thu, 21 Dec 2023 21:24:23 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 16/33] scsi: assert that callbacks run in the correct AioContext
Date: Thu, 21 Dec 2023 22:23:21 +0100
Message-ID: <20231221212339.164439-17-kwolf@redhat.com>
In-Reply-To: <20231221212339.164439-1-kwolf@redhat.com>
References: <20231221212339.164439-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.061,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Stefan Hajnoczi <stefanha@redhat.com>

Since the removal of AioContext locking, the correctness of the code
relies on running requests from a single AioContext at any given time.

Add assertions that verify that callbacks are invoked in the correct
AioContext.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20231205182011.1976568-3-stefanha@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 hw/scsi/scsi-disk.c  | 14 ++++++++++++++
 system/dma-helpers.c |  3 +++
 2 files changed, 17 insertions(+)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 2c1bbb3530..a5048e0aaf 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -273,6 +273,10 @@ static void scsi_aio_complete(void *opaque, int ret)
     SCSIDiskReq *r = (SCSIDiskReq *)opaque;
     SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, r->req.dev);
 
+    /* The request must only run in the BlockBackend's AioContext */
+    assert(blk_get_aio_context(s->qdev.conf.blk) ==
+           qemu_get_current_aio_context());
+
     assert(r->req.aiocb != NULL);
     r->req.aiocb = NULL;
 
@@ -370,8 +374,13 @@ static void scsi_dma_complete(void *opaque, int ret)
 
 static void scsi_read_complete_noio(SCSIDiskReq *r, int ret)
 {
+    SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, r->req.dev);
     uint32_t n;
 
+    /* The request must only run in the BlockBackend's AioContext */
+    assert(blk_get_aio_context(s->qdev.conf.blk) ==
+           qemu_get_current_aio_context());
+
     assert(r->req.aiocb == NULL);
     if (scsi_disk_req_check_error(r, ret, false)) {
         goto done;
@@ -496,8 +505,13 @@ static void scsi_read_data(SCSIRequest *req)
 
 static void scsi_write_complete_noio(SCSIDiskReq *r, int ret)
 {
+    SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, r->req.dev);
     uint32_t n;
 
+    /* The request must only run in the BlockBackend's AioContext */
+    assert(blk_get_aio_context(s->qdev.conf.blk) ==
+           qemu_get_current_aio_context());
+
     assert (r->req.aiocb == NULL);
     if (scsi_disk_req_check_error(r, ret, false)) {
         goto done;
diff --git a/system/dma-helpers.c b/system/dma-helpers.c
index 528117f256..9b221cf94e 100644
--- a/system/dma-helpers.c
+++ b/system/dma-helpers.c
@@ -119,6 +119,9 @@ static void dma_blk_cb(void *opaque, int ret)
 
     trace_dma_blk_cb(dbs, ret);
 
+    /* DMAAIOCB is not thread-safe and must be accessed only from dbs->ctx */
+    assert(ctx == qemu_get_current_aio_context());
+
     dbs->acb = NULL;
     dbs->offset += dbs->iov.size;
 
-- 
2.43.0


