Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 787BD7787D7
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 09:08:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUMFV-00048F-OI; Fri, 11 Aug 2023 03:07:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1qUMFR-00047h-M3
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 03:07:50 -0400
Received: from mail.ispras.ru ([83.149.199.84])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1qUMFM-0008IK-Ua
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 03:07:49 -0400
Received: from pasha-ThinkPad-X280.lan02.inno (unknown [188.162.65.26])
 by mail.ispras.ru (Postfix) with ESMTPSA id 69EB9407626B;
 Fri, 11 Aug 2023 07:07:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 69EB9407626B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
 s=default; t=1691737660;
 bh=HV+HS4QRZW3hne/qyQQW82szrTm0JKnDcIIOdOfyylA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=dyc829Tax84GpIMn+CxR35NLc1n1KClwlNZbuBYJngl1UidMrNbWdsRZ3HJgOMBxW
 vdWjHD6MDwcvvcwjdHEcH1ohOu8BNdb3qS32PmMordii9qPaQoB5FoqBTNVV08MGXC
 jYgZ/R0tuYxT3cKspn4XhIRWBY4SqQghpzGkmr0Q=
From: pavel.dovgalyuk@ispras.ru
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, crosa@redhat.com, wainersm@redhat.com, bleal@redhat.com,
 alex.bennee@linaro.org, mst@redhat.com, rafael.pizarrosolar@epfl.ch,
 Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>, John Snow <jsnow@redhat.com>
Subject: [PATCH 3/3] tests/avocado: fix waiting for vm shutdown in replay_linux
Date: Fri, 11 Aug 2023 10:06:08 +0300
Message-Id: <20230811070608.3383343-4-pavel.dovgalyuk@ispras.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230811070608.3383343-1-pavel.dovgalyuk@ispras.ru>
References: <20230811070608.3383343-1-pavel.dovgalyuk@ispras.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=83.149.199.84;
 envelope-from=pavel.dovgalyuk@ispras.ru; helo=mail.ispras.ru
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

From: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>

This patch fixes the race condition in waiting for shutdown
of the replay linux test.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
Suggested-by: John Snow <jsnow@redhat.com>
---
 tests/avocado/replay_linux.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/avocado/replay_linux.py b/tests/avocado/replay_linux.py
index a76dd507fc..270ccc1eae 100644
--- a/tests/avocado/replay_linux.py
+++ b/tests/avocado/replay_linux.py
@@ -93,7 +93,7 @@ def launch_and_wait(self, record, args, shift):
                 % os.path.getsize(replay_path))
         else:
             vm.event_wait('SHUTDOWN', self.timeout)
-            vm.shutdown(True)
+            vm.wait()
             logger.info('successfully fihished the replay')
         elapsed = time.time() - start_time
         logger.info('elapsed time %.2f sec' % elapsed)
-- 
2.34.1


