Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1907F9868
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 05:37:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7TMH-00088S-57; Sun, 26 Nov 2023 23:36:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1r7TMD-000883-Tk
 for qemu-devel@nongnu.org; Sun, 26 Nov 2023 23:36:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1r7TMA-0001DU-Q5
 for qemu-devel@nongnu.org; Sun, 26 Nov 2023 23:36:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701059786;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uB8RtCVtSAfV4uboXXib4r70O1crEDrMolu/UkoV8Y0=;
 b=YDgo6p9XSS/vuPrtqeL4A0KCBwiN8hI9ABjdAgBwTpZ8SmLOUVQgFMQhoR972mkzOOI/N1
 Bxt0LxoDeOfb/Xpw6cpshZmern/E1SuziPYZjPh0gIZXICrRZUBYT5IVghwS+htVFBE5ly
 go7OuEU88+wga7vThTOCq3t1S6X05PY=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-kjJLYPeNMeuOtGw5MqKf5g-1; Sun, 26 Nov 2023 23:36:24 -0500
X-MC-Unique: kjJLYPeNMeuOtGw5MqKf5g-1
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-1fa182dc04aso3228922fac.1
 for <qemu-devel@nongnu.org>; Sun, 26 Nov 2023 20:36:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701059784; x=1701664584;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uB8RtCVtSAfV4uboXXib4r70O1crEDrMolu/UkoV8Y0=;
 b=qwvEnqq6TkZpAqHe7zbVOwBV425dstev8g6ThIU7TtjdCVxw1udk3GUVyRczRuAjcr
 lfKc+MLY2eBSJjwSH0+WcOTJEPisMEis7oDSZZt/HNW1bDyOKZg0o08JhIg0LQ17hK6e
 edEKTXoQOHI96LAr6C30L49H1epKYWDoVvcWOdoIuj6DtL3T7SLf2SBi2oBh6lGvaIP2
 KYioddGo5Y472sCtZqwKxuKtU8EiWMKhgEsMrjZAuI1YeHgR/eB4f3qsrd96wpyyoDo7
 tzI6rY/xxSOKszA6nCOwS1Wd1sXrgje/IHzpJMTGzgsl7BekIqR3j2/c8zQBiE0dZ4MR
 ITLw==
X-Gm-Message-State: AOJu0Yzt4VZhZIuS4qxh6c7lcxP/1eveqZAl7A1itvghWvOd3VaD+7Uw
 xgotf6AsWsZFxGgb0o2we0d8KpznEFES6JY1tt2gCBi3E6dBll+oCXo7ZfYgrzzSlgH4iaGM0RY
 EDXpgMNZvtzv+9gM=
X-Received: by 2002:a05:6870:ea08:b0:1fa:1efd:f65e with SMTP id
 g8-20020a056870ea0800b001fa1efdf65emr9308579oap.21.1701059784159; 
 Sun, 26 Nov 2023 20:36:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHS3kztNt48niItFPhRKBja756oNavjoZfrYv85qD4BdhzRiKHQ1nqW8EJ9HSaJNJ1pWad57w==
X-Received: by 2002:a05:6870:ea08:b0:1fa:1efd:f65e with SMTP id
 g8-20020a056870ea0800b001fa1efdf65emr9308568oap.21.1701059783938; 
 Sun, 26 Nov 2023 20:36:23 -0800 (PST)
Received: from [192.168.68.51] ([43.252.115.3])
 by smtp.gmail.com with ESMTPSA id
 j25-20020a62e919000000b006930db1e6cfsm6334347pfh.62.2023.11.26.20.36.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Nov 2023 20:36:23 -0800 (PST)
Message-ID: <9c1cb48a-9de0-45ed-80e3-2ea4d4d5bff3@redhat.com>
Date: Mon, 27 Nov 2023 15:36:19 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0 16/16] target/arm/kvm: Have
 kvm_arm_hw_debug_active take a ARMCPU argument
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20231123183518.64569-1-philmd@linaro.org>
 <20231123183518.64569-17-philmd@linaro.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20231123183518.64569-17-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Hi Phil,

On 11/24/23 05:35, Philippe Mathieu-Daudé wrote:
> Unify the "kvm_arm.h" API: All functions related to ARM vCPUs
> take a ARMCPU* argument. Use the CPU() QOM cast macro When
> calling the generic vCPU API from "sysemu/kvm.h".
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/arm/kvm.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 

With the following comments addressed:

Reviewed-by: Gavin Shan <gshan@redhat.com>

> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index 1f6da5529f..cbfea689cc 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -1455,11 +1455,11 @@ int kvm_arch_process_async_events(CPUState *cs)
>   
>   /**
>    * kvm_arm_hw_debug_active:
> - * @cs: CPU State
> + * @cpu: ARMCPU
>    *
>    * Return: TRUE if any hardware breakpoints in use.
>    */
> -static bool kvm_arm_hw_debug_active(CPUState *cs)
> +static bool kvm_arm_hw_debug_active(ARMCPU *cpu)
>   {
>       return ((cur_hw_wps > 0) || (cur_hw_bps > 0));
>   }

Either @cs or @cpu isn't dereferenced in kvm_arm_hw_debug_active(). So I guess
the argument can be simply droped?

> @@ -1493,7 +1493,7 @@ void kvm_arch_update_guest_debug(CPUState *cs, struct kvm_guest_debug *dbg)
>       if (kvm_sw_breakpoints_active(cs)) {
>           dbg->control |= KVM_GUESTDBG_ENABLE | KVM_GUESTDBG_USE_SW_BP;
>       }
> -    if (kvm_arm_hw_debug_active(cs)) {
> +    if (kvm_arm_hw_debug_active(ARM_CPU(cs))) {
>           dbg->control |= KVM_GUESTDBG_ENABLE | KVM_GUESTDBG_USE_HW;
>           kvm_arm_copy_hw_debug_data(&dbg->arch);
>       }

Thanks,
Gavin


