Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9477C7CDA07
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 13:11:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt4RD-0003eC-Av; Wed, 18 Oct 2023 07:10:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abelova@astralinux.ru>)
 id 1qt4R5-0003dm-Ra
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 07:10:00 -0400
Received: from mail.astralinux.ru ([217.74.38.119])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abelova@astralinux.ru>)
 id 1qt4R3-0002I0-Ht
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 07:09:59 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.astralinux.ru (Postfix) with ESMTP id A8C3E1863C02;
 Wed, 18 Oct 2023 14:09:49 +0300 (MSK)
Received: from mail.astralinux.ru ([127.0.0.1])
 by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new,
 port 10032)
 with ESMTP id HOTw-PCO_x_z; Wed, 18 Oct 2023 14:09:49 +0300 (MSK)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.astralinux.ru (Postfix) with ESMTP id 5E8411863730;
 Wed, 18 Oct 2023 14:09:49 +0300 (MSK)
X-Virus-Scanned: amavisd-new at astralinux.ru
Received: from mail.astralinux.ru ([127.0.0.1])
 by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new,
 port 10026)
 with ESMTP id 2Dl_TrdB7oUe; Wed, 18 Oct 2023 14:09:49 +0300 (MSK)
Received: from rbta-msk-lt-106062.astralinux.ru (unknown [10.177.20.58])
 by mail.astralinux.ru (Postfix) with ESMTPSA id D5C0118632B7;
 Wed, 18 Oct 2023 14:09:48 +0300 (MSK)
From: Anastasia Belova <abelova@astralinux.ru>
To: Jason Wang <jasowang@redhat.com>
Cc: Anastasia Belova <abelova@astralinux.ru>, qemu-devel@nongnu.org,
 sdl.qemu@linuxtesting.org
Subject: [PATCH] l2tpv3: overwrite s->fd in net_l2tpv3_cleanup
Date: Wed, 18 Oct 2023 14:09:17 +0300
Message-Id: <20231018110917.4131-1-abelova@astralinux.ru>
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

It's better to overwrite freed pointer s->fd to avoid
accessing an invalid descriptor.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 3fb69aa1d1 ("net: L2TPv3 transport")
Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
---
 net/l2tpv3.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/l2tpv3.c b/net/l2tpv3.c
index b5547cb917..713fb8053a 100644
--- a/net/l2tpv3.c
+++ b/net/l2tpv3.c
@@ -501,6 +501,7 @@ static void net_l2tpv3_cleanup(NetClientState *nc)
     l2tpv3_write_poll(s, false);
     if (s->fd >=3D 0) {
         close(s->fd);
+        s->fd =3D -1;
     }
     destroy_vector(s->msgvec, MAX_L2TPV3_MSGCNT, IOVSIZE);
     g_free(s->vec);
--=20
2.30.2


