Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3211B7E3820
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 10:50:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0IiV-0005Yi-Pi; Tue, 07 Nov 2023 04:49:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0IiU-0005VI-Al
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 04:49:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0IiS-0006VU-P9
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 04:49:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699350588;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CqGUbUKz1J6foLX0wqsHp2msAP52n1m0k2H2ScM6SAM=;
 b=V2Z7K4LqJouPDdCW8/MdAuWe5l7gXfCF95rXWxEXQROEQwoayoVm+O5/QktEs8dwtYpa26
 WM8sOOFcJNC+YwboGEOTHoOLQa+U6CDXOqigLjltNOQuZ4rxO/H5y50xbMILow6fKBWl/a
 MXLzrS7B9IyzUpl/c0sTg9ZKEsW6dsg=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-riyc-tXWO9qsQEZEDz2GnQ-1; Tue, 07 Nov 2023 04:49:35 -0500
X-MC-Unique: riyc-tXWO9qsQEZEDz2GnQ-1
Received: by mail-yb1-f199.google.com with SMTP id
 3f1490d57ef6-da0c6d62ec8so6385218276.1
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 01:49:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699350574; x=1699955374;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CqGUbUKz1J6foLX0wqsHp2msAP52n1m0k2H2ScM6SAM=;
 b=g0gy/Qiz2GdmplVzSR9bigDRzeEwyVom0tvyCT516Qr6PbWaQjXDJu5M/teH8n5jBu
 PtUNEm6LmjWCTLYqWpTFsMJhQVf5VbjlWV5EEVLVU8wjjsX4w8fm8Lj5jC+FbVzwv5Kp
 BLdyODTZFaJYyF2wwknBOVqd3tNeUWCuKRufhL0/s0IAdrGZHNuQvPz+QARkgRx+e3n9
 4l7bkvN6gxlj9hcd8SFDb1shTAp7etFqmD9Vv6TPqZuQE0DUiSIyfAR4We/Xoj+4TyX9
 UD5Ok6kcG/T2LOY3AcUmK7bKFizhg2zqmTqz+oS7lO+DSudh/xp5YxxTQCs70HZFdKaS
 Q8QA==
X-Gm-Message-State: AOJu0Ywv+5eJdQW50AOh410TP2lFDnjvAm35EPXcaG/pcDYw1DZ0AHCr
 XIp3lvUmbZmRHn0QMPEV42BjzMa87rDmPedKhRBPVgxwrUr9wAFyZSuROgmm7STpG6XCMZf2QHN
 ePNgmFXDzQiy2bR0j7jEHXxAmR9Bw8EIIymX5HQ/7jOD5q6liVm9FkXXdO1EI5RWG2s+Z
X-Received: by 2002:a25:6b43:0:b0:d9b:3ed:41a5 with SMTP id
 o3-20020a256b43000000b00d9b03ed41a5mr30032179ybm.21.1699350574107; 
 Tue, 07 Nov 2023 01:49:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH0NjKgp7rs/qMhoZgxMsv8dWut6K7Cco+KvuEuwoghhI70UL/5jw2zPmbmEgSVjK1T1lZk5A==
X-Received: by 2002:a25:6b43:0:b0:d9b:3ed:41a5 with SMTP id
 o3-20020a256b43000000b00d9b03ed41a5mr30032159ybm.21.1699350573585; 
 Tue, 07 Nov 2023 01:49:33 -0800 (PST)
Received: from redhat.com ([2.55.5.143]) by smtp.gmail.com with ESMTPSA id
 h96-20020a25a569000000b00d9ace05037csm4972908ybi.13.2023.11.07.01.49.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 01:49:32 -0800 (PST)
Date: Tue, 7 Nov 2023 04:49:27 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH RFC 2/2] netdev: set timeout depending on loadavg
Message-ID: <eb33ee05432afacce29a70a2e3679aaacef723da.1699350487.git.mst@redhat.com>
References: <1e64d2a47b63ba7d7f49a23c02c2be91ff5c15fe.1699350487.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e64d2a47b63ba7d7f49a23c02c2be91ff5c15fe.1699350487.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

netdev test keeps failing sometimes.
I don't think we should increase the timeout some more:
let's try something else instead, testing how busy the
system is.

Seems to work for me.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/netdev-socket.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/netdev-socket.c b/tests/qtest/netdev-socket.c
index 7ba1eff120..bb99d08b5e 100644
--- a/tests/qtest/netdev-socket.c
+++ b/tests/qtest/netdev-socket.c
@@ -18,6 +18,32 @@
 
 #define CONNECTION_TIMEOUT    120
 
+static double connection_timeout(void)
+{
+    double load;
+    int ret = getloadavg(&load, 1);
+
+    /*
+     * If we can't get load data, or load is low because we just started
+     * running, assume load of 1 (we are alone in this system).
+     */
+    if (ret < 1 || load < 1.0) {
+        load = 1.0;
+    }
+    /*
+     * No one wants to wait more than 10 minutes for this test. Higher load?
+     * Too bad.
+     */
+    if (load > 10.0) {
+        fprintf(stderr, "Warning: load %f higher than 10 - test might timeout\n",
+                load);
+        load = 10.0;
+    }
+
+    /* if load is high increase timeout as we might not get a chance to run */
+    return load * CONNECTION_TIMEOUT;
+}
+
 #define EXPECT_STATE(q, e, t)                             \
 do {                                                      \
     char *resp = NULL;                                    \
@@ -31,7 +57,7 @@ do {                                                      \
         if (g_str_equal(resp, e)) {                       \
             break;                                        \
         }                                                 \
-    } while (g_test_timer_elapsed() < CONNECTION_TIMEOUT); \
+    } while (g_test_timer_elapsed() < connection_timeout()); \
     g_assert_cmpstr(resp, ==, e);                         \
     g_free(resp);                                         \
 } while (0)
-- 
MST


