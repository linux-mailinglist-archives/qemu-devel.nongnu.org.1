Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E84787F41
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 07:30:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZPNK-0006IR-1J; Fri, 25 Aug 2023 01:28:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vineetg@rivosinc.com>)
 id 1qZPND-0006I1-Pd
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 01:28:44 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <vineetg@rivosinc.com>)
 id 1qZPN8-00084N-7z
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 01:28:40 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1c06f6f98c0so5191625ad.3
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 22:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1692941315; x=1693546115; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rNf3HgIy7fXyNFm7MBMQLrjE6GXfwqdtwg3jc9DNb3Q=;
 b=Ga2ymCYWGlVDsI9FvaquoeYNdVQziRgPwjEpyeUuG5WI35i15mc8J+d4HL5/LAL+Zb
 xb03kjp1ikgPs2NUHKdIDIOBdS+Zqd6VsgTq3MdU8lmnIgqToL+FHFCByEo9XtC+Y+ep
 oj/prtOlMJuZ7K/RHlI9GTPnafgCGvMzccYvpci9hjlQCodOiHV3DS1NJMFGzaIAWHHA
 m8oEmWHIEBBQdMyFms6atLcP1F3QhGI9/Jj/dqeUIJTF5jA4Y+gL1oD08JZwdtqmiK4m
 qTiJlObWur0XCaBFdFe+A+WE7Rfct45C4hHpeQ+f7kgCTCULCJMG8liXkYFh9FQGbwwz
 bFDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692941315; x=1693546115;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rNf3HgIy7fXyNFm7MBMQLrjE6GXfwqdtwg3jc9DNb3Q=;
 b=R2cg3usbbCekpV/nCvFpsuG68J12mn83cuyZ9ud1+SEsh5xIxHIfWGemCEoJOnlfip
 xTYJ3ovYig9jPqqROblzbCEg3V+e6eCgNZPFzRdejFB7d53bJR5qMB35oC6Ar1dRDsvz
 NlczO/NaRu9gt88r2AuwTlt2r2jAYY2YEjECl2q/9aKAU+BtlC1pCstyfKtVSZiaHU5V
 dlt/XPy3BAGoblxoHDefyCG5MyGlOT/T52Vffeq3Ru+1Y6uPrqzh+fsYM/3877LUADpX
 gJpGASbxKw8zwZqpbl37KStVnuzC1WqNEpoXcer0EBKTKDNTLLfTKJlnIAXlz1dZBf9+
 6TjA==
X-Gm-Message-State: AOJu0YyIXemf/ySDymQzCx4fImFKoApD0UfOzCUnW7sFqzHMuCsM14vd
 JRLJmQSKQe9Sh0vaqcrFeSGKfw==
X-Google-Smtp-Source: AGHT+IFwalHQ5pp6NmH1xxYawI5AHFY5I9/Vr879zq4ZA29EZbd7yCIr8yo/kQeaW/LOZZAERPza1Q==
X-Received: by 2002:a17:902:ea0f:b0:1b8:1bac:3782 with SMTP id
 s15-20020a170902ea0f00b001b81bac3782mr20577054plg.6.1692941315115; 
 Thu, 24 Aug 2023 22:28:35 -0700 (PDT)
Received: from [192.168.50.117] (c-98-210-197-24.hsd1.ca.comcast.net.
 [98.210.197.24]) by smtp.gmail.com with ESMTPSA id
 v11-20020a170902d68b00b001bba1475c92sm657548ply.113.2023.08.24.22.28.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Aug 2023 22:28:34 -0700 (PDT)
Message-ID: <7d8e9cbe-50d7-9a69-f67a-9f890012b868@rivosinc.com>
Date: Thu, 24 Aug 2023 22:28:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] riscv: zicond: make non-experimental
Content-Language: en-US
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, kito.cheng@gmail.com,
 Jeff Law <jeffreyalaw@gmail.com>, Palmer Dabbelt <palmer@rivosinc.com>
References: <20230808181715.436395-1-vineetg@rivosinc.com>
 <CAKmqyKPrrXqQRqqtRDi08hU5uNYB=0PxXBdxRVh81zmnRAauKw@mail.gmail.com>
From: Vineet Gupta <vineetg@rivosinc.com>
In-Reply-To: <CAKmqyKPrrXqQRqqtRDi08hU5uNYB=0PxXBdxRVh81zmnRAauKw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=vineetg@rivosinc.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, NICE_REPLY_A=-2.919, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 8/10/23 10:14, Alistair Francis wrote:
> On Tue, Aug 8, 2023 at 2:18 PM Vineet Gupta <vineetg@rivosinc.com> wrote:
>> zicond is now codegen supported in both llvm and gcc.
>>
>> This change allows seamless enabling/testing of zicond in downstream
>> projects. e.g. currently riscv-gnu-toolchain parses elf attributes
>> to create a cmdline for qemu but fails short of enabling it because of
>> the "x-" prefix.
>>
>> Signed-off-by: Vineet Gupta <vineetg@rivosinc.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
>
> Alistair

Gentle ping to remind that this lands in some -next tree and not forgotten !

Thx,
-Vineet

>
>> ---
>>   target/riscv/cpu.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>> index 6b93b04453c8..022bd9d01223 100644
>> --- a/target/riscv/cpu.c
>> +++ b/target/riscv/cpu.c
>> @@ -1816,6 +1816,7 @@ static Property riscv_cpu_extensions[] = {
>>       DEFINE_PROP_BOOL("zcf", RISCVCPU, cfg.ext_zcf, false),
>>       DEFINE_PROP_BOOL("zcmp", RISCVCPU, cfg.ext_zcmp, false),
>>       DEFINE_PROP_BOOL("zcmt", RISCVCPU, cfg.ext_zcmt, false),
>> +    DEFINE_PROP_BOOL("zicond", RISCVCPU, cfg.ext_zicond, false),
>>
>>       /* Vendor-specific custom extensions */
>>       DEFINE_PROP_BOOL("xtheadba", RISCVCPU, cfg.ext_xtheadba, false),
>> @@ -1832,7 +1833,6 @@ static Property riscv_cpu_extensions[] = {
>>       DEFINE_PROP_BOOL("xventanacondops", RISCVCPU, cfg.ext_XVentanaCondOps, false),
>>
>>       /* These are experimental so mark with 'x-' */
>> -    DEFINE_PROP_BOOL("x-zicond", RISCVCPU, cfg.ext_zicond, false),
>>
>>       /* ePMP 0.9.3 */
>>       DEFINE_PROP_BOOL("x-epmp", RISCVCPU, cfg.epmp, false),
>> --
>> 2.34.1
>>
>>


