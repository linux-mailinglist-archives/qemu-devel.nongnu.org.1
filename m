Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF0B822D09
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jan 2024 13:30:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rL0O6-0006vh-RP; Wed, 03 Jan 2024 07:30:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rL0Nw-0006uY-9j
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 07:30:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rL0Nu-0003Bp-Bj
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 07:30:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704285009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=zzDJS3XVLPcBSvOhKcEkfLXII/vDkCSEdEkTE9Hn3sg=;
 b=BHmT2ClZXhG+M+bry2abx3qJVXqPgNp4E+TNOHeIr0mp0YmOFrnLFGaQ14LprQl3Ym3Skn
 9NQwVXQBhOkOWlnmCkI4n0mpMBZDDgvUyrJxZuOVYmj8Qu85vNWLyFZ4oCtG1cEeE/rEcE
 qhxY1mOslhdR7T6G8OMCutjS1GIJSVc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-oySDrYZOPLqYUTRdlYP6sQ-1; Wed, 03 Jan 2024 07:30:07 -0500
X-MC-Unique: oySDrYZOPLqYUTRdlYP6sQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2A476835380
 for <qemu-devel@nongnu.org>; Wed,  3 Jan 2024 12:30:07 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.117])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5668F1C060AF;
 Wed,  3 Jan 2024 12:30:06 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH] qtest: use correct boolean type for failover property
Date: Wed,  3 Jan 2024 12:30:05 +0000
Message-ID: <20240103123005.2400437-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.601,
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

QMP device_add does not historically validate the parameter types.
At some point it will likely change to enforce correct types, to
match behaviour of -device. The failover property is expected to
be a boolean in JSON.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/qtest/virtio-net-failover.c | 36 +++++++++++++++----------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/tests/qtest/virtio-net-failover.c b/tests/qtest/virtio-net-failover.c
index 0d40bc1f2d..73dfabc272 100644
--- a/tests/qtest/virtio-net-failover.c
+++ b/tests/qtest/virtio-net-failover.c
@@ -486,7 +486,7 @@ static void test_hotplug_1_reverse(void)
 
     qtest_qmp_device_add(qts, "virtio-net", "standby0",
                          "{'bus': 'root0',"
-                         "'failover': 'on',"
+                         "'failover': true,"
                          "'netdev': 'hs0',"
                          "'mac': '"MAC_STANDBY0"'}");
 
@@ -517,7 +517,7 @@ static void test_hotplug_2(void)
 
     qtest_qmp_device_add(qts, "virtio-net", "standby0",
                          "{'bus': 'root0',"
-                         "'failover': 'on',"
+                         "'failover': true,"
                          "'netdev': 'hs0',"
                          "'mac': '"MAC_STANDBY0"'}");
 
@@ -566,7 +566,7 @@ static void test_hotplug_2_reverse(void)
 
     qtest_qmp_device_add(qts, "virtio-net", "standby0",
                          "{'bus': 'root0',"
-                         "'failover': 'on',"
+                         "'failover': true,"
                          "'netdev': 'hs0',"
                          "'rombar': 0,"
                          "'romfile': '',"
@@ -639,7 +639,7 @@ static void test_migrate_out(gconstpointer opaque)
 
     qtest_qmp_device_add(qts, "virtio-net", "standby0",
                          "{'bus': 'root0',"
-                         "'failover': 'on',"
+                         "'failover': true,"
                          "'netdev': 'hs0',"
                          "'mac': '"MAC_STANDBY0"'}");
 
@@ -754,7 +754,7 @@ static void test_migrate_in(gconstpointer opaque)
 
     qtest_qmp_device_add(qts, "virtio-net", "standby0",
                          "{'bus': 'root0',"
-                         "'failover': 'on',"
+                         "'failover': true,"
                          "'netdev': 'hs0',"
                          "'mac': '"MAC_STANDBY0"'}");
 
@@ -808,7 +808,7 @@ static void test_off_migrate_out(gconstpointer opaque)
 
     qtest_qmp_device_add(qts, "virtio-net", "standby0",
                          "{'bus': 'root0',"
-                         "'failover': 'off',"
+                         "'failover': false,"
                          "'netdev': 'hs0',"
                          "'mac': '"MAC_STANDBY0"'}");
 
@@ -876,7 +876,7 @@ static void test_off_migrate_in(gconstpointer opaque)
 
     qtest_qmp_device_add(qts, "virtio-net", "standby0",
                          "{'bus': 'root0',"
-                         "'failover': 'off',"
+                         "'failover': false,"
                          "'netdev': 'hs0',"
                          "'mac': '"MAC_STANDBY0"'}");
 
@@ -927,7 +927,7 @@ static void test_guest_off_migrate_out(gconstpointer opaque)
 
     qtest_qmp_device_add(qts, "virtio-net", "standby0",
                          "{'bus': 'root0',"
-                         "'failover': 'on',"
+                         "'failover': true,"
                          "'netdev': 'hs0',"
                          "'mac': '"MAC_STANDBY0"'}");
 
@@ -1003,7 +1003,7 @@ static void test_guest_off_migrate_in(gconstpointer opaque)
 
     qtest_qmp_device_add(qts, "virtio-net", "standby0",
                          "{'bus': 'root0',"
-                         "'failover': 'on',"
+                         "'failover': true,"
                          "'netdev': 'hs0',"
                          "'mac': '"MAC_STANDBY0"'}");
 
@@ -1054,7 +1054,7 @@ static void test_migrate_guest_off_abort(gconstpointer opaque)
 
     qtest_qmp_device_add(qts, "virtio-net", "standby0",
                          "{'bus': 'root0',"
-                         "'failover': 'on',"
+                         "'failover': true,"
                          "'netdev': 'hs0',"
                          "'mac': '"MAC_STANDBY0"'}");
 
@@ -1154,7 +1154,7 @@ static void test_migrate_abort_wait_unplug(gconstpointer opaque)
 
     qtest_qmp_device_add(qts, "virtio-net", "standby0",
                          "{'bus': 'root0',"
-                         "'failover': 'on',"
+                         "'failover': true,"
                          "'netdev': 'hs0',"
                          "'mac': '"MAC_STANDBY0"'}");
 
@@ -1243,7 +1243,7 @@ static void test_migrate_abort_active(gconstpointer opaque)
 
     qtest_qmp_device_add(qts, "virtio-net", "standby0",
                          "{'bus': 'root0',"
-                         "'failover': 'on',"
+                         "'failover': true,"
                          "'netdev': 'hs0',"
                          "'mac': '"MAC_STANDBY0"'}");
 
@@ -1342,7 +1342,7 @@ static void test_migrate_off_abort(gconstpointer opaque)
 
     qtest_qmp_device_add(qts, "virtio-net", "standby0",
                          "{'bus': 'root0',"
-                         "'failover': 'off',"
+                         "'failover': false,"
                          "'netdev': 'hs0',"
                          "'mac': '"MAC_STANDBY0"'}");
 
@@ -1434,7 +1434,7 @@ static void test_migrate_abort_timeout(gconstpointer opaque)
 
     qtest_qmp_device_add(qts, "virtio-net", "standby0",
                          "{'bus': 'root0',"
-                         "'failover': 'on',"
+                         "'failover': true,"
                          "'netdev': 'hs0',"
                          "'mac': '"MAC_STANDBY0"'}");
 
@@ -1530,7 +1530,7 @@ static void test_multi_out(gconstpointer opaque)
 
     qtest_qmp_device_add(qts, "virtio-net", "standby0",
                          "{'bus': 'root0',"
-                         "'failover': 'on',"
+                         "'failover': true,"
                          "'netdev': 'hs0',"
                          "'mac': '"MAC_STANDBY0"'}");
 
@@ -1561,7 +1561,7 @@ static void test_multi_out(gconstpointer opaque)
 
     qtest_qmp_device_add(qts, "virtio-net", "standby1",
                          "{'bus': 'root2',"
-                         "'failover': 'on',"
+                         "'failover': true,"
                          "'netdev': 'hs2',"
                          "'mac': '"MAC_STANDBY1"'}");
 
@@ -1700,7 +1700,7 @@ static void test_multi_in(gconstpointer opaque)
 
     qtest_qmp_device_add(qts, "virtio-net", "standby0",
                          "{'bus': 'root0',"
-                         "'failover': 'on',"
+                         "'failover': true,"
                          "'netdev': 'hs0',"
                          "'mac': '"MAC_STANDBY0"'}");
 
@@ -1724,7 +1724,7 @@ static void test_multi_in(gconstpointer opaque)
 
     qtest_qmp_device_add(qts, "virtio-net", "standby1",
                          "{'bus': 'root2',"
-                         "'failover': 'on',"
+                         "'failover': true,"
                          "'netdev': 'hs2',"
                          "'mac': '"MAC_STANDBY1"'}");
 
-- 
2.43.0


