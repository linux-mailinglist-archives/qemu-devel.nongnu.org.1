Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C60297490EA
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 00:19:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHApM-0006in-1A; Wed, 05 Jul 2023 18:18:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qHApJ-0006gv-Jm
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 18:18:21 -0400
Received: from mail-oo1-xc32.google.com ([2607:f8b0:4864:20::c32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qHApH-0007js-9o
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 18:18:21 -0400
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-565db4666d7so402eaf.0
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 15:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1688595498; x=1691187498;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2N3FRMmzL12eCcBKsbFQPwrsz1c6EqeQC2opIuzvIkc=;
 b=BSgB7kP2yFvoxQxfNUfHqlGweCjPpXWA6WakQKHwfzNO/rGDqeb7XGnsXLBShZ0yy8
 8BOqOCfJwB81/F4GZBpGY7QnT7+eFVfFrr4L/aL/gj+Py56kNLFyI4IZRmNNJwfe3opO
 ZTDhj6eEPec2+VZT+IabLbvGeLzYUdvgIw+Kbaem0sJPCtY8u1BjdwQvUEKSEWOvJ3Uf
 CRggA7b1V1/B0rsG0exU2B5JZG+k1m+pDAQh8famKTGiiraZBbUGb1cQhzd0gS8qnO40
 qjPHuUn6G+Cf42Tj3/ptR8elSaMoOLWJCZeS/aPFXt+lgmnYcjF3g7e3OYMAV7DXlnnM
 RJkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688595498; x=1691187498;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2N3FRMmzL12eCcBKsbFQPwrsz1c6EqeQC2opIuzvIkc=;
 b=Cdm/T08d/yZwE70k1slwhADEtursR+7a4VRp0PxtERhiSLqYtF1lIFvml7O5YZsKuo
 Z0AYdQNS7yUJW6Au9vQuJcoGNpld5mz4trimxhA52FwBBBSWbyw2cTKwEd+ZB20CpOJC
 0AhDfX/8siTuRwapXcQaSUmGqiLYxPXF+BNQqeNAXBNjNWnZ7bwbU/eIpPkjVI2jNd1P
 embuD67grI413l3N/jqMNm2Pn+3ZGSBoXpVpD/9woR+Z8vo/GN90VQ4uGGpXXNWgsQLI
 zhupN1PJ6ACd3syDm+FrzYevQSS0Wqg5ZjsIfCm3/yrTL68mahL+7a9MNaUCRKxRvt8g
 I8Sw==
X-Gm-Message-State: ABy/qLYf18WxFmu7VhjjfiqKIM/ZfuhKnFBTu+55QdRPzBbzMfmnq5Rl
 8U65Tli6A3shehd15tzx2nrzuA==
X-Google-Smtp-Source: APBJJlHJXqJJ/lM+vE63fIKSuUkDoXFd6voNB9e1St0v8cuZkAfn5axtTgxWFsoSVR6jyphb0+PjFA==
X-Received: by 2002:a4a:aacc:0:b0:563:49fd:e772 with SMTP id
 e12-20020a4aaacc000000b0056349fde772mr74363oon.4.1688595497807; 
 Wed, 05 Jul 2023 15:18:17 -0700 (PDT)
Received: from [192.168.68.107] (201-69-66-110.dial-up.telesp.net.br.
 [201.69.66.110]) by smtp.gmail.com with ESMTPSA id
 n17-20020a4ae751000000b0051134f333d3sm112445oov.16.2023.07.05.15.18.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jul 2023 15:18:17 -0700 (PDT)
Message-ID: <aba237e8-1b9f-06bc-7fc5-09431cf1cf49@ventanamicro.com>
Date: Wed, 5 Jul 2023 19:18:13 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v8 02/20] hw/riscv/virt.c: skip 'mmu-type' FDT if satp
 mode not set
Content-Language: en-US
To: Conor Dooley <conor@kernel.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 bmeng@tinylab.org, liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com,
 palmer@rivosinc.com, ajones@ventanamicro.com,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
References: <20230705213955.429895-1-dbarboza@ventanamicro.com>
 <20230705213955.429895-3-dbarboza@ventanamicro.com>
 <20230705-gallstone-untitled-1463e43aa33c@spud>
 <c5372b14-b2b8-4664-4357-a7f22c880dcd@ventanamicro.com>
 <20230705-patchwork-sibling-4827156457bf@spud>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20230705-patchwork-sibling-4827156457bf@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c32;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oo1-xc32.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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



On 7/5/23 19:12, Conor Dooley wrote:
> On Wed, Jul 05, 2023 at 07:00:52PM -0300, Daniel Henrique Barboza wrote:
>>
>>
>> On 7/5/23 18:49, Conor Dooley wrote:
>>> On Wed, Jul 05, 2023 at 06:39:37PM -0300, Daniel Henrique Barboza wrote:
>>>> The absence of a satp mode in riscv_host_cpu_init() is causing the
>>>> following error:
>>>>
>>>> $ ./qemu/build/qemu-system-riscv64  -machine virt,accel=kvm \
>>>>       -m 2G -smp 1  -nographic -snapshot \
>>>>       -kernel ./guest_imgs/Image \
>>>>       -initrd ./guest_imgs/rootfs_kvm_riscv64.img \
>>>>       -append "earlycon=sbi root=/dev/ram rw" \
>>>>       -cpu host
>>>> **
>>>> ERROR:../target/riscv/cpu.c:320:satp_mode_str: code should not be
>>>> reached
>>>> Bail out! ERROR:../target/riscv/cpu.c:320:satp_mode_str: code should
>>>> not be reached
>>>> Aborted
>>>>
>>>> The error is triggered from create_fdt_socket_cpus() in hw/riscv/virt.c.
>>>> It's trying to get satp_mode_str for a NULL cpu->cfg.satp_mode.map.
>>>>
>>>> For this KVM cpu we would need to inherit the satp supported modes
>>>> from the RISC-V host. At this moment this is not possible because the
>>>> KVM driver does not support it. And even when it does we can't just let
>>>> this broken for every other older kernel.
>>>>
>>>> Since mmu-type is not a required node, according to [1], skip the
>>>> 'mmu-type' FDT node if there's no satp_mode set. We'll revisit this
>>>> logic when we can get satp information from KVM.
>>>>
>>>> [1] https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/cpu.yaml
>>>
>>> I don't think this is the correct link to reference as backup, as the
>>> generic binding sets out no requirements. I think you would want to link
>>> to the RISC-V specific cpus binding.
>>
>> You mean this link?
>>
>> https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bindings/riscv/cpus.yaml
> 
> Yeah, that's the correct file. Should probably have linked it, sorry
> about that. And in case it was not clear, not suggesting that this would
> require a resend, since the reasoning is correct.

I don't mind amending this in case we need another version for any other reason.
Otherwise we'll hope that Alistair will be a true, real gentlemann and amend the
commit msg for us :D

> 
>>> That said, things like FreeBSD and U-Boot appear to require mmu-type
>>> https://lore.kernel.org/all/20230705-fondue-bagginess-66c25f1a4135@spud/
>>> so I am wondering if we should in fact make the mmu-type a required
>>> property in the RISC-V specific binding.
>>
>>
>> To make it required, as far as QEMU is concerned, we'll need to assume a
>> default value for the 'host' CPU type (e.g. sv57). In the future we can read the
>> satp host value directly when/if KVM provides satp_mode via get_one_reg().
> 
> I dunno if assuming is the right thing to do, since it could be actively
> wrong. Leaving it out, as you are doing here, is, IMO, nicer to those
> guests. Once there's an API for it, I think it could then be added and
> then the additional guests would be supported.

Makes sense. We'll revisit this piece of code when that API I sent today find
its way upstream. Thanks,


Daniel

> 
> Thanks,
> Conor.

