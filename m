Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A88805D46
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 19:24:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAa2i-0000GP-Ar; Tue, 05 Dec 2023 13:21:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rAa2A-0008VS-Lh
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 13:20:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rAa1y-0002hr-UU
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 13:20:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701800425;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XASdwYxqaVrj7Zfh8PNH/kQYEj4OCOxW3FbL/rilTmk=;
 b=RwA24PZ3499uaaQMl6J8s+HqChqLDzhexQduPKzvdJCgV1EY6FjANpyORle7Qrd82t0qoW
 fmnYQjYM5u5HGGfkLq4WB1W3ktZXig9fGDMTDzx9/+VyaOuaV8pCryf2pc+Mg3oxJ/XCBe
 LQkO6T4/gBx4ucLLhz4DLUTYZaPgdRc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-Jo0TQi2kMYmjMAUTVu4qcg-1; Tue, 05 Dec 2023 13:20:21 -0500
X-MC-Unique: Jo0TQi2kMYmjMAUTVu4qcg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 98D45881D35;
 Tue,  5 Dec 2023 18:20:20 +0000 (UTC)
Received: from localhost (unknown [10.39.194.111])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F19A02166B31;
 Tue,  5 Dec 2023 18:20:19 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Cleber Rosa <crosa@redhat.com>, Xie Changlong <xiechanglong.d@gmail.com>,
 Paul Durrant <paul@xen.org>, Ari Sundholm <ari@tuxera.com>,
 Jason Wang <jasowang@redhat.com>, Eric Blake <eblake@redhat.com>,
 John Snow <jsnow@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Wen Congyang <wencongyang2@huawei.com>, Alberto Garcia <berto@igalia.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, Hanna Reitz <hreitz@redhat.com>,
 Zhang Chen <chen.zhang@intel.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Peter Xu <peterx@redhat.com>,
 Emanuele Giuseppe Esposito <eesposit@redhat.com>,
 Fam Zheng <fam@euphon.net>, Leonardo Bras <leobras@redhat.com>,
 David Hildenbrand <david@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 xen-devel@lists.xenproject.org
Subject: [PATCH v2 02/14] scsi: assert that callbacks run in the correct
 AioContext
Date: Tue,  5 Dec 2023 13:19:59 -0500
Message-ID: <20231205182011.1976568-3-stefanha@redhat.com>
In-Reply-To: <20231205182011.1976568-1-stefanha@redhat.com>
References: <20231205182011.1976568-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Since the removal of AioContext locking, the correctness of the code
relies on running requests from a single AioContext at any given time.

Add assertions that verify that callbacks are invoked in the correct
AioContext.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
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


