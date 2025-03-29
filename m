Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A82A75702
	for <lists+qemu-devel@lfdr.de>; Sat, 29 Mar 2025 16:44:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tyYLh-0003cw-7q; Sat, 29 Mar 2025 11:43:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tyYLJ-0003aa-99
 for qemu-devel@nongnu.org; Sat, 29 Mar 2025 11:43:29 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tyYLH-0003Bd-0t
 for qemu-devel@nongnu.org; Sat, 29 Mar 2025 11:43:29 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id CD6A04E6035;
 Sat, 29 Mar 2025 16:43:23 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id GnfGCivGQUQj; Sat, 29 Mar 2025 16:43:21 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id B7E8A4E6029; Sat, 29 Mar 2025 16:43:21 +0100 (CET)
Message-ID: <cover.1743262839.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 0/2] Move device tree files in a subdir in pc-bios
To: qemu-devel@nongnu.org
Cc: Edgar E. Iglesias <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 29 Mar 2025 16:43:21 +0100 (CET)
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Simple series doing what the subject says.

BALATON Zoltan (2):
  system/datadir: Add new type constant for DTB files
  pc-bios: Move device tree files in their own subdir

 MAINTAINERS                                |   2 +-
 hw/microblaze/boot.c                       |   2 +-
 hw/ppc/ppc440_bamboo.c                     |   2 +-
 hw/ppc/sam460ex.c                          |   2 +-
 hw/ppc/virtex_ml507.c                      |   2 +-
 include/qemu/datadir.h                     |  13 ++++++++----
 pc-bios/{ => dtb}/bamboo.dtb               | Bin
 pc-bios/{ => dtb}/bamboo.dts               |   0
 pc-bios/{ => dtb}/canyonlands.dtb          | Bin
 pc-bios/{ => dtb}/canyonlands.dts          |   0
 pc-bios/dtb/meson.build                    |  23 +++++++++++++++++++++
 pc-bios/{ => dtb}/petalogix-ml605.dtb      | Bin
 pc-bios/{ => dtb}/petalogix-ml605.dts      |   0
 pc-bios/{ => dtb}/petalogix-s3adsp1800.dtb | Bin
 pc-bios/{ => dtb}/petalogix-s3adsp1800.dts |   0
 pc-bios/meson.build                        |  23 +--------------------
 system/datadir.c                           |   5 ++++-
 17 files changed, 42 insertions(+), 32 deletions(-)
 rename pc-bios/{ => dtb}/bamboo.dtb (100%)
 rename pc-bios/{ => dtb}/bamboo.dts (100%)
 rename pc-bios/{ => dtb}/canyonlands.dtb (100%)
 rename pc-bios/{ => dtb}/canyonlands.dts (100%)
 create mode 100644 pc-bios/dtb/meson.build
 rename pc-bios/{ => dtb}/petalogix-ml605.dtb (100%)
 rename pc-bios/{ => dtb}/petalogix-ml605.dts (100%)
 rename pc-bios/{ => dtb}/petalogix-s3adsp1800.dtb (100%)
 rename pc-bios/{ => dtb}/petalogix-s3adsp1800.dts (100%)

-- 
2.41.3


