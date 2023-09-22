Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB087AAE17
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 11:33:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjcW1-0004oT-UZ; Fri, 22 Sep 2023 05:32:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qjcVq-0004lo-O6
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 05:31:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qjcVo-0003O4-FC
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 05:31:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695375108;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eEsKc+d0fnRtLJHbjHGMBYA2mr0CMr95bGIl3yAmm50=;
 b=FBRD/UYElHClsQ6PyMm5QGf3uf1ZGBwz8crASAjdzPo9OtVws8OgY18xhIo11R6IbA87up
 Ll2f2gIYhzW0kw+9T9t47SJ9W8m2zD2dCE/LU3yhd7IuirORaPdJlIkVIPsmEaehdOyhBY
 YrBEmlpJKrlCif1Y8iShzdFe2oIoDD4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-MhcBZzHbOOGKQXsfeG7RRQ-1; Fri, 22 Sep 2023 05:31:46 -0400
X-MC-Unique: MhcBZzHbOOGKQXsfeG7RRQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-317d5b38194so229018f8f.0
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 02:31:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695375104; x=1695979904;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eEsKc+d0fnRtLJHbjHGMBYA2mr0CMr95bGIl3yAmm50=;
 b=PqSOU5wWTxVvfaMcWv0E+cQa26Jr1Kd02oXDf8lHTexVfuLAER61JZps95wKX3Vmkf
 EwizNB2ty0DnKk5CmeuwPq7UIVS/MFC7wK1dpF5Zq4pdjkNx+Zvts1VhFvIkQdyKxxKj
 9/dwXhmda3edVplnLYo+l1gncgBJ1x1ybnhdMWbi0bcAtba2tVI9HkC8OhKnBZfDnwv1
 hZ3deLR5eBDLYcuQsxKvrhmchUJU38WuKDmPGMcZYaoioIurCEqGiJVXQl+5msA0AO93
 tix6IXgn1zn7Uzc2nnv+Rh3ZDSx7cyzOtGiza1uLjKOGeJHVcy8PL98iDZvk8+T0Uf6x
 duFg==
X-Gm-Message-State: AOJu0YzvPXCN8kxXluL38IurYae5oiMU0uUBKiInCB/s3rs25MEV12Dp
 VVhr336voS33rE5Jr9EvS0BYqcCv+AegOFOhdiMQjOr+BNeRJr0UoCT/NU11k1IJ2ax+1s4e8gp
 XOCNEwz+ozb8AbKzKV2aF/y+0xPcICZiT1emKvYBWi3MG03vK016fT+F88jTfFTNvoISAi2vwKk
 o=
X-Received: by 2002:adf:ef52:0:b0:31f:eb45:462e with SMTP id
 c18-20020adfef52000000b0031feb45462emr1400995wrp.28.1695375104292; 
 Fri, 22 Sep 2023 02:31:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHeR5jrXWhnsMPOOKXW1BLxagC+Zy/yE9FSUT+O38G8GpLtw//HKsZGVFKKevpeUr7oZLh3+g==
X-Received: by 2002:adf:ef52:0:b0:31f:eb45:462e with SMTP id
 c18-20020adfef52000000b0031feb45462emr1400979wrp.28.1695375103953; 
 Fri, 22 Sep 2023 02:31:43 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 z16-20020a056000111000b003176eab8868sm3934201wrw.82.2023.09.22.02.31.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Sep 2023 02:31:42 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Martin Kletzander <mkletzan@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 09/12] tests/qtest: Specify audiodev= and -audiodev
Date: Fri, 22 Sep 2023 11:31:22 +0200
Message-ID: <20230922093126.264016-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230922093126.264016-1-pbonzini@redhat.com>
References: <20230922093126.264016-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Martin Kletzander <mkletzan@redhat.com>

This will enable removing deprecated default audiodev support.

I did not figure out how to make the audiodev represented as an
interface node, so this is a workaround.  I am not sure what would be
the proper way.

Signed-off-by: Martin Kletzander <mkletzan@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <6e7f2808dd40679a415812767b88f2a411fc137f.1650874791.git.mkletzan@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/qtest/es1370-test.c               |  3 ++-
 tests/qtest/fuzz/generic_fuzz_configs.h |  6 ++++--
 tests/qtest/intel-hda-test.c            | 15 ++++++++++-----
 3 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/tests/qtest/es1370-test.c b/tests/qtest/es1370-test.c
index 97ab65c4357..8387e74193b 100644
--- a/tests/qtest/es1370-test.c
+++ b/tests/qtest/es1370-test.c
@@ -46,7 +46,8 @@ static void *es1370_create(void *pci_bus, QGuestAllocator *alloc, void *addr)
 static void es1370_register_nodes(void)
 {
     QOSGraphEdgeOptions opts = {
-        .extra_device_opts = "addr=04.0",
+        .extra_device_opts = "addr=04.0,audiodev=audio0",
+        .before_cmd_line = "-audiodev driver=none,id=audio0",
     };
     add_qpci_address(&opts, &(QPCIAddress) { .devfn = QPCI_DEVFN(4, 0) });
 
diff --git a/tests/qtest/fuzz/generic_fuzz_configs.h b/tests/qtest/fuzz/generic_fuzz_configs.h
index 50689da6539..4d7c8ca4ece 100644
--- a/tests/qtest/fuzz/generic_fuzz_configs.h
+++ b/tests/qtest/fuzz/generic_fuzz_configs.h
@@ -106,8 +106,10 @@ const generic_fuzz_config predefined_configs[] = {
     },{
         .name = "intel-hda",
         .args = "-machine q35 -nodefaults -device intel-hda,id=hda0 "
-        "-device hda-output,bus=hda0.0 -device hda-micro,bus=hda0.0 "
-        "-device hda-duplex,bus=hda0.0",
+        "-audiodev driver=none,id=audio0",
+        "-device hda-output,bus=hda0.0,audiodev=audio0 "
+        "-device hda-micro,bus=hda0.0,audiodev=audio0 "
+        "-device hda-duplex,bus=hda0.0,audiodev=audio0",
         .objects = "intel-hda",
     },{
         .name = "ide-hd",
diff --git a/tests/qtest/intel-hda-test.c b/tests/qtest/intel-hda-test.c
index d4a8db6fd60..663bb6c4854 100644
--- a/tests/qtest/intel-hda-test.c
+++ b/tests/qtest/intel-hda-test.c
@@ -11,20 +11,24 @@
 #include "libqtest-single.h"
 
 #define HDA_ID "hda0"
-#define CODEC_DEVICES " -device hda-output,bus=" HDA_ID ".0" \
-                      " -device hda-micro,bus=" HDA_ID ".0" \
-                      " -device hda-duplex,bus=" HDA_ID ".0"
+#define AUDIODEV " -audiodev driver=none,id=audio0 "
+#define AUDIODEV_REF "audiodev=audio0"
+#define CODEC_DEVICES " -device hda-output,bus=" HDA_ID ".0," AUDIODEV_REF \
+                      " -device hda-micro,bus=" HDA_ID ".0," AUDIODEV_REF \
+                      " -device hda-duplex,bus=" HDA_ID ".0," AUDIODEV_REF
 
 /* Tests only initialization so far. TODO: Replace with functional tests */
 static void ich6_test(void)
 {
-    qtest_start("-machine pc -device intel-hda,id=" HDA_ID CODEC_DEVICES);
+    qtest_start(AUDIODEV "-machine pc -device intel-hda,id=" HDA_ID CODEC_DEVICES);
     qtest_end();
 }
 
 static void ich9_test(void)
 {
-    qtest_start("-machine q35 -device ich9-intel-hda,bus=pcie.0,addr=1b.0,id="
+    qtest_start("-machine q35"
+                AUDIODEV
+                "-device ich9-intel-hda,bus=pcie.0,addr=1b.0,id="
                 HDA_ID CODEC_DEVICES);
     qtest_end();
 }
@@ -39,6 +43,7 @@ static void test_issue542_ich6(void)
     QTestState *s;
 
     s = qtest_init("-nographic -nodefaults -M pc-q35-6.2 "
+                   AUDIODEV
                    "-device intel-hda,id=" HDA_ID CODEC_DEVICES);
 
     qtest_outl(s, 0xcf8, 0x80000804);
-- 
2.41.0


