Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 21ED97D7C89
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 07:53:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvtIf-0005Cy-Mt; Thu, 26 Oct 2023 01:52:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvtIb-0005Cf-VH
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 01:52:53 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvtIY-000114-BM
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 01:52:52 -0400
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2c59a4dd14cso6922481fa.2
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 22:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698299568; x=1698904368; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Blus2E8MXTIU3zWcw+upkP+KG6Xw5pB0t5mXlT/gwLU=;
 b=l4YxRF2uLqia0ezSInjPqF35Rjfv97+CiJaTIkowbvxoalW9RzVgPNkfMZZwea0mfM
 H8+oCcRSI+4STBHQh/YBZcD8kPXKdWy67qNQTx/N6omBQ8TAlKkPDWSfIAVx8OuWwR0c
 cImA4ISuTCZwhrtZWYDuVkMJ1IyikraqKRHFefPxR4eEDdaWFsloNujcdU4h6+RZtPfQ
 BVweSQkj+RVGlwfEpjFcvQeC39rMJgHBxiaWFd9R+EGj1s/fAzfCdYL5cd49us1MMdvb
 pSl4C17C/r8X40zmHzMJEKsjneoXaFHdzdiYxhmA/W6wFtX/a1HW1yTu65q2xO+raJtf
 rPsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698299568; x=1698904368;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Blus2E8MXTIU3zWcw+upkP+KG6Xw5pB0t5mXlT/gwLU=;
 b=rIB9bGOFiIxDtwJlUiL4kc8/nas1YOcwktxW4hc8W8fUdtQkYqP+y05BQvNzkYE+NL
 3s/Ml8Zg9gijwbh9JM6yNRDTtRBNIF3bKnMLnOLf4pmLMuBpFQf9VWkGI9WvN/ENWbrH
 BL5BVhh0YCkcA7GVQ5xNJ2GrusF2OJFJOwBmfg7uGN4hlif0P2/9SqFdtjtI1Bq3AYTs
 Mi4Hn+HmRg8WAQdO7dZv9GL0w9vPTzdLUwb+FYr6ad/zDoUkIeopNll3f3+j/0PTqZRA
 W62rLNeUZ/Wf4UGJKlRnbBMv41xn5SrpptNCJjdp9qBYVlzZHEOHFS4DoHyY108Rgrud
 JLFg==
X-Gm-Message-State: AOJu0Yy6WmaA1CX3cc2OdZsxowBLla4NetjLdekaztNWCJcGdv3BBCI/
 OSGTrzdf0LvM7TO9dGcbOgkbYw==
X-Google-Smtp-Source: AGHT+IGF8aTwjtsUMEqjRxbYFSfypaf74fyCg1NLwA+TH4Xd7SyLRTwSAW3uGtRI2Hotypp1x3c/Ww==
X-Received: by 2002:a2e:9812:0:b0:2bd:102c:4161 with SMTP id
 a18-20020a2e9812000000b002bd102c4161mr13652384ljj.43.1698299567693; 
 Wed, 25 Oct 2023 22:52:47 -0700 (PDT)
Received: from [192.168.69.115]
 (aif79-h01-176-172-114-150.dsl.sta.abo.bbox.fr. [176.172.114.150])
 by smtp.gmail.com with ESMTPSA id
 m17-20020a056000009100b0032d829e10c0sm13514117wrx.28.2023.10.25.22.52.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Oct 2023 22:52:47 -0700 (PDT)
Message-ID: <78ddc3c3-6cfa-b48c-5d73-903adec6ac4a@linaro.org>
Date: Thu, 26 Oct 2023 07:52:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] target/i386/kvm: call kvm_put_vcpu_events() before
 kvm_put_nested_state()
Content-Language: en-US
To: Eiichi Tsukata <eiichi.tsukata@nutanix.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "mtosatti@redhat.com" <mtosatti@redhat.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Vitaly Kuznetsov <vkuznets@redhat.com>
References: <20231026054201.87845-1-eiichi.tsukata@nutanix.com>
 <D761458A-9296-492B-85B9-F196C7D11CDA@nutanix.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <D761458A-9296-492B-85B9-F196C7D11CDA@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x233.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
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

Cc'ing Vitaly.

On 26/10/23 07:49, Eiichi Tsukata wrote:
> Hi all,
> 
> Here is additional details on the issue.
> 
> We've found this issue when testing Windows Virtual Secure Mode (VSM) VMs.
> We sometimes saw live migration failures of VSM-enabled VMs. It turned
> out that the issue happens during live migration when VMs change boot related
> EFI variables (ex: BootOrder, Boot0001).
> After some debugging, I've found the race I mentioned in the commit message.
> 
> Symptom
> =======
> 
> When it happnes with the latest Qemu which has commit https://github.com/qemu/qemu/commit/7191f24c7fcfbc1216d09
> Qemu shows the following error message on destination.
> 
>    qemu-system-x86_64: Failed to put registers after init: Invalid argument
> 
> If it happens with older Qemu which doesn't have the commit, then we see  CPU dump something like this:
> 
>    KVM internal error. Suberror: 3
>    extra data[0]: 0x0000000080000b0e
>    extra data[1]: 0x0000000000000031
>    extra data[2]: 0x0000000000000683
>    extra data[3]: 0x000000007f809000
>    extra data[4]: 0x0000000000000026
>    RAX=0000000000000000 RBX=0000000000000000 RCX=0000000000000000 RDX=0000000000000f61
>    RSI=0000000000000000 RDI=0000000000000000 RBP=0000000000000000 RSP=0000000000000000
>    R8 =0000000000000000 R9 =0000000000000000 R10=0000000000000000 R11=0000000000000000
>    R12=0000000000000000 R13=0000000000000000 R14=0000000000000000 R15=0000000000000000
>    RIP=000000000000fff0 RFL=00010002 [-------] CPL=0 II=0 A20=1 SMM=0 HLT=0
>    ES =0020 0000000000000000 ffffffff 00c09300 DPL=0 DS   [-WA]
>    CS =0038 0000000000000000 ffffffff 00a09b00 DPL=0 CS64 [-RA]
>    SS =0020 0000000000000000 ffffffff 00c09300 DPL=0 DS   [-WA]
>    DS =0020 0000000000000000 ffffffff 00c09300 DPL=0 DS   [-WA]
>    FS =0020 0000000000000000 ffffffff 00c09300 DPL=0 DS   [-WA]
>    GS =0020 0000000000000000 ffffffff 00c09300 DPL=0 DS   [-WA]
>    LDT=0000 0000000000000000 ffffffff 00c00000
>    TR =0040 000000007f7df050 00068fff 00808b00 DPL=0 TSS64-busy
>    GDT=     000000007f7df000 0000004f
>    IDT=     000000007f836000 000001ff
>    CR0=80010033 CR2=000000000000fff0 CR3=000000007f809000 CR4=00000668
>    DR0=0000000000000000 DR1=0000000000000000 DR2=0000000000000000 DR3=0000000000000000    DR6=00000000ffff0ff0 DR7=0000000000000400
>    EFER=0000000000000d00
>    Code=?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? <??> ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ??
> 
> In the above dump, CR3 is pointing to SMRAM region though SMM=0.
> 
> Repro
> =====
> 
> Repro step is pretty simple.
> 
> * Run SMM enabled Linux guest with secure boot enabled OVMF.
> * Run the following script in the guest.
> 
>    /usr/libexec/qemu-kvm &
>    while true
>    do
>      efibootmgr -n 1
>    done
> 
> * Do live migration
> 
> On my environment, live migration fails in 20%.
> 
> VMX specific
> ============
> 
> This issue is VMX sepcific and SVM is not affected as the validation
> in svm_set_nested_state() is a bit different from VMX one.
> 
> VMX:
> 
>    static int vmx_set_nested_state(struct kvm_vcpu *vcpu,
>                                    struct kvm_nested_state __user *user_kvm_nested_state,
>                                    struct kvm_nested_state *kvm_state)
>    {
>    ..           /*             * SMM temporarily disables VMX, so we cannot be in guest mode,
>           * nor can VMLAUNCH/VMRESUME be pending.  Outside SMM, SMM flags
>           * must be zero.
>           */           if (is_smm(vcpu) ?
>                  (kvm_state->flags &
>                   (KVM_STATE_NESTED_GUEST_MODE | KVM_STATE_NESTED_RUN_PENDING))
>                  : kvm_state->hdr.vmx.smm.flags)
>                  return -EINVAL;
>    ..
> 
> SVM:
> 
>    static int svm_set_nested_state(struct kvm_vcpu *vcpu,
>                                    struct kvm_nested_state __user *user_kvm_nested_state,
>                                    struct kvm_nested_state *kvm_state)
>    {
>    ..           /* SMM temporarily disables SVM, so we cannot be in guest mode.  */           if (is_smm(vcpu) && (kvm_state->flags & KVM_STATE_NESTED_GUEST_MODE))
>                  return -EINVAL;
>    ..
> 
> Thanks,
> 
> Eiichi
> 
>> On Oct 26, 2023, at 14:42, Eiichi Tsukata <eiichi.tsukata@nutanix.com> wrote:
>>
>> kvm_put_vcpu_events() needs to be called before kvm_put_nested_state()
>> because vCPU's hflag is referred in KVM vmx_get_nested_state()
>> validation. Otherwise kvm_put_nested_state() can fail with -EINVAL when
>> a vCPU is in VMX operation and enters SMM mode. This leads to live
>> migration failure.
>>
>> Signed-off-by: Eiichi Tsukata <eiichi.tsukata@nutanix.com>
>> ---
>> target/i386/kvm/kvm.c | 13 +++++++++----
>> 1 file changed, 9 insertions(+), 4 deletions(-)
>>
>> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
>> index e7c054cc16..cd635c9142 100644
>> --- a/target/i386/kvm/kvm.c
>> +++ b/target/i386/kvm/kvm.c
>> @@ -4741,6 +4741,15 @@ int kvm_arch_put_registers(CPUState *cpu, int level)
>>          return ret;
>>      }
>>
>> +    /*
>> +     * must be before kvm_put_nested_state so that HF_SMM_MASK is set during
>> +     * SMM.
>> +     */
>> +    ret = kvm_put_vcpu_events(x86_cpu, level);
>> +    if (ret < 0) {
>> +        return ret;
>> +    }
>> +
>>      if (level >= KVM_PUT_RESET_STATE) {
>>          ret = kvm_put_nested_state(x86_cpu);
>>          if (ret < 0) {
>> @@ -4787,10 +4796,6 @@ int kvm_arch_put_registers(CPUState *cpu, int level)
>>      if (ret < 0) {
>>          return ret;
>>      }
>> -    ret = kvm_put_vcpu_events(x86_cpu, level);
>> -    if (ret < 0) {
>> -        return ret;
>> -    }
>>      if (level >= KVM_PUT_RESET_STATE) {
>>          ret = kvm_put_mp_state(x86_cpu);
>>          if (ret < 0) {
>> -- 
>> 2.41.0
>>
> 
> 


