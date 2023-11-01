Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C577DDFC4
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 11:50:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qy8mk-0007Sq-Cj; Wed, 01 Nov 2023 06:49:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qy8mi-0007Sd-Jg; Wed, 01 Nov 2023 06:49:16 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qy8mg-00005J-9C; Wed, 01 Nov 2023 06:49:16 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id DAE44756082;
 Wed,  1 Nov 2023 11:49:18 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id A43E9756062; Wed,  1 Nov 2023 11:49:18 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id A2691745681;
 Wed,  1 Nov 2023 11:49:18 +0100 (CET)
Date: Wed, 1 Nov 2023 11:49:18 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
cc: jsnow@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org, 
 philmd@linaro.org, shentey@gmail.com
Subject: Re: [PATCH v2 0/3] ide: implement simple legacy/native mode switching
 for PCI IDE controllers
In-Reply-To: <20231024224056.842607-1-mark.cave-ayland@ilande.co.uk>
Message-ID: <fbaa0311-c11f-4440-bd5f-852f5ca7ff01@eik.bme.hu>
References: <20231024224056.842607-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Probability: 9%
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
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

On Tue, 24 Oct 2023, Mark Cave-Ayland wrote:
> This series adds a simple implementation of legacy/native mode switching for PCI
> IDE controllers and updates the via-ide device to use it.

This is needed for my amigaone machine to boot (as that uses the legacy 
mode of this controller) so is somebody looking at merging this series in 
time for next release? Only one week left until the freeze.

Regards,
BALATON Zoltan

> The approach I take here is to add a new pci_ide_update_mode() function which handles
> management of the PCI BARs and legacy IDE ioports for each mode to avoid exposing
> details of the internal logic to individual PCI IDE controllers.
>
> As noted in [1] this is extracted from a local WIP branch I have which contains
> further work in this area. However for the moment I've kept it simple (and
> restricted it to the via-ide device) which is good enough for Zoltan's PPC
> images whilst paving the way for future improvements after 8.2.
>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>
> [1] https://lists.gnu.org/archive/html/qemu-devel/2023-10/msg05403.html
>
> v2:
> - Rebase onto master
> - Mask the bottom 4 bits of PCI_CLASS_PROG in pci_ide_update_mode() in patch 1
> - Add patch 2 to remove the default BAR addresses to avoid confusion
> - Don't set PCI_INTERRUPT_PIN directly in via_ide_reset() as it is already set
>  by pci_ide_update_mode() in patch 3, and reword the commit message accordingly
> - Add Tested-By tags from Zoltan and Bernhard
>
>
> Mark Cave-Ayland (3):
>  ide/pci.c: introduce pci_ide_update_mode() function
>  ide/via: don't attempt to set default BAR addresses
>  hw/ide/via: implement legacy/native mode switching
>
> hw/ide/pci.c         | 90 ++++++++++++++++++++++++++++++++++++++++++++
> hw/ide/via.c         | 25 ++++++++----
> include/hw/ide/pci.h |  1 +
> 3 files changed, 109 insertions(+), 7 deletions(-)
>
>

