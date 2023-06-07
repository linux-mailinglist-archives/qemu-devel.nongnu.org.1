Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 530D4726294
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 16:20:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6u0n-0002rA-Jr; Wed, 07 Jun 2023 10:19:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=51561cf95=anthony.perard@citrix.com>)
 id 1q6u0m-0002qm-0q
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 10:19:44 -0400
Received: from esa6.hc3370-68.iphmx.com ([216.71.155.175])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=51561cf95=anthony.perard@citrix.com>)
 id 1q6u0k-0003Q0-Ec
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 10:19:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1686147582;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=DevbehoMd5ErdPmYCLaewfSTkvvhbRICcFTF4cmkBNY=;
 b=RZcmB7xZn4O1Z/r3QYVs5q5QU5P37ktk36HNG0UEIcV106F3qs/NPOGm
 P+4yERS/h0szXEbt6S6Cc64j2sCQORfKAeLQg63aMoOSJMaAo19+Ny2kG
 V6DfEGdiEGMZWurUkSjFe4gOQxpLJfN6XvnkJubbU7NWTdom2CWDXIt8g Y=;
Authentication-Results: esa6.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none
X-SBRS: 4.0
X-MesageID: 111246603
X-Ironport-Server: esa6.hc3370-68.iphmx.com
X-Remote-IP: 162.221.156.123
X-Policy: $RELAYED
IronPort-Data: A9a23:2qr80qrYchiUX5E8RJfKEJxQ3HdeBmIeZRIvgKrLsJaIsI4StFCzt
 garIBmDb/ncazT0et11PITg9kpVuZXXzNdiQAJupX9hEC5A8puZCYyVIHmrMnLJJKUvbq7FA
 +Y2MYCccZ9uHhcwgj/3b9ANeFEljfngqoLUUbKCYWYpA1c/Ek/NsDo788YhmIlknNOlNA2Ev
 NL2sqX3NUSsnjV5KQr40YrawP9UlKq04GtwUmAWP6gR5weAzyZNVvrzGInqR5fGatgMdgKFb
 76rIIGRpgvx4xorA9W5pbf3GmVirmn6ZFXmZtJ+AsBOszAazsAA+v9T2Mk0MC+7vw6hjdFpo
 OihgLTrIesf0g8gr8xGO/VQO3kW0aSrY9YrK1Dn2SCY5xWun3cBX5yCpaz5VGEV0r8fPI1Ay
 RAXAD4wSC7b3MS6+ZWmd/FXh+YEDuTUDrpK7xmMzRmBZRonaZXKQqGM7t5ExjYgwMtJGJ4yZ
 eJAN2ApNk6ZJUQSZBFOUslWcOSA3xETdxVRrk6VoqwmpXDe1gVr3JDmMcbPe8zMTsJQ9qqdj
 jufpj6lXE9Cb7RzzxLZ132N3MjAwxjJZ4w/EaS9qKA7q3Cqkzl75Bo+CgLg/KjRZlSFc8tSL
 lFR9icwoKwa8kutQd/gGRqirxassgEZRPJZFuQo7wfLwa2S/gXxO4QfZmcfMpp87pZwHGF0k
 AbTxLsFGACDrpWbdFSjruyyoQqVJBUNFm4gQg0pcjk8toyLTJ4IsjrDSdNqEaiQh9LzGC3tz
 z3ikBXSl4n/nuZQifzloAmvbyaE48GQE1Vrvlm/sneNtFsRWWKzW2C/BbE3B95kJZ3RcFSOt
 WNsdyO2vLFXVsHleMBgrYww8FCVCxStamW0bb1HRcNJG9GRF5mLI+htDMlWfhsBDyr9UWaBj
 LXvkQ1Q/oRPG3ChcLV6ZYm8Y+xzk/i+TYu7DKyPP4YXCnSUSONh1Hs2DaJ39zq0+HXAbIllY
 cvLGSpSJShy5VtbIMqeGL5GjO5DKtEWzmLPX5HrpylLIpLHDEN5vYwtaQPUBshgtfPsnekg2
 4oHXyd840kFAbKWj+i+2dJ7EG3m2lBlXc2n9ZYKLLfrz8gPMDhJNsI9CIgJI+RN95m5XM+Sl
 p1hcie0EGbCuEA=
IronPort-HdrOrdr: A9a23:lnR0n6jAd+DP1o2sA9e2Qh8LI3BQXugji2hC6mlwRA09TyX4ra
 +TdZEgviMc5wxhPU3I9ergBED4ewK+yXcX2+cs1MmZLWvbUQKTRekJgOffKlvbaknDH4VmtZ
 uIHZIOceHYPBxXitv7/Rn9M/tI+qj+zElwv5a48566d3ANV51d
X-Talos-CUID: 9a23:TPUUvmB1X9on+Cr6Eyda0nBMQeYpS1rA8W/rIm2fK0tWeoTAHA==
X-Talos-MUID: 9a23:Pv8zNwUN3+z/uTbq/GPJixA4E8g22JaRBm0IiJBY5ZivGBUlbg==
X-IronPort-AV: E=Sophos;i="6.00,224,1681185600"; d="scan'208";a="111246603"
To: <qemu-devel@nongnu.org>
CC: David Woodhouse <dwmw@amazon.co.uk>, Anthony PERARD
 <anthony.perard@citrix.com>
Subject: [PULL 04/12] hw/xen: Fix broken check for invalid state in
 xs_be_open()
Date: Wed, 7 Jun 2023 15:18:31 +0100
Message-ID: <20230607141839.48422-5-anthony.perard@citrix.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230607141839.48422-1-anthony.perard@citrix.com>
References: <20230607141839.48422-1-anthony.perard@citrix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=216.71.155.175;
 envelope-from=prvs=51561cf95=anthony.perard@citrix.com;
 helo=esa6.hc3370-68.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Reply-to:  Anthony PERARD <anthony.perard@citrix.com>
From:  Anthony PERARD via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

From: David Woodhouse <dwmw@amazon.co.uk>

Coverity points out that if (!s && !s->impl) isn't really what we intended
to do here. CID 1508131.

Fixes: 032475127225 ("hw/xen: Add emulated implementation of XenStore operations")
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Paul Durrant <paul@xen.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20230412185102.441523-6-dwmw2@infradead.org>
Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
---
 hw/i386/kvm/xen_xenstore.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/kvm/xen_xenstore.c b/hw/i386/kvm/xen_xenstore.c
index 0b189c6ab8..133d89e953 100644
--- a/hw/i386/kvm/xen_xenstore.c
+++ b/hw/i386/kvm/xen_xenstore.c
@@ -1688,7 +1688,7 @@ static struct qemu_xs_handle *xs_be_open(void)
     XenXenstoreState *s = xen_xenstore_singleton;
     struct qemu_xs_handle *h;
 
-    if (!s && !s->impl) {
+    if (!s || !s->impl) {
         errno = -ENOSYS;
         return NULL;
     }
-- 
Anthony PERARD


