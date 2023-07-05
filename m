Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7197490C5
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 00:01:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHAYd-0008Oa-7u; Wed, 05 Jul 2023 18:01:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qHAYV-0008O3-KP
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 18:01:00 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qHAYT-0002g7-LX
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 18:00:59 -0400
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3a1ebb85f99so146317b6e.2
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 15:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1688594456; x=1691186456;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=O9Umo4Ym/zYVPcLMiYaq5ll1qCgBNhmHnB4z7LEUNC4=;
 b=iikOq/eDtDK8KKNCXxkd6tz2baLgXYOIQ9ZwD90vCK4kKJ3Fgs3rdYNtOROJHm7X/c
 5O2gimm1iTL2pljzgrubWnHpPFVdnXHLZ9AZyljn98G1aG4ZE3UCELanvLqPp+6rzKak
 oLuVMWQNAf3XRG7BZYuk4dj+1+2p+ZxEjaqeAbSFIW8ueH8/09hszcE2r80xPwVGKDEY
 mCZnqEBUfBgZcZ7KKf7yrRm4BFGo2pCy2LNbcCfqlgbkWUTZIHm9IY99TRpsXspIeEQK
 uGfXLw8JafjVaGruYYO1VPWh603Y2m6M4drwDO5EsbTbGq+0AOdRNEZzKH4KDQyZ4UqY
 hL6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688594456; x=1691186456;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=O9Umo4Ym/zYVPcLMiYaq5ll1qCgBNhmHnB4z7LEUNC4=;
 b=hMfESwqvv1YlQXZ6lebTZhUzkNinPE1dRuNDmpYqwmFH19fK5EZzZaXC2n1xUL/Gn9
 dOQv8122k0leoX3gabge/3u9szo7m17XyGMjDNBkxv/a+QQKSyuvW18inJkvx//nboCq
 vMg9sDh8SGEfJI72I9GTb+MmkSr0O53VMADwdsXlASLuHVyDLI2YsP5l8FgVsN5bAaau
 qkmHm+as63EsuwdEZ/XObYQgnEHgsQmXP2RZF9HFZwKZM8RUHDP34CvAbA1Dx0dIVDq4
 xQzf8YL5pHcxL+wr2eaFFtPFk3I44CaZfTUN2V5TvC8N5akaiXofqN9DQD3QnPDhso88
 U2Mg==
X-Gm-Message-State: AC+VfDyOmCYg29t6G+NTEC7hUNbt2743psL98ohh/rdx8J01Ukx5w/mH
 pL1V3+dACUhkvVb9p9djQw41qA==
X-Google-Smtp-Source: ACHHUZ5MHj8VTle0m54+QtwHu36+YxYN+Cc/OxQnFOP6KkgvOTAdChhY7u0QBxQiMTvz7kFBVEknVg==
X-Received: by 2002:a05:6808:2020:b0:39d:63eb:3e9a with SMTP id
 q32-20020a056808202000b0039d63eb3e9amr22400244oiw.16.1688594456602; 
 Wed, 05 Jul 2023 15:00:56 -0700 (PDT)
Received: from [192.168.68.107] (201-69-66-110.dial-up.telesp.net.br.
 [201.69.66.110]) by smtp.gmail.com with ESMTPSA id
 e19-20020a05680809b300b003a1e965bf39sm72166oig.2.2023.07.05.15.00.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jul 2023 15:00:56 -0700 (PDT)
Message-ID: <c5372b14-b2b8-4664-4357-a7f22c880dcd@ventanamicro.com>
Date: Wed, 5 Jul 2023 19:00:52 -0300
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
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20230705-gallstone-untitled-1463e43aa33c@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::232;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oi1-x232.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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



On 7/5/23 18:49, Conor Dooley wrote:
> On Wed, Jul 05, 2023 at 06:39:37PM -0300, Daniel Henrique Barboza wrote:
>> The absence of a satp mode in riscv_host_cpu_init() is causing the
>> following error:
>>
>> $ ./qemu/build/qemu-system-riscv64  -machine virt,accel=kvm \
>>      -m 2G -smp 1  -nographic -snapshot \
>>      -kernel ./guest_imgs/Image \
>>      -initrd ./guest_imgs/rootfs_kvm_riscv64.img \
>>      -append "earlycon=sbi root=/dev/ram rw" \
>>      -cpu host
>> **
>> ERROR:../target/riscv/cpu.c:320:satp_mode_str: code should not be
>> reached
>> Bail out! ERROR:../target/riscv/cpu.c:320:satp_mode_str: code should
>> not be reached
>> Aborted
>>
>> The error is triggered from create_fdt_socket_cpus() in hw/riscv/virt.c.
>> It's trying to get satp_mode_str for a NULL cpu->cfg.satp_mode.map.
>>
>> For this KVM cpu we would need to inherit the satp supported modes
>> from the RISC-V host. At this moment this is not possible because the
>> KVM driver does not support it. And even when it does we can't just let
>> this broken for every other older kernel.
>>
>> Since mmu-type is not a required node, according to [1], skip the
>> 'mmu-type' FDT node if there's no satp_mode set. We'll revisit this
>> logic when we can get satp information from KVM.
>>
>> [1] https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/cpu.yaml
> 
> I don't think this is the correct link to reference as backup, as the
> generic binding sets out no requirements. I think you would want to link
> to the RISC-V specific cpus binding.

You mean this link?

https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bindings/riscv/cpus.yaml


> 
> That said, things like FreeBSD and U-Boot appear to require mmu-type
> https://lore.kernel.org/all/20230705-fondue-bagginess-66c25f1a4135@spud/
> so I am wondering if we should in fact make the mmu-type a required
> property in the RISC-V specific binding.


To make it required, as far as QEMU is concerned, we'll need to assume a
default value for the 'host' CPU type (e.g. sv57). In the future we can read the
satp host value directly when/if KVM provides satp_mode via get_one_reg().


Thanks,

Daniel

> 
> Since nommu is covered by an mmu type of "riscv,none", I am kinda
> struggling to think of a case where it should be left out (while
> describing real hardware at least).
> 
> Cheers,
> Conor.

