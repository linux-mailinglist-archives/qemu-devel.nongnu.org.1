Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C99173CA9B
	for <lists+qemu-devel@lfdr.de>; Sat, 24 Jun 2023 13:30:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qD1Sl-0003zZ-5S; Sat, 24 Jun 2023 07:29:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qD1SE-0003ob-MP
 for qemu-devel@nongnu.org; Sat, 24 Jun 2023 07:29:22 -0400
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qD1SB-0001rm-SF
 for qemu-devel@nongnu.org; Sat, 24 Jun 2023 07:29:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1687606156; x=1688210956; i=deller@gmx.de;
 bh=mKPc0BwDQ588kUwJ1eBduivpwW8my9dNKTD9hZSkFGs=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
 b=jhiSvcemr9WblTxZkOY/fFm+xIBDy+w8FOXOpH/T71h8OTe2tLFGwoC1VFk+Ak1Zu6/GTL+
 3bFzNLeqjzJCqK8TaWXtDb1cTdXxnYPcDab3ds9ROimYvI6A3/QGSXZSjVjwtFjNt5oabuCvx
 t71k4RyGRrTCocOPTDq/gArNya9ELYp4usDC+YtZL2JAJ/jHsB+GYezlE8goAO8Bnv3qHW7yb
 np1d/dximO2AucHe/Q+DFSQYlEGyBwxkBi70/6F1RkcvvlkTbsZ7OaVMfJJEnaMPGtGD5t2ds
 wOsRXKNTmLD89rGncr0XAHMQuscMaFPyGYl5VxViydzi/ysbqaUA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100.fritz.box ([94.134.156.152]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MhU9j-1pYzXj0Gx9-00egcF; Sat, 24
 Jun 2023 13:29:16 +0200
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Helge Deller <deller@gmx.de>
Subject: [PULL 0/3] Hppa reboot fix patches
Date: Sat, 24 Jun 2023 13:29:12 +0200
Message-Id: <20230624112915.27033-1-deller@gmx.de>
X-Mailer: git-send-email 2.38.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1SCoVw16t/524n9ZtWdXMnw3kAAWJCu2Wm9IT1UwK+1xMA9DTu3
 gsgLHsB63xsBuV7nyoHNYF0yJQ84RSLPOktNpJAa0dwZHmVvyD32GWkO4/y2Ol1dlR6igjR
 eiaAXFsVCJ8HsaY1nhfTf5H+y8PVxMN0gX9k82etBoteAagtRUSyJy+LkWVKIbaw8lyHb3e
 +lrzNh7gHbSlVLeabz+1g==
UI-OutboundReport: notjunk:1;M01:P0:s6QZahGrokU=;+CVq5HL0lgzsiM5OLcorrfhumS/
 lChJRboUHhVB/11GHpmUxs382hXGy2vdKB2H4srzLfFv26wTIVE7vUHsLq47UDz1YIuwv8TAJ
 RbWI2ejg+OjoqWwaN8h30lUUgSOklPF/4iSEES/jpjh2jwU1IFjKjnSsZK/V0xZ5/f7sBCUk0
 b0usIu6rgkfp7wEgnA99exWIeuVt4u/wUawHBZaPVdriR7uCUQRXP2setNjXmw08vAU3anRDc
 JlB5SnHl7b5aI8s0ZyXvPw2xtM3UFht0X9XGCo3Oz2qZFIOFFC5gZvFCDAiYFYzIcJmBDBjkM
 GX20k/KC4bQJ5m5Pw/EJOETmDIXbR+cs8Yl4s76c8Ypj3fHGGS4ZU427CFmskDrFEJfBHo4Az
 qNZIkNNhkQPZlsTLdndGUxXEzbhimQKI6x0Os4G6RzQIrCTxr4JDk51/S/skgg1BKnzy/dqbU
 0KLulOnaUWlay6TENmIxkTaP4NA+6jQkaFlB+t3rTL5TXZ4PsKJU8lLqSpAGhToY6XOs9vXSo
 w37wr3rd3Y8nAxbsJHH7M36DY8nsN8IRNf8yf1c1j0K9xNvNUVWCZ/+5AWIObIoM5nAhn2sg/
 WajUH8xSj+t1K2EbExy5w9vAo8fbRXTDoGiRrHP13Kw58xKzl7XyQivv4HJVP8Pat70rU0bf6
 8V3R5YXR9N7kdGu9PXIhS1z9yQfoUUpyTkrX1ULg2w67NUsBdja5V39eQYgDNf3VPcHWxXqlV
 C2CgEWYTCW2dczyhYSNJML6xnds6YBr5HomQo17tYnrslotDaO+kXOnyqw4y/2riJbwUrRI5P
 WqQqB4irtuSXllLkUVpYKfA3n3palNAh1RCmNDnrPITSf36KE17aS+oAsz74DDSxBpvet7jXa
 sFfdOnLQsJV9vCvPSlnJqesRXTnJgn+YRRFNG9r5aRTUZcydFxXHO38lAjwYbDtj54e08dBWq
 lL76s5wzWCwtM4rXufkiO90Nxe8=
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

The following changes since commit c5ffd16ba4c8fd3601742cc9d2b3cff03995dd5=
d:

  Revert "cputlb: Restrict SavedIOTLB to system emulation" (2023-06-21 07:=
19:46 +0200)

are available in the Git repository at:

  https://github.com/hdeller/qemu-hppa.git tags/hppa-reboot-fix-pull-reque=
st

for you to fetch changes up to b9bed0896e8352a340188e32bee69988209e4f72:

  target/hppa: Update to SeaBIOS-hppa version 8 (2023-06-24 11:45:52 +0200=
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


