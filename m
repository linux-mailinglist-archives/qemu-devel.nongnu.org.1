Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6A77E7A34
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 09:37:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1N0n-0004PR-6b; Fri, 10 Nov 2023 03:37:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1r1N0k-0004Oo-ER
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 03:37:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1r1N0j-0002sJ-35
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 03:37:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699605424;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=/48ObBUAedEyPRpgtsOuL4Ztg+DGbSyrmAPAkGMsBpg=;
 b=BSRo63LVOSx7ngeLKc5kZhbF/q4VfESjzcl8pfkEBT0LTx+44WRbOMaEukY8kqTNLBMzqT
 9HfSJG7bfxLb5EcyAL909rfWcv4n0S/M6I6W5YffL+Aj/2EsEGO3HDZZOrv+pBf5rZYBz/
 3xkak7dd7kpL2ncq47jhUHSOGCBGREU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-UtbcqoM7O1WJI2gHPw4Ghg-1; Fri, 10 Nov 2023 03:37:00 -0500
X-MC-Unique: UtbcqoM7O1WJI2gHPw4Ghg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1F67D811E82;
 Fri, 10 Nov 2023 08:37:00 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.39.192.149])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D6C45492BFC;
 Fri, 10 Nov 2023 08:36:58 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org
Cc: clg@redhat.com
Subject: [PATCH for-8.2] test-resv-mem: Fix CID 1523911
Date: Fri, 10 Nov 2023 09:36:54 +0100
Message-ID: <20231110083654.277345-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Coverity complains about passing "&expected" to "run_range_inverse_array",
which dereferences null "expected". I guess the problem is that the
compare_ranges() loop dereferences 'e' without testing it. However the
loop condition is based on 'ranges' which is garanteed to have
the same length as 'expected' given the g_assert_cmpint() just
before the loop. So the code looks safe to me.

Nevertheless adding a test on expected before the loop to get rid of the
warning.

Fixes: CID 1523901
Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reported-by: Coverity (CID 1523901)

---

Hope this fixes the Coverity warning as I cannot test.
---
 tests/unit/test-resv-mem.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/unit/test-resv-mem.c b/tests/unit/test-resv-mem.c
index 5963274e2c..cd8f7318cc 100644
--- a/tests/unit/test-resv-mem.c
+++ b/tests/unit/test-resv-mem.c
@@ -44,6 +44,10 @@ static void compare_ranges(const char *prefix, GList *ranges,
     print_ranges("out", ranges);
     print_ranges("expected", expected);
 #endif
+    if (!expected) {
+        g_assert_true(!ranges);
+        return;
+    }
     g_assert_cmpint(g_list_length(ranges), ==, g_list_length(expected));
     for (l = ranges, e = expected; l ; l = l->next, e = e->next) {
         Range *r = (Range *)l->data;
-- 
2.41.0


