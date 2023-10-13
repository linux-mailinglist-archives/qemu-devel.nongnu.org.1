Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 973F37C8D94
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 21:12:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrNYr-0008EP-2J; Fri, 13 Oct 2023 15:11:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qrNYc-0007TT-76
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 15:10:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qrNYI-0001zW-PS
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 15:10:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697224225;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=63oAWUDdJrQU5xMahSBgjJIxGvqOwtRogPzcH0MHJqE=;
 b=KEyre8uRx6sfnnK7EtmhAKiOqiGPS3oktISt4Jeu0PmpWfeKOt0rl23gDwBypEL89OCbOQ
 zHJsLI+BLfdRFwntL0kPQeoEXu3VHkgjoBsBMSxHJfmruOALzrAaBdybJL5c3K1vY10p2b
 cQQ1c8c6EAJ5MkPd1wod50p6/obqYF4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-170-RRlSd562Mrq-u6RZqwn-cQ-1; Fri, 13 Oct 2023 15:10:17 -0400
X-MC-Unique: RRlSd562Mrq-u6RZqwn-cQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 223503813BD4;
 Fri, 13 Oct 2023 19:10:16 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.32.124])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A473C40C6F79;
 Fri, 13 Oct 2023 19:10:14 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-arm@nongnu.org,
 Vladimir Sementsov-Ogievskiy <v.sementsov-og@mail.ru>,
 Ani Sinha <anisinha@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, qemu-s390x@nongnu.org,
 Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>, Eric Blake <eblake@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 qemu-block@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Joel Stanley <joel@jms.id.au>, Paolo Bonzini <pbonzini@redhat.com>,
 Andrew Jeffery <andrew@aj.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Eric Farman <farman@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Cleber Rosa <crosa@redhat.com>
Subject: [PULL 25/25] python: use vm.cmd() instead of vm.qmp() where
 appropriate
Date: Fri, 13 Oct 2023 15:09:40 -0400
Message-ID: <20231013190941.3699288-26-jsnow@redhat.com>
In-Reply-To: <20231013190941.3699288-1-jsnow@redhat.com>
References: <20231013190941.3699288-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

In many cases we just want an effect of qmp command and want to raise
on failure.  Use vm.cmd() method which does exactly this.

The commit is generated by command

  git grep -l '\.qmp(' | xargs ./scripts/python_qmp_updater.py

And then, fix self.assertRaises to expect ExecuteError exception in
tests/qemu-iotests/124

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-id: 20231006154125.1068348-16-vsementsov@yandex-team.ru
Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/avocado/vnc.py                          |  16 +-
 tests/qemu-iotests/030                        | 168 +++----
 tests/qemu-iotests/040                        | 172 +++----
 tests/qemu-iotests/041                        | 471 ++++++++----------
 tests/qemu-iotests/045                        |  15 +-
 tests/qemu-iotests/055                        |  62 +--
 tests/qemu-iotests/056                        |  77 ++-
 tests/qemu-iotests/093                        |  42 +-
 tests/qemu-iotests/118                        | 223 ++++-----
 tests/qemu-iotests/124                        | 102 ++--
 tests/qemu-iotests/129                        |  14 +-
 tests/qemu-iotests/132                        |   5 +-
 tests/qemu-iotests/139                        |  45 +-
 tests/qemu-iotests/147                        |  31 +-
 tests/qemu-iotests/151                        | 104 ++--
 tests/qemu-iotests/152                        |  10 +-
 tests/qemu-iotests/155                        |  55 +-
 tests/qemu-iotests/165                        |   8 +-
 tests/qemu-iotests/196                        |   3 +-
 tests/qemu-iotests/205                        |   6 +-
 tests/qemu-iotests/218                        |  95 ++--
 tests/qemu-iotests/245                        | 245 ++++-----
 tests/qemu-iotests/264                        |  31 +-
 tests/qemu-iotests/281                        |  21 +-
 tests/qemu-iotests/295                        |  15 +-
 tests/qemu-iotests/296                        |  15 +-
 tests/qemu-iotests/298                        |  13 +-
 tests/qemu-iotests/300                        |  54 +-
 tests/qemu-iotests/iotests.py                 |   9 +-
 .../tests/backing-file-invalidation           |  11 +-
 tests/qemu-iotests/tests/copy-before-write    |  15 +-
 .../tests/export-incoming-iothread            |   6 +-
 .../qemu-iotests/tests/graph-changes-while-io |  18 +-
 tests/qemu-iotests/tests/image-fleecing       |   3 +-
 .../tests/migrate-bitmaps-postcopy-test       |  31 +-
 tests/qemu-iotests/tests/migrate-bitmaps-test |  47 +-
 .../qemu-iotests/tests/migrate-during-backup  |  37 +-
 .../qemu-iotests/tests/migration-permissions  |   9 +-
 .../tests/mirror-ready-cancel-error           |  74 ++-
 tests/qemu-iotests/tests/mirror-top-perms     |  16 +-
 tests/qemu-iotests/tests/nbd-multiconn        |  12 +-
 tests/qemu-iotests/tests/reopen-file          |   3 +-
 .../qemu-iotests/tests/stream-error-on-reset  |   6 +-
 .../qemu-iotests/tests/stream-under-throttle  |   7 +-
 44 files changed, 974 insertions(+), 1448 deletions(-)

diff --git a/tests/avocado/vnc.py b/tests/avocado/vnc.py
index aeeefc70be..862c8996a8 100644
--- a/tests/avocado/vnc.py
+++ b/tests/avocado/vnc.py
@@ -88,9 +88,8 @@ def test_change_password(self):
         self.vm.add_args('-nodefaults', '-S', '-vnc', ':0,password=on')
         self.vm.launch()
         self.assertTrue(self.vm.qmp('query-vnc')['return']['enabled'])
-        set_password_response = self.vm.qmp('change-vnc-password',
-                                            password='new_password')
-        self.assertEqual(set_password_response['return'], {})
+        self.vm.cmd('change-vnc-password',
+                    password='new_password')
 
     def test_change_listen(self):
         a, b, c = find_free_ports(3)
@@ -105,12 +104,11 @@ def test_change_listen(self):
         self.assertFalse(check_connect(b))
         self.assertFalse(check_connect(c))
 
-        res = self.vm.qmp('display-update', type='vnc',
-                          addresses=[{'type': 'inet', 'host': VNC_ADDR,
-                                      'port': str(b)},
-                                     {'type': 'inet', 'host': VNC_ADDR,
-                                      'port': str(c)}])
-        self.assertEqual(res['return'], {})
+        self.vm.cmd('display-update', type='vnc',
+                    addresses=[{'type': 'inet', 'host': VNC_ADDR,
+                                'port': str(b)},
+                               {'type': 'inet', 'host': VNC_ADDR,
+                                'port': str(c)}])
         self.assertEqual(self.vm.qmp('query-vnc')['return']['service'], str(b))
         self.assertFalse(check_connect(a))
         self.assertTrue(check_connect(b))
diff --git a/tests/qemu-iotests/030 b/tests/qemu-iotests/030
index 98595d47fe..0e6a39d103 100755
--- a/tests/qemu-iotests/030
+++ b/tests/qemu-iotests/030
@@ -56,8 +56,7 @@ class TestSingleDrive(iotests.QMPTestCase):
     def test_stream(self):
         self.assert_no_active_block_jobs()
 
-        result = self.vm.qmp('block-stream', device='drive0')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('block-stream', device='drive0')
 
         self.wait_until_completed()
 
@@ -77,8 +76,7 @@ class TestSingleDrive(iotests.QMPTestCase):
             qemu_io('-f', iotests.imgfmt, '-rU', '-c', 'map', mid_img).stdout,
             'image file map matches backing file before streaming')
 
-        result = self.vm.qmp('block-stream', device='mid', job_id='stream-mid')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('block-stream', device='mid', job_id='stream-mid')
 
         self.wait_until_completed(drive='stream-mid')
 
@@ -94,8 +92,7 @@ class TestSingleDrive(iotests.QMPTestCase):
         self.assert_no_active_block_jobs()
 
         self.vm.pause_drive('drive0')
-        result = self.vm.qmp('block-stream', device='drive0')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('block-stream', device='drive0')
 
         self.pause_job('drive0', wait=False)
         self.vm.resume_drive('drive0')
@@ -108,8 +105,7 @@ class TestSingleDrive(iotests.QMPTestCase):
         result = self.vm.qmp('query-block-jobs')
         self.assert_qmp(result, 'return[0]/offset', offset)
 
-        result = self.vm.qmp('block-job-resume', device='drive0')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('block-job-resume', device='drive0')
 
         self.wait_until_completed()
 
@@ -129,8 +125,7 @@ class TestSingleDrive(iotests.QMPTestCase):
             '-f', iotests.imgfmt, '-rU', '-c', 'map', test_img).stdout
 
         # This is a no-op: no data should ever be copied from the base image
-        result = self.vm.qmp('block-stream', device='drive0', base=mid_img)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('block-stream', device='drive0', base=mid_img)
 
         self.wait_until_completed()
 
@@ -144,8 +139,7 @@ class TestSingleDrive(iotests.QMPTestCase):
     def test_stream_partial(self):
         self.assert_no_active_block_jobs()
 
-        result = self.vm.qmp('block-stream', device='drive0', base=backing_img)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('block-stream', device='drive0', base=backing_img)
 
         self.wait_until_completed()
 
@@ -172,24 +166,22 @@ class TestSingleDrive(iotests.QMPTestCase):
             qemu_img('create', '-f', iotests.imgfmt, ro_top_path,
                      str(self.image_len))
 
-            result = self.vm.qmp('blockdev-add',
-                                 node_name='ro-top',
-                                 driver=iotests.imgfmt,
-                                 read_only=True,
-                                 file={
-                                     'driver': 'file',
-                                     'filename': ro_top_path,
-                                     'read-only': True
-                                 },
-                                 backing='mid')
-            self.assert_qmp(result, 'return', {})
+            self.vm.cmd('blockdev-add',
+                        node_name='ro-top',
+                        driver=iotests.imgfmt,
+                        read_only=True,
+                        file={
+                            'driver': 'file',
+                            'filename': ro_top_path,
+                            'read-only': True
+                        },
+                        backing='mid')
 
             result = self.vm.qmp('block-stream', job_id='stream',
                                  device='ro-top', base_node='base')
             self.assert_qmp(result, 'error/desc', 'Block node is read-only')
 
-            result = self.vm.qmp('blockdev-del', node_name='ro-top')
-            self.assert_qmp(result, 'return', {})
+            self.vm.cmd('blockdev-del', node_name='ro-top')
 
 
 class TestParallelOps(iotests.QMPTestCase):
@@ -254,10 +246,9 @@ class TestParallelOps(iotests.QMPTestCase):
             node_name = 'node%d' % i
             job_id = 'stream-%s' % node_name
             pending_jobs.append(job_id)
-            result = self.vm.qmp('block-stream', device=node_name,
-                                 job_id=job_id, bottom=f'node{i-1}',
-                                 speed=1024)
-            self.assert_qmp(result, 'return', {})
+            self.vm.cmd('block-stream', device=node_name,
+                        job_id=job_id, bottom=f'node{i-1}',
+                        speed=1024)
 
         # Do this in reverse: After unthrottling them, some jobs may finish
         # before we have unthrottled all of them.  This will drain their
@@ -269,8 +260,7 @@ class TestParallelOps(iotests.QMPTestCase):
         # Starting from the top (i.e. in reverse) does not have this problem:
         # When a job finishes, the ones below it are not advanced.
         for job in reversed(pending_jobs):
-            result = self.vm.qmp('block-job-set-speed', device=job, speed=0)
-            self.assert_qmp(result, 'return', {})
+            self.vm.cmd('block-job-set-speed', device=job, speed=0)
 
         # Wait for all jobs to be finished.
         while len(pending_jobs) > 0:
@@ -297,10 +287,9 @@ class TestParallelOps(iotests.QMPTestCase):
         self.assert_no_active_block_jobs()
 
         # Set a speed limit to make sure that this job blocks the rest
-        result = self.vm.qmp('block-stream', device='node4',
-                             job_id='stream-node4', base=self.imgs[1],
-                             filter_node_name='stream-filter', speed=1024*1024)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('block-stream', device='node4',
+                    job_id='stream-node4', base=self.imgs[1],
+                    filter_node_name='stream-filter', speed=1024*1024)
 
         result = self.vm.qmp('block-stream', device='node5', job_id='stream-node5', base=self.imgs[2])
         self.assert_qmp(result, 'error/desc',
@@ -328,8 +317,7 @@ class TestParallelOps(iotests.QMPTestCase):
         self.assert_qmp(result, 'error/desc',
             "Node 'node2' is busy: block device is in use by block job: stream")
 
-        result = self.vm.qmp('block-job-set-speed', device='stream-node4', speed=0)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('block-job-set-speed', device='stream-node4', speed=0)
 
         self.wait_until_completed(drive='stream-node4')
         self.assert_no_active_block_jobs()
@@ -341,8 +329,7 @@ class TestParallelOps(iotests.QMPTestCase):
         self.assert_no_active_block_jobs()
 
         # Set a speed limit to make sure that this job blocks the rest
-        result = self.vm.qmp('block-commit', device='drive0', top=self.imgs[5], base=self.imgs[3], job_id='commit-node3', speed=1024*1024)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('block-commit', device='drive0', top=self.imgs[5], base=self.imgs[3], job_id='commit-node3', speed=1024*1024)
 
         result = self.vm.qmp('block-stream', device='node3', job_id='stream-node3')
         self.assert_qmp(result, 'error/desc',
@@ -365,8 +352,7 @@ class TestParallelOps(iotests.QMPTestCase):
         self.assert_qmp(result, 'error/desc',
             "Node 'drive0' is busy: block device is in use by block job: commit")
 
-        result = self.vm.qmp('block-job-set-speed', device='commit-node3', speed=0)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('block-job-set-speed', device='commit-node3', speed=0)
 
         self.wait_until_completed(drive='commit-node3')
 
@@ -377,23 +363,20 @@ class TestParallelOps(iotests.QMPTestCase):
         self.assert_no_active_block_jobs()
 
         # Set a speed limit to make sure that this job blocks the rest
-        result = self.vm.qmp('block-commit', device='drive0', base=self.imgs[3], job_id='commit-drive0', speed=1024*1024)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('block-commit', device='drive0', base=self.imgs[3], job_id='commit-drive0', speed=1024*1024)
 
         result = self.vm.qmp('block-stream', device='node5', base=self.imgs[3], job_id='stream-node6')
         self.assert_qmp(result, 'error/desc',
             "Node 'node5' is busy: block device is in use by block job: commit")
 
-        result = self.vm.qmp('block-job-set-speed', device='commit-drive0', speed=0)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('block-job-set-speed', device='commit-drive0', speed=0)
 
         event = self.vm.event_wait(name='BLOCK_JOB_READY')
         self.assert_qmp(event, 'data/device', 'commit-drive0')
         self.assert_qmp(event, 'data/type', 'commit')
         self.assert_qmp_absent(event, 'data/error')
 
-        result = self.vm.qmp('block-job-complete', device='commit-drive0')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('block-job-complete', device='commit-drive0')
 
         self.wait_until_completed(drive='commit-drive0')
 
@@ -404,18 +387,16 @@ class TestParallelOps(iotests.QMPTestCase):
         self.assert_no_active_block_jobs()
 
         # Commit from node2 into node0
-        result = self.vm.qmp('block-commit', device='drive0',
-                             top=self.imgs[2], base=self.imgs[0],
-                             filter_node_name='commit-filter', speed=1024*1024)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('block-commit', device='drive0',
+                    top=self.imgs[2], base=self.imgs[0],
+                    filter_node_name='commit-filter', speed=1024*1024)
 
         # Stream from node2 into node4
         result = self.vm.qmp('block-stream', device='node4', base_node='node2', job_id='node4')
         self.assert_qmp(result, 'error/desc',
             "Cannot freeze 'backing' link to 'commit-filter'")
 
-        result = self.vm.qmp('block-job-set-speed', device='drive0', speed=0)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('block-job-set-speed', device='drive0', speed=0)
 
         self.wait_until_completed()
         self.assert_no_active_block_jobs()
@@ -428,18 +409,15 @@ class TestParallelOps(iotests.QMPTestCase):
         self.assert_no_active_block_jobs()
 
         # Commit from node2 into node0
-        result = self.vm.qmp('block-commit', device='drive0',
-                             top_node='node2', base_node='node0',
-                             filter_node_name='commit-filter', speed=1024*1024)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('block-commit', device='drive0',
+                    top_node='node2', base_node='node0',
+                    filter_node_name='commit-filter', speed=1024*1024)
 
         # Stream from node2 into node4
-        result = self.vm.qmp('block-stream', device='node4',
-                             base_node='commit-filter', job_id='node4')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('block-stream', device='node4',
+                    base_node='commit-filter', job_id='node4')
 
-        result = self.vm.qmp('block-job-set-speed', device='drive0', speed=0)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('block-job-set-speed', device='drive0', speed=0)
 
         self.vm.run_job(job='drive0', auto_dismiss=True)
         self.vm.run_job(job='node4', auto_dismiss=True)
@@ -458,12 +436,10 @@ class TestParallelOps(iotests.QMPTestCase):
         self.assert_no_active_block_jobs()
 
         # Stream from node0 into node2
-        result = self.vm.qmp('block-stream', device='node2', base_node='node0', job_id='node2')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('block-stream', device='node2', base_node='node0', job_id='node2')
 
         # Commit from the active layer into node3
-        result = self.vm.qmp('block-commit', device='drive0', base=self.imgs[3])
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('block-commit', device='drive0', base=self.imgs[3])
 
         # Wait for all jobs to be finished.
         pending_jobs = ['node2', 'drive0']
@@ -490,16 +466,13 @@ class TestParallelOps(iotests.QMPTestCase):
         self.assert_no_active_block_jobs()
 
         # Stream from node0 into node4
-        result = self.vm.qmp('block-stream', device='node4', base_node='node0', job_id='node4', speed=1024*1024)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('block-stream', device='node4', base_node='node0', job_id='node4', speed=1024*1024)
 
         # Commit from the active layer into node5
-        result = self.vm.qmp('block-commit', device='drive0', base=self.imgs[5], speed=1024*1024)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('block-commit', device='drive0', base=self.imgs[5], speed=1024*1024)
 
         for job in ['drive0', 'node4']:
-            result = self.vm.qmp('block-job-set-speed', device=job, speed=0)
-            self.assert_qmp(result, 'return', {})
+            self.vm.cmd('block-job-set-speed', device=job, speed=0)
 
         # Wait for all jobs to be finished.
         pending_jobs = ['node4', 'drive0']
@@ -549,8 +522,7 @@ class TestParallelOps(iotests.QMPTestCase):
             "'base' and 'base-node' cannot be specified at the same time")
 
         # Success: the base node is a backing file of the top node
-        result = self.vm.qmp('block-stream', device='node4', base_node='node2', job_id='stream')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('block-stream', device='node4', base_node='node2', job_id='stream')
 
         self.wait_until_completed(drive='stream')
 
@@ -606,8 +578,7 @@ class TestQuorum(iotests.QMPTestCase):
 
         self.assert_no_active_block_jobs()
 
-        result = self.vm.qmp('block-stream', device='node0', job_id='stream-node0')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('block-stream', device='node0', job_id='stream-node0')
 
         self.wait_until_completed(drive='stream-node0')
 
@@ -636,8 +607,7 @@ class TestSmallerBackingFile(iotests.QMPTestCase):
     def test_stream(self):
         self.assert_no_active_block_jobs()
 
-        result = self.vm.qmp('block-stream', device='drive0')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('block-stream', device='drive0')
 
         self.wait_until_completed()
 
@@ -694,8 +664,7 @@ class TestEIO(TestErrors):
     def test_report(self):
         self.assert_no_active_block_jobs()
 
-        result = self.vm.qmp('block-stream', device='drive0')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('block-stream', device='drive0')
 
         completed = False
         error = False
@@ -722,8 +691,7 @@ class TestEIO(TestErrors):
     def test_ignore(self):
         self.assert_no_active_block_jobs()
 
-        result = self.vm.qmp('block-stream', device='drive0', on_error='ignore')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('block-stream', device='drive0', on_error='ignore')
 
         error = False
         completed = False
@@ -756,8 +724,7 @@ class TestEIO(TestErrors):
     def test_stop(self):
         self.assert_no_active_block_jobs()
 
-        result = self.vm.qmp('block-stream', device='drive0', on_error='stop')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('block-stream', device='drive0', on_error='stop')
 
         error = False
         completed = False
@@ -779,8 +746,7 @@ class TestEIO(TestErrors):
                     self.assert_qmp(result, 'return[0]/offset', self.STREAM_BUFFER_SIZE)
                     self.assert_qmp(result, 'return[0]/io-status', 'failed')
 
-                    result = self.vm.qmp('block-job-resume', device='drive0')
-                    self.assert_qmp(result, 'return', {})
+                    self.vm.cmd('block-job-resume', device='drive0')
 
                     result = self.vm.qmp('query-block-jobs')
                     if result == {'return': []}:
@@ -806,8 +772,7 @@ class TestEIO(TestErrors):
     def test_enospc(self):
         self.assert_no_active_block_jobs()
 
-        result = self.vm.qmp('block-stream', device='drive0', on_error='enospc')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('block-stream', device='drive0', on_error='enospc')
 
         completed = False
         error = False
@@ -852,8 +817,7 @@ class TestENOSPC(TestErrors):
     def test_enospc(self):
         self.assert_no_active_block_jobs()
 
-        result = self.vm.qmp('block-stream', device='drive0', on_error='enospc')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('block-stream', device='drive0', on_error='enospc')
 
         error = False
         completed = False
@@ -875,8 +839,7 @@ class TestENOSPC(TestErrors):
                     self.assert_qmp(result, 'return[0]/offset', self.STREAM_BUFFER_SIZE)
                     self.assert_qmp(result, 'return[0]/io-status', 'nospace')
 
-                    result = self.vm.qmp('block-job-resume', device='drive0')
-                    self.assert_qmp(result, 'return', {})
+                    self.vm.cmd('block-job-resume', device='drive0')
 
                     result = self.vm.qmp('query-block-jobs')
                     if result == {'return': []}:
@@ -921,8 +884,7 @@ class TestStreamStop(iotests.QMPTestCase):
         self.assert_no_active_block_jobs()
 
         self.vm.pause_drive('drive0')
-        result = self.vm.qmp('block-stream', device='drive0')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('block-stream', device='drive0')
 
         time.sleep(0.1)
         events = self.vm.get_qmp_events(wait=False)
@@ -955,11 +917,9 @@ class TestSetSpeed(iotests.QMPTestCase):
     def perf_test_throughput(self):
         self.assert_no_active_block_jobs()
 
-        result = self.vm.qmp('block-stream', device='drive0')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('block-stream', device='drive0')
 
-        result = self.vm.qmp('block-job-set-speed', device='drive0', speed=8 * 1024 * 1024)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('block-job-set-speed', device='drive0', speed=8 * 1024 * 1024)
 
         self.wait_until_completed()
 
@@ -969,16 +929,14 @@ class TestSetSpeed(iotests.QMPTestCase):
         self.assert_no_active_block_jobs()
 
         self.vm.pause_drive('drive0')
-        result = self.vm.qmp('block-stream', device='drive0')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('block-stream', device='drive0')
 
         # Default speed is 0
         result = self.vm.qmp('query-block-jobs')
         self.assert_qmp(result, 'return[0]/device', 'drive0')
         self.assert_qmp(result, 'return[0]/speed', 0)
 
-        result = self.vm.qmp('block-job-set-speed', device='drive0', speed=8 * 1024 * 1024)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('block-job-set-speed', device='drive0', speed=8 * 1024 * 1024)
 
         # Ensure the speed we set was accepted
         result = self.vm.qmp('query-block-jobs')
@@ -989,8 +947,7 @@ class TestSetSpeed(iotests.QMPTestCase):
         self.vm.pause_drive('drive0')
 
         # Check setting speed in block-stream works
-        result = self.vm.qmp('block-stream', device='drive0', speed=4 * 1024 * 1024)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('block-stream', device='drive0', speed=4 * 1024 * 1024)
 
         result = self.vm.qmp('query-block-jobs')
         self.assert_qmp(result, 'return[0]/device', 'drive0')
@@ -1007,8 +964,7 @@ class TestSetSpeed(iotests.QMPTestCase):
         self.assert_no_active_block_jobs()
 
         self.vm.pause_drive('drive0')
-        result = self.vm.qmp('block-stream', device='drive0')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('block-stream', device='drive0')
 
         result = self.vm.qmp('block-job-set-speed', device='drive0', speed=-1)
         self.assert_qmp(result, 'error/desc', "Parameter 'speed' expects a non-negative value")
diff --git a/tests/qemu-iotests/040 b/tests/qemu-iotests/040
index 4b8bf09a5d..5c18e413ec 100755
--- a/tests/qemu-iotests/040
+++ b/tests/qemu-iotests/040
@@ -61,17 +61,14 @@ class ImageCommitTestCase(iotests.QMPTestCase):
     def run_commit_test(self, top, base, need_ready=False, node_names=False):
         self.assert_no_active_block_jobs()
         if node_names:
-            result = self.vm.qmp('block-commit', device='drive0', top_node=top, base_node=base)
-            self.assert_qmp(result, 'return', {})
+            self.vm.cmd('block-commit', device='drive0', top_node=top, base_node=base)
         else:
-            result = self.vm.qmp('block-commit', device='drive0', top=top, base=base)
-            self.assert_qmp(result, 'return', {})
+            self.vm.cmd('block-commit', device='drive0', top=top, base=base)
         self.wait_for_complete(need_ready)
 
     def run_default_commit_test(self):
         self.assert_no_active_block_jobs()
-        result = self.vm.qmp('block-commit', device='drive0')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('block-commit', device='drive0')
         self.wait_for_complete()
 
 class TestSingleDrive(ImageCommitTestCase):
@@ -118,38 +115,30 @@ class TestSingleDrive(ImageCommitTestCase):
 
     @iotests.skip_if_unsupported(['throttle'])
     def test_commit_with_filter_and_quit(self):
-        result = self.vm.qmp('object-add', qom_type='throttle-group', id='tg')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('object-add', qom_type='throttle-group', id='tg')
 
         # Add a filter outside of the backing chain
-        result = self.vm.qmp('blockdev-add', driver='throttle', node_name='filter', throttle_group='tg', file='mid')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-add', driver='throttle', node_name='filter', throttle_group='tg', file='mid')
 
-        result = self.vm.qmp('block-commit', device='drive0')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('block-commit', device='drive0')
 
         # Quit immediately, thus forcing a simultaneous cancel of the
         # block job and a bdrv_drain_all()
-        result = self.vm.qmp('quit')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('quit')
 
     # Same as above, but this time we add the filter after starting the job
     @iotests.skip_if_unsupported(['throttle'])
     def test_commit_plus_filter_and_quit(self):
-        result = self.vm.qmp('object-add', qom_type='throttle-group', id='tg')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('object-add', qom_type='throttle-group', id='tg')
 
-        result = self.vm.qmp('block-commit', device='drive0')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('block-commit', device='drive0')
 
         # Add a filter outside of the backing chain
-        result = self.vm.qmp('blockdev-add', driver='throttle', node_name='filter', throttle_group='tg', file='mid')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-add', driver='throttle', node_name='filter', throttle_group='tg', file='mid')
 
         # Quit immediately, thus forcing a simultaneous cancel of the
         # block job and a bdrv_drain_all()
-        result = self.vm.qmp('quit')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('quit')
 
     def test_device_not_found(self):
         result = self.vm.qmp('block-commit', device='nonexistent', top='%s' % mid_img)
@@ -226,8 +215,7 @@ class TestSingleDrive(ImageCommitTestCase):
     def test_top_node_in_wrong_chain(self):
         self.assert_no_active_block_jobs()
 
-        result = self.vm.qmp('blockdev-add', driver='null-co', node_name='null')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-add', driver='null-co', node_name='null')
 
         result = self.vm.qmp('block-commit', device='drive0', top_node='null', base_node='base')
         self.assert_qmp(result, 'error/class', 'GenericError')
@@ -240,11 +228,9 @@ class TestSingleDrive(ImageCommitTestCase):
             return
 
         self.assert_no_active_block_jobs()
-        result = self.vm.qmp('block-commit', device='drive0', top=mid_img,
-                             base=backing_img, speed=(self.image_len // 4))
-        self.assert_qmp(result, 'return', {})
-        result = self.vm.qmp('device_del', id='scsi0')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('block-commit', device='drive0', top=mid_img,
+                    base=backing_img, speed=(self.image_len // 4))
+        self.vm.cmd('device_del', id='scsi0')
 
         cancelled = False
         deleted = False
@@ -270,9 +256,8 @@ class TestSingleDrive(ImageCommitTestCase):
             return
 
         self.assert_no_active_block_jobs()
-        result = self.vm.qmp('block-commit', device='drive0', top=mid_img,
-                             base=backing_img, speed=(self.image_len // 4))
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('block-commit', device='drive0', top=mid_img,
+                    base=backing_img, speed=(self.image_len // 4))
 
         result = self.vm.qmp('query-block')
         self.assert_qmp(result, 'return[0]/inserted/file', test_img)
@@ -407,8 +392,7 @@ class TestSetSpeed(ImageCommitTestCase):
         self.assert_no_active_block_jobs()
 
         self.vm.pause_drive('drive0')
-        result = self.vm.qmp('block-commit', device='drive0', top=mid_img, speed=1024 * 1024)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('block-commit', device='drive0', top=mid_img, speed=1024 * 1024)
 
         # Ensure the speed we set was accepted
         result = self.vm.qmp('query-block-jobs')
@@ -481,8 +465,7 @@ class TestErrorHandling(iotests.QMPTestCase):
         os.remove(backing_img)
 
     def blockdev_add(self, **kwargs):
-        result = self.vm.qmp('blockdev-add', **kwargs)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-add', **kwargs)
 
     def add_block_nodes(self, base_debug=None, mid_debug=None, top_debug=None):
         self.blockdev_add(node_name='base-file', driver='file',
@@ -528,11 +511,9 @@ class TestErrorHandling(iotests.QMPTestCase):
                 completed = True
             elif ev['event'] == 'BLOCK_JOB_ERROR':
                 if error_pauses_job:
-                    result = self.vm.qmp('block-job-resume', device='job0')
-                    self.assert_qmp(result, 'return', {})
+                    self.vm.cmd('block-job-resume', device='job0')
             elif ev['event'] == 'BLOCK_JOB_READY':
-                result = self.vm.qmp('block-job-complete', device='job0')
-                self.assert_qmp(result, 'return', {})
+                self.vm.cmd('block-job-complete', device='job0')
             else:
                 self.fail("Unexpected event: %s" % ev)
             log.append(iotests.filter_qmp_event(ev))
@@ -595,11 +576,10 @@ class TestErrorHandling(iotests.QMPTestCase):
         self.add_block_nodes(top_debug=top_debug, mid_debug=mid_debug,
                              base_debug=base_debug)
 
-        result = self.vm.qmp('block-commit', job_id='job0', device='top-fmt',
-                             top_node='top-fmt' if active else 'mid-fmt',
-                             base_node='mid-fmt' if active else 'base-fmt',
-                             on_error=on_error)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('block-commit', job_id='job0', device='top-fmt',
+                    top_node='top-fmt' if active else 'mid-fmt',
+                    base_node='mid-fmt' if active else 'base-fmt',
+                    on_error=on_error)
 
     def testActiveReadErrorReport(self):
         self.prepare_and_start_job('report', top_event='read_aio')
@@ -771,10 +751,9 @@ class TestCommitWithFilters(iotests.QMPTestCase):
         self.vm = iotests.VM().add_device('virtio-scsi,id=vio-scsi')
         self.vm.launch()
 
-        result = self.vm.qmp('object-add', qom_type='throttle-group', id='tg')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('object-add', qom_type='throttle-group', id='tg')
 
-        result = self.vm.qmp('blockdev-add', {
+        self.vm.cmd('blockdev-add', {
                 'node-name': 'top-filter',
                 'driver': 'throttle',
                 'throttle-group': 'tg',
@@ -816,7 +795,6 @@ class TestCommitWithFilters(iotests.QMPTestCase):
                     }
                 }
             })
-        self.assert_qmp(result, 'return', {})
 
     def tearDown(self):
         self.vm.shutdown()
@@ -833,13 +811,12 @@ class TestCommitWithFilters(iotests.QMPTestCase):
         return self.vm.node_info(node)['image']['filename']
 
     def test_filterless_commit(self):
-        result = self.vm.qmp('block-commit',
-                             job_id='commit',
-                             device='top-filter',
-                             top_node='cow-2',
-                             base_node='cow-1',
-                             backing_file=self.img1)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('block-commit',
+                    job_id='commit',
+                    device='top-filter',
+                    top_node='cow-2',
+                    base_node='cow-1',
+                    backing_file=self.img1)
         self.wait_until_completed(drive='commit')
 
         self.assertIsNotNone(self.vm.node_info('cow-3'))
@@ -850,13 +827,12 @@ class TestCommitWithFilters(iotests.QMPTestCase):
         self.pattern_files[2] = self.img1
 
     def test_commit_through_filter(self):
-        result = self.vm.qmp('block-commit',
-                             job_id='commit',
-                             device='top-filter',
-                             top_node='cow-1',
-                             base_node='cow-0',
-                             backing_file=self.img0)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('block-commit',
+                    job_id='commit',
+                    device='top-filter',
+                    top_node='cow-1',
+                    base_node='cow-0',
+                    backing_file=self.img0)
         self.wait_until_completed(drive='commit')
 
         self.assertIsNotNone(self.vm.node_info('cow-2'))
@@ -871,9 +847,8 @@ class TestCommitWithFilters(iotests.QMPTestCase):
         # Add a device, so the commit job finds a parent it can change
         # to point to the base node (so we can test that top-filter is
         # dropped from the graph)
-        result = self.vm.qmp('device_add', id='drv0', driver='scsi-hd',
-                             bus='vio-scsi.0', drive='top-filter')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('device_add', id='drv0', driver='scsi-hd',
+                    bus='vio-scsi.0', drive='top-filter')
 
         # Try to release our reference to top-filter; that should not
         # work because drv0 uses it
@@ -881,16 +856,14 @@ class TestCommitWithFilters(iotests.QMPTestCase):
         self.assert_qmp(result, 'error/class', 'GenericError')
         self.assert_qmp(result, 'error/desc', 'Node top-filter is in use')
 
-        result = self.vm.qmp('block-commit',
-                             job_id='commit',
-                             device='top-filter',
-                             base_node='cow-2')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('block-commit',
+                    job_id='commit',
+                    device='top-filter',
+                    base_node='cow-2')
         self.complete_and_wait(drive='commit')
 
         # Try to release our reference to top-filter again
-        result = self.vm.qmp('blockdev-del', node_name='top-filter')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-del', node_name='top-filter')
 
         self.assertIsNone(self.vm.node_info('top-filter'))
         self.assertIsNone(self.vm.node_info('cow-3'))
@@ -905,12 +878,11 @@ class TestCommitWithFilters(iotests.QMPTestCase):
         self.pattern_files[3] = self.img2
 
     def test_filtered_active_commit_without_filter(self):
-        result = self.vm.qmp('block-commit',
-                             job_id='commit',
-                             device='top-filter',
-                             top_node='cow-3',
-                             base_node='cow-2')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('block-commit',
+                    job_id='commit',
+                    device='top-filter',
+                    top_node='cow-3',
+                    base_node='cow-2')
         self.complete_and_wait(drive='commit')
 
         self.assertIsNotNone(self.vm.node_info('top-filter'))
@@ -935,23 +907,22 @@ class TestCommitWithOverriddenBacking(iotests.QMPTestCase):
         self.vm.launch()
 
         # Use base_b instead of base_a as the backing of top
-        result = self.vm.qmp('blockdev-add', {
-                                'node-name': 'top',
-                                'driver': iotests.imgfmt,
-                                'file': {
-                                    'driver': 'file',
-                                    'filename': self.img_top
-                                },
-                                'backing': {
-                                    'node-name': 'base',
-                                    'driver': iotests.imgfmt,
-                                    'file': {
-                                        'driver': 'file',
-                                        'filename': self.img_base_b
-                                    }
-                                }
-                            })
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-add', {
+                        'node-name': 'top',
+                        'driver': iotests.imgfmt,
+                        'file': {
+                            'driver': 'file',
+                            'filename': self.img_top
+                        },
+                        'backing': {
+                            'node-name': 'base',
+                            'driver': iotests.imgfmt,
+                            'file': {
+                                'driver': 'file',
+                                'filename': self.img_base_b
+                            }
+                        }
+                    })
 
     def tearDown(self):
         self.vm.shutdown()
@@ -971,11 +942,10 @@ class TestCommitWithOverriddenBacking(iotests.QMPTestCase):
     def test_commit_to_b(self):
         # Try committing to base_b (which should work, since that is
         # actually top's backing image)
-        result = self.vm.qmp('block-commit',
-                             job_id='commit',
-                             device='top',
-                             base=self.img_base_b)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('block-commit',
+                    job_id='commit',
+                    device='top',
+                    base=self.img_base_b)
 
         self.vm.event_wait('BLOCK_JOB_READY')
         self.vm.qmp('block-job-complete', device='commit')
diff --git a/tests/qemu-iotests/041 b/tests/qemu-iotests/041
index 3aef42aec8..98d17b1388 100755
--- a/tests/qemu-iotests/041
+++ b/tests/qemu-iotests/041
@@ -65,9 +65,8 @@ class TestSingleDrive(iotests.QMPTestCase):
     def test_complete(self):
         self.assert_no_active_block_jobs()
 
-        result = self.vm.qmp(self.qmp_cmd, device='drive0', sync='full',
-                             target=self.qmp_target)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd(self.qmp_cmd, device='drive0', sync='full',
+                    target=self.qmp_target)
 
         self.complete_and_wait()
         result = self.vm.qmp('query-block')
@@ -79,9 +78,8 @@ class TestSingleDrive(iotests.QMPTestCase):
     def test_cancel(self):
         self.assert_no_active_block_jobs()
 
-        result = self.vm.qmp(self.qmp_cmd, device='drive0', sync='full',
-                             target=self.qmp_target)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd(self.qmp_cmd, device='drive0', sync='full',
+                    target=self.qmp_target)
 
         self.cancel_and_wait(force=True)
         result = self.vm.qmp('query-block')
@@ -90,9 +88,8 @@ class TestSingleDrive(iotests.QMPTestCase):
     def test_cancel_after_ready(self):
         self.assert_no_active_block_jobs()
 
-        result = self.vm.qmp(self.qmp_cmd, device='drive0', sync='full',
-                             target=self.qmp_target)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd(self.qmp_cmd, device='drive0', sync='full',
+                    target=self.qmp_target)
 
         self.wait_ready_and_cancel()
         result = self.vm.qmp('query-block')
@@ -104,9 +101,8 @@ class TestSingleDrive(iotests.QMPTestCase):
     def test_pause(self):
         self.assert_no_active_block_jobs()
 
-        result = self.vm.qmp(self.qmp_cmd, device='drive0', sync='full',
-                             target=self.qmp_target)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd(self.qmp_cmd, device='drive0', sync='full',
+                    target=self.qmp_target)
 
         self.pause_job('drive0')
 
@@ -117,8 +113,7 @@ class TestSingleDrive(iotests.QMPTestCase):
         result = self.vm.qmp('query-block-jobs')
         self.assert_qmp(result, 'return[0]/offset', offset)
 
-        result = self.vm.qmp('block-job-resume', device='drive0')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('block-job-resume', device='drive0')
 
         self.complete_and_wait()
         self.vm.shutdown()
@@ -129,9 +124,8 @@ class TestSingleDrive(iotests.QMPTestCase):
         self.assert_no_active_block_jobs()
 
         # A small buffer is rounded up automatically
-        result = self.vm.qmp(self.qmp_cmd, device='drive0', sync='full',
-                             buf_size=4096, target=self.qmp_target)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd(self.qmp_cmd, device='drive0', sync='full',
+                    buf_size=4096, target=self.qmp_target)
 
         self.complete_and_wait()
         result = self.vm.qmp('query-block')
@@ -145,9 +139,8 @@ class TestSingleDrive(iotests.QMPTestCase):
 
         qemu_img('create', '-f', iotests.imgfmt, '-o', 'cluster_size=%d,size=%d'
                         % (self.image_len, self.image_len), target_img)
-        result = self.vm.qmp(self.qmp_cmd, device='drive0', sync='full',
-                             buf_size=65536, mode='existing', target=self.qmp_target)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd(self.qmp_cmd, device='drive0', sync='full',
+                    buf_size=65536, mode='existing', target=self.qmp_target)
 
         self.complete_and_wait()
         result = self.vm.qmp('query-block')
@@ -162,9 +155,8 @@ class TestSingleDrive(iotests.QMPTestCase):
         qemu_img('create', '-f', iotests.imgfmt, '-o', 'cluster_size=%d,backing_file=%s'
                         % (self.image_len, backing_img),
                  '-F', 'raw', target_img)
-        result = self.vm.qmp(self.qmp_cmd, device='drive0', sync='full',
-                             mode='existing', target=self.qmp_target)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd(self.qmp_cmd, device='drive0', sync='full',
+                    mode='existing', target=self.qmp_target)
 
         self.complete_and_wait()
         result = self.vm.qmp('query-block')
@@ -178,9 +170,8 @@ class TestSingleDrive(iotests.QMPTestCase):
     def test_implicit_node(self):
         self.assert_no_active_block_jobs()
 
-        result = self.vm.qmp(self.qmp_cmd, device='drive0', sync='full',
-                             target=self.qmp_target)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd(self.qmp_cmd, device='drive0', sync='full',
+                    target=self.qmp_target)
 
         result = self.vm.qmp('query-block')
         self.assert_qmp(result, 'return[0]/inserted/file', test_img)
@@ -236,8 +227,7 @@ class TestSingleBlockdev(TestSingleDrive):
         args = {'driver': iotests.imgfmt,
                 'node-name': self.qmp_target,
                 'file': { 'filename': target_img, 'driver': 'file' } }
-        result = self.vm.qmp("blockdev-add", args)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd("blockdev-add", args)
 
     def test_mirror_to_self(self):
         result = self.vm.qmp(self.qmp_cmd, job_id='job0',
@@ -254,10 +244,9 @@ class TestSingleBlockdev(TestSingleDrive):
             result = self.vm.qmp('block_resize', node_name=node, size=65536)
             self.assert_qmp(result, 'error/class', 'GenericError')
 
-        result = self.vm.qmp(self.qmp_cmd, job_id='job0', device='drive0',
-                             sync='full', target=self.qmp_target,
-                             auto_finalize=False, auto_dismiss=False)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd(self.qmp_cmd, job_id='job0', device='drive0',
+                    sync='full', target=self.qmp_target,
+                    auto_finalize=False, auto_dismiss=False)
 
         result = self.vm.run_job('job0', auto_finalize=False,
                                  pre_finalize=pre_finalize)
@@ -270,14 +259,12 @@ class TestSingleBlockdev(TestSingleDrive):
         self.do_test_resize(None, self.qmp_target)
 
     def do_test_target_size(self, size):
-        result = self.vm.qmp('block_resize', node_name=self.qmp_target,
-                             size=size)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('block_resize', node_name=self.qmp_target,
+                    size=size)
 
-        result = self.vm.qmp(self.qmp_cmd, job_id='job0',
-                             device='drive0', sync='full', auto_dismiss=False,
-                             target=self.qmp_target)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd(self.qmp_cmd, job_id='job0',
+                    device='drive0', sync='full', auto_dismiss=False,
+                    target=self.qmp_target)
 
         result = self.vm.run_job('job0')
         self.assertEqual(result, 'Source and target image have different sizes')
@@ -337,9 +324,8 @@ class TestMirrorNoBacking(iotests.QMPTestCase):
 
         qemu_img('create', '-f', iotests.imgfmt,
                  '-o', 'backing_file=%s' % backing_img, '-F', 'raw', target_img)
-        result = self.vm.qmp('drive-mirror', device='drive0', sync='full',
-                             mode='existing', target=target_img)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('drive-mirror', device='drive0', sync='full',
+                    mode='existing', target=target_img)
 
         self.complete_and_wait()
         result = self.vm.qmp('query-block')
@@ -353,9 +339,8 @@ class TestMirrorNoBacking(iotests.QMPTestCase):
 
         qemu_img('create', '-f', iotests.imgfmt,
                  '-o', 'backing_file=%s' % backing_img, '-F', 'raw', target_img)
-        result = self.vm.qmp('drive-mirror', device='drive0', sync='full',
-                             mode='existing', target=target_img)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('drive-mirror', device='drive0', sync='full',
+                    mode='existing', target=target_img)
 
         self.wait_ready_and_cancel()
         result = self.vm.qmp('query-block')
@@ -374,9 +359,8 @@ class TestMirrorNoBacking(iotests.QMPTestCase):
                         % (TestMirrorNoBacking.image_len, target_backing_img),
                  '-F', iotests.imgfmt, target_img)
 
-        result = self.vm.qmp('drive-mirror', device='drive0', sync='full',
-                             mode='existing', target=target_img)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('drive-mirror', device='drive0', sync='full',
+                    mode='existing', target=target_img)
 
         self.complete_and_wait()
         result = self.vm.qmp('query-block')
@@ -409,9 +393,8 @@ class TestMirrorResized(iotests.QMPTestCase):
     def test_complete_top(self):
         self.assert_no_active_block_jobs()
 
-        result = self.vm.qmp('drive-mirror', device='drive0', sync='top',
-                             target=target_img)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('drive-mirror', device='drive0', sync='top',
+                    target=target_img)
 
         self.complete_and_wait()
         result = self.vm.qmp('query-block')
@@ -423,9 +406,8 @@ class TestMirrorResized(iotests.QMPTestCase):
     def test_complete_full(self):
         self.assert_no_active_block_jobs()
 
-        result = self.vm.qmp('drive-mirror', device='drive0', sync='full',
-                             target=target_img)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('drive-mirror', device='drive0', sync='full',
+                    target=target_img)
 
         self.complete_and_wait()
         result = self.vm.qmp('query-block')
@@ -488,9 +470,8 @@ new_state = "1"
     def test_report_read(self):
         self.assert_no_active_block_jobs()
 
-        result = self.vm.qmp('drive-mirror', device='drive0', sync='full',
-                             target=target_img)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('drive-mirror', device='drive0', sync='full',
+                    target=target_img)
 
         completed = False
         error = False
@@ -516,9 +497,8 @@ new_state = "1"
     def test_ignore_read(self):
         self.assert_no_active_block_jobs()
 
-        result = self.vm.qmp('drive-mirror', device='drive0', sync='full',
-                             target=target_img, on_source_error='ignore')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('drive-mirror', device='drive0', sync='full',
+                    target=target_img, on_source_error='ignore')
 
         event = self.vm.get_qmp_event(wait=True)
         while event['event'] == 'JOB_STATUS_CHANGE':
@@ -541,10 +521,9 @@ new_state = "1"
         qemu_img('create', '-f', iotests.imgfmt,
                  '-ocluster_size=131072,backing_file=%s' %(backing_img),
                  '-F', 'raw', target_img)
-        result = self.vm.qmp('drive-mirror', device='drive0', sync='top',
-                             on_source_error='ignore',
-                             mode='existing', target=target_img)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('drive-mirror', device='drive0', sync='top',
+                    on_source_error='ignore',
+                    mode='existing', target=target_img)
 
         event = self.vm.get_qmp_event(wait=True)
         while event['event'] == 'JOB_STATUS_CHANGE':
@@ -568,9 +547,8 @@ new_state = "1"
     def test_stop_read(self):
         self.assert_no_active_block_jobs()
 
-        result = self.vm.qmp('drive-mirror', device='drive0', sync='full',
-                             target=target_img, on_source_error='stop')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('drive-mirror', device='drive0', sync='full',
+                    target=target_img, on_source_error='stop')
 
         error = False
         ready = False
@@ -590,8 +568,7 @@ new_state = "1"
                     self.assert_qmp(result, 'return[0]/status', 'paused')
                     self.assert_qmp(result, 'return[0]/io-status', 'failed')
 
-                    result = self.vm.qmp('block-job-resume', device='drive0')
-                    self.assert_qmp(result, 'return', {})
+                    self.vm.cmd('block-job-resume', device='drive0')
                     error = True
                 elif event['event'] == 'BLOCK_JOB_READY':
                     self.assertTrue(error, 'job completed unexpectedly')
@@ -656,9 +633,8 @@ new_state = "1"
     def test_report_write(self):
         self.assert_no_active_block_jobs()
 
-        result = self.vm.qmp('drive-mirror', device='drive0', sync='full',
-                             mode='existing', target=self.target_img)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('drive-mirror', device='drive0', sync='full',
+                    mode='existing', target=self.target_img)
 
         completed = False
         error = False
@@ -682,10 +658,9 @@ new_state = "1"
     def test_ignore_write(self):
         self.assert_no_active_block_jobs()
 
-        result = self.vm.qmp('drive-mirror', device='drive0', sync='full',
-                             mode='existing', target=self.target_img,
-                             on_target_error='ignore')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('drive-mirror', device='drive0', sync='full',
+                    mode='existing', target=self.target_img,
+                    on_target_error='ignore')
 
         event = self.vm.event_wait(name='BLOCK_JOB_ERROR')
         self.assertEqual(event['event'], 'BLOCK_JOB_ERROR')
@@ -698,10 +673,9 @@ new_state = "1"
     def test_stop_write(self):
         self.assert_no_active_block_jobs()
 
-        result = self.vm.qmp('drive-mirror', device='drive0', sync='full',
-                             mode='existing', target=self.target_img,
-                             on_target_error='stop')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('drive-mirror', device='drive0', sync='full',
+                    mode='existing', target=self.target_img,
+                    on_target_error='stop')
 
         error = False
         ready = False
@@ -721,8 +695,7 @@ new_state = "1"
                     self.assert_qmp(result, 'return[0]/status', 'paused')
                     self.assert_qmp(result, 'return[0]/io-status', 'failed')
 
-                    result = self.vm.qmp('block-job-resume', device='drive0')
-                    self.assert_qmp(result, 'return', {})
+                    self.vm.cmd('block-job-resume', device='drive0')
 
                     result = self.vm.qmp('query-block-jobs')
                     self.assertIn(result['return'][0]['status'], ['running', 'ready'])
@@ -755,17 +728,15 @@ class TestSetSpeed(iotests.QMPTestCase):
     def test_set_speed(self):
         self.assert_no_active_block_jobs()
 
-        result = self.vm.qmp('drive-mirror', device='drive0', sync='full',
-                             target=target_img)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('drive-mirror', device='drive0', sync='full',
+                    target=target_img)
 
         # Default speed is 0
         result = self.vm.qmp('query-block-jobs')
         self.assert_qmp(result, 'return[0]/device', 'drive0')
         self.assert_qmp(result, 'return[0]/speed', 0)
 
-        result = self.vm.qmp('block-job-set-speed', device='drive0', speed=8 * 1024 * 1024)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('block-job-set-speed', device='drive0', speed=8 * 1024 * 1024)
 
         # Ensure the speed we set was accepted
         result = self.vm.qmp('query-block-jobs')
@@ -775,9 +746,8 @@ class TestSetSpeed(iotests.QMPTestCase):
         self.wait_ready_and_cancel()
 
         # Check setting speed in drive-mirror works
-        result = self.vm.qmp('drive-mirror', device='drive0', sync='full',
-                             target=target_img, speed=4*1024*1024)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('drive-mirror', device='drive0', sync='full',
+                    target=target_img, speed=4*1024*1024)
 
         result = self.vm.qmp('query-block-jobs')
         self.assert_qmp(result, 'return[0]/device', 'drive0')
@@ -794,9 +764,8 @@ class TestSetSpeed(iotests.QMPTestCase):
 
         self.assert_no_active_block_jobs()
 
-        result = self.vm.qmp('drive-mirror', device='drive0', sync='full',
-                             target=target_img)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('drive-mirror', device='drive0', sync='full',
+                    target=target_img)
 
         result = self.vm.qmp('block-job-set-speed', device='drive0', speed=-1)
         self.assert_qmp(result, 'error/class', 'GenericError')
@@ -811,13 +780,12 @@ class TestUnbackedSource(iotests.QMPTestCase):
                  str(TestUnbackedSource.image_len))
         self.vm = iotests.VM()
         self.vm.launch()
-        result = self.vm.qmp('blockdev-add', node_name='drive0',
-                             driver=iotests.imgfmt,
-                             file={
-                                 'driver': 'file',
-                                 'filename': test_img,
-                             })
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-add', node_name='drive0',
+                    driver=iotests.imgfmt,
+                    file={
+                        'driver': 'file',
+                        'filename': test_img,
+                    })
 
     def tearDown(self):
         self.vm.shutdown()
@@ -826,28 +794,25 @@ class TestUnbackedSource(iotests.QMPTestCase):
 
     def test_absolute_paths_full(self):
         self.assert_no_active_block_jobs()
-        result = self.vm.qmp('drive-mirror', job_id='drive0', device='drive0',
-                             sync='full', target=target_img,
-                             mode='absolute-paths')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('drive-mirror', job_id='drive0', device='drive0',
+                    sync='full', target=target_img,
+                    mode='absolute-paths')
         self.complete_and_wait()
         self.assert_no_active_block_jobs()
 
     def test_absolute_paths_top(self):
         self.assert_no_active_block_jobs()
-        result = self.vm.qmp('drive-mirror', job_id='drive0', device='drive0',
-                             sync='top', target=target_img,
-                             mode='absolute-paths')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('drive-mirror', job_id='drive0', device='drive0',
+                    sync='top', target=target_img,
+                    mode='absolute-paths')
         self.complete_and_wait()
         self.assert_no_active_block_jobs()
 
     def test_absolute_paths_none(self):
         self.assert_no_active_block_jobs()
-        result = self.vm.qmp('drive-mirror', job_id='drive0', device='drive0',
-                             sync='none', target=target_img,
-                             mode='absolute-paths')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('drive-mirror', job_id='drive0', device='drive0',
+                    sync='none', target=target_img,
+                    mode='absolute-paths')
         self.complete_and_wait()
         self.assert_no_active_block_jobs()
 
@@ -857,14 +822,12 @@ class TestUnbackedSource(iotests.QMPTestCase):
         qemu_io('-c', 'write -P 42 0 64k', target_img)
 
         self.assert_no_active_block_jobs()
-        result = self.vm.qmp('drive-mirror', job_id='drive0', device='drive0',
-                             sync='full', target=target_img, mode='existing')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('drive-mirror', job_id='drive0', device='drive0',
+                    sync='full', target=target_img, mode='existing')
         self.complete_and_wait()
         self.assert_no_active_block_jobs()
 
-        result = self.vm.qmp('blockdev-del', node_name='drive0')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-del', node_name='drive0')
 
         self.assertTrue(iotests.compare_images(test_img, target_img),
                         'target image does not match source after mirroring')
@@ -874,26 +837,22 @@ class TestUnbackedSource(iotests.QMPTestCase):
                  str(self.image_len))
         qemu_io('-c', 'write -P 42 0 64k', target_img)
 
-        result = self.vm.qmp('blockdev-add', node_name='target',
-                             driver=iotests.imgfmt,
-                             file={
-                                 'driver': 'file',
-                                 'filename': target_img,
-                             })
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-add', node_name='target',
+                    driver=iotests.imgfmt,
+                    file={
+                        'driver': 'file',
+                        'filename': target_img,
+                    })
 
         self.assert_no_active_block_jobs()
-        result = self.vm.qmp('blockdev-mirror', job_id='drive0', device='drive0',
-                             sync='full', target='target')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-mirror', job_id='drive0', device='drive0',
+                    sync='full', target='target')
         self.complete_and_wait()
         self.assert_no_active_block_jobs()
 
-        result = self.vm.qmp('blockdev-del', node_name='drive0')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-del', node_name='drive0')
 
-        result = self.vm.qmp('blockdev-del', node_name='target')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-del', node_name='target')
 
         self.assertTrue(iotests.compare_images(test_img, target_img),
                         'target image does not match source after mirroring')
@@ -918,10 +877,9 @@ class TestGranularity(iotests.QMPTestCase):
 
     def test_granularity(self):
         self.assert_no_active_block_jobs()
-        result = self.vm.qmp('drive-mirror', device='drive0',
-                             sync='full', target=target_img,
-                             mode='absolute-paths', granularity=8192)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('drive-mirror', device='drive0',
+                    sync='full', target=target_img,
+                    mode='absolute-paths', granularity=8192)
 
         event = self.vm.get_qmp_event(wait=60.0)
         while event['event'] == 'JOB_STATUS_CHANGE':
@@ -963,8 +921,7 @@ class TestRepairQuorum(iotests.QMPTestCase):
         #assemble the quorum block device from the individual files
         args = { "driver": "quorum", "node-name": "quorum0",
                  "vote-threshold": 2, "children": [ "img0", "img1", "img2" ] }
-        result = self.vm.qmp("blockdev-add", args)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd("blockdev-add", args)
 
 
     def tearDown(self):
@@ -978,10 +935,9 @@ class TestRepairQuorum(iotests.QMPTestCase):
                 pass
 
     def test_complete(self):
-        result = self.vm.qmp('drive-mirror', job_id='job0', device='quorum0',
-                             sync='full', node_name="repair0", replaces="img1",
-                             target=quorum_repair_img, format=iotests.imgfmt)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('drive-mirror', job_id='job0', device='quorum0',
+                    sync='full', node_name="repair0", replaces="img1",
+                    target=quorum_repair_img, format=iotests.imgfmt)
 
         self.complete_and_wait(drive="job0")
         self.assert_has_block_node("repair0", quorum_repair_img)
@@ -991,10 +947,9 @@ class TestRepairQuorum(iotests.QMPTestCase):
                         'target image does not match source after mirroring')
 
     def test_cancel(self):
-        result = self.vm.qmp('drive-mirror', job_id='job0', device='quorum0',
-                             sync='full', node_name="repair0", replaces="img1",
-                             target=quorum_repair_img, format=iotests.imgfmt)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('drive-mirror', job_id='job0', device='quorum0',
+                    sync='full', node_name="repair0", replaces="img1",
+                    target=quorum_repair_img, format=iotests.imgfmt)
 
         self.cancel_and_wait(drive="job0", force=True)
         # here we check that the last registered quorum file has not been
@@ -1002,10 +957,9 @@ class TestRepairQuorum(iotests.QMPTestCase):
         self.assert_has_block_node(None, quorum_img3)
 
     def test_cancel_after_ready(self):
-        result = self.vm.qmp('drive-mirror', job_id='job0', device='quorum0',
-                             sync='full', node_name="repair0", replaces="img1",
-                             target=quorum_repair_img, format=iotests.imgfmt)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('drive-mirror', job_id='job0', device='quorum0',
+                    sync='full', node_name="repair0", replaces="img1",
+                    target=quorum_repair_img, format=iotests.imgfmt)
 
         self.wait_ready_and_cancel(drive="job0")
         # here we check that the last registered quorum file has not been
@@ -1016,10 +970,9 @@ class TestRepairQuorum(iotests.QMPTestCase):
                         'target image does not match source after mirroring')
 
     def test_pause(self):
-        result = self.vm.qmp('drive-mirror', job_id='job0', device='quorum0',
-                             sync='full', node_name="repair0", replaces="img1",
-                             target=quorum_repair_img, format=iotests.imgfmt)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('drive-mirror', job_id='job0', device='quorum0',
+                    sync='full', node_name="repair0", replaces="img1",
+                    target=quorum_repair_img, format=iotests.imgfmt)
 
         self.pause_job('job0')
 
@@ -1030,8 +983,7 @@ class TestRepairQuorum(iotests.QMPTestCase):
         result = self.vm.qmp('query-block-jobs')
         self.assert_qmp(result, 'return[0]/offset', offset)
 
-        result = self.vm.qmp('block-job-resume', device='job0')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('block-job-resume', device='job0')
 
         self.complete_and_wait(drive="job0")
         self.vm.shutdown()
@@ -1084,20 +1036,18 @@ class TestRepairQuorum(iotests.QMPTestCase):
         self.assert_qmp(result, 'error/class', 'GenericError')
 
     def test_after_a_quorum_snapshot(self):
-        result = self.vm.qmp('blockdev-snapshot-sync', node_name='img1',
-                             snapshot_file=quorum_snapshot_file,
-                             snapshot_node_name="snap1")
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-snapshot-sync', node_name='img1',
+                    snapshot_file=quorum_snapshot_file,
+                    snapshot_node_name="snap1")
 
         result = self.vm.qmp('drive-mirror', job_id='job0', device='quorum0',
                              sync='full', node_name='repair0', replaces="img1",
                              target=quorum_repair_img, format=iotests.imgfmt)
         self.assert_qmp(result, 'error/class', 'GenericError')
 
-        result = self.vm.qmp('drive-mirror', job_id='job0', device='quorum0',
-                             sync='full', node_name='repair0', replaces="snap1",
-                             target=quorum_repair_img, format=iotests.imgfmt)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('drive-mirror', job_id='job0', device='quorum0',
+                    sync='full', node_name='repair0', replaces="snap1",
+                    target=quorum_repair_img, format=iotests.imgfmt)
 
         self.complete_and_wait('job0')
         self.assert_has_block_node("repair0", quorum_repair_img)
@@ -1108,15 +1058,13 @@ class TestRepairQuorum(iotests.QMPTestCase):
         Check that we cannot replace a Quorum child when it has other
         parents.
         """
-        result = self.vm.qmp('nbd-server-start',
-                             addr={
-                                 'type': 'unix',
-                                 'data': {'path': nbd_sock_path}
-                             })
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('nbd-server-start',
+                    addr={
+                        'type': 'unix',
+                        'data': {'path': nbd_sock_path}
+                    })
 
-        result = self.vm.qmp('nbd-server-add', device='img1')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('nbd-server-add', device='img1')
 
         result = self.vm.qmp('drive-mirror', job_id='mirror', device='quorum0',
                              sync='full', node_name='repair0', replaces='img1',
@@ -1131,20 +1079,17 @@ class TestRepairQuorum(iotests.QMPTestCase):
         The same as test_with_other_parent(), but add the NBD server
         only when the mirror job is already running.
         """
-        result = self.vm.qmp('nbd-server-start',
-                             addr={
-                                 'type': 'unix',
-                                 'data': {'path': nbd_sock_path}
-                             })
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('nbd-server-start',
+                    addr={
+                        'type': 'unix',
+                        'data': {'path': nbd_sock_path}
+                    })
 
-        result = self.vm.qmp('drive-mirror', job_id='mirror', device='quorum0',
-                             sync='full', node_name='repair0', replaces='img1',
-                             target=quorum_repair_img, format=iotests.imgfmt)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('drive-mirror', job_id='mirror', device='quorum0',
+                    sync='full', node_name='repair0', replaces='img1',
+                    target=quorum_repair_img, format=iotests.imgfmt)
 
-        result = self.vm.qmp('nbd-server-add', device='img1')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('nbd-server-add', device='img1')
 
         # The full error message goes to stderr, we will check it later
         self.complete_and_wait('mirror',
@@ -1200,9 +1145,8 @@ class TestOrphanedSource(iotests.QMPTestCase):
     def test_success(self):
         self.assert_no_active_block_jobs()
 
-        result = self.vm.qmp('blockdev-mirror', job_id='job', device='src',
-                             sync='full', target='dest')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-mirror', job_id='job', device='src',
+                    sync='full', target='dest')
 
         self.complete_and_wait('job')
 
@@ -1218,27 +1162,24 @@ class TestOrphanedSource(iotests.QMPTestCase):
 
         # Unshare consistent-read on the target
         # (The mirror job does not care)
-        result = self.vm.qmp('blockdev-add',
-                             driver='blkdebug',
-                             node_name='dest-perm',
-                             image='dest',
-                             unshare_child_perms=['consistent-read'])
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-add',
+                    driver='blkdebug',
+                    node_name='dest-perm',
+                    image='dest',
+                    unshare_child_perms=['consistent-read'])
 
-        result = self.vm.qmp('blockdev-mirror', job_id='job', device='src',
-                             sync='full', target='dest',
-                             filter_node_name='mirror-filter')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-mirror', job_id='job', device='src',
+                    sync='full', target='dest',
+                    filter_node_name='mirror-filter')
 
         # Require consistent-read on the source
         # (We can only add this node once the job has started, or it
         # will complain that it does not want to run on non-root nodes)
-        result = self.vm.qmp('blockdev-add',
-                             driver='blkdebug',
-                             node_name='src-perm',
-                             image='src',
-                             take_child_perms=['consistent-read'])
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-add',
+                    driver='blkdebug',
+                    node_name='src-perm',
+                    image='src',
+                    take_child_perms=['consistent-read'])
 
         # While completing, mirror will attempt to replace src by
         # dest, which must fail because src-perm requires
@@ -1278,26 +1219,23 @@ class TestReplaces(iotests.QMPTestCase):
         """
         Check that we can replace filter nodes.
         """
-        result = self.vm.qmp('blockdev-add', {
-                                 'driver': 'copy-on-read',
-                                 'node-name': 'filter0',
-                                 'file': {
-                                     'driver': 'copy-on-read',
-                                     'node-name': 'filter1',
-                                     'file': {
-                                         'driver': 'null-co'
-                                     }
-                                 }
-                             })
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-add', {
+                        'driver': 'copy-on-read',
+                        'node-name': 'filter0',
+                        'file': {
+                            'driver': 'copy-on-read',
+                            'node-name': 'filter1',
+                            'file': {
+                                'driver': 'null-co'
+                            }
+                        }
+                    })
 
-        result = self.vm.qmp('blockdev-add',
-                             node_name='target', driver='null-co')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-add',
+                    node_name='target', driver='null-co')
 
-        result = self.vm.qmp('blockdev-mirror', job_id='mirror', device='filter0',
-                             target='target', sync='full', replaces='filter1')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-mirror', job_id='mirror', device='filter0',
+                    target='target', sync='full', replaces='filter1')
 
         self.complete_and_wait('mirror')
 
@@ -1319,16 +1257,15 @@ class TestFilters(iotests.QMPTestCase):
         self.vm = iotests.VM().add_device('virtio-scsi,id=vio-scsi')
         self.vm.launch()
 
-        result = self.vm.qmp('blockdev-add', {
-                                'node-name': 'target',
-                                'driver': iotests.imgfmt,
-                                'file': {
-                                    'driver': 'file',
-                                    'filename': target_img
-                                },
-                                'backing': None
-                            })
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-add', {
+                        'node-name': 'target',
+                        'driver': iotests.imgfmt,
+                        'file': {
+                            'driver': 'file',
+                            'filename': target_img
+                        },
+                        'backing': None
+                    })
 
         self.filterless_chain = {
                 'node-name': 'source',
@@ -1355,19 +1292,17 @@ class TestFilters(iotests.QMPTestCase):
         os.remove(backing_img)
 
     def test_cor(self):
-        result = self.vm.qmp('blockdev-add', {
-                                'node-name': 'filter',
-                                'driver': 'copy-on-read',
-                                'file': self.filterless_chain
-                            })
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-add', {
+                        'node-name': 'filter',
+                        'driver': 'copy-on-read',
+                        'file': self.filterless_chain
+                    })
 
-        result = self.vm.qmp('blockdev-mirror',
-                             job_id='mirror',
-                             device='filter',
-                             target='target',
-                             sync='top')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-mirror',
+                    job_id='mirror',
+                    device='filter',
+                    target='target',
+                    sync='top')
 
         self.complete_and_wait('mirror')
 
@@ -1384,23 +1319,20 @@ class TestFilters(iotests.QMPTestCase):
         assert target_map[1]['depth'] == 0
 
     def test_implicit_mirror_filter(self):
-        result = self.vm.qmp('blockdev-add', self.filterless_chain)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-add', self.filterless_chain)
 
         # We need this so we can query from above the mirror node
-        result = self.vm.qmp('device_add',
-                             driver='scsi-hd',
-                             id='virtio',
-                             bus='vio-scsi.0',
-                             drive='source')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('device_add',
+                    driver='scsi-hd',
+                    id='virtio',
+                    bus='vio-scsi.0',
+                    drive='source')
 
-        result = self.vm.qmp('blockdev-mirror',
-                             job_id='mirror',
-                             device='source',
-                             target='target',
-                             sync='top')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-mirror',
+                    job_id='mirror',
+                    device='source',
+                    target='target',
+                    sync='top')
 
         # The mirror filter is now an implicit node, so it should be
         # invisible when querying the backing chain
@@ -1418,24 +1350,21 @@ class TestFilters(iotests.QMPTestCase):
     def test_explicit_mirror_filter(self):
         # Same test as above, but this time we give the mirror filter
         # a node-name so it will not be invisible
-        result = self.vm.qmp('blockdev-add', self.filterless_chain)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-add', self.filterless_chain)
 
         # We need this so we can query from above the mirror node
-        result = self.vm.qmp('device_add',
-                             driver='scsi-hd',
-                             id='virtio',
-                             bus='vio-scsi.0',
-                             drive='source')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('device_add',
+                    driver='scsi-hd',
+                    id='virtio',
+                    bus='vio-scsi.0',
+                    drive='source')
 
-        result = self.vm.qmp('blockdev-mirror',
-                             job_id='mirror',
-                             device='source',
-                             target='target',
-                             sync='top',
-                             filter_node_name='mirror-filter')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-mirror',
+                    job_id='mirror',
+                    device='source',
+                    target='target',
+                    sync='top',
+                    filter_node_name='mirror-filter')
 
         # With a node-name given to it, the mirror filter should now
         # be visible
diff --git a/tests/qemu-iotests/045 b/tests/qemu-iotests/045
index 45eb239baa..a341f21cd7 100755
--- a/tests/qemu-iotests/045
+++ b/tests/qemu-iotests/045
@@ -77,8 +77,7 @@ class TestFdSets(iotests.QMPTestCase):
         self.vm.shutdown()
 
     def test_remove_fdset(self):
-        result = self.vm.qmp('remove-fd', fdset_id=2)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('remove-fd', fdset_id=2)
         result = self.vm.qmp('query-fdsets')
         self.assert_qmp(result, 'return[0]/fdset-id', 1)
         self.assert_qmp(result, 'return[1]/fdset-id', 0)
@@ -90,8 +89,7 @@ class TestFdSets(iotests.QMPTestCase):
     def test_remove_fd(self):
         result = self.vm.qmp('query-fdsets')
         fd_image3 = result['return'][0]['fds'][0]['fd']
-        result = self.vm.qmp('remove-fd', fdset_id=2, fd=fd_image3)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('remove-fd', fdset_id=2, fd=fd_image3)
         result = self.vm.qmp('query-fdsets')
         self.assert_qmp(result, 'return[0]/fdset-id', 2)
         self.assert_qmp(result, 'return[1]/fdset-id', 1)
@@ -151,8 +149,7 @@ class TestSCMFd(iotests.QMPTestCase):
 
     def test_getfd(self):
         self._send_fd_by_SCM()
-        result = self.vm.qmp('getfd', fdname='image0:r')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('getfd', fdname='image0:r')
 
     def test_getfd_invalid_fdname(self):
         self._send_fd_by_SCM()
@@ -163,10 +160,8 @@ class TestSCMFd(iotests.QMPTestCase):
 
     def test_closefd(self):
         self._send_fd_by_SCM()
-        result = self.vm.qmp('getfd', fdname='image0:r')
-        self.assert_qmp(result, 'return', {})
-        result = self.vm.qmp('closefd', fdname='image0:r')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('getfd', fdname='image0:r')
+        self.vm.cmd('closefd', fdname='image0:r')
 
     def test_closefd_fd_not_found(self):
         fdname = 'image0:r'
diff --git a/tests/qemu-iotests/055 b/tests/qemu-iotests/055
index 5d6b607051..d8372b5598 100755
--- a/tests/qemu-iotests/055
+++ b/tests/qemu-iotests/055
@@ -69,8 +69,7 @@ class TestSingleDrive(iotests.QMPTestCase):
         self.assert_no_active_block_jobs()
 
         self.vm.pause_drive('drive0')
-        result = self.vm.qmp(cmd, device='drive0', target=target, sync='full')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd(cmd, device='drive0', target=target, sync='full')
 
         event = self.cancel_and_wait(resume=True)
         self.assert_qmp(event, 'data/type', 'backup')
@@ -85,9 +84,8 @@ class TestSingleDrive(iotests.QMPTestCase):
         self.assert_no_active_block_jobs()
 
         self.vm.pause_drive('drive0')
-        result = self.vm.qmp(cmd, device='drive0',
-                             target=target, sync='full')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd(cmd, device='drive0',
+                    target=target, sync='full')
 
         self.pause_job('drive0', wait=False)
         self.vm.resume_drive('drive0')
@@ -100,8 +98,7 @@ class TestSingleDrive(iotests.QMPTestCase):
         result = self.vm.qmp('query-block-jobs')
         self.assert_qmp(result, 'return[0]/offset', offset)
 
-        result = self.vm.qmp('block-job-resume', device='drive0')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('block-job-resume', device='drive0')
 
         self.wait_until_completed()
 
@@ -123,10 +120,9 @@ class TestSingleDrive(iotests.QMPTestCase):
             result = self.vm.qmp('block_resize', node_name=node, size=65536)
             self.assert_qmp(result, 'error/class', 'GenericError')
 
-        result = self.vm.qmp('blockdev-backup', job_id='job0', device='drive0',
-                             target='drive1', sync='full', auto_finalize=False,
-                             auto_dismiss=False)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-backup', job_id='job0', device='drive0',
+                    target='drive1', sync='full', auto_finalize=False,
+                    auto_dismiss=False)
 
         self.vm.run_job('job0', auto_finalize=False, pre_finalize=pre_finalize)
 
@@ -137,8 +133,7 @@ class TestSingleDrive(iotests.QMPTestCase):
         self.do_test_resize_blockdev_backup('drive1', 'target')
 
     def do_test_target_size(self, size):
-        result = self.vm.qmp('block_resize', device='drive1', size=size)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('block_resize', device='drive1', size=size)
 
         result = self.vm.qmp('blockdev-backup', job_id='job0', device='drive0',
                              target='drive1', sync='full')
@@ -219,16 +214,14 @@ class TestSetSpeed(iotests.QMPTestCase):
         self.assert_no_active_block_jobs()
 
         self.vm.pause_drive('drive0')
-        result = self.vm.qmp(cmd, device='drive0', target=target, sync='full')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd(cmd, device='drive0', target=target, sync='full')
 
         # Default speed is 0
         result = self.vm.qmp('query-block-jobs')
         self.assert_qmp(result, 'return[0]/device', 'drive0')
         self.assert_qmp(result, 'return[0]/speed', 0)
 
-        result = self.vm.qmp('block-job-set-speed', device='drive0', speed=8 * 1024 * 1024)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('block-job-set-speed', device='drive0', speed=8 * 1024 * 1024)
 
         # Ensure the speed we set was accepted
         result = self.vm.qmp('query-block-jobs')
@@ -240,9 +233,8 @@ class TestSetSpeed(iotests.QMPTestCase):
 
         # Check setting speed option works
         self.vm.pause_drive('drive0')
-        result = self.vm.qmp(cmd, device='drive0',
-                             target=target, sync='full', speed=4*1024*1024)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd(cmd, device='drive0',
+                    target=target, sync='full', speed=4*1024*1024)
 
         result = self.vm.qmp('query-block-jobs')
         self.assert_qmp(result, 'return[0]/device', 'drive0')
@@ -267,9 +259,8 @@ class TestSetSpeed(iotests.QMPTestCase):
         self.assert_no_active_block_jobs()
 
         self.vm.pause_drive('drive0')
-        result = self.vm.qmp(cmd, device='drive0',
-                             target=target, sync='full')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd(cmd, device='drive0',
+                    target=target, sync='full')
 
         result = self.vm.qmp('block-job-set-speed', device='drive0', speed=-1)
         self.assert_qmp(result, 'error/class', 'GenericError')
@@ -306,7 +297,7 @@ class TestSingleTransaction(iotests.QMPTestCase):
     def do_test_cancel(self, cmd, target):
         self.assert_no_active_block_jobs()
 
-        result = self.vm.qmp('transaction', actions=[{
+        self.vm.cmd('transaction', actions=[{
                 'type': cmd,
                 'data': { 'device': 'drive0',
                           'target': target,
@@ -315,8 +306,6 @@ class TestSingleTransaction(iotests.QMPTestCase):
             }
         ])
 
-        self.assert_qmp(result, 'return', {})
-
         event = self.cancel_and_wait()
         self.assert_qmp(event, 'data/type', 'backup')
 
@@ -329,7 +318,7 @@ class TestSingleTransaction(iotests.QMPTestCase):
     def do_test_pause(self, cmd, target, image):
         self.assert_no_active_block_jobs()
 
-        result = self.vm.qmp('transaction', actions=[{
+        self.vm.cmd('transaction', actions=[{
                 'type': cmd,
                 'data': { 'device': 'drive0',
                           'target': target,
@@ -337,12 +326,10 @@ class TestSingleTransaction(iotests.QMPTestCase):
                           'speed': 64 * 1024 },
             }
         ])
-        self.assert_qmp(result, 'return', {})
 
         self.pause_job('drive0', wait=False)
 
-        result = self.vm.qmp('block-job-set-speed', device='drive0', speed=0)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('block-job-set-speed', device='drive0', speed=0)
 
         self.pause_wait('drive0')
 
@@ -353,8 +340,7 @@ class TestSingleTransaction(iotests.QMPTestCase):
         result = self.vm.qmp('query-block-jobs')
         self.assert_qmp(result, 'return[0]/offset', offset)
 
-        result = self.vm.qmp('block-job-resume', device='drive0')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('block-job-resume', device='drive0')
 
         self.wait_until_completed()
 
@@ -519,8 +505,7 @@ class TestCompressedToQcow2(iotests.QMPTestCase):
 
         self.assert_no_active_block_jobs()
 
-        result = self.vm.qmp(cmd, device='drive0', sync='full', compress=True, **args)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd(cmd, device='drive0', sync='full', compress=True, **args)
 
         self.wait_until_completed()
 
@@ -545,8 +530,7 @@ class TestCompressedToQcow2(iotests.QMPTestCase):
         self.assert_no_active_block_jobs()
 
         self.vm.pause_drive('drive0')
-        result = self.vm.qmp(cmd, device='drive0', sync='full', compress=True, **args)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd(cmd, device='drive0', sync='full', compress=True, **args)
 
         event = self.cancel_and_wait(resume=True)
         self.assert_qmp(event, 'data/type', 'backup')
@@ -568,8 +552,7 @@ class TestCompressedToQcow2(iotests.QMPTestCase):
         self.assert_no_active_block_jobs()
 
         self.vm.pause_drive('drive0')
-        result = self.vm.qmp(cmd, device='drive0', sync='full', compress=True, **args)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd(cmd, device='drive0', sync='full', compress=True, **args)
 
         self.pause_job('drive0', wait=False)
         self.vm.resume_drive('drive0')
@@ -582,8 +565,7 @@ class TestCompressedToQcow2(iotests.QMPTestCase):
         result = self.vm.qmp('query-block-jobs')
         self.assert_qmp(result, 'return[0]/offset', offset)
 
-        result = self.vm.qmp('block-job-resume', device='drive0')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('block-job-resume', device='drive0')
 
         self.wait_until_completed()
 
diff --git a/tests/qemu-iotests/056 b/tests/qemu-iotests/056
index bef865eec4..808ea6b48a 100755
--- a/tests/qemu-iotests/056
+++ b/tests/qemu-iotests/056
@@ -75,9 +75,8 @@ class TestSyncModesNoneAndTop(iotests.QMPTestCase):
 
     def test_complete_top(self):
         self.assert_no_active_block_jobs()
-        result = self.vm.qmp('drive-backup', device='drive0', sync='top',
-                             format=iotests.imgfmt, target=target_img)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('drive-backup', device='drive0', sync='top',
+                    format=iotests.imgfmt, target=target_img)
 
         self.wait_until_completed(check_offset=False)
 
@@ -89,9 +88,8 @@ class TestSyncModesNoneAndTop(iotests.QMPTestCase):
     def test_cancel_sync_none(self):
         self.assert_no_active_block_jobs()
 
-        result = self.vm.qmp('drive-backup', device='drive0',
-                             sync='none', target=target_img)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('drive-backup', device='drive0',
+                    sync='none', target=target_img)
         time.sleep(1)
         self.vm.hmp_qemu_io('drive0', 'write -P0x5e 0 512')
         self.vm.hmp_qemu_io('drive0', 'aio_flush')
@@ -115,18 +113,15 @@ class TestBeforeWriteNotifier(iotests.QMPTestCase):
 
     def test_before_write_notifier(self):
         self.vm.pause_drive("drive0")
-        result = self.vm.qmp('drive-backup', device='drive0',
-                             sync='full', target=target_img,
-                             format="file", speed=1)
-        self.assert_qmp(result, 'return', {})
-        result = self.vm.qmp('block-job-pause', device="drive0")
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('drive-backup', device='drive0',
+                    sync='full', target=target_img,
+                    format="file", speed=1)
+        self.vm.cmd('block-job-pause', device="drive0")
         # Speed is low enough that this must be an uncopied range, which will
         # trigger the before write notifier
         self.vm.hmp_qemu_io('drive0', 'aio_write -P 1 512512 512')
         self.vm.resume_drive("drive0")
-        result = self.vm.qmp('block-job-resume', device="drive0")
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('block-job-resume', device="drive0")
         event = self.cancel_and_wait()
         self.assert_qmp(event, 'data/type', 'backup')
 
@@ -191,8 +186,7 @@ class BackupTest(iotests.QMPTestCase):
         self.qmp_backup_and_wait(device='drive0', format=iotests.imgfmt,
                                  sync='full', target=self.ref_img,
                                  auto_dismiss=False)
-        res = self.vm.qmp('block-job-dismiss', id='drive0')
-        self.assert_qmp(res, 'return', {})
+        self.vm.cmd('block-job-dismiss', id='drive0')
 
         # Now to the test backup: We simulate the following guest
         # writes:
@@ -211,11 +205,9 @@ class BackupTest(iotests.QMPTestCase):
                                       ('66', '1M', '1M')])
 
         # Let the job complete
-        res = self.vm.qmp('block-job-set-speed', device='drive0', speed=0)
-        self.assert_qmp(res, 'return', {})
+        self.vm.cmd('block-job-set-speed', device='drive0', speed=0)
         self.qmp_backup_wait('drive0')
-        res = self.vm.qmp('block-job-dismiss', id='drive0')
-        self.assert_qmp(res, 'return', {})
+        self.vm.cmd('block-job-dismiss', id='drive0')
 
         self.assertTrue(iotests.compare_images(self.ref_img, self.dest_img),
                         'target image does not match reference image')
@@ -237,8 +229,7 @@ class BackupTest(iotests.QMPTestCase):
                                  auto_dismiss=False)
         res = self.vm.qmp('query-block-jobs')
         self.assert_qmp(res, 'return[0]/status', 'concluded')
-        res = self.vm.qmp('block-job-dismiss', id='drive0')
-        self.assert_qmp(res, 'return', {})
+        self.vm.cmd('block-job-dismiss', id='drive0')
         res = self.vm.qmp('query-block-jobs')
         self.assert_qmp(res, 'return', [])
 
@@ -263,8 +254,7 @@ class BackupTest(iotests.QMPTestCase):
                                        auto_dismiss=False)
         self.assertEqual(res, False)
         # OK, dismiss the zombie.
-        res = self.vm.qmp('block-job-dismiss', id='drive0')
-        self.assert_qmp(res, 'return', {})
+        self.vm.cmd('block-job-dismiss', id='drive0')
         res = self.vm.qmp('query-block-jobs')
         self.assert_qmp(res, 'return', [])
         # Ensure it's really gone.
@@ -281,23 +271,22 @@ class BackupTest(iotests.QMPTestCase):
                            ('0x55', '8M', '352k'),
                            ('0x78', '15872k', '1M')))
         # Add destination node via blkdebug
-        res = self.vm.qmp('blockdev-add',
-                          node_name='target0',
-                          driver=iotests.imgfmt,
-                          file={
-                              'driver': 'blkdebug',
-                              'image': {
-                                  'driver': 'file',
-                                  'filename': self.dest_img
-                              },
-                              'inject-error': [{
-                                  'event': 'write_aio',
-                                  'errno': 5,
-                                  'immediately': False,
-                                  'once': True
-                              }],
-                          })
-        self.assert_qmp(res, 'return', {})
+        self.vm.cmd('blockdev-add',
+                    node_name='target0',
+                    driver=iotests.imgfmt,
+                    file={
+                        'driver': 'blkdebug',
+                        'image': {
+                            'driver': 'file',
+                            'filename': self.dest_img
+                        },
+                        'inject-error': [{
+                            'event': 'write_aio',
+                            'errno': 5,
+                            'immediately': False,
+                            'once': True
+                        }],
+                    })
 
         res = self.qmp_backup(cmd='blockdev-backup',
                               device='drive0', target='target0',
@@ -323,8 +312,7 @@ class BackupTest(iotests.QMPTestCase):
         res = self.vm.qmp('query-block-jobs')
         self.assert_qmp(res, 'return[0]/status', 'paused')
         # OK, unstick job and move forward.
-        res = self.vm.qmp('block-job-resume', device='drive0')
-        self.assert_qmp(res, 'return', {})
+        self.vm.cmd('block-job-resume', device='drive0')
         # And now we need to wait for it to conclude;
         res = self.qmp_backup_wait(device='drive0')
         self.assertTrue(res)
@@ -332,8 +320,7 @@ class BackupTest(iotests.QMPTestCase):
             # Job should now be languishing:
             res = self.vm.qmp('query-block-jobs')
             self.assert_qmp(res, 'return[0]/status', 'concluded')
-            res = self.vm.qmp('block-job-dismiss', id='drive0')
-            self.assert_qmp(res, 'return', {})
+            self.vm.cmd('block-job-dismiss', id='drive0')
             res = self.vm.qmp('query-block-jobs')
             self.assert_qmp(res, 'return', [])
 
diff --git a/tests/qemu-iotests/093 b/tests/qemu-iotests/093
index 93274dc8cb..4f9e224e8a 100755
--- a/tests/qemu-iotests/093
+++ b/tests/qemu-iotests/093
@@ -55,8 +55,7 @@ class ThrottleTestCase(iotests.QMPTestCase):
         # Set the I/O throttling parameters to all drives
         for i in range(0, ndrives):
             params['device'] = 'drive%d' % i
-            result = self.vm.qmp("block_set_io_throttle", conv_keys=False, **params)
-            self.assert_qmp(result, 'return', {})
+            self.vm.cmd("block_set_io_throttle", conv_keys=False, **params)
 
     def do_test_throttle(self, ndrives, seconds, params, first_drive = 0):
         def check_limit(limit, num):
@@ -253,8 +252,7 @@ class ThrottleTestCase(iotests.QMPTestCase):
         # drive1 remains in the group with a throttled request.
         params['bps_rd'] = 0
         params['device'] = 'drive0'
-        result = self.vm.qmp("block_set_io_throttle", conv_keys=False, **params)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd("block_set_io_throttle", conv_keys=False, **params)
 
         # Removing the I/O limits from drive0 drains its two pending requests.
         # The read request in drive1 is still throttled.
@@ -286,8 +284,7 @@ class ThrottleTestGroupNames(iotests.QMPTestCase):
 
     def set_io_throttle(self, device, params):
         params["device"] = device
-        result = self.vm.qmp("block_set_io_throttle", conv_keys=False, **params)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd("block_set_io_throttle", conv_keys=False, **params)
 
     def verify_name(self, device, name):
         result = self.vm.qmp("query-block")
@@ -379,23 +376,19 @@ class ThrottleTestRemovableMedia(iotests.QMPTestCase):
 
     def test_removable_media(self):
         # Add a couple of dummy nodes named cd0 and cd1
-        result = self.vm.qmp("blockdev-add", driver="null-co",
-                             read_zeroes=True, node_name="cd0")
-        self.assert_qmp(result, 'return', {})
-        result = self.vm.qmp("blockdev-add", driver="null-co",
-                             read_zeroes=True, node_name="cd1")
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd("blockdev-add", driver="null-co",
+                    read_zeroes=True, node_name="cd0")
+        self.vm.cmd("blockdev-add", driver="null-co",
+                    read_zeroes=True, node_name="cd1")
 
         # Attach a CD drive with cd0 inserted
-        result = self.vm.qmp("device_add", driver="scsi-cd",
-                             id="dev0", drive="cd0")
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd("device_add", driver="scsi-cd",
+                    id="dev0", drive="cd0")
 
         # Set I/O limits
         args = { "id": "dev0", "iops": 100, "iops_rd": 0, "iops_wr": 0,
                                 "bps":  50,  "bps_rd": 0,  "bps_wr": 0 }
-        result = self.vm.qmp("block_set_io_throttle", conv_keys=False, **args)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd("block_set_io_throttle", conv_keys=False, **args)
 
         # Check that the I/O limits have been set
         result = self.vm.qmp("query-block")
@@ -403,12 +396,9 @@ class ThrottleTestRemovableMedia(iotests.QMPTestCase):
         self.assert_qmp(result, 'return[0]/inserted/bps',   50)
 
         # Now eject cd0 and insert cd1
-        result = self.vm.qmp("blockdev-open-tray", id='dev0')
-        self.assert_qmp(result, 'return', {})
-        result = self.vm.qmp("blockdev-remove-medium", id='dev0')
-        self.assert_qmp(result, 'return', {})
-        result = self.vm.qmp("blockdev-insert-medium", id='dev0', node_name='cd1')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd("blockdev-open-tray", id='dev0')
+        self.vm.cmd("blockdev-remove-medium", id='dev0')
+        self.vm.cmd("blockdev-insert-medium", id='dev0', node_name='cd1')
 
         # Check that the I/O limits are still the same
         result = self.vm.qmp("query-block")
@@ -416,16 +406,14 @@ class ThrottleTestRemovableMedia(iotests.QMPTestCase):
         self.assert_qmp(result, 'return[0]/inserted/bps',   50)
 
         # Eject cd1
-        result = self.vm.qmp("blockdev-remove-medium", id='dev0')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd("blockdev-remove-medium", id='dev0')
 
         # Check that we can't set limits if the device has no medium
         result = self.vm.qmp("block_set_io_throttle", conv_keys=False, **args)
         self.assert_qmp(result, 'error/class', 'GenericError')
 
         # Remove the CD drive
-        result = self.vm.qmp("device_del", id='dev0')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd("device_del", id='dev0')
 
 
 if __name__ == '__main__':
diff --git a/tests/qemu-iotests/118 b/tests/qemu-iotests/118
index cae52ffa5e..10dc47459f 100755
--- a/tests/qemu-iotests/118
+++ b/tests/qemu-iotests/118
@@ -74,11 +74,9 @@ class ChangeBaseClass(iotests.QMPTestCase):
 class GeneralChangeTestsBaseClass(ChangeBaseClass):
 
     def test_blockdev_change_medium(self):
-        result = self.vm.qmp('blockdev-change-medium',
-                             id=self.device_name, filename=new_img,
-                             format=iotests.imgfmt)
-
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-change-medium',
+                    id=self.device_name, filename=new_img,
+                    format=iotests.imgfmt)
 
         self.wait_for_open()
         self.wait_for_close()
@@ -89,8 +87,7 @@ class GeneralChangeTestsBaseClass(ChangeBaseClass):
         self.assert_qmp(result, 'return[0]/inserted/image/filename', new_img)
 
     def test_eject(self):
-        result = self.vm.qmp('eject', id=self.device_name, force=True)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('eject', id=self.device_name, force=True)
 
         self.wait_for_open()
 
@@ -100,8 +97,7 @@ class GeneralChangeTestsBaseClass(ChangeBaseClass):
         self.assert_qmp_absent(result, 'return[0]/inserted')
 
     def test_tray_eject_change(self):
-        result = self.vm.qmp('eject', id=self.device_name, force=True)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('eject', id=self.device_name, force=True)
 
         self.wait_for_open()
 
@@ -110,9 +106,8 @@ class GeneralChangeTestsBaseClass(ChangeBaseClass):
             self.assert_qmp(result, 'return[0]/tray_open', True)
         self.assert_qmp_absent(result, 'return[0]/inserted')
 
-        result = self.vm.qmp('blockdev-change-medium', id=self.device_name,
-                             filename=new_img, format=iotests.imgfmt)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-change-medium', id=self.device_name,
+                    filename=new_img, format=iotests.imgfmt)
 
         self.wait_for_close()
 
@@ -122,9 +117,8 @@ class GeneralChangeTestsBaseClass(ChangeBaseClass):
         self.assert_qmp(result, 'return[0]/inserted/image/filename', new_img)
 
     def test_tray_open_close(self):
-        result = self.vm.qmp('blockdev-open-tray',
-                             id=self.device_name, force=True)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-open-tray',
+                    id=self.device_name, force=True)
 
         self.wait_for_open()
 
@@ -136,8 +130,7 @@ class GeneralChangeTestsBaseClass(ChangeBaseClass):
         else:
             self.assert_qmp(result, 'return[0]/inserted/image/filename', old_img)
 
-        result = self.vm.qmp('blockdev-close-tray', id=self.device_name)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-close-tray', id=self.device_name)
 
         if self.has_real_tray or not self.was_empty:
             self.wait_for_close()
@@ -151,8 +144,7 @@ class GeneralChangeTestsBaseClass(ChangeBaseClass):
             self.assert_qmp(result, 'return[0]/inserted/image/filename', old_img)
 
     def test_tray_eject_close(self):
-        result = self.vm.qmp('eject', id=self.device_name, force=True)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('eject', id=self.device_name, force=True)
 
         self.wait_for_open()
 
@@ -161,8 +153,7 @@ class GeneralChangeTestsBaseClass(ChangeBaseClass):
             self.assert_qmp(result, 'return[0]/tray_open', True)
         self.assert_qmp_absent(result, 'return[0]/inserted')
 
-        result = self.vm.qmp('blockdev-close-tray', id=self.device_name)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-close-tray', id=self.device_name)
 
         self.wait_for_close()
 
@@ -172,9 +163,8 @@ class GeneralChangeTestsBaseClass(ChangeBaseClass):
         self.assert_qmp_absent(result, 'return[0]/inserted')
 
     def test_tray_open_change(self):
-        result = self.vm.qmp('blockdev-open-tray', id=self.device_name,
-                                                   force=True)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-open-tray', id=self.device_name,
+                                          force=True)
 
         self.wait_for_open()
 
@@ -186,10 +176,9 @@ class GeneralChangeTestsBaseClass(ChangeBaseClass):
         else:
             self.assert_qmp(result, 'return[0]/inserted/image/filename', old_img)
 
-        result = self.vm.qmp('blockdev-change-medium', id=self.device_name,
-                                                       filename=new_img,
-                                                       format=iotests.imgfmt)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-change-medium', id=self.device_name,
+                                              filename=new_img,
+                                              format=iotests.imgfmt)
 
         self.wait_for_close()
 
@@ -199,17 +188,15 @@ class GeneralChangeTestsBaseClass(ChangeBaseClass):
         self.assert_qmp(result, 'return[0]/inserted/image/filename', new_img)
 
     def test_cycle(self, read_only_node=False):
-        result = self.vm.qmp('blockdev-add',
-                             node_name='new',
-                             driver=iotests.imgfmt,
-                             read_only=read_only_node,
-                             file={'filename': new_img,
-                                    'driver': 'file'})
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-add',
+                    node_name='new',
+                    driver=iotests.imgfmt,
+                    read_only=read_only_node,
+                    file={'filename': new_img,
+                           'driver': 'file'})
 
-        result = self.vm.qmp('blockdev-open-tray',
-                             id=self.device_name, force=True)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-open-tray',
+                    id=self.device_name, force=True)
 
         self.wait_for_open()
 
@@ -221,26 +208,23 @@ class GeneralChangeTestsBaseClass(ChangeBaseClass):
         else:
             self.assert_qmp(result, 'return[0]/inserted/image/filename', old_img)
 
-        result = self.vm.qmp('blockdev-remove-medium',
-                             id=self.device_name)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-remove-medium',
+                    id=self.device_name)
 
         result = self.vm.qmp('query-block')
         if self.has_real_tray:
             self.assert_qmp(result, 'return[0]/tray_open', True)
         self.assert_qmp_absent(result, 'return[0]/inserted')
 
-        result = self.vm.qmp('blockdev-insert-medium',
-                             id=self.device_name, node_name='new')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-insert-medium',
+                    id=self.device_name, node_name='new')
 
         result = self.vm.qmp('query-block')
         if self.has_real_tray:
             self.assert_qmp(result, 'return[0]/tray_open', True)
         self.assert_qmp(result, 'return[0]/inserted/image/filename', new_img)
 
-        result = self.vm.qmp('blockdev-close-tray', id=self.device_name)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-close-tray', id=self.device_name)
 
         self.wait_for_close()
 
@@ -253,9 +237,8 @@ class GeneralChangeTestsBaseClass(ChangeBaseClass):
         self.test_cycle(True)
 
     def test_close_on_closed(self):
-        result = self.vm.qmp('blockdev-close-tray', id=self.device_name)
         # Should be a no-op
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-close-tray', id=self.device_name)
         self.assertEqual(self.vm.get_qmp_events(wait=False), [])
 
     def test_remove_on_closed(self):
@@ -269,12 +252,11 @@ class GeneralChangeTestsBaseClass(ChangeBaseClass):
         if not self.has_real_tray:
             return
 
-        result = self.vm.qmp('blockdev-add',
-                             node_name='new',
-                             driver=iotests.imgfmt,
-                             file={'filename': new_img,
-                                   'driver': 'file'})
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-add',
+                    node_name='new',
+                    driver=iotests.imgfmt,
+                    file={'filename': new_img,
+                          'driver': 'file'})
 
         result = self.vm.qmp('blockdev-insert-medium', id=self.device_name,
                                                        node_name='new')
@@ -307,15 +289,13 @@ class TestInitiallyFilled(GeneralChangeTestsBaseClass):
         os.remove(new_img)
 
     def test_insert_on_filled(self):
-        result = self.vm.qmp('blockdev-add',
-                             node_name='new',
-                             driver=iotests.imgfmt,
-                             file={'filename': new_img,
-                                   'driver': 'file'})
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-add',
+                    node_name='new',
+                    driver=iotests.imgfmt,
+                    file={'filename': new_img,
+                          'driver': 'file'})
 
-        result = self.vm.qmp('blockdev-open-tray', id=self.device_name)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-open-tray', id=self.device_name)
 
         self.wait_for_open()
 
@@ -344,14 +324,12 @@ class TestInitiallyEmpty(GeneralChangeTestsBaseClass):
         os.remove(new_img)
 
     def test_remove_on_empty(self):
-        result = self.vm.qmp('blockdev-open-tray', id=self.device_name)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-open-tray', id=self.device_name)
 
         self.wait_for_open()
 
-        result = self.vm.qmp('blockdev-remove-medium', id=self.device_name)
         # Should be a no-op
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-remove-medium', id=self.device_name)
 
 # Do this in a function to avoid leaking variables like case into the global
 # name space (otherwise tests would be run for the abstract base classes)
@@ -399,11 +377,10 @@ class TestChangeReadOnly(ChangeBaseClass):
         self.assert_qmp(result, 'return[0]/inserted/ro', True)
         self.assert_qmp(result, 'return[0]/inserted/image/filename', old_img)
 
-        result = self.vm.qmp('blockdev-change-medium', id=self.device_name,
-                                                       filename=new_img,
-                                                       format=iotests.imgfmt,
-                                                       read_only_mode='retain')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-change-medium', id=self.device_name,
+                                              filename=new_img,
+                                              format=iotests.imgfmt,
+                                              read_only_mode='retain')
 
         result = self.vm.qmp('query-block')
         self.assert_qmp(result, 'return[0]/inserted/ro', True)
@@ -419,11 +396,10 @@ class TestChangeReadOnly(ChangeBaseClass):
         self.assert_qmp(result, 'return[0]/inserted/ro', True)
         self.assert_qmp(result, 'return[0]/inserted/image/filename', old_img)
 
-        result = self.vm.qmp('blockdev-change-medium', id=self.device_name,
-                                                       filename=new_img,
-                                                       format=iotests.imgfmt,
-                                                       read_only_mode='retain')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-change-medium', id=self.device_name,
+                                              filename=new_img,
+                                              format=iotests.imgfmt,
+                                              read_only_mode='retain')
 
         result = self.vm.qmp('query-block')
         self.assert_qmp(result, 'return[0]/inserted/ro', True)
@@ -462,12 +438,11 @@ class TestChangeReadOnly(ChangeBaseClass):
         self.assert_qmp(result, 'return[0]/inserted/ro', True)
         self.assert_qmp(result, 'return[0]/inserted/image/filename', old_img)
 
-        result = self.vm.qmp('blockdev-change-medium',
-                             id=self.device_name,
-                             filename=new_img,
-                             format=iotests.imgfmt,
-                             read_only_mode='read-write')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-change-medium',
+                    id=self.device_name,
+                    filename=new_img,
+                    format=iotests.imgfmt,
+                    read_only_mode='read-write')
 
         result = self.vm.qmp('query-block')
         self.assert_qmp(result, 'return[0]/inserted/ro', False)
@@ -483,12 +458,11 @@ class TestChangeReadOnly(ChangeBaseClass):
         self.assert_qmp(result, 'return[0]/inserted/ro', False)
         self.assert_qmp(result, 'return[0]/inserted/image/filename', old_img)
 
-        result = self.vm.qmp('blockdev-change-medium',
-                             id=self.device_name,
-                             filename=new_img,
-                             format=iotests.imgfmt,
-                             read_only_mode='read-only')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-change-medium',
+                    id=self.device_name,
+                    filename=new_img,
+                    format=iotests.imgfmt,
+                    read_only_mode='read-only')
 
         result = self.vm.qmp('query-block')
         self.assert_qmp(result, 'return[0]/inserted/ro', True)
@@ -503,12 +477,11 @@ class TestChangeReadOnly(ChangeBaseClass):
         self.assert_qmp(result, 'return[0]/inserted/ro', False)
         self.assert_qmp(result, 'return[0]/inserted/image/filename', old_img)
 
-        result = self.vm.qmp('blockdev-change-medium',
-                             id=self.device_name,
-                             filename=new_img,
-                             format=iotests.imgfmt,
-                             read_only_mode='read-only')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-change-medium',
+                    id=self.device_name,
+                    filename=new_img,
+                    format=iotests.imgfmt,
+                    read_only_mode='read-only')
 
         result = self.vm.qmp('query-block')
         self.assert_qmp(result, 'return[0]/inserted/ro', True)
@@ -546,11 +519,10 @@ class TestChangeReadOnly(ChangeBaseClass):
         self.assert_qmp(result, 'return[0]/inserted/ro', True)
         self.assert_qmp(result, 'return[0]/inserted/image/filename', old_img)
 
-        result = self.vm.qmp('blockdev-change-medium', id=self.device_name,
-                                                       filename=new_img,
-                                                       format=iotests.imgfmt,
-                                                       read_only_mode='retain')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-change-medium', id=self.device_name,
+                                              filename=new_img,
+                                              format=iotests.imgfmt,
+                                              read_only_mode='retain')
 
         result = self.vm.qmp('query-block')
         self.assert_qmp(result, 'return[0]/inserted/ro', True)
@@ -587,27 +559,24 @@ class TestChangeReadOnly(ChangeBaseClass):
         self.assert_qmp(result, 'return[0]/inserted/ro', False)
         self.assert_qmp(result, 'return[0]/inserted/image/filename', old_img)
 
-        result = self.vm.qmp('blockdev-add',
-                             node_name='new',
-                             driver=iotests.imgfmt,
-                             read_only=True,
-                             file={'filename': new_img,
-                                    'driver': 'file'})
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-add',
+                    node_name='new',
+                    driver=iotests.imgfmt,
+                    read_only=True,
+                    file={'filename': new_img,
+                           'driver': 'file'})
 
         result = self.vm.qmp('query-block')
         self.assert_qmp(result, 'return[0]/inserted/ro', False)
         self.assert_qmp(result, 'return[0]/inserted/image/filename', old_img)
 
-        result = self.vm.qmp('blockdev-remove-medium', id=self.device_name)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-remove-medium', id=self.device_name)
 
         result = self.vm.qmp('query-block')
         self.assert_qmp_absent(result, 'return[0]/inserted')
 
-        result = self.vm.qmp('blockdev-insert-medium', id=self.device_name,
-                                                       node_name='new')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-insert-medium', id=self.device_name,
+                                              node_name='new')
 
         result = self.vm.qmp('query-block')
         self.assert_qmp(result, 'return[0]/inserted/ro', True)
@@ -638,22 +607,19 @@ class TestBlockJobsAfterCycle(ChangeBaseClass):
 
         # For device-less BBs, calling blockdev-open-tray or blockdev-close-tray
         # is not necessary
-        result = self.vm.qmp('blockdev-remove-medium', id=self.device_name)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-remove-medium', id=self.device_name)
 
         result = self.vm.qmp('query-block')
         self.assert_qmp_absent(result, 'return[0]/inserted')
 
-        result = self.vm.qmp('blockdev-add',
-                             node_name='node0',
-                             driver=iotests.imgfmt,
-                             file={'filename': old_img,
-                                   'driver': 'file'})
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-add',
+                    node_name='node0',
+                    driver=iotests.imgfmt,
+                    file={'filename': old_img,
+                          'driver': 'file'})
 
-        result = self.vm.qmp('blockdev-insert-medium', id=self.device_name,
-                                                       node_name='node0')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-insert-medium', id=self.device_name,
+                                              node_name='node0')
 
         result = self.vm.qmp('query-block')
         self.assert_qmp(result, 'return[0]/inserted/image/filename', old_img)
@@ -670,10 +636,9 @@ class TestBlockJobsAfterCycle(ChangeBaseClass):
     @iotests.skip_for_formats(('vpc', 'parallels', 'qcow', 'vdi', 'vmdk', 'raw',
                                'vhdx'))
     def test_snapshot_and_commit(self):
-        result = self.vm.qmp('blockdev-snapshot-sync', device='drive0',
-                                                       snapshot_file=new_img,
-                                                       format=iotests.imgfmt)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-snapshot-sync', device='drive0',
+                                              snapshot_file=new_img,
+                                              format=iotests.imgfmt)
 
         result = self.vm.qmp('query-block')
         self.assert_qmp(result, 'return[0]/inserted/image/filename', new_img)
@@ -681,16 +646,14 @@ class TestBlockJobsAfterCycle(ChangeBaseClass):
                         'return[0]/inserted/image/backing-image/filename',
                         old_img)
 
-        result = self.vm.qmp('block-commit', device='drive0')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('block-commit', device='drive0')
 
         self.vm.event_wait(name='BLOCK_JOB_READY')
 
         result = self.vm.qmp('query-block-jobs')
         self.assert_qmp(result, 'return[0]/device', 'drive0')
 
-        result = self.vm.qmp('block-job-complete', device='drive0')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('block-job-complete', device='drive0')
 
         self.vm.event_wait(name='BLOCK_JOB_COMPLETED')
 
diff --git a/tests/qemu-iotests/124 b/tests/qemu-iotests/124
index 845ab5303c..b2f4328e34 100755
--- a/tests/qemu-iotests/124
+++ b/tests/qemu-iotests/124
@@ -24,6 +24,7 @@
 import os
 import iotests
 from iotests import try_remove
+from qemu.qmp.qmp_client import ExecuteError
 
 
 def io_write_patterns(img, patterns):
@@ -141,8 +142,7 @@ class TestIncrementalBackupBase(iotests.QMPTestCase):
 
 
     def do_qmp_backup(self, error='Input/output error', **kwargs):
-        res = self.vm.qmp('drive-backup', **kwargs)
-        self.assert_qmp(res, 'return', {})
+        self.vm.cmd('drive-backup', **kwargs)
         return self.wait_qmp_backup(kwargs['device'], error)
 
 
@@ -201,9 +201,8 @@ class TestIncrementalBackupBase(iotests.QMPTestCase):
     def add_bitmap(self, name, drive, **kwargs):
         bitmap = Bitmap(name, drive)
         self.bitmaps.append(bitmap)
-        result = self.vm.qmp('block-dirty-bitmap-add', node=drive['id'],
-                             name=bitmap.name, **kwargs)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('block-dirty-bitmap-add', node=drive['id'],
+                    name=bitmap.name, **kwargs)
         return bitmap
 
 
@@ -388,13 +387,12 @@ class TestIncrementalBackup(TestIncrementalBackupBase):
                                           ('0x64', '32736k', '64k')))
         bitmap1 = self.add_bitmap('bitmap1', drive0)
 
-        result = self.vm.qmp('transaction', actions=[
+        self.vm.cmd('transaction', actions=[
             transaction_bitmap_clear(bitmap0.drive['id'], bitmap0.name),
             transaction_bitmap_clear(bitmap1.drive['id'], bitmap1.name),
             transaction_drive_backup(drive0['id'], drive0['backup'],
                                      sync='full', format=drive0['fmt'])
         ])
-        self.assert_qmp(result, 'return', {})
         self.wait_until_completed(drive0['id'])
         self.files.append(drive0['backup'])
 
@@ -417,7 +415,7 @@ class TestIncrementalBackup(TestIncrementalBackupBase):
                                            ('0xcd', '32M', '124k')))
 
         # Create a blkdebug interface to this img as 'drive1'
-        result = self.vm.qmp('blockdev-add',
+        self.vm.cmd('blockdev-add',
             node_name=drive1['id'],
             driver=drive1['fmt'],
             file={
@@ -440,7 +438,6 @@ class TestIncrementalBackup(TestIncrementalBackupBase):
                 }],
             }
         )
-        self.assert_qmp(result, 'return', {})
 
         # Create bitmaps and full backups for both drives
         drive0 = self.drives[0]
@@ -475,9 +472,8 @@ class TestIncrementalBackup(TestIncrementalBackupBase):
                                      format=drive1['fmt'], mode='existing',
                                      bitmap=dr1bm0.name)
         ]
-        result = self.vm.qmp('transaction', actions=transaction,
-                             properties={'completion-mode': 'grouped'} )
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('transaction', actions=transaction,
+                    properties={'completion-mode': 'grouped'} )
 
         # Observe that drive0's backup is cancelled and drive1 completes with
         # an error.
@@ -504,9 +500,8 @@ class TestIncrementalBackup(TestIncrementalBackupBase):
         target1 = self.prepare_backup(dr1bm0)
 
         # Re-run the exact same transaction.
-        result = self.vm.qmp('transaction', actions=transaction,
-                             properties={'completion-mode':'grouped'})
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('transaction', actions=transaction,
+                    properties={'completion-mode':'grouped'})
 
         # Both should complete successfully this time.
         self.assertTrue(self.wait_qmp_backup(drive0['id']))
@@ -567,7 +562,7 @@ class TestIncrementalBackup(TestIncrementalBackupBase):
         The granularity must always be a power of 2.
         '''
         self.assert_no_active_block_jobs()
-        self.assertRaises(AssertionError, self.add_bitmap,
+        self.assertRaises(ExecuteError, self.add_bitmap,
                           'bitmap0', self.drives[0],
                           granularity=64000)
 
@@ -585,9 +580,8 @@ class TestIncrementalBackup(TestIncrementalBackupBase):
 
         self.add_bitmap('bitmap0', self.drives[0])
 
-        res = self.vm.qmp('block_resize', device=self.drives[0]['id'],
-                          size=(65 * 1048576))
-        self.assert_qmp(res, 'return', {})
+        self.vm.cmd('block_resize', device=self.drives[0]['id'],
+                    size=(65 * 1048576))
 
         # Dirty the image past the old end
         self.vm.hmp_qemu_io(self.drives[0]['id'], 'write 64M 64k')
@@ -617,7 +611,7 @@ class TestIncrementalBackupBlkdebug(TestIncrementalBackupBase):
         '''
 
         drive0 = self.drives[0]
-        result = self.vm.qmp('blockdev-add',
+        self.vm.cmd('blockdev-add',
             node_name=drive0['id'],
             driver=drive0['fmt'],
             file={
@@ -640,7 +634,6 @@ class TestIncrementalBackupBlkdebug(TestIncrementalBackupBase):
                 }],
             }
         )
-        self.assert_qmp(result, 'return', {})
 
         self.create_anchor_backup(drive0)
         self.add_bitmap('bitmap0', drive0)
@@ -668,29 +661,28 @@ class TestIncrementalBackupBlkdebug(TestIncrementalBackupBase):
         drive0 = self.drives[0]
         # NB: The blkdebug script here looks for a "flush, read" pattern.
         # The flush occurs in hmp_io_writes, and the read during the block job.
-        result = self.vm.qmp('blockdev-add',
-                             node_name=drive0['id'],
-                             driver=drive0['fmt'],
-                             file={
-                                 'driver': 'blkdebug',
-                                 'image': {
-                                     'driver': 'file',
-                                     'filename': drive0['file']
-                                 },
-                                 'set-state': [{
-                                     'event': 'flush_to_disk',
-                                     'state': 1,
-                                     'new_state': 2
-                                 }],
-                                 'inject-error': [{
-                                     'event': 'read_aio',
-                                     'errno': 5,
-                                     'state': 2,
-                                     'immediately': False,
-                                     'once': True
-                                 }],
-                             })
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-add',
+                    node_name=drive0['id'],
+                    driver=drive0['fmt'],
+                    file={
+                        'driver': 'blkdebug',
+                        'image': {
+                            'driver': 'file',
+                            'filename': drive0['file']
+                        },
+                        'set-state': [{
+                            'event': 'flush_to_disk',
+                            'state': 1,
+                            'new_state': 2
+                        }],
+                        'inject-error': [{
+                            'event': 'read_aio',
+                            'errno': 5,
+                            'state': 2,
+                            'immediately': False,
+                            'once': True
+                        }],
+                    })
         self.create_anchor_backup(drive0)
         bitmap = self.add_bitmap('bitmap0', drive0)
 
@@ -711,16 +703,15 @@ class TestIncrementalBackupBlkdebug(TestIncrementalBackupBase):
         # Start backup
         parent, _ = bitmap.last_target()
         target = self.prepare_backup(bitmap, parent)
-        res = self.vm.qmp('drive-backup',
-                          job_id=bitmap.drive['id'],
-                          device=bitmap.drive['id'],
-                          sync='incremental',
-                          bitmap=bitmap.name,
-                          format=bitmap.drive['fmt'],
-                          target=target,
-                          mode='existing',
-                          on_source_error='stop')
-        self.assert_qmp(res, 'return', {})
+        self.vm.cmd('drive-backup',
+                    job_id=bitmap.drive['id'],
+                    device=bitmap.drive['id'],
+                    sync='incremental',
+                    bitmap=bitmap.name,
+                    format=bitmap.drive['fmt'],
+                    target=target,
+                    mode='existing',
+                    on_source_error='stop')
 
         # Wait for the error
         event = self.vm.event_wait(name="BLOCK_JOB_ERROR",
@@ -739,8 +730,7 @@ class TestIncrementalBackupBlkdebug(TestIncrementalBackupBase):
             }))
 
         # Resume and check incremental backup for consistency
-        res = self.vm.qmp('block-job-resume', device=bitmap.drive['id'])
-        self.assert_qmp(res, 'return', {})
+        self.vm.cmd('block-job-resume', device=bitmap.drive['id'])
         self.wait_qmp_backup(bitmap.drive['id'])
 
         # Bitmap Status Check
diff --git a/tests/qemu-iotests/129 b/tests/qemu-iotests/129
index e1536ee3c3..97773cd96d 100755
--- a/tests/qemu-iotests/129
+++ b/tests/qemu-iotests/129
@@ -55,11 +55,9 @@ class TestStopWithBlockJob(iotests.QMPTestCase):
     def do_test_stop(self, cmd, **args):
         """Test 'stop' while block job is running on a throttled drive.
         The 'stop' command shouldn't drain the job"""
-        result = self.vm.qmp(cmd, **args)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd(cmd, **args)
 
-        result = self.vm.qmp("stop")
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd("stop")
         result = self.vm.qmp("query-block-jobs")
 
         self.assert_qmp(result, 'return[0]/status', 'running')
@@ -87,7 +85,7 @@ class TestStopWithBlockJob(iotests.QMPTestCase):
         iotests.qemu_img('create', '-f', iotests.imgfmt, self.overlay_img,
                          '1G')
 
-        result = self.vm.qmp('blockdev-add', {
+        self.vm.cmd('blockdev-add', {
             'node-name': 'overlay',
             'driver': iotests.imgfmt,
             'file': {
@@ -95,11 +93,9 @@ class TestStopWithBlockJob(iotests.QMPTestCase):
                 'filename': self.overlay_img
             }
         })
-        self.assert_qmp(result, 'return', {})
 
-        result = self.vm.qmp('blockdev-snapshot',
-                             node='source', overlay='overlay')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-snapshot',
+                    node='source', overlay='overlay')
 
         self.do_test_stop('block-commit', device='drive0', top_node='source')
 
diff --git a/tests/qemu-iotests/132 b/tests/qemu-iotests/132
index 367ea08036..12a64b3d95 100755
--- a/tests/qemu-iotests/132
+++ b/tests/qemu-iotests/132
@@ -47,9 +47,8 @@ class TestSingleDrive(iotests.QMPTestCase):
             pass
 
     def test_mirror_discard(self):
-        result = self.vm.qmp('drive-mirror', device='drive0', sync='full',
-                             target=target_img)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('drive-mirror', device='drive0', sync='full',
+                    target=target_img)
         self.vm.hmp_qemu_io('drive0', 'discard 0 64k')
         self.complete_and_wait('drive0')
         self.vm.shutdown()
diff --git a/tests/qemu-iotests/139 b/tests/qemu-iotests/139
index 178b1ee230..ebb4cd62b6 100755
--- a/tests/qemu-iotests/139
+++ b/tests/qemu-iotests/139
@@ -58,8 +58,7 @@ class TestBlockdevDel(iotests.QMPTestCase):
                 'file': {'driver': 'file',
                          'node-name': file_node,
                          'filename': base_img}}
-        result = self.vm.qmp('blockdev-add', conv_keys = False, **opts)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-add', conv_keys = False, **opts)
         self.checkBlockDriverState(node)
         self.checkBlockDriverState(file_node)
 
@@ -73,8 +72,7 @@ class TestBlockdevDel(iotests.QMPTestCase):
                 'backing': None,
                 'file': {'driver': 'file',
                          'filename': new_img}}
-        result = self.vm.qmp('blockdev-add', conv_keys = False, **opts)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-add', conv_keys = False, **opts)
         self.checkBlockDriverState(node)
 
     # Delete a BlockDriverState
@@ -89,17 +87,14 @@ class TestBlockdevDel(iotests.QMPTestCase):
 
     # Add a device model
     def addDeviceModel(self, device, backend, driver = 'virtio-blk'):
-        result = self.vm.qmp('device_add', id = device,
-                             driver = driver, drive = backend)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('device_add', id = device,
+                    driver = driver, drive = backend)
 
     # Delete a device model
     def delDeviceModel(self, device, is_virtio_blk = True):
-        result = self.vm.qmp('device_del', id = device)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('device_del', id = device)
 
-        result = self.vm.qmp('system_reset')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('system_reset')
 
         if is_virtio_blk:
             device_path = '/machine/peripheral/%s/virtio-backend' % device
@@ -126,9 +121,8 @@ class TestBlockdevDel(iotests.QMPTestCase):
     # Insert a BlockDriverState
     def insertDrive(self, device, node):
         self.checkBlockDriverState(node)
-        result = self.vm.qmp('blockdev-insert-medium',
-                             id = device, node_name = node)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-insert-medium',
+                    id = device, node_name = node)
         self.checkBlockDriverState(node)
 
     # Create a snapshot using 'blockdev-snapshot-sync'
@@ -139,8 +133,7 @@ class TestBlockdevDel(iotests.QMPTestCase):
                 'snapshot-file': new_img,
                 'snapshot-node-name': overlay,
                 'format': iotests.imgfmt}
-        result = self.vm.qmp('blockdev-snapshot-sync', conv_keys=False, **opts)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-snapshot-sync', conv_keys=False, **opts)
         self.checkBlockDriverState(node)
         self.checkBlockDriverState(overlay)
 
@@ -148,9 +141,8 @@ class TestBlockdevDel(iotests.QMPTestCase):
     def createSnapshot(self, node, overlay):
         self.checkBlockDriverState(node)
         self.checkBlockDriverState(overlay)
-        result = self.vm.qmp('blockdev-snapshot',
-                             node = node, overlay = overlay)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-snapshot',
+                    node = node, overlay = overlay)
         self.checkBlockDriverState(node)
         self.checkBlockDriverState(overlay)
 
@@ -163,14 +155,12 @@ class TestBlockdevDel(iotests.QMPTestCase):
                 'node-name': new_node,
                 'sync': 'top',
                 'format': iotests.imgfmt}
-        result = self.vm.qmp('drive-mirror', conv_keys=False, **opts)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('drive-mirror', conv_keys=False, **opts)
         self.checkBlockDriverState(new_node)
 
     # Complete an existing block job
     def completeBlockJob(self, id, node_before, node_after):
-        result = self.vm.qmp('block-job-complete', device=id)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('block-job-complete', device=id)
         self.wait_until_completed(id)
 
     # Add a BlkDebug node
@@ -186,8 +176,7 @@ class TestBlockdevDel(iotests.QMPTestCase):
         opts = {'driver': 'blkdebug',
                 'node-name': debug,
                 'image': image}
-        result = self.vm.qmp('blockdev-add', conv_keys = False, **opts)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-add', conv_keys = False, **opts)
         self.checkBlockDriverState(node)
         self.checkBlockDriverState(debug)
 
@@ -211,8 +200,7 @@ class TestBlockdevDel(iotests.QMPTestCase):
                 'node-name': blkverify,
                 'test': node_0,
                 'raw': node_1}
-        result = self.vm.qmp('blockdev-add', conv_keys = False, **opts)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-add', conv_keys = False, **opts)
         self.checkBlockDriverState(test)
         self.checkBlockDriverState(raw)
         self.checkBlockDriverState(blkverify)
@@ -235,8 +223,7 @@ class TestBlockdevDel(iotests.QMPTestCase):
                 'node-name': quorum,
                 'vote-threshold': 1,
                 'children': [ child_0, child_1 ]}
-        result = self.vm.qmp('blockdev-add', conv_keys = False, **opts)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-add', conv_keys = False, **opts)
         self.checkBlockDriverState(child0)
         self.checkBlockDriverState(child1)
         self.checkBlockDriverState(quorum)
diff --git a/tests/qemu-iotests/147 b/tests/qemu-iotests/147
index 08111c5108..6d6f077a14 100755
--- a/tests/qemu-iotests/147
+++ b/tests/qemu-iotests/147
@@ -58,8 +58,7 @@ class NBDBlockdevAddBase(iotests.QMPTestCase):
     def client_test(self, filename, address, export=None,
                     node_name='nbd-blockdev', delete=True):
         bao = self.blockdev_add_options(address, export, node_name)
-        result = self.vm.qmp('blockdev-add', bao)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-add', bao)
 
         found = False
         result = self.vm.qmp('query-named-block-nodes')
@@ -75,8 +74,7 @@ class NBDBlockdevAddBase(iotests.QMPTestCase):
         self.assertTrue(found)
 
         if delete:
-            result = self.vm.qmp('blockdev-del', node_name=node_name)
-            self.assert_qmp(result, 'return', {})
+            self.vm.cmd('blockdev-del', node_name=node_name)
 
 
 class QemuNBD(NBDBlockdevAddBase):
@@ -158,17 +156,14 @@ class BuiltinNBD(NBDBlockdevAddBase):
         self.assert_qmp(result, 'return', {})
 
         if export_name is None:
-            result = self.server.qmp('nbd-server-add', device='nbd-export')
-            self.assert_qmp(result, 'return', {})
+            self.server.cmd('nbd-server-add', device='nbd-export')
         else:
-            result = self.server.qmp('nbd-server-add', device='nbd-export',
-                                     name=export_name)
-            self.assert_qmp(result, 'return', {})
+            self.server.cmd('nbd-server-add', device='nbd-export',
+                            name=export_name)
 
         if export_name2 is not None:
-            result = self.server.qmp('nbd-server-add', device='nbd-export',
-                                     name=export_name2)
-            self.assert_qmp(result, 'return', {})
+            self.server.cmd('nbd-server-add', device='nbd-export',
+                            name=export_name2)
 
         return True
 
@@ -176,8 +171,7 @@ class BuiltinNBD(NBDBlockdevAddBase):
         self.assertTrue(self._try_server_up(address, export_name, export_name2))
 
     def _server_down(self):
-        result = self.server.qmp('nbd-server-stop')
-        self.assert_qmp(result, 'return', {})
+        self.server.cmd('nbd-server-stop')
 
     def do_test_inet(self, export_name=None):
         while True:
@@ -219,10 +213,8 @@ class BuiltinNBD(NBDBlockdevAddBase):
                          flatten_sock_addr(address), 'exp1', 'node1', False)
         self.client_test('nbd://localhost:%i/%s' % (nbd_port, 'exp2'),
                          flatten_sock_addr(address), 'exp2', 'node2', False)
-        result = self.vm.qmp('blockdev-del', node_name='node1')
-        self.assert_qmp(result, 'return', {})
-        result = self.vm.qmp('blockdev-del', node_name='node2')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-del', node_name='node1')
+        self.vm.cmd('blockdev-del', node_name='node2')
         self._server_down()
 
     def test_inet6(self):
@@ -273,8 +265,7 @@ class BuiltinNBD(NBDBlockdevAddBase):
         result = self.vm.send_fd_scm(fd=sockfd.fileno())
         self.assertEqual(result, 0, 'Failed to send socket FD')
 
-        result = self.vm.qmp('getfd', fdname='nbd-fifo')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('getfd', fdname='nbd-fifo')
 
         address = { 'type': 'fd',
                     'data': { 'str': 'nbd-fifo' } }
diff --git a/tests/qemu-iotests/151 b/tests/qemu-iotests/151
index 668d0c1e9c..f2ff9c5dac 100755
--- a/tests/qemu-iotests/151
+++ b/tests/qemu-iotests/151
@@ -79,14 +79,13 @@ class TestActiveMirror(iotests.QMPTestCase):
             self.vm.hmp_qemu_io('source', 'aio_write -z %i 1M' % offset)
 
         # Start the block job
-        result = self.vm.qmp('blockdev-mirror',
-                             job_id='mirror',
-                             filter_node_name='mirror-node',
-                             device='source-node',
-                             target='target-node',
-                             sync='full',
-                             copy_mode='write-blocking')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-mirror',
+                    job_id='mirror',
+                    filter_node_name='mirror-node',
+                    device='source-node',
+                    target='target-node',
+                    sync='full',
+                    copy_mode='write-blocking')
 
         # Start some more requests
         for offset in range(3 * self.image_len // 8, 5 * self.image_len // 8, 1024 * 1024):
@@ -125,23 +124,21 @@ class TestActiveMirror(iotests.QMPTestCase):
         result = self.vm.hmp_qemu_io('source', 'write -P 1 0 2M')
 
         # Start the block job (very slowly)
-        result = self.vm.qmp('blockdev-mirror',
-                             job_id='mirror',
-                             filter_node_name='mirror-node',
-                             device='source-node',
-                             target='target-node',
-                             sync='full',
-                             copy_mode='write-blocking',
-                             buf_size=(1048576 // 4),
-                             speed=1)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-mirror',
+                    job_id='mirror',
+                    filter_node_name='mirror-node',
+                    device='source-node',
+                    target='target-node',
+                    sync='full',
+                    copy_mode='write-blocking',
+                    buf_size=(1048576 // 4),
+                    speed=1)
 
         # Start an unaligned request to a dirty area
         result = self.vm.hmp_qemu_io('source', 'write -P 2 %i 1' % (1048576 + 42))
 
         # Let the job finish
-        result = self.vm.qmp('block-job-set-speed', device='mirror', speed=0)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('block-job-set-speed', device='mirror', speed=0)
         self.complete_and_wait(drive='mirror')
 
         self.potential_writes_in_flight = False
@@ -151,15 +148,14 @@ class TestActiveMirror(iotests.QMPTestCase):
         result = self.vm.hmp_qemu_io('source', 'write -P 1 0 2M')
 
         # Start the block job (very slowly)
-        result = self.vm.qmp('blockdev-mirror',
-                             job_id='mirror',
-                             filter_node_name='mirror-node',
-                             device='source-node',
-                             target='target-node',
-                             sync='full',
-                             copy_mode='write-blocking',
-                             speed=1)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-mirror',
+                    job_id='mirror',
+                    filter_node_name='mirror-node',
+                    device='source-node',
+                    target='target-node',
+                    sync='full',
+                    copy_mode='write-blocking',
+                    speed=1)
 
         self.vm.hmp_qemu_io('source', 'break write_aio A')
         self.vm.hmp_qemu_io('source', 'aio_write 0 1M')  # 1
@@ -190,8 +186,7 @@ class TestActiveMirror(iotests.QMPTestCase):
         # After resuming 4, one of 2 and 3 goes first and set in_flight_bitmap,
         # so the other will wait for it.
 
-        result = self.vm.qmp('block-job-set-speed', device='mirror', speed=0)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('block-job-set-speed', device='mirror', speed=0)
         self.complete_and_wait(drive='mirror')
 
         self.potential_writes_in_flight = False
@@ -212,7 +207,7 @@ class TestThrottledWithNbdExportBase(iotests.QMPTestCase):
         self.vm = iotests.VM()
         self.vm.launch()
 
-        result = self.vm.qmp('object-add', **{
+        self.vm.cmd('object-add', **{
             'qom-type': 'throttle-group',
             'id': 'thrgr',
             'limits': {
@@ -220,9 +215,8 @@ class TestThrottledWithNbdExportBase(iotests.QMPTestCase):
                 'iops-total-max': self.iops
             }
         })
-        self.assert_qmp(result, 'return', {})
 
-        result = self.vm.qmp('blockdev-add', **{
+        self.vm.cmd('blockdev-add', **{
             'node-name': 'source-node',
             'driver': 'throttle',
             'throttle-group': 'thrgr',
@@ -234,9 +228,8 @@ class TestThrottledWithNbdExportBase(iotests.QMPTestCase):
                 }
             }
         })
-        self.assert_qmp(result, 'return', {})
 
-        result = self.vm.qmp('blockdev-add', **{
+        self.vm.cmd('blockdev-add', **{
             'node-name': 'target-node',
             'driver': iotests.imgfmt,
             'file': {
@@ -244,23 +237,20 @@ class TestThrottledWithNbdExportBase(iotests.QMPTestCase):
                 'filename': target_img
             }
         })
-        self.assert_qmp(result, 'return', {})
 
         self.nbd_sock = iotests.file_path('nbd.sock',
                                           base_dir=iotests.sock_dir)
         self.nbd_url = f'nbd+unix:///source-node?socket={self.nbd_sock}'
 
-        result = self.vm.qmp('nbd-server-start', addr={
+        self.vm.cmd('nbd-server-start', addr={
             'type': 'unix',
             'data': {
                 'path': self.nbd_sock
             }
         })
-        self.assert_qmp(result, 'return', {})
 
-        result = self.vm.qmp('block-export-add', id='exp0', type='nbd',
-                             node_name='source-node', writable=True)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('block-export-add', id='exp0', type='nbd',
+                    node_name='source-node', writable=True)
 
     def tearDown(self):
         # Wait for background requests to settle
@@ -313,15 +303,14 @@ class TestLowThrottledWithNbdExport(TestThrottledWithNbdExportBase):
 
         # Launch the mirror job
         mirror_buf_size = 65536
-        result = self.vm.qmp('blockdev-mirror',
-                             job_id='mirror',
-                             filter_node_name='mirror-node',
-                             device='source-node',
-                             target='target-node',
-                             sync='full',
-                             copy_mode='write-blocking',
-                             buf_size=mirror_buf_size)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-mirror',
+                    job_id='mirror',
+                    filter_node_name='mirror-node',
+                    device='source-node',
+                    target='target-node',
+                    sync='full',
+                    copy_mode='write-blocking',
+                    buf_size=mirror_buf_size)
 
         # We create the external requests via qemu-io processes on the NBD
         # server.  Have their offset start in the middle of the image so they
@@ -409,13 +398,12 @@ class TestHighThrottledWithNbdExport(TestThrottledWithNbdExportBase):
         # start blockdev-mirror
         self.vm.qtest(f'clock_step {1 * 1000 * 1000 * 1000}')
 
-        result = self.vm.qmp('blockdev-mirror',
-                             job_id='mirror',
-                             device='source-node',
-                             target='target-node',
-                             sync='full',
-                             copy_mode='write-blocking')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-mirror',
+                    job_id='mirror',
+                    device='source-node',
+                    target='target-node',
+                    sync='full',
+                    copy_mode='write-blocking')
 
 
 if __name__ == '__main__':
diff --git a/tests/qemu-iotests/152 b/tests/qemu-iotests/152
index b73a0d08a2..197bea9e77 100755
--- a/tests/qemu-iotests/152
+++ b/tests/qemu-iotests/152
@@ -41,18 +41,16 @@ class TestUnaligned(iotests.QMPTestCase):
             pass
 
     def test_unaligned(self):
-        result = self.vm.qmp('drive-mirror', device='drive0', sync='full',
-                             granularity=65536, target=target_img)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('drive-mirror', device='drive0', sync='full',
+                    granularity=65536, target=target_img)
         self.complete_and_wait()
         self.vm.shutdown()
         self.assertEqual(iotests.image_size(test_img), iotests.image_size(target_img),
                          "Target size doesn't match source when granularity when unaligend")
 
     def test_unaligned_with_update(self):
-        result = self.vm.qmp('drive-mirror', device='drive0', sync='full',
-                             granularity=65536, target=target_img)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('drive-mirror', device='drive0', sync='full',
+                    granularity=65536, target=target_img)
         self.wait_ready()
         self.vm.hmp_qemu_io('drive0', 'write 0 512')
         self.complete_and_wait(wait_ready=False)
diff --git a/tests/qemu-iotests/155 b/tests/qemu-iotests/155
index 0c073fd61b..38eacb4127 100755
--- a/tests/qemu-iotests/155
+++ b/tests/qemu-iotests/155
@@ -110,8 +110,7 @@ class BaseClass(iotests.QMPTestCase):
                 elif self.target_blockdev_backing:
                         options['backing'] = self.target_blockdev_backing
 
-                result = self.vm.qmp('blockdev-add', options)
-                self.assert_qmp(result, 'return', {})
+                self.vm.cmd('blockdev-add', options)
 
     def tearDown(self):
         self.vm.shutdown()
@@ -178,20 +177,18 @@ class MirrorBaseClass(BaseClass):
 
     def runMirror(self, sync):
         if self.cmd == 'blockdev-mirror':
-            result = self.vm.qmp(self.cmd, job_id='mirror-job', device='source',
-                                 sync=sync, target='target',
-                                 auto_finalize=False)
-            self.assert_qmp(result, 'return', {})
+            self.vm.cmd(self.cmd, job_id='mirror-job', device='source',
+                        sync=sync, target='target',
+                        auto_finalize=False)
         else:
             if self.existing:
                 mode = 'existing'
             else:
                 mode = 'absolute-paths'
-            result = self.vm.qmp(self.cmd, job_id='mirror-job', device='source',
-                                 sync=sync, target=target_img,
-                                 format=iotests.imgfmt, mode=mode,
-                                 node_name='target', auto_finalize=False)
-            self.assert_qmp(result, 'return', {})
+            self.vm.cmd(self.cmd, job_id='mirror-job', device='source',
+                        sync=sync, target=target_img,
+                        format=iotests.imgfmt, mode=mode,
+                        node_name='target', auto_finalize=False)
 
         self.vm.run_job('mirror-job', auto_finalize=False,
                         pre_finalize=self.openBacking, auto_dismiss=True)
@@ -258,16 +255,14 @@ class TestBlockdevMirrorReopen(MirrorBaseClass):
 
     def openBacking(self):
         if not self.target_open_with_backing:
-            result = self.vm.qmp('blockdev-add', node_name="backing",
-                                 driver="null-co")
-            self.assert_qmp(result, 'return', {})
-            result = self.vm.qmp('blockdev-reopen', options=[{
-                                     'node-name': "target",
-                                     'driver': iotests.imgfmt,
-                                     'file': "target-file",
-                                     'backing': "backing"
-                                 }])
-            self.assert_qmp(result, 'return', {})
+            self.vm.cmd('blockdev-add', node_name="backing",
+                        driver="null-co")
+            self.vm.cmd('blockdev-reopen', options=[{
+                            'node-name': "target",
+                            'driver': iotests.imgfmt,
+                            'file': "target-file",
+                            'backing': "backing"
+                        }])
 
 class TestBlockdevMirrorReopenIothread(TestBlockdevMirrorReopen):
     use_iothread = True
@@ -281,12 +276,10 @@ class TestBlockdevMirrorSnapshot(MirrorBaseClass):
 
     def openBacking(self):
         if not self.target_open_with_backing:
-            result = self.vm.qmp('blockdev-add', node_name="backing",
-                                 driver="null-co")
-            self.assert_qmp(result, 'return', {})
-            result = self.vm.qmp('blockdev-snapshot', node="backing",
-                                 overlay="target")
-            self.assert_qmp(result, 'return', {})
+            self.vm.cmd('blockdev-add', node_name="backing",
+                        driver="null-co")
+            self.vm.cmd('blockdev-snapshot', node="backing",
+                        overlay="target")
 
 class TestBlockdevMirrorSnapshotIothread(TestBlockdevMirrorSnapshot):
     use_iothread = True
@@ -295,14 +288,12 @@ class TestCommit(BaseClass):
     existing = False
 
     def testCommit(self):
-        result = self.vm.qmp('block-commit', job_id='commit-job',
-                             device='source', base=back1_img)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('block-commit', job_id='commit-job',
+                    device='source', base=back1_img)
 
         self.vm.event_wait('BLOCK_JOB_READY')
 
-        result = self.vm.qmp('block-job-complete', device='commit-job')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('block-job-complete', device='commit-job')
 
         self.vm.event_wait('BLOCK_JOB_COMPLETED')
 
diff --git a/tests/qemu-iotests/165 b/tests/qemu-iotests/165
index e3ef28e2ee..b24907a62f 100755
--- a/tests/qemu-iotests/165
+++ b/tests/qemu-iotests/165
@@ -116,9 +116,8 @@ class TestPersistentDirtyBitmap(iotests.QMPTestCase):
         sha256_2 = self.getSha256()
         assert sha256_1 != sha256_2 # Otherwise, it's not very interesting.
 
-        result = self.vm.qmp('block-dirty-bitmap-clear', node='drive0',
-                             name='bitmap0')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('block-dirty-bitmap-clear', node='drive0',
+                    name='bitmap0')
 
         # Start with regions1
 
@@ -137,7 +136,7 @@ class TestPersistentDirtyBitmap(iotests.QMPTestCase):
         assert sha256_1 == self.getSha256()
 
         # Reopen to RW
-        result = self.vm.qmp('blockdev-reopen', options=[{
+        self.vm.cmd('blockdev-reopen', options=[{
             'node-name': 'node0',
             'driver': iotests.imgfmt,
             'file': {
@@ -146,7 +145,6 @@ class TestPersistentDirtyBitmap(iotests.QMPTestCase):
             },
             'read-only': False
         }])
-        self.assert_qmp(result, 'return', {})
 
         # Check that bitmap is reopened to RW and we can write to it.
         self.writeRegions(regions2)
diff --git a/tests/qemu-iotests/196 b/tests/qemu-iotests/196
index 27c1629be3..e5105b1354 100755
--- a/tests/qemu-iotests/196
+++ b/tests/qemu-iotests/196
@@ -45,8 +45,7 @@ class TestInvalidateAutoclear(iotests.QMPTestCase):
         self.vm_b.add_incoming("exec: cat '" + migfile + "'")
 
     def test_migration(self):
-        result = self.vm_a.qmp('migrate', uri='exec:cat>' + migfile)
-        self.assert_qmp(result, 'return', {})
+        self.vm_a.cmd('migrate', uri='exec:cat>' + migfile)
         self.assertNotEqual(self.vm_a.event_wait("STOP"), None)
 
         with open(disk, 'r+b') as f:
diff --git a/tests/qemu-iotests/205 b/tests/qemu-iotests/205
index 15f798288a..2370e1a138 100755
--- a/tests/qemu-iotests/205
+++ b/tests/qemu-iotests/205
@@ -44,10 +44,8 @@ class TestNbdServerRemove(iotests.QMPTestCase):
             }
         }
 
-        result = self.vm.qmp('nbd-server-start', addr=address)
-        self.assert_qmp(result, 'return', {})
-        result = self.vm.qmp('nbd-server-add', device='drive0', name='exp')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('nbd-server-start', addr=address)
+        self.vm.cmd('nbd-server-add', device='drive0', name='exp')
 
     def tearDown(self):
         self.vm.shutdown()
diff --git a/tests/qemu-iotests/218 b/tests/qemu-iotests/218
index 5e74c55b6a..81aa68806f 100755
--- a/tests/qemu-iotests/218
+++ b/tests/qemu-iotests/218
@@ -41,34 +41,30 @@ iotests.script_initialize(supported_fmts=['qcow2', 'raw'])
 def start_mirror(vm, speed=None, buf_size=None):
     vm.launch()
 
-    ret = vm.qmp('blockdev-add',
-                     node_name='source',
-                     driver='null-co',
-                     size=1048576)
-    assert ret['return'] == {}
+    vm.cmd('blockdev-add',
+               node_name='source',
+               driver='null-co',
+               size=1048576)
 
-    ret = vm.qmp('blockdev-add',
-                     node_name='target',
-                     driver='null-co',
-                     size=1048576)
-    assert ret['return'] == {}
+    vm.cmd('blockdev-add',
+               node_name='target',
+               driver='null-co',
+               size=1048576)
 
     if speed is not None:
-        ret = vm.qmp('blockdev-mirror',
-                         job_id='mirror',
-                         device='source',
-                         target='target',
-                         sync='full',
-                         speed=speed,
-                         buf_size=buf_size)
-        assert ret['return'] == {}
+        vm.cmd('blockdev-mirror',
+                   job_id='mirror',
+                   device='source',
+                   target='target',
+                   sync='full',
+                   speed=speed,
+                   buf_size=buf_size)
     else:
-        ret = vm.qmp('blockdev-mirror',
-                         job_id='mirror',
-                         device='source',
-                         target='target',
-                         sync='full')
-        assert ret['return'] == {}
+        vm.cmd('blockdev-mirror',
+                   job_id='mirror',
+                   device='source',
+                   target='target',
+                   sync='full')
 
 
 log('')
@@ -150,38 +146,33 @@ with iotests.VM() as vm, \
 
     vm.launch()
 
-    ret = vm.qmp('object-add', qom_type='throttle-group', id='tg',
-                 limits={'bps-read': 4096})
-    assert ret['return'] == {}
+    vm.cmd('object-add', qom_type='throttle-group', id='tg',
+           limits={'bps-read': 4096})
 
-    ret = vm.qmp('blockdev-add',
-                 node_name='source',
-                 driver=iotests.imgfmt,
-                 file={
-                     'driver': 'file',
-                     'filename': src_img_path
-                 })
-    assert ret['return'] == {}
+    vm.cmd('blockdev-add',
+           node_name='source',
+           driver=iotests.imgfmt,
+           file={
+               'driver': 'file',
+               'filename': src_img_path
+           })
 
-    ret = vm.qmp('blockdev-add',
-                 node_name='throttled-source',
-                 driver='throttle',
-                 throttle_group='tg',
-                 file='source')
-    assert ret['return'] == {}
+    vm.cmd('blockdev-add',
+           node_name='throttled-source',
+           driver='throttle',
+           throttle_group='tg',
+           file='source')
 
-    ret = vm.qmp('blockdev-add',
-                 node_name='target',
-                 driver='null-co',
-                 size=(64 * 1048576))
-    assert ret['return'] == {}
+    vm.cmd('blockdev-add',
+           node_name='target',
+           driver='null-co',
+           size=(64 * 1048576))
 
-    ret = vm.qmp('blockdev-mirror',
-                 job_id='mirror',
-                 device='throttled-source',
-                 target='target',
-                 sync='full')
-    assert ret['return'] == {}
+    vm.cmd('blockdev-mirror',
+           job_id='mirror',
+           device='throttled-source',
+           target='target',
+           sync='full')
 
     log(vm.qmp('quit'))
 
diff --git a/tests/qemu-iotests/245 b/tests/qemu-iotests/245
index 92b28c79be..a934c9d1e6 100755
--- a/tests/qemu-iotests/245
+++ b/tests/qemu-iotests/245
@@ -136,8 +136,7 @@ class TestBlockdevReopen(iotests.QMPTestCase):
     def test_incorrect_parameters_single_file(self):
         # Open 'hd0' only (no backing files)
         opts = hd_opts(0)
-        result = self.vm.qmp('blockdev-add', conv_keys = False, **opts)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-add', conv_keys = False, **opts)
         original_graph = self.vm.qmp('query-named-block-nodes')
 
         # We can reopen the image passing the same options
@@ -171,8 +170,7 @@ class TestBlockdevReopen(iotests.QMPTestCase):
         self.check_node_graph(original_graph)
 
         # Remove the node
-        result = self.vm.qmp('blockdev-del', conv_keys = True, node_name = 'hd0')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-del', conv_keys = True, node_name = 'hd0')
 
     # This test opens an image with a backing file and tries to reopen
     # it with illegal / incorrect parameters.
@@ -180,8 +178,7 @@ class TestBlockdevReopen(iotests.QMPTestCase):
         # Open hd1 omitting the backing options (hd0 will be opened
         # with the default options)
         opts = hd_opts(1)
-        result = self.vm.qmp('blockdev-add', conv_keys = False, **opts)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-add', conv_keys = False, **opts)
         original_graph = self.vm.qmp('query-named-block-nodes')
 
         # We can't reopen the image passing the same options, 'backing' is mandatory
@@ -213,8 +210,7 @@ class TestBlockdevReopen(iotests.QMPTestCase):
         self.check_node_graph(original_graph)
 
         # Remove the node
-        result = self.vm.qmp('blockdev-del', conv_keys = True, node_name = 'hd1')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-del', conv_keys = True, node_name = 'hd1')
 
     # Reopen an image several times changing some of its options
     def test_reopen(self):
@@ -230,8 +226,7 @@ class TestBlockdevReopen(iotests.QMPTestCase):
         # Open the hd1 image passing all backing options
         opts = hd_opts(1)
         opts['backing'] = hd_opts(0)
-        result = self.vm.qmp('blockdev-add', conv_keys = False, **opts)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-add', conv_keys = False, **opts)
         original_graph = self.vm.qmp('query-named-block-nodes')
 
         # We can reopen the image passing the same options
@@ -306,8 +301,7 @@ class TestBlockdevReopen(iotests.QMPTestCase):
         self.assert_qmp_absent(self.get_node('hd1'), 'image/backing-image')
 
         # Open the 'hd0' image
-        result = self.vm.qmp('blockdev-add', conv_keys = False, **hd_opts(0))
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-add', conv_keys = False, **hd_opts(0))
 
         # Reopen the hd1 image setting 'hd0' as its backing image
         self.reopen(opts, {'backing': 'hd0'})
@@ -326,10 +320,8 @@ class TestBlockdevReopen(iotests.QMPTestCase):
         self.assert_qmp(result, 'error/desc', "Node 'hd0' is busy: node is used as backing hd of 'hd1'")
 
         # But we can remove both nodes if done in the proper order
-        result = self.vm.qmp('blockdev-del', conv_keys = True, node_name = 'hd1')
-        self.assert_qmp(result, 'return', {})
-        result = self.vm.qmp('blockdev-del', conv_keys = True, node_name = 'hd0')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-del', conv_keys = True, node_name = 'hd1')
+        self.vm.cmd('blockdev-del', conv_keys = True, node_name = 'hd0')
 
     # Reopen a raw image and see the effect of changing the 'offset' option
     def test_reopen_raw(self):
@@ -345,8 +337,7 @@ class TestBlockdevReopen(iotests.QMPTestCase):
         qemu_io('-f', 'raw', '-c', 'write -P 0xa1 1M 1M', hd_path[0])
 
         # Open the raw file with QEMU
-        result = self.vm.qmp('blockdev-add', conv_keys = False, **opts)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-add', conv_keys = False, **opts)
 
         # Read 1MB from offset 0
         self.run_qemu_io("hd0", "read -P 0xa0  0 1M")
@@ -362,8 +353,7 @@ class TestBlockdevReopen(iotests.QMPTestCase):
         self.run_qemu_io("hd0", "read -P 0xa0  0 1M")
 
         # Remove the block device
-        result = self.vm.qmp('blockdev-del', conv_keys = True, node_name = 'hd0')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-del', conv_keys = True, node_name = 'hd0')
 
     # Omitting an option should reset it to the default value, but if
     # an option cannot be changed it shouldn't be possible to reset it
@@ -377,8 +367,7 @@ class TestBlockdevReopen(iotests.QMPTestCase):
                           'node-name': 'hd0-file' } }
 
         # Open the file with QEMU
-        result = self.vm.qmp('blockdev-add', conv_keys = False, **opts)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-add', conv_keys = False, **opts)
 
         # file.x-check-cache-dropped can be changed...
         self.reopen(opts, { 'file.x-check-cache-dropped': False })
@@ -394,8 +383,7 @@ class TestBlockdevReopen(iotests.QMPTestCase):
         self.reopen(opts, { 'file.locking': 'off' })
 
         # Remove the block device
-        result = self.vm.qmp('blockdev-del', conv_keys = True, node_name = 'hd0')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-del', conv_keys = True, node_name = 'hd0')
 
     # This test modifies the node graph a few times by changing the
     # 'backing' option on reopen and verifies that the guest data that
@@ -407,8 +395,7 @@ class TestBlockdevReopen(iotests.QMPTestCase):
         for i in range(3):
             opts.append(hd_opts(i))
             opts[i]['backing'] = None
-            result = self.vm.qmp('blockdev-add', conv_keys = False, **opts[i])
-            self.assert_qmp(result, 'return', {})
+            self.vm.cmd('blockdev-add', conv_keys = False, **opts[i])
 
         # hd0
         self.run_qemu_io("hd0", "read -P 0xa0  0 1M")
@@ -499,8 +486,7 @@ class TestBlockdevReopen(iotests.QMPTestCase):
         for i in range(3):
             opts.append(hd_opts(i))
             opts[i]['backing'] = None
-            result = self.vm.qmp('blockdev-add', conv_keys = False, **opts[i])
-            self.assert_qmp(result, 'return', {})
+            self.vm.cmd('blockdev-add', conv_keys = False, **opts[i])
 
         # hd1 <- hd0, hd1 <- hd2
         self.reopen(opts[0], {'backing': 'hd1'})
@@ -532,8 +518,7 @@ class TestBlockdevReopen(iotests.QMPTestCase):
                   'node-name': 'bv',
                   'test': 'hd0',
                   'raw': 'hd1'}
-        result = self.vm.qmp('blockdev-add', conv_keys = False, **bvopts)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-add', conv_keys = False, **bvopts)
 
         # blkverify doesn't currently allow reopening. TODO: implement this
         self.reopen(bvopts, {}, "Block format 'blkverify' used by node 'bv'" +
@@ -544,8 +529,7 @@ class TestBlockdevReopen(iotests.QMPTestCase):
                     "Making 'bv' a backing child of 'hd0' would create a cycle")
 
         # Delete the blkverify node
-        result = self.vm.qmp('blockdev-del', conv_keys = True, node_name = 'bv')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-del', conv_keys = True, node_name = 'bv')
 
     # Replace the protocol layer ('file' parameter) of a disk image
     def test_replace_file(self):
@@ -556,16 +540,13 @@ class TestBlockdevReopen(iotests.QMPTestCase):
         hd0_opts = {'driver': 'file', 'node-name': 'hd0-file', 'filename':  hd_path[0] }
         hd1_opts = {'driver': 'file', 'node-name': 'hd1-file', 'filename':  hd_path[1] }
 
-        result = self.vm.qmp('blockdev-add', conv_keys = False, **hd0_opts)
-        self.assert_qmp(result, 'return', {})
-        result = self.vm.qmp('blockdev-add', conv_keys = False, **hd1_opts)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-add', conv_keys = False, **hd0_opts)
+        self.vm.cmd('blockdev-add', conv_keys = False, **hd1_opts)
 
         # Add a raw format layer that uses hd0-file as its protocol layer
         opts = {'driver': 'raw', 'node-name': 'hd', 'file': 'hd0-file'}
 
-        result = self.vm.qmp('blockdev-add', conv_keys = False, **opts)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-add', conv_keys = False, **opts)
 
         # Fill the image with data
         self.run_qemu_io("hd", "read  -P 0 0 10k")
@@ -588,21 +569,18 @@ class TestBlockdevReopen(iotests.QMPTestCase):
     def test_insert_throttle_filter(self):
         # Add an image to the VM
         hd0_opts = hd_opts(0)
-        result = self.vm.qmp('blockdev-add', conv_keys = False, **hd0_opts)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-add', conv_keys = False, **hd0_opts)
 
         # Create a throttle-group object
         opts = { 'qom-type': 'throttle-group', 'id': 'group0',
                  'limits': { 'iops-total': 1000 } }
-        result = self.vm.qmp('object-add', conv_keys = False, **opts)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('object-add', conv_keys = False, **opts)
 
         # Add a throttle filter with the group that we just created.
         # The filter is not used by anyone yet
         opts = { 'driver': 'throttle', 'node-name': 'throttle0',
                  'throttle-group': 'group0', 'file': 'hd0-file' }
-        result = self.vm.qmp('blockdev-add', conv_keys = False, **opts)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-add', conv_keys = False, **opts)
 
         # Insert the throttle filter between hd0 and hd0-file
         self.reopen(hd0_opts, {'file': 'throttle0'})
@@ -615,15 +593,13 @@ class TestBlockdevReopen(iotests.QMPTestCase):
     def test_insert_compress_filter(self):
         # Add an image to the VM: hd (raw) -> hd0 (qcow2) -> hd0-file (file)
         opts = {'driver': 'raw', 'node-name': 'hd', 'file': hd_opts(0)}
-        result = self.vm.qmp('blockdev-add', conv_keys = False, **opts)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-add', conv_keys = False, **opts)
 
         # Add a 'compress' filter
         filter_opts = {'driver': 'compress',
                        'node-name': 'compress0',
                        'file': 'hd0'}
-        result = self.vm.qmp('blockdev-add', conv_keys = False, **filter_opts)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-add', conv_keys = False, **filter_opts)
 
         # Unmap the beginning of the image (we cannot write compressed
         # data to an allocated cluster)
@@ -659,12 +635,10 @@ class TestBlockdevReopen(iotests.QMPTestCase):
     def test_swap_files(self):
         # Add hd0 and hd2 (none of them with backing files)
         opts0 = hd_opts(0)
-        result = self.vm.qmp('blockdev-add', conv_keys = False, **opts0)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-add', conv_keys = False, **opts0)
 
         opts2 = hd_opts(2)
-        result = self.vm.qmp('blockdev-add', conv_keys = False, **opts2)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-add', conv_keys = False, **opts2)
 
         # Write different data to both block devices
         self.run_qemu_io("hd0", "write -P 0xa0 0 1k")
@@ -712,15 +686,13 @@ class TestBlockdevReopen(iotests.QMPTestCase):
             opts = hd_opts(i)
             # Open all three images without backing file
             opts['backing'] = None
-            result = self.vm.qmp('blockdev-add', conv_keys = False, **opts)
-            self.assert_qmp(result, 'return', {})
+            self.vm.cmd('blockdev-add', conv_keys = False, **opts)
 
         opts = {'driver': 'quorum',
                 'node-name': 'quorum0',
                 'children': ['hd0', 'hd1', 'hd2'],
                 'vote-threshold': 2}
-        result = self.vm.qmp('blockdev-add', conv_keys = False, **opts)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-add', conv_keys = False, **opts)
 
         # Quorum doesn't currently allow reopening. TODO: implement this
         self.reopen(opts, {}, "Block format 'quorum' used by node 'quorum0'" +
@@ -732,14 +704,12 @@ class TestBlockdevReopen(iotests.QMPTestCase):
                     "Making 'quorum0' a backing child of 'hd0' would create a cycle")
 
         # Delete quorum0
-        result = self.vm.qmp('blockdev-del', conv_keys = True, node_name = 'quorum0')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-del', conv_keys = True, node_name = 'quorum0')
 
         # Delete hd0, hd1 and hd2
         for i in range(3):
-            result = self.vm.qmp('blockdev-del', conv_keys = True,
-                                 node_name = 'hd%d' % i)
-            self.assert_qmp(result, 'return', {})
+            self.vm.cmd('blockdev-del', conv_keys = True,
+                        node_name = 'hd%d' % i)
 
         ######################
         ###### blkdebug ######
@@ -748,8 +718,7 @@ class TestBlockdevReopen(iotests.QMPTestCase):
                 'node-name': 'bd',
                 'config': '/dev/null',
                 'image': hd_opts(0)}
-        result = self.vm.qmp('blockdev-add', conv_keys = False, **opts)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-add', conv_keys = False, **opts)
 
         # blkdebug allows reopening if we keep the same options
         self.reopen(opts)
@@ -762,16 +731,14 @@ class TestBlockdevReopen(iotests.QMPTestCase):
         self.reopen(opts, {}, "Option 'config' cannot be reset to its default value")
 
         # Delete the blkdebug node
-        result = self.vm.qmp('blockdev-del', conv_keys = True, node_name = 'bd')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-del', conv_keys = True, node_name = 'bd')
 
         ##################
         ###### null ######
         ##################
         opts = {'driver': 'null-co', 'node-name': 'root', 'size': 1024}
 
-        result = self.vm.qmp('blockdev-add', conv_keys = False, **opts)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-add', conv_keys = False, **opts)
 
         # 1 << 30 is the default value, but we cannot change it explicitly
         self.reopen(opts, {'size': (1 << 30)}, "Cannot change the option 'size'")
@@ -780,16 +747,14 @@ class TestBlockdevReopen(iotests.QMPTestCase):
         del opts['size']
         self.reopen(opts, {}, "Option 'size' cannot be reset to its default value")
 
-        result = self.vm.qmp('blockdev-del', conv_keys = True, node_name = 'root')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-del', conv_keys = True, node_name = 'root')
 
         ##################
         ###### file ######
         ##################
         opts = hd_opts(0)
         opts['file']['locking'] = 'on'
-        result = self.vm.qmp('blockdev-add', conv_keys = False, **opts)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-add', conv_keys = False, **opts)
 
         # 'locking' cannot be changed
         del opts['file']['locking']
@@ -803,27 +768,23 @@ class TestBlockdevReopen(iotests.QMPTestCase):
         self.reopen(opts, {'locking': 'off'}, "Cannot change the option 'locking'")
         self.reopen(opts, {}, "Option 'locking' cannot be reset to its default value")
 
-        result = self.vm.qmp('blockdev-del', conv_keys = True, node_name = 'hd0')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-del', conv_keys = True, node_name = 'hd0')
 
         ######################
         ###### throttle ######
         ######################
         opts = { 'qom-type': 'throttle-group', 'id': 'group0',
                  'limits': { 'iops-total': 1000 } }
-        result = self.vm.qmp('object-add', conv_keys = False, **opts)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('object-add', conv_keys = False, **opts)
 
         opts = { 'qom-type': 'throttle-group', 'id': 'group1',
                  'limits': { 'iops-total': 2000 } }
-        result = self.vm.qmp('object-add', conv_keys = False, **opts)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('object-add', conv_keys = False, **opts)
 
         # Add a throttle filter with group = group0
         opts = { 'driver': 'throttle', 'node-name': 'throttle0',
                  'throttle-group': 'group0', 'file': hd_opts(0) }
-        result = self.vm.qmp('blockdev-add', conv_keys = False, **opts)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-add', conv_keys = False, **opts)
 
         # We can reopen it if we keep the same options
         self.reopen(opts)
@@ -851,16 +812,13 @@ class TestBlockdevReopen(iotests.QMPTestCase):
         self.assert_qmp(result, 'error/desc', "object 'group0' is in use, can not be deleted")
 
         # But group1 is free this time, and it can be deleted
-        result = self.vm.qmp('object-del', id = 'group1')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('object-del', id = 'group1')
 
         # Let's delete the filter node
-        result = self.vm.qmp('blockdev-del', conv_keys = True, node_name = 'throttle0')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-del', conv_keys = True, node_name = 'throttle0')
 
         # And we can finally get rid of group0
-        result = self.vm.qmp('object-del', id = 'group0')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('object-del', id = 'group0')
 
     # If an image has a backing file then the 'backing' option must be
     # passed on reopen. We don't allow leaving the option out in this
@@ -868,13 +826,11 @@ class TestBlockdevReopen(iotests.QMPTestCase):
     def test_missing_backing_options_1(self):
         # hd2
         opts = hd_opts(2)
-        result = self.vm.qmp('blockdev-add', conv_keys = False, **opts)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-add', conv_keys = False, **opts)
 
         # hd0
         opts = hd_opts(0)
-        result = self.vm.qmp('blockdev-add', conv_keys = False, **opts)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-add', conv_keys = False, **opts)
 
         # hd0 has no backing file: we can omit the 'backing' option
         self.reopen(opts)
@@ -897,11 +853,9 @@ class TestBlockdevReopen(iotests.QMPTestCase):
         self.reopen(opts)
 
         # Remove both hd0 and hd2
-        result = self.vm.qmp('blockdev-del', conv_keys = True, node_name = 'hd0')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-del', conv_keys = True, node_name = 'hd0')
 
-        result = self.vm.qmp('blockdev-del', conv_keys = True, node_name = 'hd2')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-del', conv_keys = True, node_name = 'hd2')
 
     # If an image has default backing file (as part of its metadata)
     # then the 'backing' option must be passed on reopen. We don't
@@ -911,8 +865,7 @@ class TestBlockdevReopen(iotests.QMPTestCase):
         # hd0 <- hd1
         # (hd0 is hd1's default backing file)
         opts = hd_opts(1)
-        result = self.vm.qmp('blockdev-add', conv_keys = False, **opts)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-add', conv_keys = False, **opts)
 
         # hd1 has a backing file: we can't omit the 'backing' option
         self.reopen(opts, {}, "backing is missing for 'hd1'")
@@ -923,8 +876,7 @@ class TestBlockdevReopen(iotests.QMPTestCase):
         # No backing file attached to hd1 now, but we still can't omit the 'backing' option
         self.reopen(opts, {}, "backing is missing for 'hd1'")
 
-        result = self.vm.qmp('blockdev-del', conv_keys = True, node_name = 'hd1')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-del', conv_keys = True, node_name = 'hd1')
 
     # Test that making 'backing' a reference to an existing child
     # keeps its current options
@@ -937,8 +889,7 @@ class TestBlockdevReopen(iotests.QMPTestCase):
         opts['detect-zeroes'] = 'on'
         opts['backing']['detect-zeroes'] = 'on'
         opts['backing']['backing']['detect-zeroes'] = 'on'
-        result = self.vm.qmp('blockdev-add', conv_keys = False, **opts)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-add', conv_keys = False, **opts)
 
         # Reopen the chain passing the minimum amount of required options.
         # By making 'backing' a reference to hd1 (instead of a sub-dict)
@@ -961,12 +912,10 @@ class TestBlockdevReopen(iotests.QMPTestCase):
         opts = hd_opts(0)
         opts['backing'] = hd_opts(1)
         opts['backing']['backing'] = None
-        result = self.vm.qmp('blockdev-add', conv_keys = False, **opts)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-add', conv_keys = False, **opts)
 
         # Stream hd1 into hd0 and wait until it's done
-        result = self.vm.qmp('block-stream', conv_keys = True, job_id = 'stream0', device = 'hd0')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('block-stream', conv_keys = True, job_id = 'stream0', device = 'hd0')
         self.wait_until_completed(drive = 'stream0')
 
         # Now we have only hd0
@@ -982,8 +931,7 @@ class TestBlockdevReopen(iotests.QMPTestCase):
         # We can also reopen hd0 if we set 'backing' to null
         self.reopen(opts, {'backing': None})
 
-        result = self.vm.qmp('blockdev-del', conv_keys = True, node_name = 'hd0')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-del', conv_keys = True, node_name = 'hd0')
 
     # Another block_stream test
     def test_block_stream_2(self):
@@ -991,13 +939,11 @@ class TestBlockdevReopen(iotests.QMPTestCase):
         opts = hd_opts(0)
         opts['backing'] = hd_opts(1)
         opts['backing']['backing'] = hd_opts(2)
-        result = self.vm.qmp('blockdev-add', conv_keys = False, **opts)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-add', conv_keys = False, **opts)
 
         # Stream hd1 into hd0 and wait until it's done
-        result = self.vm.qmp('block-stream', conv_keys = True, job_id = 'stream0',
-                             device = 'hd0', base_node = 'hd2')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('block-stream', conv_keys = True, job_id = 'stream0',
+                    device = 'hd0', base_node = 'hd2')
         self.wait_until_completed(drive = 'stream0')
 
         # The chain is hd2 <- hd0 now. hd1 is missing
@@ -1019,8 +965,7 @@ class TestBlockdevReopen(iotests.QMPTestCase):
         self.reopen(opts, {}, "backing is missing for 'hd0'")
 
         # Now we can delete hd0 (and hd2)
-        result = self.vm.qmp('blockdev-del', conv_keys = True, node_name = 'hd0')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-del', conv_keys = True, node_name = 'hd0')
         self.assertEqual(self.get_node('hd2'), None)
 
     # Reopen the chain during a block-stream job (from hd1 to hd0)
@@ -1029,14 +974,12 @@ class TestBlockdevReopen(iotests.QMPTestCase):
         opts = hd_opts(0)
         opts['backing'] = hd_opts(1)
         opts['backing']['backing'] = hd_opts(2)
-        result = self.vm.qmp('blockdev-add', conv_keys = False, **opts)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-add', conv_keys = False, **opts)
 
         # hd2 <- hd0
-        result = self.vm.qmp('block-stream', conv_keys = True, job_id = 'stream0',
-                             device = 'hd0', base_node = 'hd2',
-                             auto_finalize = False)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('block-stream', conv_keys = True, job_id = 'stream0',
+                    device = 'hd0', base_node = 'hd2',
+                    auto_finalize = False)
 
         # We can remove hd2 while the stream job is ongoing
         opts['backing']['backing'] = None
@@ -1054,14 +997,12 @@ class TestBlockdevReopen(iotests.QMPTestCase):
         opts = hd_opts(0)
         opts['backing'] = hd_opts(1)
         opts['backing']['backing'] = hd_opts(2)
-        result = self.vm.qmp('blockdev-add', conv_keys = False, **opts)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-add', conv_keys = False, **opts)
 
         # hd1 <- hd0
-        result = self.vm.qmp('block-stream', conv_keys = True, job_id = 'stream0',
-                             device = 'hd1', filter_node_name='cor',
-                             auto_finalize = False)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('block-stream', conv_keys = True, job_id = 'stream0',
+                    device = 'hd1', filter_node_name='cor',
+                    auto_finalize = False)
 
         # We can't reopen with the original options because there is a filter
         # inserted by stream job above hd1.
@@ -1090,12 +1031,10 @@ class TestBlockdevReopen(iotests.QMPTestCase):
         opts = hd_opts(0)
         opts['backing'] = hd_opts(1)
         opts['backing']['backing'] = hd_opts(2)
-        result = self.vm.qmp('blockdev-add', conv_keys = False, **opts)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-add', conv_keys = False, **opts)
 
-        result = self.vm.qmp('block-commit', conv_keys = True, job_id = 'commit0',
-                             device = 'hd0')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('block-commit', conv_keys = True, job_id = 'commit0',
+                    device = 'hd0')
 
         # We can't remove hd2 while the commit job is ongoing
         opts['backing']['backing'] = None
@@ -1110,8 +1049,7 @@ class TestBlockdevReopen(iotests.QMPTestCase):
         self.assert_qmp(event, 'data/type', 'commit')
         self.assert_qmp_absent(event, 'data/error')
 
-        result = self.vm.qmp('block-job-complete', device='commit0')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('block-job-complete', device='commit0')
 
         self.wait_until_completed(drive = 'commit0')
 
@@ -1121,13 +1059,11 @@ class TestBlockdevReopen(iotests.QMPTestCase):
         opts = hd_opts(0)
         opts['backing'] = hd_opts(1)
         opts['backing']['backing'] = hd_opts(2)
-        result = self.vm.qmp('blockdev-add', conv_keys = False, **opts)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-add', conv_keys = False, **opts)
 
-        result = self.vm.qmp('block-commit', conv_keys = True, job_id = 'commit0',
-                             device = 'hd0', top_node = 'hd1',
-                             auto_finalize = False)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('block-commit', conv_keys = True, job_id = 'commit0',
+                    device = 'hd0', top_node = 'hd1',
+                    auto_finalize = False)
 
         # We can't remove hd2 while the commit job is ongoing
         opts['backing']['backing'] = None
@@ -1147,36 +1083,28 @@ class TestBlockdevReopen(iotests.QMPTestCase):
     def run_test_iothreads(self, iothread_a, iothread_b, errmsg = None,
                            opts_a = None, opts_b = None):
         opts = opts_a or hd_opts(0)
-        result = self.vm.qmp('blockdev-add', conv_keys = False, **opts)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-add', conv_keys = False, **opts)
 
         opts2 = opts_b or hd_opts(2)
-        result = self.vm.qmp('blockdev-add', conv_keys = False, **opts2)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-add', conv_keys = False, **opts2)
 
-        result = self.vm.qmp('object-add', qom_type='iothread', id='iothread0')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('object-add', qom_type='iothread', id='iothread0')
 
-        result = self.vm.qmp('object-add', qom_type='iothread', id='iothread1')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('object-add', qom_type='iothread', id='iothread1')
 
-        result = self.vm.qmp('device_add', driver='virtio-scsi', id='scsi0',
-                             iothread=iothread_a)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('device_add', driver='virtio-scsi', id='scsi0',
+                    iothread=iothread_a)
 
-        result = self.vm.qmp('device_add', driver='virtio-scsi', id='scsi1',
-                             iothread=iothread_b)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('device_add', driver='virtio-scsi', id='scsi1',
+                    iothread=iothread_b)
 
         if iothread_a:
-            result = self.vm.qmp('device_add', driver='scsi-hd', drive='hd0',
-                                 share_rw=True, bus="scsi0.0")
-            self.assert_qmp(result, 'return', {})
+            self.vm.cmd('device_add', driver='scsi-hd', drive='hd0',
+                        share_rw=True, bus="scsi0.0")
 
         if iothread_b:
-            result = self.vm.qmp('device_add', driver='scsi-hd', drive='hd2',
-                                 share_rw=True, bus="scsi1.0")
-            self.assert_qmp(result, 'return', {})
+            self.vm.cmd('device_add', driver='scsi-hd', drive='hd2',
+                        share_rw=True, bus="scsi1.0")
 
         # Attaching the backing file may or may not work
         self.reopen(opts, {'backing': 'hd2'}, errmsg)
@@ -1205,8 +1133,7 @@ class TestBlockdevReopen(iotests.QMPTestCase):
         # Create a throttle-group object
         opts = { 'qom-type': 'throttle-group', 'id': 'group0',
                  'limits': { 'iops-total': 1000 } }
-        result = self.vm.qmp('object-add', conv_keys = False, **opts)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('object-add', conv_keys = False, **opts)
 
         # Options with a throttle filter between format and protocol
         opts = [
diff --git a/tests/qemu-iotests/264 b/tests/qemu-iotests/264
index d44deb673a..c532ccd809 100755
--- a/tests/qemu-iotests/264
+++ b/tests/qemu-iotests/264
@@ -48,18 +48,16 @@ class TestNbdReconnect(iotests.QMPTestCase):
         """Stat job with nbd target and kill the server"""
         assert job in ('blockdev-backup', 'blockdev-mirror')
         with qemu_nbd_popen('-k', nbd_sock, '-f', iotests.imgfmt, disk_b):
-            result = self.vm.qmp('blockdev-add',
-                                 {'node-name': 'backup0',
-                                  'driver': 'raw',
-                                  'file': {'driver': 'nbd',
-                                           'server': {'type': 'unix',
-                                                      'path': nbd_sock},
-                                           'reconnect-delay': 10}})
-            self.assert_qmp(result, 'return', {})
-            result = self.vm.qmp(job, device='drive0',
-                                 sync='full', target='backup0',
-                                 speed=(1 * 1024 * 1024))
-            self.assert_qmp(result, 'return', {})
+            self.vm.cmd('blockdev-add',
+                        {'node-name': 'backup0',
+                         'driver': 'raw',
+                         'file': {'driver': 'nbd',
+                                  'server': {'type': 'unix',
+                                             'path': nbd_sock},
+                                  'reconnect-delay': 10}})
+            self.vm.cmd(job, device='drive0',
+                        sync='full', target='backup0',
+                        speed=(1 * 1024 * 1024))
 
             # Wait for some progress
             t = 0.0
@@ -77,8 +75,7 @@ class TestNbdReconnect(iotests.QMPTestCase):
         self.assertTrue(jobs)
         self.assertTrue(jobs[0]['offset'] < jobs[0]['len'])
 
-        result = self.vm.qmp('block-job-set-speed', device='drive0', speed=0)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('block-job-set-speed', device='drive0', speed=0)
 
         # Emulate server down time for 1 second
         time.sleep(1)
@@ -91,12 +88,10 @@ class TestNbdReconnect(iotests.QMPTestCase):
         with qemu_nbd_popen('-k', nbd_sock, '-f', iotests.imgfmt, disk_b):
             e = self.vm.event_wait('BLOCK_JOB_COMPLETED')
             self.assertEqual(e['data']['offset'], size)
-            result = self.vm.qmp('blockdev-del', node_name='backup0')
-            self.assert_qmp(result, 'return', {})
+            self.vm.cmd('blockdev-del', node_name='backup0')
 
     def cancel_job(self):
-        result = self.vm.qmp('block-job-cancel', device='drive0', force=True)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('block-job-cancel', device='drive0', force=True)
 
         start_t = time.time()
         self.vm.event_wait('BLOCK_JOB_CANCELLED')
diff --git a/tests/qemu-iotests/281 b/tests/qemu-iotests/281
index 5e1339bd75..f6746a12e8 100755
--- a/tests/qemu-iotests/281
+++ b/tests/qemu-iotests/281
@@ -56,15 +56,13 @@ class TestDirtyBitmapIOThread(iotests.QMPTestCase):
             os.remove(self.images[name])
 
     def test_add_dirty_bitmap(self):
-        result = self.vm.qmp(
+        self.vm.cmd(
             'block-dirty-bitmap-add',
             node='drive0',
             name='bitmap1',
             persistent=True,
         )
 
-        self.assert_qmp(result, 'return', {})
-
 
 # Test for RHBZ#1746217 & RHBZ#1773517
 class TestNBDMirrorIOThread(iotests.QMPTestCase):
@@ -105,23 +103,21 @@ class TestNBDMirrorIOThread(iotests.QMPTestCase):
             os.remove(self.images[name])
 
     def test_nbd_mirror(self):
-        result = self.vm_tgt.qmp(
+        self.vm_tgt.cmd(
             'nbd-server-start',
             addr={
                 'type': 'unix',
                 'data': { 'path': self.nbd_sock }
             }
         )
-        self.assert_qmp(result, 'return', {})
 
-        result = self.vm_tgt.qmp(
+        self.vm_tgt.cmd(
             'nbd-server-add',
             device='drive0',
             writable=True
         )
-        self.assert_qmp(result, 'return', {})
 
-        result = self.vm_src.qmp(
+        self.vm_src.cmd(
             'drive-mirror',
             device='drive0',
             target='nbd+unix:///drive0?socket=' + self.nbd_sock,
@@ -130,7 +126,6 @@ class TestNBDMirrorIOThread(iotests.QMPTestCase):
             speed=64*1024*1024,
             job_id='j1'
         )
-        self.assert_qmp(result, 'return', {})
 
         self.vm_src.event_wait(name="BLOCK_JOB_READY")
 
@@ -290,8 +285,7 @@ class TestYieldingAndTimers(iotests.QMPTestCase):
         # they will remain active, fire later, and then access freed data.
         # (Or, with "block/nbd: Assert there are no timers when closed"
         # applied, the assertions added in that patch will fail.)
-        result = self.vm.qmp('blockdev-del', node_name='nbd')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-del', node_name='nbd')
 
         # Give the timers some time to fire (both have a timeout of 1 s).
         # (Sleeping in an iotest may ring some alarm bells, but note that if
@@ -303,9 +297,8 @@ class TestYieldingAndTimers(iotests.QMPTestCase):
     def test_yield_in_iothread(self):
         # Move the NBD node to the I/O thread; the NBD block driver should
         # attach the connection's QIOChannel to that thread's AioContext, too
-        result = self.vm.qmp('x-blockdev-set-iothread',
-                             node_name='nbd', iothread='iothr')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('x-blockdev-set-iothread',
+                    node_name='nbd', iothread='iothr')
 
         # Do some I/O that will be throttled by the QSD, so that the network
         # connection hopefully will yield here.  When it is resumed, it must
diff --git a/tests/qemu-iotests/295 b/tests/qemu-iotests/295
index 8ebe31054c..04818af264 100755
--- a/tests/qemu-iotests/295
+++ b/tests/qemu-iotests/295
@@ -57,8 +57,7 @@ class EncryptionSetupTestCase(iotests.QMPTestCase):
         # create the secrets and load 'em into the VM
         self.secrets = [ Secret(i) for i in range(0, 6) ]
         for secret in self.secrets:
-            result = self.vm.qmp("object-add", **secret.to_qmp_object())
-            self.assert_qmp(result, 'return', {})
+            self.vm.cmd("object-add", **secret.to_qmp_object())
 
         if iotests.imgfmt == "qcow2":
             self.pfx = "encrypt."
@@ -102,7 +101,7 @@ class EncryptionSetupTestCase(iotests.QMPTestCase):
                 }
             }
 
-        result = self.vm.qmp('blockdev-add', {
+        self.vm.cmd('blockdev-add', {
                 'driver': iotests.imgfmt,
                 'node-name': id,
                 'read-only': read_only,
@@ -115,12 +114,10 @@ class EncryptionSetupTestCase(iotests.QMPTestCase):
                 }
             }
         )
-        self.assert_qmp(result, 'return', {})
 
     # close the encrypted block device
     def closeImageQmp(self, id):
-        result = self.vm.qmp('blockdev-del', {'node-name': id})
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-del', {'node-name': id})
 
     ###########################################################################
     # add a key to an encrypted block device
@@ -159,8 +156,7 @@ class EncryptionSetupTestCase(iotests.QMPTestCase):
             args['force'] = True
 
         #TODO: check what jobs return
-        result = self.vm.qmp('x-blockdev-amend', **args)
-        assert result['return'] == {}
+        self.vm.cmd('x-blockdev-amend', **args)
         self.vm.run_job('job_add_key')
 
     # erase a key from an encrypted block device
@@ -193,8 +189,7 @@ class EncryptionSetupTestCase(iotests.QMPTestCase):
         if force == True:
             args['force'] = True
 
-        result = self.vm.qmp('x-blockdev-amend', **args)
-        assert result['return'] == {}
+        self.vm.cmd('x-blockdev-amend', **args)
         self.vm.run_job('job_erase_key')
 
     ###########################################################################
diff --git a/tests/qemu-iotests/296 b/tests/qemu-iotests/296
index 47d2526b72..2b63cefff0 100755
--- a/tests/qemu-iotests/296
+++ b/tests/qemu-iotests/296
@@ -61,10 +61,8 @@ class EncryptionSetupTestCase(iotests.QMPTestCase):
         # create the secrets and load 'em into the VMs
         self.secrets = [ Secret(i) for i in range(0, 4) ]
         for secret in self.secrets:
-            result = self.vm1.qmp("object-add", secret.to_qmp_object())
-            self.assert_qmp(result, 'return', {})
-            result = self.vm2.qmp("object-add", secret.to_qmp_object())
-            self.assert_qmp(result, 'return', {})
+            self.vm1.cmd("object-add", secret.to_qmp_object())
+            self.vm2.cmd("object-add", secret.to_qmp_object())
 
     # test case shutdown
     def tearDown(self):
@@ -132,11 +130,9 @@ class EncryptionSetupTestCase(iotests.QMPTestCase):
             }
 
         if reOpen:
-            result = vm.qmp(command, options=[opts])
-            self.assert_qmp(result, 'return', {})
+            vm.cmd(command, options=[opts])
         else:
-            result = vm.qmp(command, opts)
-            self.assert_qmp(result, 'return', {})
+            vm.cmd(command, opts)
 
 
     ###########################################################################
@@ -154,8 +150,7 @@ class EncryptionSetupTestCase(iotests.QMPTestCase):
 
     # close the encrypted block device
     def closeImageQmp(self, vm, id):
-        result = vm.qmp('blockdev-del', {'node-name': id})
-        self.assert_qmp(result, 'return', {})
+        vm.cmd('blockdev-del', {'node-name': id})
 
     ###########################################################################
 
diff --git a/tests/qemu-iotests/298 b/tests/qemu-iotests/298
index 9e75ac6975..09c9290711 100755
--- a/tests/qemu-iotests/298
+++ b/tests/qemu-iotests/298
@@ -80,25 +80,23 @@ class TestPreallocateFilter(TestPreallocateBase):
     def test_external_snapshot(self):
         self.test_prealloc()
 
-        result = self.vm.qmp('blockdev-snapshot-sync', node_name='disk',
-                             snapshot_file=overlay,
-                             snapshot_node_name='overlay')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-snapshot-sync', node_name='disk',
+                    snapshot_file=overlay,
+                    snapshot_node_name='overlay')
 
         # on reopen to  r-o base preallocation should be dropped
         self.check_small()
 
         self.vm.hmp_qemu_io('drive0', 'write 1M 1M')
 
-        result = self.vm.qmp('block-commit', device='overlay')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('block-commit', device='overlay')
         self.complete_and_wait()
 
         # commit of new megabyte should trigger preallocation
         self.check_big()
 
     def test_reopen_opts(self):
-        result = self.vm.qmp('blockdev-reopen', options=[{
+        self.vm.cmd('blockdev-reopen', options=[{
             'node-name': 'disk',
             'driver': iotests.imgfmt,
             'file': {
@@ -113,7 +111,6 @@ class TestPreallocateFilter(TestPreallocateBase):
                 }
             }
         }])
-        self.assert_qmp(result, 'return', {})
 
         self.vm.hmp_qemu_io('drive0', 'write 0 1M')
         self.assertTrue(os.path.getsize(disk) == 25 * MiB)
diff --git a/tests/qemu-iotests/300 b/tests/qemu-iotests/300
index dbd28384ec..e46616d7b1 100755
--- a/tests/qemu-iotests/300
+++ b/tests/qemu-iotests/300
@@ -50,10 +50,9 @@ class TestDirtyBitmapMigration(iotests.QMPTestCase):
         self.vm_b.add_incoming(f'unix:{mig_sock}')
         self.vm_b.launch()
 
-        result = self.vm_a.qmp('block-dirty-bitmap-add',
-                               node=self.src_node_name,
-                               name=self.src_bmap_name)
-        self.assert_qmp(result, 'return', {})
+        self.vm_a.cmd('block-dirty-bitmap-add',
+                      node=self.src_node_name,
+                      name=self.src_bmap_name)
 
         # Dirty some random megabytes
         for _ in range(9):
@@ -69,8 +68,7 @@ class TestDirtyBitmapMigration(iotests.QMPTestCase):
                 for name in ('dirty-bitmaps', 'events')]
 
         for vm in (self.vm_a, self.vm_b):
-            result = vm.qmp('migrate-set-capabilities', capabilities=caps)
-            self.assert_qmp(result, 'return', {})
+            vm.cmd('migrate-set-capabilities', capabilities=caps)
 
     def tearDown(self) -> None:
         self.vm_a.shutdown()
@@ -93,8 +91,7 @@ class TestDirtyBitmapMigration(iotests.QMPTestCase):
 
     def migrate(self, bitmap_name_valid: bool = True,
                 migration_success: bool = True) -> None:
-        result = self.vm_a.qmp('migrate', uri=f'unix:{mig_sock}')
-        self.assert_qmp(result, 'return', {})
+        self.vm_a.cmd('migrate', uri=f'unix:{mig_sock}')
 
         with iotests.Timeout(5, 'Timeout waiting for migration to complete'):
             self.assertEqual(self.vm_a.wait_migration('postmigrate'),
@@ -442,10 +439,9 @@ class TestBlockBitmapMappingErrors(TestDirtyBitmapMigration):
     def test_bitmap_name_too_long(self) -> None:
         name = 'a' * 256
 
-        result = self.vm_a.qmp('block-dirty-bitmap-add',
-                               node=self.src_node_name,
-                               name=name)
-        self.assert_qmp(result, 'return', {})
+        self.vm_a.cmd('block-dirty-bitmap-add',
+                      node=self.src_node_name,
+                      name=name)
 
         self.migrate(False, False)
 
@@ -517,22 +513,19 @@ class TestCrossAliasMigration(TestDirtyBitmapMigration):
         TestDirtyBitmapMigration.setUp(self)
 
         # Now create another block device and let both have two bitmaps each
-        result = self.vm_a.qmp('blockdev-add',
-                               node_name='node-b', driver='null-co')
-        self.assert_qmp(result, 'return', {})
+        self.vm_a.cmd('blockdev-add',
+                      node_name='node-b', driver='null-co')
 
-        result = self.vm_b.qmp('blockdev-add',
-                               node_name='node-a', driver='null-co')
-        self.assert_qmp(result, 'return', {})
+        self.vm_b.cmd('blockdev-add',
+                      node_name='node-a', driver='null-co')
 
         bmaps_to_add = (('node-a', 'bmap-b'),
                         ('node-b', 'bmap-a'),
                         ('node-b', 'bmap-b'))
 
         for (node, bmap) in bmaps_to_add:
-            result = self.vm_a.qmp('block-dirty-bitmap-add',
-                                   node=node, name=bmap)
-            self.assert_qmp(result, 'return', {})
+            self.vm_a.cmd('block-dirty-bitmap-add',
+                          node=node, name=bmap)
 
     @staticmethod
     def cross_mapping() -> BlockBitmapMapping:
@@ -611,24 +604,21 @@ class TestAliasTransformMigration(TestDirtyBitmapMigration):
         TestDirtyBitmapMigration.setUp(self)
 
         # Now create another block device and let both have two bitmaps each
-        result = self.vm_a.qmp('blockdev-add',
-                               node_name='node-b', driver='null-co',
-                               read_zeroes=False)
-        self.assert_qmp(result, 'return', {})
+        self.vm_a.cmd('blockdev-add',
+                      node_name='node-b', driver='null-co',
+                      read_zeroes=False)
 
-        result = self.vm_b.qmp('blockdev-add',
-                               node_name='node-a', driver='null-co',
-                               read_zeroes=False)
-        self.assert_qmp(result, 'return', {})
+        self.vm_b.cmd('blockdev-add',
+                      node_name='node-a', driver='null-co',
+                      read_zeroes=False)
 
         bmaps_to_add = (('node-a', 'bmap-b'),
                         ('node-b', 'bmap-a'),
                         ('node-b', 'bmap-b'))
 
         for (node, bmap) in bmaps_to_add:
-            result = self.vm_a.qmp('block-dirty-bitmap-add',
-                                   node=node, name=bmap)
-            self.assert_qmp(result, 'return', {})
+            self.vm_a.cmd('block-dirty-bitmap-add',
+                          node=node, name=bmap)
 
     @staticmethod
     def transform_mapping() -> BlockBitmapMapping:
diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index f43814e802..e5c5798c71 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -1252,8 +1252,7 @@ def assert_json_filename_equal(self, json_filename, reference):
     def cancel_and_wait(self, drive='drive0', force=False,
                         resume=False, wait=60.0):
         '''Cancel a block job and wait for it to finish, returning the event'''
-        result = self.vm.qmp('block-job-cancel', device=drive, force=force)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('block-job-cancel', device=drive, force=force)
 
         if resume:
             self.vm.resume_drive(drive)
@@ -1315,8 +1314,7 @@ def complete_and_wait(self, drive='drive0', wait_ready=True,
         if wait_ready:
             self.wait_ready(drive=drive)
 
-        result = self.vm.qmp('block-job-complete', device=drive)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('block-job-complete', device=drive)
 
         event = self.wait_until_completed(drive=drive, error=completion_error)
         self.assertTrue(event['data']['type'] in ['mirror', 'commit'])
@@ -1335,8 +1333,7 @@ def pause_wait(self, job_id='job0'):
                 assert found
 
     def pause_job(self, job_id='job0', wait=True):
-        result = self.vm.qmp('block-job-pause', device=job_id)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('block-job-pause', device=job_id)
         if wait:
             self.pause_wait(job_id)
 
diff --git a/tests/qemu-iotests/tests/backing-file-invalidation b/tests/qemu-iotests/tests/backing-file-invalidation
index 4eccc80153..b0e19839db 100755
--- a/tests/qemu-iotests/tests/backing-file-invalidation
+++ b/tests/qemu-iotests/tests/backing-file-invalidation
@@ -129,12 +129,11 @@ class TestPostMigrateFilename(iotests.QMPTestCase):
 
         # For good measure, try creating an overlay and check its backing
         # chain below.  This is how the issue was originally found.
-        result = self.vm_d.qmp('blockdev-snapshot-sync',
-                               format=iotests.imgfmt,
-                               snapshot_file=imgs[3],
-                               node_name='node0',
-                               snapshot_node_name='node0-overlay')
-        self.assert_qmp(result, 'return', {})
+        self.vm_d.cmd('blockdev-snapshot-sync',
+                      format=iotests.imgfmt,
+                      snapshot_file=imgs[3],
+                      node_name='node0',
+                      snapshot_node_name='node0-overlay')
 
         self.vm_d.shutdown()
         self.vm_d = None
diff --git a/tests/qemu-iotests/tests/copy-before-write b/tests/qemu-iotests/tests/copy-before-write
index d3987db942..d33bea577d 100755
--- a/tests/qemu-iotests/tests/copy-before-write
+++ b/tests/qemu-iotests/tests/copy-before-write
@@ -48,7 +48,7 @@ class TestCbwError(iotests.QMPTestCase):
         self.vm.launch()
 
     def do_cbw_error(self, on_cbw_error):
-        result = self.vm.qmp('blockdev-add', {
+        self.vm.cmd('blockdev-add', {
             'node-name': 'cbw',
             'driver': 'copy-before-write',
             'on-cbw-error': on_cbw_error,
@@ -78,14 +78,12 @@ class TestCbwError(iotests.QMPTestCase):
                 }
             }
         })
-        self.assert_qmp(result, 'return', {})
 
-        result = self.vm.qmp('blockdev-add', {
+        self.vm.cmd('blockdev-add', {
             'node-name': 'access',
             'driver': 'snapshot-access',
             'file': 'cbw'
         })
-        self.assert_qmp(result, 'return', {})
 
         result = self.vm.qmp('human-monitor-command',
                              command_line='qemu-io cbw "write 0 1M"')
@@ -129,14 +127,13 @@ read 1048576/1048576 bytes at offset 0
 """)
 
     def do_cbw_timeout(self, on_cbw_error):
-        result = self.vm.qmp('object-add', {
+        self.vm.cmd('object-add', {
             'qom-type': 'throttle-group',
             'id': 'group0',
             'limits': {'bps-write': 300 * 1024}
         })
-        self.assert_qmp(result, 'return', {})
 
-        result = self.vm.qmp('blockdev-add', {
+        self.vm.cmd('blockdev-add', {
             'node-name': 'cbw',
             'driver': 'copy-before-write',
             'on-cbw-error': on_cbw_error,
@@ -160,14 +157,12 @@ read 1048576/1048576 bytes at offset 0
                 }
             }
         })
-        self.assert_qmp(result, 'return', {})
 
-        result = self.vm.qmp('blockdev-add', {
+        self.vm.cmd('blockdev-add', {
             'node-name': 'access',
             'driver': 'snapshot-access',
             'file': 'cbw'
         })
-        self.assert_qmp(result, 'return', {})
 
         result = self.vm.qmp('human-monitor-command',
                              command_line='qemu-io cbw "write 0 512K"')
diff --git a/tests/qemu-iotests/tests/export-incoming-iothread b/tests/qemu-iotests/tests/export-incoming-iothread
index 7679e49103..d36d6194e0 100755
--- a/tests/qemu-iotests/tests/export-incoming-iothread
+++ b/tests/qemu-iotests/tests/export-incoming-iothread
@@ -55,7 +55,7 @@ class TestExportIncomingIothread(iotests.QMPTestCase):
         os.remove(test_img)
 
     def test_export_add(self):
-        result = self.vm.qmp('nbd-server-start', {
+        self.vm.cmd('nbd-server-start', {
             'addr': {
                 'type': 'unix',
                 'data': {
@@ -63,16 +63,14 @@ class TestExportIncomingIothread(iotests.QMPTestCase):
                 }
             }
         })
-        self.assert_qmp(result, 'return', {})
 
         # Regression test for issue 945: This should not fail an assertion
-        result = self.vm.qmp('block-export-add', {
+        self.vm.cmd('block-export-add', {
             'type': 'nbd',
             'id': 'exp0',
             'node-name': node_name,
             'iothread': iothread_id
         })
-        self.assert_qmp(result, 'return', {})
 
 
 if __name__ == '__main__':
diff --git a/tests/qemu-iotests/tests/graph-changes-while-io b/tests/qemu-iotests/tests/graph-changes-while-io
index 750e7d4d38..194fda500e 100755
--- a/tests/qemu-iotests/tests/graph-changes-while-io
+++ b/tests/qemu-iotests/tests/graph-changes-while-io
@@ -66,7 +66,7 @@ class TestGraphChangesWhileIO(QMPTestCase):
         # While qemu-img bench is running, repeatedly add and remove an
         # overlay to/from node0
         while bench_thr.is_alive():
-            result = self.qsd.qmp('blockdev-add', {
+            self.qsd.cmd('blockdev-add', {
                 'driver': imgfmt,
                 'node-name': 'overlay',
                 'backing': 'node0',
@@ -75,12 +75,10 @@ class TestGraphChangesWhileIO(QMPTestCase):
                     'filename': top
                 }
             })
-            self.assert_qmp(result, 'return', {})
 
-            result = self.qsd.qmp('blockdev-del', {
+            self.qsd.cmd('blockdev-del', {
                 'node-name': 'overlay'
             })
-            self.assert_qmp(result, 'return', {})
 
         bench_thr.join()
 
@@ -92,7 +90,7 @@ class TestGraphChangesWhileIO(QMPTestCase):
         qemu_io('-c', 'write 0 64k', top)
         qemu_io('-c', 'write 128k 64k', top)
 
-        result = self.qsd.qmp('blockdev-add', {
+        self.qsd.cmd('blockdev-add', {
             'driver': imgfmt,
             'node-name': 'overlay',
             'backing': None,
@@ -101,26 +99,22 @@ class TestGraphChangesWhileIO(QMPTestCase):
                 'filename': top
             }
         })
-        self.assert_qmp(result, 'return', {})
 
-        result = self.qsd.qmp('blockdev-snapshot', {
+        self.qsd.cmd('blockdev-snapshot', {
             'node': 'node0',
             'overlay': 'overlay',
         })
-        self.assert_qmp(result, 'return', {})
 
         # While qemu-img bench is running, repeatedly commit overlay to node0
         while bench_thr.is_alive():
-            result = self.qsd.qmp('block-commit', {
+            self.qsd.cmd('block-commit', {
                 'job-id': 'job0',
                 'device': 'overlay',
             })
-            self.assert_qmp(result, 'return', {})
 
-            result = self.qsd.qmp('block-job-cancel', {
+            self.qsd.cmd('block-job-cancel', {
                 'device': 'job0',
             })
-            self.assert_qmp(result, 'return', {})
 
             cancelled = False
             while not cancelled:
diff --git a/tests/qemu-iotests/tests/image-fleecing b/tests/qemu-iotests/tests/image-fleecing
index f6e449d071..5e3b2c7e46 100755
--- a/tests/qemu-iotests/tests/image-fleecing
+++ b/tests/qemu-iotests/tests/image-fleecing
@@ -213,8 +213,7 @@ def do_test(vm, use_cbw, use_snapshot_access_filter, base_img_path,
         result = vm.qmp('query-block-jobs')
         assert len(result['return']) == 1
 
-        result = vm.qmp('block-job-set-speed', device='push-backup', speed=0)
-        assert result == {'return': {}}
+        vm.cmd('block-job-set-speed', device='push-backup', speed=0)
 
         log(vm.event_wait(name='BLOCK_JOB_COMPLETED',
                           match={'data': {'device': 'push-backup'}}),
diff --git a/tests/qemu-iotests/tests/migrate-bitmaps-postcopy-test b/tests/qemu-iotests/tests/migrate-bitmaps-postcopy-test
index dda55fad28..c519e6db8c 100755
--- a/tests/qemu-iotests/tests/migrate-bitmaps-postcopy-test
+++ b/tests/qemu-iotests/tests/migrate-bitmaps-postcopy-test
@@ -118,11 +118,10 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
     def start_postcopy(self):
         """ Run migration until RESUME event on target. Return this event. """
         for i in range(nb_bitmaps):
-            result = self.vm_a.qmp('block-dirty-bitmap-add', node='drive0',
-                                   name='bitmap{}'.format(i),
-                                   granularity=granularity,
-                                   persistent=True)
-            self.assert_qmp(result, 'return', {})
+            self.vm_a.cmd('block-dirty-bitmap-add', node='drive0',
+                          name='bitmap{}'.format(i),
+                          granularity=granularity,
+                          persistent=True)
 
         result = self.vm_a.qmp('x-debug-block-dirty-bitmap-sha256',
                                node='drive0', name='bitmap0')
@@ -140,9 +139,8 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
         # We want to calculate resulting sha256. Do it in bitmap0, so, disable
         # other bitmaps
         for i in range(1, nb_bitmaps):
-            result = self.vm_a.qmp('block-dirty-bitmap-disable', node='drive0',
-                                   name='bitmap{}'.format(i))
-            self.assert_qmp(result, 'return', {})
+            self.vm_a.cmd('block-dirty-bitmap-disable', node='drive0',
+                          name='bitmap{}'.format(i))
 
         apply_discards(self.vm_a, discards2)
 
@@ -152,24 +150,19 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
 
         # Now, enable some bitmaps, to be updated during migration
         for i in range(2, nb_bitmaps, 2):
-            result = self.vm_a.qmp('block-dirty-bitmap-enable', node='drive0',
-                                   name='bitmap{}'.format(i))
-            self.assert_qmp(result, 'return', {})
+            self.vm_a.cmd('block-dirty-bitmap-enable', node='drive0',
+                          name='bitmap{}'.format(i))
 
         caps = [{'capability': 'dirty-bitmaps', 'state': True},
                 {'capability': 'events', 'state': True}]
 
-        result = self.vm_a.qmp('migrate-set-capabilities', capabilities=caps)
-        self.assert_qmp(result, 'return', {})
+        self.vm_a.cmd('migrate-set-capabilities', capabilities=caps)
 
-        result = self.vm_b.qmp('migrate-set-capabilities', capabilities=caps)
-        self.assert_qmp(result, 'return', {})
+        self.vm_b.cmd('migrate-set-capabilities', capabilities=caps)
 
-        result = self.vm_a.qmp('migrate', uri='exec:cat>' + fifo)
-        self.assert_qmp(result, 'return', {})
+        self.vm_a.cmd('migrate', uri='exec:cat>' + fifo)
 
-        result = self.vm_a.qmp('migrate-start-postcopy')
-        self.assert_qmp(result, 'return', {})
+        self.vm_a.cmd('migrate-start-postcopy')
 
         event_resume = self.vm_b.event_wait('RESUME')
         self.vm_b_events.append(event_resume)
diff --git a/tests/qemu-iotests/tests/migrate-bitmaps-test b/tests/qemu-iotests/tests/migrate-bitmaps-test
index eebb256485..f98e721e97 100755
--- a/tests/qemu-iotests/tests/migrate-bitmaps-test
+++ b/tests/qemu-iotests/tests/migrate-bitmaps-test
@@ -67,8 +67,7 @@ class TestDirtyBitmapMigration(iotests.QMPTestCase):
         if persistent:
             params['persistent'] = True
 
-        result = vm.qmp('block-dirty-bitmap-add', params)
-        self.assert_qmp(result, 'return', {})
+        vm.cmd('block-dirty-bitmap-add', params)
 
     def check_bitmap(self, vm, sha256):
         result = vm.qmp('x-debug-block-dirty-bitmap-sha256',
@@ -91,17 +90,15 @@ class TestDirtyBitmapMigration(iotests.QMPTestCase):
         if migrate_bitmaps:
             mig_caps.append({'capability': 'dirty-bitmaps', 'state': True})
 
-        result = self.vm_a.qmp('migrate-set-capabilities',
-                               capabilities=mig_caps)
-        self.assert_qmp(result, 'return', {})
+        self.vm_a.cmd('migrate-set-capabilities',
+                      capabilities=mig_caps)
 
         self.add_bitmap(self.vm_a, granularity, persistent)
         for r in regions:
             self.vm_a.hmp_qemu_io('drive0', 'write %d %d' % r)
         sha256 = get_bitmap_hash(self.vm_a)
 
-        result = self.vm_a.qmp('migrate', uri=mig_cmd)
-        self.assert_qmp(result, 'return', {})
+        self.vm_a.cmd('migrate', uri=mig_cmd)
         while True:
             event = self.vm_a.event_wait('MIGRATION')
             if event['data']['status'] == 'completed':
@@ -115,8 +112,7 @@ class TestDirtyBitmapMigration(iotests.QMPTestCase):
         removed = (not migrate_bitmaps) and persistent
         self.check_bitmap(self.vm_a, False if removed else sha256)
 
-        result = self.vm_a.qmp('cont')
-        self.assert_qmp(result, 'return', {})
+        self.vm_a.cmd('cont')
 
         # test that bitmap is still here after invalidation
         self.check_bitmap(self.vm_a, sha256)
@@ -159,9 +155,8 @@ class TestDirtyBitmapMigration(iotests.QMPTestCase):
         if online:
             os.mkfifo(mig_file)
             self.vm_b.launch()
-            result = self.vm_b.qmp('migrate-set-capabilities',
-                                   capabilities=mig_caps)
-            self.assert_qmp(result, 'return', {})
+            self.vm_b.cmd('migrate-set-capabilities',
+                          capabilities=mig_caps)
 
         self.add_bitmap(self.vm_a, granularity, persistent)
         for r in regions:
@@ -172,12 +167,10 @@ class TestDirtyBitmapMigration(iotests.QMPTestCase):
             self.vm_a.shutdown()
             self.vm_a.launch()
 
-        result = self.vm_a.qmp('migrate-set-capabilities',
-                               capabilities=mig_caps)
-        self.assert_qmp(result, 'return', {})
+        self.vm_a.cmd('migrate-set-capabilities',
+                      capabilities=mig_caps)
 
-        result = self.vm_a.qmp('migrate', uri=mig_cmd)
-        self.assert_qmp(result, 'return', {})
+        self.vm_a.cmd('migrate', uri=mig_cmd)
         while True:
             event = self.vm_a.event_wait('MIGRATION')
             if event['data']['status'] == 'completed':
@@ -186,11 +179,9 @@ class TestDirtyBitmapMigration(iotests.QMPTestCase):
         if not online:
             self.vm_a.shutdown()
             self.vm_b.launch()
-            result = self.vm_b.qmp('migrate-set-capabilities',
-                                   capabilities=mig_caps)
-            self.assert_qmp(result, 'return', {})
-            result = self.vm_b.qmp('migrate-incoming', uri=incoming_cmd)
-            self.assert_qmp(result, 'return', {})
+            self.vm_b.cmd('migrate-set-capabilities',
+                          capabilities=mig_caps)
+            self.vm_b.cmd('migrate-incoming', uri=incoming_cmd)
 
         while True:
             event = self.vm_b.event_wait('MIGRATION')
@@ -256,8 +247,7 @@ class TestDirtyBitmapBackingMigration(iotests.QMPTestCase):
         self.vm = iotests.VM()
         self.vm.launch()
 
-        result = self.vm.qmp('blockdev-add', blockdev)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-add', blockdev)
 
         # Check that the bitmaps are there
         nodes = self.vm.qmp('query-named-block-nodes', flat=True)['return']
@@ -266,8 +256,7 @@ class TestDirtyBitmapBackingMigration(iotests.QMPTestCase):
                 self.assert_qmp(node, 'dirty-bitmaps[0]/name', 'bmap0')
 
         caps = [{'capability': 'events', 'state': True}]
-        result = self.vm.qmp('migrate-set-capabilities', capabilities=caps)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('migrate-set-capabilities', capabilities=caps)
 
     def tearDown(self):
         self.vm.shutdown()
@@ -278,14 +267,12 @@ class TestDirtyBitmapBackingMigration(iotests.QMPTestCase):
         """
         Continue the source after migration.
         """
-        result = self.vm.qmp('migrate', uri='exec: cat > /dev/null')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('migrate', uri='exec: cat > /dev/null')
 
         with Timeout(10, 'Migration timeout'):
             self.vm.wait_migration('postmigrate')
 
-        result = self.vm.qmp('cont')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('cont')
 
 
 def main() -> None:
diff --git a/tests/qemu-iotests/tests/migrate-during-backup b/tests/qemu-iotests/tests/migrate-during-backup
index 34103229ee..afb2277896 100755
--- a/tests/qemu-iotests/tests/migrate-during-backup
+++ b/tests/qemu-iotests/tests/migrate-during-backup
@@ -43,7 +43,7 @@ class TestMigrateDuringBackup(iotests.QMPTestCase):
 
         self.vm = iotests.VM().add_drive(disk_a)
         self.vm.launch()
-        result = self.vm.qmp('blockdev-add', {
+        self.vm.cmd('blockdev-add', {
             'node-name': 'target',
             'driver': iotests.imgfmt,
             'file': {
@@ -51,26 +51,21 @@ class TestMigrateDuringBackup(iotests.QMPTestCase):
                 'filename': disk_b
             }
         })
-        self.assert_qmp(result, 'return', {})
 
     def test_migrate(self):
-        result = self.vm.qmp('blockdev-backup', device='drive0',
-                             target='target', sync='full',
-                             speed=1, x_perf={
-                                 'max-workers': 1,
-                                 'max-chunk': 64 * 1024
-                             })
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-backup', device='drive0',
+                    target='target', sync='full',
+                    speed=1, x_perf={
+                        'max-workers': 1,
+                        'max-chunk': 64 * 1024
+                    })
 
-        result = self.vm.qmp('job-pause', id='drive0')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('job-pause', id='drive0')
 
-        result = self.vm.qmp('migrate-set-capabilities',
-                             capabilities=[{'capability': 'events',
-                                            'state': True}])
-        self.assert_qmp(result, 'return', {})
-        result = self.vm.qmp('migrate', uri=mig_cmd)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('migrate-set-capabilities',
+                    capabilities=[{'capability': 'events',
+                                   'state': True}])
+        self.vm.cmd('migrate', uri=mig_cmd)
 
         e = self.vm.events_wait((('MIGRATION',
                                   {'data': {'status': 'completed'}}),
@@ -80,11 +75,9 @@ class TestMigrateDuringBackup(iotests.QMPTestCase):
         # Don't assert that e is 'failed' now: this way we'll miss
         # possible crash when backup continues :)
 
-        result = self.vm.qmp('block-job-set-speed', device='drive0',
-                             speed=0)
-        self.assert_qmp(result, 'return', {})
-        result = self.vm.qmp('job-resume', id='drive0')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('block-job-set-speed', device='drive0',
+                    speed=0)
+        self.vm.cmd('job-resume', id='drive0')
 
         # For future: if something changes so that both migration
         # and backup pass, let's not miss that moment, as it may
diff --git a/tests/qemu-iotests/tests/migration-permissions b/tests/qemu-iotests/tests/migration-permissions
index 4e1da369c9..0deaad2d3a 100755
--- a/tests/qemu-iotests/tests/migration-permissions
+++ b/tests/qemu-iotests/tests/migration-permissions
@@ -47,11 +47,10 @@ class TestMigrationPermissions(iotests.QMPTestCase):
 
             vms[i].launch()
 
-            result = vms[i].qmp('migrate-set-capabilities',
-                                capabilities=[
-                                    {'capability': 'events', 'state': True}
-                                ])
-            self.assert_qmp(result, 'return', {})
+            vms[i].cmd('migrate-set-capabilities',
+                       capabilities=[
+                           {'capability': 'events', 'state': True}
+                       ])
 
         self.vm_s = vms[0]
         self.vm_d = vms[1]
diff --git a/tests/qemu-iotests/tests/mirror-ready-cancel-error b/tests/qemu-iotests/tests/mirror-ready-cancel-error
index a59e245659..ed2e46447e 100755
--- a/tests/qemu-iotests/tests/mirror-ready-cancel-error
+++ b/tests/qemu-iotests/tests/mirror-ready-cancel-error
@@ -48,51 +48,48 @@ class TestMirrorReadyCancelError(iotests.QMPTestCase):
         os.remove(target)
 
     def add_blockdevs(self, once: bool) -> None:
-        res = self.vm.qmp('blockdev-add',
-                          {'node-name': 'source',
-                           'driver': iotests.imgfmt,
-                           'file': {
-                               'driver': 'file',
-                               'filename': source
-                           }})
-        self.assert_qmp(res, 'return', {})
+        self.vm.cmd('blockdev-add',
+                    {'node-name': 'source',
+                     'driver': iotests.imgfmt,
+                     'file': {
+                         'driver': 'file',
+                         'filename': source
+                     }})
 
         # blkdebug notes:
         # Enter state 2 on the first flush, which happens before the
         # job enters the READY state.  The second flush will happen
         # when the job is about to complete, and we want that one to
         # fail.
-        res = self.vm.qmp('blockdev-add',
-                          {'node-name': 'target',
-                           'driver': iotests.imgfmt,
-                           'file': {
-                               'driver': 'blkdebug',
-                               'image': {
-                                   'driver': 'file',
-                                   'filename': target
-                               },
-                               'set-state': [{
-                                   'event': 'flush_to_disk',
-                                   'state': 1,
-                                   'new_state': 2
-                               }],
-                               'inject-error': [{
-                                   'event': 'flush_to_disk',
-                                   'once': once,
-                                   'immediately': True,
-                                   'state': 2
-                               }]}})
-        self.assert_qmp(res, 'return', {})
+        self.vm.cmd('blockdev-add',
+                    {'node-name': 'target',
+                     'driver': iotests.imgfmt,
+                     'file': {
+                         'driver': 'blkdebug',
+                         'image': {
+                             'driver': 'file',
+                             'filename': target
+                         },
+                         'set-state': [{
+                             'event': 'flush_to_disk',
+                             'state': 1,
+                             'new_state': 2
+                         }],
+                         'inject-error': [{
+                             'event': 'flush_to_disk',
+                             'once': once,
+                             'immediately': True,
+                             'state': 2
+                         }]}})
 
     def start_mirror(self) -> None:
-        res = self.vm.qmp('blockdev-mirror',
-                          job_id='mirror',
-                          device='source',
-                          target='target',
-                          filter_node_name='mirror-top',
-                          sync='full',
-                          on_target_error='stop')
-        self.assert_qmp(res, 'return', {})
+        self.vm.cmd('blockdev-mirror',
+                    job_id='mirror',
+                    device='source',
+                    target='target',
+                    filter_node_name='mirror-top',
+                    sync='full',
+                    on_target_error='stop')
 
     def cancel_mirror_with_error(self) -> None:
         self.vm.event_wait('BLOCK_JOB_READY')
@@ -107,8 +104,7 @@ class TestMirrorReadyCancelError(iotests.QMPTestCase):
         while self.vm.event_wait('JOB_STATUS_CHANGE', timeout=0.0) is not None:
             pass
 
-        res = self.vm.qmp('block-job-cancel', device='mirror')
-        self.assert_qmp(res, 'return', {})
+        self.vm.cmd('block-job-cancel', device='mirror')
 
         self.vm.event_wait('BLOCK_JOB_ERROR')
 
diff --git a/tests/qemu-iotests/tests/mirror-top-perms b/tests/qemu-iotests/tests/mirror-top-perms
index 8bca592708..fab9907e92 100755
--- a/tests/qemu-iotests/tests/mirror-top-perms
+++ b/tests/qemu-iotests/tests/mirror-top-perms
@@ -78,12 +78,11 @@ class TestMirrorTopPerms(iotests.QMPTestCase):
         difficult to let some other qemu process open the image.)
         """
 
-        result = self.vm.qmp('blockdev-mirror',
-                             job_id='mirror',
-                             device='drive0',
-                             target='null',
-                             sync='full')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('blockdev-mirror',
+                    job_id='mirror',
+                    device='drive0',
+                    target='null',
+                    sync='full')
 
         self.vm.event_wait('BLOCK_JOB_READY')
 
@@ -105,9 +104,8 @@ class TestMirrorTopPerms(iotests.QMPTestCase):
         except machine.VMLaunchFailure as exc:
             assert 'Is another process using the image' in exc.output
 
-        result = self.vm.qmp('block-job-cancel',
-                             device='mirror')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('block-job-cancel',
+                    device='mirror')
 
         self.vm.event_wait('BLOCK_JOB_COMPLETED')
 
diff --git a/tests/qemu-iotests/tests/nbd-multiconn b/tests/qemu-iotests/tests/nbd-multiconn
index 7e686a786e..479e872f2a 100755
--- a/tests/qemu-iotests/tests/nbd-multiconn
+++ b/tests/qemu-iotests/tests/nbd-multiconn
@@ -48,12 +48,11 @@ class TestNbdMulticonn(iotests.QMPTestCase):
 
         self.vm = iotests.VM()
         self.vm.launch()
-        result = self.vm.qmp('blockdev-add', {
+        self.vm.cmd('blockdev-add', {
             'driver': 'qcow2',
             'node-name': 'n',
             'file': {'driver': 'file', 'filename': disk}
         })
-        self.assert_qmp(result, 'return', {})
 
     def tearDown(self):
         self.vm.shutdown()
@@ -74,12 +73,10 @@ class TestNbdMulticonn(iotests.QMPTestCase):
         if max_connections is not None:
             args['max-connections'] = max_connections
 
-        result = self.vm.qmp('nbd-server-start', args)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('nbd-server-start', args)
         yield
 
-        result = self.vm.qmp('nbd-server-stop')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('nbd-server-stop')
 
     def add_export(self, name, writable=None):
         args = {
@@ -91,8 +88,7 @@ class TestNbdMulticonn(iotests.QMPTestCase):
         if writable is not None:
             args['writable'] = writable
 
-        result = self.vm.qmp('block-export-add', args)
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('block-export-add', args)
 
     def test_default_settings(self):
         with self.run_server():
diff --git a/tests/qemu-iotests/tests/reopen-file b/tests/qemu-iotests/tests/reopen-file
index 8590a94d53..5a50794ffc 100755
--- a/tests/qemu-iotests/tests/reopen-file
+++ b/tests/qemu-iotests/tests/reopen-file
@@ -64,12 +64,11 @@ class TestReopenFile(QMPTestCase):
             self.fail('qemu-io pattern verification failed')
 
     def test_reopen_file(self) -> None:
-        result = self.vm.qmp('blockdev-reopen', options=[{
+        self.vm.cmd('blockdev-reopen', options=[{
             'driver': imgfmt,
             'node-name': 'format',
             'file': 'raw'
         }])
-        self.assert_qmp(result, 'return', {})
 
         # Do some I/O to the image to see whether it still works
         # (Pattern verification will be checked by tearDown())
diff --git a/tests/qemu-iotests/tests/stream-error-on-reset b/tests/qemu-iotests/tests/stream-error-on-reset
index 5a8c3a9e8d..b60aabb68e 100755
--- a/tests/qemu-iotests/tests/stream-error-on-reset
+++ b/tests/qemu-iotests/tests/stream-error-on-reset
@@ -115,8 +115,7 @@ class TestStreamErrorOnReset(QMPTestCase):
         # Launch a stream job, which will take at least a second to
         # complete, because the base image is throttled (so we can
         # get in between it having started and it having completed)
-        res = self.vm.qmp('block-stream', job_id='stream', device='top')
-        self.assert_qmp(res, 'return', {})
+        self.vm.cmd('block-stream', job_id='stream', device='top')
 
         while True:
             ev = self.vm.event_wait('JOB_STATUS_CHANGE')
@@ -125,8 +124,7 @@ class TestStreamErrorOnReset(QMPTestCase):
                 # forces the virtio-scsi device to be reset, thus draining
                 # the stream job, and making it complete.  Completing
                 # inside of that drain should not result in a segfault.
-                res = self.vm.qmp('system_reset')
-                self.assert_qmp(res, 'return', {})
+                self.vm.cmd('system_reset')
             elif ev['data']['status'] == 'null':
                 # The test is done once the job is gone
                 break
diff --git a/tests/qemu-iotests/tests/stream-under-throttle b/tests/qemu-iotests/tests/stream-under-throttle
index c24dfbcaa2..1a50b682fc 100755
--- a/tests/qemu-iotests/tests/stream-under-throttle
+++ b/tests/qemu-iotests/tests/stream-under-throttle
@@ -102,10 +102,9 @@ class TestStreamWithThrottle(iotests.QMPTestCase):
         Do a simple stream beneath the two throttle nodes.  Should complete
         with no problems.
         '''
-        result = self.vm.qmp('block-stream',
-                             job_id='stream',
-                             device='unthrottled-node')
-        self.assert_qmp(result, 'return', {})
+        self.vm.cmd('block-stream',
+                    job_id='stream',
+                    device='unthrottled-node')
 
         # Should succeed and not time out
         try:
-- 
2.41.0


