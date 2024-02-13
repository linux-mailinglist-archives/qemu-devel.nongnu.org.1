Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CEED1852A64
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Feb 2024 09:02:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZnk4-000467-GK; Tue, 13 Feb 2024 03:02:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rZnjp-00045L-9Z; Tue, 13 Feb 2024 03:01:57 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rZnjn-00078v-F8; Tue, 13 Feb 2024 03:01:57 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A93A64CBC9;
 Tue, 13 Feb 2024 11:01:56 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id CDA8B7CF17;
 Tue, 13 Feb 2024 11:01:51 +0300 (MSK)
Received: (nullmailer pid 160883 invoked by uid 1000);
 Tue, 13 Feb 2024 08:01:51 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-trivial@nongnu.org
Subject: [PULL 00/15] Trivial patches for 2024-02-13
Date: Tue, 13 Feb 2024 11:01:36 +0300
Message-Id: <20240213080151.160839-1-mjt@tls.msk.ru>
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

The following changes since commit 5005aed8a7e728d028efb40e243ecfc2b4f3df3a:

  Merge tag 'pull-maintainer-updates-090224-1' of https://gitlab.com/stsquad/qemu into staging (2024-02-12 14:14:10 +0000)

are available in the Git repository at:

  https://gitlab.com/mjt0k/qemu.git tags/pull-trivial-patches

for you to fetch changes up to f6e33708bbb824d493863bc936d3c86fc86f2004:

  monitor/target: Include missing 'exec/memory.h' header (2024-02-13 10:59:25 +0300)

----------------------------------------------------------------
trivial patches for 2024-02-13

----------------------------------------------------------------
Akihiko Odaki (2):
      hw/smbios: Fix OEM strings table option validation
      hw/smbios: Fix port connector option validation

BALATON Zoltan (2):
      qemu-options.hx: Add zoom-to-fit to option summary for gtk
      system: Move memory_ldst.c.inc to system

Kevin Wolf (1):
      iothread: Simplify expression in qemu_in_iothread()

Markus Armbruster (2):
      MAINTAINERS: Cover qapi/cxl.json
      MAINTAINERS: Cover qapi/stats.json

Michael Tokarev (2):
      qemu-nbd: mention --tls-hostname option in qemu-nbd --help
      qemu-options.hx: document that tftp=dir is readonly

Philippe Mathieu-Daudé (2):
      cpu-target: Include missing 'exec/memory.h' header
      monitor/target: Include missing 'exec/memory.h' header

Zhao Liu (4):
      hw/isa/vt82c686: Consolidate the use of device_class_set_parent_realize()
      hw/isa/pc87312: Consolidate the use of device_class_set_parent_realize()
      hw/intc/s390_flic: Consolidate the use of device_class_set_parent_realize()
      hw/arm/smmuv3: Consolidate the use of device_class_set_parent_realize()

 MAINTAINERS                                   |  2 ++
 cpu-target.c                                  |  1 +
 hw/arm/smmuv3.c                               |  4 ++--
 hw/intc/s390_flic_kvm.c                       |  5 +++--
 hw/isa/pc87312.c                              |  4 ++--
 hw/isa/vt82c686.c                             |  4 ++--
 hw/smbios/smbios.c                            | 12 ++++++++++++
 iothread.c                                    |  3 +--
 monitor/hmp-cmds-target.c                     |  1 +
 qemu-nbd.c                                    |  1 +
 qemu-options.hx                               |  4 +++-
 memory_ldst.c.inc => system/memory_ldst.c.inc |  0
 12 files changed, 30 insertions(+), 11 deletions(-)
 rename memory_ldst.c.inc => system/memory_ldst.c.inc (100%)

