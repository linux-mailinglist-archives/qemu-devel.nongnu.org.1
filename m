Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F3CD3712BB8
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 19:25:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2bB1-0001lo-8I; Fri, 26 May 2023 13:24:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q2bAy-0001lE-EB; Fri, 26 May 2023 13:24:28 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q2bAw-0007kn-VQ; Fri, 26 May 2023 13:24:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yaHounYOxznC2dmDyiMNMKaOaeUdwXRxw+2bwttEFx8=; b=O2h2CPdxyXyzU9HAP2lLyU7/EP
 2Y5BkLEnljWkr1zR6QLnIZIrWJDjNk5fnKKPDRrwllDJLcg89Dg+1IWzqO4d2fo9CtTMqvftB3INZ
 brv3FbQu2qYoAIHqZdTdaon+sM3LHXKcJxIwWgq7cH7KqCjpovMft0L9KVbiPOgkLGC2G36spGCct
 HRjxcR/nCLII1xRAFp7gYjQfOpSFIfD+wfvMaApkNIWbYpUiM1TLavybj1yGjFL/X4ZHoVdwiKflP
 YQXbNFQPYKDAjZ7e4nyAwpnDlvnzZvASkEy96YtRuMSEygRj9Be48zspRpfQwSD5v1jWrQQF5Vto0
 PR5VPYr+ege527Xr87wHvTrLXcJxH1D3nC944QzVNvKdHqqLCWwOYt1avJdFbIWmqE69QX5NesrwO
 62Z1NG05Xv+LBZ3Dh6KE9W9JdVl+qhCz9Xz7jgj5phyWa2SvhNR8q/wjTjHzQ6oHGE+36VlRphKbY
 tVWtZMv6sk0fWWsIf2zKJR9ASHhNT4fF4PaKtCEjHITabrbt++tHV5ijYCnd0DY+L2RK5Ely6uHEh
 y4jMulKsq582nCEHXaiG0s6+hWu6n9A1VE5EfRpRbWq30mbLn1NJWAnxfJy+LNrFfmD873WKnJ6LQ
 FhLEKFtBbH8k5TWUTly9PeV6WPUiPjrcLJu+4poaY=;
Received: from [2a00:23c4:8bac:6900:b726:cf58:4c12:f013]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q2bAm-000CLh-86; Fri, 26 May 2023 18:24:16 +0100
Message-ID: <a36c6acc-6b27-884a-cf2a-521435feed40@ilande.co.uk>
Date: Fri, 26 May 2023 18:24:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, Thomas Huth <thuth@redhat.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
References: <20230526125323.2386324-1-thuth@redhat.com>
 <e2854ac5-e786-fcdf-453a-5a4fd343e871@eik.bme.hu>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
In-Reply-To: <e2854ac5-e786-fcdf-453a-5a4fd343e871@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bac:6900:b726:cf58:4c12:f013
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH] hw/ppc/mac_newworld: Check for the availability of
 pci-ohci before using it
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.092,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 26/05/2023 14:30, BALATON Zoltan wrote:

> On Fri, 26 May 2023, Thomas Huth wrote:
>> pci-ohci might habe been disabled in the QEMU binary (e.g. when "configure"
>> has been run with "--without-default-devices"). Thus we should check
>> for its availability before blindly using it.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>> hw/ppc/mac_newworld.c | 3 ++-
>> 1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
>> index 535710314a..c7cca430e1 100644
>> --- a/hw/ppc/mac_newworld.c
>> +++ b/hw/ppc/mac_newworld.c
>> @@ -349,7 +349,8 @@ static void ppc_core99_init(MachineState *machine)
>>                                     sysbus_mmio_get_region(s, 3));
>>     }
>>
>> -    machine->usb |= defaults_enabled() && !machine->usb_disabled;
>> +    machine->usb |= defaults_enabled() && !machine->usb_disabled &&
>> +                    module_object_class_by_name("pci-ohci") != 0;
> 
> Considering that PowerMacs have an OHCI controller built in soldered to the 
> motherboard should this depend on it instead and not rely on pulling it in with 
> PCI_DEVICES and --without-default-devices disabling it?
> 
> Currently it's not quite emulating a real Mac but I think we should aim for going 
> that way rather than to keep emulating random Mac hardware.

Indeed that's correct: New World Macs should always have USB ports built-in. I guess 
the problem here is that this isn't being indicated correctly via Kconfig and/or the 
machine->usb_disabled logic?

> Regards,
> BALATON Zoltan
> 
>>     has_pmu = (core99_machine->via_config != CORE99_VIA_CONFIG_CUDA);
>>     has_adb = (core99_machine->via_config == CORE99_VIA_CONFIG_CUDA ||
>>                core99_machine->via_config == CORE99_VIA_CONFIG_PMU_ADB);


ATB,

Mark.


