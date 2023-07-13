Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B0BF375205C
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 13:47:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJumx-0004zh-Cy; Thu, 13 Jul 2023 07:47:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qJumu-0004zP-Ow
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 07:47:12 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qJums-0001DK-Un
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 07:47:12 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B527D137CA;
 Thu, 13 Jul 2023 14:47:14 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id AE9DC148F9;
 Thu, 13 Jul 2023 14:47:00 +0300 (MSK)
Message-ID: <512d2664-5464-a502-391a-bf41491926fe@tls.msk.ru>
Date: Thu, 13 Jul 2023 14:47:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] hw/mips: Improve the default USB settings in the
 loongson3-virt machine
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Huacai Chen <chenhuacai@kernel.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
References: <20230621074134.82781-1-thuth@redhat.com>
 <062e8b3b-dcdd-8f87-d245-ea9e16b1c276@linaro.org>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <062e8b3b-dcdd-8f87-d245-ea9e16b1c276@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -69
X-Spam_score: -7.0
X-Spam_bar: -------
X-Spam_report: (-7.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.096,
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

13.07.2023 13:09, Philippe Mathieu-Daudé wrote:
> Hi Thomas,
> 
> On 21/6/23 09:41, Thomas Huth wrote:
>> It's possible to compile QEMU without the USB devices (e.g. when using
>> "--without-default-devices" as option for the "configure" script).
>> To be still able to run the loongson3-virt machine in default mode with
>> such a QEMU binary, we have to check here for the availability of the
>> USB devices first before instantiating them.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   v2: Use #ifdef instead of runtime check
>>
>>   hw/mips/loongson3_virt.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
>> index 216812f660..3094413eea 100644
>> --- a/hw/mips/loongson3_virt.c
>> +++ b/hw/mips/loongson3_virt.c
>> @@ -51,6 +51,7 @@
>>   #include "sysemu/reset.h"
>>   #include "sysemu/runstate.h"
>>   #include "qemu/error-report.h"
>> +#include CONFIG_DEVICES
> 
> I'm a but reluctant to include CONFIG_DEVICES.
> 
>> +#ifdef CONFIG_USB_OHCI_PCI
>>       if (defaults_enabled()) {
> 
> What about:
> 
>    if (defaults_enabled() && object_class_by_name(TYPE_PCI_OHCI)) {

I think it was a v1 like this :)

/mjt

