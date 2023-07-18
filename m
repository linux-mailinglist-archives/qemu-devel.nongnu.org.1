Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF47375851E
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 20:54:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLpov-0000xQ-3K; Tue, 18 Jul 2023 14:53:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1qLpot-0000x2-HN; Tue, 18 Jul 2023 14:53:11 -0400
Received: from mout.gmx.net ([212.227.15.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1qLpod-0003O6-5L; Tue, 18 Jul 2023 14:53:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1689706364; x=1690311164; i=deller@gmx.de;
 bh=Y2R6dhX3c4Smt/gWWNK5vjxqVT4qS1UdFbVRJHqxeWA=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=jS9mtCzJ75znawTzoTZvu/qqUkUuV7VNo09uBqozVKITyHbnJM/gtZTLQJYN07R7pSNaMfJ
 lcYbq8Ec2gnms8b0TBFgw56WOdrSov6Z3ihHYOYJp76KPK29cJuttfoh2SDtZxYLlJt/z9cJz
 pNCME7r3LAIrvmw7a4ArP9N4tdHtt4BWjW9xmEfHBu+0fjjTGLmh7XJnpog1Vc4qn43/vKLdm
 IU7t3MJEQqigKn2nrwaoidVRNh+ofJgTmEie/8kwTBKKWNvAFeExmDXNcjXLq4QtjV9NM01+s
 Fdk3uznQ+Ogr8JW1+u3gDSAGCuDokqR2+oLut3xWvxTwqcEgKd2A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.159.74]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MMofW-1qcGCW0Bjo-00Ikqs; Tue, 18
 Jul 2023 20:52:44 +0200
From: Helge Deller <deller@gmx.de>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, Andreas Schwab <schwab@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Helge Deller <deller@gmx.de>,
 "Markus F.X.J. Oberhumer" <markus@oberhumer.com>, qemu-stable@nongnu.org
Subject: [PATCH v2 2/5] linux-user: Prohibit brk() to to shrink below initial
 heap address
Date: Tue, 18 Jul 2023 20:52:38 +0200
Message-ID: <20230718185241.11433-3-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230718185241.11433-1-deller@gmx.de>
References: <20230718185241.11433-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bN2rE8OD/IFUXJ4lb2S2+6vORvqJCC9LQmfhUWkR4GzxGLgORyX
 In444UrIfupWtIMKp98xIkv3BGfiT8Xg5/V95Q+z8bkbRVE5iypWzePpTgdC1qptJXQt89H
 wRTAI3PhA0BXbw5Ge1ojwXmB6qcBNdmPfb5Z4SYVKoas63MQcCR2EOmMiQJu3Fc5jg6SCev
 OdDeQassOEcg2iupKQzLg==
UI-OutboundReport: notjunk:1;M01:P0:do2eX0aYYZ8=;c/AlMSPb6/IkqNfagJ9j9mPCo5S
 HqTl7+YGqai0fwuS1GdAoirvECMlvUik3PJ6JGrQwtVmH4VT6UGor2sM1YonI6fBTrG6Kdx3K
 4FUEq39wgxnNmNxUyXQtfD8rJo46oz+rCYOO/8Ngwq+xKa1XkHpkydtkKRDBFfJimGfFf4kxl
 gk1iyoOxHmdEeHL8IZk/yPKvDTeaqyCAEKwjMfchZzwYbKEa4TvG3uReVsrpKpGtPy0rZMS4m
 Lh/IlvDnzNjlIKsykCvaOnOEwTaNcu/IBliBupL35FEJTS0oBnOA6prXOvx/WuS5GrZT3EoH0
 tE5CXO2WH5DVKXKLviYqcqZSGFTTiuLwtjBM/YFMmWEk+XqlXFU8q2DoOdlDHeNHuxaS5x1Pe
 FI4mNM3G34fPG3Lb5cTgt33mhzOik8LEoh45zhByxi7oh23wAEZEkPpA0R7UAao+fLLSIOHbw
 YUTzj9vxWOvIIv0aT5iumK4Og7cJFoZKLrD5RdRUR0cim6os92o/2TPor1VBoElWTPA+RekF2
 lRhr47fw4TiIvMaV5siy2ggtP9GwMiilEVO2Pn/nZ2tMftWYcGOV+t8ZMIMZ6tKzYVOcNvH+R
 5AWLCRtyhRZFZQuvWNNFa64Lw0iRFrDRb1g36wY/CxFyn3ovQymdn5IGs4cCXHhO6z9bhRzZ2
 L85HiywEMa491J1NpcUg2NtA8Od+GHpVYnGvgXHrnxQjroGro2MgZlaHJ/OTFwT5HPnDDsXNo
 rFMFztd/nYYod2I+Z2EfI0oeG4V8fKL8ITqhqtATx9mX5z0NW7SMP6mSmFB872/aoCOWChkTE
 u+xybUQVa0EU0hVPIJ1bRPE+tC92C2hyYmfdqbvQ62YMbX3PoXTkUnYnugJpdxg8hZzlZeviC
 Ad6ZyzXuSXMAmisX1yw7u5LfBIFivY56+Vb8qXtvXZz+zpkeU6TEezPjgeOVLIOnZXGad6Rg5
 oZ6REz7/jn02944pEUq6eHSjkyE=
Received-SPF: pass client-ip=212.227.15.15; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_FROM=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Since commit 86f04735ac ("linux-user: Fix brk() to release pages") it's
possible for userspace applications to reduce their memory footprint by
calling brk() with a lower address and free up memory. Before that commit
guest heap memory was never unmapped.

But the Linux kernel prohibits to reduce brk() below the initial memory
address which is set at startup by the set_brk() function in binfmt_elf.c.
Such a range check was missed in commit 86f04735ac.

This patch adds the missing check by storing the initial brk value in
initial_target_brk and verify any new brk addresses against that value.

Tested with the i386 upx binary from
https://github.com/upx/upx/releases/download/v4.0.2/upx-4.0.2-i386_linux.t=
ar.xz

Signed-off-by: Helge Deller <deller@gmx.de>
Tested-by: "Markus F.X.J. Oberhumer" <markus@oberhumer.com>
Fixes: 86f04735ac ("linux-user: Fix brk() to release pages")
Cc: qemu-stable@nongnu.org
Buglink: https://github.com/upx/upx/issues/683
=2D--
 linux-user/syscall.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index ee54eed33b..125fcbe423 100644
=2D-- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -801,12 +801,13 @@ static inline int host_to_target_sock_type(int host_=
type)
     return target_type;
 }

-static abi_ulong target_brk;
+static abi_ulong target_brk, initial_target_brk;
 static abi_ulong brk_page;

 void target_set_brk(abi_ulong new_brk)
 {
     target_brk =3D TARGET_PAGE_ALIGN(new_brk);
+    initial_target_brk =3D target_brk;
     brk_page =3D HOST_PAGE_ALIGN(target_brk);
 }

@@ -824,6 +825,11 @@ abi_long do_brk(abi_ulong brk_val)
         return target_brk;
     }

+    /* do not allow to shrink below initial brk value */
+    if (brk_val < initial_target_brk) {
+        brk_val =3D initial_target_brk;
+    }
+
     new_brk =3D TARGET_PAGE_ALIGN(brk_val);
     new_host_brk_page =3D HOST_PAGE_ALIGN(brk_val);

=2D-
2.41.0


