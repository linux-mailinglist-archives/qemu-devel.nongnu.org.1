Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 191977BCC91
	for <lists+qemu-devel@lfdr.de>; Sun,  8 Oct 2023 08:24:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpNCo-00083P-UO; Sun, 08 Oct 2023 02:23:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qpNCm-00082g-MR
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 02:23:56 -0400
Received: from mout.kundenserver.de ([212.227.17.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qpNCk-0007jP-QX
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 02:23:56 -0400
Received: from quad ([82.142.8.70]) by mrelayeu.kundenserver.de (mreue107
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1M1qfu-1qrZ431qgK-002GrQ; Sun, 08
 Oct 2023 08:23:51 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>
Subject: [PULL 00/20] Q800 for 8.2 patches
Date: Sun,  8 Oct 2023 08:23:29 +0200
Message-ID: <20231008062349.2733552-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:BeVYl1syj6+V9L82i9eff+60f78rkKxoYqRGVfQY2ShHIQ2LMR/
 7IW8pAoY7M7X24GzMCeVgb3nvDWvX5KHE3xVutyv/7GdZfE1p8reXIWVCFIkYHuHpeeNYd0
 0+OLga8EAqzVCT8W+7NI4G8xFWnBBKzlPnkWQXOsgiqwFxq4/BHMOIRGT6NQT/12M1ihi/j
 ULJJJ8c5D+U3Wdu81XJXg==
UI-OutboundReport: notjunk:1;M01:P0:WRVg0pL2DO4=;Y9ZK6jAClBlpVNAADk1H9J70mtE
 xrVNzRSd4WNwnkSQmVuMjqAWTc5VEhKAaYU6Eib8dASYo/aKedE4t6coe+5VLUvin2STpCpHg
 sHhiAXvryZczFfwGrOyVVdaJFH9YMJ7E6bSrRfly63TX6FtCb7etSGFzC2pykyPPM6p7rP6mX
 sn3ezx0B9FydqBfKZt1Iclq5G7/evOK2/3QJ0P04xe48OzWQJOIzwblYdSqrdhAk+hT5cSUQ1
 DWsM4UE9yvod9IUf7tP7Kxan0p6E3MbD7Se0kyLsQErtHdjucMA9t4X0UB+A1TZc+JSoo90J0
 IwqmBsg1SCm7nhQqhaLvNINYsCpPI9ikJzH55tddomqg14b5aVyY0hzevIKZksStGQecb87dT
 g51cZpMg8GugiwtdzADnybamMTJnX8NzcdPyMzZS8HX3f4uujH6jzZru1kNXckjEKhLB2JY8k
 tDHkod7ZBcf/IRD4Ukgzg4dn98pAS76tRrT4K96nVrSwoBuScqgI3Xqa2Uy58eSx8zwKWQDdV
 txijXFLtSTlc/yCKEyPdjz0MdIxXFtSGxGe/DJCWct3kzoTcMPgaUvaVpgfF5goHm7TFdsjdo
 PYu6xZg7pHyP0/18bCucWXD3TZSKJcnyRKFaHDfsUVw/az2TDG736YcDUntYnGOjUGhM+Ely0
 fk8HT6drP0bE/gAGIFybuOc8xp0xrrhg/rfZPOiPPMpLZ7HNZWaeculI6mPzq3XSo9hjHKJ2F
 /vkJCvzZHUtP5ElzQr2HxhWEd4R11s4AqKeO4LM+ww9g/Yp/YZn8/83NSo7dsT38UnGoB9JXg
 0rsW13d3mLUsD359DrerdNpB9zpjnWy5rItTuaPg71cY697RHMDQRQcXuKPtEYAilzYSdHjCP
 cOrLe1wv818yQxg==
Received-SPF: none client-ip=212.227.17.10; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.376, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

The following changes since commit 2f3913f4b2ad74baeb5a6f1d36efbd9ecdf1057d:

  Merge tag 'for_upstream' of https://git.kernel.org/pub/scm/virt/kvm/mst/qemu into staging (2023-10-05 09:01:01 -0400)

are available in the Git repository at:

  https://github.com/vivier/qemu-m68k.git tags/q800-for-8.2-pull-request

for you to fetch changes up to b4d3a83b89fba814613f7ead6b6ea92e0b2c3cd8:

  mac_via: extend timer calibration hack to work with A/UX (2023-10-06 10:33:43 +0200)

----------------------------------------------------------------
Pull request q800 20231008

add support for booting:
  - MacOS 7.1 - 8.1, with or without virtual memory enabled
  - A/UX 3.0.1
  - NetBSD 9.3
  - Linux (via EMILE)

----------------------------------------------------------------

Mark Cave-Ayland (20):
  q800-glue.c: convert to Resettable interface
  q800: add djMEMC memory controller
  q800: add machine id register
  q800: implement additional machine id bits on VIA1 port A
  q800: add IOSB subsystem
  q800: allow accesses to RAM area even if less memory is available
  audio: add Apple Sound Chip (ASC) emulation
  asc: generate silence if FIFO empty but engine still running
  q800: add Apple Sound Chip (ASC) audio to machine
  q800: add easc bool machine class property to switch between ASC and
    EASC
  swim: add trace events for IWM and ISM registers
  swim: split into separate IWM and ISM register blocks
  swim: update IWM/ISM register block decoding
  mac_via: work around underflow in TimeDBRA timing loop in SETUPTIMEK
  mac_via: workaround NetBSD ADB bus enumeration issue
  mac_via: implement ADB_STATE_IDLE state if shift register in input
    mode
  mac_via: always clear ADB interrupt when switching to A/UX mode
  q800: add ESCC alias at 0xc000
  q800: add alias for MacOS toolbox ROM at 0x40000000
  mac_via: extend timer calibration hack to work with A/UX

 MAINTAINERS                 |   6 +
 include/hw/audio/asc.h      |  86 +++++
 include/hw/block/swim.h     |  21 +-
 include/hw/m68k/q800-glue.h |   4 +-
 include/hw/m68k/q800.h      |  11 +
 include/hw/misc/djmemc.h    |  30 ++
 include/hw/misc/iosb.h      |  25 ++
 include/hw/misc/mac_via.h   |   3 +
 hw/audio/asc.c              | 727 ++++++++++++++++++++++++++++++++++++
 hw/block/swim.c             | 261 ++++++++-----
 hw/m68k/q800-glue.c         |  18 +-
 hw/m68k/q800.c              | 138 ++++++-
 hw/misc/djmemc.c            | 135 +++++++
 hw/misc/iosb.c              | 133 +++++++
 hw/misc/mac_via.c           | 234 +++++++++++-
 hw/audio/Kconfig            |   3 +
 hw/audio/meson.build        |   1 +
 hw/audio/trace-events       |  10 +
 hw/block/trace-events       |   8 +
 hw/m68k/Kconfig             |   3 +
 hw/misc/Kconfig             |   6 +
 hw/misc/meson.build         |   2 +
 hw/misc/trace-events        |  10 +
 23 files changed, 1769 insertions(+), 106 deletions(-)
 create mode 100644 include/hw/audio/asc.h
 create mode 100644 include/hw/misc/djmemc.h
 create mode 100644 include/hw/misc/iosb.h
 create mode 100644 hw/audio/asc.c
 create mode 100644 hw/misc/djmemc.c
 create mode 100644 hw/misc/iosb.c

-- 
2.41.0


