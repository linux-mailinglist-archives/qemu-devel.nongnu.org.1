Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B95FE7DC1AD
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 22:17:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxZcM-0000LK-2G; Mon, 30 Oct 2023 17:16:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qxZcJ-0000K4-ET
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 17:16:11 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qxZcH-0006OI-GQ
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 17:16:11 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 5E05E756082;
 Mon, 30 Oct 2023 22:16:10 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 25CE9756094; Mon, 30 Oct 2023 22:16:10 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 24118756088;
 Mon, 30 Oct 2023 22:16:10 +0100 (CET)
Date: Mon, 30 Oct 2023 22:16:10 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>
Subject: Re: [PATCH 0/3] Misc ati-vga patches
In-Reply-To: <2665fbfd-f1fe-4952-8230-0f1661eaf4ca@ilande.co.uk>
Message-ID: <d3aa1f16-bc5f-89f1-691b-cd51ffcb45cd@eik.bme.hu>
References: <cover.1696942148.git.balaton@eik.bme.hu>
 <2875d8e4-e0b0-2167-7f71-f4df3588e80d@eik.bme.hu>
 <bdf7cb61-4b2f-c7da-6d40-bfc8c26d69cb@eik.bme.hu>
 <2665fbfd-f1fe-4952-8230-0f1661eaf4ca@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1443793002-1698700570=:63185"
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

--3866299591-1443793002-1698700570=:63185
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 30 Oct 2023, Mark Cave-Ayland wrote:
> On 30/10/2023 10:37, BALATON Zoltan wrote:
>> On Mon, 23 Oct 2023, BALATON Zoltan wrote:
>>> On Tue, 10 Oct 2023, BALATON Zoltan wrote:
>>>> Some misc patches I had laying around that could be upstreamed just to
>>>> clean up my tree a bit.
>>> 
>>> Ping? Is Gerd still the maintainer of gfx or who else should be cc'd on 
>>> such patches?
>> 
>> Ping^2
>> 
>> Regards,
>> BALATON Zoltan
>>> 
>>>> BALATON Zoltan (3):
>>>>  ati-vga: Fix aperture sizes
>>>>  ati-vga: Support unaligned access to GPIO DDC registers
>>>>  ati-vga: Add 30 bit palette access register
>>>> 
>>>> hw/display/ati.c      | 50 ++++++++++++++++++++++++++++---------------
>>>> hw/display/ati_dbg.c  |  1 +
>>>> hw/display/ati_int.h  |  1 +
>>>> hw/display/ati_regs.h |  1 +
>>>> 4 files changed, 36 insertions(+), 17 deletions(-)
>
> Slightly off-topic, but are there any known issues with the ati-vga device 
> (hardware?) cursor handling? At least here with testing MorphOS with -display 
> gtk, the guest unconditionally grabs the mouse and it's impossible to release 
> it. Within the windows itself the mouse "skids" which means I can't get to 
> the edge of the window to close it, and so I end up having to switch to a 
> text console and kill QEMU to be able to access the desktop again.

Try -device ati-vga,guest_hwcursor=true that may work better. There are 
two ways in QEMU to handle HW cursor and the default is to let the host 
move the pointer but the problem with this in my understanding is that the 
host and guest may have different mouse pointer acceleration settings so 
the host pointer and guest pointer may get out of sync which causes it to 
jump ot lag. There's another API which does it differently and let the 
guest dictate where the pointer is which does not get out of sync but may 
freeze or jump if the guest is busy. Or something like that. I've 
implemented both in ati-vga as first it used the host pointer but others 
also reported problems so added the guest_hwcursor option as well. Maybe 
also using -display sdl can help as I did not get that problem with sdl.

Regards,
BALATON Zoltan
--3866299591-1443793002-1698700570=:63185--

