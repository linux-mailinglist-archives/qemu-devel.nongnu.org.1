Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B33A382AB1D
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 10:40:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNrX8-0006yU-2i; Thu, 11 Jan 2024 04:39:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNrX5-0006xx-QQ
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 04:39:27 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNrX4-00041b-6J
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 04:39:27 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40e60e1373bso2573185e9.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 01:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704965964; x=1705570764; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VM0HKEU6ibKzztbyzuajNU6Ll6Gt8v2pcXKmTNWCX1k=;
 b=OcI7crp/UhnLVaz8f0IcSztTSKWwUG2pnK1d6CYtNPL5gN8PBeXnIJ+I2o9wG5qphZ
 Xz0Ud0pOX+uSn48gwkNIO/0212b6kvWXqT/3EUMM9KBXH6OtmAN2ihGdANUipkIyQ82H
 GzQGTUTSlSnrspqDrsO3LmWLNRm20Tcg9z8iPcQrT7J7ceeeVG2iH7DMHqzyYZSgpPUB
 t3vsTpbvr16MB2UGKpeJMI+8BtA/bd49Ghkz1YJ1zdl3GI8YanVxwCZMyhopkggznywm
 UeGaUIRPTEj4hIWzTAE2fWMy4yznrOlzbVqDFdcCz8MbZbiunvLC0QmVio81I9K0kW97
 Qn7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704965964; x=1705570764;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VM0HKEU6ibKzztbyzuajNU6Ll6Gt8v2pcXKmTNWCX1k=;
 b=vRFgkSxpSKxjphvK0KQTxx81UU4QXVcwt01r63pCOsTwmBSk+0F/0qy7xw7QcFF5le
 8hi8cnyAITGAeZwhk74g75Q5bDZDPkauwE2IkKmnstPk9uV86lVCLmjid8ez8MRQjACf
 9MkadxbqKvU2/bLJEkdxDWJg59I4mRLF8bHLzyGPzJ8jU6H4t7V7MyGR0gVU+XrJ/+Uf
 LwdKrJkO4nTxx5y2+/+gDTawiZAbq7l1Fnk19X/RWEhoKYyQBSf9g2XWZ4dEDHbR3Qas
 IfOTyO+yoo74Bucm8DkjjhU+77tOvUd59S1x8FsJq2NGN1cX92cCSAmhiCCBeNaaro9o
 PZvg==
X-Gm-Message-State: AOJu0Yy786jjVbfdmNvqYLkxq8jHfJWHIRGg0wLDwSDbLo2VP6i/h2r3
 UBv2HmzD5DJPHcZvMXZ6kZrY7Dr9YF40VRN/HcGiuAj6ARBoLQ==
X-Google-Smtp-Source: AGHT+IF2cYqLJHu2UWDuqXDpPX02gIFlgyGX3SyNXha60MpDNU7MZlWY/HBb1vrIX/f7CMfghaFVUw==
X-Received: by 2002:a05:600c:4693:b0:40e:5b66:f4dc with SMTP id
 p19-20020a05600c469300b0040e5b66f4dcmr213359wmo.7.1704965964029; 
 Thu, 11 Jan 2024 01:39:24 -0800 (PST)
Received: from [192.168.207.175] (83.red-88-28-3.dynamicip.rima-tde.net.
 [88.28.3.83]) by smtp.gmail.com with ESMTPSA id
 w18-20020a05600c475200b0040d2d33312csm1229961wmo.2.2024.01.11.01.39.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jan 2024 01:39:23 -0800 (PST)
Message-ID: <ff57e1f5-ea78-459e-b51c-48040483bdea@linaro.org>
Date: Thu, 11 Jan 2024 10:39:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/14] hw/arm: Prefer arm_feature(AARCH64) over
 object_property_find(aarch64)
Content-Language: en-US
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jones <ajones@ventanamicro.com>
Cc: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, qemu-arm@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>, Rob Herring <robh@kernel.org>,
 Markus Armbruster <armbru@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, Marc Zyngier <maz@kernel.org>
References: <20240110195329.3995-1-philmd@linaro.org>
 <20240110195329.3995-14-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240110195329.3995-14-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 10/1/24 20:53, Philippe Mathieu-Daudé wrote:
> The "aarch64" property is added to ARMCPU when the
> ARM_FEATURE_AARCH64 feature is available. Rather than
> checking whether the QOM property is present, directly
> check the feature.
> 
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/arm/virt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 49ed5309ff..a43e87874c 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -2140,7 +2140,7 @@ static void machvirt_init(MachineState *machine)
>           numa_cpu_pre_plug(&possible_cpus->cpus[cs->cpu_index], DEVICE(cpuobj),
>                             &error_fatal);
>   
> -        aarch64 &= object_property_get_bool(cpuobj, "aarch64", NULL);
> +        aarch64 &= arm_feature(cpu_env(cs), ARM_FEATURE_AARCH64);

So after this patch there are no more use of the ARMCPU "aarch64"
property from code. Still it is exposed via the qom-tree. Thus it
can be set (see aarch64_cpu_set_aarch64). I could understand one
flip this feature to create a custom CPU (as a big-LITTLE setup
as Marc mentioned on IRC), but I don't understand what is the
expected behavior when this is flipped at runtime. Can that
happen in real hardware (how could the guest react to that...)?

Thanks,

Phil.


