Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F8DC75392B
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 13:01:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKGXM-00071V-ED; Fri, 14 Jul 2023 07:00:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qKGWy-0006wQ-A4
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 07:00:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qKGWv-0005Qa-Mv
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 07:00:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689332407;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QkRJ+F4DieJLRrlQngYFaFKy3DvilqMM9x+FgLX6gcw=;
 b=eIcNjMSSD92pIZoTo89zFveJhArv8E/NB+LpR/W3WIf1KgeuKI0nINYmahEt2wT5B8a+jF
 /NLwoVeYLXRl67aZMHBkA/PzOONJX0/dniBOsKGLLSnv2VJoyU0e3jbJJBmvp37Txsrrhu
 j+DZvnDDCtxls8C2gK2EPG1ZAQdjyak=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-LAWNQQ__ORi84JpxqP53gw-1; Fri, 14 Jul 2023 07:00:06 -0400
X-MC-Unique: LAWNQQ__ORi84JpxqP53gw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3fbe590234aso10281555e9.1
 for <qemu-devel@nongnu.org>; Fri, 14 Jul 2023 04:00:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689332404; x=1691924404;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QkRJ+F4DieJLRrlQngYFaFKy3DvilqMM9x+FgLX6gcw=;
 b=BKyopbnQWkmpF5pmoL7bYuBae/DM9DWUrUuKsJueo/pwqZ022uS0LoHd5AD3pOYRBU
 udKkGRR4CvyQuaPxQnIEPLGI7mKL4sFmIDPovQ6I5F+pV+Asr2mpZe/ymigIMQtxBCe8
 U4Tvs/HtDIq6/URe8kaQtZi9yf7f29VS13ie5eb/hzWE2m1APTzWDfbU6eQoYHkOL+pw
 85eZOiFBEC0jUxvdLpWiGzXhURmiD2g6lLBPXNQdUueyRsmBeZcv6wvx85nNzNUTsPzS
 AeNrnEawJGrdpkJJH5IQjvaR3aZXLeocmcYbQgiBqynn2mkyCvidhFy/6/ak8HBy/8mn
 llrA==
X-Gm-Message-State: ABy/qLaWWMeFemdUTlx6lSWebuUAmEgqxWJLbUT74LdIz26WnQuXWAx0
 ZeTn/LRZTJ//uzKUCmxFqheKIXRb7P9Xx4r4feSegac1/lBKXw94//SWwVSqKTEneq31nU9LIty
 PCJmW6EAE4BpZjUaO7EJtPmQrKpPNFn790ZWTQMdGNsNe4GC3D/xXfHa9gE39EDLK0qStikLRwt
 E=
X-Received: by 2002:a7b:ce08:0:b0:3f6:1474:905 with SMTP id
 m8-20020a7bce08000000b003f614740905mr4693773wmc.29.1689332404429; 
 Fri, 14 Jul 2023 04:00:04 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGWj0VGm3JepyZWhzlX+wPMh6dUs12IOgarpv+QC8YdCIm6R5DLXOje4Ljajs5gXh9i52RvXA==
X-Received: by 2002:a7b:ce08:0:b0:3f6:1474:905 with SMTP id
 m8-20020a7bce08000000b003f614740905mr4693747wmc.29.1689332404099; 
 Fri, 14 Jul 2023 04:00:04 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 n2-20020a05600c294200b003fbd9e390e1sm1120880wmd.47.2023.07.14.04.00.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Jul 2023 04:00:03 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL 5/5] scsi: clear unit attention only for REPORT LUNS commands
Date: Fri, 14 Jul 2023 12:59:53 +0200
Message-ID: <20230714105953.223485-6-pbonzini@redhat.com>
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

scsi_clear_unit_attention() now only handles REPORTED LUNS DATA HAS
CHANGED.

This only happens when we handle REPORT LUNS commands, so let's rename
the function in scsi_clear_reported_luns_changed() and call it only in
scsi_target_emulate_report_luns().

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Message-ID: <20230712134352.118655-4-sgarzare@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/scsi-bus.c | 34 +++++++++++-----------------------
 1 file changed, 11 insertions(+), 23 deletions(-)

diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index f9c95dfb50d..fc4b77fdb02 100644
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


