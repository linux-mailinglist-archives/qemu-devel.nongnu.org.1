Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2F77262EC
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 16:37:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6uHD-0001GE-JR; Wed, 07 Jun 2023 10:36:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1q6uH7-0001F0-Ow; Wed, 07 Jun 2023 10:36:38 -0400
Received: from forwardcorp1c.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1q6uH5-0006LB-6B; Wed, 07 Jun 2023 10:36:37 -0400
Received: from mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:2c24:0:640:73f8:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTP id DE7F55EB39;
 Wed,  7 Jun 2023 17:36:22 +0300 (MSK)
Received: from vsementsov-nix.yandex-team.ru (unknown
 [2a02:6b8:b081:b5a3::1:2b])
 by mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 9aVXqs1OjuQ0-TIcG8OnD; Wed, 07 Jun 2023 17:36:22 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1686148582; bh=hiLiX5spHkYE4uhp9VEnNPmDeVyEwEgsQmjiJDl7DNs=;
 h=Message-Id:Date:Cc:Subject:To:From;
 b=TS+iXGxTV9/g/3ruiouOCZLC5r6hi4tPIx4ovxNv2xfqYPaZSVgceFxD5n+IclfX5
 BshjE/3rKzpealBz1yrgkUTVTpxSwp+Xeysy99ZNDREBtk8F7M+7abMsoiZbExWTym
 8Ip6RH3gn2N+nRaiINSYZrp0h20/HRe3RNzbg0+I=
Authentication-Results: mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 stefanha@redhat.com, berrange@redhat.com, jsnow@redhat.com,
 richard.henderson@linaro.org, thuth@redhat.com, philmd@linaro.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH] iotests: fix 194: filter out racy postcopy-active event
Date: Wed,  7 Jun 2023 17:36:06 +0300
Message-Id: <20230607143606.1557395-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

The event is racy: it will not appear in the output if bitmap is
migrated during downtime period of migration and postcopy phase is not
started.

Fixes: ae00aa239847 "iotests: 194: test also migration of dirty bitmap"
Reported-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---

The patch fixes the problem described in
  [PATCH] gitlab: Disable io-raw-194 for build-tcg-disabled
and we can keep the test in gitlab ci

 tests/qemu-iotests/194     | 5 +++++
 tests/qemu-iotests/194.out | 1 -
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/194 b/tests/qemu-iotests/194
index 68894371f5..c0ce82dd25 100755
--- a/tests/qemu-iotests/194
+++ b/tests/qemu-iotests/194
@@ -74,6 +74,11 @@ with iotests.FilePath('source.img') as source_img_path, \
 
     while True:
         event1 = source_vm.event_wait('MIGRATION')
+        if event1['data']['status'] == 'postcopy-active':
+            # This event is racy, it depends do we really do postcopy or bitmap
+            # was migrated during downtime (and no data to migrate in postcopy
+            # phase). So, don't log it.
+            continue
         iotests.log(event1, filters=[iotests.filter_qmp_event])
         if event1['data']['status'] in ('completed', 'failed'):
             iotests.log('Gracefully ending the `drive-mirror` job on source...')
diff --git a/tests/qemu-iotests/194.out b/tests/qemu-iotests/194.out
index 4e6df1565a..376ed1d2e6 100644
--- a/tests/qemu-iotests/194.out
+++ b/tests/qemu-iotests/194.out
@@ -14,7 +14,6 @@ Starting migration...
 {"return": {}}
 {"data": {"status": "setup"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 {"data": {"status": "active"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
-{"data": {"status": "postcopy-active"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 {"data": {"status": "completed"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 Gracefully ending the `drive-mirror` job on source...
 {"return": {}}
-- 
2.34.1


