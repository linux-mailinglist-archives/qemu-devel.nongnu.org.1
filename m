Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F19F37CB68D
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 00:26:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsW2f-0007Wn-9l; Mon, 16 Oct 2023 18:26:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qsW2b-0007WP-3v; Mon, 16 Oct 2023 18:26:25 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qsW2W-0003Yr-0N; Mon, 16 Oct 2023 18:26:22 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id E00A57456AC;
 Tue, 17 Oct 2023 00:25:10 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id A3FE67456A7; Tue, 17 Oct 2023 00:25:10 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id A1F7E745681;
 Tue, 17 Oct 2023 00:25:10 +0200 (CEST)
Date: Tue, 17 Oct 2023 00:25:10 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
cc: Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, clg@kaod.org, 
 philmd@linaro.org, Bernhard Beschow <shentey@gmail.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Rene Engel <ReneEngel80@emailn.de>, vr_qemu@t-online.de
Subject: Re: [PATCH v3 0/3] Add emulation of AmigaOne XE board
In-Reply-To: <cover.1697311794.git.balaton@eik.bme.hu>
Message-ID: <81c6d451-a457-16ad-2f5d-5764bd32b4d5@eik.bme.hu>
References: <cover.1697311794.git.balaton@eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1722379743-1697495110=:7980"
X-Spam-Probability: 9%
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1722379743-1697495110=:7980
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8BIT

On Sat, 14 Oct 2023, BALATON Zoltan wrote:
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
>  via-ide: Fix legacy mode emulation
>  hw/pci-host: Add emulation of Mai Logic Articia S
>  hw/ppc: Add emulation of AmigaOne XE board

Nick, Daniel, Cédric,

Patch 1 is not related to PPC and is still debated but just to make sure 
we don't get too close to freeze again I ask about patch 2 and 3 in the 
maintime. Not sure who will merge this series at the end but if you can 
give an Acked-by for the last two patches maybe Philippe can take care of 
the series or is any of you plan to take it via ppc?

Regards,
BALATON Zoltan

> MAINTAINERS                             |   8 +
> configs/devices/ppc-softmmu/default.mak |   1 +
> hw/ide/via.c                            |  41 +++-
> hw/pci-host/Kconfig                     |   5 +
> hw/pci-host/articia.c                   | 293 ++++++++++++++++++++++++
> hw/pci-host/meson.build                 |   2 +
> hw/ppc/Kconfig                          |   7 +
> hw/ppc/amigaone.c                       | 164 +++++++++++++
> hw/ppc/meson.build                      |   2 +
> include/hw/pci-host/articia.h           |  17 ++
> 10 files changed, 535 insertions(+), 5 deletions(-)
> create mode 100644 hw/pci-host/articia.c
> create mode 100644 hw/ppc/amigaone.c
> create mode 100644 include/hw/pci-host/articia.h
>
>
--3866299591-1722379743-1697495110=:7980--

