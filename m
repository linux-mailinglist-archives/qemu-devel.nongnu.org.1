Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EB501AA7147
	for <lists+qemu-devel@lfdr.de>; Fri,  2 May 2025 14:13:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uApEy-0000Wp-Dy; Fri, 02 May 2025 08:11:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <afaria@redhat.com>) id 1uApEv-0000WP-Ns
 for qemu-devel@nongnu.org; Fri, 02 May 2025 08:11:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <afaria@redhat.com>) id 1uApEq-0003Tv-8J
 for qemu-devel@nongnu.org; Fri, 02 May 2025 08:11:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746187891;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O3qPRtwnLxImfqoM+SxwhbWkP6zG0zSzWQFszr9u6HM=;
 b=AGEqr0D2OT7ylfz9PHWDq0tPF4pU2qykdauxdbhKdsz6PXaAzsGINOjgTMTnazcpXi9kXv
 gPzeVAVGSiOgNNO+VeaoPHdCQy56AwHvvziSREP9uofeFEV8qIOcdFlTrdCD3x9Kb98KDw
 9sshTYwtLc5zT2SewFpsleOWzVqBZv0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-256-1xe2vXo2OKSIxoYhVSB09g-1; Fri,
 02 May 2025 08:11:29 -0400
X-MC-Unique: 1xe2vXo2OKSIxoYhVSB09g-1
X-Mimecast-MFC-AGG-ID: 1xe2vXo2OKSIxoYhVSB09g_1746187887
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 126501955E79; Fri,  2 May 2025 12:11:27 +0000 (UTC)
Received: from desktop.redhat.com (unknown [10.45.224.121])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A25B41954B08; Fri,  2 May 2025 12:11:22 +0000 (UTC)
From: Alberto Faria <afaria@redhat.com>
To: qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Fam Zheng <fam@euphon.net>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Alberto Faria <afaria@redhat.com>
Subject: [PATCH v3 1/2] scsi-disk: Add native FUA write support
Date: Fri,  2 May 2025 13:11:14 +0100
Message-ID: <20250502121115.3613717-2-afaria@redhat.com>
In-Reply-To: <20250502121115.3613717-1-afaria@redhat.com>
References: <20250502121115.3613717-1-afaria@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=afaria@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.644,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Simply propagate the FUA flag on write requests to the driver. The block
layer will emulate it if necessary.

Signed-off-by: Alberto Faria <afaria@redhat.com>
---
 hw/scsi/scsi-disk.c | 53 +++++++++++++--------------------------------
 1 file changed, 15 insertions(+), 38 deletions(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index cb4af1b715..738d8df8ec 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -74,7 +74,7 @@ struct SCSIDiskClass {
      */
     DMAIOFunc       *dma_readv;
     DMAIOFunc       *dma_writev;
-    bool            (*need_fua_emulation)(SCSICommand *cmd);
+    bool            (*need_fua)(SCSICommand *cmd);
     void            (*update_sense)(SCSIRequest *r);
 };
 
@@ -85,7 +85,7 @@ typedef struct SCSIDiskReq {
     uint32_t sector_count;
     uint32_t buflen;
     bool started;
-    bool need_fua_emulation;
+    bool need_fua;
     struct iovec iov;
     QEMUIOVector qiov;
     BlockAcctCookie acct;
@@ -389,24 +389,6 @@ static bool scsi_is_cmd_fua(SCSICommand *cmd)
     }
 }
 
-static void scsi_write_do_fua(SCSIDiskReq *r)
-{
-    SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, r->req.dev);
-
-    assert(r->req.aiocb == NULL);
-    assert(!r->req.io_canceled);
-
-    if (r->need_fua_emulation) {
-        block_acct_start(blk_get_stats(s->qdev.conf.blk), &r->acct, 0,
-                         BLOCK_ACCT_FLUSH);
-        r->req.aiocb = blk_aio_flush(s->qdev.conf.blk, scsi_aio_complete, r);
-        return;
-    }
-
-    scsi_req_complete(&r->req, GOOD);
-    scsi_req_unref(&r->req);
-}
-
 static void scsi_dma_complete_noio(SCSIDiskReq *r, int ret)
 {
     assert(r->req.aiocb == NULL);
@@ -416,12 +398,7 @@ static void scsi_dma_complete_noio(SCSIDiskReq *r, int ret)
 
     r->sector += r->sector_count;
     r->sector_count = 0;
-    if (r->req.cmd.mode == SCSI_XFER_TO_DEV) {
-        scsi_write_do_fua(r);
-        return;
-    } else {
-        scsi_req_complete(&r->req, GOOD);
-    }
+    scsi_req_complete(&r->req, GOOD);
 
 done:
     scsi_req_unref(&r->req);
@@ -564,7 +541,7 @@ static void scsi_read_data(SCSIRequest *req)
 
     first = !r->started;
     r->started = true;
-    if (first && r->need_fua_emulation) {
+    if (first && r->need_fua) {
         block_acct_start(blk_get_stats(s->qdev.conf.blk), &r->acct, 0,
                          BLOCK_ACCT_FLUSH);
         r->req.aiocb = blk_aio_flush(s->qdev.conf.blk, scsi_do_read_cb, r);
@@ -589,8 +566,7 @@ static void scsi_write_complete_noio(SCSIDiskReq *r, int ret)
     r->sector += n;
     r->sector_count -= n;
     if (r->sector_count == 0) {
-        scsi_write_do_fua(r);
-        return;
+        scsi_req_complete(&r->req, GOOD);
     } else {
         scsi_init_iovec(r, SCSI_DMA_BUF_SIZE);
         trace_scsi_disk_write_complete_noio(r->req.tag, r->qiov.size);
@@ -623,6 +599,7 @@ static void scsi_write_data(SCSIRequest *req)
     SCSIDiskReq *r = DO_UPCAST(SCSIDiskReq, req, req);
     SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, r->req.dev);
     SCSIDiskClass *sdc = (SCSIDiskClass *) object_get_class(OBJECT(s));
+    BlockCompletionFunc *cb;
 
     /* No data transfer may already be in progress */
     assert(r->req.aiocb == NULL);
@@ -648,11 +625,10 @@ static void scsi_write_data(SCSIRequest *req)
 
     if (r->req.cmd.buf[0] == VERIFY_10 || r->req.cmd.buf[0] == VERIFY_12 ||
         r->req.cmd.buf[0] == VERIFY_16) {
-        if (r->req.sg) {
-            scsi_dma_complete_noio(r, 0);
-        } else {
-            scsi_write_complete_noio(r, 0);
-        }
+        block_acct_start(blk_get_stats(s->qdev.conf.blk), &r->acct, 0,
+                         BLOCK_ACCT_FLUSH);
+        cb = r->req.sg ? scsi_dma_complete : scsi_write_complete;
+        r->req.aiocb = blk_aio_flush(s->qdev.conf.blk, cb, r);
         return;
     }
 
@@ -2391,7 +2367,7 @@ static int32_t scsi_disk_dma_command(SCSIRequest *req, uint8_t *buf)
         scsi_check_condition(r, SENSE_CODE(LBA_OUT_OF_RANGE));
         return 0;
     }
-    r->need_fua_emulation = sdc->need_fua_emulation(&r->req.cmd);
+    r->need_fua = sdc->need_fua(&r->req.cmd);
     if (r->sector_count == 0) {
         scsi_req_complete(&r->req, GOOD);
     }
@@ -3137,7 +3113,8 @@ BlockAIOCB *scsi_dma_writev(int64_t offset, QEMUIOVector *iov,
 {
     SCSIDiskReq *r = opaque;
     SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, r->req.dev);
-    return blk_aio_pwritev(s->qdev.conf.blk, offset, iov, 0, cb, cb_opaque);
+    int flags = r->need_fua ? BDRV_REQ_FUA : 0;
+    return blk_aio_pwritev(s->qdev.conf.blk, offset, iov, flags, cb, cb_opaque);
 }
 
 static char *scsi_property_get_loadparm(Object *obj, Error **errp)
@@ -3186,7 +3163,7 @@ static void scsi_disk_base_class_initfn(ObjectClass *klass, const void *data)
     device_class_set_legacy_reset(dc, scsi_disk_reset);
     sdc->dma_readv = scsi_dma_readv;
     sdc->dma_writev = scsi_dma_writev;
-    sdc->need_fua_emulation = scsi_is_cmd_fua;
+    sdc->need_fua  = scsi_is_cmd_fua;
 }
 
 static const TypeInfo scsi_disk_base_info = {
@@ -3338,7 +3315,7 @@ static void scsi_block_class_initfn(ObjectClass *klass, const void *data)
     sdc->dma_readv   = scsi_block_dma_readv;
     sdc->dma_writev  = scsi_block_dma_writev;
     sdc->update_sense = scsi_block_update_sense;
-    sdc->need_fua_emulation = scsi_block_no_fua;
+    sdc->need_fua    = scsi_block_no_fua;
     dc->desc = "SCSI block device passthrough";
     device_class_set_props(dc, scsi_block_properties);
     dc->vmsd  = &vmstate_scsi_disk_state;
-- 
2.49.0


