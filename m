Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5361672A995
	for <lists+qemu-devel@lfdr.de>; Sat, 10 Jun 2023 08:59:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7sY4-0002dW-EA; Sat, 10 Jun 2023 02:58:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1q7sY2-0002c4-7X; Sat, 10 Jun 2023 02:58:06 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1q7sY0-0005tV-6r; Sat, 10 Jun 2023 02:58:05 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 4ADABBE20;
 Sat, 10 Jun 2023 09:57:59 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id D2791B28D;
 Sat, 10 Jun 2023 09:57:58 +0300 (MSK)
Received: (nullmailer pid 1107492 invoked by uid 1000);
 Sat, 10 Jun 2023 06:57:58 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-trivial@nongnu.org
Subject: [PULL 00/16] trivial patches 2023-06-10
Date: Sat, 10 Jun 2023 09:57:38 +0300
Message-Id: <cover.1686379708.git.mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

Hi here!

This is my first pullreq in quite some years.

It looks like there has been quite some trivial patches which were forgotten,
so I thought I'd give it a shot at least.

And since I haven't done a PR in a while, I basically forgot how to do it
properly :)

Please note: there are 2 patches in there which are *not* reviewed.  Being
a trivial-patch collection, they're "obviously correct", - namely these are
spelling fixes ("information") and adding comments in linux-user/syscall.c.
If that's not okay, let's remove these 2 changes and apply the rest.

Thanks,

/mjt

The following changes since commit 5f9dd6a8ce3961db4ce47411ed2097ad88bdf5fc:

  Merge tag 'pull-9p-20230608' of https://github.com/cschoenebeck/qemu into staging (2023-06-08 08:47:35 -0700)

are available in the Git repository at:

  https://gitlab.com/mjt0k/qemu.git tags/trivial-patches-20230610

for you to fetch changes up to e928907105cfeb48b68cedce232bbd4784536707:

  linux-user: elfload: Specify -R is an option for qemu-user binaries (2023-06-10 09:40:46 +0300)

----------------------------------------------------------------
trivial-patches-20230610

----------------------------------------------------------------
Anastasia Belova (1):
      vnc: move assert in vnc_worker_thread_loop

Andrew Jeffery (2):
      linux-user: elfload: s/min_mmap_addr/mmap_min_addr/
      linux-user: elfload: Specify -R is an option for qemu-user binaries

Carlos Santos (1):
      meson: install keyboard maps only if necessary

Mattias Nissler (1):
      hw/remote: Fix vfu_cfg trace offset format

Michael Tokarev (4):
      hw/virtio/virtio-qmp.c: spelling: suppoted
      spelling: information
      block.c: add newline for "Detected format" warning
      linux-user: add comments for TARGET_NR_[gs]etgroups{,32}

Milan Zamazal (1):
      docs: Fix trivial typos in vhost-user.rst

Peter Maydell (1):
      linux-user: Return EINVAL for getgroups() with negative gidsetsize

Philippe Mathieu-Daudé (5):
      target/m68k/fpu_helper: Use FloatRelation enum to hold comparison result
      hw/core/cpu: Simplify realize() using MACHINE_GET_CLASS() macro
      hw/i386/microvm: Simplify using object_dynamic_cast()
      hw/pci/pci: Simplify pci_bar_address() using MACHINE_GET_CLASS() macro
      hw/usb/hcd-ehci-pci: Simplify using DEVICE_GET_CLASS() macro

 block.c                            |  2 +-
 docs/system/devices/vhost-user.rst |  4 ++--
 hw/core/cpu-common.c               |  3 +--
 hw/i386/microvm.c                  |  3 +--
 hw/pci/pci.c                       |  4 +---
 hw/remote/trace-events             |  4 ++--
 hw/usb/hcd-ehci-pci.c              |  2 +-
 hw/virtio/virtio-qmp.c             |  2 +-
 include/ui/clipboard.h             |  2 +-
 linux-user/elfload.c               |  5 +++--
 linux-user/syscall.c               | 12 ++++++------
 pc-bios/keymaps/meson.build        |  6 ++++--
 qapi/cryptodev.json                |  2 +-
 qga/qapi-schema.json               |  2 +-
 target/m68k/fpu_helper.c           |  4 ++--
 ui/vnc-jobs.c                      |  3 ++-
 16 files changed, 30 insertions(+), 30 deletions(-)

