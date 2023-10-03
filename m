Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA757B6446
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 10:34:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnaoc-00039A-Ae; Tue, 03 Oct 2023 04:31:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qnaoL-0002N4-Mi
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 04:31:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qnao6-0000IZ-MM
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 04:31:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696321866;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7A7XLyUbLXuEVp9hnv5SZ1RtggfAbndCdpUl9H3FpLM=;
 b=Uy3ayEbpGTMCcuL55no3S7S5+7AgKs1S8eHRvnMbm8FAdxUCMpjzqEdoU5tMfZ1vzm+Xu7
 E7K5H/Jge9kcD59ihxlJSEk6YVzZFUyM/wymR0BJDzMoinrzI6R7rrqhWcP0E6XNWTbI4A
 MB0MFcZKUjW4yEjEZl4d3BlPqMBLG34=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-380-73b4WRdnOnukJYkHbvwDbA-1; Tue, 03 Oct 2023 04:31:04 -0400
X-MC-Unique: 73b4WRdnOnukJYkHbvwDbA-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-99c8bbc902eso49803666b.1
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 01:31:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696321863; x=1696926663;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7A7XLyUbLXuEVp9hnv5SZ1RtggfAbndCdpUl9H3FpLM=;
 b=WXjEfQPlXzHf7e5h9QDJPLqwR6TY+F/0nmhD9oCbHgk64bmBuNQXibqp66dxVjR5W4
 +Af8lqd09HhOj583jEPORK332RXiCHtqst0YKMCF0QwKTTatFEVdo4s/+Il7APF3u95q
 QSwRaXACVfcUTMdnoMzcq2XG1bd+jgYC62Sj28XQGn6Dd4SXSBxGCGoOdg0EDLWliI2k
 MTgPMwy3aBwlRBmMwke6H6tCMWH0kVvFhWfvo67g1s90GTjN0wvACrxBXgrjBQL6HOoG
 tvrM7ipL23lMvxY1oFTiqFQs9DiRUSgDG9asX/lANesPX7cc9najGpYCtwFWn0odazQr
 vUPQ==
X-Gm-Message-State: AOJu0Yx4RYwqn/EQTzaC8h444Lw1+zlAeRVFvs6b4OhNai1WvD+UxTZ1
 hrYNCnsNBGmGNlNR1QnQf6D6AuUDNKmgp6CpYZkeCtPwricKIlMrkih6B6Z2DQc7nekmnK/ykaZ
 KMgW7OUJhGL0f87NNUe0VtTnVr7yD1MubNQQs2geoW/X29e4aECq8aif8KGIH7BHmSdvVlzt6Yk
 E=
X-Received: by 2002:a17:907:7851:b0:9ae:594d:d3fc with SMTP id
 lb17-20020a170907785100b009ae594dd3fcmr10360331ejc.17.1696321863132; 
 Tue, 03 Oct 2023 01:31:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfmtkUmKpjTAgdFoBdR2hzXEUzDh5lLK2tDm3hIRuE8iHdNY1vY5iti9fTrGCPli7NUH0efQ==
X-Received: by 2002:a17:907:7851:b0:9ae:594d:d3fc with SMTP id
 lb17-20020a170907785100b009ae594dd3fcmr10360318ejc.17.1696321862798; 
 Tue, 03 Oct 2023 01:31:02 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 c2-20020a170906340200b009adcb6c0f0esm650772ejb.193.2023.10.03.01.31.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 01:31:01 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 10/24] scsi-disk: ensure that FORMAT UNIT commands are
 terminated
Date: Tue,  3 Oct 2023 10:30:27 +0200
Message-ID: <20231003083042.110065-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231003083042.110065-1-pbonzini@redhat.com>
References: <20231003083042.110065-1-pbonzini@redhat.com>
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

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Otherwise when a FORMAT UNIT command is issued, the SCSI layer can become
confused because it can find itself in the situation where it thinks there
is still data to be transferred which can cause the next emulated SCSI
command to fail.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Fixes: 6ab71761 ("scsi-disk: add FORMAT UNIT command")
Tested-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20230913204410.65650-4-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/scsi-disk.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 477ee2bcd47..6691f5edb84 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -1959,6 +1959,10 @@ static void scsi_disk_emulate_write_data(SCSIRequest *req)
         scsi_disk_emulate_write_same(r, r->iov.iov_base);
         break;
 
+    case FORMAT_UNIT:
+        scsi_req_complete(&r->req, GOOD);
+        break;
+
     default:
         abort();
     }
-- 
2.41.0


