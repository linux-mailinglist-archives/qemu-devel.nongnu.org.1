Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B815870C5DA
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 21:13:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1Ar4-0003qw-5D; Mon, 22 May 2023 15:06:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q1AqA-0003dY-NC
 for qemu-devel@nongnu.org; Mon, 22 May 2023 15:05:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q1Aq1-0003cP-JZ
 for qemu-devel@nongnu.org; Mon, 22 May 2023 15:05:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684782295;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8cJzwJZ4zdGIq/I0J9calmLyGZPx++hERjNy8PReoLw=;
 b=CDhVZ4RP+cW/+aYJYVahIxTyRHBdPCR2/5Yt+2ZEBA5u4K/zC2S0QBP7K0pO3N/ppjvl27
 DZBQe30mwuA5ys6lix3d0icRsMC7Eml8AbJhsONtuhkmlcMjK5gW5mOE4es/4gnkgG6lSI
 oWK/vf0yuy2S+cmsDWaHv4XvsWi2W30=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-435-vAtI3MElMRSGwZwzaz8xDg-1; Mon, 22 May 2023 15:04:54 -0400
X-MC-Unique: vAtI3MElMRSGwZwzaz8xDg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 03924101A53B;
 Mon, 22 May 2023 19:04:54 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.46])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 95747400DFF;
 Mon, 22 May 2023 19:04:53 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: hreitz@redhat.com,
	qemu-block@nongnu.org,
	Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH v3 17/19] cutils: Use parse_uint in qemu_strtosz for negative
 rejection
Date: Mon, 22 May 2023 14:04:39 -0500
Message-Id: <20230522190441.64278-18-eblake@redhat.com>
In-Reply-To: <20230522190441.64278-1-eblake@redhat.com>
References: <20230522190441.64278-1-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
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

Rather than open-coding two different ways to check for an unwanted
negative sign, reuse the same code in both functions.  That way, if we
decide down the road to accept "-0" instead of rejecting it, we have
fewer places to change.  Also, it means we now get ERANGE instead of
EINVAL for negative values in qemu_strtosz, which is reasonable for
what it represents.  This in turn changes the expected output of a
couple of iotests.

The change is not quite complete: negative fractional scaled values
can trip us up.  This will be fixed in a later patch addressing other
issues with fractional scaled values.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
---

v3: also fix iotests, commit message tweaked, R-b added
---
 tests/unit/test-cutils.c         | 7 +++----
 util/cutils.c                    | 8 ++------
 tests/qemu-iotests/049.out       | 7 ++-----
 tests/qemu-iotests/178.out.qcow2 | 3 +--
 tests/qemu-iotests/178.out.raw   | 3 +--
 5 files changed, 9 insertions(+), 19 deletions(-)

diff --git a/tests/unit/test-cutils.c b/tests/unit/test-cutils.c
index adc9878f93d..8bdae856827 100644
--- a/tests/unit/test-cutils.c
+++ b/tests/unit/test-cutils.c
@@ -3519,10 +3519,9 @@ static void test_qemu_strtosz_trailing(void)
 static void test_qemu_strtosz_erange(void)
 {
     /* FIXME negative values fit better as ERANGE */
-    do_strtosz(" -0", -EINVAL /* FIXME -ERANGE */, 0, 0 /* FIXME 3 */);
-    do_strtosz("-1", -EINVAL /* FIXME -ERANGE */, 0, 0 /* FIXME 2 */);
-    do_strtosz_full("-2M", qemu_strtosz, -EINVAL /* FIXME -ERANGE */, 0,
-                    0 /* FIXME 2 */, -EINVAL, 0);
+    do_strtosz(" -0", -ERANGE, 0, 3);
+    do_strtosz("-1", -ERANGE, 0, 2);
+    do_strtosz_full("-2M", qemu_strtosz, -ERANGE, 0, 2, -EINVAL, 0);
     do_strtosz(" -.0", -EINVAL /* FIXME -ERANGE */, 0, 0 /* FIXME 4 */);
     do_strtosz_full("-.1k", qemu_strtosz, -EINVAL /* FIXME -ERANGE */, 0,
                     0 /* FIXME 3 */, -EINVAL, 0);
diff --git a/util/cutils.c b/util/cutils.c
index edfb71a2171..e3a49209a94 100644
--- a/util/cutils.c
+++ b/util/cutils.c
@@ -201,6 +201,7 @@ static int64_t suffix_mul(char suffix, int64_t unit)
  * - hex with scaling suffix, such as 0x20M
  * - octal, such as 08
  * - fractional hex, such as 0x1.8
+ * - negative values, including -0
  * - floating point exponents, such as 1e3
  *
  * The end pointer will be returned in *end, if not NULL.  If there is
@@ -226,15 +227,10 @@ static int do_strtosz(const char *nptr, const char **end,
     int64_t mul;

     /* Parse integral portion as decimal. */
-    retval = qemu_strtou64(nptr, &endptr, 10, &val);
+    retval = parse_uint(nptr, &endptr, 10, &val);
     if (retval) {
         goto out;
     }
-    if (memchr(nptr, '-', endptr - nptr) != NULL) {
-        endptr = nptr;
-        retval = -EINVAL;
-        goto out;
-    }
     if (val == 0 && (*endptr == 'x' || *endptr == 'X')) {
         /* Input looks like hex; reparse, and insist on no fraction or suffix. */
         retval = qemu_strtou64(nptr, &endptr, 16, &val);
diff --git a/tests/qemu-iotests/049.out b/tests/qemu-iotests/049.out
index 8719c91b483..34e1b452e6e 100644
--- a/tests/qemu-iotests/049.out
+++ b/tests/qemu-iotests/049.out
@@ -92,13 +92,10 @@ Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 cluster_size=65536 extended_l2=off comp
 == 3. Invalid sizes ==

 qemu-img create -f qcow2 TEST_DIR/t.qcow2 -- -1024
-qemu-img: Invalid image size specified. You may use k, M, G, T, P or E suffixes for
-qemu-img: kilobytes, megabytes, gigabytes, terabytes, petabytes and exabytes.
+qemu-img: Invalid image size specified. Must be between 0 and 9223372036854775807.

 qemu-img create -f qcow2 -o size=-1024 TEST_DIR/t.qcow2
-qemu-img: TEST_DIR/t.qcow2: Parameter 'size' expects a non-negative number below 2^64
-Optional suffix k, M, G, T, P or E means kilo-, mega-, giga-, tera-, peta-
-and exabytes, respectively.
+qemu-img: TEST_DIR/t.qcow2: Value '-1024' is out of range for parameter 'size'

 qemu-img create -f qcow2 TEST_DIR/t.qcow2 -- -1k
 qemu-img: Invalid image size specified. You may use k, M, G, T, P or E suffixes for
diff --git a/tests/qemu-iotests/178.out.qcow2 b/tests/qemu-iotests/178.out.qcow2
index 0d51fe401ec..fe193fd5f4f 100644
--- a/tests/qemu-iotests/178.out.qcow2
+++ b/tests/qemu-iotests/178.out.qcow2
@@ -13,8 +13,7 @@ qemu-img: Invalid option list: ,
 qemu-img: Invalid parameter 'snapshot.foo'
 qemu-img: Failed in parsing snapshot param 'snapshot.foo=bar'
 qemu-img: --output must be used with human or json as argument.
-qemu-img: Invalid image size specified. You may use k, M, G, T, P or E suffixes for
-qemu-img: kilobytes, megabytes, gigabytes, terabytes, petabytes and exabytes.
+qemu-img: Invalid image size specified. Must be between 0 and 9223372036854775807.
 qemu-img: Unknown file format 'foo'

 == Size calculation for a new file (human) ==
diff --git a/tests/qemu-iotests/178.out.raw b/tests/qemu-iotests/178.out.raw
index 116241ddef2..445e460fad9 100644
--- a/tests/qemu-iotests/178.out.raw
+++ b/tests/qemu-iotests/178.out.raw
@@ -13,8 +13,7 @@ qemu-img: Invalid option list: ,
 qemu-img: Invalid parameter 'snapshot.foo'
 qemu-img: Failed in parsing snapshot param 'snapshot.foo=bar'
 qemu-img: --output must be used with human or json as argument.
-qemu-img: Invalid image size specified. You may use k, M, G, T, P or E suffixes for
-qemu-img: kilobytes, megabytes, gigabytes, terabytes, petabytes and exabytes.
+qemu-img: Invalid image size specified. Must be between 0 and 9223372036854775807.
 qemu-img: Unknown file format 'foo'

 == Size calculation for a new file (human) ==
-- 
2.40.1


