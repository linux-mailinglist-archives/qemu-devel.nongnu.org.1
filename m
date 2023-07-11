Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B477A74F656
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 19:03:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJGlZ-0005Pa-AK; Tue, 11 Jul 2023 13:03:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qJGlJ-0004w3-9p
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 13:02:54 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qJGlE-0001Zm-LC
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 13:02:50 -0400
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-6b74faaac3bso4734112a34.1
 for <qemu-devel@nongnu.org>; Tue, 11 Jul 2023 10:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1689094967; x=1691686967;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UgqfjuqweyrwSQHezhYIKwf2Do4blnmKydH08PAxTpw=;
 b=WTZK1RNQ2cPCw7SHT7JesHKIUXq53dtzxxFVKNO7eJUnFp8wcaskCUmrumciaPQacf
 JiTDi4ZJKyO2tIGH+MdV0roxRcR7BXe8dJqlq2F25mZGtkz3kJG9nD6T9LGP3WrCU7xe
 IeyplMaV4IXLiHp+shB73rf4+W9cDa/F3wd4XUUjVxz92aSHw11Ee4msZahirmitQZhq
 bdsj1TbFCJ1YVY2REfqXufTA+h0dDAvSD0Lt9jO54Kr+m8rImIgL3N9QLDOnFdeDgkup
 faLp2gBsNqsEgKJmlmTPDAmGafu/pUkFxXyM8ZR+vPEvmeN1d/k0+S8VPgrUuOE403Nh
 /DnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689094967; x=1691686967;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UgqfjuqweyrwSQHezhYIKwf2Do4blnmKydH08PAxTpw=;
 b=cjMMnJfNaI4TOQ/YGA0Hs7I6d0vf9ctcx+1t3sqY3TKY7H670idU6LKSRo8Zt0HjwS
 gsmUvybxoGun6Sd0Pa4FaXsXG55K9OXoYehcPz0+oTGMRV0SFB0q+NpPG+oiX4UJJq6W
 sjFjQKXzkK2lfjyqvyJoeY/Xd9nynSG5ytcvYB4PTDf6HQEVR8qy0Fu1756fcJWTkXl7
 C+sWvG/57dXX2VS/ANI0S8lpZZFNn3sZUiZyZFIiqjUFZb3g8hiclALus1LgD3rnjKZo
 Q506/t2MBMBaILbondkb4IiHwzhpwdAkSVXjUbklpP0KpHyRI8kYhJe8/cIIYIN1TmDl
 e9CA==
X-Gm-Message-State: ABy/qLZ4nrbQY7TFrmXnMF6s/JXVtVb6/8khH7uUTRuRyNcJlxxTsvw4
 Mt6t8FxMfDHeJEnk10EtjxXvJFfd/C9r/jB5z+M=
X-Google-Smtp-Source: APBJJlE4UqfUUHhRZlr443NEMBccmWT/2DDlQgGqkMm3oNyV1n4llPKpkxwyxxA0j/PY2RSI5Jc+Cw==
X-Received: by 2002:a05:6830:1e57:b0:6b7:558d:579 with SMTP id
 e23-20020a0568301e5700b006b7558d0579mr14343248otj.32.1689094967442; 
 Tue, 11 Jul 2023 10:02:47 -0700 (PDT)
Received: from [192.168.68.107] (201-69-66-19.dial-up.telesp.net.br.
 [201.69.66.19]) by smtp.gmail.com with ESMTPSA id
 g13-20020a056830160d00b006b93c6c97basm1119303otr.44.2023.07.11.10.02.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Jul 2023 10:02:47 -0700 (PDT)
Message-ID: <2405d7a7-5243-2883-9e9b-e764c95471c0@ventanamicro.com>
Date: Tue, 11 Jul 2023 14:02:43 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: riscv kvm breakage
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, liweiwei <liweiwei@iscas.ac.cn>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <629afcc2-ffed-c081-9564-7faa6defc1f4@linaro.org>
 <7b35a2ab-548e-8eb5-cd09-5a2e12d93453@linaro.org>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <7b35a2ab-548e-8eb5-cd09-5a2e12d93453@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x333.google.com
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



On 7/11/23 13:47, Philippe Mathieu-Daudé wrote:
> On 11/7/23 18:43, Richard Henderson wrote:
>> Hiya,
>>
>> This breakage crept in while cross-riscv64-system was otherwise broken in configure:
>>
>> https://gitlab.com/qemu-project/qemu/-/jobs/4633277557#L4165
>>
>> ../target/riscv/kvm.c:209:38: error: ‘KVM_RISCV_ISA_EXT_ZICBOZ’ undeclared here (not in a function); did you mean ‘KVM_RISCV_ISA_EXT_ZICBOM’?
>>    209 |     KVM_EXT_CFG("zicboz", ext_icboz, KVM_RISCV_ISA_EXT_ZICBOZ),
>>        |                                      ^~~~~~~~~~~~~~~~~~~~~~~~
>> ../target/riscv/kvm.c:205:20: note: in definition of macro ‘KVM_EXT_CFG’
>>    205 |      .kvm_reg_id = _reg_id}
>>        |                    ^~~~~~~
>> ../target/riscv/kvm.c:211:33: error: ‘KVM_RISCV_ISA_EXT_ZBB’ undeclared here (not in a function); did you mean ‘KVM_RISCV_ISA_EXT_MAX’?
>>    211 |     KVM_EXT_CFG("zbb", ext_zbb, KVM_RISCV_ISA_EXT_ZBB),
>>        |                                 ^~~~~~~~~~~~~~~~~~~~~
>> ../target/riscv/kvm.c:205:20: note: in definition of macro ‘KVM_EXT_CFG’
>>    205 |      .kvm_reg_id = _reg_id}
>>        |                    ^~~~~~~
>> ../target/riscv/kvm.c:212:37: error: ‘KVM_RISCV_ISA_EXT_SSAIA’ undeclared here (not in a function); did you mean ‘KVM_RISCV_ISA_EXT_SSTC’?
>>    212 |     KVM_EXT_CFG("ssaia", ext_ssaia, KVM_RISCV_ISA_EXT_SSAIA),
>>        |                                     ^~~~~~~~~~~~~~~~~~~~~~~
>> ../target/riscv/kvm.c:205:20: note: in definition of macro ‘KVM_EXT_CFG’
>>    205 |      .kvm_reg_id = _reg_id}
>>        |                    ^~~~~~~
>> In file included from /usr/riscv64-linux-gnu/include/rpc/netdb.h:42,
>>                   from /usr/riscv64-linux-gnu/include/netdb.h:32,
>>                   from /builds/qemu-project/qemu/include/sysemu/os-posix.h:34,
>>                   from /builds/qemu-project/qemu/include/qemu/osdep.h:151,
>>                   from ../target/riscv/kvm.c:19:
>> ../target/riscv/kvm.c:288:44: error: ‘struct kvm_riscv_config’ has no member named ‘zicboz_block_size’; did you mean ‘zicbom_block_size’?
>>    288 |     .kvm_reg_id = KVM_REG_RISCV_CONFIG_REG(zicboz_block_size)
>>        |                                            ^~~~~~~~~~~~~~~~~
>>
>> Can someone have a look asap?  Thanks,
> 
> See:
> https://lore.kernel.org/qemu-devel/20230711163346.69409-1-philmd@linaro.org/

Thanks Phil!

ps: cross building stuff is hard ....



> 
> :)

