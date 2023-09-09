Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 789A879986E
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 15:13:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qexf9-0006mj-Rd; Sat, 09 Sep 2023 09:06:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qexez-0006jl-WB; Sat, 09 Sep 2023 09:06:02 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qexev-0003Zn-VV; Sat, 09 Sep 2023 09:06:01 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 93CF6205D8;
 Sat,  9 Sep 2023 16:06:05 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 4237A26E2B;
 Sat,  9 Sep 2023 16:05:14 +0300 (MSK)
Received: (nullmailer pid 354293 invoked by uid 1000);
 Sat, 09 Sep 2023 13:05:12 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 Claudio Fontana <cfontana@suse.de>, David Hildenbrand <david@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.6 11/37] target/s390x: Fix the "ignored match" case in
 VSTRS
Date: Sat,  9 Sep 2023 16:04:41 +0300
Message-Id: <20230909130511.354171-11-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.6-20230909160328@cover.tls.msk.ru>
References: <qemu-stable-7.2.6-20230909160328@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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
(cherry picked from commit 791b2b6a930273db694b9ba48bbb406e78715927)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

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
2.39.2


