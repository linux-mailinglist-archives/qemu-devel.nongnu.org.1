Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CA91C746333
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 21:12:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGOx5-0004dR-P2; Mon, 03 Jul 2023 15:11:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qGOx3-0004cO-7o
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 15:11:09 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qGOwz-0001BW-Iv
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 15:11:08 -0400
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-6b8baa72c71so1598552a34.2
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 12:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1688411464; x=1691003464;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IG5cNv8G/TvFPnLB5SBj9w4Pnse9trEpvweWpi329fo=;
 b=DnwWd375ffPvg2hKt5wHxDIs69ExU0iSOWy+8hb9wPPNOVOQXnfzsjKTJKWFIt3jVe
 d5XOLZBIyeY2DiTU2PD7TFZZETuC8rd4FO8DGb6vhzpvRPckWmtvt/sBdyVF2K6pEEvE
 pae858m+gFUFTnNemeMDNdbJju7yf8mYSDjqPYKL4BsBYhaqu+siLe7PZ6HtTDFFbrZ9
 0MG5vSGiubFPmbOLK3SxpxwT7EIjW1mgn+7bIx9J3ZThUaEfwh3wZLOL25tUadgAdqdO
 94xgg0OPQMXm0DUzghgph2zAsf3VTQoSR9TnuDsfcz7f9HINN4sC5cl5oye2oD9NOGUM
 /6Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688411464; x=1691003464;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IG5cNv8G/TvFPnLB5SBj9w4Pnse9trEpvweWpi329fo=;
 b=RWdpFf4LBHDOkj/sRHmncuwzYwvbLNyxPrlSxJEuqyOpLSUXFf6FkTYjs+/wr5r+zv
 yOArY6NqV0Zd8dnJbWkQDWwZmvl2h+L7tEfCRkU23vYwmT1ZP0M06LeaRAToHPblOAzW
 5KDDrcQe2NlgOLaBl0TS6pDCsh7lnbFJoL9yYHhUPftCqZ6RLWASv8XLl6nF26MKjilg
 32ZKad02OylJOTegHdQjvW4q8jalxofk9HdsDPDsALU6YFwT6mmlTlgCP8EqcooGcK7Q
 OAdiBX0VJht7rd3t+x+fyqM0X0TcXh9ttu+1OopD7v69+El4snGa89gOFpP2fxigxU4S
 40RA==
X-Gm-Message-State: ABy/qLZkg0wiOn4WFCY8CZHtTS4J2LvJrlzjT5EUvL9joytrA6ODOCRO
 6lTJ4wcwP3QebxPuqceOyxAZIA==
X-Google-Smtp-Source: ACHHUZ7xgQO+tsk4yATUwLWAKB6XO6UaQpNZUBiP3DJ4TvJFb4SpHwap+JupvhNwcP2fk0iHCuOlwg==
X-Received: by 2002:a05:6870:a902:b0:1b0:25b4:4b7a with SMTP id
 eq2-20020a056870a90200b001b025b44b7amr11221345oab.51.1688411463792; 
 Mon, 03 Jul 2023 12:11:03 -0700 (PDT)
Received: from [192.168.68.107] (201-69-66-110.dial-up.telesp.net.br.
 [201.69.66.110]) by smtp.gmail.com with ESMTPSA id
 w18-20020a056870a2d200b001aa1779d0besm12801395oak.7.2023.07.03.12.10.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jul 2023 12:11:03 -0700 (PDT)
Message-ID: <fc841e67-0e3f-34ba-011f-c52f142ff32d@ventanamicro.com>
Date: Mon, 3 Jul 2023 16:10:56 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] riscv: Generate devicetree only after machine
 initialization is complete
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Guenter Roeck <linux@roeck-us.net>, Palmer Dabbelt <palmer@dabbelt.com>
Cc: Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Alistair Francis <alistair23@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Jia Liu <proljc@gmail.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Paul Burton <paulburton@kernel.org>, Peter Maydell
 <peter.maydell@linaro.org>, Radoslaw Biernacki <rad@semihalf.com>,
 Song Gao <gaosong@loongson.cn>, Stafford Horne <shorne@gmail.com>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <20230703034614.3909079-1-linux@roeck-us.net>
 <e08863cd-f4ac-9ffa-b79b-5f9c594f1db4@linaro.org>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <e08863cd-f4ac-9ffa-b79b-5f9c594f1db4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x32c.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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



On 7/3/23 04:46, Philippe Mathieu-Daudé wrote:
> On 3/7/23 05:46, Guenter Roeck wrote:
>> If the devicetree is created before machine initialization is complete,
>> it misses dynamic devices. Specifically, the tpm device is not added
>> to the devicetree file and is therefore not instantiated in Linux.
>> Create devicetree in virt_machine_done() to solve the problem.
> 
> This makes sense, but what about the other archs/machines?
> Shouldn't we fix this generically?

As far as other archs goes I can say that ARM isn't affected by it because
the fdt creation is done by arm_load_dtb() during virt_machine_done time.
I'm not aware of how x86 handles TPM. And pseries/ppc64 does a completely
different thing (per usual).

Inside hw/riscv the only TPM capable board is 'virt'. So I think this patch
has an adequate scope.


Thanks,


Daniel


> 
>> Cc: Alistair Francis <alistair23@gmail.com>
>> Fixes: 325b7c4e75 hw/riscv: Enable TPM backends
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>   hw/riscv/virt.c | 9 ++++++---
>>   1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
>> index ed4c27487e..08876284f5 100644
>> --- a/hw/riscv/virt.c
>> +++ b/hw/riscv/virt.c
>> @@ -1248,6 +1248,11 @@ static void virt_machine_done(Notifier *notifier, void *data)
>>       uint64_t kernel_entry = 0;
>>       BlockBackend *pflash_blk0;
>> +    /* create devicetree if not provided */
>> +    if (!machine->dtb) {
>> +        create_fdt(s, memmap);
>> +    }
>> +
>>       /*
>>        * Only direct boot kernel is currently supported for KVM VM,
>>        * so the "-bios" parameter is not supported when KVM is enabled.
>> @@ -1508,15 +1513,13 @@ static void virt_machine_init(MachineState *machine)
>>       }
>>       virt_flash_map(s, system_memory);
>> -    /* load/create device tree */
>> +    /* load device tree */
>>       if (machine->dtb) {
>>           machine->fdt = load_device_tree(machine->dtb, &s->fdt_size);
>>           if (!machine->fdt) {
>>               error_report("load_device_tree() failed");
>>               exit(1);
>>           }
>> -    } else {
>> -        create_fdt(s, memmap);
>>       }
>>       s->machine_done.notify = virt_machine_done;
> 

