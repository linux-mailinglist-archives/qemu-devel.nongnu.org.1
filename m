Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AF8017EE041
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 12:58:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3azx-0000Rn-Ci; Thu, 16 Nov 2023 06:57:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1r3azv-0000RD-07
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 06:57:27 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1r3azt-0008Mt-1D
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 06:57:26 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1cc53d0030fso5479315ad.0
 for <qemu-devel@nongnu.org>; Thu, 16 Nov 2023 03:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1700135843; x=1700740643; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=S6FK7P8Z5Z31rsSNv/rs3uzXVy4fYvm6ZuAPPa0ZWbE=;
 b=bET2fzrKLkhOjwv+21T5/9EMKkI/dSHz8UreK0mvz5tK3TjWiw+NToo+NZ4g9giJrj
 aNVCU+J+uHmhLI7YYdIxw5otUhI65xD5TA4jjq7zDiEEnkUPWCPhzKGuqr75J5F4XKxp
 Ry8KZ2b6z92yVQMPgoxOwh5nKiBud6hkDequtT6MqnIW8Bhtw3QWYAVinnRu0v7sdOZz
 Sce85bi0ju5yFg9HEBj8LzINRkbAMBKtVzMF7/Au5WaEFU+j3CmfF7gUaNXCVitC5ieP
 0MkW60xiYmXRQSG3uo4B7I7RrU4PyL9qtGfufc1ouIw6QZnFoiRVI86giBII9QgvbOZ3
 iUKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700135843; x=1700740643;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=S6FK7P8Z5Z31rsSNv/rs3uzXVy4fYvm6ZuAPPa0ZWbE=;
 b=olvDdHYLuCJLvva/ANnY7jCtMa7u55ONpb4FtqGy4JnktXFDju7MxnGm7fdJBOQ8Yk
 g5E/hq32f49haSPFAe+aCfw8Q0/W98i/bRoGBx19onYLip/8QG83KFwXDzsblsBlvvOj
 fIjBRY5eBbfdjpsPaebObFH8b1qpVvFsb4K72TJoT5y/o8tMxkUYHqp4/+t/Xxsw8hLa
 buitgIZBxc/Al+8Hhm1BN9UAe1zswNJUq5IiARxCuQgdcDw6TUve1A25HZmBZUzWLtNu
 lC+zGf6boPNOv5B5a6qdt1od8VAyrlr/dAtKjnvOTxe31JrZezJ5WPgKjmYKWzFty06U
 f9OA==
X-Gm-Message-State: AOJu0Ywq4ma3xs7X9iaBomrp3icvoJq3w+dbV+6++k+n+buBJl7EZtFk
 O+Rp0QTUWsyEHwdu6rficsuncQ==
X-Google-Smtp-Source: AGHT+IE31yq4Yxy3Vx/xkCUWDn2VKqztirCFpUWSD/8lnGTqg56fbcBDpeiIsmIjlyh3/1WtFUCY4A==
X-Received: by 2002:a17:903:244b:b0:1cc:4a83:d839 with SMTP id
 l11-20020a170903244b00b001cc4a83d839mr2450662pls.17.1700135843363; 
 Thu, 16 Nov 2023 03:57:23 -0800 (PST)
Received: from [192.168.68.109] ([152.250.131.148])
 by smtp.gmail.com with ESMTPSA id
 x16-20020a170902ec9000b001c6052152fdsm9064427plg.50.2023.11.16.03.57.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Nov 2023 03:57:22 -0800 (PST)
Message-ID: <d5232072-018a-40e2-8c25-096ed18ca641@ventanamicro.com>
Date: Thu, 16 Nov 2023 08:57:18 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Fix CLINT clock frequency for SiFive E
Content-Language: en-US
To: =?UTF-8?B?Um9tw6FuIEPDoXJkZW5hcyBSb2Ryw61ndWV6?= <rcardenas.rod@gmail.com>
Cc: qemu-devel@nongnu.org, "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Weiwei Li <liweiwei@iscas.ac.cn>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20231110161457.60528-1-rcardenas.rod@gmail.com>
 <035908b8-4964-4878-a0c3-bca06af45b54@ventanamicro.com>
 <ECB4CA72-630F-4DAC-9386-D0884DB9DA9F@gmail.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <ECB4CA72-630F-4DAC-9386-D0884DB9DA9F@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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



On 11/15/23 18:06, Román Cárdenas Rodríguez wrote:
> Hi, Daniel!
> 
> Sorry for that, I’m quite new to this way of contributing (you may notice that I sent the same patch several times, I apologize).
> 
> If you check the manual of SiFive E310 (https://cdn.sparkfun.com/assets/7/f/0/2/7/fe310-g002-manual-v19p05.pdf?_gl=1*w2ieef*_ga*MTcyNDI2MjM0Ny4xNjk2ODcwNTM3*_ga_T369JS7J9N*MTY5Njg3MDUzNy4xLjAuMTY5Njg3MDUzNy42MC4wLjA. <https://cdn.sparkfun.com/assets/7/f/0/2/7/fe310-g002-manual-v19p05.pdf?_gl=1*w2ieef*_ga*MTcyNDI2MjM0Ny4xNjk2ODcwNTM3*_ga_T369JS7J9N*MTY5Njg3MDUzNy4xLjAuMTY5Njg3MDUzNy42MC4wLjA.>), you can see in Figure 1 that the CLINT is connected to the real time clock, which also feeds the AON peripheral (they share the same clock).
> 
> In page 43, the docs also say that the timer registers of the CLINT count ticks from the rtcclk.
> 
> I attached a couple of screenshots to ease the process.
> 
> Thank you very much for your time, let me know if I can help you with further documentation
> 
> PS: I am currently playing with bare metal applications both in QEMU and a physical SiFive E310 board and I confirm that the CLINT clock in the physical board runs at 32.768 kHz. In QEMU, the same app produces a completely different outcome, as sometimes a new CLINT interrupt is triggered before finishing other tasks.


I read the doc and this makes sense.

Can you please re-send the patch, same code, but with all this information in the commit
message? We need this context to justify changing the existing sifive-e board clock.

ps: It would be nice if someone from Sifive could drop an ACK in this change.


Thanks,

Daniel

> 
> 
> Screenshot 2023-11-15 at 21.58.17.png
> 
> Screenshot 2023-11-15 at 21.57.27.png
> 
>> On 15 Nov 2023, at 21:51, Daniel Henrique Barboza <dbarboza@ventanamicro.com> wrote:
>>
>> Hi Roman!
>>
>> It helps to add the maintainers/reviewers in the CC when sending the patch. You
>> can see who need to be CCed by using the get_maintainer.pl script. E.g:
>>
>> ./scripts/get_maintainer.pl \[PATCH\]\ Fix\ CLINT\ clock\ frequency\ for\ SiFive\ E\ -\ rcardenas.rod@gmail.com\ -\ 2023-11-10\ 1314.eml
>>
>> Alistair Francis <Alistair.Francis@wdc.com> (supporter:SiFive Machines)
>> Bin Meng <bin.meng@windriver.com> (supporter:SiFive Machines)
>> Palmer Dabbelt <palmer@dabbelt.com> (supporter:SiFive Machines)
>> Weiwei Li <liwei1518@gmail.com> (reviewer:RISC-V TCG CPUs)
>> Daniel Henrique Barboza <dbarboza@ventanamicro.com> (reviewer:RISC-V TCG CPUs)
>> Liu Zhiwei <zhiwei_liu@linux.alibaba.com> (reviewer:RISC-V TCG CPUs)
>> qemu-riscv@nongnu.org (open list:SiFive Machines)
>> qemu-devel@nongnu.org (open list:All patches CC here)
>>
>>
>> I'm CCing all these folks in the reply.
>>
>>
>> On 11/10/23 13:14, rcardenas.rod@gmail.com wrote:
>>> From: Román Cárdenas Rodríguez <rcardenas.rod@gmail.com>
>>> ---
>>>  hw/riscv/sifive_e.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>> diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
>>> index 0d37adc542..87d9602383 100644
>>> --- a/hw/riscv/sifive_e.c
>>> +++ b/hw/riscv/sifive_e.c
>>> @@ -225,7 +225,7 @@ static void sifive_e_soc_realize(DeviceState *dev, Error **errp)
>>>              RISCV_ACLINT_SWI_SIZE,
>>>          RISCV_ACLINT_DEFAULT_MTIMER_SIZE, 0, ms->smp.cpus,
>>>          RISCV_ACLINT_DEFAULT_MTIMECMP, RISCV_ACLINT_DEFAULT_MTIME,
>>> -        RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ, false);
>>> +        SIFIVE_E_LFCLK_DEFAULT_FREQ, false);
>>
>> I'm not sure if this is correct. The last commit that touched this line was b8fb878aa2
>> ("hw/intc: Upgrade the SiFive CLINT implementation to RISC-V ACLINT"). If you see the commit
>> diff, the previous value was:
>>
>> -            SIFIVE_CLINT_TIMEBASE_FREQ, false);
>>
>> In this same commit we can see that the existing value of that macro back then was:
>>
>> -    SIFIVE_CLINT_TIMEBASE_FREQ = 10000000
>>
>>
>> Which is the same value of RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ.
>>
>>
>> The value you're changing to, SIFIVE_E_LFCLK_DEFAULT_FREQ (32768), seems to be related to the
>> SIFIVE AON watchdog implemented in hw/misc/sifive_e_aon.c:
>>
>> static void sifive_e_aon_init(Object *obj)
>> {
>>    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
>>    SiFiveEAONState *r = SIFIVE_E_AON(obj);
>>
>>    memory_region_init_io(&r->mmio, OBJECT(r), &sifive_e_aon_ops, r,
>>                          TYPE_SIFIVE_E_AON, SIFIVE_E_AON_MAX);
>>    sysbus_init_mmio(sbd, &r->mmio);
>>
>>    /* watchdog timer */
>>    r->wdog_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
>>                                 sifive_e_aon_wdt_expired_cb, r);
>>    r->wdogclk_freq = SIFIVE_E_LFCLK_DEFAULT_FREQ;   <==========
>>    sysbus_init_irq(sbd, &r->wdog_irq);
>> }
>>
>>
>>
>> Thanks,
>>
>>
>> Daniel
>>
>>
>>
>>>      sifive_e_prci_create(memmap[SIFIVE_E_DEV_PRCI].base);
>>>        /* AON */
> 

