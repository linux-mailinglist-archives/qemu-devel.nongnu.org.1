Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A42F706EC0
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 18:53:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzKNM-00043w-UA; Wed, 17 May 2023 12:51:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1pzKNK-00042b-Ib
 for qemu-devel@nongnu.org; Wed, 17 May 2023 12:51:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1pzKNI-0001Va-Vb
 for qemu-devel@nongnu.org; Wed, 17 May 2023 12:51:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684342300;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6HiFJsun4DvczkId8/hzkLX1Wz6i1p32cpQ72Lh7oqs=;
 b=FvYI8Zz3IgMB16X/njfKF/PVBvPKkI54+2s3U7kHGaEcA2yhsVpPQWnRumGJlsUjHE81ez
 jIPELct7iwnKP4K7Kg4MulS/wRU4EWydkiHN9VY+kyTemFRSpd28GX2nuuhyXCrhYrnlOQ
 VOTHJ4RkJM0OvkZOK8+WaSmz40+eMqM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-636-rP_bh_OAPu-80TrxgVFnyg-1; Wed, 17 May 2023 12:51:39 -0400
X-MC-Unique: rP_bh_OAPu-80TrxgVFnyg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B5C2E85A5A3;
 Wed, 17 May 2023 16:51:38 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 09ABA40C6EC4;
 Wed, 17 May 2023 16:51:37 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 16/18] iotests/245: Check if 'compress' driver is available
Date: Wed, 17 May 2023 18:51:14 +0200
Message-Id: <20230517165116.475123-17-kwolf@redhat.com>
In-Reply-To: <20230517165116.475123-1-kwolf@redhat.com>
References: <20230517165116.475123-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
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

Skip TestBlockdevReopen.test_insert_compress_filter() if the 'compress'
driver isn't available.

In order to make the test succeed when the case is skipped, we also need
to remove any output from it (which would be missing in the case where
we skip it). This is done by replacing qemu_io_log() with qemu_io(). In
case of failure, qemu_io() raises an exception with the output of the
qemu-io binary in its message, so we don't actually lose anything.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <20230511143801.255021-1-kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/245     | 7 ++++---
 tests/qemu-iotests/245.out | 9 +--------
 2 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/tests/qemu-iotests/245 b/tests/qemu-iotests/245
index edaf29094b..92b28c79be 100755
--- a/tests/qemu-iotests/245
+++ b/tests/qemu-iotests/245
@@ -611,6 +611,7 @@ class TestBlockdevReopen(iotests.QMPTestCase):
         self.reopen(hd0_opts, {'file': 'hd0-file'})
 
     # Insert (and remove) a compress filter
+    @iotests.skip_if_unsupported(['compress'])
     def test_insert_compress_filter(self):
         # Add an image to the VM: hd (raw) -> hd0 (qcow2) -> hd0-file (file)
         opts = {'driver': 'raw', 'node-name': 'hd', 'file': hd_opts(0)}
@@ -650,9 +651,9 @@ class TestBlockdevReopen(iotests.QMPTestCase):
 
         # Check the first byte of the first three L2 entries and verify that
         # the second one is compressed (0x40) while the others are not (0x80)
-        iotests.qemu_io_log('-f', 'raw', '-c', 'read -P 0x80 0x40000 1',
-                                         '-c', 'read -P 0x40 0x40008 1',
-                                         '-c', 'read -P 0x80 0x40010 1', hd_path[0])
+        iotests.qemu_io('-f', 'raw', '-c', 'read -P 0x80 0x40000 1',
+                                     '-c', 'read -P 0x40 0x40008 1',
+                                     '-c', 'read -P 0x80 0x40010 1', hd_path[0])
 
     # Swap the disk images of two active block devices
     def test_swap_files(self):
diff --git a/tests/qemu-iotests/245.out b/tests/qemu-iotests/245.out
index a4e04a3266..0970ced62a 100644
--- a/tests/qemu-iotests/245.out
+++ b/tests/qemu-iotests/245.out
@@ -10,14 +10,7 @@
 {"return": {}}
 {"data": {"id": "stream0", "type": "stream"}, "event": "BLOCK_JOB_PENDING", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 {"data": {"device": "stream0", "len": 3145728, "offset": 3145728, "speed": 0, "type": "stream"}, "event": "BLOCK_JOB_COMPLETED", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
-....read 1/1 bytes at offset 262144
-1 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-read 1/1 bytes at offset 262152
-1 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-read 1/1 bytes at offset 262160
-1 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-
-................
+....................
 ----------------------------------------------------------------------
 Ran 26 tests
 
-- 
2.40.1


