Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AACDB76C0DA
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 01:28:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQymT-0001Jc-Bh; Tue, 01 Aug 2023 19:27:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qQymQ-0001BK-TA
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 19:27:54 -0400
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qQymO-00077y-TX
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 19:27:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1690932468; x=1691537268; i=deller@gmx.de;
 bh=ZAGQPFsn2pZ8MmOMealg/D8/q1s7JqKrqHIFaQj3uic=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Gh2/qwmqWyRJ24gY2CB42NH00tEY15toAeK70pW94ij+N7P1J3S5PU5E2fy8WtCiRjWCMCo
 kZNIBuvjwcu+FyLDjxyTruNyT5ckarhcRHBcCZV/VDn2mJ0E6cIq84BgpAErX7xviAAnOpMcp
 +RbDvm6TxxFA/aV1slt4Ya0M/RW7Px/ykilql+jR+D0La75v0NhiL/q64eRHmlK5GhZSIYqnD
 U40Condu0SAu4MqGnrDyGO5/1fPRO5RjILbHH0i6uVVCoAcBIjcYdcrHL8EhRqNFZHTK/cw5h
 UP/paZcC1JWKqQSbWrzqV7tkVB1/P6P+5iWR9v5CjFYN7lndcMYQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.150.247]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MbAgq-1ppS6V3RPc-00beiI; Wed, 02
 Aug 2023 01:27:47 +0200
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Joel Stanley <joel@jms.id.au>, Akihiko Odaki <akihiko.odaki@daynix.com>,
 Helge Deller <deller@gmx.de>
Subject: [PATCH v6 4/8] linux-user: Do nothing if too small brk is specified
Date: Wed,  2 Aug 2023 01:27:41 +0200
Message-ID: <20230801232745.4125-5-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801232745.4125-1-deller@gmx.de>
References: <20230801232745.4125-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LwLTCi1pUahACstVhvRkf5Bmkp+Qetgts09Fqen6Tsl9OjruMQ0
 hwoaKFALyYanwLNqB3/kwoGZYFeS/ujTBSer2QxtiI+RiRwsLzNlanbn/nyrRTfpKPM8tlT
 EwRQQ0wjVIEMApj0IArvREWMXH4dIh4hXFK/qwuRxkcBhV0qdSIXOoTHRAlFb4z9O4ts7kS
 5r9IFf69hbnjfTTvRjXiQ==
UI-OutboundReport: notjunk:1;M01:P0:csyIOGYGJuc=;2AsaHcIZG9g17YPWrIL6Dtgo2p/
 +LLqsolo5kGuwBuQG3xNK1n35srQAFcjMdn333D8JX8Qltks2LxFqr1ZzFLVWHLva2s22HUew
 VtvAvT0rkhsvtr0H2IiyWDzOT2li3MI/O/pPH8NYHbeV7EmTUSfuzS5yuL322Ml/c1Oyudgrg
 oSYYsnwhPWZbKcUtRdFAWwBtSx1iXszOmNTDCuxF6JeBc1PciEwgJFeEmG72EiIrLy2P7Z1Oi
 GpcP2jcCAcZc3Ijya2dS+Z6J6ky2G5hggikU8/3Y0+cnU2aHdsEZ83EVi2JKCTHCMMk6KIXWa
 wL2x6o6SvYS9ZCabY4NjVkiiRKzl+cxo50sEteboljF8jEmrN1NW+fiqiaEMNwludBYYBcU0A
 y2/Q4hrACso40hBBYVr0rXmG2CvHcMg5aDc2TQJKsGhYNs83OFMrHow7D4JkMWRcf2epyOr4H
 UvxCbvwvllZMA1q3U1SsKbrTj5e4K2tBEH9Ck3h63x4XpyFo8yjRxNjlNE9lfCSuo/R24wIQ+
 aZDyfFoUuEvxPiMwhH/RzwQmzfTVJ+3YGIF9C7pmzuJuC35tRyWIVHtDOHO0PdxWii3EpAqwX
 qZNDauy6z1a7spomQQIPgGlKdV8R0q8ieOo58pEWXVS/UxIckCcGcqKJ3RFrRo5TXUZS03gmd
 BgfVmpzC/NG2vpJwUoFqnMz7WCLx2m3vEDUCcgOh2Owxxtutt4jCFr4zFxi45yD+PbTCz8uBi
 +S/+yVEEFxLfxEcWkEvnQ2ImsOWTrgEKU63ZGurNqfYZKfxNkiG4ltjU7Py+HMnE9hsbupU6C
 wg0E2cGpV2ZD5OPfytP0CIKGIXqCmJWF9vxfk5LOhb6o57+tt8rZOj/2tqDSdKENLb8yqwFvt
 cWXEi5ftC7xLRrSynsL2Ad4ZHvsak5YwZRcnqcfcLEAG4vu3QMbnBm9p0VzLDMGkj4uZ3XDK+
 fKGs3Jqgi1hT0PO6FZjFqRdqZnE=
Received-SPF: pass client-ip=212.227.17.22; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

Linux 6.4.7 does nothing when a value smaller than the initial brk is
specified.

Fixes: 86f04735ac ("linux-user: Fix brk() to release pages")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Helge Deller <deller@gmx.de>
=2D--
 linux-user/syscall.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index ac429a185a..ebdc8c144c 100644
=2D-- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -820,14 +820,14 @@ abi_long do_brk(abi_ulong brk_val)

     /* brk pointers are always untagged */

-    /* return old brk value if brk_val unchanged or zero */
-    if (!brk_val || brk_val =3D=3D target_brk) {
+    /* return old brk value if brk_val unchanged */
+    if (brk_val =3D=3D target_brk) {
         return target_brk;
     }

     /* do not allow to shrink below initial brk value */
     if (brk_val < initial_target_brk) {
-        brk_val =3D initial_target_brk;
+        return target_brk;
     }

     new_brk =3D TARGET_PAGE_ALIGN(brk_val);
=2D-
2.41.0


