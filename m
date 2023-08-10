Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A530777459
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 11:21:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU1qv-0006as-4B; Thu, 10 Aug 2023 05:21:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qU1qs-0006a5-J8
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 05:21:06 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qU1qq-0001PU-Rk
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 05:21:06 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2b9dc1bff38so10123231fa.1
 for <qemu-devel@nongnu.org>; Thu, 10 Aug 2023 02:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691659263; x=1692264063;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wAGRahBwpiagiszDDcvDgRWO7a+yNxGSUwvwQuKCeaY=;
 b=bg/eGuc6Astpeu+qMEd+ZFDHBJkGCckQKSGVlCi4yBZ+wxzfxUcoAwZRbjLqsDNM/Q
 WFQDEmf4FCss/+dp2wn1nf8xqZpg0ewBOZ6bEdvlSfxRLF/bbHNWoumwKxGJSDmSKYkP
 uHKqqOeUP6qRK0giM3hpO8Oe3hhlEWsaHgbFahEmq1p6xBogdLEeyrXaYj3TplhTOUN/
 qwt4mmdOLm+MeHhQLz3HbBBTnJK3LjYoYPG9nfj/koXGPKkHY+nbJGMcC1XbobllZKyW
 KMSg3CgdWrbIsFb8SSI/LbFDXc3zsYqw77A3odz1SHj6OjSbrBHo6Nm8In1zfCuzjdKL
 6d2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691659263; x=1692264063;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wAGRahBwpiagiszDDcvDgRWO7a+yNxGSUwvwQuKCeaY=;
 b=In3cJiHEbye2g8RERLI7rLtUyneOoQqcIalpnNcBSwDIy5jiD7S5APDax+ESo7Fpzm
 gjyxwOJplM8dgR+HzJslZZy75s6bXo6DesDST0GQfI7r+xiNAtNmJvB4mGYutS1nkKR6
 b6NHzJNKoGrboSgkSDeuT3VW0+9EjwagbmNS1MOzBJB3KkN4BqwfZviQiVfyeT8shTW6
 utvo0x4SuaOmvrWxv94yozWH8OC7rvasRxx79lMzaemE2OaY6/zIzg7mmoCIglfn0vuB
 /V9EYn9Fi5L9Pdjqn4FpmiZ10DVq0H5n5U5kB6tONRzdXVPIT5iYCQKukVDgEm0DmsTp
 1w9w==
X-Gm-Message-State: AOJu0YzCTwJ9VhhfASIeN3AxvyZSzwzgnHwJL68P0v/2dIExCL+cmFRa
 UkKhOfnBhq6tiZ9ZiP6/OLcLztM6X4RYn+Kb3F4=
X-Google-Smtp-Source: AGHT+IEAbUHatMKZjJb3Q29oge/qO2UaymAKxvrWbdQriKD29gG30Wfx9yi0YCaT7iTKlR8etCp+gA==
X-Received: by 2002:a2e:9cd5:0:b0:2b6:9fdf:d8f4 with SMTP id
 g21-20020a2e9cd5000000b002b69fdfd8f4mr1385560ljj.29.1691659262860; 
 Thu, 10 Aug 2023 02:21:02 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.158.65])
 by smtp.gmail.com with ESMTPSA id
 h14-20020a05600c260e00b003fa8dbb7b5dsm1514313wma.25.2023.08.10.02.21.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Aug 2023 02:21:02 -0700 (PDT)
Message-ID: <2039f2b3-e916-411e-1987-fa15a03144b7@linaro.org>
Date: Thu, 10 Aug 2023 11:21:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v5 1/6] kvm: Introduce kvm_arch_get_default_type hook
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20230727073134.134102-1-akihiko.odaki@daynix.com>
 <20230727073134.134102-2-akihiko.odaki@daynix.com>
 <CAFEAcA_26e2G_qLA8DEcv74MADgquhiVkWEZkh_wL0+JxAf91Q@mail.gmail.com>
 <CAFEAcA9gkKy=GBXNw0rRLeN80ekFY5JQB1Jn2b+F70oC1C5uxg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA9gkKy=GBXNw0rRLeN80ekFY5JQB1Jn2b+F70oC1C5uxg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x231.google.com
X-Spam_score_int: -61
X-Spam_score: -6.2
X-Spam_bar: ------
X-Spam_report: (-6.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.14,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 4/8/23 19:38, Peter Maydell wrote:
> On Fri, 4 Aug 2023 at 18:26, Peter Maydell <peter.maydell@linaro.org> wrote:
>>
>> On Thu, 27 Jul 2023 at 08:31, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>
>>> kvm_arch_get_default_type() returns the default KVM type. This hook is
>>> particularly useful to derive a KVM type that is valid for "none"
>>> machine model, which is used by libvirt to probe the availability of
>>> KVM.
>>>
>>> For MIPS, the existing mips_kvm_type() is reused. This function ensures
>>> the availability of VZ which is mandatory to use KVM on the current
>>> QEMU.
>>>
>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>> ---
>>>   include/sysemu/kvm.h     | 2 ++
>>>   target/mips/kvm_mips.h   | 9 ---------
>>>   accel/kvm/kvm-all.c      | 4 +++-
>>>   hw/mips/loongson3_virt.c | 2 --
>>>   target/arm/kvm.c         | 5 +++++
>>>   target/i386/kvm/kvm.c    | 5 +++++
>>>   target/mips/kvm.c        | 2 +-
>>>   target/ppc/kvm.c         | 5 +++++
>>>   target/riscv/kvm.c       | 5 +++++
>>>   target/s390x/kvm/kvm.c   | 5 +++++
>>>   10 files changed, 31 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
>>> index 115f0cca79..ccaf55caf7 100644
>>> --- a/include/sysemu/kvm.h
>>> +++ b/include/sysemu/kvm.h
>>> @@ -369,6 +369,8 @@ int kvm_arch_get_registers(CPUState *cpu);
>>>
>>>   int kvm_arch_put_registers(CPUState *cpu, int level);
>>>
>>> +int kvm_arch_get_default_type(MachineState *ms);
>>> +
>>
>> New global functions should have a doc comment that explains
>> what they do, what their API is, etc. For instance, is
>> this allowed to return an error, and if so, how ?
> 
> Looks like this was the only issue with this patchset. So
> I propose to take this into my target-arm queue for 8.2,
> with the following doc comment added:
> 
> /**
>   * kvm_arch_get_default_type: Return default KVM type
>   * @ms: MachineState of the VM being created
>   *
>   * Return the default type argument to use in the
>   * KVM_CREATE_VM ioctl when creating the VM. This will
>   * only be used when the machine model did not specify a
>   * type to use via the MachineClass::kvm_type method.
>   *
>   * Returns: type to use, or a negative value on error.
>   */

Thank you.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


