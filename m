Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5E9728741
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 20:33:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7KR2-0003DY-M4; Thu, 08 Jun 2023 14:32:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1q7KQi-0003Cp-5H; Thu, 08 Jun 2023 14:32:16 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1q7KQd-00076J-Fv; Thu, 08 Jun 2023 14:32:15 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 17C22B9A0;
 Thu,  8 Jun 2023 21:31:58 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id ED12AAA71;
 Thu,  8 Jun 2023 21:31:55 +0300 (MSK)
Message-ID: <10ef6b88-0770-65bb-b6dd-217a5f731d14@tls.msk.ru>
Date: Thu, 8 Jun 2023 21:31:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] hw/mips: Improve the default USB settings in the
 loongson3-virt machine
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 QEMU Trivial <qemu-trivial@nongnu.org>
References: <20230525064731.1854107-1-thuth@redhat.com>
 <5795da20-a2f6-e606-27bd-a23fc72346fc@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <5795da20-a2f6-e606-27bd-a23fc72346fc@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -69
X-Spam_score: -7.0
X-Spam_bar: -------
X-Spam_report: (-7.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.091,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

07.06.2023 13:26, Thomas Huth wrote:
> On 25/05/2023 08.47, Thomas Huth wrote:
>> It's possible to compile QEMU without the USB devices (e.g. when using
>> "--without-default-devices" as option for the "configure" script).
>> To be still able to run the loongson3-virt machine in default mode with
>> such a QEMU binary, we have to check here for the availability of the
>> devices first before instantiating them.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   The alternative would be to use a "#ifdef CONFIG_USB_OHCI_PCI" etc.
>>   ... not sure what is nicer ... what do you think?
>>
>>   hw/mips/loongson3_virt.c | 10 +++++++---
>>   1 file changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
>> index 216812f660..a0afb17030 100644
>> --- a/hw/mips/loongson3_virt.c
>> +++ b/hw/mips/loongson3_virt.c
>> @@ -447,10 +447,14 @@ static inline void loongson3_virt_devices_init(MachineState *machine,
>>       pci_vga_init(pci_bus);
>> -    if (defaults_enabled()) {
>> +    if (defaults_enabled() && module_object_class_by_name("pci-ohci")) {
>>           pci_create_simple(pci_bus, -1, "pci-ohci");
>> -        usb_create_simple(usb_bus_find(-1), "usb-kbd");
>> -        usb_create_simple(usb_bus_find(-1), "usb-tablet");
>> +        if (module_object_class_by_name("usb-kbd")) {
>> +            usb_create_simple(usb_bus_find(-1), "usb-kbd");
>> +        }
>> +        if (module_object_class_by_name("usb-tablet")) {
>> +            usb_create_simple(usb_bus_find(-1), "usb-tablet");
>> +        }

It looks like kbd/tablet don't need to have an if around, because
hw/usb/usb-hid.c is always compiled when CONFIG_USB is enabled,
and enabling CONFIG_USB_OHCI automatically selects CONFIG_USB.

I guess this whole code can be guarded by #if CONFIG_USB_OHCI..#endif,
instead of using runtime checking of device availability.

Notes:

Other places don't check if ohci or other usb controllers are available.

We have TYPE_PCI_OHCI #define which isn't used in places where pci-ohci
is requested, - probably need to move it to a common header (it is
defined in hw/usb/hcd-ohci-pci.c now).

roms/config.seabios-128k turns USB_OHCI off.

/mjt

