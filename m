Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF2A7DB5A0
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 10:03:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxOAa-0005dL-TV; Mon, 30 Oct 2023 05:02:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qxOAX-0005cX-Cw; Mon, 30 Oct 2023 05:02:45 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qxOAV-00014L-8G; Mon, 30 Oct 2023 05:02:45 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 1C784757202;
 Mon, 30 Oct 2023 10:02:44 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id DA4F275728C; Mon, 30 Oct 2023 10:02:43 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id D795E75724F;
 Mon, 30 Oct 2023 10:02:43 +0100 (CET)
Date: Mon, 30 Oct 2023 10:02:43 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Gerd Hoffmann <kraxel@redhat.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 Bernhard Beschow <shentey@gmail.com>, 
 Peter Maydell <peter.maydell@linaro.org>, ReneEngel80@emailn.de
Subject: Re: [PATCH v9 4/7] hw/isa/vt82c686: Implement PCI IRQ routing
In-Reply-To: <cf4b1c2f-dde1-738e-1e5d-329b9074e58d@linaro.org>
Message-ID: <38729153-8636-f530-4f5f-b63b10e406a8@eik.bme.hu>
References: <cover.1678188711.git.balaton@eik.bme.hu>
 <fbb016c7d0e19093335c237e15f5f6c62c4393b4.1678188711.git.balaton@eik.bme.hu>
 <cf4b1c2f-dde1-738e-1e5d-329b9074e58d@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1628928238-1698656563=:78133"
X-Spam-Probability: 9%
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1628928238-1698656563=:78133
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 30 Oct 2023, Philippe Mathieu-Daudé wrote:
> On 7/3/23 12:42, BALATON Zoltan wrote:
>> The real VIA south bridges implement a PCI IRQ router which is configured
>> by the BIOS or the OS. In order to respect these configurations, QEMU
>> needs to implement it as well. The real chip may allow routing IRQs from
>> internal functions independently of PCI interrupts but since guests
>> usually configute it to a single shared interrupt we don't model that
>> here for simplicity.
>> 
>> Note: The implementation was taken from piix4_set_irq() in hw/isa/piix4.
>> 
>> Suggested-by: Bernhard Beschow <shentey@gmail.com>
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> Reviewed-by: Bernhard Beschow <shentey@gmail.com>
>> Tested-by: Rene Engel <ReneEngel80@emailn.de>
>> ---
>>   hw/isa/vt82c686.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 42 insertions(+)
>
>
>> +static int via_isa_get_pci_irq(const ViaISAState *s, int irq_num)
>> +{
>> +    switch (irq_num) {
>> +    case 0:
>> +        return s->dev.config[0x55] >> 4;
>> +    case 1:
>> +        return s->dev.config[0x56] & 0xf;
>> +    case 2:
>> +        return s->dev.config[0x56] >> 4;
>> +    case 3:
>> +        return s->dev.config[0x57] >> 4;
>
> Shouldn't this be & 0xf?

No, the INTD value is actually in the high byte of reg 0x57. See e.g. page 
73 in the VT8231 doc Revision 2.32.

> (This is why I prefer extract8() over manual bits extraction)

(I have two problems with deposit/extract. Have to remember which operand 
is what so it's less obvious to me and they have an assert which is not a 
good idea in an interrupt handlet that could be called millinos of times.)

Regards,
BALATON Zoltan
--3866299591-1628928238-1698656563=:78133--

