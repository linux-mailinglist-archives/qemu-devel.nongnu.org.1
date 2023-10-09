Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C5F67BEB03
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 21:56:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpwLN-00014n-LF; Mon, 09 Oct 2023 15:55:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qpwLM-000144-2e; Mon, 09 Oct 2023 15:55:08 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qpwLH-0005DI-Va; Mon, 09 Oct 2023 15:55:07 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id ED24E748FF4;
 Mon,  9 Oct 2023 21:54:06 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id DA8197456A7; Mon,  9 Oct 2023 21:54:04 +0200 (CEST)
Message-Id: <cover.1696880742.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v2 0/3] Add emulation of AmigaOne XE board
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, clg@kaod.org,
 philmd@linaro.org, Bernhard Beschow <shentey@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Rene Engel <ReneEngel80@emailn.de>, vr_qemu@t-online.de
Date: Mon,  9 Oct 2023 21:54:04 +0200 (CEST)
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

Changes in v2:
- Update comment and commit message in patch 1 (Mark)
- Fix irq mapping in patch 2 (Volker)

Regards,
BALATON Zoltan

BALATON Zoltan (3):
  via-ide: Fix legacy mode emulation
  hw/pci-host: Add emulation of Mai Logic Articia S
  hw/ppc: Add emulation of AmigaOne XE board

 MAINTAINERS                             |   8 +
 configs/devices/ppc-softmmu/default.mak |   1 +
 hw/ide/via.c                            |  41 +++-
 hw/pci-host/Kconfig                     |   5 +
 hw/pci-host/articia.c                   | 293 ++++++++++++++++++++++++
 hw/pci-host/meson.build                 |   2 +
 hw/ppc/Kconfig                          |   7 +
 hw/ppc/amigaone.c                       | 164 +++++++++++++
 hw/ppc/meson.build                      |   2 +
 include/hw/pci-host/articia.h           |  17 ++
 10 files changed, 535 insertions(+), 5 deletions(-)
 create mode 100644 hw/pci-host/articia.c
 create mode 100644 hw/ppc/amigaone.c
 create mode 100644 include/hw/pci-host/articia.h

-- 
2.30.9


