Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D65753928
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 13:01:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKGXK-0006xq-OR; Fri, 14 Jul 2023 07:00:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qKGWw-0006wI-Ce
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 07:00:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qKGWs-0005Jl-7Z
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 07:00:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689332404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=62/T52h0VNBTSRACyMK7y1qz0HsHsDe8s3F7BViE+Lo=;
 b=HYyJgPt2aLZKKrFEJSlVNrRef8TyVGQIO5BnSOYLAKDgvdKvtTbjzaxqpr429kNDXpFQLn
 h7v7AQPxIgR4Wf3MewlwaED6QFSkg/lBKXvoMrlAowsbKYvUVz7dVmQUqDoY69yyNvSzzj
 FMXULNJ2Rvf/Y9uMgLfcInRrgJDgvzY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-336--AzEz3lFNf-LYLHrCDwV1w-1; Fri, 14 Jul 2023 07:00:02 -0400
X-MC-Unique: -AzEz3lFNf-LYLHrCDwV1w-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-314275b653eso1053505f8f.1
 for <qemu-devel@nongnu.org>; Fri, 14 Jul 2023 04:00:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689332401; x=1691924401;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=62/T52h0VNBTSRACyMK7y1qz0HsHsDe8s3F7BViE+Lo=;
 b=ajFe8DluGpQac6Rje8fcc0pKIYG8DqGsLqfy4EM/BvhUtxKyYCIqD4AxZcDhpjFveL
 MCN7FxqLYipY+36aNWlqBQViLDdnko2PqUtN00sDDjcF97fwm92ELAfZdBK0hufKTj2y
 +xLXcpjqqEefqaLsAHASXn7ZiWJe/2ENPjNiEsVIUVtFc87/N+jN6MGaWA+fbdOEeSYy
 glmwXSRVIGG+jumJ4C/rZbkZ+2hnEOpuu4bDPdD3U5j4gOclPUvARn3s/ak5IINDs63Q
 6M/CxqpoR8JlU2sB6I3XS5MIM4LXobQa/LSADdROObJ9Wd9rghnC13Sz80aVTkrtxkxy
 aW/g==
X-Gm-Message-State: ABy/qLb5yEYEIWwfeOkNpCO97lX7q0/eaHnWCtIZNAf+T1fJl7T2XfxS
 TMYTQyDK78LBBt8T9OK1g0cV3+dUUBulvNtrMamDeNma/HaDtBjMMJrwKaZQztYlYo5nkrnX2pM
 N0oUpSSMfNPp0neqfkZt+yS14ygQG4w3u/MRvwLTiUBYYKZhjHTBLphoy+Xy554ITNsWNy2Q0NR
 s=
X-Received: by 2002:a5d:66c5:0:b0:315:a34f:b520 with SMTP id
 k5-20020a5d66c5000000b00315a34fb520mr3359065wrw.71.1689332400906; 
 Fri, 14 Jul 2023 04:00:00 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFgs1Ofxo0aMu/qYN9JZtp4wevvNbWovcU7v70J/UD6td8NecV2T6IJOj7VXYgj3cSPsgyzXA==
X-Received: by 2002:a5d:66c5:0:b0:315:a34f:b520 with SMTP id
 k5-20020a5d66c5000000b00315a34fb520mr3359053wrw.71.1689332400531; 
 Fri, 14 Jul 2023 04:00:00 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 p5-20020a5d4e05000000b003143d80d11dsm10460377wrt.112.2023.07.14.03.59.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Jul 2023 03:59:59 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	Thomas Huth <thuth@redhat.com>
Subject: [PULL 3/5] scsi: fetch unit attention when creating the request
Date: Fri, 14 Jul 2023 12:59:51 +0200
Message-ID: <20230714105953.223485-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230714105953.223485-1-pbonzini@redhat.com>
References: <20230714105953.223485-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

From: Stefano Garzarella <sgarzare@redhat.com>

Commit 1880ad4f4e ("virtio-scsi: Batched prepare for cmd reqs") split
calls to scsi_req_new() and scsi_req_enqueue() in the virtio-scsi device.
No ill effects were observed until commit 8cc5583abe ("virtio-scsi: Send
"REPORTED LUNS CHANGED" sense data upon disk hotplug events") added a
unit attention that was easy to trigger with device hotplug and
hot-unplug.

Because the two calls were separated, all requests in the batch were
prepared calling scsi_req_new() to report a sense.  The first one
submitted would report the right sense and reset it to NO_SENSE, while
the others reported CHECK_CONDITION with no sense data.  This caused
SCSI errors in Linux.

To solve this issue, let's fetch the unit attention as early as possible
when we prepare the request, so that only the first request in the batch
will use the unit attention SCSIReqOps and the others will not report
CHECK CONDITION.

Fixes: 1880ad4f4e ("virtio-scsi: Batched prepare for cmd reqs")
Fixes: 8cc5583abe ("virtio-scsi: Send "REPORTED LUNS CHANGED" sense data upon disk hotplug events")
Reported-by: Thomas Huth <thuth@redhat.com>
Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=2176702
Co-developed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Message-ID: <20230712134352.118655-2-sgarzare@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/scsi-bus.c     | 40 +++++++++++++++++++++++++++++++++++-----
 include/hw/scsi/scsi.h |  1 +
 2 files changed, 36 insertions(+), 5 deletions(-)

diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index f80f4cb4fcf..f083373021c 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -412,19 +412,35 @@ static const struct SCSIReqOps reqops_invalid_opcode = {
 
 /* SCSIReqOps implementation for unit attention conditions.  */
 
+static void scsi_fetch_unit_attention_sense(SCSIRequest *req)
+{
+    SCSISense *ua = NULL;
+
+    if (req->dev->unit_attention.key == UNIT_ATTENTION) {
+        ua = &req->dev->unit_attention;
+    } else if (req->bus->unit_attention.key == UNIT_ATTENTION) {
+        ua = &req->bus->unit_attention;
+    }
+
+    /*
+     * Fetch the unit attention sense immediately so that another
+     * scsi_req_new does not use reqops_unit_attention.
+     */
+    if (ua) {
+        scsi_req_build_sense(req, *ua);
+        *ua = SENSE_CODE(NO_SENSE);
+    }
+}
+
 static int32_t scsi_unit_attention(SCSIRequest *req, uint8_t *buf)
 {
-    if (req->dev->unit_attention.key == UNIT_ATTENTION) {
-        scsi_req_build_sense(req, req->dev->unit_attention);
-    } else if (req->bus->unit_attention.key == UNIT_ATTENTION) {
-        scsi_req_build_sense(req, req->bus->unit_attention);
-    }
     scsi_req_complete(req, CHECK_CONDITION);
     return 0;
 }
 
 static const struct SCSIReqOps reqops_unit_attention = {
     .size         = sizeof(SCSIRequest),
+    .init_req     = scsi_fetch_unit_attention_sense,
     .send_command = scsi_unit_attention
 };
 
@@ -699,6 +715,11 @@ SCSIRequest *scsi_req_alloc(const SCSIReqOps *reqops, SCSIDevice *d,
     object_ref(OBJECT(d));
     object_ref(OBJECT(qbus->parent));
     notifier_list_init(&req->cancel_notifiers);
+
+    if (reqops->init_req) {
+        reqops->init_req(req);
+    }
+
     trace_scsi_req_alloc(req->dev->id, req->lun, req->tag);
     return req;
 }
@@ -798,6 +819,15 @@ uint8_t *scsi_req_get_buf(SCSIRequest *req)
 static void scsi_clear_unit_attention(SCSIRequest *req)
 {
     SCSISense *ua;
+
+    /*
+     * scsi_fetch_unit_attention_sense() already cleaned the unit attention
+     * in this case.
+     */
+    if (req->ops == &reqops_unit_attention) {
+        return;
+    }
+
     if (req->dev->unit_attention.key != UNIT_ATTENTION &&
         req->bus->unit_attention.key != UNIT_ATTENTION) {
         return;
diff --git a/include/hw/scsi/scsi.h b/include/hw/scsi/scsi.h
index e2bb1a2fbfd..3692ca82f31 100644
--- a/include/hw/scsi/scsi.h
+++ b/include/hw/scsi/scsi.h
@@ -108,6 +108,7 @@ int cdrom_read_toc_raw(int nb_sectors, uint8_t *buf, int msf, int session_num);
 /* scsi-bus.c */
 struct SCSIReqOps {
     size_t size;
+    void (*init_req)(SCSIRequest *req);
     void (*free_req)(SCSIRequest *req);
     int32_t (*send_command)(SCSIRequest *req, uint8_t *buf);
     void (*read_data)(SCSIRequest *req);
-- 
2.41.0


