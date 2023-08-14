Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE59877BC16
	for <lists+qemu-devel@lfdr.de>; Mon, 14 Aug 2023 16:53:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVYuu-00052O-WF; Mon, 14 Aug 2023 10:51:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qVYus-00051e-Jx
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 10:51:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qVYup-0003Xh-SR
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 10:51:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692024690;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=k8uQiR4xztlKoM2fXk72fYRKfklULXJci2SehY8GBNE=;
 b=DU0tpC9aFAlLL/H/vCCwAvUWiXyAUhhJ/8hCQsetGS1hgvcWefoVMB1uNUnDIDUi7SpfQ5
 XTk+V/sQPstpQIgpaIhGn7o1m8sv9wHs62mBPZxJk0mjndtNBucvdbVh9iNoqjSp3YiT2E
 hHp9wnKv0En1H1/JaQOZYX1eLt6r480=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-594-sSPVgOVMPh-jk-uc6wWPUA-1; Mon, 14 Aug 2023 10:51:28 -0400
X-MC-Unique: sSPVgOVMPh-jk-uc6wWPUA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C6CF48DC672;
 Mon, 14 Aug 2023 14:51:27 +0000 (UTC)
Received: from thuth.com (unknown [10.39.193.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7B5A344104;
 Mon, 14 Aug 2023 14:51:26 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-block@nongnu.org,
	Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org,
	Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH] tests/qemu-iotests/183: Fix timeout issue when running tests
 in parallel
Date: Mon, 14 Aug 2023 16:51:24 +0200
Message-Id: <20230814145124.886292-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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

When running "make check-block SPEED=slow -j$(nproc)", the test 183
fails due to the very low default timeout value since the system is
quite loaded and thus slower in this case. We need a much higher
value when running tests in parallel, so let's try to detect this
situation by looking for "-j..." in the MAKEFLAGS environment variable.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 PS: Yeah, I know, this is a little bit ugly ... if someone has a better
 idea how to fix this, please let me know.

 tests/qemu-iotests/183 | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/183 b/tests/qemu-iotests/183
index ee62939e72..b50e0d2b85 100755
--- a/tests/qemu-iotests/183
+++ b/tests/qemu-iotests/183
@@ -97,7 +97,9 @@ if echo "$reply" | grep "compiled without old-style" > /dev/null; then
 fi
 
 timeout_comm=$QEMU_COMM_TIMEOUT
-if [ "${VALGRIND_QEMU}" == "y" ]; then
+if echo "$MAKEFLAGS" | grep -q "\-j"; then
+    QEMU_COMM_TIMEOUT=10
+elif [ "${VALGRIND_QEMU}" == "y" ]; then
     QEMU_COMM_TIMEOUT=4
 else
     QEMU_COMM_TIMEOUT=0.1
-- 
2.39.3


