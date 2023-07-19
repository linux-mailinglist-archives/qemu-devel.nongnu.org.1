Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F48759A3D
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 17:54:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM9Tv-0006zh-OD; Wed, 19 Jul 2023 11:52:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qM9Tq-0006zC-6S
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 11:52:46 -0400
Received: from mout.gmx.net ([212.227.15.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qM9To-0006NJ-2Z
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 11:52:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1689781957; x=1690386757; i=deller@gmx.de;
 bh=RExEh8gbKD44Bsl7EWTuRgemBQGP5ogRpAJ78Yqde6c=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
 b=ZrsnSkyTiSyMoTPBFl6Fju2L2WMWafaanaJBKPA2sR9p4ISXIAwTJhkgTggkxYOim2d1B4Q
 PSciwplDC3B/e/mneif5gOWhw4sSiBn01XyG2XMJTdcUXE0NvezA2t6Y8osZYLje9pv0hYtVh
 Qw+XHvi2CQU4afF6xNn06S4pVyzFOPnXLn4JmCIqD4ERRQEIgzOwSfmlR0CY0xGDcFLnAfncr
 7pTiGFxwRqSc9CUTTBV/ZR1HZRnDzxO2N43yt9TKeUJuIHSInYo9hPl3dysuiwjL9rLSpWMkI
 JdkWVFia++rsSGRJvNLoEJ7HcwGt6sCDNL8w8xfbqyj4S3cwuldw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.145.157]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MQMyZ-1qZiFw18gD-00MOGN; Wed, 19
 Jul 2023 17:52:37 +0200
From: Helge Deller <deller@gmx.de>
To: Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Andreas Schwab <schwab@suse.de>,
 Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PULL 0/5] Linux user brk fixes patches
Date: Wed, 19 Jul 2023 17:52:30 +0200
Message-ID: <20230719155235.244478-1-deller@gmx.de>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tfzl/fP+REA+v07VDzA5sTFxwMD6LkcPje0Xwho0e1P0rZRDRSF
 YdZfKXcKb6stM661uglZEj1LV6cZZjG6WxAq7JUBNfyezpsM7duxV6WVMS9522xs9LsV7pA
 HsiqNUXEbqIevk6Hg+ZiW6xRAjOUBODJKXrgiDn9h0jM/K8+vrzn+sZLD5YxtTakSFEOJag
 k7Jaasmy64Il0EwStP5mA==
UI-OutboundReport: notjunk:1;M01:P0:NAb3rbDrLyQ=;vv8oS3A/iyIHU6FqCPQinodXTTH
 ipY0mNcRdgjrKS+YgK6t2R0gr8SgLjLVOquERPqg94haXkhagHxd+nxp1MBnSACR1WPkBtx99
 HXwoCv8+/EuBAUNoSSF6X4+TaxbKh/ZjUFNURGrhFDQJHdrSuOPhWg6Bb6S8i1lM2ymG6WlMy
 wjJX7XLwDRq/EQp7RPXnmo4WQw2/a/T2bGfMrMgi8RVVAyinS9cazdWAJNQAB/AVQHjVR7lSh
 GFeCxMITSrHD+aHzuLDDy2LHKEYQzkkZIndLFNYO7m4YkMs1SNY/sk6EuUIivsW2ESj/No/fx
 D4tXWH5c2nFbnOdh+6GXrYXp/pNTNidn7P71zkazOBIgAYCEcU8mWJxiNwBmW75fjXX4t9wK7
 dsulYWnTaO61XQkeAyAkK8nbvDFf+S/9NEPd7LYtToI1CI9zD9yk5/Mc0IppC8myubPEnvIE2
 nqTBuI98PlyTWCNBPlXMhplqrwyhEPXG+/hA4g7+dVaQtetBZZoZTk9bZib0LJLF95H+BA4Lj
 lTJEVz8l5tsSpZNthzI1jlX6DbBQ2JNn+Jugzfk1nvfl5yJA3bJJtMgh2tc1TIx5Gfui3Kjhw
 ka1g1NlP6xrXqjft+UxnuWgQVi+LAIM5LnmOyoQktUtrV9VmcSswp3e4ImmmDdU0l8zrwEQ9S
 ZfkYgpR2etnqfz+S5rJ1KKhGvKy3K78i3TOlot+OgkU/XCXH8pmS5JD+ebbeemUv9Dv7QpjIh
 tZc0VP1s1pDi1tP15D3mlBbR68yVnKaF+m+lcGq5Hff0U/lYkqNDJe96Rj5lfvtyivJ+EuIIU
 SLasMKFILRYwlSYXimlwqqXIerI/xgDmZWQ4sRckSC3xpmNoNFxItpLdamd6QW9etM7enKF67
 4b0hp9WC6DIrII0fZ8dc522Ye8JigTqqBEYvNVn/6OrUe2bYMiKdn5Fw9oYcbfsx5XLG61WgU
 n/1EjMS3KPVr51PuF3Y14I0syV0=
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

The following changes since commit 361d5397355276e3007825cc17217c1e4d4320f=
7:

  Merge tag 'block-pull-request' of https://gitlab.com/stefanha/qemu into =
staging (2023-07-17 15:49:27 +0100)

are available in the Git repository at:

  https://github.com/hdeller/qemu-hppa.git tags/linux-user-brk-fixes-pull-=
request

for you to fetch changes up to 518f32221af759a29500ac172c4c857bef142067:

  linux-user: Fix qemu-arm to run static armhf binaries (2023-07-18 20:42:=
05 +0200)

=2D---------------------------------------------------------------
linux-user: brk() syscall fixes and armhf static binary fix

Commit 86f04735ac ("linux-user: Fix brk() to release pages") introduced
the possibility for userspace applications to reduce memory footprint by
calling brk() with a lower address and as such free up memory, the same
way as the Linux kernel allows on physical machines.

This change introduced some failures for applications with errors like
- accesing bytes above the brk heap address on the same page,
- freeing memory below the initial brk address,
and introduced a behaviour which isn't done by the kernel (e.g. zeroing
memory above brk).

This patch series fixes those issues and has been tested with existing
programs (e.g. upx).

Additionally one patch fixes running static armhf executables (e.g. fstype=
)
which was broken since qemu-8.0.

Changes in v2:
- dropped patch to revert d28b3c90cfad ("linux-user: Make sure initial brk=
(0)
  is page-aligned")
- rephrased some commit messages
- fixed Cc email addresses, added new ones
- added R-b tags

Helge

=2D---------------------------------------------------------------

Helge Deller (5):
  linux-user: Fix qemu brk() to not zero bytes on current page
  linux-user: Prohibit brk() to to shrink below initial heap address
  linux-user: Fix signed math overflow in brk() syscall
  linux-user: Fix strace output for old_mmap
  linux-user: Fix qemu-arm to run static armhf binaries

 linux-user/elfload.c |  7 +++++++
 linux-user/strace.c  | 49 ++++++++++++++++++++++++++++++++++++++++----
 linux-user/syscall.c | 23 +++++++++++++--------
 3 files changed, 66 insertions(+), 13 deletions(-)

=2D-
2.41.0


