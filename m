Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA317F92ED
	for <lists+qemu-devel@lfdr.de>; Sun, 26 Nov 2023 15:01:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7Ffk-0002lI-Re; Sun, 26 Nov 2023 08:59:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r7Fff-0002kt-6g
 for qemu-devel@nongnu.org; Sun, 26 Nov 2023 08:59:40 -0500
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r7Ffb-0005JJ-Lq
 for qemu-devel@nongnu.org; Sun, 26 Nov 2023 08:59:37 -0500
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-6d81580d696so638540a34.2
 for <qemu-devel@nongnu.org>; Sun, 26 Nov 2023 05:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701007174; x=1701611974; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=R0tl1FznWRSZXjG/br/+doPbwrsA5NmyepPx25HwKuI=;
 b=Zi4a38NmuykxFAfVe8RHIEIxiKD53buoFAGxIt0xqmX/orId2BEtt4qFcQ8Q7vkiYb
 o+DtoaUsrNgb9OcWbtwpvW2/aHw8raOo1My79I8v6FHIoaPTn3ihXMN8VDou8b7vE9Ob
 M9V9a5KbUUP/KKQYuzMmrgD/kC22uf8McM6xpoL+G73r81qjIAX4yHZ0eLfzZ9nTo1hk
 BUU0tFGQSRN5WEVgDbsaac4IYdC3MvDJUhAogkv+EnEoWYPmz6k2dtZe5Wfavvk+9gpN
 5Mxiivs31xbJWumeuWqs9NS+f0RJ0FKM/7Y6GpdWQxap4JnZJDnF6OS49Q/aBPt2qZvX
 nxKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701007174; x=1701611974;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=R0tl1FznWRSZXjG/br/+doPbwrsA5NmyepPx25HwKuI=;
 b=Pl2K9UDW4G6hyp+AYHZNUHWSHWBk3x0jchaPPBa7u4LXfXrjlqKdzh924xBmcNuGYX
 lJqt8/K0cB+8DjusUU54lTVJ78gb2Tbia8YDXJaAXaKMg3AxSiTTqUSMebssQrRT8aoH
 iS5I+aeK4m86LeQdL04B4q7bkay3dqJywxDHDKugyovWEZt3GWje2J7563DXSb9+qPkn
 Jol54ekTIt6RKWT2k7dn0uo1qnTAUt1UnkjuGXVugxs9RnNF1dUTBIb1XPVh58hku8La
 wB5yXQVPtbuIaICmYBPcl1qEKaF7wEtx2j4z/Qx5OCUjIo5sEN3R9TiwToK/SDiFum65
 +XEg==
X-Gm-Message-State: AOJu0Ywvw94jaUeJ9qW8pFVuFj45+Hmdf4cs9uqAiHzCgtjoGFEtByjC
 T80stb1tOqjjI5UZiSwcN+ceew==
X-Google-Smtp-Source: AGHT+IF7kW/awZBhcTnkmTfsTXsGwKE17/GAbOYH0WpjB8/6qRCu7XicdvDtLbhh0qKA5zhe9MhMag==
X-Received: by 2002:a9d:7c86:0:b0:6c2:2bca:7a14 with SMTP id
 q6-20020a9d7c86000000b006c22bca7a14mr10801328otn.23.1701007173808; 
 Sun, 26 Nov 2023 05:59:33 -0800 (PST)
Received: from [172.20.7.39] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 r8-20020a056830448800b006d3127234d7sm1058215otv.8.2023.11.26.05.59.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Nov 2023 05:59:33 -0800 (PST)
Message-ID: <c031bcb4-7b2b-4ca4-a25b-65e9c10430af@linaro.org>
Date: Sun, 26 Nov 2023 07:59:30 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0 00/16] target/arm/kvm: Unify kvm_arm_FOO() API
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20231123183518.64569-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231123183518.64569-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x332.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 11/23/23 12:35, Philippe Mathieu-Daudé wrote:
> Half of the API takes CPUState, the other ARMCPU...
> 
> $ git grep -F 'CPUState *' target/arm/kvm_arm.h | wc -l
>        16
> $ git grep -F 'ARMCPU *' target/arm/kvm_arm.h | wc -l
>        14
> 
> Since this is ARM specific, have it always take ARMCPU, and
> call the generic KVM API casting with the CPU() macro.
> 
> Based-on: <20231123044219.896776-1-richard.henderson@linaro.org>
>    "target/arm: kvm cleanups"
>    https://lore.kernel.org/qemu-devel/20231123044219.896776-1-richard.henderson@linaro.org/
> 
> Philippe Mathieu-Daudé (16):
>    hw/intc/arm_gicv3: Include missing 'qemu/error-report.h' header
>    target/arm/kvm: Remove unused includes
>    target/arm/kvm: Have kvm_arm_add_vcpu_properties take a ARMCPU
>      argument
>    target/arm/kvm: Have kvm_arm_sve_set_vls take a ARMCPU argument
>    target/arm/kvm: Have kvm_arm_sve_get_vls take a ARMCPU argument
>    target/arm/kvm: Have kvm_arm_set_device_attr take a ARMCPU argument
>    target/arm/kvm: Have kvm_arm_pvtime_init take a ARMCPU argument
>    target/arm/kvm: Have kvm_arm_pmu_init take a ARMCPU argument
>    target/arm/kvm: Have kvm_arm_pmu_set_irq take a ARMCPU argument
>    target/arm/kvm: Have kvm_arm_vcpu_init take a ARMCPU argument
>    target/arm/kvm: Have kvm_arm_vcpu_finalize take a ARMCPU argument
>    target/arm/kvm: Have kvm_arm_[get|put]_virtual_time take ARMCPU
>      argument
>    target/arm/kvm: Have kvm_arm_verify_ext_dabt_pending take a ARMCPU arg
>    target/arm/kvm: Have kvm_arm_handle_dabt_nisv take a ARMCPU argument
>    target/arm/kvm: Have kvm_arm_handle_debug take a ARMCPU argument
>    target/arm/kvm: Have kvm_arm_hw_debug_active take a ARMCPU argument


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

