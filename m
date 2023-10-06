Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 53EBA7BBBFD
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 17:44:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qomxt-0006e7-Rx; Fri, 06 Oct 2023 11:42:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qomxr-0006cy-Ai; Fri, 06 Oct 2023 11:42:07 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qomxl-0003ak-5N; Fri, 06 Oct 2023 11:42:07 -0400
Received: from mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:3a8c:0:640:ec94:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTP id 4C86D60B29;
 Fri,  6 Oct 2023 18:41:58 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:a512::1:22])
 by mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id VfbK2W5OrKo0-qyEfj9D6; Fri, 06 Oct 2023 18:41:57 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1696606917;
 bh=CiFw+ri2pV3fFGFSkqgrXomGv4tyFoU5F3j5zc357CY=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=AySDCIfv/GIt0UMrSR3Hd8q5bLHzvZwXLxUWVP6ql/hCDJV3ZALFJhRGoFJ2p3gVC
 IIcXKdElwo64IzyNQqCboxkOsxXhLmpImbaMSTSz3PNU3R3VN6YzTAjZxBk5/59oWu
 WDGlpW/bKCZ3modWVhzSacl+xML90V5RU/HQcr1k=
Authentication-Results: mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, jsnow@redhat.com,
 crosa@redhat.com, kwolf@redhat.com, hreitz@redhat.com, eblake@redhat.com
Subject: [PATCH v7 09/15] iotests: refactor some common qmp result checks into
 generic pattern
Date: Fri,  6 Oct 2023 18:41:19 +0300
Message-Id: <20231006154125.1068348-10-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231006154125.1068348-1-vsementsov@yandex-team.ru>
References: <20231006154125.1068348-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
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

To simplify further conversion.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Eric Blake <eblake@redhat.com>
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
2.34.1


