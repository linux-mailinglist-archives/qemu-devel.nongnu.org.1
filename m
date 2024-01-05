Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D42FC825B1C
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 20:33:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLpuM-0000HD-3J; Fri, 05 Jan 2024 14:31:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rLpu9-0000Gm-Iw; Fri, 05 Jan 2024 14:30:54 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rLpu7-0002xT-El; Fri, 05 Jan 2024 14:30:53 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 12F4040D2B;
 Fri,  5 Jan 2024 22:30:42 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id AB73F5B1EB;
 Fri,  5 Jan 2024 22:30:38 +0300 (MSK)
Received: (nullmailer pid 116603 invoked by uid 1000);
 Fri, 05 Jan 2024 19:30:38 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-trivial@nongnu.org
Subject: [PULL 0/6] Trivial patches for 2024-01-05
Date: Fri,  5 Jan 2024 22:30:32 +0300
Message-Id: <20240105193038.116576-1-mjt@tls.msk.ru>
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

The following changes since commit 0c1eccd368af8805ec0fb11e6cf25d0684d37328:

  Merge tag 'hw-cpus-20240105' of https://github.com/philmd/qemu into staging (2024-01-05 16:08:58 +0000)

are available in the Git repository at:

  https://gitlab.com/mjt0k/qemu.git tags/pull-trivial-patches

for you to fetch changes up to 8a780cd212647a6013c8ea59e0929dad996e2c54:

  docs: use "buses" rather than "busses" (2024-01-05 22:28:54 +0300)

----------------------------------------------------------------
trivial patches for 2024-01-05

Random stuff here and there, plus a riscv bugfix.

----------------------------------------------------------------
Bin Meng (1):
      hw/net: cadence_gem: Fix MDIO_OP_xxx values

Max Erenberg (1):
      edu: fix DMA range upper bound check

Michael Tokarev (2):
      chardev/char.c: fix "abstract device type" error message
      audio/audio.c: remove trailing newline in error_setg

Samuel Tardieu (1):
      docs: use "buses" rather than "busses"

Xu Lu (1):
      target/riscv: Fix mcycle/minstret increment behavior

 audio/audio.c               |  2 +-
 chardev/char.c              |  2 +-
 docs/system/arm/palm.rst    |  2 +-
 docs/system/arm/xscale.rst  |  2 +-
 docs/system/devices/can.rst |  6 +++---
 hw/misc/edu.c               |  2 +-
 hw/net/cadence_gem.c        |  4 ++--
 target/riscv/csr.c          | 14 +++++++-------
 8 files changed, 17 insertions(+), 17 deletions(-)

