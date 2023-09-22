Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E52A37AB4FB
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 17:43:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjiJ0-0001DG-F2; Fri, 22 Sep 2023 11:42:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qjiIy-00013a-0n
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 11:42:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qjiIv-0002pp-3n
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 11:42:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695397372;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eEsKc+d0fnRtLJHbjHGMBYA2mr0CMr95bGIl3yAmm50=;
 b=N5ut2L1By/OSu5Y3WRAAGnmD5/a/zV7lyndkDMONr21YCPL7mRZGCbjnMjB3ETa0M38AmF
 Wb9o6fD30J0teljJw3H6UpEyAZTzO3ER2aAYl5jzV4hKMWN2kaus5gKvnL4PqZ9hp04cCf
 FH0rEZwsmdxaNkMcGmBdpS28ORW5+OI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-M9K7lICJNCS1SYHr5omQCw-1; Fri, 22 Sep 2023 11:42:49 -0400
X-MC-Unique: M9K7lICJNCS1SYHr5omQCw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-40526a782f7so17935045e9.2
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 08:42:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695397368; x=1696002168;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eEsKc+d0fnRtLJHbjHGMBYA2mr0CMr95bGIl3yAmm50=;
 b=gCdXRsZ276zXXuSb5mVRtvPEwowGrD1JmipF8s4NYEOu45Dx3SZgopSA9xLK50cY1o
 LkX2ywOwOZSo1UOjB+KZvI3feAfEK73ucwxT2aWUf1b8MM8s6u4fp7FD09Xp0oZBcaj8
 y2YAvyoO1UBoi3Ll4eo+kbuH1Tr6AhbSZTHv/HS4sVUQQ9r+uX7OolaCZMWS5qC0RsCd
 FMhfKmoHeyYXlbt9FqV+UWV5VWpjKcjXTMWGbaxwcvoQwVlr2YmG3vMeyQM0G3/Aqnem
 VYxrQTtZ8YBeCUSqHRjxWzOQC8VnD2hFM1cMV0e0CPBF7vpKcDNWbb5+SJioY+s6vMJX
 f7Nw==
X-Gm-Message-State: AOJu0YxIH1QybE1EuUA0L3ogSfFJk9urkiscUb99P+TLwnDuk3Hw3kud
 VMqA+Lo1uinrmkxHr+kF0KTlqOs16GYJ5qFA/iWQOe6pI5r2TegrDX7H7EXuAkVE/G3xQ7Oj82h
 2Raq4fZiYTfomd1Ft2AIO+yKKWjIBxg1EAF60PKjcPJfDFwpIal0VW7wt20QnrM0CFLhF0gw39s
 Y=
X-Received: by 2002:a1c:7419:0:b0:3fb:b248:67c with SMTP id
 p25-20020a1c7419000000b003fbb248067cmr8384565wmc.22.1695397368033; 
 Fri, 22 Sep 2023 08:42:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFC5gMzJmlbuqlco8FqYLbougVmrD4mm3m4tztnpspMLM4Npp1qjWEdvzlAym2H6ickiATutQ==
X-Received: by 2002:a1c:7419:0:b0:3fb:b248:67c with SMTP id
 p25-20020a1c7419000000b003fbb248067cmr8384546wmc.22.1695397367657; 
 Fri, 22 Sep 2023 08:42:47 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 y2-20020a7bcd82000000b00403bbe69629sm4988462wmj.31.2023.09.22.08.42.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Sep 2023 08:42:46 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu, Martin Kletzander <mkletzan@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 8/9] tests/qtest: Specify audiodev= and -audiodev
Date: Fri, 22 Sep 2023 17:42:27 +0200
Message-ID: <20230922154228.304933-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230922154228.304933-1-pbonzini@redhat.com>
References: <20230922154228.304933-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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


