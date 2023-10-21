Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B327D1D08
	for <lists+qemu-devel@lfdr.de>; Sat, 21 Oct 2023 14:08:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quAjh-000309-HB; Sat, 21 Oct 2023 08:05:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1quAjV-0002ze-Lk; Sat, 21 Oct 2023 08:05:33 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1quAjT-0000tx-0I; Sat, 21 Oct 2023 08:05:33 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id BB5782C32E;
 Sat, 21 Oct 2023 15:05:50 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id A70693067C;
 Sat, 21 Oct 2023 15:05:25 +0300 (MSK)
Received: (nullmailer pid 220774 invoked by uid 1000);
 Sat, 21 Oct 2023 12:05:25 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-trivial@nongnu.org
Subject: [PULL 00/17] Trivial patches for 2023-10-21
Date: Sat, 21 Oct 2023 15:05:02 +0300
Message-Id: <20231021120519.220720-1-mjt@tls.msk.ru>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit 384dbdda94c0bba55bf186cccd3714bbb9b737e9:

  Merge tag 'migration-20231020-pull-request' of https://gitlab.com/juan.quintela/qemu into staging (2023-10-20 06:46:53 -0700)

are available in the Git repository at:

  https://gitlab.com/mjt0k/qemu.git tags/pull-trivial-patches

for you to fetch changes up to a4a2f7f8161ed1dbaa748350c4bc2d86c4d77d97:

  MAINTAINERS: Add the ompic.c file to the or1k-sim section (2023-10-21 15:00:22 +0300)

----------------------------------------------------------------
trivial patches for 2023-10-21

This is mostly updates to MAINTAINERS, plus a fix for pvrdma
and dead code removal in ppc440_uc.

----------------------------------------------------------------
Cédric Le Goater (7):
      ppc/{bamboo, virtex_ml507}: Remove useless dependency on ppc405.h header
      MAINTAINERS: Adjust file list for PPC ref405ep machine
      MAINTAINERS: Adjust file list for PPC 4xx CPUs
      MAINTAINERS: Adjust file list for PPC e500 machines
      MAINTAINERS: Adjust file list for PPC pseries machine
      MAINTAINERS: Add fw_cfg.c to PPC mac99 machine
      MAINTAINERS: Add PPC common files to PowerPC TCG CPUs

Eric Farman (1):
      MAINTAINERS: Fix a couple s390 paths

Peter Maydell (1):
      hw/rdma/vmw/pvrdma_cmd: Use correct struct in query_port()

Philippe Mathieu-Daudé (2):
      hw/ppc/ppc440_uc: Remove dead l2sram_update_mappings()
      MAINTAINERS: Cover hw/ppc/ppc440_uc.c with Sam460ex board

Thomas Huth (6):
      MAINTAINERS: Add the nios2 interrupt controller to the nios2 section
      MAINTAINERS: Add include/hw/intc/i8259.h to the PC chip section
      MAINTAINERS: Add docs/devel/ebpf_rss.rst to the EBPF section
      MAINTAINERS: Add unvalued folders in tests/tcg/ to the right sections
      MAINTAINERS: Fix typo in openpic_kvm.c entry
      MAINTAINERS: Add the ompic.c file to the or1k-sim section

 MAINTAINERS              | 37 ++++++++++++++++++++++++++++++++-----
 hw/ppc/ppc440_bamboo.c   |  1 -
 hw/ppc/ppc440_uc.c       | 42 ------------------------------------------
 hw/ppc/virtex_ml507.c    |  1 -
 hw/rdma/vmw/pvrdma_cmd.c | 18 +++++++++++-------
 5 files changed, 43 insertions(+), 56 deletions(-)

