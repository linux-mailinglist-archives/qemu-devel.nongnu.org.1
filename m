Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E329756EFC
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 23:36:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLVso-00022y-8R; Mon, 17 Jul 2023 17:35:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qLVsm-00022a-80
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 17:35:52 -0400
Received: from mout.gmx.net ([212.227.15.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qLVsk-00083e-7G
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 17:35:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1689629746; x=1690234546; i=deller@gmx.de;
 bh=JQkQBiVR+OHUGrLq6zEvCE+y8fkagC30PPU3cX2QOLw=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ntWj+/cZ9D0Wjn9miATjUVHaIbMuHhqm0T/ORxy5ciILxqShlezeCo8cF43Kbv6ngt+mjf5
 r5k5ArKbulpPPTydxuyycVSIxY9mThHcMuYbwAKvuPee7GbIbIIG7l6vJz2z9TdVVJnn9eIDN
 UTtDdDQxBe2AWFEm7uXN9PcH4c4nU6fER/EqNmEFS3zzFxLZbFaZFg7LL0e4sjyroyXDNtuwz
 YKelM2CcfXQT9jBzotUP4T/C2ed9YHJxyMcFefUCUU4AHWso129eh3HNCHyob8X4nQ29LWx5X
 CwphYhdJf6uPa2A5VLbpnwqWXz86dTaXNuRLJ0ZuYzYGhsckzJyw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.159.97]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MFKGZ-1qACGh17bl-00FlX6; Mon, 17
 Jul 2023 23:35:46 +0200
From: Helge Deller <deller@gmx.de>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Helge Deller <deller@gmx.de>,
 "Markus F . X . J . Oberhumer" <notifications@github.com>
Subject: [PATCH 1/6] Revert "linux-user: Make sure initial brk(0) is
 page-aligned"
Date: Mon, 17 Jul 2023 23:35:40 +0200
Message-ID: <20230717213545.142598-2-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230717213545.142598-1-deller@gmx.de>
References: <20230717213545.142598-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DtSMRM0qakslN7G4lyg91Dw7hyrIv2K8x0rZfPO/5t9+zRVJfbw
 wk+c8O13xTZmAIzJV8ddthDmvLVU4ErjY75TjxLFF3fFIlFxY6R7kLzezCS+kdT1XfnpcTS
 0MeMvkmoGwkbJdNTknYq6QJhmTUormo1q76Cgsqr/oN/5iWtJUIqQGGrtUVKTFUKiSV7ATq
 +RhjPsQeuhOqQvzUakHnQ==
UI-OutboundReport: notjunk:1;M01:P0:e3ElbqU2R8o=;EAcRZ6I+7so4Ju35AMber7XT+PK
 3Fj5x8g8E23CGdNPGVihC3/sH80IQiFl96hsJzL+1bkvp7ittv19ITyI8oHaVJYpBNN3EZ4V6
 RgVr6832yiaf3TvbBzIqCleV3NtkRaSDQPNejOjIj2w2SBS2aiLQkEBASDz19evHTy9CWuyVf
 I+U8ZrxeMbqTftSaagnuBAQzfcPf57joZqB7uk/iFWEzm6+Cgz/xH86qPl69kl47a/Vku/KKf
 LlR3I9HGZ82TPnG9NncTmc1QirgKMfNJWNsVHsKh+dRb+hid/isBVHp1/wGXSpjt4A6RBaRdW
 2S43BmmiI2GWN5AvPosQkPHjQlLVKMu/BUH0jXSWiHyB6pa42TONcu/p5YKLpQoxy8+GqvhSF
 iq0J6hsECgI4w/jMtgVD2/5dIzWROaxaqHX3HwoAyyPF7p6uJC9Ug4vSzRypobFTQKAGeoxVX
 cynh4SI9jrki15BepdNBb9E4PDkCrD/TlQEB5MekbFplMXllLyP59ClDPdAQy8RpvgWsyDWAq
 ++BhKjjfZr6QDu77LN/0kLfCxWGGkWtYnV2gBOn/nuthZMdw4vxwFMCh2d163RvgeQNvNlY3B
 lopyIcZwAx1eAXwn/o8e+sfp/TDNbVGig5sVWkAjOgK0/VU3JGs7W/pTJlWkBnC9QtgMw7Oc2
 zu4HuYaOD+LVEzhaSAUO41OgPk0f5XUug7NkO/+uWmw0ZRrF7WozSfbmeIRS9dbqirRI/i9Pt
 4b6OWHmzHfEK34i6Z4LvlEtwHk7U9o004BnPHwUhBLcFRBXQFtT51W0UtxY6i/Di28AnvZNLl
 gxAPwJm7HEk5Wfd8Tlg6n6ZFoQe9Jfr5gkXyMwczk6OVlVAMvalziURbS0wzYNzK0jPG9oxrr
 D+N8i5FSU7l2je2vihPY0AWxjrnuP5B9u6HGl64lDsixpzfzLvbOlTl8zt+D22Hk5L8KbThZ0
 cf1fyorst8ykGZ1odNTKykRiTqk=
Received-SPF: pass client-ip=212.227.15.15; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

This reverts commit d28b3c90cfad1a7e211ae2bce36ecb9071086129.

It just hides the real bug, and even the Linux kernel may
return page-unaligned addresses.

Signed-off-by: Helge Deller <deller@gmx.de>
Tested-by: Markus F.X.J. Oberhumer <notifications@github.com>
=2D--
 linux-user/syscall.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index c99ef9c01e..b9527ab00f 100644
=2D-- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -806,7 +806,7 @@ static abi_ulong brk_page;

 void target_set_brk(abi_ulong new_brk)
 {
-    target_brk =3D TARGET_PAGE_ALIGN(new_brk);
+    target_brk =3D new_brk;
     brk_page =3D HOST_PAGE_ALIGN(target_brk);
 }

=2D-
2.41.0


