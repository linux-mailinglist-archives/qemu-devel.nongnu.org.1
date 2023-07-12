Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 784477509DE
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 15:45:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJa8n-0002YL-I9; Wed, 12 Jul 2023 09:44:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1qJa8b-0002Xz-EP
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 09:44:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1qJa8Z-0002aE-TJ
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 09:44:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689169450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GQ/mOfPK6LROxwR4/v8NGbbNQBqo4JCfc2aPuyAhXlI=;
 b=JohvBBcUsxdIBg48t5dTLAok84rVyY/2xPAdOnTyEW22hWZ20DJW7Xr2JIJqMkTF6B5r56
 ZpVSVxnvkhBWTEG8z5w98Vw79LJnIA1o7izmkvliF+qPY7WQNr/o63ar65C504CjouxgMx
 F+38jZ2pH7dQau67hJCUctUqK8S9UO0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-EBqGScqcMsGYqY9VixpdSA-1; Wed, 12 Jul 2023 09:44:09 -0400
X-MC-Unique: EBqGScqcMsGYqY9VixpdSA-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-993c24f3246so105378466b.1
 for <qemu-devel@nongnu.org>; Wed, 12 Jul 2023 06:44:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689169448; x=1691761448;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GQ/mOfPK6LROxwR4/v8NGbbNQBqo4JCfc2aPuyAhXlI=;
 b=PAFz0rK2Atl96CBwbB3bRHKshaHXUgEvc7PrZfl7sQcNkF20g9MX6f3dwbu3UqGj/k
 Xfkjh+kLwHbcImYqLgAX12pg9I/otnBzInbsBPMqNfIvU2hv9Z9MT1UVrJTnm3ys/E+7
 YrP/iPuthgbzmWgRqYEPCqv/7DmuZdtICNZaFYRY6Z/v2jgfpFOXPXwcn0FWj1aY8S+7
 XohaD5twBV5R6oZJtGKkq5cW1d34/iiOWGtyvMkVD5THF4xtsJVEyGwD4aK6l3n58V5V
 MQ3zCLESlAautc1cOv5Uf7QRlOLqGY9JRLrIRxFTRi6S1GkEO2gW4vG8CuRnMmb7VhiJ
 VQtw==
X-Gm-Message-State: ABy/qLamgirC5BmtIOqcqgov/Lalh/M7AkXadCWQYZ2Bl6A489JNRJ5W
 KUaEd4CUQ/HJ5AePIBQ4u6JLQuVBBJkctEinYYbYcAZopCDW4VWgO+CuxjnBW1zabaIS5uWCCT8
 10B98Y5siEMjlKHalPKFduf2W6JDPVLQBhrwI0jaAKTrH5+JImlRQ11ZyvSs6SfErB+6I2dl4dX
 M=
X-Received: by 2002:a17:906:5352:b0:993:eee4:e704 with SMTP id
 j18-20020a170906535200b00993eee4e704mr2710891ejo.38.1689169447891; 
 Wed, 12 Jul 2023 06:44:07 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE1Gi5HZ+69llj4rGtYbFEzgMRK69+s+UN1zq/V4cAam2qZPYnMz9L0OKU5dtOKAF2Ou7siRA==
X-Received: by 2002:a17:906:5352:b0:993:eee4:e704 with SMTP id
 j18-20020a170906535200b00993eee4e704mr2710862ejo.38.1689169447642; 
 Wed, 12 Jul 2023 06:44:07 -0700 (PDT)
Received: from localhost.localdomain
 (host-82-53-134-6.retail.telecomitalia.it. [82.53.134.6])
 by smtp.gmail.com with ESMTPSA id
 qo11-20020a170907212b00b00992b0745548sm2553416ejb.152.2023.07.12.06.44.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jul 2023 06:44:06 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mike Christie <michael.christie@oracle.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Mark Kanda <mark.kanda@oracle.com>, Fam Zheng <fam@euphon.net>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH 2/3] scsi: cleanup scsi_clear_unit_attention()
Date: Wed, 12 Jul 2023 15:43:51 +0200
Message-ID: <20230712134352.118655-3-sgarzare@redhat.com>
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

The previous commit moved the unit attention clearing when we create
the request. So now we can clean scsi_clear_unit_attention() to handle
only the case of the REPORT LUNS command.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 hw/scsi/scsi-bus.c | 28 ++++++----------------------
 1 file changed, 6 insertions(+), 22 deletions(-)

diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index f083373021..f9c95dfb50 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -828,26 +828,12 @@ static void scsi_clear_unit_attention(SCSIRequest *req)
         return;
     }
 
-    if (req->dev->unit_attention.key != UNIT_ATTENTION &&
-        req->bus->unit_attention.key != UNIT_ATTENTION) {
-        return;
-    }
-
-    /*
-     * If an INQUIRY command enters the enabled command state,
-     * the device server shall [not] clear any unit attention condition;
-     * See also MMC-6, paragraphs 6.5 and 6.6.2.
-     */
-    if (req->cmd.buf[0] == INQUIRY ||
-        req->cmd.buf[0] == GET_CONFIGURATION ||
-        req->cmd.buf[0] == GET_EVENT_STATUS_NOTIFICATION) {
-        return;
-    }
-
     if (req->dev->unit_attention.key == UNIT_ATTENTION) {
         ua = &req->dev->unit_attention;
-    } else {
+    } else if (req->bus->unit_attention.key == UNIT_ATTENTION) {
         ua = &req->bus->unit_attention;
+    } else {
+        return;
     }
 
     /*
@@ -856,12 +842,10 @@ static void scsi_clear_unit_attention(SCSIRequest *req)
      * with an additional sense code of REPORTED LUNS DATA HAS CHANGED.
      */
     if (req->cmd.buf[0] == REPORT_LUNS &&
-        !(ua->asc == SENSE_CODE(REPORTED_LUNS_CHANGED).asc &&
-          ua->ascq == SENSE_CODE(REPORTED_LUNS_CHANGED).ascq)) {
-        return;
+        ua->asc == SENSE_CODE(REPORTED_LUNS_CHANGED).asc &&
+        ua->ascq == SENSE_CODE(REPORTED_LUNS_CHANGED).ascq) {
+        *ua = SENSE_CODE(NO_SENSE);
     }
-
-    *ua = SENSE_CODE(NO_SENSE);
 }
 
 int scsi_req_get_sense(SCSIRequest *req, uint8_t *buf, int len)
-- 
2.41.0


