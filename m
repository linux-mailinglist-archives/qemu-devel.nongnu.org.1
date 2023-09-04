Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 179EB791951
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 16:03:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdA8o-0006yh-R3; Mon, 04 Sep 2023 10:01:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qdA8N-0006tN-V3
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 10:01:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qdA8I-00088O-Bv
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 10:00:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693836049;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2urv1KXUDYUsVN9QLuH+NyVg5VQbxIVWiLcrAJOBFFI=;
 b=WAoQQhN07WrMOtY0i40NdnLT/Y19A/sUr4KxbPzzTXe3lHSo8veNA9ljHgnytwvkT9EMZR
 fqrzsAw2txbKDgBeMbWIzhxXG2OQDF+xRhbrCnO7XhOo2HJuxQf94TTzSjZtikIWbvFvFm
 esBpDcAie76DUXRrNo8R9VGzI/SUgIM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-137-4cCWOVKrPLG1p2NE9tIMOw-1; Mon, 04 Sep 2023 10:00:48 -0400
X-MC-Unique: 4cCWOVKrPLG1p2NE9tIMOw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 865AA3C025CB;
 Mon,  4 Sep 2023 14:00:47 +0000 (UTC)
Received: from thuth.com (unknown [10.39.193.108])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F3DB11121314;
 Mon,  4 Sep 2023 14:00:45 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@redhat.com>
Subject: [risu PATCH 2/4] s390x: Add simple s390x.risu file
Date: Mon,  4 Sep 2023 16:00:38 +0200
Message-Id: <20230904140040.33153-3-thuth@redhat.com>
In-Reply-To: <20230904140040.33153-1-thuth@redhat.com>
References: <20230904140040.33153-1-thuth@redhat.com>
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

This only adds a limited set of s390x instructions for initial testing.
More instructions will be added later.

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


