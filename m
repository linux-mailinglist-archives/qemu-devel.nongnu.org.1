Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5E37AF180
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 19:02:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlBPj-0002Bd-EQ; Tue, 26 Sep 2023 12:59:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qlBPU-00024z-6E
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 12:59:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qlBPQ-0006eq-W7
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 12:59:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695747580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o5TVdBN70p9N2jvFk5DaLfD5DUA1933o2O19WHIVc8s=;
 b=BipwVjAcF24YLIYhD4PFxkadnP/ANMh/sNeHz5b81URhPT468T9SEs8LeR/boUGdI9TTCP
 SGImlQaJ0Q0bOsXWO6NQWo//pUHX+/CURwY+RSnSwSC1i7AMGl3tcS+Nsr3P9hUMPll6hn
 rj45CpWTJrzsZrvdpen9y1yJBmFoRoA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-abXwVzgIOxKgbKiQC9PJ0w-1; Tue, 26 Sep 2023 12:59:38 -0400
X-MC-Unique: abXwVzgIOxKgbKiQC9PJ0w-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-314256aedcbso7454316f8f.0
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 09:59:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695747577; x=1696352377;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o5TVdBN70p9N2jvFk5DaLfD5DUA1933o2O19WHIVc8s=;
 b=Y8RSOPeesEUpH0STcTMt3PwXI8qHlV7zORSqc73iL0jyCM50hWfkJ844tMtWCijBOu
 pxD1MFWWvaXIdQzIdMi4oTIq3xw/q+2l4saMjrShWVoYP+HM4ip37RlfvQK9b7WUvqJX
 2F5yvao++K7fBKszDtfS2R8AvhRlORNi5S28jveUZOxNmpWvmajuDpPX24lFJQ1soKN/
 w7ZSurjK6TZupqcI4dc6d0GjP42QX/TOioQkPS8nG+MaCcyPL8ok8tfvBhxy8n2yFKay
 P/kV4hpaqXzp9l9MiNaRh0wHNSlinsmCKfJ64SiiAUh1gWrCchaFMeeEBIheWVS0L651
 WI8Q==
X-Gm-Message-State: AOJu0YwTVHT2BZYPtGHkFPBkQcJgusEwEBe82bdcV+3nnkNvpqnOvgwT
 tqVwnGQ6KSgKj7+cJmNAcVVRUZV2VfzEMvmQ3gXIfT5ThEgbdSHLR8/8jTNZZa4yYt2Ezgu1rYN
 Ue06sGxS8c+WuMh007LUgqpHZaapLOOaNENjX+9Hv5C15rrrfJLkeIIDxZq6XGabP8BXQuyDya8
 g=
X-Received: by 2002:a5d:5248:0:b0:31a:d9bc:47a2 with SMTP id
 k8-20020a5d5248000000b0031ad9bc47a2mr8834987wrc.53.1695747577028; 
 Tue, 26 Sep 2023 09:59:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFC2h0TCrnOLqkse1IiU2B5v1scLg7M2KrzLptcJ4TXJouyEAb+cyPHvzZmzvBh9ucaIzCjCg==
X-Received: by 2002:a5d:5248:0:b0:31a:d9bc:47a2 with SMTP id
 k8-20020a5d5248000000b0031ad9bc47a2mr8834975wrc.53.1695747576695; 
 Tue, 26 Sep 2023 09:59:36 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 e9-20020adfe7c9000000b003197efd1e7bsm1203641wrn.114.2023.09.26.09.59.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 09:59:36 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 10/19] m48t59-test: avoid possible overflow on ABS
Date: Tue, 26 Sep 2023 18:59:06 +0200
Message-ID: <20230926165915.738719-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230926165915.738719-1-pbonzini@redhat.com>
References: <20230926165915.738719-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Originally meant to avoid a shadowed variable "s", which was fixed by
renaming the outer declaration to "qts".  Avoid the chance of an overflow
in the computation of ABS(t - s).

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/qtest/m48t59-test.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/tests/qtest/m48t59-test.c b/tests/qtest/m48t59-test.c
index 9487faff1a4..b9cd209165a 100644
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
 
     qtest_quit(qts);
-- 
2.41.0


