Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A7D7D94AD
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 12:06:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwJiS-0003D1-Dz; Fri, 27 Oct 2023 06:05:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qwJiP-0003CT-Bq
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 06:05:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qwJiN-0002AR-6w
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 06:05:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698401111;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+txKFsCSidJfclXYgv4mc91q3/LZBamT7olLm/gyZOo=;
 b=GMBZewqIIEu3NEKOgfIxxAt8L54xs4xEIvbajqdNRgyHop2+iLFnKVLaoGZctuKBz+ZwvB
 lJyaWSeUzI949enI9NVd6mPUQBGbsF3dAYqckZ5RV00NXN59V1XRBJHqudiXo9v37bCDUF
 q2h61J718UAsZ+AgOTdt8rt+XleEdtc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-538-mYn-wGUHM9qXM5lRxIqyxQ-1; Fri,
 27 Oct 2023 06:05:10 -0400
X-MC-Unique: mYn-wGUHM9qXM5lRxIqyxQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DD4F83804A40;
 Fri, 27 Oct 2023 10:05:09 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.196])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 186AC492BFC;
 Fri, 27 Oct 2023 10:05:07 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 Sebastian Mitterle <smitterl@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Laurent Vivier <laurent@vivier.eu>,
 Thomas Huth <thuth@redhat.com>
Subject: [risu PATCH 2/2] s390x.risu: Add some instructions with a length of
 48 bits
Date: Fri, 27 Oct 2023 12:04:41 +0200
Message-ID: <20231027100441.375223-3-thuth@redhat.com>
In-Reply-To: <20231027100441.375223-1-thuth@redhat.com>
References: <20231027100441.375223-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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

Now that risugen can handle instructions with a length > 32 bit,
we can test some instructions with the length of 48-bit, too.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 s390x.risu | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/s390x.risu b/s390x.risu
index 1661be6..b70678a 100644
--- a/s390x.risu
+++ b/s390x.risu
@@ -27,6 +27,19 @@ ARK STFLE45 10111001 11111000 r3:4 0000 r1:4 r2:4
 AGRK STFLE45 10111001 11101000 r3:4 0000 r1:4 r2:4
 
 
+# format:RIL-a Add immediate (32 bit)
+AFI EI 11000010 r1:4 1001 i2a:16 i2b:16
+
+# format:RIL-a Add immediate (64 bit)
+AGFI EI 11000010 r1:4 1000 i2a:16 i2b:16
+
+# format:RIE-d Add Immediate (32 bit, distinct operand)
+AHIK STFLE35 11101100 r1:4 r3:4 i2:16 00000000 11011000
+
+# format:RIE-d Add Immediate (64 bit, distinct operand)
+AGHIK STFLE35 11101100 r1:4 r3:4 i2:16 00000000 11011001
+
+
 # format:RRE Add Halfword Immediate (32 bit)
 AHI Z 10100111 r1:4 1010 i2:16
 
@@ -44,6 +57,13 @@ ALGR Z 10111001 00001010 00000000 r1:4 r2:4
 ALGFR Z 10111001 00011010 00000000 r1:4 r2:4
 
 
+# format:RIL-a Insert Immediate (32 bit to upper word)
+IIHF EI 11000000 r1:4 1000 i2a:16 i2b:16
+
+# format:RIL-a Insert Immediate (32 bit to upper word)
+IILF EI 11000000 r1:4 1001 i2a:16 i2b:16
+
+
 # format:RRF-c Population Count
 POPCNT STFLE45 10111001 11100001 m3:4 0000 r1:4 r2:4
 
-- 
2.41.0


