Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1B47A46AD
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 12:10:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiBCe-0001gh-5z; Mon, 18 Sep 2023 06:10:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aik@ozlabs.ru>)
 id 1qiBCI-0001eD-Fg; Mon, 18 Sep 2023 06:09:43 -0400
Received: from ozlabs.ru ([107.174.27.60])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aik@ozlabs.ru>)
 id 1qiBCD-0005K5-Qq; Mon, 18 Sep 2023 06:09:41 -0400
Received: from ole.2.ozlabs.ru (localhost.localdomain [127.0.0.1])
 by ozlabs.ru (Postfix) with ESMTP id B79E28026A;
 Mon, 18 Sep 2023 06:09:32 -0400 (EDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: npiggin@gmail.com
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, clg@kaod.org, danielhb413@gmail.com,
 jniethe5@gmail.com, thuth@redhat.com, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Subject: [PULL SUBSYSTEM qemu-pseries] pseries: Update SLOF firmware image
Date: Mon, 18 Sep 2023 20:09:29 +1000
Message-ID: <20230918100931.607341-1-aik@ozlabs.ru>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=107.174.27.60; envelope-from=aik@ozlabs.ru;
 helo=ozlabs.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit 005ad32358f12fe9313a4a01918a55e60d4f39e5:

  Merge tag 'pull-tpm-2023-09-12-3' of https://github.com/stefanberger/qemu-tpm into staging (2023-09-13 13:41:57 -0400)

are available in the Git repository at:

  git@github.com:aik/qemu.git tags/qemu-slof-20230918

for you to fetch changes up to b4f872c6bcbf71f60326988c76b240318c51bd16:

  pseries: Update SLOF firmware image (2023-09-18 19:14:44 +1000)

----------------------------------------------------------------
Alexey Kardashevskiy (1):
      pseries: Update SLOF firmware image

 pc-bios/README   |   2 +-
 pc-bios/slof.bin | Bin 995176 -> 995000 bytes
 roms/SLOF        |   2 +-
 3 files changed, 2 insertions(+), 2 deletions(-)


*** Note: this is not for master, this is for pseries

It's been a while. This fixes compile warning, typos and
a bug with virtio-serial being used after it was shutdown
at "quiesce".

The full changelog is here:

Alexey Kardashevskiy (2):
      Remove ?PICK
      version: update to 20230918

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

Compiled with gcc-12.1.0-nolibc

Tested with (sorry, no KVM):

/home/aik/b/q-slof/qemu-system-ppc64 \
-nodefaults \
-chardev stdio,id=STDIO0,signal=off,mux=on \
-device spapr-vty,id=svty0,reg=0x71000110,chardev=STDIO0 \
-mon id=MON0,chardev=STDIO0,mode=readline \
-nographic \
-vga none \
-m 2G \
-kernel /home/aik/t/vml4150le \
-initrd /home/aik/t/le.cpio \
-machine pseries,cap-cfpc=broken,cap-sbbc=broken,cap-ibs=broken,cap-ccf-assist=off \
-bios pc-bios/slof.bin \
-trace events=/home/aik/qemu_trace_events \
-d guest_errors \
-chardev socket,id=SOCKET0,server=on,wait=off,path=qemu.mon.604650 \
-mon chardev=SOCKET0,mode=control \
-name 604650,debug-threads=on


