Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C25FB73CAA9
	for <lists+qemu-devel@lfdr.de>; Sat, 24 Jun 2023 13:51:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qD1mV-00010g-Gz; Sat, 24 Jun 2023 07:50:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qD1mS-0000zf-Ox
 for qemu-devel@nongnu.org; Sat, 24 Jun 2023 07:50:16 -0400
Received: from mout.gmx.net ([212.227.15.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qD1mM-0001AT-B5
 for qemu-devel@nongnu.org; Sat, 24 Jun 2023 07:50:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1687607408; x=1688212208; i=deller@gmx.de;
 bh=N8SwPzJASu1Yi2qKT1wUux1VMwUAUTUlWBbPSQrGdFo=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
 b=BeMrX9T2fA/x4aLYSX8qaQmDiOXc+fbKCe0l+NXVT3mvYqfRqGuJdPaR2v9DwWJqjO8rJk9
 oGZCcDA1S1xckF0bEvwefn10+QeeoOrwZASvz+PTzxm0A3ryKJmF5wWXiaTZ+ilifuicIA+zl
 BlI2Kz112i/uFBcRZ/7x+ugCSfChVV2Z4F4QcbDa6sxDLek5RMWn35RYpklmguQU6S/sn14bD
 3PT4iBJ1g/pSXXa2FTNV6qz1OEOKSQATZpemWQsnPsmdJKayrsBlbMPgCJLMh+4Qh5AYUV2+t
 zOhR1Cbu9PLcdAIghuLVtAI6wUet07XbJRkGlj/PhMz+KuV1mplg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.156.152]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MvK4Z-1pvUze3n4T-00rEZd; Sat, 24
 Jun 2023 13:50:07 +0200
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Helge Deller <deller@gmx.de>
Subject: [PULL v2 0/3] Hppa boot reboot fixes patches
Date: Sat, 24 Jun 2023 13:50:04 +0200
Message-Id: <20230624115007.30332-1-deller@gmx.de>
X-Mailer: git-send-email 2.38.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3RaeTA2W8pJjcupULvjXk4tLAeVLWYztusees9HmvqQ3pnvz3Nc
 6TAtdv1VVzwujtFM5TEo0yuR8QdYE6VVvnUgunlsciLkkEAvMvorIyfuYJ4L0dZ4k/6n7P9
 A62qKCc9rHOgdLJ84LyZqmNHKZSMUI2MFlcdGdADmGmDysa3e+F9RuHH8y5v7+UyEEfO8c+
 CrOhdtJzsuCiQMrNAppOg==
UI-OutboundReport: notjunk:1;M01:P0:RPuP9chMffY=;gek1yPSA0uPHfAX/1juihC7cXgx
 8kKFpkqjiWC56XQQPx0PdxsrLJTrvq9PTVMpypz9WUJauRXMOyecSl7pupWAY9bpu+gEDJBdf
 sUzeOaQZDc3wTR0yxdp4SLfQOBNFH1TR+GtXfs93Y9CRzWIcphzBkIEGdsvy9ixexNxQICEOK
 PXBExCBOK9pdsxxJbpGneBmBl3FO3kT5QKLrOqITr+ogbUFpAWjExgrZgAhpymVvOQQgmm+at
 joy715aTx2d7Q3oHCQmA89s7uEyK69KjfNcSrUzQp9UgGvRSb7LpY+d4zFlKAKWEx6RC9O8zS
 z/tVh23A36haLduIIJ06nCQ6bmc5tStiwoUS3NbcTc377RA3+08UVvqv4dOg3gKKR934ij62U
 K5qrdQ+5a0+zaWlaFXyL8NbAZ4xqQaRqFsu5KK5qwRcpQNMxNynwnPn2+BJSEQr8jJGJfsfpZ
 wVC/4gHRihtmc4jUJ2cXiLQghuLC168b5guradLWhPF/UDyzrCCfvK0p/6Hu1tfILoMyKe2S7
 LeWe2A6INjvA4ihOdznGNbfcxSg1Cmp0IL6GEiaL3StDwkG67sMgpnOuJp5RU6DUnBt+/OngU
 8U0IspuVT2EasUAEKjfsRKg8cnzX+ltQLd8LA0hiuos4sHR/PzIIEVNKT79xM8nac4KVzrVjU
 p8gQ6KsVKUOYCqz9OX3F0OfPU3MIClIsyzSMrhNz1bqlzmjxjEAMhraOJST2yo17iANrMMsRx
 vdBXjDGnc1RwQgOJCrq3GHUTq8H/4RBV0P+IpUxaKPJ0Gct4npqgtAfJVDsCcf7IzFqdL1QLd
 fWFZ29aq51klp/Jchim2+nAjobF9RRbhW9/svbqPWQvMLNSbCmCOKIJUjSeKSwviX08kbDndo
 fQyrZ1W6HUAdp50gx3AcCI/g8VSj/YQEYPJQGfJfbpv0CwyUNPoRYIClsmMQIM5zelXCiF+zm
 Kvu51dHLN43vlvaXeSFMgAirJTY=
Received-SPF: pass client-ip=212.227.15.15; envelope-from=deller@gmx.de;
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

The following changes since commit b455ce4c2f300c8ba47cba7232dd03261368a4c=
b:

  Merge tag 'q800-for-8.1-pull-request' of https://github.com/vivier/qemu-=
m68k into staging (2023-06-22 10:18:32 +0200)

are available in the Git repository at:

  https://github.com/hdeller/qemu-hppa.git tags/hppa-boot-reboot-fixes-pul=
l-request

for you to fetch changes up to 34ec3aea54368a92b62a55c656335885ba8c65ef:

  target/hppa: Update to SeaBIOS-hppa version 8 (2023-06-24 13:39:48 +0200=
)

=2D---------------------------------------------------------------
target/hppa: Fix boot and reboot for SMP machines

Fix some SMP-related boot and reboot issues with HP-UX and Linux by
correctly initializing the CPU PSW bits, disabling data and instruction
translations and unhalting the CPU in the qemu hppa_machine_reset()
function.

To work correctly some fixes are needed in the SeaBIOS-hppa firmware too,
which is why this series updates it to version 8 which includes those
fixes and enhancements:

Fixes
- boot of HP-UX with SMP, and
- reboot of Linux and HP-UX with SMP

Enhancements:
- show qemu version in boot menu
- adds exit menu entry in boot menu to quit emulation
- allow to trace PCD_CHASSIS codes more specifically

Signed-off-by: Helge Deller <deller@gmx.de>

=2D---------------------------------------------------------------

Helge Deller (3):
  target/hppa: Fix OS reboot issues
  target/hppa: Provide qemu version via fw_cfg to firmware
  target/hppa: Update to SeaBIOS-hppa version 8

 hw/hppa/machine.c         |  15 +++++++++++++--
 pc-bios/hppa-firmware.img | Bin 719376 -> 720216 bytes
 roms/seabios-hppa         |   2 +-
 3 files changed, 14 insertions(+), 3 deletions(-)

=2D-
2.38.1


