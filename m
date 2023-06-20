Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7558B737573
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 21:59:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBhUf-00046z-9b; Tue, 20 Jun 2023 15:58:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qBhUd-00046o-EP
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 15:58:23 -0400
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qBhUb-0005tw-I2
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 15:58:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1687291098; x=1687895898; i=deller@gmx.de;
 bh=DCO3iDCFG5Bwc9Aw25OAiYJnx9sM0oY/um9SZT3X4mw=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
 b=gNy1IYS+NIe9HY8LQvbBa7yWltgnFm5onrhtOIhA4zBVG43gULHaauOOxgseElUNQeaSkFo
 kHhiYJ/tc85ZIBqmKu7DwBr+dS3tKUZReZPbvX1ZPesuU7PIWtFgvrJqancS1vZAwU/lJFuVf
 S3AiOL9RcFyI+xpfnK3ERIgF4CSnTGL3SQY5ba4+Z38JmEO3BBKh7EHTqJGFOdm1e94PXI7WC
 d925bYPKCHeOe/Q/F4+i7ECVuc1jpyESxEUYtzkcMTXmxxOQ+rOAF88fvA35x9y2YeWVKBtpn
 1GToakqJWCSgj2LKNvjPxUBkPQW5XpZAGh2S/kFHHh5Q6OTcmy8A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.157.8]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MZktj-1qYdvq3w6p-00Wk4q; Tue, 20
 Jun 2023 21:58:18 +0200
From: Helge Deller <deller@gmx.de>
To: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PULL 0/1] Seabios hppa v7 patches
Date: Tue, 20 Jun 2023 21:58:16 +0200
Message-Id: <20230620195817.119401-1-deller@gmx.de>
X-Mailer: git-send-email 2.38.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aWHndqyc77O2ffq2ss6tsx2Ez3iGAoEefFXpits5uB328BqPrsU
 cax/+xUYbp+pEOY8w9Eqzw5USkv5ZTniQyjN4leIj9Tfw7TUsYST3+AlAgSEAxOViaBxVK8
 PiBM1Zx9eOEyk1x/GvC1DKhOVigHqt+Cg2hJQsJZAsJdkrIqYE548ALscPpLUJ1DEMbQVCf
 O61/rez9p2REfsbwrxO1Q==
UI-OutboundReport: notjunk:1;M01:P0:TefMXmOZoFU=;Y1bUDiXfOrxwGb1ABvr0vRuErAL
 l9dBKK6v3pp5mUvRP3TiX4KSrB7I7s8ZOIt64okrvArfdRXdgMtgtF0aVhzJUMBdl65j8z+A+
 ww0dbbyQ3v5JW3WRJVoLAQXHKA2HcbLwPx+BdUEAzF3buyy1eS+tkJLwXCwsrB+UVKwQtsJIe
 rrhqjyttxP5G663N0/N8IVV5636rMSrtwvpH6cH4VA2r3diukVOTO+bymrWTT3ltVtBXVE282
 xJxnGNlEy7/Tgp7D2u91uYZU970PVcbUiU0G5ft/rmuQYNmeH2efCHbSLPx6Hb4KqPk5IkjzZ
 8Hfob2hhBggYu2odgvTgYGDD+JaeAJ0ibx78L1vEziyfGrqCX/v2GvOiekXx+Ky9ekjAtmbis
 F44DINkKnpoE3I2xXth+jYL2guszXPCrIZgc3FQIn05Cg2dJ+ZA9y1+wpSYUc2/WOm3XukPoi
 mOJQ7W9hQW4QPvShmeB3tAh8HGnYsgN90cdKTfiiMWN6O8Gq55fGrQ2j3dtF4JAbiSO3vF/PP
 n6TjP+8r4soxqOJ9W+Lubk5TPro/jckR5VZgr3D7w313zMUElvx6LtZ0qnomrhaLpenmiwAPk
 ZaJziUctUBll3NTDXEv89iGDedOMJVWLPr4jfJYFmbBbl5pqgVbL1FPKF0KcLLK0jCM5IIJhj
 nQ476t2dWNCa8TaaQBHreeLzn6atFwMbdp+u/nwwz6LKQrRQD+NaTuciF4o4g/MQevMrTrXeV
 LKXs9HZQVGP0YBGUv63lii/9DXg7Mu3ESpdmBchgUOMqJezjWKxJroQ5cQ6ShueB8wHUkMsi9
 ccqN9pmFNKrl4koAzWnGuerxAoWQp4FTL9QPIjeQoClDZcY7IcjSSldt0WApqjBIC85dqVRm9
 RpGYsZKNxAS9FtS9MAhzwUoS0vqetWFt93SRUW0O2Wlttgb88MnfAQkimDuZ52AHOgvLSk53p
 JFjWEBsm6VLWsBjX3N0EB9wnbO0=
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

The following changes since commit 327ec8d6c2a2223b78d311153a471036e474c5c=
5:

  Merge tag 'pull-tcg-20230423' of https://gitlab.com/rth7680/qemu into st=
aging (2023-04-23 11:20:37 +0100)

are available in the Git repository at:

  https://github.com/hdeller/qemu-hppa.git tags/seabios-hppa-v7-pull-reque=
st

for you to fetch changes up to bb9c998ca9343d445c76b69fa15dea9db692f526:

  target/hppa: New SeaBIOS-hppa version 7 (2023-06-20 21:39:47 +0200)

=2D---------------------------------------------------------------
hppa: New SeaBIOS-hppa version 7 ROM

New SeaBIOS-hppa version 7 ROM to fix Debian-12
CD-ROM boot issues.

Signed-off-by: Helge Deller <deller@gmx.de>

=2D---------------------------------------------------------------

Helge Deller (1):
  target/hppa: New SeaBIOS-hppa version 7

 pc-bios/hppa-firmware.img | Bin 719368 -> 719376 bytes
 roms/seabios-hppa         |   2 +-
 2 files changed, 1 insertion(+), 1 deletion(-)

=2D-
2.38.1


