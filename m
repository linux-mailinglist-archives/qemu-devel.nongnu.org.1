Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F9619483E3
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Aug 2024 23:11:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sb4xM-0000cp-JT; Mon, 05 Aug 2024 17:09:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sb4xG-0000Jx-4s
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 17:09:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sb4xB-0008TK-4z
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 17:09:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722892153;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zyK8ju1u2MVFTs7Yjc1l/lw6D/rg7JG4csNR18vJ5LQ=;
 b=V417U7dHR2BIyn5Blda7iFsO8/Lem2MKjYRDVQLDnfLcUt6AsljnK5PvvFOy8BiSjsw2cS
 o1S/99ZoyxwXYUbt3ICo1kNEbzrI8AtBRb4ZkhRa8so4mumWrK1nV9czAh7M5NrgO/t86Q
 z0FTYqXKGSfEuzh/ty/sZOe2Xyt65Lo=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-587-zkjWd7XXNYarRqZOBdrxFA-1; Mon,
 05 Aug 2024 17:09:10 -0400
X-MC-Unique: zkjWd7XXNYarRqZOBdrxFA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DFFAF1955D48; Mon,  5 Aug 2024 21:09:09 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.193.224])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5A54B30001AA; Mon,  5 Aug 2024 21:09:07 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 04/13] scsi-disk: Use positive return value for status in
 dma_readv/writev
Date: Mon,  5 Aug 2024 23:08:42 +0200
Message-ID: <20240805210851.314076-5-kwolf@redhat.com>
In-Reply-To: <20240805210851.314076-1-kwolf@redhat.com>
References: <20240805210851.314076-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

In some error cases, scsi_block_sgio_complete() never calls the passed
callback, but directly completes the request. This leads to bugs because
its error paths are not exact copies of what the callback would normally
do.

In preparation to fix this, allow passing positive return values to the
callbacks that represent the status code that should be used to complete
the request.

scsi_handle_rw_error() already handles positive values for its ret
parameter because scsi_block_sgio_complete() calls directly into it.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20240731123207.27636-2-kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 hw/scsi/scsi-disk.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index a67092db6a..3ff6798bde 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -65,6 +65,10 @@ OBJECT_DECLARE_TYPE(SCSIDiskState, SCSIDiskClass, SCSI_DISK_BASE)
 
 struct SCSIDiskClass {
     SCSIDeviceClass parent_class;
+    /*
+     * Callbacks receive ret == 0 for success. Errors are represented either as
+     * negative errno values, or as positive SAM status codes.
+     */
     DMAIOFunc       *dma_readv;
     DMAIOFunc       *dma_writev;
     bool            (*need_fua_emulation)(SCSICommand *cmd);
@@ -283,7 +287,7 @@ static bool scsi_disk_req_check_error(SCSIDiskReq *r, int ret, bool acct_failed)
         return true;
     }
 
-    if (ret < 0) {
+    if (ret != 0) {
         return scsi_handle_rw_error(r, ret, acct_failed);
     }
 
@@ -360,7 +364,7 @@ static void scsi_write_do_fua(SCSIDiskReq *r)
 static void scsi_dma_complete_noio(SCSIDiskReq *r, int ret)
 {
     assert(r->req.aiocb == NULL);
-    if (scsi_disk_req_check_error(r, ret, false)) {
+    if (scsi_disk_req_check_error(r, ret, ret > 0)) {
         goto done;
     }
 
@@ -385,9 +389,10 @@ static void scsi_dma_complete(void *opaque, int ret)
     assert(r->req.aiocb != NULL);
     r->req.aiocb = NULL;
 
+    /* ret > 0 is accounted for in scsi_disk_req_check_error() */
     if (ret < 0) {
         block_acct_failed(blk_get_stats(s->qdev.conf.blk), &r->acct);
-    } else {
+    } else if (ret == 0) {
         block_acct_done(blk_get_stats(s->qdev.conf.blk), &r->acct);
     }
     scsi_dma_complete_noio(r, ret);
@@ -403,7 +408,7 @@ static void scsi_read_complete_noio(SCSIDiskReq *r, int ret)
            qemu_get_current_aio_context());
 
     assert(r->req.aiocb == NULL);
-    if (scsi_disk_req_check_error(r, ret, false)) {
+    if (scsi_disk_req_check_error(r, ret, ret > 0)) {
         goto done;
     }
 
@@ -424,9 +429,10 @@ static void scsi_read_complete(void *opaque, int ret)
     assert(r->req.aiocb != NULL);
     r->req.aiocb = NULL;
 
+    /* ret > 0 is accounted for in scsi_disk_req_check_error() */
     if (ret < 0) {
         block_acct_failed(blk_get_stats(s->qdev.conf.blk), &r->acct);
-    } else {
+    } else if (ret == 0) {
         block_acct_done(blk_get_stats(s->qdev.conf.blk), &r->acct);
         trace_scsi_disk_read_complete(r->req.tag, r->qiov.size);
     }
@@ -534,7 +540,7 @@ static void scsi_write_complete_noio(SCSIDiskReq *r, int ret)
            qemu_get_current_aio_context());
 
     assert (r->req.aiocb == NULL);
-    if (scsi_disk_req_check_error(r, ret, false)) {
+    if (scsi_disk_req_check_error(r, ret, ret > 0)) {
         goto done;
     }
 
@@ -562,9 +568,10 @@ static void scsi_write_complete(void * opaque, int ret)
     assert (r->req.aiocb != NULL);
     r->req.aiocb = NULL;
 
+    /* ret > 0 is accounted for in scsi_disk_req_check_error() */
     if (ret < 0) {
         block_acct_failed(blk_get_stats(s->qdev.conf.blk), &r->acct);
-    } else {
+    } else if (ret == 0) {
         block_acct_done(blk_get_stats(s->qdev.conf.blk), &r->acct);
     }
     scsi_write_complete_noio(r, ret);
-- 
2.45.2


