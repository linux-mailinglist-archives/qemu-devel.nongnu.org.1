Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A19367F5BD7
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 11:02:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r66W0-0001Ja-DG; Thu, 23 Nov 2023 05:00:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r66Vx-0001Ig-RF
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 05:00:54 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r66Vw-0004t1-8A
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 05:00:53 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40b2afd049aso4469075e9.0
 for <qemu-devel@nongnu.org>; Thu, 23 Nov 2023 02:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700733650; x=1701338450; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uhF8UjaKtMa3szBB3PYJ7CaLfrF8gURumFjUK6ZS6vo=;
 b=pc+vPKH3WDZMby0Lgw9W9QGOfAzwkI3UD6wcjjU9nbG/xEmVgWYpdwutyAtYPLHObK
 qZ1nBoMurZXlNE7vmBuLQFtyIvygiEzz6j0W6tCbSjjMBcWtFHrS+3aKPobe+8uv48Jp
 KltO9lGN/8GkXMpgrxM2sDvg0XQ+xA6tnr32DuOytFXY7g6692e9oejPz7YxhkjIxxqi
 goVW1Tbhm4sgcmvsuLnmUxxBKb2BCpU94YuQIWUZPusAHEroaEY27bGkZyB5WxaYKGt+
 lx83WaxRMukaKYqsJ7fi7SAMsloOXBoBsMhPsyBJpThfLx8JM3xp1RNX1qkh7H8UBEpA
 Dkxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700733650; x=1701338450;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uhF8UjaKtMa3szBB3PYJ7CaLfrF8gURumFjUK6ZS6vo=;
 b=soZ7x6irShNHirzVB+dHLEnfEL7OXfl7lRv7h43OomzIcISmR2kyf+Mas35MiFX+/Z
 C2gIvvAj9prSLBqdZcSGUbuAGTkrQlRC3zP2mJI54pValWbYPb8Bs0NymeJSKPmI0Oh0
 7VWmq9evVTrtkHaltR2lUfeYAgStY0BieUlx0qlVXCLSl+5exnFGSCVzf150uHPMalWK
 pvVns0AtYtamtMD5ukJe8jnIL4bew8BFRruKRWUmsYsCJ+IVckYXmg40sovcO4P2zVcN
 WoaJ3JVqF4p72xk65MSDVN5WeZDLgF4G0x3H7afE+FNBxIALKazStyIlexUv+uF9yVhZ
 e71w==
X-Gm-Message-State: AOJu0YzFX0SnsjgVdz3+2K6uBhjsvoP3PEbktwChyoHHp8jaM3NZ6MVf
 MGXrx5KkB29a1MrA6Cop8r6m/r1ksxEfihvxsyk=
X-Google-Smtp-Source: AGHT+IHx+SD/0zkpuvOSADdw6ceWWuFrh9u4dDRlbXzg8816flrF3uNsgv9Mzcp+b+WTVscveXh0yA==
X-Received: by 2002:a05:600c:3108:b0:409:703c:b9b1 with SMTP id
 g8-20020a05600c310800b00409703cb9b1mr3507739wmo.40.1700733649821; 
 Thu, 23 Nov 2023 02:00:49 -0800 (PST)
Received: from [192.168.69.100] ([176.176.165.237])
 by smtp.gmail.com with ESMTPSA id
 f18-20020a05600c4e9200b00403b63e87f2sm1430208wmq.32.2023.11.23.02.00.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Nov 2023 02:00:49 -0800 (PST)
Message-ID: <4b89c690-1a21-439d-ab30-0fa5bc7bb038@linaro.org>
Date: Thu, 23 Nov 2023 11:00:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH-for-9.0 02/11] target/arm: Add
 target_aarch64_available() helper
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20231122183048.17150-1-philmd@linaro.org>
 <20231122183048.17150-3-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231122183048.17150-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 22/11/23 19:30, Philippe Mathieu-Daudé wrote:
> We want to build HW models once, but don't want to
> register types when all prerequisites are satisfied. Add
> the target_aarch64_available() to know at runtime whether
> TARGET_AARCH64 is built-in.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/arm/cpu-qom.h | 2 ++
>   target/arm/cpu.c     | 9 +++++++++
>   2 files changed, 11 insertions(+)
> 
> diff --git a/target/arm/cpu-qom.h b/target/arm/cpu-qom.h
> index 02b914c876..bf6b3604ed 100644
> --- a/target/arm/cpu-qom.h
> +++ b/target/arm/cpu-qom.h
> @@ -33,4 +33,6 @@ typedef struct AArch64CPUClass AArch64CPUClass;
>   DECLARE_CLASS_CHECKERS(AArch64CPUClass, AARCH64_CPU,
>                          TYPE_AARCH64_CPU)
>   
> +bool target_aarch64_available(void);
> +
>   #endif
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 25e9d2ae7b..1990c04089 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -2548,3 +2548,12 @@ static void arm_cpu_register_types(void)
>   }
>   
>   type_init(arm_cpu_register_types)
> +
> +bool target_aarch64_available(void)
> +{
> +#ifdef TARGET_AARCH64
> +    return true;
> +#else
> +    return false;
> +#endif
> +}

I forgot to precise here, what was discussed during the previous 2
years. Eventually qemu-system-arm is absorbed by qemu-system-aarch64,
but to keep backward compatibility we add a new qemu-system-arm wrapper
which simply calls 'qemu-system-aarch64 --32bit-only' (or better named
option) forwarding the same command line. target_aarch64_available()
then becomes:

   bool target_aarch64_available(void)
   {
     return option_32bit_only == false;
   }

