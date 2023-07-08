Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 422A374BDF0
	for <lists+qemu-devel@lfdr.de>; Sat,  8 Jul 2023 16:58:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qI9NX-00061I-Rt; Sat, 08 Jul 2023 10:57:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qI9NI-0005zt-1x
 for qemu-devel@nongnu.org; Sat, 08 Jul 2023 10:57:28 -0400
Received: from mout.gmx.net ([212.227.17.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qI9NF-00034Y-7E
 for qemu-devel@nongnu.org; Sat, 08 Jul 2023 10:57:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1688828241; x=1689433041; i=deller@gmx.de;
 bh=oVA7DOmdo4bxdT4W+7xeCgzvc45ieCdprU3mDyZaow0=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=C0Gc/CO+RJi5O6kyGMgRvYcUCTO6EEJ5M/utdU6kK9VENZ3syeC8wQIAO9PwTeXarNqN6vv
 0F84+VJPZlOj+P+LUL385DefNdu/AeK36y0+if3rstqbr/k3+hN6IURIixz0kaNfdvxmCYn6O
 ztPrgupuQldHjhjusqW85B1zvx4Ntcd+6Xp3R3zB9C8+DvPodbOQPCSBpCi3ejkDsxKbdnimW
 VAzcKNC5CVf5pIKyc120UnXX1buyUSrYE7KFtviA5XRwPt/sLmcTdmCxx8PEA8d/Iyi96AWhs
 jg/+okcKjQ0DnKDRFye+LQzjLEPqreWTRa998CDjh644j2BYRcbQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.155.129]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MrhUK-1pfk9t26NQ-00nfDH; Sat, 08
 Jul 2023 16:57:21 +0200
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Helge Deller <deller@gmx.de>
Subject: [PULL 1/3] linux-user: Fix fcntl() and fcntl64() to return
 O_LARGEFILE for 32-bit targets
Date: Sat,  8 Jul 2023 16:57:18 +0200
Message-ID: <20230708145720.136671-2-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230708145720.136671-1-deller@gmx.de>
References: <20230708145720.136671-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:r34w/tBWaiV3ww68WP1NIIzPRxUQU7kgChub+yBr3V+ACEa5SjJ
 8v6zUAgnFfjgjSQ0S0qLCeojG2cU7MqEkS80ceBsxX40R2fHFFOCvap5ZyHnSPyWrwRmXro
 6WeLSPPDaEP2fzLOsT2jDCksv6VTNxXZ2TQ3l7R3L+Nd6mo17pTMQrV293HCpYRV5PKoezA
 19u67vLlcU4/ln8ZhNF/w==
UI-OutboundReport: notjunk:1;M01:P0:yIMBPfIcWdE=;lL8Dt4C4rW8X4WGLV+KDUDebctm
 Et64BPxDqELxJDxkMELI0bg/IP4/kQz8iRkrRKiOLgZepICc2ldua+AVGBgX1lKTgMowDVcmp
 dCtMVp3ToCR2pOvj+9PamUTXOBNTyEdQXm+HkHC83v54lb8aEG/C/S9sMVH46PhloMQu5aYcm
 MUJelxuhvWZBSgTQL4yrzUeq03fwTjXHyTkjQBiVAWyT35cre+aw1NIT8rVeusb+8WtnI0PHz
 sIE/SQLD4W1MWpV9ysm61FXEGH6hk7VNkIe+QIvCQIEddZlTytajjhSvyXTcWOzFa3JoFfYwK
 Gm0apSoAJMvCNI7GUzje64Y0r51To/ScxeeZi7y1vEYmMZfxFwhoG785QFXVOqAsYQcBUH9mY
 zKlcPZFzgfF+V4CHhveST1D5LqL/RVZ4zF0zVPUMTvwsHhiGeKbSTeFSaaOhhoAfvorGfQsXG
 tnVeucwwp2rX97xqEAutY4ZWAPOBhvT3+T+AVgjBT5nR3gK7CMg0wZF7GdXEVjNxdUhhqQexr
 g4C4EKWiAkG+vqlgNO3XIcDG2fEwnL8eM9BYUjAHFjmrfQKC2OygpcPu3PvAY9JfL+ot01Gy9
 Qhk0RUg/5E9kJyVn+zAhM7OtYIBGBiwLaBp01uORB+znQ08vfJwCbnMs3kWTX4geyG1e/j7Tu
 F9xfNHuYfpHs4ytV6t0zsq8H0NoWB4DoYQmBtD8krK7WvgRtJK3/d48+mu4eGJoGUr8ZZWz/2
 uBdO9BvHB2a9kqJwCqplpYGTvyumqm4m/6stPHsOvtC3qePEMZKCPUCvy+enlhTmQewNBjtFI
 5x7/WIGPZ8Y01nKSqC3IpSbDfrR07LFaZWwyC0luaG5q21LC8qCZE99nnC+6Q74RTtzcPSAab
 n41/5xuuVKrfOLLobCZ3+9mW6P5cPscJJ6T8hsLcPFW9RjzJ/E39xCGHImC0564kNAyN6tjRO
 tJKdrvnnVK3c4l0lhoucFPgN6Z8=
Received-SPF: pass client-ip=212.227.17.20; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

When running a 32-bit guest on a 64-bit host, fcntl[64](F_GETFL) should
return with the TARGET_O_LARGEFILE flag set, because all 64-bit hosts
support large files unconditionally.

But on 64-bit hosts, O_LARGEFILE has the value 0, so the flag
translation can't be done with the fcntl_flags_tbl[]. Instead add the
TARGET_O_LARGEFILE flag afterwards.

Note that for 64-bit guests the compiler will optimize away this code,
since TARGET_O_LARGEFILE is zero.

Signed-off-by: Helge Deller <deller@gmx.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
=2D--
 linux-user/syscall.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 08162cc966..10f05b1e55 100644
=2D-- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7132,6 +7132,10 @@ static abi_long do_fcntl(int fd, int cmd, abi_ulong=
 arg)
         ret =3D get_errno(safe_fcntl(fd, host_cmd, arg));
         if (ret >=3D 0) {
             ret =3D host_to_target_bitmask(ret, fcntl_flags_tbl);
+            /* tell 32-bit guests it uses largefile on 64-bit hosts: */
+            if (O_LARGEFILE =3D=3D 0 && HOST_LONG_BITS =3D=3D 64) {
+                ret |=3D TARGET_O_LARGEFILE;
+            }
         }
         break;

=2D-
2.41.0


