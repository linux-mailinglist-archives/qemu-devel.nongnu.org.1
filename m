Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2C1709A81
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 16:53:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q01RS-0000ov-I9; Fri, 19 May 2023 10:50:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q01RM-0000HE-JJ
 for qemu-devel@nongnu.org; Fri, 19 May 2023 10:50:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q01RK-0003ZO-4E
 for qemu-devel@nongnu.org; Fri, 19 May 2023 10:50:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684507841;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OnZ6eLMzZsROly4VW6ysnh46XonOIPRp/Ia9O8cYqm8=;
 b=bYHAq7m4GYk+4K9juhc1y2mE82kn0YXVUlgbUoXZK/xCsiJRvsrDdVBFWaUXiPamn9nOwW
 0+6EXzHhj7/O3J1pHSjjWhYhaKssBISK7M7VGruoTviC7YLw2n8HOz3HPW0kn0j618ptqR
 s/IsL+YER6hkJMqIPvE+RGdx7vv26Ro=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-KSYbPigzO6mS6q07r73Csg-1; Fri, 19 May 2023 10:50:32 -0400
X-MC-Unique: KSYbPigzO6mS6q07r73Csg-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-4f3b27050e7so174423e87.3
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 07:50:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684507831; x=1687099831;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OnZ6eLMzZsROly4VW6ysnh46XonOIPRp/Ia9O8cYqm8=;
 b=fuhM8HoDisFT/PlQ0S6J85ggsHdIa1fXlw4hQ8NMofmBFZrKntxoZEXWu1DVIEwL+t
 rZC/Qab3nDqMK0F47vn/tXqnki03WNlpBoIrwkBAmVy9abXYeYYeQR7aLg4i6qftdGDI
 pkKsRrPboV+7Gv4SFeMGtfSxPa+rSlq+E+uoZcz9bES3izhYSgfQK4W85FmfntWURRkf
 WcA6s+qX4rLgXmC1WwKXEwsMrrx2/T8JsFyN7/TMooR07YKchHamNgPikRkO6Kng1jmB
 ibFfuBBc9DErclMggDT+FtenUrOGPFCaMgLZQkMIXhoARxeOW2RjW5v3jNJ1Kh7WXHCK
 IcHw==
X-Gm-Message-State: AC+VfDx4KFq6zd1B7mLGGbE5nh650y96UY7Li8qjbPmoF0M14scsm493
 jxGmVYwVgxEem+LFhLdr0xkvJfUrUDy7OIwGdu/SvjBq+PaRj5xsCMkXJ0SCBR8YUMix61e8OO2
 uxTsVhsIN3sUvRrYtSFqLFZMdEzOb7O8SiKHSSSJpod2GDxp/QoI+e8d5QtJiWqVIOjko
X-Received: by 2002:a05:6512:147:b0:4f1:4040:8143 with SMTP id
 m7-20020a056512014700b004f140408143mr910906lfo.60.1684507830730; 
 Fri, 19 May 2023 07:50:30 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5RV4bZyW+fXhp+UglkWYSonB9HMDcdeGCQZ6otuMQvgmg0WN9fcp8yEh9C90zQZ+hcqJOWWQ==
X-Received: by 2002:a05:6512:147:b0:4f1:4040:8143 with SMTP id
 m7-20020a056512014700b004f140408143mr910891lfo.60.1684507830450; 
 Fri, 19 May 2023 07:50:30 -0700 (PDT)
Received: from redhat.com ([176.12.184.180]) by smtp.gmail.com with ESMTPSA id
 v11-20020a056512096b00b004eefdd8b37fsm613067lft.194.2023.05.19.07.50.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 May 2023 07:50:29 -0700 (PDT)
Date: Fri, 19 May 2023 10:50:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Gregory Price <gourry.memverge@gmail.com>,
 Gregory Price <gregory.price@memverge.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 10/40] tests/qtest/cxl-test: whitespace, line ending cleanup
Message-ID: <847ea4e746a1cac861ffe6b8256052131e8e3b93.1684507742.git.mst@redhat.com>
References: <cover.1684507742.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1684507742.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Gregory Price <gourry.memverge@gmail.com>

Defines are starting to exceed line length limits, align them for
cleanliness before making modifications.

Signed-off-by: Gregory Price <gregory.price@memverge.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20230421160827.2227-2-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/cxl-test.c | 78 +++++++++++++++++++++++-------------------
 1 file changed, 43 insertions(+), 35 deletions(-)

diff --git a/tests/qtest/cxl-test.c b/tests/qtest/cxl-test.c
index 61f25a72b6..eda2bbbbe6 100644
--- a/tests/qtest/cxl-test.c
+++ b/tests/qtest/cxl-test.c
@@ -8,50 +8,58 @@
 #include "qemu/osdep.h"
 #include "libqtest-single.h"
 
-#define QEMU_PXB_CMD "-machine q35,cxl=on " \
-                     "-device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52 "  \
-                     "-M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.size=4G "
+#define QEMU_PXB_CMD \
+    "-machine q35,cxl=on " \
+    "-device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52 " \
+    "-M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.size=4G "
 
-#define QEMU_2PXB_CMD "-machine q35,cxl=on "                            \
-                      "-device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52 "  \
-                      "-device pxb-cxl,id=cxl.1,bus=pcie.0,bus_nr=53 " \
-                      "-M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.targets.1=cxl.1,cxl-fmw.0.size=4G "
+#define QEMU_2PXB_CMD \
+    "-machine q35,cxl=on " \
+    "-device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52 " \
+    "-device pxb-cxl,id=cxl.1,bus=pcie.0,bus_nr=53 " \
+    "-M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.targets.1=cxl.1,cxl-fmw.0.size=4G "
 
-#define QEMU_RP "-device cxl-rp,id=rp0,bus=cxl.0,chassis=0,slot=0 "
+#define QEMU_RP \
+    "-device cxl-rp,id=rp0,bus=cxl.0,chassis=0,slot=0 "
 
 /* Dual ports on first pxb */
-#define QEMU_2RP "-device cxl-rp,id=rp0,bus=cxl.0,chassis=0,slot=0 " \
-                 "-device cxl-rp,id=rp1,bus=cxl.0,chassis=0,slot=1 "
+#define QEMU_2RP \
+    "-device cxl-rp,id=rp0,bus=cxl.0,chassis=0,slot=0 " \
+    "-device cxl-rp,id=rp1,bus=cxl.0,chassis=0,slot=1 "
 
 /* Dual ports on each of the pxb instances */
-#define QEMU_4RP "-device cxl-rp,id=rp0,bus=cxl.0,chassis=0,slot=0 " \
-                 "-device cxl-rp,id=rp1,bus=cxl.0,chassis=0,slot=1 " \
-                 "-device cxl-rp,id=rp2,bus=cxl.1,chassis=0,slot=2 " \
-                 "-device cxl-rp,id=rp3,bus=cxl.1,chassis=0,slot=3 "
+#define QEMU_4RP \
+    "-device cxl-rp,id=rp0,bus=cxl.0,chassis=0,slot=0 " \
+    "-device cxl-rp,id=rp1,bus=cxl.0,chassis=0,slot=1 " \
+    "-device cxl-rp,id=rp2,bus=cxl.1,chassis=0,slot=2 " \
+    "-device cxl-rp,id=rp3,bus=cxl.1,chassis=0,slot=3 "
 
-#define QEMU_T3D "-object memory-backend-file,id=cxl-mem0,mem-path=%s,size=256M " \
-                 "-object memory-backend-file,id=lsa0,mem-path=%s,size=256M "    \
-                 "-device cxl-type3,bus=rp0,memdev=cxl-mem0,lsa=lsa0,id=cxl-pmem0 "
+#define QEMU_T3D \
+    "-object memory-backend-file,id=cxl-mem0,mem-path=%s,size=256M " \
+    "-object memory-backend-file,id=lsa0,mem-path=%s,size=256M " \
+    "-device cxl-type3,bus=rp0,memdev=cxl-mem0,lsa=lsa0,id=cxl-pmem0 "
 
-#define QEMU_2T3D "-object memory-backend-file,id=cxl-mem0,mem-path=%s,size=256M "    \
-                  "-object memory-backend-file,id=lsa0,mem-path=%s,size=256M "    \
-                  "-device cxl-type3,bus=rp0,memdev=cxl-mem0,lsa=lsa0,id=cxl-pmem0 " \
-                  "-object memory-backend-file,id=cxl-mem1,mem-path=%s,size=256M "    \
-                  "-object memory-backend-file,id=lsa1,mem-path=%s,size=256M "    \
-                  "-device cxl-type3,bus=rp1,memdev=cxl-mem1,lsa=lsa1,id=cxl-pmem1 "
+#define QEMU_2T3D \
+    "-object memory-backend-file,id=cxl-mem0,mem-path=%s,size=256M " \
+    "-object memory-backend-file,id=lsa0,mem-path=%s,size=256M " \
+    "-device cxl-type3,bus=rp0,memdev=cxl-mem0,lsa=lsa0,id=cxl-pmem0 " \
+    "-object memory-backend-file,id=cxl-mem1,mem-path=%s,size=256M " \
+    "-object memory-backend-file,id=lsa1,mem-path=%s,size=256M " \
+    "-device cxl-type3,bus=rp1,memdev=cxl-mem1,lsa=lsa1,id=cxl-pmem1 "
 
-#define QEMU_4T3D "-object memory-backend-file,id=cxl-mem0,mem-path=%s,size=256M " \
-                  "-object memory-backend-file,id=lsa0,mem-path=%s,size=256M "    \
-                  "-device cxl-type3,bus=rp0,memdev=cxl-mem0,lsa=lsa0,id=cxl-pmem0 " \
-                  "-object memory-backend-file,id=cxl-mem1,mem-path=%s,size=256M "    \
-                  "-object memory-backend-file,id=lsa1,mem-path=%s,size=256M "    \
-                  "-device cxl-type3,bus=rp1,memdev=cxl-mem1,lsa=lsa1,id=cxl-pmem1 " \
-                  "-object memory-backend-file,id=cxl-mem2,mem-path=%s,size=256M "    \
-                  "-object memory-backend-file,id=lsa2,mem-path=%s,size=256M "    \
-                  "-device cxl-type3,bus=rp2,memdev=cxl-mem2,lsa=lsa2,id=cxl-pmem2 " \
-                  "-object memory-backend-file,id=cxl-mem3,mem-path=%s,size=256M "    \
-                  "-object memory-backend-file,id=lsa3,mem-path=%s,size=256M "    \
-                  "-device cxl-type3,bus=rp3,memdev=cxl-mem3,lsa=lsa3,id=cxl-pmem3 "
+#define QEMU_4T3D \
+    "-object memory-backend-file,id=cxl-mem0,mem-path=%s,size=256M " \
+    "-object memory-backend-file,id=lsa0,mem-path=%s,size=256M " \
+    "-device cxl-type3,bus=rp0,memdev=cxl-mem0,lsa=lsa0,id=cxl-pmem0 " \
+    "-object memory-backend-file,id=cxl-mem1,mem-path=%s,size=256M " \
+    "-object memory-backend-file,id=lsa1,mem-path=%s,size=256M " \
+    "-device cxl-type3,bus=rp1,memdev=cxl-mem1,lsa=lsa1,id=cxl-pmem1 " \
+    "-object memory-backend-file,id=cxl-mem2,mem-path=%s,size=256M " \
+    "-object memory-backend-file,id=lsa2,mem-path=%s,size=256M " \
+    "-device cxl-type3,bus=rp2,memdev=cxl-mem2,lsa=lsa2,id=cxl-pmem2 " \
+    "-object memory-backend-file,id=cxl-mem3,mem-path=%s,size=256M " \
+    "-object memory-backend-file,id=lsa3,mem-path=%s,size=256M " \
+    "-device cxl-type3,bus=rp3,memdev=cxl-mem3,lsa=lsa3,id=cxl-pmem3 "
 
 static void cxl_basic_hb(void)
 {
-- 
MST


