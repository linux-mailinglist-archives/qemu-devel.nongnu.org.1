Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E2A7ED36C
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 21:52:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3Mr8-0002vL-QS; Wed, 15 Nov 2023 15:51:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1r3Mr6-0002un-JS
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 15:51:24 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1r3Mr4-0004Lb-Sz
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 15:51:24 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1cc5b705769so1139495ad.0
 for <qemu-devel@nongnu.org>; Wed, 15 Nov 2023 12:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1700081480; x=1700686280; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=l43tlOgsYJ+rr/5eLqphSGu7z320lk7WToOcB8zTvKY=;
 b=l1du3WiJ3BdfAcdyHNjsbIoU9VbfoADBdhf2INJP7hZARdU1VZCbOXCBOglBiiu+aT
 xSOeK69+0MT2VzKCRjTIZ15Fx6dde4WUPv4WBaWvxby9zfbrFtzsOjoK32xckfaoat/k
 7fBOu0sKO6e3QfQ3pEK9PutmHhDcWBhn8nsauC+AOqOnSnI74BPSr2jRygjUNq6yYyM9
 QlAHy3Xah3MPnNXffPRrJDWF92NLd5u5r3CmlJ3iNtxK1X1gEyZG8O2k2beP5U+Odjjl
 kqmMAikZZ1cW6OrlSaMQFywgj+hj2aiU3kaWkIRE3gm4xYe5OgIVYtzRGNNN2ket30yO
 OO4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700081480; x=1700686280;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=l43tlOgsYJ+rr/5eLqphSGu7z320lk7WToOcB8zTvKY=;
 b=Dj0MsnbTryld7O0PBfQXhN9m2vX4M7dGbjNv6VR7nP1e7eOAhjfGidRKD9OVGBdvHC
 ROC9CyCUtVc3+YRY86FEUoJQSJ0ire6+TchMixYn25Y1Uziw9imxQ9ho0OKPwpOFTi/5
 PRvzxtAci62Wjb8+J7fITo51HW5P1qtpImNwXZ85++FKM8ILQGMCjzZDXTBUu3R7BPHM
 Uky2QJ0LuA/tUO+rHgownmQBcjV4YoZESHJq31UozPDY9qcyEDUQyCvXkalJKMU6fZI0
 2q/I+byBdH5nMWTUubUmkAWIuvOd29DX3xBew6CxcVeMqGy1H6Fm7OmNTrn0MtUsaoBm
 wJHQ==
X-Gm-Message-State: AOJu0YwBUUS59//QN9WWsNEImt0Wvv6Vd+ZAjW05LDyRqGpcxevhtWeF
 jBSoZ2/BN1e+f9a1Yf6YSoQ7wg==
X-Google-Smtp-Source: AGHT+IENSY4oWYsYroAlh70eBHuoxGlB8qqPgp/EWH6wYzCxKz+QmtB6N+H0bA8/3aZ1dQWzdDEVYg==
X-Received: by 2002:a17:902:d2c3:b0:1b0:f8:9b2d with SMTP id
 n3-20020a170902d2c300b001b000f89b2dmr7149135plc.29.1700081480385; 
 Wed, 15 Nov 2023 12:51:20 -0800 (PST)
Received: from [192.168.68.109] ([152.250.131.148])
 by smtp.gmail.com with ESMTPSA id
 s13-20020a170902988d00b001b567bbe82dsm7818390plp.150.2023.11.15.12.51.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Nov 2023 12:51:19 -0800 (PST)
Message-ID: <035908b8-4964-4878-a0c3-bca06af45b54@ventanamicro.com>
Date: Wed, 15 Nov 2023 17:51:16 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Fix CLINT clock frequency for SiFive E
Content-Language: en-US
To: rcardenas.rod@gmail.com, qemu-devel@nongnu.org
References: <20231110161457.60528-1-rcardenas.rod@gmail.com>
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Weiwei Li <liweiwei@iscas.ac.cn>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20231110161457.60528-1-rcardenas.rod@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62a.google.com
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

Hi Roman!

It helps to add the maintainers/reviewers in the CC when sending the patch. You
can see who need to be CCed by using the get_maintainer.pl script. E.g:

./scripts/get_maintainer.pl \[PATCH\]\ Fix\ CLINT\ clock\ frequency\ for\ SiFive\ E\ -\ rcardenas.rod@gmail.com\ -\ 2023-11-10\ 1314.eml

Alistair Francis <Alistair.Francis@wdc.com> (supporter:SiFive Machines)
Bin Meng <bin.meng@windriver.com> (supporter:SiFive Machines)
Palmer Dabbelt <palmer@dabbelt.com> (supporter:SiFive Machines)
Weiwei Li <liwei1518@gmail.com> (reviewer:RISC-V TCG CPUs)
Daniel Henrique Barboza <dbarboza@ventanamicro.com> (reviewer:RISC-V TCG CPUs)
Liu Zhiwei <zhiwei_liu@linux.alibaba.com> (reviewer:RISC-V TCG CPUs)
qemu-riscv@nongnu.org (open list:SiFive Machines)
qemu-devel@nongnu.org (open list:All patches CC here)


I'm CCing all these folks in the reply.


On 11/10/23 13:14, rcardenas.rod@gmail.com wrote:
> From: Román Cárdenas Rodríguez <rcardenas.rod@gmail.com>
> 
> ---
>   hw/riscv/sifive_e.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
> index 0d37adc542..87d9602383 100644
> --- a/hw/riscv/sifive_e.c
> +++ b/hw/riscv/sifive_e.c
> @@ -225,7 +225,7 @@ static void sifive_e_soc_realize(DeviceState *dev, Error **errp)
>               RISCV_ACLINT_SWI_SIZE,
>           RISCV_ACLINT_DEFAULT_MTIMER_SIZE, 0, ms->smp.cpus,
>           RISCV_ACLINT_DEFAULT_MTIMECMP, RISCV_ACLINT_DEFAULT_MTIME,
> -        RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ, false);
> +        SIFIVE_E_LFCLK_DEFAULT_FREQ, false);

I'm not sure if this is correct. The last commit that touched this line was b8fb878aa2
("hw/intc: Upgrade the SiFive CLINT implementation to RISC-V ACLINT"). If you see the commit
diff, the previous value was:

-            SIFIVE_CLINT_TIMEBASE_FREQ, false);

In this same commit we can see that the existing value of that macro back then was:

-    SIFIVE_CLINT_TIMEBASE_FREQ = 10000000


Which is the same value of RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ.


The value you're changing to, SIFIVE_E_LFCLK_DEFAULT_FREQ (32768), seems to be related to the
SIFIVE AON watchdog implemented in hw/misc/sifive_e_aon.c:

static void sifive_e_aon_init(Object *obj)
{
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
     SiFiveEAONState *r = SIFIVE_E_AON(obj);

     memory_region_init_io(&r->mmio, OBJECT(r), &sifive_e_aon_ops, r,
                           TYPE_SIFIVE_E_AON, SIFIVE_E_AON_MAX);
     sysbus_init_mmio(sbd, &r->mmio);

     /* watchdog timer */
     r->wdog_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
                                  sifive_e_aon_wdt_expired_cb, r);
     r->wdogclk_freq = SIFIVE_E_LFCLK_DEFAULT_FREQ;   <==========
     sysbus_init_irq(sbd, &r->wdog_irq);
}



Thanks,


Daniel



>       sifive_e_prci_create(memmap[SIFIVE_E_DEV_PRCI].base);
>   
>       /* AON */

