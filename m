Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B8F7EDC47
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 08:49:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3X4e-0006yb-EC; Thu, 16 Nov 2023 02:46:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3X42-00062P-D3
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 02:45:28 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3X3w-0005TU-Q0
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 02:45:22 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-32f7bd27c2aso385235f8f.2
 for <qemu-devel@nongnu.org>; Wed, 15 Nov 2023 23:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700120719; x=1700725519; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tv2yZRN74eHZMwdWLD7mpGdkg8iOa25VpknKxAN5VM0=;
 b=uaNdUdNDRb3+xwHGGYivt99BPgGRDi7vAD+vQY21Fs7A+qVUvb7p7wdIqj7WG+lzcz
 N4ffAiygmkWFve4iRyaMLvgcogeJJ9qaHmBlGz54c/1MDjFVvS2eXl9N2YvIbSAUtC+K
 kIRqLxwnxMiwQxOhiaZkqvAdtG6dCFSosynKxXku4lpf5QmtZP78K8KGnf/MsygO08IN
 UXnFJ5IyvKHNLkh07bJqrO0ZDhRFNyT0JFVKkEq8izzNplriWbfuDpGDDeXPhnGcP4Pn
 v4+8zfvZdgPy9RxGiGUJR9dSS9KGGIHOlwIF+1UqDl4YCRO2nn/XFd4adDX+5IJHNHci
 mMlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700120719; x=1700725519;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tv2yZRN74eHZMwdWLD7mpGdkg8iOa25VpknKxAN5VM0=;
 b=uLwtsFovvC2EXBMgh0hPtg4dgNDynea7v1stbQKpZC8IC5kPW57GmNdQZyQT4VjKhD
 H4MxKflN5YaJqEm/eyYNDlhSQ/ddcKbOwUEnoFfCQc2ReYYzi48A/6e40Lkn1bttotoO
 MeHoTAm7RITEFoBUH5Y6VHvmShtTgxwt5m2WgylPlvh/u4+JZ+grwYzYCgfvoyltgqd2
 kLPjbKgdg4sLpovuYij9dlSfauIGqMtTl/SvrXFK0ZJAsKSRzTGc45Td1nNC+mNASsds
 g1NuLXRV8+ucs2JZdtrWKfYHf7Kr2MOJ9CSE7blXtBAMom7qxYdJO1XxDRK7pqp4dy6m
 4z/g==
X-Gm-Message-State: AOJu0Yz7GleISs93S+E7lNiaVqXaELqVTcvZuhPaK3a9urn++bkR+nus
 ve+MlSjaARaAIUyCLRYDHRXrqw==
X-Google-Smtp-Source: AGHT+IHjjQOz8/YDGl6c9LklZrnm69xKtDhgje+Uu2XOz/gRL8mmUcQXzyXVcISatmB07bEVJoAcJw==
X-Received: by 2002:a05:6000:1acd:b0:32f:79de:8b7f with SMTP id
 i13-20020a0560001acd00b0032f79de8b7fmr12585796wry.49.1700120719153; 
 Wed, 15 Nov 2023 23:45:19 -0800 (PST)
Received: from [192.168.69.100] ([176.187.220.205])
 by smtp.gmail.com with ESMTPSA id
 i7-20020adffc07000000b0032dcb08bf94sm12707034wrr.60.2023.11.15.23.45.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Nov 2023 23:45:18 -0800 (PST)
Message-ID: <e54701c3-bbcc-42d4-b3ae-13b298fac62c@linaro.org>
Date: Thu, 16 Nov 2023 08:45:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/31] cpu: Add helper cpu_model_from_type()
Content-Language: en-US
To: Gavin Shan <gshan@redhat.com>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 imp@bsdimp.com, kevans@freebsd.org, richard.henderson@linaro.org,
 pbonzini@redhat.com, peter.maydell@linaro.org, imammedo@redhat.com,
 b.galvani@gmail.com, strahinja.p.jankovic@gmail.com, sundeep.lkml@gmail.com,
 kfting@nuvoton.com, wuhaotsh@google.com, nieklinnenbank@gmail.com,
 rad@semihalf.com, quic_llindhol@quicinc.com, marcin.juszkiewicz@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, wangyanan55@huawei.com,
 laurent@vivier.eu, vijai@behindbytes.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, mrolnik@gmail.com,
 edgar.iglesias@gmail.com, bcain@quicinc.com, gaosong@loongson.cn,
 aurelien@aurel32.net, jiaxun.yang@flygoat.com, aleksandar.rikalo@syrmia.com,
 chenhuacai@kernel.org, shorne@gmail.com, npiggin@gmail.com, clg@kaod.org,
 ysato@users.sourceforge.jp, kbastian@mail.uni-paderborn.de,
 jcmvbkbc@gmail.com, shan.gavin@gmail.com
References: <20231114235628.534334-1-gshan@redhat.com>
 <20231114235628.534334-6-gshan@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231114235628.534334-6-gshan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

On 15/11/23 00:56, Gavin Shan wrote:
> Add helper cpu_model_from_type() to extract the CPU model name from
> the CPU type name in two circumstances: (1) The CPU type name is the
> combination of the CPU model name and suffix. (2) The CPU type name
> is same to the CPU model name.
> 
> The helper will be used in the subsequent commits to conver the
> CPU type name to the CPU model name.
> 
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>   cpu-target.c          | 15 +++++++++++++++
>   include/hw/core/cpu.h | 12 ++++++++++++
>   2 files changed, 27 insertions(+)


> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index c0c8320413..57ceb46bc1 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -779,6 +779,18 @@ void cpu_reset(CPUState *cpu);
>    */
>   ObjectClass *cpu_class_by_name(const char *typename, const char *cpu_model);
>   
> +/**
> + * cpu_model_from_type:
> + * @typename: The CPU type name
> + *
> + * Extract the CPU model name from the CPU type name. The
> + * CPU type name is either the combination of the CPU model
> + * name and suffix, or same to the CPU model name.
> + *
> + * Returns: CPU model name or NULL if the CPU class doesn't exist

Worth adding:

     *          The user should g_free() the string once no longer
     *          needed.

> + */


Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


