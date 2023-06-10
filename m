Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE36872A8E2
	for <lists+qemu-devel@lfdr.de>; Sat, 10 Jun 2023 05:49:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7paq-00031W-TU; Fri, 09 Jun 2023 23:48:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q7pam-000314-TT
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 23:48:44 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q7pak-0007a0-K1
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 23:48:44 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1b025d26f4fso14215345ad.1
 for <qemu-devel@nongnu.org>; Fri, 09 Jun 2023 20:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1686368921; x=1688960921;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=VnWMydR8I7AjHGk8PbtlJMwJlD444VqmITbEIIyb36o=;
 b=OtWoyN26fyfQcQOyLBBwZb2HNwlPMImXnUMGVmLkCSsmRmShdF0GXnklI6drsqvyiR
 bJKwmChSmdHE4BrFxEJYjt/PEJViYDK/HkjNkuUk0s1iEogMaj7BELpnObZzLuCLISlz
 XgvKfj8/Z5a8BfTefimUQlFI788VF5mIvomMO9OM0bDF2/Zhqc//F8Ix60uNVMNJthp1
 MLpt9wuo8l+C0/osQSoshsL1T0N/F/pxzPAZCySIC9Pmz3aL8HUj0K1XOTrTG+EPaGX0
 HgZGsgGtUp2AJKfNMmBAPjDstBH9sxqd0qn1Yy2V2XphxfdF31vNZeCGtq2WVMFM1Bjv
 dp2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686368921; x=1688960921;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VnWMydR8I7AjHGk8PbtlJMwJlD444VqmITbEIIyb36o=;
 b=QeuXZWn7ocUQbKTNMxaiKESFAnzPaRMy0nC4Q7rmFnbdIWQM1B2lpgoLUcby71Ne6F
 N6vaKX80t6Qccbu/044yHgeD/mjxuUy2CYPHdP0bE3hYpdRBFHCJDFU+T6S066+1fNMJ
 UtZHTjRNOg2UAeRWkEAJek0V3l9MlMSlHxoSfEO4fxjp8cftllJmE2k5eJMciAYGDr7P
 R4EfLewWQPGCB5PkYEFNSZmH8SMS9Qj8VZnw0liAIFhEh7DOZJPhB13Nhrd1KNxcKjEi
 Z6SyhNDOD9PTJ4Q1rENtYaIQbQQUn4J8o5aUYc621SPOp3zNy6OPPnIVib8cHgd/YFdM
 6tUw==
X-Gm-Message-State: AC+VfDz9WsTcjLgtpP2wi1jljQc3Ts3HHWO6UBPmtjLaKLTVrAGdI0rg
 dY9mgm82YJw5z868GATOi3s4Xg==
X-Google-Smtp-Source: ACHHUZ6p27WIqBW+yHCD80t+4oYIIy0QBFkk9zuH8ol1TnM84ORi+tAkH782E3/ykyaoXN48pw8S1w==
X-Received: by 2002:a17:903:1209:b0:1b0:3224:e53a with SMTP id
 l9-20020a170903120900b001b03224e53amr986205plh.20.1686368920625; 
 Fri, 09 Jun 2023 20:48:40 -0700 (PDT)
Received: from [157.82.204.253] ([157.82.204.253])
 by smtp.gmail.com with ESMTPSA id
 w17-20020a170902e89100b001affb590696sm3912648plg.216.2023.06.09.20.48.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jun 2023 20:48:39 -0700 (PDT)
Message-ID: <735b9728-8d9a-0b1b-22c9-f8dac3723740@daynix.com>
Date: Sat, 10 Jun 2023 12:48:37 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] accel/kvm: Specify default IPA size for arm64
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>
References: <20230109062259.79074-1-akihiko.odaki@daynix.com>
 <481867e4-b019-80de-5369-9a503fa049ac@linaro.org>
 <fb435604-1638-c4ee-efca-bdbe2a4be98b@daynix.com>
 <CAFEAcA8dT+uvhCspUU9P-ev57UR9r5MDxkinPzwf+TieW_mUYg@mail.gmail.com>
 <1453e91d-c630-0d95-156d-cdf97774db1b@daynix.com>
Content-Language: en-US
In-Reply-To: <1453e91d-c630-0d95-156d-cdf97774db1b@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::636;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

On 2023/04/24 19:58, Akihiko Odaki wrote:
> On 2023/01/16 20:18, Peter Maydell wrote:
>> On Sat, 14 Jan 2023 at 06:49, Akihiko Odaki <akihiko.odaki@daynix.com> 
>> wrote:
>>>
>>> On 2023/01/14 14:23, Richard Henderson wrote:
>>>> On 1/8/23 22:22, Akihiko Odaki wrote:
>>>>> libvirt uses "none" machine type to test KVM availability. Before this
>>>>> change, QEMU used to pass 0 as machine type when calling 
>>>>> KVM_CREATE_VM.
>>>>>
>>>>> The kernel documentation says:
>>>>>> On arm64, the physical address size for a VM (IPA Size limit) is
>>>>>> limited to 40bits by default. The limit can be configured if the host
>>>>>> supports the extension KVM_CAP_ARM_VM_IPA_SIZE. When supported, use
>>>>>> KVM_VM_TYPE_ARM_IPA_SIZE(IPA_Bits) to set the size in the machine 
>>>>>> type
>>>>>> identifier, where IPA_Bits is the maximum width of any physical
>>>>>> address used by the VM. The IPA_Bits is encoded in bits[7-0] of the
>>>>>> machine type identifier.
>>>>>>
>>>>>> e.g, to configure a guest to use 48bit physical address size::
>>>>>>
>>>>>>       vm_fd = ioctl(dev_fd, KVM_CREATE_VM, 
>>>>>> KVM_VM_TYPE_ARM_IPA_SIZE(48));
>>>>>>
>>>>>> The requested size (IPA_Bits) must be:
>>>>>>
>>>>>>    ==   =========================================================
>>>>>>     0   Implies default size, 40bits (for backward compatibility)
>>>>>>     N   Implies N bits, where N is a positive integer such that,
>>>>>>         32 <= N <= Host_IPA_Limit
>>>>>>    ==   =========================================================
>>>>>
>>>>>> Host_IPA_Limit is the maximum possible value for IPA_Bits on the host
>>>>>> and is dependent on the CPU capability and the kernel configuration.
>>>>>> The limit can be retrieved using KVM_CAP_ARM_VM_IPA_SIZE of the
>>>>>> KVM_CHECK_EXTENSION ioctl() at run-time.
>>>>>>
>>>>>> Creation of the VM will fail if the requested IPA size (whether it is
>>>>>> implicit or explicit) is unsupported on the host.
>>>>> https://docs.kernel.org/virt/kvm/api.html#kvm-create-vm
>>>>>
>>>>> So if Host_IPA_Limit < 40, such KVM_CREATE_VM will fail, and libvirt
>>>>> incorrectly thinks KVM is not available. This actually happened on M2
>>>>> MacBook Air.
>>>>>
>>>>> Fix this by specifying 32 for IPA_Bits as any arm64 system should
>>>>> support the value according to the documentation.
>>>>>
>>>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>>> ---
>>>>>    accel/kvm/kvm-all.c | 4 ++++
>>>>>    1 file changed, 4 insertions(+)
>>>>>
>>>>> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
>>>>> index e86c33e0e6..776ac7efcc 100644
>>>>> --- a/accel/kvm/kvm-all.c
>>>>> +++ b/accel/kvm/kvm-all.c
>>>>> @@ -2294,7 +2294,11 @@ static int kvm_init(MachineState *ms)
>>>>>        KVMState *s;
>>>>>        const KVMCapabilityInfo *missing_cap;
>>>>>        int ret;
>>>>> +#ifdef TARGET_AARCH64
>>>>> +    int type = 32;
>>>>> +#else
>>>>>        int type = 0;
>>>>> +#endif
>>>>
>>>> No need for an ifdef.  Down below we have,
>>>>
>>>>       if (object_property_find(OBJECT(current_machine), "kvm-type")) {
>>>>           g_autofree char *kvm_type =
>>>> object_property_get_str(OBJECT(current_machine),
>>>>                                                               
>>>> "kvm-type",
>>>>                                                               
>>>> &error_abort);
>>>>           type = mc->kvm_type(ms, kvm_type);
>>>>       } else if (mc->kvm_type) {
>>>>           type = mc->kvm_type(ms, NULL);
>>>>       }
>>>>
>>>> and the aarch64 -M virt machine provides virt_kvm_type as mc->kvm_type.
>>>>
>>>> How did you hit this?  Are you trying to implement your own board 
>>>> model?
>>>>
>>>> Looking at this, I'm surprised this is a board hook and not a cpu hook.
>>>> But I suppose the architecture specific 'type' can hide any number of
>>>> sins.  Anyway, if you are doing your own board model, I suggest
>>>> arranging to share the virt board hook -- maybe moving it to
>>>> target/arm/kvm.c in the process?
>>
>>> I hit this problem when I used libvirt; libvirt uses "none" machine type
>>> to probe the availability of KVM and "none" machine type does not
>>> provide kvm_type hook.
>>>
>>> As the implementation of "none" machine type is shared among different
>>> architectures, we cannot remove ifdef by moving it to the hook.
>>>
>>> Although implementing the hook for "none" machine type is still
>>> possible, I  think the default type should provide the lowest common
>>> denominator and "none" machine type shouldn't try to work around when
>>> the type is wrong. Otherwise it doesn't make sense to provide the 
>>> "default".
>>
>> Yes, the problem is that the 'none' board type is all
>> architecture-independent code, and so is this kvm_init() code, so
>> there's no obvious arm-specific place to say "pick the best IPA size
>> that will work for this host".
>>
>> Perhaps we should create somewhere in here a target-arch specific
>> hook: we already have ifdefs in this function for S390X and PPC
>> (printing some special case error strings if the ioctl fails), so
>> maybe a hook that does "take the type provided by the machine hook,
>> if any, sanitize or reject it, do the ioctl call, print arch-specific
>> help/error messages if relevant" ? Paolo, do you have an opinion?
>>
>> thanks
>> -- PMM
> 
> Hi Paolo,
> 
> I have sent this patch a while ago but it's kind of missed so I'm about 
> to push this forward again. Can you have a look at this?
> 
> Regards,
> Akihiko Odaki

ping?

