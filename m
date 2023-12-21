Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5897A81C01B
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 22:28:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGQWp-0007tF-Ja; Thu, 21 Dec 2023 16:24:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rGQWn-0007kO-34
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 16:24:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rGQWl-00086P-3y
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 16:24:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703193862;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SDLwP/BJVhybEywki62FzlxQuTPf9uP48poLNlPLvL8=;
 b=CTLZG3k/Rw6cd3esw3chbo7OanxYC5eRwpKIliOV4166UUp89ghK+1oTSMjfmArzeQ7dq4
 DUYBWbvf0pBYwuXZaJs5sj4GmbthQlOh+Q6pfa/K5uHI0/CdXeua3dhljIQfx2O+AX8pS3
 4Bou5+3fSjCL8kLKoeaQdPU2jxvy0v4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-XUTWsdP6OEyudWON6XYLaQ-1; Thu, 21 Dec 2023 16:24:19 -0500
X-MC-Unique: XUTWsdP6OEyudWON6XYLaQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1A6D4833A0F;
 Thu, 21 Dec 2023 21:24:19 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.193.128])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 65BAEC15A0C;
 Thu, 21 Dec 2023 21:24:17 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 13/33] scsi: don't lock AioContext in I/O code path
Date: Thu, 21 Dec 2023 22:23:18 +0100
Message-ID: <20231221212339.164439-14-kwolf@redhat.com>
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

From: Stefan Hajnoczi <stefanha@redhat.com>

blk_aio_*() doesn't require the AioContext lock and the SCSI subsystem's
internal state also does not anymore.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Acked-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20231204164259.1515217-4-stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 hw/scsi/scsi-disk.c    | 23 -----------------------
 hw/scsi/scsi-generic.c | 20 +++-----------------
 2 files changed, 3 insertions(+), 40 deletions(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 6691f5edb8..2c1bbb3530 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -273,8 +273,6 @@ static void scsi_aio_complete(void *opaque, int ret)
     SCSIDiskReq *r = (SCSIDiskReq *)opaque;
     SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, r->req.dev);
 
-    aio_context_acquire(blk_get_aio_context(s->qdev.conf.blk));
-
     assert(r->req.aiocb != NULL);
     r->req.aiocb = NULL;
 
@@ -286,7 +284,6 @@ static void scsi_aio_complete(void *opaque, int ret)
     scsi_req_complete(&r->req, GOOD);
 
 done:
-    aio_context_release(blk_get_aio_context(s->qdev.conf.blk));
     scsi_req_unref(&r->req);
 }
 
@@ -394,8 +391,6 @@ static void scsi_read_complete(void *opaque, int ret)
     SCSIDiskReq *r = (SCSIDiskReq *)opaque;
     SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, r->req.dev);
 
-    aio_context_acquire(blk_get_aio_context(s->qdev.conf.blk));
-
     assert(r->req.aiocb != NULL);
     r->req.aiocb = NULL;
 
@@ -406,7 +401,6 @@ static void scsi_read_complete(void *opaque, int ret)
         trace_scsi_disk_read_complete(r->req.tag, r->qiov.size);
     }
     scsi_read_complete_noio(r, ret);
-    aio_context_release(blk_get_aio_context(s->qdev.conf.blk));
 }
 
 /* Actually issue a read to the block device.  */
@@ -448,8 +442,6 @@ static void scsi_do_read_cb(void *opaque, int ret)
     SCSIDiskReq *r = (SCSIDiskReq *)opaque;
     SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, r->req.dev);
 
-    aio_context_acquire(blk_get_aio_context(s->qdev.conf.blk));
-
     assert (r->req.aiocb != NULL);
     r->req.aiocb = NULL;
 
@@ -459,7 +451,6 @@ static void scsi_do_read_cb(void *opaque, int ret)
         block_acct_done(blk_get_stats(s->qdev.conf.blk), &r->acct);
     }
     scsi_do_read(opaque, ret);
-    aio_context_release(blk_get_aio_context(s->qdev.conf.blk));
 }
 
 /* Read more data from scsi device into buffer.  */
@@ -533,8 +524,6 @@ static void scsi_write_complete(void * opaque, int ret)
     SCSIDiskReq *r = (SCSIDiskReq *)opaque;
     SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, r->req.dev);
 
-    aio_context_acquire(blk_get_aio_context(s->qdev.conf.blk));
-
     assert (r->req.aiocb != NULL);
     r->req.aiocb = NULL;
 
@@ -544,7 +533,6 @@ static void scsi_write_complete(void * opaque, int ret)
         block_acct_done(blk_get_stats(s->qdev.conf.blk), &r->acct);
     }
     scsi_write_complete_noio(r, ret);
-    aio_context_release(blk_get_aio_context(s->qdev.conf.blk));
 }
 
 static void scsi_write_data(SCSIRequest *req)
@@ -1742,8 +1730,6 @@ static void scsi_unmap_complete(void *opaque, int ret)
     SCSIDiskReq *r = data->r;
     SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, r->req.dev);
 
-    aio_context_acquire(blk_get_aio_context(s->qdev.conf.blk));
-
     assert(r->req.aiocb != NULL);
     r->req.aiocb = NULL;
 
@@ -1754,7 +1740,6 @@ static void scsi_unmap_complete(void *opaque, int ret)
         block_acct_done(blk_get_stats(s->qdev.conf.blk), &r->acct);
         scsi_unmap_complete_noio(data, ret);
     }
-    aio_context_release(blk_get_aio_context(s->qdev.conf.blk));
 }
 
 static void scsi_disk_emulate_unmap(SCSIDiskReq *r, uint8_t *inbuf)
@@ -1822,8 +1807,6 @@ static void scsi_write_same_complete(void *opaque, int ret)
     SCSIDiskReq *r = data->r;
     SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, r->req.dev);
 
-    aio_context_acquire(blk_get_aio_context(s->qdev.conf.blk));
-
     assert(r->req.aiocb != NULL);
     r->req.aiocb = NULL;
 
@@ -1847,7 +1830,6 @@ static void scsi_write_same_complete(void *opaque, int ret)
                                        data->sector << BDRV_SECTOR_BITS,
                                        &data->qiov, 0,
                                        scsi_write_same_complete, data);
-        aio_context_release(blk_get_aio_context(s->qdev.conf.blk));
         return;
     }
 
@@ -1857,7 +1839,6 @@ done:
     scsi_req_unref(&r->req);
     qemu_vfree(data->iov.iov_base);
     g_free(data);
-    aio_context_release(blk_get_aio_context(s->qdev.conf.blk));
 }
 
 static void scsi_disk_emulate_write_same(SCSIDiskReq *r, uint8_t *inbuf)
@@ -2810,7 +2791,6 @@ static void scsi_block_sgio_complete(void *opaque, int ret)
 {
     SCSIBlockReq *req = (SCSIBlockReq *)opaque;
     SCSIDiskReq *r = &req->req;
-    SCSIDevice *s = r->req.dev;
     sg_io_hdr_t *io_hdr = &req->io_header;
 
     if (ret == 0) {
@@ -2827,13 +2807,10 @@ static void scsi_block_sgio_complete(void *opaque, int ret)
         }
 
         if (ret > 0) {
-            aio_context_acquire(blk_get_aio_context(s->conf.blk));
             if (scsi_handle_rw_error(r, ret, true)) {
-                aio_context_release(blk_get_aio_context(s->conf.blk));
                 scsi_req_unref(&r->req);
                 return;
             }
-            aio_context_release(blk_get_aio_context(s->conf.blk));
 
             /* Ignore error.  */
             ret = 0;
diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
index 2417f0ad84..b7b04e1d63 100644
--- a/hw/scsi/scsi-generic.c
+++ b/hw/scsi/scsi-generic.c
@@ -109,15 +109,11 @@ done:
 static void scsi_command_complete(void *opaque, int ret)
 {
     SCSIGenericReq *r = (SCSIGenericReq *)opaque;
-    SCSIDevice *s = r->req.dev;
-
-    aio_context_acquire(blk_get_aio_context(s->conf.blk));
 
     assert(r->req.aiocb != NULL);
     r->req.aiocb = NULL;
 
     scsi_command_complete_noio(r, ret);
-    aio_context_release(blk_get_aio_context(s->conf.blk));
 }
 
 static int execute_command(BlockBackend *blk,
@@ -274,14 +270,12 @@ static void scsi_read_complete(void * opaque, int ret)
     SCSIDevice *s = r->req.dev;
     int len;
 
-    aio_context_acquire(blk_get_aio_context(s->conf.blk));
-
     assert(r->req.aiocb != NULL);
     r->req.aiocb = NULL;
 
     if (ret || r->req.io_canceled) {
         scsi_command_complete_noio(r, ret);
-        goto done;
+        return;
     }
 
     len = r->io_header.dxfer_len - r->io_header.resid;
@@ -320,7 +314,7 @@ static void scsi_read_complete(void * opaque, int ret)
         r->io_header.status != GOOD ||
         len == 0) {
         scsi_command_complete_noio(r, 0);
-        goto done;
+        return;
     }
 
     /* Snoop READ CAPACITY output to set the blocksize.  */
@@ -356,9 +350,6 @@ static void scsi_read_complete(void * opaque, int ret)
 req_complete:
     scsi_req_data(&r->req, len);
     scsi_req_unref(&r->req);
-
-done:
-    aio_context_release(blk_get_aio_context(s->conf.blk));
 }
 
 /* Read more data from scsi device into buffer.  */
@@ -391,14 +382,12 @@ static void scsi_write_complete(void * opaque, int ret)
 
     trace_scsi_generic_write_complete(ret);
 
-    aio_context_acquire(blk_get_aio_context(s->conf.blk));
-
     assert(r->req.aiocb != NULL);
     r->req.aiocb = NULL;
 
     if (ret || r->req.io_canceled) {
         scsi_command_complete_noio(r, ret);
-        goto done;
+        return;
     }
 
     if (r->req.cmd.buf[0] == MODE_SELECT && r->req.cmd.buf[4] == 12 &&
@@ -408,9 +397,6 @@ static void scsi_write_complete(void * opaque, int ret)
     }
 
     scsi_command_complete_noio(r, ret);
-
-done:
-    aio_context_release(blk_get_aio_context(s->conf.blk));
 }
 
 /* Write data to a scsi device.  Returns nonzero on failure.
-- 
2.43.0


