Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C30781DF0F
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Dec 2023 09:12:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rHg2l-0007ki-RG; Mon, 25 Dec 2023 03:10:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rHg2Q-0007hd-4q; Mon, 25 Dec 2023 03:10:14 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rHg2O-0008J1-Ad; Mon, 25 Dec 2023 03:10:13 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3A0CC3E964;
 Mon, 25 Dec 2023 11:10:32 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id E6B4A5300B;
 Mon, 25 Dec 2023 11:10:07 +0300 (MSK)
Received: (nullmailer pid 78169 invoked by uid 1000);
 Mon, 25 Dec 2023 08:10:07 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-trivial@nongnu.org
Subject: [PULL 0/7] Trivial patches for 2023-12-25
Date: Mon, 25 Dec 2023 11:10:00 +0300
Message-Id: <20231225081007.78141-1-mjt@tls.msk.ru>
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

The following changes since commit 80f1709aa0eb4de09b4240563463f991a5b9d855:

  Merge tag 'pull-loongarch-20231221' of https://gitlab.com/gaosong/qemu into staging (2023-12-21 19:44:19 -0500)

are available in the Git repository at:

  https://gitlab.com/mjt0k/qemu.git tags/pull-trivial-patches

for you to fetch changes up to d819fc9516a4ec71e37a6c9edfcd285b7f98c2dc:

  virtio-blk: Fix potential nullpointer read access in virtio_blk_data_plane_destroy (2023-12-25 11:01:01 +0300)

----------------------------------------------------------------
trivial patches for 2023-12-25

This pullreq contains cocoa help text updates, DPRINTF=>trace
conversion in accel/kvm, a typo fix in qemu-img.rst, and
3 imprtant (yet trivial) bugfixes:
 - fix for virtio-vga breakage after pixman becoming optional
 - fix for potential null pointer deref in virtio_blk_data_plane_destroy()
 - fix for usage of non-portable strerrorname_np()

----------------------------------------------------------------
Akihiko Odaki (2):
      qemu-options: Unify the help entries for cocoa
      qemu-options: Tell more for -display cocoa

Elen Avan (1):
      include/ui/rect.h: fix qemu_rect_init() mis-assignment

Jai Arora (1):
      accel/kvm: Turn DPRINTF macro use into tracepoints

Natanael Copa (1):
      target/riscv/kvm: do not use non-portable strerrorname_np()

Samuel Tardieu (1):
      docs/tools/qemu-img.rst: fix typo (sumarizes)

Stefan Weil via (1):
      virtio-blk: Fix potential nullpointer read access in virtio_blk_data_plane_destroy

 accel/kvm/kvm-all.c             | 28 ++++++----------------------
 accel/kvm/trace-events          |  7 ++++++-
 docs/tools/qemu-img.rst         |  2 +-
 hw/block/dataplane/virtio-blk.c |  3 ++-
 include/ui/rect.h               |  2 +-
 qemu-options.hx                 | 21 ++++++++++++++++++---
 target/riscv/kvm/kvm-cpu.c      | 18 ++++++++----------
 7 files changed, 42 insertions(+), 39 deletions(-)

