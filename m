Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 729607FB5CD
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 10:30:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7uPU-0002vH-Ui; Tue, 28 Nov 2023 04:29:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r7uPS-0002tQ-T2
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 04:29:38 -0500
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r7uPO-0000hI-4S
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 04:29:38 -0500
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a00cbb83c82so743164166b.2
 for <qemu-devel@nongnu.org>; Tue, 28 Nov 2023 01:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701163772; x=1701768572; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=du8yRDrQyafQjmDYUSBdE7OyJ1dquNjYM+twJVYf+lA=;
 b=UIFejMT0raZE4kACA9ryh6IVJ5f3mpkwcxhX3KEhloX79HPKdtD53PdDJbveu78QYL
 Vc4WuZAROZ9b2m1Q+P51JN33qn/IotRz+gx3tKT8Xxt1Nkk9dVO/1VCYYaI3ErZDwNMI
 47tYmpfMxrt4eKwIomH0Q1A0YQ5JS/BpbpRTzIshuRe1Sr+/Dxei6dFBPQGnxLsqrYUN
 3zN8bvt+dMIF+0idcbzu/KYI0cKBgWvOF7wihkY0U0sjGBH+ubfuFRE4kvC5W+lJyykE
 Qqk2nabfQxUQE/gmuQaJpZB6VZ7Mlvt0G6ojyoiA8drg/AhwQ7Ub4D/psafZ6sBHwacm
 kcqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701163772; x=1701768572;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=du8yRDrQyafQjmDYUSBdE7OyJ1dquNjYM+twJVYf+lA=;
 b=oO2d+n6wnY5VMIPcbw9ZO5vOzYPu0+Xx/KtwOwkVqK5MsBp910oBKJPB9UAXaMUY3j
 IqxzwwKGl+D8bnJSX5celt2WklHhIJ1cN7q2SfgL3VfFVp81JKKrYdSFJlWHMX1nns2l
 pJLCb2pIx+r4v1bbdF8UvOCGnEft8CUWfeJSP5eNKaI2OBaL8fGbn4T6h6+k88+3jBZX
 +UnQC9K+s4peOqytap8/QPuYOAHbtUnkoB9XCP/9rDe/D+RO/jxtyJADjXTLXsUcHLKw
 5NEGGVxxyDlsBdd9zvM9QIYyIZFAUbIooZuyLiAn+/QgCd7+xjyw49rW+EJUUVWLTYmG
 q9qg==
X-Gm-Message-State: AOJu0YyKM/N2bE4YKghkoO2rCQHmBCC3xM+NOM9DGtL5Cta6xL5wDj0u
 VcMpuN/z4sA6UpPIPvdp9pHbTA==
X-Google-Smtp-Source: AGHT+IELN/RXpeeLeLQhIC5uKxQ7qTuGdRztTEibcNSv7OgUa45hfT7F+L3zZCxP7lP0zlysKxPCOg==
X-Received: by 2002:a17:906:99c7:b0:9ba:65e:7529 with SMTP id
 s7-20020a17090699c700b009ba065e7529mr13204547ejn.68.1701163772119; 
 Tue, 28 Nov 2023 01:29:32 -0800 (PST)
Received: from [192.168.69.100] (crb44-h02-176-184-13-61.dsl.sta.abo.bbox.fr.
 [176.184.13.61]) by smtp.gmail.com with ESMTPSA id
 bw24-20020a170906c1d800b009fc24437439sm6580993ejb.158.2023.11.28.01.29.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Nov 2023 01:29:31 -0800 (PST)
Message-ID: <f3bf354b-cf46-40d1-89b2-35bdd5074840@linaro.org>
Date: Tue, 28 Nov 2023 10:29:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/8] hw/arm/virt: Hide host CPU model for tcg
Content-Language: en-US
To: Gavin Shan <gshan@redhat.com>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, peter.maydell@linaro.org,
 imammedo@redhat.com, richard.henderson@linaro.org,
 quic_llindhol@quicinc.com, b.galvani@gmail.com,
 strahinja.p.jankovic@gmail.com, kfting@nuvoton.com, wuhaotsh@google.com,
 nieklinnenbank@gmail.com, rad@semihalf.com, marcin.juszkiewicz@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, wangyanan55@huawei.com,
 vijai@behindbytes.com, palmer@dabbelt.com, alistair.francis@wdc.com,
 bin.meng@windriver.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, shan.gavin@gmail.com
References: <20231126231210.112820-1-gshan@redhat.com>
 <20231126231210.112820-5-gshan@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231126231210.112820-5-gshan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 27/11/23 00:12, Gavin Shan wrote:
> The 'host' CPU model isn't available until KVM or HVF is enabled.
> For example, the following error messages are seen when the guest
> is started with option '-cpu cortex-a8' on tcg after the next commit
> is applied to check the CPU type in machine_run_board_init().
> 
>    ERROR:../hw/core/machine.c:1423:is_cpu_type_supported: \
>    assertion failed: (model != NULL)
>    Bail out! ERROR:../hw/core/machine.c:1423:is_cpu_type_supported: \
>    assertion failed: (model != NULL)
>    Aborted (core dumped)
> 
> Hide 'host' CPU model until KVM or HVF is enabled. With this applied,
> the valid CPU models can be shown.
> 
>    qemu-system-aarch64: Invalid CPU type: cortex-a8
>    The valid types are: cortex-a7, cortex-a15, cortex-a35, \
>    cortex-a55, cortex-a72, cortex-a76, cortex-a710, a64fx, \
>    neoverse-n1, neoverse-v1, neoverse-n2, cortex-a53,      \
>    cortex-a57, max
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   hw/arm/virt.c | 2 ++
>   1 file changed, 2 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


