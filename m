Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BADB7756D3
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 12:09:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTg6d-0001Vv-LJ; Wed, 09 Aug 2023 06:07:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maksim.kostin@ispras.ru>)
 id 1qTg6a-0001Vh-Ri; Wed, 09 Aug 2023 06:07:53 -0400
Received: from mail.ispras.ru ([83.149.199.84])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maksim.kostin@ispras.ru>)
 id 1qTg6Y-0002KO-Qi; Wed, 09 Aug 2023 06:07:52 -0400
Received: from timbersaw.intra.ispras.ru (unknown [85.142.117.226])
 by mail.ispras.ru (Postfix) with ESMTPSA id BA16640F1DD7;
 Wed,  9 Aug 2023 10:07:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru BA16640F1DD7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
 s=default; t=1691575665;
 bh=KSUA1EF/4walk+vI1G+OyBeQQdvGHsA+9ce6SthPjJA=;
 h=From:To:Cc:Subject:Date:From;
 b=QtQ1lCqdDSvStM1wKSwkp1/OSv87UHign3hzumGezmoXOhB1pFp9iPduFlVg9EViM
 R6N6t9vQh3AJosCokV0QMOVTgGm6V6BodlcY6hrr8CJUf6f2Dg5VS7UyhZc4wfvkWj
 WfDLZXnxykTlCnPiLVf4bBka1fuLebYPaLBBK8aU=
From: Maksim Kostin <maksim.kostin@ispras.ru>
To: qemu-devel@nongnu.org
Cc: Maksim Kostin <maksim.kostin@ispras.ru>, qemu-ppc@nongnu.org,
 pavel.dovgaluk@ispras.ru, pbonzini@redhat.com, alex.bennee@linaro.org,
 Vitaly Cheptsov <cheptsov@ispras.ru>
Subject: [PATCH] hw/ppc/e500: fix broken snapshot replay
Date: Wed,  9 Aug 2023 13:07:33 +0300
Message-Id: <20230809100733.32189-1-maksim.kostin@ispras.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=83.149.199.84;
 envelope-from=maksim.kostin@ispras.ru; helo=mail.ispras.ru
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
---
 hw/ppc/e500.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 67793a86f1..d5b6820d1d 100644
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
2.34.1


