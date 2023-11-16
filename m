Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD407EDC55
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 08:50:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3X3X-0005kR-Es; Thu, 16 Nov 2023 02:44:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r3X3V-0005jx-DT; Thu, 16 Nov 2023 02:44:53 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r3X3T-0004pM-4j; Thu, 16 Nov 2023 02:44:53 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D66E133BD9;
 Thu, 16 Nov 2023 10:45:02 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 5FE8C3583F;
 Thu, 16 Nov 2023 10:44:41 +0300 (MSK)
Received: (nullmailer pid 3202486 invoked by uid 1000);
 Thu, 16 Nov 2023 07:44:41 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-trivial@nongnu.org
Subject: [PULL 00/27] Trivial patches for 2023-11-16
Date: Thu, 16 Nov 2023 10:44:14 +0300
Message-Id: <20231116074441.3202417-1-mjt@tls.msk.ru>
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

The following changes since commit 9c673a41eefc50f1cb2fe3c083e7de842c7d276a:

  Update version for v8.2.0-rc0 release (2023-11-14 12:35:47 -0500)

are available in the Git repository at:

  https://gitlab.com/mjt0k/qemu.git tags/pull-trivial-patches

for you to fetch changes up to f779357882b4758551ff30074b4b915d7d249d3d:

  util/range.c: spelling fix: inbetween (2023-11-15 12:06:05 +0300)

----------------------------------------------------------------
trivial patches for 2023-11-16

Mostly spelling fixes in various parts in code added since 8.1,
plus a few other tiny things (comment rewording, removal of unused
file, forgotten MAINTAINERS change).

----------------------------------------------------------------
Michael Tokarev (23):
      hw/audio/virtio-snd.c: spelling: initalize
      qapi/migration.json: spelling: transfering
      bsd-user: spelling fixes: necesary, agrument, undocummented
      linux-user: spelling fixes: othe, necesary
      hw/cxl: spelling fixes: limitaions, potentialy, intialized
      gdbstub: spelling fix: respectivelly
      docs/about/deprecated.rst: spelling fix: becase
      docs/devel/migration.rst: spelling fixes: doen't, diferent, responsability, recomend
      docs/system/arm/emulation.rst: spelling fix: Enhacements
      target/arm/tcg: spelling fixes: alse, addreses
      target/hppa: spelling fixes: Indicies, Truely
      migration/rdma.c: spelling fix: asume
      contrib/vhost-user-gpu/virgl.c: spelling fix: mesage
      hw/mem/memory-device.c: spelling fix: ontaining
      hw/net/cadence_gem.c: spelling fixes: Octects
      include/block/ufs.h: spelling fix: setted
      include/hw/hyperv/dynmem-proto.h: spelling fix: nunber, atleast
      include/hw/virtio/vhost.h: spelling fix: sate
      target/riscv/cpu.h: spelling fix: separatly
      tests/qtest/migration-test.c: spelling fix: bandwith
      tests/qtest/ufs-test.c: spelling fix: tranfer
      util/filemonitor-inotify.c: spelling fix: kenel
      util/range.c: spelling fix: inbetween

Philippe Mathieu-Daudé (1):
      hw/watchdog/wdt_aspeed: Remove unused 'hw/misc/aspeed_scu.h' header

Thomas Huth (3):
      MAINTAINERS: Add tests/decode/ to the "Overall TCG CPUs" section
      tests/data/qobject/qdict.txt: Avoid non-inclusive words
      qapi/pragma.json: Improve the comment about the lists of QAPI rule exceptions

 MAINTAINERS                      |  1 +
 bsd-user/bsd-mem.h               |  2 +-
 bsd-user/freebsd/os-proc.c       |  2 +-
 bsd-user/freebsd/os-stat.h       |  6 +++---
 contrib/vhost-user-gpu/virgl.c   |  2 +-
 docs/about/deprecated.rst        |  2 +-
 docs/devel/migration.rst         | 10 +++++-----
 docs/system/arm/emulation.rst    |  2 +-
 gdbstub/gdbstub.c                |  2 +-
 hw/audio/virtio-snd.c            |  2 +-
 hw/cxl/cxl-component-utils.c     |  4 ++--
 hw/cxl/cxl-mailbox-utils.c       |  2 +-
 hw/mem/memory-device.c           |  2 +-
 hw/net/cadence_gem.c             |  8 ++++----
 hw/watchdog/wdt_aspeed.c         |  1 -
 include/block/ufs.h              |  2 +-
 include/hw/cxl/cxl_device.h      |  2 +-
 include/hw/hyperv/dynmem-proto.h |  6 +++---
 include/hw/virtio/vhost.h        |  2 +-
 linux-user/ppc/vdso.S            |  2 +-
 linux-user/syscall.c             |  2 +-
 migration/rdma.c                 |  2 +-
 qapi/migration.json              |  2 +-
 qapi/pragma.json                 |  4 ++--
 target/arm/tcg/helper-a64.c      |  2 +-
 target/arm/tcg/hflags.c          |  2 +-
 target/hppa/cpu.h                |  2 +-
 target/hppa/machine.c            |  2 +-
 target/riscv/cpu.h               |  4 ++--
 tests/data/qobject/qdict.txt     |  4 ----
 tests/qtest/migration-test.c     |  2 +-
 tests/qtest/ufs-test.c           |  2 +-
 util/filemonitor-inotify.c       |  2 +-
 util/range.c                     |  2 +-
 34 files changed, 46 insertions(+), 50 deletions(-)

