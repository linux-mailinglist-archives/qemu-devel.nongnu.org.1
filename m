Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B097B9E47
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 16:04:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoOq4-00008w-6Q; Thu, 05 Oct 2023 09:56:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qoOpx-00005k-0t; Thu, 05 Oct 2023 09:56:21 -0400
Received: from forwardcorp1c.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qoOpr-0001xT-MS; Thu, 05 Oct 2023 09:56:20 -0400
Received: from mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:7d8a:0:640:8fc3:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTP id B75935E9FA;
 Thu,  5 Oct 2023 16:56:13 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:b584::1:2f])
 by mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id qtYmoW4Oi4Y0-l16Wmaao; Thu, 05 Oct 2023 16:56:13 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1696514173;
 bh=ue9H0VVTFc/NFBBo19GdFV7OLPb9thJm9K5AkJZCNJs=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=erPZAab59k5T+33MbRrBGJB2sX1rfZUhoNJZ9uUoyr7kNrt9JHsOBOpIMGIOBD3/7
 wC8y7cAnBd31vyZehRikYAWIWI53/VKCr7Avdcwb2D5jFm+oOPSSgxZ1J2OFaNGJyG
 nfUzjJg690RzcDQHkcte0h3NPCahoMTntzf7Uuig=
Authentication-Results: mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, jsnow@redhat.com,
 crosa@redhat.com, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v6 08/14] iotests: add some missed checks of qmp result
Date: Thu,  5 Oct 2023 16:55:44 +0300
Message-Id: <20231005135550.331657-9-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231005135550.331657-1-vsementsov@yandex-team.ru>
References: <20231005135550.331657-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 tests/qemu-iotests/041                        | 1 +
 tests/qemu-iotests/151                        | 1 +
 tests/qemu-iotests/152                        | 2 ++
 tests/qemu-iotests/tests/migrate-bitmaps-test | 2 ++
 4 files changed, 6 insertions(+)

diff --git a/tests/qemu-iotests/041 b/tests/qemu-iotests/041
index 8429958bf0..4d7a829b65 100755
--- a/tests/qemu-iotests/041
+++ b/tests/qemu-iotests/041
@@ -1087,6 +1087,7 @@ class TestRepairQuorum(iotests.QMPTestCase):
         result = self.vm.qmp('blockdev-snapshot-sync', node_name='img1',
                              snapshot_file=quorum_snapshot_file,
                              snapshot_node_name="snap1");
+        self.assert_qmp(result, 'return', {})
 
         result = self.vm.qmp('drive-mirror', job_id='job0', device='quorum0',
                              sync='full', node_name='repair0', replaces="img1",
diff --git a/tests/qemu-iotests/151 b/tests/qemu-iotests/151
index b4d1bc2553..668d0c1e9c 100755
--- a/tests/qemu-iotests/151
+++ b/tests/qemu-iotests/151
@@ -159,6 +159,7 @@ class TestActiveMirror(iotests.QMPTestCase):
                              sync='full',
                              copy_mode='write-blocking',
                              speed=1)
+        self.assert_qmp(result, 'return', {})
 
         self.vm.hmp_qemu_io('source', 'break write_aio A')
         self.vm.hmp_qemu_io('source', 'aio_write 0 1M')  # 1
diff --git a/tests/qemu-iotests/152 b/tests/qemu-iotests/152
index 4e179c340f..b73a0d08a2 100755
--- a/tests/qemu-iotests/152
+++ b/tests/qemu-iotests/152
@@ -43,6 +43,7 @@ class TestUnaligned(iotests.QMPTestCase):
     def test_unaligned(self):
         result = self.vm.qmp('drive-mirror', device='drive0', sync='full',
                              granularity=65536, target=target_img)
+        self.assert_qmp(result, 'return', {})
         self.complete_and_wait()
         self.vm.shutdown()
         self.assertEqual(iotests.image_size(test_img), iotests.image_size(target_img),
@@ -51,6 +52,7 @@ class TestUnaligned(iotests.QMPTestCase):
     def test_unaligned_with_update(self):
         result = self.vm.qmp('drive-mirror', device='drive0', sync='full',
                              granularity=65536, target=target_img)
+        self.assert_qmp(result, 'return', {})
         self.wait_ready()
         self.vm.hmp_qemu_io('drive0', 'write 0 512')
         self.complete_and_wait(wait_ready=False)
diff --git a/tests/qemu-iotests/tests/migrate-bitmaps-test b/tests/qemu-iotests/tests/migrate-bitmaps-test
index 59f3357580..8668caae1e 100755
--- a/tests/qemu-iotests/tests/migrate-bitmaps-test
+++ b/tests/qemu-iotests/tests/migrate-bitmaps-test
@@ -101,6 +101,7 @@ class TestDirtyBitmapMigration(iotests.QMPTestCase):
         sha256 = get_bitmap_hash(self.vm_a)
 
         result = self.vm_a.qmp('migrate', uri=mig_cmd)
+        self.assert_qmp(result, 'return', {})
         while True:
             event = self.vm_a.event_wait('MIGRATION')
             if event['data']['status'] == 'completed':
@@ -176,6 +177,7 @@ class TestDirtyBitmapMigration(iotests.QMPTestCase):
         self.assert_qmp(result, 'return', {})
 
         result = self.vm_a.qmp('migrate', uri=mig_cmd)
+        self.assert_qmp(result, 'return', {})
         while True:
             event = self.vm_a.event_wait('MIGRATION')
             if event['data']['status'] == 'completed':
-- 
2.34.1


