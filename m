Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C236E791473
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 11:11:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd5Z4-0004ed-QC; Mon, 04 Sep 2023 05:08:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=kZzc=EU=kaod.org=clg@ozlabs.org>)
 id 1qd5Yw-000418-QD; Mon, 04 Sep 2023 05:08:04 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=kZzc=EU=kaod.org=clg@ozlabs.org>)
 id 1qd5Yt-0003wQ-Rj; Mon, 04 Sep 2023 05:08:02 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4RfN8F4BFkz4x2Z;
 Mon,  4 Sep 2023 19:07:57 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4RfN8C1g7cz4wy9;
 Mon,  4 Sep 2023 19:07:54 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: qemu-ppc@nongnu.org,
	qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Maksim Kostin <maksim.kostin@ispras.ru>,
 Vitaly Cheptsov <cheptsov@ispras.ru>, Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 30/35] hw/ppc/e500: fix broken snapshot replay
Date: Mon,  4 Sep 2023 11:06:25 +0200
Message-ID: <20230904090630.725952-31-clg@kaod.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230904090630.725952-1-clg@kaod.org>
References: <20230904090630.725952-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=kZzc=EU=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
---
 hw/ppc/e500.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 67793a86f11f..d5b6820d1dc9 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -712,7 +712,7 @@ static int ppce500_prep_device_tree(PPCE500MachineState *machine,
     p->kernel_base = kernel_base;
     p->kernel_size = kernel_size;
 
-    qemu_register_reset(ppce500_reset_device_tree, p);
+    qemu_register_reset_nosnapshotload(ppce500_reset_device_tree, p);
     p->notifier.notify = ppce500_init_notify;
     qemu_add_machine_init_done_notifier(&p->notifier);
 
-- 
2.41.0


