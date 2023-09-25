Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 102BC7ADA5E
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 16:49:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkmsp-0000du-Hv; Mon, 25 Sep 2023 10:48:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qkmsP-0000ZX-MW
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 10:48:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qkmsN-00082j-Md
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 10:47:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695653274;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=pB/+oAlvM0PMibN+xNHGS68dbXihDZgvECTdvH0ZLeY=;
 b=clqr4OCNdIPoVDhsIg/nXG9jL/pKRhTOJfKWdSs+x6aYIb9XFrcRJziVTPmzqovQoNwepm
 S+DbCIloqJf7RteUGczsMIoigriCrfKqkIbXWvNSWIcyA1o0oSTWJwqrA8e+qo5b8lHyLe
 DTYBm6+TuflOT/hWY6MYcsN70Wqoag0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-wq4vAZnmOAajlyq0NhAkjg-1; Mon, 25 Sep 2023 10:47:52 -0400
X-MC-Unique: wq4vAZnmOAajlyq0NhAkjg-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3232c3df248so1282342f8f.3
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 07:47:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695653270; x=1696258070;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pB/+oAlvM0PMibN+xNHGS68dbXihDZgvECTdvH0ZLeY=;
 b=xI0SdOMEfRQzT3UmJTTAwDcgwP712CnoiSRMO5fiAqxE3ZuRaH6nHtzy85/0YBpnqw
 ZhfyfDYcJul1i3++OBBcZ6y3KQH3C55ZfWXMGFUbdfqC40G4sBtp+LY7Mb/LBz95x06c
 hs32WW3/DQeJr8sOnJNob9zd57pRo3XIxqXXL1TWaskPBGVDJGdwKpjYMNyc+vfJjQRz
 0CUG5dvZvDoS7v1fl3zpKbF4w0ZdeCmXZXUXydAYordF6quA5YHnvQPPf8HsqaNY3EGe
 EepgKKfzc1Qfmcq1JznQS3Wt9z0hW1E+4zZJ4rRrpmogSa0s/Vg1pOaf2qLMxdxYoYa0
 mZ5Q==
X-Gm-Message-State: AOJu0YwQWKXVQPlgdawkrn+TSMQpi/1kbyPsu4G0kAj8j1eLB5B8HadW
 afIEpVa+SPSuAn+XEOnacVxiiAHpsxF0ANpxubzlpRSifM78m28FS8xVZtv/2PEFxupYhDDqsOE
 76bnPDEsJlQfBN4S8MQpGAVYRL77k/dUy0R0CRR11ZCtWrcZVuZKxT6Eb7UjtAMq3ytZLhI3+OJ
 A=
X-Received: by 2002:a7b:cd85:0:b0:400:57d1:4911 with SMTP id
 y5-20020a7bcd85000000b0040057d14911mr5834315wmj.16.1695653270575; 
 Mon, 25 Sep 2023 07:47:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSqZQkbQ+yIuZh0y6s3HwcLbF+L/4xxKsLj7CqQPLp7ueFAMP98jO83X5X8f2Z+FoFlzc9Hw==
X-Received: by 2002:a7b:cd85:0:b0:400:57d1:4911 with SMTP id
 y5-20020a7bcd85000000b0040057d14911mr5834302wmj.16.1695653270195; 
 Mon, 25 Sep 2023 07:47:50 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 c9-20020a05600c0ac900b003fbb25da65bsm12499690wmr.30.2023.09.25.07.47.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 07:47:48 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com
Subject: [PATCH] m48t59-test: remove shadowed variables and cleanup
Date: Mon, 25 Sep 2023 16:47:40 +0200
Message-ID: <20230925144744.527958-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_SUBJ_WIPE_DEBT=1.004 autolearn=no autolearn_force=no
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

Rename the variable "s" and, while at it, avoid the chance of an overflow in the
computation of ABS(t - s).

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/qtest/m48t59-test.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/tests/qtest/m48t59-test.c b/tests/qtest/m48t59-test.c
index 843d2ced8e2..6c0b3dd6463 100644
--- a/tests/qtest/m48t59-test.c
+++ b/tests/qtest/m48t59-test.c
@@ -192,19 +192,22 @@ static void bcd_check_time(void)
     }
 
     if (!(tm_cmp(&start, datep) <= 0 && tm_cmp(datep, &end) <= 0)) {
-        long t, s;
+        long date_s, start_s;
+        unsigned long diff;
 
         start.tm_isdst = datep->tm_isdst;
 
-        t = (long)mktime(datep);
-        s = (long)mktime(&start);
-        if (t < s) {
-            g_test_message("RTC is %ld second(s) behind wall-clock", (s - t));
+        date_s = (long)mktime(datep);
+        start_s = (long)mktime(&start);
+        if (date_s < start_s) {
+            diff = start_s - date_s;
+            g_test_message("RTC is %ld second(s) behind wall-clock", diff);
         } else {
-            g_test_message("RTC is %ld second(s) ahead of wall-clock", (t - s));
+            diff = date_s - start_s;
+            g_test_message("RTC is %ld second(s) ahead of wall-clock", diff);
         }
 
-        g_assert_cmpint(ABS(t - s), <=, wiggle);
+        g_assert_cmpint(diff, <=, wiggle);
     }
 
     qtest_quit(s);
-- 
2.41.0


