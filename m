Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 366877C8DA0
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 21:17:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrNYp-00087R-1X; Fri, 13 Oct 2023 15:10:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qrNYV-0007JM-Is
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 15:10:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qrNYI-0001zj-Co
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 15:10:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697224225;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oa109OK3W3Uo1tZYdj4EWbflCM+wicoxKWR+Wm3G+Zk=;
 b=OkAwSEbei0lYyW7532rOElCkkuuk7tPGpngDXg5AnzI73NsWnWIms367JpcytpTQWb/7Y0
 26uylJ1157o3M6UJ0H7ZJ027hNPxlRkZ1sZt//CW59tLbl87hXcuCJiWyYygLb9Ldn4ZR+
 b68mtyym3nIajJa/v8rZS3uImlyDdns=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-526-tNIi7r6GNDK3D_TeOkP1rQ-1; Fri, 13 Oct 2023 15:10:11 -0400
X-MC-Unique: tNIi7r6GNDK3D_TeOkP1rQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9B32B3813BDB;
 Fri, 13 Oct 2023 19:10:10 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.32.124])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 65D2740C6CA0;
 Fri, 13 Oct 2023 19:10:09 +0000 (UTC)
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
Subject: [PULL 21/25] iotests: drop some extra ** in qmp() call
Date: Fri, 13 Oct 2023 15:09:36 -0400
Message-ID: <20231013190941.3699288-22-jsnow@redhat.com>
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

qmp() method supports passing dict (if it doesn't need substituting
'_' to '-' in keys). So, drop some extra '**' operators.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-id: 20231006154125.1068348-12-vsementsov@yandex-team.ru
Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/qemu-iotests/040                        |  4 +-
 tests/qemu-iotests/041                        | 14 +++---
 tests/qemu-iotests/129                        |  2 +-
 tests/qemu-iotests/147                        |  2 +-
 tests/qemu-iotests/155                        |  2 +-
 tests/qemu-iotests/264                        | 12 ++---
 tests/qemu-iotests/295                        |  5 +-
 tests/qemu-iotests/296                        | 15 +++---
 tests/qemu-iotests/tests/migrate-bitmaps-test |  4 +-
 .../tests/mirror-ready-cancel-error           | 50 +++++++++----------
 10 files changed, 54 insertions(+), 56 deletions(-)

diff --git a/tests/qemu-iotests/040 b/tests/qemu-iotests/040
index e61e7f2433..4b8bf09a5d 100755
--- a/tests/qemu-iotests/040
+++ b/tests/qemu-iotests/040
@@ -774,7 +774,7 @@ class TestCommitWithFilters(iotests.QMPTestCase):
         result = self.vm.qmp('object-add', qom_type='throttle-group', id='tg')
         self.assert_qmp(result, 'return', {})
 
-        result = self.vm.qmp('blockdev-add', **{
+        result = self.vm.qmp('blockdev-add', {
                 'node-name': 'top-filter',
                 'driver': 'throttle',
                 'throttle-group': 'tg',
@@ -935,7 +935,7 @@ class TestCommitWithOverriddenBacking(iotests.QMPTestCase):
         self.vm.launch()
 
         # Use base_b instead of base_a as the backing of top
-        result = self.vm.qmp('blockdev-add', **{
+        result = self.vm.qmp('blockdev-add', {
                                 'node-name': 'top',
                                 'driver': iotests.imgfmt,
                                 'file': {
diff --git a/tests/qemu-iotests/041 b/tests/qemu-iotests/041
index 550e4dc391..3aef42aec8 100755
--- a/tests/qemu-iotests/041
+++ b/tests/qemu-iotests/041
@@ -236,7 +236,7 @@ class TestSingleBlockdev(TestSingleDrive):
         args = {'driver': iotests.imgfmt,
                 'node-name': self.qmp_target,
                 'file': { 'filename': target_img, 'driver': 'file' } }
-        result = self.vm.qmp("blockdev-add", **args)
+        result = self.vm.qmp("blockdev-add", args)
         self.assert_qmp(result, 'return', {})
 
     def test_mirror_to_self(self):
@@ -963,7 +963,7 @@ class TestRepairQuorum(iotests.QMPTestCase):
         #assemble the quorum block device from the individual files
         args = { "driver": "quorum", "node-name": "quorum0",
                  "vote-threshold": 2, "children": [ "img0", "img1", "img2" ] }
-        result = self.vm.qmp("blockdev-add", **args)
+        result = self.vm.qmp("blockdev-add", args)
         self.assert_qmp(result, 'return', {})
 
 
@@ -1278,7 +1278,7 @@ class TestReplaces(iotests.QMPTestCase):
         """
         Check that we can replace filter nodes.
         """
-        result = self.vm.qmp('blockdev-add', **{
+        result = self.vm.qmp('blockdev-add', {
                                  'driver': 'copy-on-read',
                                  'node-name': 'filter0',
                                  'file': {
@@ -1319,7 +1319,7 @@ class TestFilters(iotests.QMPTestCase):
         self.vm = iotests.VM().add_device('virtio-scsi,id=vio-scsi')
         self.vm.launch()
 
-        result = self.vm.qmp('blockdev-add', **{
+        result = self.vm.qmp('blockdev-add', {
                                 'node-name': 'target',
                                 'driver': iotests.imgfmt,
                                 'file': {
@@ -1355,7 +1355,7 @@ class TestFilters(iotests.QMPTestCase):
         os.remove(backing_img)
 
     def test_cor(self):
-        result = self.vm.qmp('blockdev-add', **{
+        result = self.vm.qmp('blockdev-add', {
                                 'node-name': 'filter',
                                 'driver': 'copy-on-read',
                                 'file': self.filterless_chain
@@ -1384,7 +1384,7 @@ class TestFilters(iotests.QMPTestCase):
         assert target_map[1]['depth'] == 0
 
     def test_implicit_mirror_filter(self):
-        result = self.vm.qmp('blockdev-add', **self.filterless_chain)
+        result = self.vm.qmp('blockdev-add', self.filterless_chain)
         self.assert_qmp(result, 'return', {})
 
         # We need this so we can query from above the mirror node
@@ -1418,7 +1418,7 @@ class TestFilters(iotests.QMPTestCase):
     def test_explicit_mirror_filter(self):
         # Same test as above, but this time we give the mirror filter
         # a node-name so it will not be invisible
-        result = self.vm.qmp('blockdev-add', **self.filterless_chain)
+        result = self.vm.qmp('blockdev-add', self.filterless_chain)
         self.assert_qmp(result, 'return', {})
 
         # We need this so we can query from above the mirror node
diff --git a/tests/qemu-iotests/129 b/tests/qemu-iotests/129
index c75ec62ecf..e1536ee3c3 100755
--- a/tests/qemu-iotests/129
+++ b/tests/qemu-iotests/129
@@ -87,7 +87,7 @@ class TestStopWithBlockJob(iotests.QMPTestCase):
         iotests.qemu_img('create', '-f', iotests.imgfmt, self.overlay_img,
                          '1G')
 
-        result = self.vm.qmp('blockdev-add', **{
+        result = self.vm.qmp('blockdev-add', {
             'node-name': 'overlay',
             'driver': iotests.imgfmt,
             'file': {
diff --git a/tests/qemu-iotests/147 b/tests/qemu-iotests/147
index 770b73e2f4..08111c5108 100755
--- a/tests/qemu-iotests/147
+++ b/tests/qemu-iotests/147
@@ -58,7 +58,7 @@ class NBDBlockdevAddBase(iotests.QMPTestCase):
     def client_test(self, filename, address, export=None,
                     node_name='nbd-blockdev', delete=True):
         bao = self.blockdev_add_options(address, export, node_name)
-        result = self.vm.qmp('blockdev-add', **bao)
+        result = self.vm.qmp('blockdev-add', bao)
         self.assert_qmp(result, 'return', {})
 
         found = False
diff --git a/tests/qemu-iotests/155 b/tests/qemu-iotests/155
index d3e1b7401e..0c073fd61b 100755
--- a/tests/qemu-iotests/155
+++ b/tests/qemu-iotests/155
@@ -110,7 +110,7 @@ class BaseClass(iotests.QMPTestCase):
                 elif self.target_blockdev_backing:
                         options['backing'] = self.target_blockdev_backing
 
-                result = self.vm.qmp('blockdev-add', **options)
+                result = self.vm.qmp('blockdev-add', options)
                 self.assert_qmp(result, 'return', {})
 
     def tearDown(self):
diff --git a/tests/qemu-iotests/264 b/tests/qemu-iotests/264
index 289381e315..d44deb673a 100755
--- a/tests/qemu-iotests/264
+++ b/tests/qemu-iotests/264
@@ -49,12 +49,12 @@ class TestNbdReconnect(iotests.QMPTestCase):
         assert job in ('blockdev-backup', 'blockdev-mirror')
         with qemu_nbd_popen('-k', nbd_sock, '-f', iotests.imgfmt, disk_b):
             result = self.vm.qmp('blockdev-add',
-                                 **{'node_name': 'backup0',
-                                    'driver': 'raw',
-                                    'file': {'driver': 'nbd',
-                                             'server': {'type': 'unix',
-                                                        'path': nbd_sock},
-                                             'reconnect-delay': 10}})
+                                 {'node-name': 'backup0',
+                                  'driver': 'raw',
+                                  'file': {'driver': 'nbd',
+                                           'server': {'type': 'unix',
+                                                      'path': nbd_sock},
+                                           'reconnect-delay': 10}})
             self.assert_qmp(result, 'return', {})
             result = self.vm.qmp(job, device='drive0',
                                  sync='full', target='backup0',
diff --git a/tests/qemu-iotests/295 b/tests/qemu-iotests/295
index 270ad3999f..8ebe31054c 100755
--- a/tests/qemu-iotests/295
+++ b/tests/qemu-iotests/295
@@ -102,8 +102,7 @@ class EncryptionSetupTestCase(iotests.QMPTestCase):
                 }
             }
 
-        result = self.vm.qmp('blockdev-add', **
-            {
+        result = self.vm.qmp('blockdev-add', {
                 'driver': iotests.imgfmt,
                 'node-name': id,
                 'read-only': read_only,
@@ -120,7 +119,7 @@ class EncryptionSetupTestCase(iotests.QMPTestCase):
 
     # close the encrypted block device
     def closeImageQmp(self, id):
-        result = self.vm.qmp('blockdev-del', **{ 'node-name': id })
+        result = self.vm.qmp('blockdev-del', {'node-name': id})
         self.assert_qmp(result, 'return', {})
 
     ###########################################################################
diff --git a/tests/qemu-iotests/296 b/tests/qemu-iotests/296
index 19a674c5ae..47d2526b72 100755
--- a/tests/qemu-iotests/296
+++ b/tests/qemu-iotests/296
@@ -42,7 +42,7 @@ class Secret:
         return  [ "secret,id=" + self._id + ",data=" + self._secret]
 
     def to_qmp_object(self):
-        return { "qom_type" : "secret", "id": self.id(),
+        return { "qom-type" : "secret", "id": self.id(),
                  "data": self.secret() }
 
 ################################################################################
@@ -61,9 +61,9 @@ class EncryptionSetupTestCase(iotests.QMPTestCase):
         # create the secrets and load 'em into the VMs
         self.secrets = [ Secret(i) for i in range(0, 4) ]
         for secret in self.secrets:
-            result = self.vm1.qmp("object-add", **secret.to_qmp_object())
+            result = self.vm1.qmp("object-add", secret.to_qmp_object())
             self.assert_qmp(result, 'return', {})
-            result = self.vm2.qmp("object-add", **secret.to_qmp_object())
+            result = self.vm2.qmp("object-add", secret.to_qmp_object())
             self.assert_qmp(result, 'return', {})
 
     # test case shutdown
@@ -135,15 +135,14 @@ class EncryptionSetupTestCase(iotests.QMPTestCase):
             result = vm.qmp(command, options=[opts])
             self.assert_qmp(result, 'return', {})
         else:
-            result = vm.qmp(command, **opts)
+            result = vm.qmp(command, opts)
             self.assert_qmp(result, 'return', {})
 
 
     ###########################################################################
     # add virtio-blk consumer for a block device
     def addImageUser(self, vm, id, disk_id, share_rw=False):
-        result = vm.qmp('device_add', **
-            {
+        result = vm.qmp('device_add', {
                 'driver': 'virtio-blk',
                 'id': id,
                 'drive': disk_id,
@@ -155,7 +154,7 @@ class EncryptionSetupTestCase(iotests.QMPTestCase):
 
     # close the encrypted block device
     def closeImageQmp(self, vm, id):
-        result = vm.qmp('blockdev-del', **{ 'node-name': id })
+        result = vm.qmp('blockdev-del', {'node-name': id})
         self.assert_qmp(result, 'return', {})
 
     ###########################################################################
@@ -174,7 +173,7 @@ class EncryptionSetupTestCase(iotests.QMPTestCase):
             },
         }
 
-        result = vm.qmp('x-blockdev-amend', **args)
+        result = vm.qmp('x-blockdev-amend', args)
         iotests.log(result)
         # Run the job only if it was created
         event = ('JOB_STATUS_CHANGE',
diff --git a/tests/qemu-iotests/tests/migrate-bitmaps-test b/tests/qemu-iotests/tests/migrate-bitmaps-test
index 8668caae1e..eebb256485 100755
--- a/tests/qemu-iotests/tests/migrate-bitmaps-test
+++ b/tests/qemu-iotests/tests/migrate-bitmaps-test
@@ -67,7 +67,7 @@ class TestDirtyBitmapMigration(iotests.QMPTestCase):
         if persistent:
             params['persistent'] = True
 
-        result = vm.qmp('block-dirty-bitmap-add', **params)
+        result = vm.qmp('block-dirty-bitmap-add', params)
         self.assert_qmp(result, 'return', {})
 
     def check_bitmap(self, vm, sha256):
@@ -256,7 +256,7 @@ class TestDirtyBitmapBackingMigration(iotests.QMPTestCase):
         self.vm = iotests.VM()
         self.vm.launch()
 
-        result = self.vm.qmp('blockdev-add', **blockdev)
+        result = self.vm.qmp('blockdev-add', blockdev)
         self.assert_qmp(result, 'return', {})
 
         # Check that the bitmaps are there
diff --git a/tests/qemu-iotests/tests/mirror-ready-cancel-error b/tests/qemu-iotests/tests/mirror-ready-cancel-error
index 01217459b9..a59e245659 100755
--- a/tests/qemu-iotests/tests/mirror-ready-cancel-error
+++ b/tests/qemu-iotests/tests/mirror-ready-cancel-error
@@ -49,12 +49,12 @@ class TestMirrorReadyCancelError(iotests.QMPTestCase):
 
     def add_blockdevs(self, once: bool) -> None:
         res = self.vm.qmp('blockdev-add',
-                          **{'node-name': 'source',
-                             'driver': iotests.imgfmt,
-                             'file': {
-                                 'driver': 'file',
-                                 'filename': source
-                             }})
+                          {'node-name': 'source',
+                           'driver': iotests.imgfmt,
+                           'file': {
+                               'driver': 'file',
+                               'filename': source
+                           }})
         self.assert_qmp(res, 'return', {})
 
         # blkdebug notes:
@@ -63,25 +63,25 @@ class TestMirrorReadyCancelError(iotests.QMPTestCase):
         # when the job is about to complete, and we want that one to
         # fail.
         res = self.vm.qmp('blockdev-add',
-                          **{'node-name': 'target',
-                             'driver': iotests.imgfmt,
-                             'file': {
-                                 'driver': 'blkdebug',
-                                 'image': {
-                                     'driver': 'file',
-                                     'filename': target
-                                 },
-                                 'set-state': [{
-                                     'event': 'flush_to_disk',
-                                     'state': 1,
-                                     'new_state': 2
-                                 }],
-                                 'inject-error': [{
-                                     'event': 'flush_to_disk',
-                                     'once': once,
-                                     'immediately': True,
-                                     'state': 2
-                                 }]}})
+                          {'node-name': 'target',
+                           'driver': iotests.imgfmt,
+                           'file': {
+                               'driver': 'blkdebug',
+                               'image': {
+                                   'driver': 'file',
+                                   'filename': target
+                               },
+                               'set-state': [{
+                                   'event': 'flush_to_disk',
+                                   'state': 1,
+                                   'new_state': 2
+                               }],
+                               'inject-error': [{
+                                   'event': 'flush_to_disk',
+                                   'once': once,
+                                   'immediately': True,
+                                   'state': 2
+                               }]}})
         self.assert_qmp(res, 'return', {})
 
     def start_mirror(self) -> None:
-- 
2.41.0


