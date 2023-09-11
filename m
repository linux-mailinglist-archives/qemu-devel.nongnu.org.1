Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C72179A7E6
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 14:24:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qffxT-0005Ei-El; Mon, 11 Sep 2023 08:24:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qffxS-0005EN-44
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 08:24:02 -0400
Received: from mail-oo1-xc2e.google.com ([2607:f8b0:4864:20::c2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qffxP-0001GC-Dj
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 08:24:01 -0400
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-5733d431209so2756360eaf.0
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 05:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1694435038; x=1695039838; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0IwAwCmOC3wAVqL+6mBjKM9KpapEr6sdkt527kGaAa0=;
 b=dlZEBsIISInKDMArOTvOuBwebW7hnks8O73+euJ08i1g+3b4V0nSHqzOntFzx7qbuo
 2FXaoDWlC+/pk7Bc0QFFhSFiyWONpIsFwUxYMa5OPV/RM1Bbl2UhefTP8s+Hwa5pnEeQ
 l+s/Oz4J96YP4BQYPL6deYmOqnxOdx32rhBjrm9Q5J/AFhwp7hMXfgWn2R9zP8BugJS0
 0f/W8LBNWhmnBzRfnUvw9Xxz5rd7q6dE38/VGNcs/fmfB+TjMi5nZOGUEuhxPWdfah6D
 /UP4feYU32QQdmkX66nzhFGZit2qzuAJeNZMk24r+kArpVeHVBu32Q0bZUZqENQlKhI9
 fw2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694435038; x=1695039838;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0IwAwCmOC3wAVqL+6mBjKM9KpapEr6sdkt527kGaAa0=;
 b=cEL4WmwEb+uwEuNo59SqzmcJiWL1TqfVTagSg4Ge5KQ1y46n0Nc+GqhQQrorvf+o5H
 B9+RDhusnC8uh9z/nm09E2eMKjVrVPdfrNz3zzat2tbMp1lrbaWr91O1QSMLuLnbkWgI
 2e4JR6a4TPBu7B+IiA2C9jo1yZCKzS2RHvsPnIamnkMTLv4yPYvyAW5T66VVk4cafhcm
 yJHkqVoPlkVuWzRz8uPTlrwjF6Bvdhs4CwrgpTQH5HU/e81Cs8UkdvFn5MggBeZhFGJt
 PD1xSKLZkAhTfXwhR4ObVzZKhnmu89qnDwyboUzUWZMS4O7d74NCVY5AN2+ltY2ixaN+
 PSnA==
X-Gm-Message-State: AOJu0Yx36ri+3vBc4+bk5ps+ib27xUugT393qyd0OAK8ZXLZ5i3Drhxx
 tAuQaktXKI1Xgx2Os+gZayuP1Q==
X-Google-Smtp-Source: AGHT+IEXWIehwePW+xxVIp854dySeW+Q3PJSQkTDmwQ2S4JFjjn8Zu7GcGCAnauoiF3Rtt/xb2KZ7A==
X-Received: by 2002:a4a:9c97:0:b0:56d:e6:21bf with SMTP id
 z23-20020a4a9c97000000b0056d00e621bfmr8911581ooj.0.1694435038226; 
 Mon, 11 Sep 2023 05:23:58 -0700 (PDT)
Received: from [192.168.68.107] ([177.9.182.82])
 by smtp.gmail.com with ESMTPSA id
 i10-20020a4aab0a000000b0054f85f67f31sm2845863oon.46.2023.09.11.05.23.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Sep 2023 05:23:57 -0700 (PDT)
Message-ID: <8c4158b7-6c44-aec1-e25a-4804df70af49@ventanamicro.com>
Date: Mon, 11 Sep 2023 09:23:53 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 10/19] target/riscv: remove kvm-stub.c
Content-Language: en-US
To: Andrew Jones <ajones@ventanamicro.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 bmeng@tinylab.org, liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com,
 palmer@rivosinc.com
References: <20230906091647.1667171-1-dbarboza@ventanamicro.com>
 <20230906091647.1667171-11-dbarboza@ventanamicro.com>
 <f30d8589-8b59-2fd7-c38c-3f79508a4ac6@linaro.org>
 <20230911-0ff170da2e7063d0eb82ded9@orel>
 <20230911-df4609b7aca0b1fe00fb2e17@orel>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20230911-df4609b7aca0b1fe00fb2e17@orel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oo1-xc2e.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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



On 9/11/23 06:04, Andrew Jones wrote:
> On Mon, Sep 11, 2023 at 09:49:06AM +0200, Andrew Jones wrote:
>> On Wed, Sep 06, 2023 at 12:23:19PM +0200, Philippe Mathieu-Daudé wrote:
>>> On 6/9/23 11:16, Daniel Henrique Barboza wrote:
>>>> This file is not needed for some time now. All the stubs implemented in
>>>> it (kvm_riscv_reset_vcpu() and kvm_riscv_set_irq()) are wrapped in 'if
>>>> kvm_enabled()' blocks that the compiler will rip it out in non-KVM
>>>> builds.
>>>>
>>>> We'll also add non-KVM stubs for all functions declared in kvm_riscv.h.
>>>> All stubs are implemented as g_asserted_not_reached(), meaning that we
>>>> won't support them in non-KVM builds. This is done by other kvm headers
>>>> like kvm_arm.h and kvm_ppc.h.
>>>
>>> Aren't them also protected by kvm_enabled()? Otherwise shouldn't they?
>>
>> Yes, I think your earlier suggestion that we always invoke kvm functions
>> from non-kvm files with a kvm_enabled() guard makes sense.
>>
>>>
>>>> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>>>> ---
>>>>    target/riscv/kvm-stub.c  | 30 ------------------------------
>>>>    target/riscv/kvm_riscv.h | 31 +++++++++++++++++++++++++++++++
>>>>    target/riscv/meson.build |  2 +-
>>>>    3 files changed, 32 insertions(+), 31 deletions(-)
>>>>    delete mode 100644 target/riscv/kvm-stub.c
>>>
>>>
>>>> diff --git a/target/riscv/kvm_riscv.h b/target/riscv/kvm_riscv.h
>>>> index f6501e68e2..c9ecd9a967 100644
>>>> --- a/target/riscv/kvm_riscv.h
>>>> +++ b/target/riscv/kvm_riscv.h
>>>> @@ -19,6 +19,7 @@
>>>>    #ifndef QEMU_KVM_RISCV_H
>>>>    #define QEMU_KVM_RISCV_H
>>>> +#ifdef CONFIG_KVM
>>>>    void kvm_riscv_cpu_add_kvm_properties(Object *obj);
>>>
>>> At a glance kvm_riscv_cpu_add_kvm_properties() is.
>>> Keep the prototype declared (before #ifdef CONFIG_KVM) is enough for the
>>> compiler to elide it.
>>
>> Yes, when building without CONFIG_KVM enabled it's actually better to not
>> have the stubs, since the compiler will catch an unguarded kvm function
>> call (assuming the kvm function is defined in a file which is only built
>> with CONFIG_KVM).
>>
>> Unfortunately we don't have anything to protect developers from forgetting
>> the kvm_enabled() guard when building a QEMU which supports both TCG and
>> KVM. We could try to remember to put 'assert(kvm_enabled())' at the start
>> of each of these types of functions. It looks like mips does that for a
>> couple functions.
> 
> Eh, ignore this suggestion. We don't need asserts, because we have CI. As
> long as our CI does a CONFIG_KVM=n build and all KVM functions are in kvm-
> only files, then we'll always catch calls of KVM functions which are
> missing their kvm_enabled() guards.

So, to sum up, get rid of the 'g_assert_not_reached()' stubs since they should
be cropped by well placed kvm_enabled() calls in the code and, if that's not
the case, a non-KVM build failure will let us know that there's something wrong.

I can live with that. It's less code to deal with in the header as well. Thanks,


Daniel


> 
> Thanks,
> drew

