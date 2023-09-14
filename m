Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 350B97A02B4
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 13:34:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgkb9-0000j9-Iq; Thu, 14 Sep 2023 07:33:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qgkb6-0000ho-5g
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 07:33:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qgkb4-000846-EY
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 07:33:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694691201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=geeRr6JZhGsCvmokRsufWzzArGmbQwerfURIvSd1AT0=;
 b=Vy0hqOkVN8unSr8npC7eo4fkLkMRBenfukDPJrJUeOEPT+uxKPSWwqTISKxQW/VMHZQFFG
 sUbtiAmCMWmIJ/tahtZFCZsQGL6MmcesCmLCpumIjRWicreiTv/FuKxWpZ55hAC1lVz1Jw
 yYx8K5vra66zXUzhHu10L+0+Dzpf91o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-541-rKNr3pE_M-KJf45hnRwfyA-1; Thu, 14 Sep 2023 07:33:18 -0400
X-MC-Unique: rKNr3pE_M-KJf45hnRwfyA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9F7D8857A9C;
 Thu, 14 Sep 2023 11:33:17 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 95CF81054FC1;
 Thu, 14 Sep 2023 11:33:16 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [risu PATCH v3 3/7] s390x: Add simple s390x.risu file
Date: Thu, 14 Sep 2023 13:33:07 +0200
Message-ID: <20230914113311.379537-4-thuth@redhat.com>
In-Reply-To: <20230914113311.379537-1-thuth@redhat.com>
References: <20230914113311.379537-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This only adds a limited set of s390x instructions for initial testing.
More instructions will be added later.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 s390x.risu | 81 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)
 create mode 100644 s390x.risu

diff --git a/s390x.risu b/s390x.risu
new file mode 100644
index 0000000..1661be6
--- /dev/null
+++ b/s390x.risu
@@ -0,0 +1,81 @@
+###############################################################################
+# Copyright 2023 Red Hat Inc.
+# All rights reserved. This program and the accompanying materials
+# are made available under the terms of the Eclipse Public License v1.0
+# which accompanies this distribution, and is available at
+# http://www.eclipse.org/legal/epl-v10.html
+#
+# Contributors:
+#     Thomas Huth - initial implementation
+###############################################################################
+
+.mode s390x
+
+# format:RR Add (register + register, 32 bit)
+AR Z 00011010 r1:4 r2:4
+
+# format:RRE Add (register + register, 64 bit)
+AGR Z 10111001 00001000 00000000 r1:4 r2:4
+
+# format:RRE Add (register + register, 32 bit to 64 bit)
+AGFR Z 10111001 00011000 00000000 r1:4 r2:4
+
+# format:RRF-a Add (three registers, 32 bit)
+ARK STFLE45 10111001 11111000 r3:4 0000 r1:4 r2:4
+
+# format:RRF-a Add (three registers, 64 bit)
+AGRK STFLE45 10111001 11101000 r3:4 0000 r1:4 r2:4
+
+
+# format:RRE Add Halfword Immediate (32 bit)
+AHI Z 10100111 r1:4 1010 i2:16
+
+# format:RI Add Halfword Immediate (64 bit)
+AGHI Z 10100111 r1:4 1011 i2:16
+
+
+# format:RR Add Logical (32 bit)
+ALR Z 00011110 r1:4 r2:4
+
+# format:RRE Add Logical (64 bit)
+ALGR Z 10111001 00001010 00000000 r1:4 r2:4
+
+# format:RRE Add Logical (32 bit to 64 bit)
+ALGFR Z 10111001 00011010 00000000 r1:4 r2:4
+
+
+# format:RRF-c Population Count
+POPCNT STFLE45 10111001 11100001 m3:4 0000 r1:4 r2:4
+
+
+###### Binary floating point instructions ######
+
+# format:RRE ADD (short BFP)
+AEBR BFP 10110011 00001010 00000000 r1:4 r2:4
+
+# format:RRE ADD (long BFP)
+ADBR BFP 10110011 00011010 00000000 r1:4 r2:4
+
+# format:RRE ADD (extended BFP)
+AXBR BFP 10110011 01001010 00000000 r1:4 r2:4
+
+
+# format:RRE COMPARE (short BFP)
+CEBR BFP 10110011 00001001 00000000 r1:4 r2:4
+
+# format:RRE COMPARE (long BFP)
+CDBR BFP 10110011 00011001 00000000 r1:4 r2:4
+
+# format:RRE COMPARE (extended BFP)
+CXBR BFP 10110011 01001001 00000000 r1:4 r2:4
+
+
+# format:RRF-e LOAD FP INTEGER (short BFP)
+FIEBRA BFP 10110011 01010111 m3:4 m4:4 r1:4 r2:4
+
+# format:RRF-e LOAD FP INTEGER (long BFP)
+FIDBRA BFP 10110011 01011111 m3:4 m4:4 r1:4 r2:4
+
+# format:RRF-e LOAD FP INTEGER (extended BFP)
+FIXBRA BFP 10110011 01000111 m3:4 m4:4 r1:4 r2:4
+
-- 
2.41.0


