Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 313087E01BC
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 12:10:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qys3p-0003Zq-2T; Fri, 03 Nov 2023 07:09:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qys3n-0003ZZ-AM
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 07:09:55 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qys3l-0001gO-Dm
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 07:09:55 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-407c3adef8eso16848175e9.2
 for <qemu-devel@nongnu.org>; Fri, 03 Nov 2023 04:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699009791; x=1699614591; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=duysefl+2NL/KJGW8keL3aZWbNjyZCifsZpSeU+nR8Q=;
 b=UoGzhO9l0UfLp80ta4fG1sIKHUwY4KRIG2IfbsT+BCK3UNfSwdR2viZtd667y/hv5o
 KmtmdeFVZMcNNZDAkklS5AV7KDGsCm5H3xqstkTJpr3QlQYDmC/txACWKQVDmYZ87mzx
 SDmcvs0t0WTuqljK1vaDVGjBmkS4bnsCrzrO+6jaCLe0rBtOzoYOrCBm85pWi/d+3o1B
 6eHVhhMpgCUqmbgmYPSDZQQ1ob38IrKXxTv4iKusm6F9i+gHADmsnKc2TniRzgCN2fpm
 8sbHAN2Ak0jktNwTFkyL1aGtAvdqRpAITUE+108rHzxG2O82E6RGmoeKBV7hjipSlQVU
 z6iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699009791; x=1699614591;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=duysefl+2NL/KJGW8keL3aZWbNjyZCifsZpSeU+nR8Q=;
 b=WN9A9X6RBWSH+X4w1cnWwGPOtSIXnzxpP6bLnsnoRiwVxaRZqLU9GGm1j0AbZqtwxL
 t7ZKDxUSJN9Z/dwcoi3HrTOTWfAEtMVvdScyCFhRJg9Smw5g69Klux6Q2neJZ1RDxjBZ
 +kV74qgWscaCKJqy0R7vbF1T+D7x/qhR/gFp55SkN0xH0hwIVqZP+yHOtv8/t428eU4Q
 lTlgmebmX56pSPiz1osD5ZUKKUoDsnEHQAVDFCI9mccXAyyFEq2Whk0zlESkYEzLwAf9
 +GMayovkRP6uq3fkKo5LSDT+w+JBIK2VYZtq8lnWuwjS5iNNPTN+axTjrE4W583w1j7Y
 YwjA==
X-Gm-Message-State: AOJu0YxoCXu96sovv6pnr3jAS8OKLi+LR+/PsuTkO3IQJSLMteIBmfHu
 FnV9fZ1eD8+uDDU9+s5UrHo3Bw==
X-Google-Smtp-Source: AGHT+IGVx4/bMhb6r4CL7dD2aJq0C+DVgy2yjy++ad/Ihqk83Qb1YM62BcbwJYIPAX9AVbspl5ycig==
X-Received: by 2002:a05:600c:1c04:b0:407:5b7c:2f6a with SMTP id
 j4-20020a05600c1c0400b004075b7c2f6amr17666995wms.0.1699009791580; 
 Fri, 03 Nov 2023 04:09:51 -0700 (PDT)
Received: from [192.168.69.115] (cou50-h02-176-172-52-228.dsl.sta.abo.bbox.fr.
 [176.172.52.228]) by smtp.gmail.com with ESMTPSA id
 i17-20020a05600c481100b004063d8b43e7sm2063761wmo.48.2023.11.03.04.09.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Nov 2023 04:09:51 -0700 (PDT)
Message-ID: <8ef2a102-3d3a-3979-6610-036c68262f6f@linaro.org>
Date: Fri, 3 Nov 2023 12:09:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 3/5] hw/ppc/e500: QOM-attach CPUs to the machine container
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Luc Michel <luc.michel@amd.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Bernhard Beschow <shentey@gmail.com>, qemu-ppc@nongnu.org,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 "Daniel P . Berrange" <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>
References: <20231030143957.82988-1-philmd@linaro.org>
 <20231030143957.82988-4-philmd@linaro.org> <874ji32sj9.fsf@pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <874ji32sj9.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -59
X-Spam_score: -6.0
X-Spam_bar: ------
X-Spam_report: (-6.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.938,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 3/11/23 08:40, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
> 
>> Instead of having CPUs dangling in the /unattached/device
>> bucket, attach them to the machine container.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   hw/ppc/e500.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
>> index e04114fb3c..f8177c0280 100644
>> --- a/hw/ppc/e500.c
>> +++ b/hw/ppc/e500.c
>> @@ -946,6 +946,7 @@ void ppce500_init(MachineState *machine)
>>               exit(1);
>>           }
>>   
>> +        object_property_add_child(OBJECT(machine), "cpu[*]", OBJECT(cs));
>>           /*
>>            * Secondary CPU starts in halted state for now. Needs to change
>>            * when implementing non-kernel boot.
> 
> A peek at "info qom-tree" confirms the CPU is in /machine/unattached/.
> Along with most onboard devices.  Details below.
> 
> Quick test...  I count 563 machines.  394 seem to have CPU(s) in or
> below /machine/unattached/, 129 elsewhere, and 40 I can't easily
> examine, because they don't start to monitor without additional CLI
> arguments.
> 
> Where should CPUs be?

It is machine specific.

- For System-on-Chip, it would be in /soc

- For systems that fully model CPU topology, I'd expect a consistent
   topology path. (If it is part of a cluster, in that /cluster).

- For mainframes, it should be part of the CPU cards that can be
   inserted?

- For a single Pentium CPU, maybe /machine is sufficient.

> Is /machine/unattached/ basically where we dump products of lazy
> modelling?

Unfortunately, yes. Also where CLI created devices are I guess.

> If yes, should we try to empty it out?

If it is useful. For components expected to be referenced externally
by humans, probably. If only used by scripts, maybe not, except if
human have to debug.

> If we shouldn't, then why move this one out?

When looking for a component in the tree, I start to look at /machine,
having to fish for it elsewhere is not very natural. I'd change your
question by:
- Why do we need /unattached?
or
- Why do we have 2 different folders, /machine and /unattached?
If it is a headache, why not just simply merge them both?

> $ qemu-system-ppc -nodefaults -S -display none -M ppce500 -monitor stdio
> QEMU 8.1.50 monitor - type 'help' for more information
> (qemu) info qom-tree
> /machine (ppce500-machine)
>    /e500-ccsr (e500-ccsr)
>      /e500-ccsr[0] (memory-region)
>      /e500-pci-bar0[0] (memory-region)
>    /pci-host (e500-pcihost)
>      /bm-e500[0] (memory-region)
>      /pci bus memory[0] (memory-region)
>      /pci-conf-data[0] (memory-region)
>      /pci-conf-idx[0] (memory-region)
>      /pci-container[0] (memory-region)
>      /pci-pio[0] (memory-region)
>      /pci.0 (PCI)
>      /pci.reg[0] (memory-region)
>    /peripheral (container)
>    /peripheral-anon (container)
[...]

>    /unattached (container)
>      /device[0] (e500v2_v30-powerpc-cpu)
>        /unnamed-gpio-in[0] (irq)
>        /unnamed-gpio-in[1] (irq)
>        /unnamed-gpio-in[2] (irq)
>        /unnamed-gpio-in[3] (irq)
>        /unnamed-gpio-in[4] (irq)
>        /unnamed-gpio-in[5] (irq)
>        /unnamed-gpio-in[6] (irq)
>      /device[1] (mpc-i2c)
>        /i2c (i2c-bus)
>        /mpc-i2c[0] (memory-region)
>      /device[2] (ds1338)
>      /device[3] (unimplemented-device)
>        /esdhc[0] (memory-region)
>      /device[4] (generic-sdhci)
>        /sd-bus (sdhci-bus)
>        /sdhci[0] (memory-region)
>      /device[5] (mpc8544-guts)
>        /mpc8544.guts[0] (memory-region)
>      /device[6] (e500-host-bridge)
>        /bus master container[0] (memory-region)
>        /bus master[0] (memory-region)
>      /device[7] (e500-spin)
>        /e500 spin pv device[0] (memory-region)
>      /device[8] (mpc8xxx_gpio)
>        /mpc8xxx_gpio[0] (memory-region)
>        /unnamed-gpio-in[0] (irq)
>        /unnamed-gpio-in[10] (irq)
>        /unnamed-gpio-in[11] (irq)
>        /unnamed-gpio-in[12] (irq)
>        /unnamed-gpio-in[13] (irq)
>        /unnamed-gpio-in[14] (irq)
>        /unnamed-gpio-in[15] (irq)
>        /unnamed-gpio-in[16] (irq)
>        /unnamed-gpio-in[17] (irq)
>        /unnamed-gpio-in[18] (irq)
>        /unnamed-gpio-in[19] (irq)
>        /unnamed-gpio-in[1] (irq)
>        /unnamed-gpio-in[20] (irq)
>        /unnamed-gpio-in[21] (irq)
>        /unnamed-gpio-in[22] (irq)
>        /unnamed-gpio-in[23] (irq)
>        /unnamed-gpio-in[24] (irq)
>        /unnamed-gpio-in[25] (irq)
>        /unnamed-gpio-in[26] (irq)
>        /unnamed-gpio-in[27] (irq)
>        /unnamed-gpio-in[28] (irq)
>        /unnamed-gpio-in[29] (irq)
>        /unnamed-gpio-in[2] (irq)
>        /unnamed-gpio-in[30] (irq)
>        /unnamed-gpio-in[31] (irq)
>        /unnamed-gpio-in[3] (irq)
>        /unnamed-gpio-in[4] (irq)
>        /unnamed-gpio-in[5] (irq)
>        /unnamed-gpio-in[6] (irq)
>        /unnamed-gpio-in[7] (irq)
>        /unnamed-gpio-in[8] (irq)
>        /unnamed-gpio-in[9] (irq)
>      /device[9] (platform-bus-device)
>        /platform bus[0] (memory-region)

Actually most of these do have a QOM parent.

Correctly placing them in the tree should help when trying to
resolve a component and avoiding an ambiguous match.

>      /io[0] (memory-region)
>      /non-qdev-gpio[0] (irq)
>      /sysbus (System)
>      /system[0] (memory-region)
> 


