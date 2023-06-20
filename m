Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA21F736721
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 11:11:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBXNZ-00022W-B4; Tue, 20 Jun 2023 05:10:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBXNV-00021r-TW
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:10:21 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBXNU-0000Ht-CH
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:10:21 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-986d871a9beso575852466b.1
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 02:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687252218; x=1689844218;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FFJenASP90LGDIyHFKED2q8AFhwROWlmAY4gt4+dzfA=;
 b=htIUGEOvI4VsXz9Otl7mkvt8HVfXC6nH1jcc76gCpAJhEMUut0qYrDgRlNu45JdSo5
 1UmpAvS1vjoR9cKH6bqt7MUq7r09F9F4r0v2ulDF/I0RkLLSN2SilcAVpzZK/qA1JOUW
 d4GTWkV/ERaOh4XDdWMgqEuKXVim1TjNhdM3SwpoyZrNHhb0SYOXaVfHven3fHUcTep7
 SMIhK2BPGdRSkcCqtZZiW2ujDrEa9iYExQDoWFSyotToYkItkrE3pUybdNsO7/y8oisD
 IfXcUXEjCbiXyFFkCpyi/+hhAOD7DzezvtsgDJM4H97SmvGJXxyfa0FnKlIRfRoCDfny
 BzUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687252218; x=1689844218;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FFJenASP90LGDIyHFKED2q8AFhwROWlmAY4gt4+dzfA=;
 b=PrFJ7yQhmp/D/NBCc6yJf30quC1buNL2i8xQV9Wu6hyJDentEmTwcfTH9k7c7rXOXG
 foLqmWs10OWuqk6hv3kNO2/EvE8bPSLSQZgCdznlCL0J2uCQ0F4T1LQ/8sfqdA7W3/ng
 TDhcxXxd7sBFfC32/q0PgtYTfSUY2+2VaqCC5ue5+MYpdAAUkjX6sH1UscuGZPwH5F8O
 BqpfSsM79wPsIQSsPrDtEuQ6yEfDR1yYZ4QsnxXfG1eAz5zf8OBYZdXU+bEiwcLhC9S2
 PhhdVa2Vk3ARnU44q5pwzpZVW0IkZTNojjgsLnIfIoVe4x9CAbzgDzefK+LdCM1Cc7+A
 147w==
X-Gm-Message-State: AC+VfDycKgwzZCrrQWzRI1xFv0TcEIbyUY1DSL3h+0ijkfFmQv8Iv2fT
 jQ+OFPkB0H/AcJJzszbQIuu4NYy6aLTezAfJTGQsV6Fp
X-Google-Smtp-Source: ACHHUZ6AhbpefVKZnQCb/CU+lF9GXxW8XZXegSHkd8QCUpbMDRoZWVfF8ZiEJXQ4PM7dOZpVMeGfgA==
X-Received: by 2002:a17:907:1609:b0:986:4789:1029 with SMTP id
 hb9-20020a170907160900b0098647891029mr11733406ejc.23.1687252218691; 
 Tue, 20 Jun 2023 02:10:18 -0700 (PDT)
Received: from [192.168.69.129] ([176.176.183.29])
 by smtp.gmail.com with ESMTPSA id
 f3-20020a170906390300b009893650453fsm584144eje.173.2023.06.20.02.10.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jun 2023 02:10:18 -0700 (PDT)
Message-ID: <f2731268-004f-74c4-3aa9-24dc0bacf835@linaro.org>
Date: Tue, 20 Jun 2023 11:10:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 9/9] target/ppc: Fix timer register accessors when !KVM
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: qemu-devel@nongnu.org
References: <20230620055911.187065-1-clg@kaod.org>
 <20230620055911.187065-10-clg@kaod.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230620055911.187065-10-clg@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x631.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 6/20/23 07:59, Cédric Le Goater wrote:
> When the Timer Control and Timer Status registers are modified, avoid
> calling the KVM backend when not available
> 
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
>   target/ppc/kvm.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index a7f2de9d1018..a8a935e26726 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -1728,6 +1728,10 @@ int kvmppc_or_tsr_bits(PowerPCCPU *cpu, uint32_t tsr_bits)
>           .addr = (uintptr_t) &bits,
>       };
>   
> +    if (!kvm_enabled()) {
> +        return 0;
> +    }

assert(kvm_enabled()) ?


r~

