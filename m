Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6999D7DBB0D
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 14:43:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxSY3-0000jv-A7; Mon, 30 Oct 2023 09:43:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qxSY0-0000in-EF
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 09:43:16 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qxSXv-0006y0-66
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 09:43:16 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 7A029756088;
 Mon, 30 Oct 2023 14:43:14 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 4C6B0756082; Mon, 30 Oct 2023 14:43:14 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 4A66C756078;
 Mon, 30 Oct 2023 14:43:14 +0100 (CET)
Date: Mon, 30 Oct 2023 14:43:14 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@gmail.com>
cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 1/3] ati-vga: Fix aperture sizes
In-Reply-To: <CAJ+F1C+iOpJWtQrHkJeq5bGxeK3nnvheE9_AKq1X703EsJD4DQ@mail.gmail.com>
Message-ID: <b592fef8-f0d1-2b5d-44c1-1d4638bcc7d7@eik.bme.hu>
References: <cover.1696942148.git.balaton@eik.bme.hu>
 <b768c6506526caea0da8cd4025dbb05e109da4c5.1696942148.git.balaton@eik.bme.hu>
 <CAJ+F1C+iOpJWtQrHkJeq5bGxeK3nnvheE9_AKq1X703EsJD4DQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1300865702-1698673394=:33934"
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

--3866299591-1300865702-1698673394=:33934
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 30 Oct 2023, Marc-André Lureau wrote:
> Hi
>
> On Tue, Oct 10, 2023 at 5:03 PM BALATON Zoltan <balaton@eik.bme.hu> wrote:
>>
>> Apparently these should be half the memory region sizes confirmed at
>> least by Radeon drivers while Rage 128 Pro drivers don't seem to use
>> these.
>
> There doesn't seem to be adjustments for the kernel PPC driver
> https://github.com/torvalds/linux/blob/master/drivers/video/fbdev/aty/radeon_base.c#L2037
>
> Do you have any other pointers?

There was some discussion back whan this was added:

https://patchew.org/QEMU/99bb800cba3596e47d2681642116756330dc6f63.1562320946.git.balaton@eik.bme.hu/

and this was also in a patch Gerd sent once around that time but I don't 
find that patch now. I've found this while trying to get some RV100 ROMs 
from real card running which did multiply this by 2 while the Rage128Pro 
ROMs and drivers did not access it and used the BAR sizes I think. 
According to the discussion above maybe this also depends on some other 
bit but I don't have detailed enough docs to know.

Regards,
BALATON Zoltan

> thanks
>
>>
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>>  hw/display/ati.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/display/ati.c b/hw/display/ati.c
>> index c36282c343..f0bf1d7493 100644
>> --- a/hw/display/ati.c
>> +++ b/hw/display/ati.c
>> @@ -349,14 +349,14 @@ static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
>>                                        PCI_BASE_ADDRESS_0, size) & 0xfffffff0;
>>          break;
>>      case CONFIG_APER_SIZE:
>> -        val = s->vga.vram_size;
>> +        val = s->vga.vram_size / 2;
>>          break;
>>      case CONFIG_REG_1_BASE:
>>          val = pci_default_read_config(&s->dev,
>>                                        PCI_BASE_ADDRESS_2, size) & 0xfffffff0;
>>          break;
>>      case CONFIG_REG_APER_SIZE:
>> -        val = memory_region_size(&s->mm);
>> +        val = memory_region_size(&s->mm) / 2;
>>          break;
>>      case MC_STATUS:
>>          val = 5;
>> --
>> 2.30.9
>>
>>
>
>
>
--3866299591-1300865702-1698673394=:33934--

