Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C57B378570F
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 13:47:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYmJn-0001a6-Dp; Wed, 23 Aug 2023 07:46:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qYmJO-0001Xa-Gi
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 07:46:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qYmJL-0001Vt-94
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 07:46:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692791166;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CyV1ROp1edt5ej0qkoEODn89anDkzeeYo0FXYSVmjQo=;
 b=g0D3SOpzzppr6tSYiNuJ8s1dlwif1n04lKimn/lmmjAwWPI3UfpFggX5nWOjkret65kgQ7
 d/XxQYa4U2sYfZpFQJjcmNtVcAIg/lS9fKh3yWvhIkr7TtxDn38C5B/jEfDTtip/XaInTW
 IPhmiZL2C+MgAJvk0Ynsy2SDRkkx5aw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-413-6YeW00rGOserFY4OF5G7ig-1; Wed, 23 Aug 2023 07:46:03 -0400
X-MC-Unique: 6YeW00rGOserFY4OF5G7ig-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1F626800CAE;
 Wed, 23 Aug 2023 11:46:03 +0000 (UTC)
Received: from thuth.com (unknown [10.39.193.36])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E788BC15BAE;
 Wed, 23 Aug 2023 11:46:01 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-stable@nongnu.org,
 Claudio Fontana <cfontana@suse.de>, David Hildenbrand <david@redhat.com>
Subject: [PULL 11/12] target/s390x: Fix the "ignored match" case in VSTRS
Date: Wed, 23 Aug 2023 13:45:43 +0200
Message-Id: <20230823114544.216520-12-thuth@redhat.com>
In-Reply-To: <20230823114544.216520-1-thuth@redhat.com>
References: <20230823114544.216520-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

Currently the emulation of VSTRS recognizes partial matches in presence
of \0 in the haystack, which, according to PoP, is not correct:

    If the ZS flag is one and a zero byte was detected
    in the second operand, then there can not be a
    partial match ...

Add a check for this. While at it, fold a number of explicitly handled
special cases into the generic logic.

Cc: qemu-stable@nongnu.org
Reported-by: Claudio Fontana <cfontana@suse.de>
Closes: https://lists.gnu.org/archive/html/qemu-devel/2023-08/msg00633.html
Fixes: 1d706f314191 ("target/s390x: vxeh2: vector string search")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-Id: <20230804233748.218935-3-iii@linux.ibm.com>
Tested-by: Claudio Fontana <cfontana@suse.de>
Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/s390x/tcg/vec_string_helper.c | 54 +++++++++-------------------
 1 file changed, 17 insertions(+), 37 deletions(-)

diff --git a/target/s390x/tcg/vec_string_helper.c b/target/s390x/tcg/vec_string_helper.c
index 9b85becdfb..a19f429768 100644
--- a/target/s390x/tcg/vec_string_helper.c
+++ b/target/s390x/tcg/vec_string_helper.c
@@ -474,9 +474,9 @@ DEF_VSTRC_CC_RT_HELPER(32)
 static int vstrs(S390Vector *v1, const S390Vector *v2, const S390Vector *v3,
                  const S390Vector *v4, uint8_t es, bool zs)
 {
-    int substr_elen, substr_0, str_elen, i, j, k, cc;
+    int substr_elen, i, j, k, cc;
     int nelem = 16 >> es;
-    bool eos = false;
+    int str_leftmost_0;
 
     substr_elen = s390_vec_read_element8(v4, 7) >> es;
 
@@ -498,47 +498,20 @@ static int vstrs(S390Vector *v1, const S390Vector *v2, const S390Vector *v3,
     }
 
     /* If ZS, look for eos in the searched string. */
+    str_leftmost_0 = nelem;
     if (zs) {
         for (k = 0; k < nelem; k++) {
             if (s390_vec_read_element(v2, k, es) == 0) {
-                eos = true;
+                str_leftmost_0 = k;
                 break;
             }
         }
-        str_elen = k;
-    } else {
-        str_elen = nelem;
     }
 
-    substr_0 = s390_vec_read_element(v3, 0, es);
-
-    for (k = 0; ; k++) {
-        for (; k < str_elen; k++) {
-            if (s390_vec_read_element(v2, k, es) == substr_0) {
-                break;
-            }
-        }
-
-        /* If we reached the end of the string, no match. */
-        if (k == str_elen) {
-            cc = eos; /* no match (with or without zero char) */
-            goto done;
-        }
-
-        /* If the substring is only one char, match. */
-        if (substr_elen == 1) {
-            cc = 2; /* full match */
-            goto done;
-        }
-
-        /* If the match begins at the last char, we have a partial match. */
-        if (k == str_elen - 1) {
-            cc = 3; /* partial match */
-            goto done;
-        }
-
+    cc = str_leftmost_0 == nelem ? 0 : 1;  /* No match. */
+    for (k = 0; k < nelem; k++) {
         i = MIN(nelem, k + substr_elen);
-        for (j = k + 1; j < i; j++) {
+        for (j = k; j < i; j++) {
             uint32_t e2 = s390_vec_read_element(v2, j, es);
             uint32_t e3 = s390_vec_read_element(v3, j - k, es);
             if (e2 != e3) {
@@ -546,9 +519,16 @@ static int vstrs(S390Vector *v1, const S390Vector *v2, const S390Vector *v3,
             }
         }
         if (j == i) {
-            /* Matched up until "end". */
-            cc = i - k == substr_elen ? 2 : 3; /* full or partial match */
-            goto done;
+            /* All elements matched. */
+            if (k > str_leftmost_0) {
+                cc = 1;  /* Ignored match. */
+                k = nelem;
+            } else if (i - k == substr_elen) {
+                cc = 2;  /* Full match. */
+            } else {
+                cc = 3;  /* Partial match. */
+            }
+            break;
         }
     }
 
-- 
2.39.3


