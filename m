Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 153B77B1E53
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 15:27:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlr28-0000UP-DQ; Thu, 28 Sep 2023 09:26:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abelova@astralinux.ru>)
 id 1qlr1m-0000KC-Pf
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 09:26:06 -0400
Received: from mail.astralinux.ru ([217.74.38.119])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abelova@astralinux.ru>)
 id 1qlr1j-0001CN-9L
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 09:26:01 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.astralinux.ru (Postfix) with ESMTP id 21D241866B55;
 Thu, 28 Sep 2023 16:25:48 +0300 (MSK)
Received: from mail.astralinux.ru ([127.0.0.1])
 by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new,
 port 10032)
 with ESMTP id AUNoyzic9DPL; Thu, 28 Sep 2023 16:25:47 +0300 (MSK)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.astralinux.ru (Postfix) with ESMTP id C63D118669DD;
 Thu, 28 Sep 2023 16:25:47 +0300 (MSK)
X-Virus-Scanned: amavisd-new at astralinux.ru
Received: from mail.astralinux.ru ([127.0.0.1])
 by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new,
 port 10026)
 with ESMTP id 9ThlqH6m0r44; Thu, 28 Sep 2023 16:25:47 +0300 (MSK)
Received: from rbta-msk-lt-106062.astralinux.ru (unknown [10.177.20.58])
 by mail.astralinux.ru (Postfix) with ESMTPSA id 30B901866780;
 Thu, 28 Sep 2023 16:25:47 +0300 (MSK)
From: Anastasia Belova <abelova@astralinux.ru>
To: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
Cc: Anastasia Belova <abelova@astralinux.ru>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 sdl.qemu@linuxtesting.org
Subject: [PATCH] hyperv: add check for NULL for msg
Date: Thu, 28 Sep 2023 16:25:19 +0300
Message-Id: <20230928132519.26266-1-abelova@astralinux.ru>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=217.74.38.119; envelope-from=abelova@astralinux.ru;
 helo=mail.astralinux.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

cpu_physical_memory_map may return NULL in hyperv_hcall_post_message.
Add check for NULL to avoid NULL-dereference.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 76036a5fc7 ("hyperv: process POST_MESSAGE hypercall")
Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
---
 hw/hyperv/hyperv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/hyperv/hyperv.c b/hw/hyperv/hyperv.c
index 57b402b956..61c65d7329 100644
--- a/hw/hyperv/hyperv.c
+++ b/hw/hyperv/hyperv.c
@@ -588,7 +588,7 @@ uint16_t hyperv_hcall_post_message(uint64_t param, bo=
ol fast)
=20
     len =3D sizeof(*msg);
     msg =3D cpu_physical_memory_map(param, &len, 0);
-    if (len < sizeof(*msg)) {
+    if (!msg || len < sizeof(*msg)) {
         ret =3D HV_STATUS_INSUFFICIENT_MEMORY;
         goto unmap;
     }
--=20
2.30.2


