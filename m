Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E8EEC7B9B3D
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 09:07:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoIRj-0004iv-5a; Thu, 05 Oct 2023 03:06:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qoIRd-0004hX-Ik
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 03:06:50 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qoIRa-0008Q6-Kc
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 03:06:48 -0400
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2bfea381255so7812091fa.3
 for <qemu-devel@nongnu.org>; Thu, 05 Oct 2023 00:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696489603; x=1697094403; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+d6KY11DqRLjvBXz5XKaI7m2MfBxT2g08tYpGKrrrT0=;
 b=r3ulq+ESKb8uaClBdPDeDjnQbBGvbWsZ02K645EFgqaG9u3MdWl5wQklpCQwCVBW4L
 K9oIvxj//PZnaVstYW2AjPITVl4U4Xwco19fdw9lHzzzQHrfIJxHqcKAxaBPze8pO48h
 ZQk5pZQt2pHVwfQWjMGs1qYLhERve6W/WgQknMg0w+DtBLy1M7KXiNPQxJeCoJyKqFAO
 f6J8KN6djo8JY4lL+bu9hQu21DZ9DATLKOf4Q0Dg+qu2uk/GUhHIO9kUPN952JfaWSEt
 QGgpjpgszm4XZpEZpSoHa6BBXWNvVxnXfvsnEqRPBT2lN9rwDfIVWoUJg/6ijZ2Svq0U
 oJiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696489603; x=1697094403;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+d6KY11DqRLjvBXz5XKaI7m2MfBxT2g08tYpGKrrrT0=;
 b=tWmutSywA4gxkewdea0RKdQQ6cSw+Qz/4nEDqn9/pBG+g/+tAa302Zufz9Ukmb+f1x
 pBAQM+wHus/dyDMFzGbjXrGBjKIeJNKfQUijekNhDrkm/xu0K/yqPRhGUXKjNeW9UDng
 Z1W4/RA7ZFfHA45zqO1XNX7kqvFKPF0MiOFpMxM+jkJLpjhFHsjIwTLMjRM4yndwjwSY
 9WuPBOMJ2424FG4NJim2t3XamsxiWpcPVfOjVD1nC73TF2zpCqyib2ZqdFEN0yN+qOlB
 bjOCf6LgQDYOLZf5LDHJ3/iEZo/zl12pVr554S3Gf61c+R9rbB1hnboeGyhy4Orb0b9T
 Cpdg==
X-Gm-Message-State: AOJu0YybqDYoZtseoDcmG74+CSundYXFb8zw84GJgFhE6F2VzLCpXPef
 22Yel6dTnEGhCu4hMZ5OF1u6Uw==
X-Google-Smtp-Source: AGHT+IHIuJ79lJZmSnnfiOX4jKSdP3hymnG4PfMgVOHzYn3SK3RmFC7cfiBL7Ikhy37HU7ytFIwmCw==
X-Received: by 2002:a19:ca08:0:b0:4ff:9efd:8a9e with SMTP id
 a8-20020a19ca08000000b004ff9efd8a9emr3570822lfg.7.1696489601725; 
 Thu, 05 Oct 2023 00:06:41 -0700 (PDT)
Received: from [192.168.69.115]
 (tbo33-h01-176-171-211-120.dsl.sta.abo.bbox.fr. [176.171.211.120])
 by smtp.gmail.com with ESMTPSA id
 q5-20020a7bce85000000b0040596352951sm3100553wmj.5.2023.10.05.00.06.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Oct 2023 00:06:41 -0700 (PDT)
Message-ID: <e2dc91e2-9ed3-6919-8a7e-d9e159a55b43@linaro.org>
Date: Thu, 5 Oct 2023 09:06:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v2 2/5] hw/i386/apic: Defer error check from
 apic_get_class to kvm_apic_realize
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost
 <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>
References: <20231003082728.83496-1-philmd@linaro.org>
 <20231003082728.83496-3-philmd@linaro.org>
 <8527EF0C-E466-41A0-B1A2-9AEF301B5B5E@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <8527EF0C-E466-41A0-B1A2-9AEF301B5B5E@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x233.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.528,
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

Hi Bernhard,

On 4/10/23 01:21, Bernhard Beschow wrote:
> Am 3. Oktober 2023 08:27:25 UTC schrieb "Philippe Mathieu-Daudé" <philmd@linaro.org>:
>> apic_get_class() isn't supposed to fail. kvm_apic_realize() is
>> DeviceRealize() handler, which can fail. Defer the error check
>> to the latter.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>> hw/i386/kvm/apic.c       | 5 +++++
>> target/i386/cpu-sysemu.c | 8 --------
>> 2 files changed, 5 insertions(+), 8 deletions(-)

                         "kvm-apic-msi", APIC_SPACE_SIZE);
>>
>> diff --git a/target/i386/cpu-sysemu.c b/target/i386/cpu-sysemu.c
>> index 2375e48178..6a228c9178 100644
>> --- a/target/i386/cpu-sysemu.c
>> +++ b/target/i386/cpu-sysemu.c
>> @@ -253,10 +253,6 @@ APICCommonClass *apic_get_class(Error **errp)
>>
>>      /* TODO: in-kernel irqchip for hvf */
>>      if (kvm_enabled()) {
>> -        if (!kvm_irqchip_in_kernel()) {
>> -            error_setg(errp, "KVM does not support userspace APIC");
>> -            return NULL;
>> -        }
>>          apic_type = "kvm-apic";
>>      } else if (xen_enabled()) {
>>          apic_type = "xen-apic";
>> @@ -272,10 +268,6 @@ void x86_cpu_apic_create(X86CPU *cpu, Error **errp)
>>      APICCommonState *apic;
>>      APICCommonClass *apic_class = apic_get_class(errp);
>>
>> -    if (!apic_class) {
>> -        return;
>> -    }
>> -
> 
> Did you intend to remove these lines in the next commit? There you're writing to simplify x86_cpu_apic_create() which you're doing here already.

No: apic_get_class() doesn't return NULL anymore, so this is dead code.

> 
> Best regards,
> Bernhard

