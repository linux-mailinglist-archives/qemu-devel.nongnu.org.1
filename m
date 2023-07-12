Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 043CB7509DC
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 15:45:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJa8a-0002Xb-95; Wed, 12 Jul 2023 09:44:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1qJa8X-0002XA-V1
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 09:44:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1qJa8W-0002Ze-8x
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 09:44:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689169447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s9aMupYmNN0Xiu9XjEFaMh2461cUjzeIVCaTLR5usdQ=;
 b=T6n3NJncm3fPquYyhhO1PoqSuPHoVtcyF7D/Y/B6u788acY4HAtR/kOcwY9n95EYjrFPFN
 /6Gvvqj6lNfqQDRbuaLrQkXdnkiutyJD6PdtfSDYXM9lSiSKEYAMpk+79MiAr6GrCX6anq
 3vueQnm+/LCSC4RIk+u30lyIhmVErxE=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-6iehIVldMuidtAkPZXEtAQ-1; Wed, 12 Jul 2023 09:44:05 -0400
X-MC-Unique: 6iehIVldMuidtAkPZXEtAQ-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-94a35b0d4ceso401935866b.3
 for <qemu-devel@nongnu.org>; Wed, 12 Jul 2023 06:44:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689169444; x=1691761444;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s9aMupYmNN0Xiu9XjEFaMh2461cUjzeIVCaTLR5usdQ=;
 b=HVGZNyUtFrvxmVQ9L4L4LyBUQcj//IIpvMtUhsSTucIAkvVF7iDpGaMcteXpsu0alf
 gsVqlaBaVWmSof6bkQBIQIkqS7SF/B2xpPeeQTgEMlCSwwy69WW0ept7Zn1YrF3DZ/4f
 6OcPyrFW1ylSwBFIDtVCjeAtxGV1Ki6eCduvQn4dMsIp+oweTklIS0TOzCsKp4UReJyI
 LV0BeYpghw8tNjnvoirvVsWzJzs3SebMUsNAEGnLufARMOp58N7kmjph3mWSJzjhkL2V
 MofAYzCSoSZzrJ5yLQsZUbS6KwcyPE6Bdseb0MwnoPxzz6slJYFEYYBe4ZcWHCqWLK6m
 oh+A==
X-Gm-Message-State: ABy/qLYh4EsF0+o+797/kTPUMAVssaochMnGE6YLZdI34S6hdYH0AVcU
 3p6SG9LtZMfWDStvOZYXdaMkW++Wy+zkP2tSyN+SoYehgKKiRWDyUUo4kWW8JnqjXo59vfOy4oG
 C3fkYyP+GASQ051KZ2wUPDEVhGTKGQPYt9NQBxCvwFTNXsPnZeam6Wr4n0k1j9JHnxxQH/FR7Bu
 8=
X-Received: by 2002:a17:907:b9d3:b0:993:6382:6e34 with SMTP id
 xa19-20020a170907b9d300b0099363826e34mr15482205ejc.72.1689169444256; 
 Wed, 12 Jul 2023 06:44:04 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHso9fjy3BFLz7SDgq4IL0TJ87+yDLxF3B7jADKfkoP4bGyDyccU1S7Xb/4+0uAnDOhdMPzww==
X-Received: by 2002:a17:907:b9d3:b0:993:6382:6e34 with SMTP id
 xa19-20020a170907b9d300b0099363826e34mr15482174ejc.72.1689169443737; 
 Wed, 12 Jul 2023 06:44:03 -0700 (PDT)
Received: from localhost.localdomain
 (host-82-53-134-6.retail.telecomitalia.it. [82.53.134.6])
 by smtp.gmail.com with ESMTPSA id
 e19-20020a170906081300b009929d998ab6sm2568035ejd.131.2023.07.12.06.44.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jul 2023 06:44:03 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mike Christie <michael.christie@oracle.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Mark Kanda <mark.kanda@oracle.com>, Fam Zheng <fam@euphon.net>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH 1/3] scsi: fetch unit attention when creating the request
Date: Wed, 12 Jul 2023 15:43:50 +0200
Message-ID: <20230712134352.118655-2-sgarzare@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230712134352.118655-1-sgarzare@redhat.com>
References: <20230712134352.118655-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
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

Commit 1880ad4f4e ("virtio-scsi: Batched prepare for cmd reqs") split
calls to scsi_req_new() and scsi_req_enqueue() in the virtio-scsi device.
This had no drawback, until commit 8cc5583abe ("virtio-scsi: Send
"REPORTED LUNS CHANGED" sense data upon disk hotplug events") added a
bus unit attention.

Having the two calls separated, all requests in the batch were prepared
calling scsi_req_new() to report a sense.
Then only the first one submitted calling scsi_req_enqueue() reported the
right sense and reset it to NO_SENSE.
The others reported NO_SENSE, causing SCSI errors in Linux.

To solve this issue, let's fetch the unit attention as early as possible
when we prepare the request, that way only the first request in the batch
will carry the right sense.

Fixes: 1880ad4f4e ("virtio-scsi: Batched prepare for cmd reqs")
Fixes: 8cc5583abe ("virtio-scsi: Send "REPORTED LUNS CHANGED" sense data upon disk hotplug events")
Reported-by: Thomas Huth <thuth@redhat.com>
Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=2176702
Co-developed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 include/hw/scsi/scsi.h |  1 +
 hw/scsi/scsi-bus.c     | 36 +++++++++++++++++++++++++++++++++---
 2 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/include/hw/scsi/scsi.h b/include/hw/scsi/scsi.h
index e2bb1a2fbf..3692ca82f3 100644
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
diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index f80f4cb4fc..f083373021 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -412,19 +412,35 @@ static const struct SCSIReqOps reqops_invalid_opcode = {
 
 /* SCSIReqOps implementation for unit attention conditions.  */
 
-static int32_t scsi_unit_attention(SCSIRequest *req, uint8_t *buf)
+static void scsi_fetch_unit_attention_sense(SCSIRequest *req)
 {
+    SCSISense *ua = NULL;
+
     if (req->dev->unit_attention.key == UNIT_ATTENTION) {
-        scsi_req_build_sense(req, req->dev->unit_attention);
+        ua = &req->dev->unit_attention;
     } else if (req->bus->unit_attention.key == UNIT_ATTENTION) {
-        scsi_req_build_sense(req, req->bus->unit_attention);
+        ua = &req->bus->unit_attention;
     }
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
+static int32_t scsi_unit_attention(SCSIRequest *req, uint8_t *buf)
+{
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
-- 
2.41.0


