Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A4E7BAEAE
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 00:15:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoWbR-0000pQ-Sm; Thu, 05 Oct 2023 18:13:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qoWbP-0000oX-7e; Thu, 05 Oct 2023 18:13:51 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qoWbM-0005tV-Ug; Thu, 05 Oct 2023 18:13:50 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 266F4756BF9;
 Fri,  6 Oct 2023 00:13:00 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id E5912748FF4; Fri,  6 Oct 2023 00:12:59 +0200 (CEST)
Message-Id: <cover.1696542537.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 0/3] Add emulation of AmigaOne XE board
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, clg@kaod.org,
 philmd@linaro.org, Bernhard Beschow <shentey@gmail.com>,
 Rene Engel <ReneEngel80@emailn.de>, vr_qemu@t-online.de
Date: Fri,  6 Oct 2023 00:12:59 +0200 (CEST)
X-Spam-Probability: 8%
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This small series adds amigaone PPC machine which can be emulated
mostly reusing existing models used by pegasos2 as these machines are
very similar. The reason to add another board is that AmigaOS has
different versions for different machines that only run on that
machine and the AmigaOne version is more common than the PegasosII one.
Also it's useful for debugging to be able to test with both machines
as problems in emulation can be identified if they occur on both
machines as opposed to problems specific only to one version. Since
this only needs a very minimal north bridge emulation and a simple
board code with everything else shared with pegasos2 it is not a big
maintenance burden.

The board uses a modofied U-Boot that is needed to boot AmigaOS which
is freely available and distributable under GPL (see comment in
hw/ppc/amigaone.c added in patch 3 for details on how to get firmware
binary) but the sources for it could not be recovered so I could not
reproduce it from source. Ideally this firmware should be included
here for convenience which should be OK due to its GPL licence but
since there's only a binary I did not include it here. Let me know if
that would be OK to include but even without that firmware adding the
machine is useful as users can get the rom binary separately which
they are used to as pegasos2 also needed a firmware image to boot
AmigaOS until recently.

I hope this could be merged for 8.2 with this series being the minimum
set of patches needed to add this machine. This was tested by a Few
people already and can run AmigaOS and Linux distro for AmigaOne well.

Regards,
BALATON Zoltan

BALATON Zoltan (3):
  via-ide: Fix legacy mode emulation
  hw/pci-host: Add emulation of Mai Logic Articia S
  hw/ppc: Add emulation of AmigaOne XE board

 MAINTAINERS                             |   8 +
 configs/devices/ppc-softmmu/default.mak |   1 +
 hw/ide/via.c                            |  35 +++-
 hw/pci-host/Kconfig                     |   5 +
 hw/pci-host/articia.c                   | 266 ++++++++++++++++++++++++
 hw/pci-host/meson.build                 |   2 +
 hw/ppc/Kconfig                          |   7 +
 hw/ppc/amigaone.c                       | 164 +++++++++++++++
 hw/ppc/meson.build                      |   2 +
 include/hw/pci-host/articia.h           |  17 ++
 10 files changed, 502 insertions(+), 5 deletions(-)
 create mode 100644 hw/pci-host/articia.c
 create mode 100644 hw/ppc/amigaone.c
 create mode 100644 include/hw/pci-host/articia.h

-- 
2.30.9


