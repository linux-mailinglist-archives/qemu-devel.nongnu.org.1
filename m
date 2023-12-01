Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA6578010FD
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 18:18:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r977P-00030m-Cd; Fri, 01 Dec 2023 12:15:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r976x-0002r2-TC
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 12:15:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r976u-0007gG-03
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 12:15:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701450926;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CqGUbUKz1J6foLX0wqsHp2msAP52n1m0k2H2ScM6SAM=;
 b=CnrT+iMDmx036ijdLykAXPWap8/vle3zKlDwzqzh+GG6vy11B3El326qDm0If1OENDOcZd
 e6QOA5/LVvSHbYukuRLgfcuxOlYKMZylxJTFdsVBDhOr9YocmCIYkcEWqGql8C5wiuuA/G
 Mr6SA9lxrOpSJbfURrP1v2r16Qrpu4Q=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-U07wH23pO_6wAX3TJkTE1Q-1; Fri, 01 Dec 2023 12:15:18 -0500
X-MC-Unique: U07wH23pO_6wAX3TJkTE1Q-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-40b554730c5so16577195e9.0
 for <qemu-devel@nongnu.org>; Fri, 01 Dec 2023 09:15:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701450916; x=1702055716;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CqGUbUKz1J6foLX0wqsHp2msAP52n1m0k2H2ScM6SAM=;
 b=D3Pyg/LyX+2pL1v9ubtScVJs+HazkaYEi/MhhJdKF9FqZMSYKgdcz+joUr+ZgJiYbZ
 leupxHNIpRfUJgUVAcCPXHy6HCVyEhKpyyBxi7JgX7/Qind6FO9Fbi0/XC+BJsHaOdsW
 dU2R1nlg45QMDUbyiMmcDu/MZ4aQyV/3nqauA8hOIuWiU26k5PwKT78Jom9vTkxHYyRe
 bDYQ5SDTXw2LpVpfVfYbKev5HSgLDRw8/BQmpa4yQNm68+ouZjr231jdFVOegTGG8pa7
 NPbmv3nhTtmnrL1w5IHTpFnE3KSE4gMwJHXRZW5OH75G126WxcxQTvuMeQqIetbvPXGb
 lpBA==
X-Gm-Message-State: AOJu0YxFsfNxasmdxqjazioLLhoYeHbH+uVJWYe7ygOEDjmF2Fr7K21L
 TlaRqOquovDlo7hBODhhX1CUAm1yfLzFdYmhnDNrZKw/zEwNerPi5h12objDUoVcouGCnwDyIvh
 JK80FucQsFgJaelbTv8gHpPOTHiywEkl4igxba1k+LOgU/wqZ+STwIoNvKumHFxATUHCC
X-Received: by 2002:a05:600c:46c7:b0:40b:5e1c:5c1e with SMTP id
 q7-20020a05600c46c700b0040b5e1c5c1emr573631wmo.51.1701450916558; 
 Fri, 01 Dec 2023 09:15:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IExs/mykcIw0CtZBDHfb+ecvZnNMbPVi4t7USW4RiVMWZWjsx3JQapD39Wf+Ibi3ESiGgpCUg==
X-Received: by 2002:a05:600c:46c7:b0:40b:5e1c:5c1e with SMTP id
 q7-20020a05600c46c700b0040b5e1c5c1emr573623wmo.51.1701450916154; 
 Fri, 01 Dec 2023 09:15:16 -0800 (PST)
Received: from redhat.com ([2a06:c701:73e1:6f00:c7ce:b553:4096:d504])
 by smtp.gmail.com with ESMTPSA id
 j11-20020a05600c190b00b0040b47c69d08sm9663134wmq.18.2023.12.01.09.15.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Dec 2023 09:15:15 -0800 (PST)
Date: Fri, 1 Dec 2023 12:15:14 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 02/15] netdev: set timeout depending on loadavg
Message-ID: <cadfc7293977ecadc2d6c48d7cffc553ed2f85f1.1701450838.git.mst@redhat.com>
References: <cover.1701450838.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1701450838.git.mst@redhat.com>
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


