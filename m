Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F3188179CA
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 19:35:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFIRe-0001XZ-Mf; Mon, 18 Dec 2023 13:34:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rFIRZ-0001RA-VT
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 13:34:22 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rFIRV-00053i-O0
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 13:34:21 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1d3ab37d0d1so7739235ad.0
 for <qemu-devel@nongnu.org>; Mon, 18 Dec 2023 10:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1702924456; x=1703529256; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=brCmMKUOqELJNrt+/g0gPGDDmxUAXpsgyOedFbqgRi4=;
 b=CK6iKUg8uh1RO2r3eM34XzfBK7vNl0UwHzDW99WOUM5eZWu3ItlMmC/JYv2x9w4FAq
 M7PReDsTfNdlpdq6YEPx4hy3LJUpPYs5VynPP2JMd0aRI3py/iKNE/ol6zIJo4EzWd9N
 DBR/wqb/f2Q711LnbzC/Pt4n3HBrr0HMb9wQYqiZX+E9Gbe3025pF2G4tN8GBr/TGqs3
 ybUh8dw5iZdc+9DwzpfwGxgi4uRLm4/+SsGQwR5LjWV3T/h+Q0OMVlKXQqph+AKe/P76
 NOfb01ZD53Fr2ylJj4Y05eiBXY3AY+yw0IMZpOnWS1X+M/eYLfbfYjFb1Q7WGNlEcM5H
 18HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702924456; x=1703529256;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=brCmMKUOqELJNrt+/g0gPGDDmxUAXpsgyOedFbqgRi4=;
 b=PespkEY0dHCJzma4B9vu7ltqBpBbMU+bSnk18eBpmYORRazKJyF5mstsnPOYZG49l2
 YDY/KARRre75OInj94rmttTzdgws8RR7ahmzPeizR7wKaD+dwDhENCKZw80Hkf0UzqVf
 B8LsE3fyWUue/14mIXrnx52IITYLaSSTZXt5H7tdVir5rUnOwY+UR3aN6Zn0SFmZDoGs
 37k42tQWvAMZWVwT7Orzw/0Y5BTa+ioisGWEPhKMzlyJkB6oz3BsJ5uqubEB+qTmntsZ
 l35fWDA1+g4TTKcPLREcvD6pfWQ4eCe8G8rA+z4JCCV26D+0RBGeJlUypShB+pXMPoof
 ZCPA==
X-Gm-Message-State: AOJu0YwMZAiDi4bDUGq6PxK3AMlE9Jcex/+mOVJSPnvO8Cd3JX0ZphTU
 j/kF0rKhkmWW8OJy1IxQ1nDarA==
X-Google-Smtp-Source: AGHT+IEnh7B8GDHEfwqshD3F4chT69yWI8zf6Z3tg8FvmSFilTqAxEqyVudUZkeWkxKQ4c3LsXbvxQ==
X-Received: by 2002:a17:902:6544:b0:1d0:cfdc:10cb with SMTP id
 d4-20020a170902654400b001d0cfdc10cbmr7764279pln.72.1702924456112; 
 Mon, 18 Dec 2023 10:34:16 -0800 (PST)
Received: from ?IPV6:2804:7f0:bcc0:ddec:9d1c:476f:1886:86ae?
 ([2804:7f0:bcc0:ddec:9d1c:476f:1886:86ae])
 by smtp.gmail.com with ESMTPSA id
 b2-20020a170902bd4200b001d369beee67sm5029321plx.131.2023.12.18.10.34.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Dec 2023 10:34:15 -0800 (PST)
Message-ID: <941c9369-3cee-459b-ac28-4b5f1aecbe82@ventanamicro.com>
Date: Mon, 18 Dec 2023 15:34:11 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv/kvm: do not use non-portable
 strerrorname_np()
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Natanael Copa <ncopa@alpinelinux.org>, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org, qemu-trivial@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>
References: <20231218162301.14817-1-ncopa@alpinelinux.org>
 <dfb9bf4e-820a-4e7e-b62b-8df952099e7a@ventanamicro.com>
 <CAFEAcA_znj3yGXYB6OsTAwg5dT8kE154ZS=YRtye6dmy0TeKDQ@mail.gmail.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <CAFEAcA_znj3yGXYB6OsTAwg5dT8kE154ZS=YRtye6dmy0TeKDQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x632.google.com
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



On 12/18/23 14:53, Peter Maydell wrote:
> On Mon, 18 Dec 2023 at 17:22, Daniel Henrique Barboza
> <dbarboza@ventanamicro.com> wrote:
>>
>>
>>
>> On 12/18/23 13:22, Natanael Copa wrote:
>>> strerrorname_np is non-portable and breaks building with musl libc.
>>>
>>> Use strerror(errno) instead, like we do other places.
>>>
>>> Cc: qemu-stable@nongnu.org
>>> Fixes: commit 082e9e4a58ba (target/riscv/kvm: improve 'init_multiext_cfg' error msg)
>>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2041
>>> Buglink: https://gitlab.alpinelinux.org/alpine/aports/-/issues/15541
>>> Signed-off-by: Natanael Copa <ncopa@alpinelinux.org>
>>> ---
>>>    target/riscv/kvm/kvm-cpu.c | 18 ++++++++----------
>>>    1 file changed, 8 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
>>> index 45b6cf1cfa..117e33cf90 100644
>>> --- a/target/riscv/kvm/kvm-cpu.c
>>> +++ b/target/riscv/kvm/kvm-cpu.c
>>> @@ -832,9 +832,8 @@ static void kvm_riscv_read_multiext_legacy(RISCVCPU *cpu,
>>>                    multi_ext_cfg->supported = false;
>>>                    val = false;
>>>                } else {
>>> -                error_report("Unable to read ISA_EXT KVM register %s, "
>>> -                             "error code: %s", multi_ext_cfg->name,
>>> -                             strerrorname_np(errno));
>>> +                error_report("Unable to read ISA_EXT KVM register %s: %s",
>>> +                             multi_ext_cfg->name, strerror(errno));
>>
>>
>> The reason I did this change, as described in 082e9e4a58ba mentioned in the commit
>> message, was precisely to avoid things like this:
>>
>> qemu-system-riscv64: Unable to read ISA_EXT KVM register ssaia, error: no such file or directory
>>
>> The generic description of the error works well with file descriptors and so on but it's
>> weird in the KVM context. This patch is re-introducing it.
> 
> We don't seem to worry about that in any of the other
> KVM code -- accel/kvm/ has lots of places that
> use strerror() or error_setg_errno().

I don't know how this is being used in other parts of accel/kvm, but in this particular
instance we're handling the errors from get_one_reg. The kernel docs describes the errors
the API may return as:

--------
Errors include:

ENOENT - no such register
EINVAL - invalid register ID, or no such register (...)
EPERM - (arm64) register access not allowed before vcpu finalization
---------


The API interprets ENOENT as "no such register", but strerror(errno) in this case will output
"no such file or directory". The generic description is forcing me to think "this error
makes no sense ... oh, this might be the description of ENOENT". At this point having an
"error code 2" instead is clearer to me.


Thanks,

Daniel

> 
> thanks
> -- PMM

