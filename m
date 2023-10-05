Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 278A67BA9CC
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 21:10:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoTio-0002Dk-E4; Thu, 05 Oct 2023 15:09:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qoTik-0002Bn-O0
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 15:09:14 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qoTii-0004dt-Bo
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 15:09:14 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 3DA2C74632B;
 Thu,  5 Oct 2023 21:08:25 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 47C167456A7; Thu,  5 Oct 2023 21:08:24 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 42BC6745681;
 Thu,  5 Oct 2023 21:08:24 +0200 (CEST)
Date: Thu, 5 Oct 2023 21:08:24 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: qemu-devel@nongnu.org, Huacai Chen <chenhuacai@kernel.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH] MAINTANERS: Split vt82c686 out of fuloong2e
In-Reply-To: <669b7b69-a5d0-fef2-40a8-84a1805f1aad@linaro.org>
Message-ID: <56c05c50-ba43-24fb-577e-d81c74ae5d58@eik.bme.hu>
References: <20231005181805.8EA7475723D@zero.eik.bme.hu>
 <669b7b69-a5d0-fef2-40a8-84a1805f1aad@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1236396969-1696532904=:3033"
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

--3866299591-1236396969-1696532904=:3033
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Thu, 5 Oct 2023, Philippe Mathieu-Daudé wrote:
> On 5/10/23 20:18, BALATON Zoltan wrote:
>> It is used by other machines not just fuloong2e so put it in a
>> separate section and add myself as reviewer.
>> 
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>> By the way, PIIX4 already has a section just above where I've added
>> this but some files are still listed in Malta. You may want to have a
>> look at that.
>>
>>   MAINTAINERS | 11 ++++++++---
>>   1 file changed, 8 insertions(+), 3 deletions(-)
>> 
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index ea91f9e804..7f0e20fde6 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1307,10 +1307,7 @@ M: Philippe Mathieu-Daudé <philmd@linaro.org>
>>   R: Jiaxun Yang <jiaxun.yang@flygoat.com>
>>   S: Odd Fixes
>>   F: hw/mips/fuloong2e.c
>> -F: hw/isa/vt82c686.c
>>   F: hw/pci-host/bonito.c
>> -F: hw/usb/vt82c686-uhci-pci.c
>> -F: include/hw/isa/vt82c686.h
>>   F: include/hw/pci-host/bonito.h
>>   F: tests/avocado/machine_mips_fuloong2e.py
>>   @@ -2462,6 +2459,14 @@ S: Maintained
>>   F: hw/isa/piix4.c
>>   F: include/hw/southbridge/piix.h
>>   +VIA south bridges (VT82C686B, VT8231)
>> +M: Philippe Mathieu-Daudé <philmd@linaro.org>
>> +R: Jiaxun Yang <jiaxun.yang@flygoat.com>
>> +R: BALATON Zoltan <balaton@eik.bme.hu>
>
> Feel free to add yourself as maintainer if you rather.

I'm happy with you staying maintainer if you don't mind :-) (after all 
we'll still need you to send pull requests anyway). Just wanted to get 
cc'd on this to make sure my machines won't break.

Regards,
BALATON Zoltan

> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>
>> +F: hw/isa/vt82c686.c
>> +F: hw/usb/vt82c686-uhci-pci.c
>> +F: include/hw/isa/vt82c686.h
>> +
>>   Firmware configuration (fw_cfg)
>>   M: Philippe Mathieu-Daudé <philmd@linaro.org>
>>   R: Gerd Hoffmann <kraxel@redhat.com>
>
>
--3866299591-1236396969-1696532904=:3033--

