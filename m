Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C85A671F589
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 00:05:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4qOT-00081o-52; Thu, 01 Jun 2023 18:03:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q4qOB-000800-Si
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 18:03:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q4qO4-0003z8-HT
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 18:03:22 -0400
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-277-H1LjDXy4NDyOdzP25AMVPg-1; Thu, 01 Jun 2023 18:03:10 -0400
X-MC-Unique: H1LjDXy4NDyOdzP25AMVPg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 783F2101AA72;
 Thu,  1 Jun 2023 22:03:10 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.76])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 04583492B0A;
 Thu,  1 Jun 2023 22:03:09 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org (open list:Block layer core)
Subject: [PULL 01/21] iotests: Fix test 104 under NBD
Date: Thu,  1 Jun 2023 17:02:45 -0500
Message-Id: <20230601220305.2130121-2-eblake@redhat.com>
In-Reply-To: <20230601220305.2130121-1-eblake@redhat.com>
References: <20230601220305.2130121-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

In the past, commit a231cb27 ("iotests: Fix 104 for NBD", v2.3.0)
added an additional filter to _filter_img_info to rewrite NBD URIs
into the expected output form.  This recently broke when we tweaked
tests to run in a per-format directory, which did not match the regex,
because _img_info itself is now already changing
SOCK_DIR=/tmp/tmpphjfbphd/raw-nbd-104 into
/tmp/tmpphjfbphd/IMGFMT-nbd-104 prior to _img_info_filter getting a
chance to further filter things.

While diagnosing the problem, I also noticed some filter lines
rendered completely useless by a typo when we switched from TCP to
Unix sockets for NBD (in shell, '\\+' is different from "\\+" (one
gives two backslash to the regex, matching the literal 2-byte sequence
<\+> after a single digit; the other gives one backslash to the regex,
as the metacharacter \+ to match one or more of <[0-9]>); since the
literal string <nbd://127.0.0.1:0\+> is not a valid URI, that regex
hasn't been matching anything for years so it is fine to just drop it
rather than fix the typo.

Fixes: f3923a72 ("iotests: Switch nbd tests to use Unix rather than TCP", v4.2.0)
Fixes: 5ba7db09 ("iotests: always use a unique sub-directory per test", v8.0.0)
Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20230519150216.2599189-1-eblake@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/qemu-iotests/common.filter | 4 +---
 tests/qemu-iotests/common.rc     | 3 ++-
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/tests/qemu-iotests/common.filter b/tests/qemu-iotests/common.filter
index 6b32c7fbfa1..fc3c64bcb8e 100644
--- a/tests/qemu-iotests/common.filter
+++ b/tests/qemu-iotests/common.filter
@@ -1,6 +1,6 @@
 #!/usr/bin/env bash
 #
-# Copyright (C) 2009 Red Hat, Inc.
+# Copyright Red Hat
 # Copyright (c) 2000-2001 Silicon Graphics, Inc.  All Rights Reserved.
 #
 # This program is free software; you can redistribute it and/or
@@ -131,7 +131,6 @@ _filter_img_create_filenames()
         -e "s#$SOCK_DIR#SOCK_DIR#g" \
         -e 's#SOCK_DIR/fuse-#TEST_DIR/#g' \
         -e "s#$IMGFMT#IMGFMT#g" \
-        -e 's#nbd:127.0.0.1:[0-9]\\+#TEST_DIR/t.IMGFMT#g' \
         -e 's#nbd+unix:///\??socket=SOCK_DIR/nbd#TEST_DIR/t.IMGFMT#g'
 }

@@ -229,7 +228,6 @@ _filter_img_info()
         -e "s#$TEST_DIR#TEST_DIR#g" \
         -e "s#$SOCK_DIR#SOCK_DIR#g" \
         -e "s#$IMGFMT#IMGFMT#g" \
-        -e 's#nbd://127.0.0.1:[0-9]\\+$#TEST_DIR/t.IMGFMT#g' \
         -e 's#nbd+unix:///\??socket=SOCK_DIR/nbd#TEST_DIR/t.IMGFMT#g' \
         -e 's#SOCK_DIR/fuse-#TEST_DIR/#g' \
         -e "/encrypted: yes/d" \
diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
index f4476b62f7d..d145f08201c 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -1,6 +1,6 @@
 #!/usr/bin/env bash
 #
-# Copyright (C) 2009 Red Hat, Inc.
+# Copyright Red Hat
 # Copyright (c) 2000-2006 Silicon Graphics, Inc.  All Rights Reserved.
 #
 # This program is free software; you can redistribute it and/or modify
@@ -717,6 +717,7 @@ _img_info()
             -e "s#$IMGPROTO:$TEST_DIR#TEST_DIR#g" \
             -e "s#$TEST_DIR#TEST_DIR#g" \
             -e "s#$SOCK_DIR/fuse-#TEST_DIR/#g" \
+            -e "s#$SOCK_DIR/#SOCK_DIR/#g" \
             -e "s#$IMGFMT#IMGFMT#g" \
             -e 's/\(compression type: \)\(zlib\|zstd\)/\1COMPRESSION_TYPE/' \
             -e "/^disk size:/ D" \
-- 
2.40.1


