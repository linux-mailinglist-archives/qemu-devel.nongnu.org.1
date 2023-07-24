Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C0BAF75FCAB
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 18:55:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNyp0-0001F3-UH; Mon, 24 Jul 2023 12:54:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qNyos-0001EC-34
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 12:54:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qNyoo-0006t0-6V
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 12:54:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690217636;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xCaUIsRvWwrp7IryBZRbJmobbCU1sZgfhPxqHZN9ERI=;
 b=W5CU1ZcXEYommISFjiu+2crasnMudRMbrDPP5n9O/MupCVeawaaXq6njhYpFF2EiHT04tR
 SKv4Wl9ZBE94lY5NR4zKhkfW1oA15AYgjZn4pYgYAcuJQo7zDgDYaruDS8VdJ2LHZQsyeK
 xKCWtrFvUPUmmpKFSWAO3zhlJgGaejo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-540-1LqFmwPdPeCz2-ZSXcEaKA-1; Mon, 24 Jul 2023 12:53:54 -0400
X-MC-Unique: 1LqFmwPdPeCz2-ZSXcEaKA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A64698030AC;
 Mon, 24 Jul 2023 16:53:53 +0000 (UTC)
Received: from thuth.com (unknown [10.39.192.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 702A7492CAC;
 Mon, 24 Jul 2023 16:53:52 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-stable@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>
Subject: [PULL 01/16] target/s390x: Make CKSM raise an exception if R2 is odd
Date: Mon, 24 Jul 2023 18:53:34 +0200
Message-Id: <20230724165349.55714-2-thuth@redhat.com>
In-Reply-To: <20230724165349.55714-1-thuth@redhat.com>
References: <20230724165349.55714-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

R2 designates an even-odd register pair; the instruction should raise
a specification exception when R2 is not even.

Cc: qemu-stable@nongnu.org
Fixes: e023e832d0ac ("s390x: translate engine for s390x CPU")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-Id: <20230724082032.66864-2-iii@linux.ibm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/s390x/tcg/insn-data.h.inc | 2 +-
 target/s390x/tcg/translate.c     | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/target/s390x/tcg/insn-data.h.inc b/target/s390x/tcg/insn-data.h.inc
index 457ed25d2f..86a509b0ac 100644
--- a/target/s390x/tcg/insn-data.h.inc
+++ b/target/s390x/tcg/insn-data.h.inc
@@ -157,7 +157,7 @@
     C(0xb2fa, NIAI,    E,     EH,  0, 0, 0, 0, 0, 0)
 
 /* CHECKSUM */
-    C(0xb241, CKSM,    RRE,   Z,   r1_o, ra2, new, r1_32, cksm, 0)
+    C(0xb241, CKSM,    RRE,   Z,   r1_o, ra2_E, new, r1_32, cksm, 0)
 
 /* COPY SIGN */
     F(0xb372, CPSDR,   RRF_b, FPSSH, f3, f2, new, f1, cps, 0, IF_AFP1 | IF_AFP2 | IF_AFP3)
diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 6661b27efa..d6e8acee99 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -5779,6 +5779,12 @@ static void in2_ra2(DisasContext *s, DisasOps *o)
 }
 #define SPEC_in2_ra2 0
 
+static void in2_ra2_E(DisasContext *s, DisasOps *o)
+{
+    return in2_ra2(s, o);
+}
+#define SPEC_in2_ra2_E SPEC_r2_even
+
 static void in2_a2(DisasContext *s, DisasOps *o)
 {
     int x2 = have_field(s, x2) ? get_field(s, x2) : 0;
-- 
2.39.3


