Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D95F97714E9
	for <lists+qemu-devel@lfdr.de>; Sun,  6 Aug 2023 14:19:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSchY-0000DK-7j; Sun, 06 Aug 2023 08:17:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qSchV-0000Bn-AJ
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 08:17:37 -0400
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qSchT-0001mo-F6
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 08:17:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691324253; x=1691929053; i=deller@gmx.de;
 bh=dvxkSS+9zJe2d6S5F16mDEZxjl4ybNfaIXuGtQs5GGw=;
 h=X-UI-Sender-Class:From:To:Subject:Date:In-Reply-To:References;
 b=tEuSi+o8v3+RY21JA9nfwacp4LxBHJ0QLpnuAy9SGnMzc1wmIeJIWqCQSTTS2Bn7tAyC7MU
 PsU3GZ+51Kjz2vjj8LAvi18tL4RC5KuzvZq7iVIdjgzR1ptUXTwgIsJriHVozu4FrHosHqItR
 VaTcsMuHdXkzSsYIOgiYGZAbVVZ6Sz/snDI+hHUVKSn9RnGbwOFTUfMjNU6zsVKfFpgJGaUaR
 1DMz3RdXFIO1yXxNrvAqlyh/i0ZA5Z/qVWTm0cln78VdesYvW6lTIvOcNKkDwi0rZckAgUrY3
 6K3k8SZ8HRiN7fnRvaOGmJKiC4ln/DKOAm5EMMDuesOCe5JWuaog==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.152.250]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MxDou-1pdxyv2Ucy-00xYnA; Sun, 06
 Aug 2023 14:17:33 +0200
From: Helge Deller <deller@gmx.de>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 06/23] target/hexagon: Use MMU_INDEX() helper
Date: Sun,  6 Aug 2023 14:17:15 +0200
Message-ID: <20230806121732.91853-7-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230806121732.91853-1-deller@gmx.de>
References: <20230806121732.91853-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zp6JnqrMUfV/5wQoLa24KCo6vzZfqH46o/Ets0FyzpYgpuV36j1
 Exf16DjQ7Tgnp+FeYY2If6b4UFkZ0tYMTn/DUQJmkrgizUfk853xrqwO7HhFEjWvF0j15h7
 vz4aU+zapcoO+OaqLvuh3iuPmuymQru7TUe+Ro0CH6Zh/VZNYXT/TZ7ZsKZeSarB7UVCr3k
 +6QxdI5iFi+UgaQ8eEyNQ==
UI-OutboundReport: notjunk:1;M01:P0:di1tIVIDR9Q=;TPJL3BxqaMq7OnloIdZHRYItp4R
 xOi9ccUdMahJunxp5E1duLC6Z0VyPgkl8k2MO+cCg7HQ8wHbbWDy8FLp8lHvgSEsFg9nLBYGL
 5QicRSR9WPpHY3YWQt0/aEjLajrssTRra0npoQZ+MVH0LnLClZWTEEIRFlCPuPKfDa/md6ODh
 K8RmNSFznCTEtJf7mmI0T9M2+5d4fxQH5PaPpjx6u8qDYW+iCSRkTrTSLwvZmf1pRw7u8drI0
 QNjaCzHVxKubpbkXvN1g+oyxsfkD2oEDcuf+wO18DRhznMFvFZVbsqSZ2uQ1G/xWaf6g36ESg
 JJO71vg2xZvZ9UZyvXBHGizImq5vc1mtRzI42TrQ4+xxvRCB2ONTNJApm9V8M4KY90ssCAzHH
 s0o6LF2Nf+IIJQeHd6G95sqOE4GKmfGa2dcEjYhGd4t2hrcVXmodH+z1W5ICzVZJ/4kKgjFvX
 GVaRsLWespe7eTo9g1NUHa09wQABGekWvdMzvNTv8Bmok64JyH1BY1VZaoJ9brXUY/HmVqU6Z
 04CY2VaYc2dib2Jz9BTtYYNwVWXkAtILXdgv9Kl2PBcmBSgud1is7F2hWjWRrHUBJNEap7411
 0oggv2G25C3kvksJBxBovVzj4I7qz1jjb9dKiadE37cwadWWb0iLg8u3rHNYORn65a5iRkR4H
 BuNdyi/0es67JVGnMDWBbUBqeYjxnZB7tFVaUvr/dQWhQNzvlHM3qHleewcBffJXvApdd2usF
 xAeIKxHszSL8KeR+JsVMQmnZ6lQIS2C8kTqJwUBJ5Xgu7FaxrnekwvasuvtMMQ7pOap9eEtg9
 PzH+dBEZSLMLKX+cuOf+mcnMxTGvNz0glQ35+YtCUQ3w1IYgECAU9+EVjIaSsqGT71I1jS26m
 R/OX1uPs4uyOXTeTUYDE1fnS098z4NK0PXNKdKQ5D4lwz36vYjSBaz76bs3x1EO7LjB9VUTl3
 giYHK/boTG0UX5qRuX9fDfw9VhU=
Received-SPF: pass client-ip=212.227.17.22; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Use the new MMU_INDEX() helper to specify the index of the CPUTLB which
should be used.  Additionally, in a follow-up patch this helper allows
then to optimize the tcg code generation.

Signed-off-by: Helge Deller <deller@gmx.de>
=2D--
 target/hexagon/cpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
index daef5c3f00..b4cf9f1a7d 100644
=2D-- a/target/hexagon/cpu.h
+++ b/target/hexagon/cpu.h
@@ -51,7 +51,7 @@
 void hexagon_cpu_list(void);
 #define cpu_list hexagon_cpu_list

-#define MMU_USER_IDX 0
+#define MMU_USER_IDX MMU_INDEX(0)

 typedef struct {
     target_ulong va;
=2D-
2.41.0


