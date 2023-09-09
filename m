Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FBC79986D
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 15:12:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qexg3-0008Do-FX; Sat, 09 Sep 2023 09:07:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qexg1-00087B-0l; Sat, 09 Sep 2023 09:07:05 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qexfy-0003ip-EJ; Sat, 09 Sep 2023 09:07:04 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0D518205E3;
 Sat,  9 Sep 2023 16:06:08 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id BE13626E36;
 Sat,  9 Sep 2023 16:05:16 +0300 (MSK)
Received: (nullmailer pid 354326 invoked by uid 1000);
 Sat, 09 Sep 2023 13:05:12 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Maksim Kostin <maksim.kostin@ispras.ru>,
 Vitaly Cheptsov <cheptsov@ispras.ru>, Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.6 22/37] hw/ppc/e500: fix broken snapshot replay
Date: Sat,  9 Sep 2023 16:04:52 +0300
Message-Id: <20230909130511.354171-22-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.6-20230909160328@cover.tls.msk.ru>
References: <qemu-stable-7.2.6-20230909160328@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Maksim Kostin <maksim.kostin@ispras.ru>

ppce500_reset_device_tree is registered for system reset, but after
c4b075318eb1 this function rerandomizes rng-seed via
qemu_guest_getrandom_nofail. And when loading a snapshot, it tries to read
EVENT_RANDOM that doesn't exist, so we have an error:

  qemu-system-ppc: Missing random event in the replay log

To fix this, use qemu_register_reset_nosnapshotload instead of
qemu_register_reset.

Reported-by: Vitaly Cheptsov <cheptsov@ispras.ru>
Fixes: c4b075318eb1 ("hw/ppc: pass random seed to fdt ")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1634
Signed-off-by: Maksim Kostin <maksim.kostin@ispras.ru>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
(cherry picked from commit 6ec65b69ba17c954414fa23a397fb8a3fcfb4a43)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 2fe496677c..8d5eb08381 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -683,7 +683,7 @@ static int ppce500_prep_device_tree(PPCE500MachineState *machine,
     p->kernel_base = kernel_base;
     p->kernel_size = kernel_size;
 
-    qemu_register_reset(ppce500_reset_device_tree, p);
+    qemu_register_reset_nosnapshotload(ppce500_reset_device_tree, p);
     p->notifier.notify = ppce500_init_notify;
     qemu_add_machine_init_done_notifier(&p->notifier);
 
-- 
2.39.2


