Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DE87398C3
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 09:59:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCFBH-0004eD-Do; Thu, 22 Jun 2023 03:56:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qCFAf-00040l-8Z
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 03:56:01 -0400
Received: from mout.kundenserver.de ([212.227.126.133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qCFAY-0002r9-8x
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 03:55:58 -0400
Received: from quad ([82.142.8.70]) by mrelayeu.kundenserver.de (mreue011
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MLzSD-1qTV4N1AwL-00Hx5T; Thu, 22
 Jun 2023 09:55:46 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>
Subject: [PULL 00/24] Q800 for 8.1 patches
Date: Thu, 22 Jun 2023 09:55:20 +0200
Message-Id: <20230622075544.210899-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:f9KRN/Mxf2ZnhtF9y1zFKjUBSCCeAQ+MWgbbO0Y2QFD0GmvaIE1
 IjlNGas22YFGNg8Tt3x/UVgGv5MbvEQfkIqDvtaDNBB11iOH0c6iXVKgeI1bOq5g/2IMNq2
 76pTaNHD5rDdwhEXZberRFo38zjzXLXm5lvRwsEVLzeb2MN2EOepXXgH133xPzt8rxar7iM
 8Ns6pxep9m0pDpvEQ+nLA==
UI-OutboundReport: notjunk:1;M01:P0:e9KCPJzuIOM=;6nkdSVtsiBAlYpGFET/MR/SwrZP
 Qw8hn6xhk+dDAOBruu82JbQ4EmKJh6sNn6RE01bsl92SBnVve9NnV5o6myySygvF5ghl5MXLc
 ndEtiqj8HjxD9homEH9eYOb9QcY5ejc83M4ao2KJ21kevD4c/S677scS4JwgBM6TT5jyYbjMH
 DZDDYSBWYyeU0+sDAzj63xoUA4IrlO6wpCdtexv+cHMJ1UuTyMqVhpKdtW98l2YAGSAjPrS1k
 TwpkIYZ0MsyILzPZnfBI9ufdyaewLk2KqZ0cXKWN+I5DZyvzAodng1Czl/UfEzTopy16Bhkxl
 1wGHX7CGg3/2mDAgopaqSZml1wsNgOcly6G4Le54pnQ91pTll50aOcbNFN6cfBxqn9TM9m2Ci
 8EyzLfXTwIX3Itl0rNqbGM+o4syENkLPmlyQkKNucSxB5by9R7jIGKH9x/cp4vSC+hw76ILX2
 +bX7pMBXrX/EJR3p5mbsUNh12RuiBn9LIIOhdf9K87lWaOR+s7v2CrvWj1oW9HiZGYIvWNTdQ
 jXueASon0HUX1GEIxJl0ArWkcqIuxGJy1EX7KO+5t0OhVIzN7vdmFz7QQ/B6uc8BgiUXm2Sty
 QYGR/Wv1vdk+0XoAIKaHj/prit2Q5Cx48pr8kJ/Etr43Lk/kh9Qcd7ThSqKMadigea4fKGH+Q
 gneSngT4C6m+QUbWn1cnouCL+1Yl6S/NMJ8iDD2JSQ==
Received-SPF: none client-ip=212.227.126.133; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

The following changes since commit 67fe6ae41da64368bc4936b196fee2bf61f8c720:

  Merge tag 'pull-tricore-20230621-1' of https://github.com/bkoppelmann/qemu into staging (2023-06-21 20:08:48 +0200)

are available in the Git repository at:

  https://github.com/vivier/qemu-m68k.git tags/q800-for-8.1-pull-request

for you to fetch changes up to 532009054b45d75a3cf7ba9c31921add669d290d:

  mac_via: fix rtc command decoding for the PRAM seconds registers (2023-06-22 09:31:18 +0200)

----------------------------------------------------------------
Q800 branch pull request 20230622

Cleanup to introduce support of MacOS Classic

----------------------------------------------------------------

Mark Cave-Ayland (24):
  q800: fix up minor spacing issues in hw_compat_q800 GlobalProperty
    array
  q800: add missing space after parent object in GLUEState
  q800: introduce Q800MachineState
  q800: rename q800_init() to q800_machine_init()
  q800: move CPU object into Q800MachineState
  q800: move ROM memory region to Q800MachineState
  q800: move GLUE device into separate q800-glue.c file
  q800-glue.c: switch TypeInfo registration to use DEFINE_TYPES() macro
  q800: move GLUE device to Q800MachineState
  q800: introduce mac-io container memory region
  q800: reimplement mac-io region aliasing using IO memory region
  q800: move VIA1 device to Q800MachineState
  q800: move VIA2 device to Q800MachineState
  hw/net/dp8393x.c: move TYPE_DP8393X and dp8393xState into dp8393x.h
  q800: move dp8393x device to Q800MachineState
  q800: move ESCC device to Q800MachineState
  q800: move escc_orgate device to Q800MachineState
  q800: move ESP device to Q800MachineState
  q800: move SWIM device to Q800MachineState
  q800: move mac-nubus-bridge device to Q800MachineState
  q800: don't access Nubus bus directly from the mac-nubus-bridge device
  q800: move macfb device to Q800MachineState
  mac_via: fix rtc command decoding from PRAM addresses 0x0 to 0xf
  mac_via: fix rtc command decoding for the PRAM seconds registers

 MAINTAINERS                 |   3 +
 include/hw/m68k/q800-glue.h |  50 ++++
 include/hw/m68k/q800.h      |  66 +++++
 include/hw/net/dp8393x.h    |  60 ++++
 hw/m68k/q800-glue.c         | 249 +++++++++++++++++
 hw/m68k/q800.c              | 526 ++++++++++++++----------------------
 hw/misc/mac_via.c           |  13 +-
 hw/net/dp8393x.c            |  32 +--
 hw/m68k/meson.build         |   2 +-
 9 files changed, 635 insertions(+), 366 deletions(-)
 create mode 100644 include/hw/m68k/q800-glue.h
 create mode 100644 include/hw/m68k/q800.h
 create mode 100644 include/hw/net/dp8393x.h
 create mode 100644 hw/m68k/q800-glue.c

-- 
2.40.1


