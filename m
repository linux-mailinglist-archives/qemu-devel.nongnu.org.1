Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F5E7F2778
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 09:30:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5M7x-0007x8-Ns; Tue, 21 Nov 2023 03:29:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aik@ozlabs.ru>)
 id 1r5M7u-0007wk-HU; Tue, 21 Nov 2023 03:28:58 -0500
Received: from ozlabs.ru ([107.174.27.60])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aik@ozlabs.ru>)
 id 1r5M7s-0004zI-Fg; Tue, 21 Nov 2023 03:28:58 -0500
Received: from ole.2.ozlabs.ru (localhost.localdomain [127.0.0.1])
 by ozlabs.ru (Postfix) with ESMTP id 31FDA8327C;
 Tue, 21 Nov 2023 03:28:52 -0500 (EST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Subject: [PULL SUBSYSTEM qemu-pseries] pseries: Update SLOF firmware image
Date: Tue, 21 Nov 2023 19:28:47 +1100
Message-ID: <20231121082850.60833-1-aik@ozlabs.ru>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=107.174.27.60; envelope-from=aik@ozlabs.ru;
 helo=ozlabs.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
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

The following changes since commit af9264da80073435fd78944bc5a46e695897d7e5:

  Merge tag '20231119-xtensa-1' of https://github.com/OSLL/qemu-xtensa into staging (2023-11-20 05:25:19 -0500)

are available in the Git repository at:

  git@github.com:aik/qemu.git tags/qemu-slof-20231121

for you to fetch changes up to b6838bf9c01c32bfecd5c446c98e788bbfd467d9:

  pseries: Update SLOF firmware image (2023-11-21 19:11:31 +1100)

----------------------------------------------------------------
Alexey Kardashevskiy (1):
      pseries: Update SLOF firmware image

 pc-bios/README   |   2 +-
 pc-bios/slof.bin | Bin 995176 -> 995000 bytes
 roms/SLOF        |   2 +-
 3 files changed, 2 insertions(+), 2 deletions(-)


*** Note: this is not for master, this is for pseries

Just an update, nothing major. Thanks everyone for keeping
an eye on this!

Compiled with  gcc-12.1.0-nolibc

Tested with:
 /home/aik/b/q-slof/qemu-system-ppc64 \
-nodefaults \
-chardev stdio,id=STDIO0,signal=off,mux=on \
-device spapr-vty,id=svty0,reg=0x71000110,chardev=STDIO0 \
-mon id=MON0,chardev=STDIO0,mode=readline \
-nographic \
-vga none \
-m 4G \
-kernel /home/aik/t/vml4150le \
-initrd /home/aik/t/le.cpio \
-machine pseries,cap-cfpc=broken,cap-sbbc=broken,cap-ibs=broken,cap-ccf-assist=off \
-bios pc-bios/slof.bin \
-trace events=/home/aik/qemu_trace_events \
-d guest_errors \
-chardev socket,id=SOCKET0,server=on,wait=off,path=qemu.mon.60616 \
-mon chardev=SOCKET0,mode=control \
-name 60616,debug-threads=on


The complete change log is:

Alexey Kardashevskiy (3):
      Remove ?PICK
      version: update to 20230918
      version: update to 20231121

Bernhard M. Wiedemann (1):
      Allow to override build date with SOURCE_DATE_EPOCH

Jordan Niethe (1):
      virtio-serial: Do not close stdout on quiesce

Kautuk Consul (1):
      virtio-serial: Make read and write methods report failure

Thomas Huth (10):
      lib/libnet/ipv6: Silence compiler warning from Clang
      Fix typos in the board-qemu folder
      Fix typos in the lib/libnet folder
      Fix typos in the remaining lib folders
      Fix typos in the slof folder
      Fix typos in the board-js2x folder
      Fix typos in the llfw folder
      Fix typos in the board-js2x folder
      Fix typos in the clients folder
      Fix remaining typos in various folders


