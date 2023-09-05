Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 30DB2792241
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 13:52:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdUZz-000813-Ap; Tue, 05 Sep 2023 07:50:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qdUZZ-0007wB-PS
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 07:50:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qdUZR-0001oM-VW
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 07:50:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693914612;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ozjnTxK+DXpLTwD7+WiSP6lSegSOY+VhK0WmKOaoBeo=;
 b=OW/YIr1aoAfp5eOH5lTNEOXE7AZCbx5vt0xY9Ew2y84PX1I3W1NW+/I3RFmjeHPV7EIQd4
 TyC3Ai1J6vrYXEehhbxBXRVWpPIhj+n1oEiY3WLdKjUX9zVygCZc0zkLT9L/TJjKSWVLdQ
 Gk10X1P+X6+oGPAYGoABlMoYr/NwhDA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-53-BA7WBGAjOne1hzHmMsMhaA-1; Tue, 05 Sep 2023 07:50:07 -0400
X-MC-Unique: BA7WBGAjOne1hzHmMsMhaA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3B24610264F3;
 Tue,  5 Sep 2023 11:50:07 +0000 (UTC)
Received: from thuth.com (unknown [10.39.193.241])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 017874043CCD;
 Tue,  5 Sep 2023 11:50:05 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@redhat.com>
Subject: [risu PATCH v2 2/4] s390x: Add simple s390x.risu file
Date: Tue,  5 Sep 2023 13:49:58 +0200
Message-Id: <20230905115000.53587-3-thuth@redhat.com>
In-Reply-To: <20230905115000.53587-1-thuth@redhat.com>
References: <20230905115000.53587-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
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

Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 s390x.risu | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 s390x.risu

diff --git a/s390x.risu b/s390x.risu
new file mode 100644
index 0000000..3ad7015
--- /dev/null
+++ b/s390x.risu
@@ -0,0 +1,48 @@
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
-- 
2.39.3


