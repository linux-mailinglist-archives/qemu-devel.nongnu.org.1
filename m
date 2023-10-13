Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B0C7C8D84
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 21:11:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrNYN-00071X-1d; Fri, 13 Oct 2023 15:10:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qrNYK-0006xJ-9H
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 15:10:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qrNY5-0001tI-4K
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 15:10:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697224210;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fRbQdUoUUQhlqnazahcRbiRmsy6tNXpHFEKPBYJkfGM=;
 b=C35rhV/9tYX+fGmS7ejOM1osjwUPHF5kXEb9tWRYBNfblKCmoGM81zxMZK492rUrVboU28
 Tr7b1c3Nav50ZjLBnUmowIANwLOMUdUYHPRPkoExcS1IpXxnkOMBEEKpaluguulccWmCz4
 XAc4QdQ2S4uS2w6JjeHPaC0VIKtlKc8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-138-rH71-VLmP0inEv2-a89V9w-1; Fri, 13 Oct 2023 15:10:09 -0400
X-MC-Unique: rH71-VLmP0inEv2-a89V9w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0F1AB85A5BA;
 Fri, 13 Oct 2023 19:10:08 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.32.124])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D495040C6CA0;
 Fri, 13 Oct 2023 19:10:06 +0000 (UTC)
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
Subject: [PULL 19/25] iotests: refactor some common qmp result checks into
 generic pattern
Date: Fri, 13 Oct 2023 15:09:34 -0400
Message-ID: <20231013190941.3699288-20-jsnow@redhat.com>
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

To simplify further conversion.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-id: 20231006154125.1068348-10-vsementsov@yandex-team.ru
Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/qemu-iotests/040 | 3 ++-
 tests/qemu-iotests/147 | 3 ++-
 tests/qemu-iotests/155 | 4 ++--
 tests/qemu-iotests/218 | 4 ++--
 tests/qemu-iotests/296 | 3 ++-
 5 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/tests/qemu-iotests/040 b/tests/qemu-iotests/040
index 5601a4873c..e61e7f2433 100755
--- a/tests/qemu-iotests/040
+++ b/tests/qemu-iotests/040
@@ -62,9 +62,10 @@ class ImageCommitTestCase(iotests.QMPTestCase):
         self.assert_no_active_block_jobs()
         if node_names:
             result = self.vm.qmp('block-commit', device='drive0', top_node=top, base_node=base)
+            self.assert_qmp(result, 'return', {})
         else:
             result = self.vm.qmp('block-commit', device='drive0', top=top, base=base)
-        self.assert_qmp(result, 'return', {})
+            self.assert_qmp(result, 'return', {})
         self.wait_for_complete(need_ready)
 
     def run_default_commit_test(self):
diff --git a/tests/qemu-iotests/147 b/tests/qemu-iotests/147
index 47dfa62e6b..770b73e2f4 100755
--- a/tests/qemu-iotests/147
+++ b/tests/qemu-iotests/147
@@ -159,10 +159,11 @@ class BuiltinNBD(NBDBlockdevAddBase):
 
         if export_name is None:
             result = self.server.qmp('nbd-server-add', device='nbd-export')
+            self.assert_qmp(result, 'return', {})
         else:
             result = self.server.qmp('nbd-server-add', device='nbd-export',
                                      name=export_name)
-        self.assert_qmp(result, 'return', {})
+            self.assert_qmp(result, 'return', {})
 
         if export_name2 is not None:
             result = self.server.qmp('nbd-server-add', device='nbd-export',
diff --git a/tests/qemu-iotests/155 b/tests/qemu-iotests/155
index eadda52615..d3e1b7401e 100755
--- a/tests/qemu-iotests/155
+++ b/tests/qemu-iotests/155
@@ -181,6 +181,7 @@ class MirrorBaseClass(BaseClass):
             result = self.vm.qmp(self.cmd, job_id='mirror-job', device='source',
                                  sync=sync, target='target',
                                  auto_finalize=False)
+            self.assert_qmp(result, 'return', {})
         else:
             if self.existing:
                 mode = 'existing'
@@ -190,8 +191,7 @@ class MirrorBaseClass(BaseClass):
                                  sync=sync, target=target_img,
                                  format=iotests.imgfmt, mode=mode,
                                  node_name='target', auto_finalize=False)
-
-        self.assert_qmp(result, 'return', {})
+            self.assert_qmp(result, 'return', {})
 
         self.vm.run_job('mirror-job', auto_finalize=False,
                         pre_finalize=self.openBacking, auto_dismiss=True)
diff --git a/tests/qemu-iotests/218 b/tests/qemu-iotests/218
index 6320c4cb56..5e74c55b6a 100755
--- a/tests/qemu-iotests/218
+++ b/tests/qemu-iotests/218
@@ -61,14 +61,14 @@ def start_mirror(vm, speed=None, buf_size=None):
                          sync='full',
                          speed=speed,
                          buf_size=buf_size)
+        assert ret['return'] == {}
     else:
         ret = vm.qmp('blockdev-mirror',
                          job_id='mirror',
                          device='source',
                          target='target',
                          sync='full')
-
-    assert ret['return'] == {}
+        assert ret['return'] == {}
 
 
 log('')
diff --git a/tests/qemu-iotests/296 b/tests/qemu-iotests/296
index 0d21b740a7..19a674c5ae 100755
--- a/tests/qemu-iotests/296
+++ b/tests/qemu-iotests/296
@@ -133,9 +133,10 @@ class EncryptionSetupTestCase(iotests.QMPTestCase):
 
         if reOpen:
             result = vm.qmp(command, options=[opts])
+            self.assert_qmp(result, 'return', {})
         else:
             result = vm.qmp(command, **opts)
-        self.assert_qmp(result, 'return', {})
+            self.assert_qmp(result, 'return', {})
 
 
     ###########################################################################
-- 
2.41.0


