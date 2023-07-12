Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E677509DF
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 15:45:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJa8p-0002Zb-V1; Wed, 12 Jul 2023 09:44:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1qJa8f-0002YZ-K9
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 09:44:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1qJa8d-0002b6-VZ
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 09:44:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689169455;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4nl9r8RrPFumzNpG2l6zIAWnHuTPJLt25EVA/SzjGHM=;
 b=c1sjLC22iGhqcAQNgR2HiyyXInFUmfKmsbCNsYcbpB2yTwm2tIoXk1cNRA3b2nARu73Oic
 c/r7nhbrm9aRfrctBnUbHM2ZF0LHDcAcVUCxGLJqnUcxUt35bJgd5j0CszPvfeYXGqO4iU
 mX/J3ZUbBU+uh0aFZI2s+1AGvwn45dE=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-Jki_zHLhNNG4V5wxBLJoQg-1; Wed, 12 Jul 2023 09:44:14 -0400
X-MC-Unique: Jki_zHLhNNG4V5wxBLJoQg-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2b6fbf1305fso68981471fa.2
 for <qemu-devel@nongnu.org>; Wed, 12 Jul 2023 06:44:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689169452; x=1691761452;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4nl9r8RrPFumzNpG2l6zIAWnHuTPJLt25EVA/SzjGHM=;
 b=fLxef1Ky2XJ32VH9xfi1faxNe3uIcIduh33m9cxDfO/1wVPzS1h+ckhsua6ZCnUITf
 xXpXTTORjfnXmEt1Z1fieeKk9crBwSydj+xyai4h4xBnZpIKdv6JHd8Iwo7vK2MqqQuK
 5CBH2A5FOCV1JNQbVvBREpjVRFMHvjGNQgzG3WkOMwM00cR+Bo8goD5Nl4y0A3E/qKIt
 zQwdJ1fNDTHjS7etHJaQuH8n5q0BzweJYTjCqARArxnxJyZVilVoRkCAbVI8Xptcg9nF
 wqwhMT7xBs0YQGzy02GEWcy3CUS13l2rNCCkb/7V34PL854CYhQ+oLL83C2gkJ/uBttw
 am1Q==
X-Gm-Message-State: ABy/qLZMHth9YBaWN9qSBP0CEBmZNg/ygV69X8BzprcJ1e0ucAuDJoEy
 qaGwAYtR+U/HUNfcuK3/FM6ISZzhLQgzMiNvWpbwff9wwvtHnrjEqCTHxZF0QFE4Malnzg+ZK4q
 Nl418vMHmpZJluuB9u2A0mp+1Q+Zdx9DCUzSaZWYtdfm7SfHVUI36FSi2jA8lkgwwQWCX4CiSPL
 0=
X-Received: by 2002:a2e:8455:0:b0:2b6:fca2:fc6e with SMTP id
 u21-20020a2e8455000000b002b6fca2fc6emr12907936ljh.42.1689169452055; 
 Wed, 12 Jul 2023 06:44:12 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF/0bkrrvsQwMdPQfkJ91FxfdlwumdlVtGWAIDfOTZDIbn4JkewFvae9vz4Br2RdgBZwenm9w==
X-Received: by 2002:a2e:8455:0:b0:2b6:fca2:fc6e with SMTP id
 u21-20020a2e8455000000b002b6fca2fc6emr12907906ljh.42.1689169451576; 
 Wed, 12 Jul 2023 06:44:11 -0700 (PDT)
Received: from localhost.localdomain
 (host-82-53-134-6.retail.telecomitalia.it. [82.53.134.6])
 by smtp.gmail.com with ESMTPSA id
 d2-20020a1709064c4200b0099290e2c15esm2595893ejw.75.2023.07.12.06.44.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jul 2023 06:44:10 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mike Christie <michael.christie@oracle.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Mark Kanda <mark.kanda@oracle.com>, Fam Zheng <fam@euphon.net>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH 3/3] scsi: clear unit attention only for REPORT LUNS commands
Date: Wed, 12 Jul 2023 15:43:52 +0200
Message-ID: <20230712134352.118655-4-sgarzare@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230712134352.118655-1-sgarzare@redhat.com>
References: <20230712134352.118655-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

scsi_clear_unit_attention() now only handles REPORTED LUNS DATA HAS
CHANGED.

This only happens when we handle REPORT LUNS commands, so let's rename
the function in scsi_clear_reported_luns_changed() and call it only in
scsi_target_emulate_report_luns().

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 hw/scsi/scsi-bus.c | 34 +++++++++++-----------------------
 1 file changed, 11 insertions(+), 23 deletions(-)

diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index f9c95dfb50..fc4b77fdb0 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -22,6 +22,7 @@ static char *scsibus_get_fw_dev_path(DeviceState *dev);
 static void scsi_req_dequeue(SCSIRequest *req);
 static uint8_t *scsi_target_alloc_buf(SCSIRequest *req, size_t len);
 static void scsi_target_free_buf(SCSIRequest *req);
+static void scsi_clear_reported_luns_changed(SCSIRequest *req);
 
 static int next_scsi_bus;
 
@@ -518,6 +519,14 @@ static bool scsi_target_emulate_report_luns(SCSITargetReq *r)
 
     /* store the LUN list length */
     stl_be_p(&r->buf[0], len - 8);
+
+    /*
+     * If a REPORT LUNS command enters the enabled command state, [...]
+     * the device server shall clear any pending unit attention condition
+     * with an additional sense code of REPORTED LUNS DATA HAS CHANGED.
+     */
+    scsi_clear_reported_luns_changed(&r->req);
+
     return true;
 }
 
@@ -816,18 +825,10 @@ uint8_t *scsi_req_get_buf(SCSIRequest *req)
     return req->ops->get_buf(req);
 }
 
-static void scsi_clear_unit_attention(SCSIRequest *req)
+static void scsi_clear_reported_luns_changed(SCSIRequest *req)
 {
     SCSISense *ua;
 
-    /*
-     * scsi_fetch_unit_attention_sense() already cleaned the unit attention
-     * in this case.
-     */
-    if (req->ops == &reqops_unit_attention) {
-        return;
-    }
-
     if (req->dev->unit_attention.key == UNIT_ATTENTION) {
         ua = &req->dev->unit_attention;
     } else if (req->bus->unit_attention.key == UNIT_ATTENTION) {
@@ -836,13 +837,7 @@ static void scsi_clear_unit_attention(SCSIRequest *req)
         return;
     }
 
-    /*
-     * If a REPORT LUNS command enters the enabled command state, [...]
-     * the device server shall clear any pending unit attention condition
-     * with an additional sense code of REPORTED LUNS DATA HAS CHANGED.
-     */
-    if (req->cmd.buf[0] == REPORT_LUNS &&
-        ua->asc == SENSE_CODE(REPORTED_LUNS_CHANGED).asc &&
+    if (ua->asc == SENSE_CODE(REPORTED_LUNS_CHANGED).asc &&
         ua->ascq == SENSE_CODE(REPORTED_LUNS_CHANGED).ascq) {
         *ua = SENSE_CODE(NO_SENSE);
     }
@@ -1528,13 +1523,6 @@ void scsi_req_complete(SCSIRequest *req, int status)
         req->dev->sense_is_ua = false;
     }
 
-    /*
-     * Unit attention state is now stored in the device's sense buffer
-     * if the HBA didn't do autosense.  Clear the pending unit attention
-     * flags.
-     */
-    scsi_clear_unit_attention(req);
-
     scsi_req_ref(req);
     scsi_req_dequeue(req);
     req->bus->info->complete(req, req->residual);
-- 
2.41.0


