Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B53F709AD2
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 17:03:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q01d3-0003Uf-5Y; Fri, 19 May 2023 11:02:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q01cm-0003Sc-8t
 for qemu-devel@nongnu.org; Fri, 19 May 2023 11:02:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1q01ci-000277-7B
 for qemu-devel@nongnu.org; Fri, 19 May 2023 11:02:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684508544;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=0bTIdHx5VKCO1f/mdTaqdNYAVr64xq7kVCAq3Z1PHLE=;
 b=VHMU4Sx76U8Mp0Zkm4jZ6iCbxMnrfsT/iB85XowLDX4evB4TeoxBGEAHTUDaAQMNwePe5G
 8KlPldFgP75ZgxBH4OvONQ6u6Tu+RtVuKOdfePOJ3JeOiGRIEE2+u8Ex0f/m0xjAZEdEPg
 xZIw/1S0gifQLujo3LUE59S069WAWyw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-274-VEuC3Sz6MAWzuGUoyMCW9g-1; Fri, 19 May 2023 11:02:21 -0400
X-MC-Unique: VEuC3Sz6MAWzuGUoyMCW9g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A765080013A;
 Fri, 19 May 2023 15:02:20 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.57])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1BF5A2026D49;
 Fri, 19 May 2023 15:02:20 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, hreitz@redhat.com, thuth@redhat.com,
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH] iotests: Fix test 104 under NBD
Date: Fri, 19 May 2023 10:02:16 -0500
Message-Id: <20230519150216.2599189-1-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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


