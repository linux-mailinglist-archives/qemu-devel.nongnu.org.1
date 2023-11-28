Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C83F7FB22A
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 07:53:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7rxx-0001S3-AV; Tue, 28 Nov 2023 01:53:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r7rxu-0001RV-3g
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 01:53:02 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r7rxq-0000mO-Tu
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 01:53:00 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-332f90a375eso1646888f8f.3
 for <qemu-devel@nongnu.org>; Mon, 27 Nov 2023 22:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701154377; x=1701759177; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oUmo3C1pLShDouWu+ZeJVsUjFrpOVE+VE0tTre6Q9A4=;
 b=pu3Th+ooKC9wkpBuGvfdtEfycmb5nrjZmw9u1wrBxQFuswz+hJMSJh/57PYc4JJYbh
 R+mjVTeI8e+hy8CS6tuOjVGZR4Cw3OTCFqNeLfP4qZoAQ0byQQnOuFSNuaY4FVBghrCG
 D2SMBDpdcQ3VjeDUpGdH0q3DCZW4BNEiaHyKdBnyWiLsWfIhYZTFgpydK+yPPDFuZ5rR
 Pd428PZEQAcI/m0zNpjkEy2IAWL3+MFF39kDmvrc4q0ZDA8M2h5Gr5iuH9ii/zvVviIh
 SmHwtpx+7VowAYx+q1p6jY6MElHf0XpDBRSrCUfWq3yfvqlRWHKiFolisk5CMQWjvm9t
 L72Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701154377; x=1701759177;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oUmo3C1pLShDouWu+ZeJVsUjFrpOVE+VE0tTre6Q9A4=;
 b=k50+fyIf1rSMgp9uW+0sSzm4sEL6xo+MD4Xt2Mjleg97ZBnzBt/aNn4MGg35EdEgct
 KG4ZzyrQzBIZJclThgpYdRLaf8wsGhtmRdVY5wQNTJN3U35jDV1oNDTY6J0Wi5ng7dgk
 oYC93G8SeNHuH/YwaOGvkMUVO+x9Ha05K2QoHPWc4aoLHG3rcb9VypKx37YPnKxWKk2l
 2Hj6+E42N0bcH23DPMwJL71OVJtkENL+bu5d5+TMnMjELgxEKaItNckYojmcJoFhWQrZ
 NvXrrslnpc1twd66WtmidmrnxbVoII/CX6OaJfu3b8EyM/FhdhxzX3fpHF3GiyyMezOE
 ZQgQ==
X-Gm-Message-State: AOJu0YysJ44t53RwDOQ8jk1OqOnwsN4QVyKwJW7sG67HjCF/lYwzQzXh
 fNq7pk8PSvPJb/seRMHKbNkZQw==
X-Google-Smtp-Source: AGHT+IGfQuAgYK0TAY1xVNqwWVacxP9S+uY59Sn5TG1o51U03XtkUUwTK9OX8cVZn/CaXFY34k6bAg==
X-Received: by 2002:a5d:5273:0:b0:331:6ad3:857 with SMTP id
 l19-20020a5d5273000000b003316ad30857mr9979882wrc.16.1701154377150; 
 Mon, 27 Nov 2023 22:52:57 -0800 (PST)
Received: from [192.168.69.100] (crb44-h02-176-184-13-61.dsl.sta.abo.bbox.fr.
 [176.184.13.61]) by smtp.gmail.com with ESMTPSA id
 w27-20020adf8bdb000000b00332e5624a31sm13406545wra.84.2023.11.27.22.52.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Nov 2023 22:52:56 -0800 (PST)
Message-ID: <4a04694e-f376-406f-84cb-f677ded08988@linaro.org>
Date: Tue, 28 Nov 2023 07:52:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0 03/16] target/arm/kvm: Have
 kvm_arm_add_vcpu_properties take a ARMCPU argument
Content-Language: en-US
To: Gavin Shan <gshan@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20231123183518.64569-1-philmd@linaro.org>
 <20231123183518.64569-4-philmd@linaro.org>
 <52cf8040-b134-4dc6-b6ce-1d51a3dc13ef@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <52cf8040-b134-4dc6-b6ce-1d51a3dc13ef@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 27/11/23 05:05, Gavin Shan wrote:
> Hi Phil,
> 
> On 11/24/23 05:35, Philippe Mathieu-Daudé wrote:
>> Unify the "kvm_arm.h" API: All functions related to ARM vCPUs
>> take a ARMCPU* argument. Use the CPU() QOM cast macro When
>> calling the generic vCPU API from "sysemu/kvm.h".
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   target/arm/kvm_arm.h | 4 ++--
>>   target/arm/cpu.c     | 2 +-
>>   target/arm/kvm.c     | 4 ++--
>>   3 files changed, 5 insertions(+), 5 deletions(-)
>>
> 
> With the following comments resolved:
> 
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> 
>> diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
>> index 50967f4ae9..6fb8a5f67e 100644
>> --- a/target/arm/kvm_arm.h
>> +++ b/target/arm/kvm_arm.h
>> @@ -153,7 +153,7 @@ void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu);
>>    * Add all KVM specific CPU properties to the CPU object. These
>>    * are the CPU properties with "kvm-" prefixed names.
>>    */
>> -void kvm_arm_add_vcpu_properties(Object *obj);
>> +void kvm_arm_add_vcpu_properties(ARMCPU *cpu);
> 
> The function's description needs to be modified since @obj has been
> renamed to @cpu?
> 
>    /**
>     * kvm_arm_add_vcpu_properties:
>     * @obj: The CPU object to add the properties to
>     *
>     */

Oops thanks!

