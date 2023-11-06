Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 649E37E2981
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 17:14:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r02EB-0000s2-T2; Mon, 06 Nov 2023 11:13:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1r02Dz-0000py-9g; Mon, 06 Nov 2023 11:13:15 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1r02Dv-0003gS-Uz; Mon, 06 Nov 2023 11:13:14 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id C944F75607A;
 Mon,  6 Nov 2023 17:13:24 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id BD973756072; Mon,  6 Nov 2023 17:13:24 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id BBDC1756062;
 Mon,  6 Nov 2023 17:13:24 +0100 (CET)
Date: Mon, 6 Nov 2023 17:13:24 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Kevin Wolf <kwolf@redhat.com>
cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, jsnow@redhat.com, 
 qemu-block@nongnu.org, qemu-devel@nongnu.org, philmd@linaro.org, 
 shentey@gmail.com
Subject: Re: [PATCH v2 3/3] hw/ide/via: implement legacy/native mode switching
In-Reply-To: <ZUj5yTKBkJ99Dbxf@redhat.com>
Message-ID: <509075f4-38d2-578b-b4f4-770c3b000ae8@eik.bme.hu>
References: <20231024224056.842607-1-mark.cave-ayland@ilande.co.uk>
 <20231024224056.842607-4-mark.cave-ayland@ilande.co.uk>
 <ZUj5yTKBkJ99Dbxf@redhat.com>
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

On Mon, 6 Nov 2023, Kevin Wolf wrote:
> Am 25.10.2023 um 00:40 hat Mark Cave-Ayland geschrieben:
>> Allow the VIA IDE controller to switch between both legacy and native modes by
>> calling pci_ide_update_mode() to reconfigure the device whenever PCI_CLASS_PROG
>> is updated.
>>
>> This patch moves the initial setting of PCI_CLASS_PROG from via_ide_realize() to
>> via_ide_reset(), and removes the direct setting of PCI_INTERRUPT_PIN during PCI
>> bus reset since this is now managed by pci_ide_update_mode(). This ensures that
>> the device configuration is always consistent with respect to the currently
>> selected mode.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> Tested-by: BALATON Zoltan <balaton@eik.bme.hu>
>> Tested-by: Bernhard Beschow <shentey@gmail.com>
>
> As I already noted in patch 1, the interrupt handling seems to be wrong
> here, it continues to use the ISA IRQ in via_ide_set_irq() even after
> switching to native mode.

That's a peculiarity of this via-ide device. It always uses 14/15 legacy 
interrupts even in native mode and guests expect that so using native 
interrupts would break pegasos2 guests. This was discussed and tested 
extensively before.

Regards,
BALATON Zoltan

> Other than this, the patch looks good to me.
>
> Kevin
>
>

