Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E377E1E56
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 11:31:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzwsT-0003tF-36; Mon, 06 Nov 2023 05:30:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qzwsO-0003rC-HC; Mon, 06 Nov 2023 05:30:36 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qzwsM-0006CY-DH; Mon, 06 Nov 2023 05:30:36 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id E5178756062;
 Mon,  6 Nov 2023 11:30:42 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id D947C74705E; Mon,  6 Nov 2023 11:30:42 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id D6788745681;
 Mon,  6 Nov 2023 11:30:42 +0100 (CET)
Date: Mon, 6 Nov 2023 11:30:42 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
cc: Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, clg@kaod.org, 
 philmd@linaro.org, Bernhard Beschow <shentey@gmail.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Rene Engel <ReneEngel80@emailn.de>, vr_qemu@t-online.de
Subject: Re: [PATCH v7 0/3] Add emulation of AmigaOne XE board
In-Reply-To: <cover.1698406922.git.balaton@eik.bme.hu>
Message-ID: <88d6fff6-b97e-7c55-bf29-6d3aa2ed690d@eik.bme.hu>
References: <cover.1698406922.git.balaton@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Virus-Scanned: ClamAV using ClamSMTP
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, 27 Oct 2023, BALATON Zoltan wrote:
> Changes in v7:
> - Increase default memory size to 512m to match pegasos2 and sam460ex
> and it's a better default for AmigaOS
>
> Changes in v6:
> - Dropped patch 1, now it's
>
> Based-on: <20231024224056.842607-1-mark.cave-ayland@ilande.co.uk>
>
> ([PATCH v2 0/3] ide: implement simple legacy/native mode switching for PCI IDE controllers)
> - Added Tested-by from Rene
>
> Changes in v5:
> - Fixed avocado test
>
> Changes in v4:
> - Found typo in comment in patch 1 so ended up rewording it again
> trying to make it more concise. Also take the idea of using
> range_covers_byte from Mark's patch
> - Added RFC patch for avocado test (untested, I don't have Avocado)
>
> Changes in v3:
> - Update values, comment and commit message in patch 1 again
>
> Changes in v2:
> - Update comment and commit message in patch 1 (Mark)
> - Fix irq mapping in patch 2 (Volker)
>
> Regards,
> BALATON Zoltan
>
> BALATON Zoltan (3):
>  hw/pci-host: Add emulation of Mai Logic Articia S
>  hw/ppc: Add emulation of AmigaOne XE board
>  tests/avocado: Add test for amigaone board

Nick,

Will you please send a pull request with this now? It's independent of the 
IDE fix which as a bugfix so can wait a little more but this series should 
be merged before the freeze starts tomorrow. (As this adds a new machine 
and does not touch anything else it can't break anything either.)

Regards,
BALATON Zoltan

> MAINTAINERS                             |   8 +
> configs/devices/ppc-softmmu/default.mak |   1 +
> hw/pci-host/Kconfig                     |   5 +
> hw/pci-host/articia.c                   | 293 ++++++++++++++++++++++++
> hw/pci-host/meson.build                 |   2 +
> hw/ppc/Kconfig                          |   7 +
> hw/ppc/amigaone.c                       | 164 +++++++++++++
> hw/ppc/meson.build                      |   2 +
> include/hw/pci-host/articia.h           |  17 ++
> tests/avocado/ppc_amiga.py              |  38 +++
> 10 files changed, 537 insertions(+)
> create mode 100644 hw/pci-host/articia.c
> create mode 100644 hw/ppc/amigaone.c
> create mode 100644 include/hw/pci-host/articia.h
> create mode 100644 tests/avocado/ppc_amiga.py
>
>

