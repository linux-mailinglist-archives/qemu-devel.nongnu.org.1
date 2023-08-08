Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA21774C8C
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 23:11:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTTyq-0005vq-TY; Tue, 08 Aug 2023 17:11:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qTTyp-0005sR-2K
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 17:11:03 -0400
Received: from mail-oa1-x29.google.com ([2001:4860:4864:20::29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qTTym-0006X7-P2
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 17:11:02 -0400
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-1bb7297c505so4435853fac.1
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 14:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1691529059; x=1692133859;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=T0Ui3mSDmZvv05hr3Xzho6fsrHB391u4au8PJ1Bv2NQ=;
 b=ZypWrbNiCPXCwaJ1/NwBauuLsYGJ6qzendhc+T4ezZkkx//Nxv6ctvLqkKOtWSkgzW
 RnXQZjaAUK3il9tmNg+XXE2ehvNXSVSNZq9wDl0xVu32EiL1MxfucOZiiQ6wnOROMX+d
 v278HRvU83o6nQZUIx9u73O25Z0/pP90NCpdqBvLB+E4p9Yn+5OJqWieKk4YvDKz5OWY
 3cYDtEYENDxgiYdVjWAH3bcQHZrxunitQZUgo8QQfstGabcj01UnrCEnrc5ooF7KzFEl
 F28mtWwnGICFklQFORKi3LmGbfJYPmbK8K4RlD7pbZ4wROoK/xgbR6hrnOXz3qGJhJmR
 Gucw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691529059; x=1692133859;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=T0Ui3mSDmZvv05hr3Xzho6fsrHB391u4au8PJ1Bv2NQ=;
 b=Uhq60lVBYHHku2v8WJYM/6ypuNl+vcslAgczucAnANDkBIuGpyX3g4j7wI1e/f/REz
 PaIcqTul0huf4/dYUJt0uyyARKuqIyB+XPBhykcdVzwXiaqsTFUN6nIfenQjTUJ0npB/
 uIyGyoPE5lwzXEiglkQk1lhs6xyUlwAqTRpU/nq/wWO7gRdtVQDdcZ1k8D5el+H5Sopo
 AtI+bnLbmSmkTygfzd+yeGuf1MQB9JcSp8P3+5tDszWygJ5Ab0NkOrTPnKsuTQ8Xj1U4
 /UWc23pwUfiSl4mBFVMvvfFeAsV4bm6psJvuDBunYkXDXf/d99dCk9qXxOrs7Sekcggz
 1ZZA==
X-Gm-Message-State: AOJu0YxYE/btE3d85Mj7j61GzqUECa55zXWr6r0Y6DjOZao/puva2vWO
 TZWoOaIkukrAeAENJzks+zJDVA==
X-Google-Smtp-Source: AGHT+IHTh16u18+9lb5hyleYYkIdCUykQPAoL9AR4kbMzHY8O3MsA3Jtcs2rasSFmqkwbdC6o3X2Lg==
X-Received: by 2002:aca:1916:0:b0:3a7:46c3:c5c3 with SMTP id
 l22-20020aca1916000000b003a746c3c5c3mr915087oii.50.1691529058802; 
 Tue, 08 Aug 2023 14:10:58 -0700 (PDT)
Received: from [192.168.68.108] (189-69-160-189.dial-up.telesp.net.br.
 [189.69.160.189]) by smtp.gmail.com with ESMTPSA id
 a20-20020a056808099400b003a371c611f6sm6313319oic.18.2023.08.08.14.10.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Aug 2023 14:10:58 -0700 (PDT)
Message-ID: <d734a730-f41f-4d3e-01fb-a0876d05c9e2@ventanamicro.com>
Date: Tue, 8 Aug 2023 18:10:54 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] riscv: zicond: make non-experimental
Content-Language: en-US
To: Palmer Dabbelt <palmer@rivosinc.com>, Vineet Gupta
 <vineetg@rivosinc.com>, Alistair Francis <Alistair.Francis@wdc.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, Kito Cheng <kito.cheng@gmail.com>,
 jeffreyalaw@gmail.com
References: <mhng-c8c16500-b5e6-4246-be18-849b74753d4d@palmer-ri-x1c9a>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <mhng-c8c16500-b5e6-4246-be18-849b74753d4d@palmer-ri-x1c9a>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::29;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oa1-x29.google.com
X-Spam_score_int: -61
X-Spam_score: -6.2
X-Spam_bar: ------
X-Spam_report: (-6.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.14,
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



On 8/8/23 17:52, Palmer Dabbelt wrote:
> On Tue, 08 Aug 2023 11:45:49 PDT (-0700), Vineet Gupta wrote:
>>
>>
>> On 8/8/23 11:29, Richard Henderson wrote:
>>> On 8/8/23 11:17, Vineet Gupta wrote:
>>>> zicond is now codegen supported in both llvm and gcc.
>>>
>>> It is still not in
>>>
>>> https://wiki.riscv.org/display/HOME/Recently+Ratified+Extensions
>>
>> Right, its been frozen since April though and with support trickling in
>> rest of tooling it becomes harder to test.
>> I don't know what exactly QEMU's policy is on this ?
> 
> IIUC we'd historically marked stuff as non-experimental when it's frozen, largely because ratification is such a nebulous process. There's obviously risk there, but there's risk to anything.  Last I can find is 260b594d8a ("RISC-V: Add Zawrs ISA extension support"), which specifically calls out Zawrs as frozen and IIUC adds support without the "x-" prefix.

If that's the case then I think it's sensible to remove the 'experimental' status
of zicond as well.

> 
> I can't find anything written down about it, though...

As soon as we agree on an official policy I'll do a doc update. Thanks,


Daniel

> 

