Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E027EB531
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 18:00:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2wkt-0006h5-9H; Tue, 14 Nov 2023 11:59:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r2wkc-0006by-1O; Tue, 14 Nov 2023 11:58:58 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r2wkR-0004m1-Mw; Tue, 14 Nov 2023 11:58:50 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 5B3A133266;
 Tue, 14 Nov 2023 19:59:00 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 26D43351ED;
 Tue, 14 Nov 2023 19:58:42 +0300 (MSK)
Received: (nullmailer pid 2949071 invoked by uid 1000);
 Tue, 14 Nov 2023 16:58:42 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH trivial 00/21] spelling fixes for 8.2
Date: Tue, 14 Nov 2023 19:58:13 +0300
Message-Id: <20231114165834.2949011-1-mjt@tls.msk.ru>
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

For newly added lines after 8.1.

Michael Tokarev (21):
  bsd-user: spelling fixes: necesary, agrument, undocummented
  linux-user: spelling fixes: othe, necesary
  hw/cxl: spelling fixes: limitaions, potentialy, intialized
  gdbstub: spelling fix: respectivelly
  docs/about/deprecated.rst: spelling fix: becase
  docs/devel/migration.rst: spelling fix: doen't
  docs/system/arm/emulation.rst: spelling fix: Enhacements
  target/arm/tcg: spelling fixes: alse, addreses
  target/hppa: spelling fixes: Indicies, Truely
  migration/rdma.c: spelling fix: asume
  contrib/vhost-user-gpu/virgl.c: spelling fix: mesage
  hw/mem/memory-device.c: spelling fix: ontaining
  hw/net/cadence_gem.c: spelling fixes: Octects
  include/block/ufs.h: spelling fix: setted
  include/hw/hyperv/dynmem-proto.h: spelling fix: nunber
  include/hw/virtio/vhost.h: spelling fix: sate
  target/riscv/cpu.h: spelling fix: separatly
  tests/qtest/migration-test.c: spelling fix: bandwith
  tests/qtest/ufs-test.c: spelling fix: tranfer
  util/filemonitor-inotify.c: spelling fix: kenel
  util/range.c: spelling fix: inbetween

 bsd-user/bsd-mem.h               | 2 +-
 bsd-user/freebsd/os-proc.c       | 2 +-
 bsd-user/freebsd/os-stat.h       | 6 +++---
 contrib/vhost-user-gpu/virgl.c   | 2 +-
 docs/about/deprecated.rst        | 2 +-
 docs/devel/migration.rst         | 8 ++++----
 docs/system/arm/emulation.rst    | 2 +-
 gdbstub/gdbstub.c                | 2 +-
 hw/cxl/cxl-component-utils.c     | 4 ++--
 hw/cxl/cxl-mailbox-utils.c       | 2 +-
 hw/mem/memory-device.c           | 2 +-
 hw/net/cadence_gem.c             | 8 ++++----
 include/block/ufs.h              | 2 +-
 include/hw/cxl/cxl_device.h      | 2 +-
 include/hw/hyperv/dynmem-proto.h | 6 +++---
 include/hw/virtio/vhost.h        | 2 +-
 linux-user/ppc/vdso.S            | 2 +-
 linux-user/syscall.c             | 2 +-
 migration/rdma.c                 | 2 +-
 target/arm/tcg/helper-a64.c      | 2 +-
 target/arm/tcg/hflags.c          | 2 +-
 target/hppa/cpu.h                | 2 +-
 target/hppa/machine.c            | 2 +-
 target/riscv/cpu.h               | 4 ++--
 tests/qtest/migration-test.c     | 2 +-
 tests/qtest/ufs-test.c           | 2 +-
 util/filemonitor-inotify.c       | 2 +-
 util/range.c                     | 2 +-
 28 files changed, 40 insertions(+), 40 deletions(-)

-- 
2.39.2


