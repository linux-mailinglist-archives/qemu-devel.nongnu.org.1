Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DBAC753929
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 13:01:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKGXM-0006y7-0n; Fri, 14 Jul 2023 07:00:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qKGWy-0006wP-9f
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 07:00:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qKGWu-0005Po-49
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 07:00:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689332405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aUUpVyvem0h6bs6GgVnJulj4BabiP67yC5AwU1dWwBk=;
 b=VQ9P1jkdYX+wPlXcxppRjGfUeySnr7xQYVmIoDEGyigGzoXSkpvrfcKixNmmZfA7FDg6c6
 Khy4OSAwfLZ+zfNDZO/jbS2oXPwMMXRHQukChXjlLpyo7SJV5qajOYmxtrDewBGsXEUyIO
 FFmo8vB6KSw87ak8W/NvNStElxjIZ8g=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-CJIvXzR8MNyj5MLyca2BQQ-1; Fri, 14 Jul 2023 07:00:04 -0400
X-MC-Unique: CJIvXzR8MNyj5MLyca2BQQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3fbcae05906so8810265e9.3
 for <qemu-devel@nongnu.org>; Fri, 14 Jul 2023 04:00:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689332402; x=1691924402;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aUUpVyvem0h6bs6GgVnJulj4BabiP67yC5AwU1dWwBk=;
 b=IzPaCHPvzFZIhZf+ySZFxQTLpqT0a2X9LFEKOjWM7Te0FH3CHpVpgYwgqO8Alfxogq
 1PXaVikHkUT1pveYIblZJxaOdSBChfX+ZOhJTOsH1DHHT9w9LqBWqwrsJkityfrCM5LT
 JiCO9rFr+NCtyoI07Z9cO7mt6XDdNHProhZkRtP6IigGwX2k+8PxelvT0fWzMxBt3j/5
 tDMOPkVUWItc8zi2MfPMxrUPWRb6wSWQRdM30sx5Q70uWBQPbcrJbdfQSBnBrlCgiK7i
 1UdKr1m7oKn1Srp6dXjKvWir0aXAjLEWhCg2gb0mpBngr8U38sshgCA5be4/4PgmcKZY
 n4ew==
X-Gm-Message-State: ABy/qLbymbcQ53ryfRw+WFE4rrR4Av+Dj6NJtE8tyPSOcliBqoHq9rxF
 WOEBR0PBkApz81gtnanBAoY8aLogMCLntT/ENtxhMIAfn3eEi0lfTsSA4/zGrCtZR2BzYdwpYe/
 fyznEDzzXEgqk+Nyisab2NgnCPclp7AH3pVYhUvdqHPPEc/d/K2etArqYydcGLYZbrS+kGdofxY
 w=
X-Received: by 2002:a5d:5223:0:b0:314:3856:8d99 with SMTP id
 i3-20020a5d5223000000b0031438568d99mr4672558wra.44.1689332402566; 
 Fri, 14 Jul 2023 04:00:02 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEYRraS/O1lcOdK6/p/xdZdTisLPYRZcJ3L8o8BSPAmcIJOClInQM51DO/08TffQLB1Idvq8g==
X-Received: by 2002:a5d:5223:0:b0:314:3856:8d99 with SMTP id
 i3-20020a5d5223000000b0031438568d99mr4672547wra.44.1689332402285; 
 Fri, 14 Jul 2023 04:00:02 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 p5-20020a5d4e05000000b003143d80d11dsm10460462wrt.112.2023.07.14.04.00.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Jul 2023 04:00:01 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL 4/5] scsi: cleanup scsi_clear_unit_attention()
Date: Fri, 14 Jul 2023 12:59:52 +0200
Message-ID: <20230714105953.223485-5-pbonzini@redhat.com>
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

The previous commit moved the unit attention clearing when we create
the request. So now we can clean scsi_clear_unit_attention() to handle
only the case of the REPORT LUNS command: this is the only case in
which a UNIT ATTENTION is cleared without having been reported.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Message-ID: <20230712134352.118655-3-sgarzare@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/scsi-bus.c | 28 ++++++----------------------
 1 file changed, 6 insertions(+), 22 deletions(-)

diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index f083373021c..f9c95dfb50d 100644
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


