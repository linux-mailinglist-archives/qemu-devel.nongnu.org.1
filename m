Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6AF7D01C9
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 20:36:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtXoF-0000u9-Ou; Thu, 19 Oct 2023 14:31:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qtXo3-0000iR-T9
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:31:43 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qtXo1-0007bZ-N6
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:31:39 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-27d17f5457fso889571a91.0
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 11:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1697740295; x=1698345095; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UV3fV/dZ656RIQwVZI5FxfcIhR6su+VKTq+o7PgF8AA=;
 b=bRsKipKYk3GuB5yzqKGQfiZPAXIIby8Pb3+l8N762PrNHZCKQD4skFi5IkUif8d/QS
 O7BaxMbm0+zjI4FF+TZoonr5Ke4GuHakdkkzYO/taP/g2sCwsGnnsbLHWef7Kz2O75Ou
 52B27w+SqYvm8CwyQ75RiWAf254lQzaJ+dDXoXg1oMUeqsfOgzCgukZf2zZizrfVAGiH
 vyzji5UsE5uXZRR3jgGsw6S4+5I4CfheAanku1jHAqfahyushZPw+V6aPd78XDH4irfZ
 aksAyVMERUcIEHqGg14i2id0W9McpM1agUrU4akjQQRvN404iZM8M8u31QirTQv191Je
 Wewg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697740295; x=1698345095;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UV3fV/dZ656RIQwVZI5FxfcIhR6su+VKTq+o7PgF8AA=;
 b=hREZ0Jx+swVvbIZ3PCrvMU7QJjy+O24HnfmIY0Yp/hFQRCGO0h6Ic79zFuFzV1n/Wq
 8ZFYAIjgpf1qpzUuJZXeF2i7Et8Mrflmb7LN9TLD0/+PsE+cmKe9GhtX1Zsc9RnxVjMP
 Ex7zPkg1H/R2EIO9kK9bpUxrocZJoMZ6BSgf5uD0ec146edtNFRrjuq9hjjwY8C1yPE8
 crvLxn+yQa/2VUygAxECY2PdPjnA28VZaJSC2XHsW0HC/agzlrq+Z6M6dNrdyc45Zr2k
 bfhFyY+/ifMEs75oXwam3U/8v4fdXfvUMCnFEP+3Q1P88j/PDokgIVb/meI8z9qp/vYv
 EsPw==
X-Gm-Message-State: AOJu0YxxK2XlZwkvBEbIwkGiK7i7Wc70/JgcneKFqZIu+Tf+6qcj6bwr
 6h/5Z8hSN96h80ysiPS6OrBSSQ==
X-Google-Smtp-Source: AGHT+IG8o+K/POx2dCAdRj38sdLYwgAx5XBtAlj3pJ7yncKhByFeqbpnBKSjgmDtQf3b3JouDzUAnQ==
X-Received: by 2002:a17:90a:a206:b0:277:4be4:7a84 with SMTP id
 u6-20020a17090aa20600b002774be47a84mr4042191pjp.19.1697740295382; 
 Thu, 19 Oct 2023 11:31:35 -0700 (PDT)
Received: from [192.168.68.107] ([177.45.186.249])
 by smtp.gmail.com with ESMTPSA id
 x3-20020aa79563000000b006bdd7cbcf98sm96405pfq.182.2023.10.19.11.31.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Oct 2023 11:31:34 -0700 (PDT)
Message-ID: <1bc517bb-0902-45a5-ada6-eebe8d12fa74@ventanamicro.com>
Date: Thu, 19 Oct 2023 15:31:30 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 12/54] target/riscv: deprecate the 'any' CPU type
To: Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair23@gmail.com>, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20231012041051.2572507-1-alistair.francis@wdc.com>
 <20231012041051.2572507-13-alistair.francis@wdc.com>
 <7dc0b6cc-7112-4f12-b52e-13f217d8dae3@linaro.org>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <7dc0b6cc-7112-4f12-b52e-13f217d8dae3@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x102b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 10/19/23 15:13, Richard Henderson wrote:
> On 10/11/23 21:10, Alistair Francis wrote:
>> From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>>
>> The 'any' CPU type was introduced in commit dc5bd18fa5725 ("RISC-V CPU
>> Core Definition"), being around since the beginning. It's not an easy
>> CPU to use: it's undocumented and its name doesn't tell users much about
>> what the CPU is supposed to bring. 'git log' doesn't help us either in
>> knowing what was the original design of this CPU type.
>>
>> The closest we have is a comment from Alistair [1] where he recalls from
>> memory that the 'any' CPU is supposed to behave like the newly added
>> 'max' CPU. He also suggested that the 'any' CPU should be removed.
>>
>> The default CPUs are rv32 and rv64, so removing the 'any' CPU will have
>> impact only on users that might have a script that uses '-cpu any'.
>> And those users are better off using the default CPUs or the new 'max'
>> CPU.
>>
>> We would love to just remove the code and be done with it, but one does
>> not simply remove a feature in QEMU. We'll put the CPU in quarantine
>> first, letting users know that we have the intent of removing it in the
>> future.
>>
>> [1] https://lists.gnu.org/archive/html/qemu-devel/2023-07/msg02891.html
>>
>> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
>> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Message-ID: <20230912132423.268494-13-dbarboza@ventanamicro.com>
>> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
>> ---
>>   docs/about/deprecated.rst | 12 ++++++++++++
>>   target/riscv/cpu.c        |  5 +++++
>>   2 files changed, 17 insertions(+)
>>
>> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
>> index 8b136320e2..5e3965a674 100644
>> --- a/docs/about/deprecated.rst
>> +++ b/docs/about/deprecated.rst
>> @@ -327,6 +327,18 @@ QEMU's ``vhost`` feature, which would eliminate the high latency costs under
>>   which the 9p ``proxy`` backend currently suffers. However as of to date nobody
>>   has indicated plans for such kind of reimplementation unfortunately.
>> +RISC-V 'any' CPU type ``-cpu any`` (since 8.2)
> 
> You forgot to update linux-user/riscv/target_elf.h, which still uses "any", and thus all qemu-riscv64 invocations trigger the warning.

Ouch. I'll send a patch.


Thanks,


Daniel

> 
> 
> r~
> 

