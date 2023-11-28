Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C230F7FB60A
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 10:40:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7uY7-0007Tr-Lz; Tue, 28 Nov 2023 04:38:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r7uY5-0007Sm-B3
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 04:38:33 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r7uY2-0002HX-Ai
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 04:38:33 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a011e9bf336so717266566b.3
 for <qemu-devel@nongnu.org>; Tue, 28 Nov 2023 01:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701164308; x=1701769108; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ntZh4VUyoyATGSlDTwaEMS64+Qw/HW3Uvdla6A8b9/Y=;
 b=VFUvULtMe9A/YoEIDkbseppvG/wRtLhDqELVEQuLIxmlcmPTMxMkyD0SxwwcUW84aS
 XYdfs+tgwawNkW6ocoLSuAewc6ytt8v5tDM39eeeuJlcS8P5IzKqdnmAmKFM/aN5xWQS
 7tuV0Yqrw79drsRoiuqDJb3VpLAOGqVGMZshGx2MvMOVpRfPd+tauv3pwIJByH2eQ9tv
 9IHPStIHowcNO42fY7lG0ZPc2kQ7VKfFUh8jKWGAoo2GfbMlWAbsKbEvdu8MwhdqQahA
 jOTbZDOfVEvoVtTqlg0gboEzRaysEb4YGjpepmLfpwwHXhmzPLHwQIDfCAJvHNl3R/41
 IRcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701164308; x=1701769108;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ntZh4VUyoyATGSlDTwaEMS64+Qw/HW3Uvdla6A8b9/Y=;
 b=hR9+e8wZWjLL1A1a/uFKbCvrzfi6Ts4PwkGjzQTJMKrsaBAT3ZbkFhU9ODK26fu+7p
 wr56dIhsSUMWJUzmdaVU+ADtlIuFkPNJaOPFgkB+hjB8kB2Zd0lkJfCAZiUU4UyP9t7O
 rUKm+F0c/iazudgnYZoHjcMV7lggaY6tvUCGysX69vvDoAThp9lKQ4RtUucCt/+r2HKf
 7z/apyOlXNKg2slneccOtBzpuHtJivk39zAKaAJMMdtmLhwBqWRypiR4FNXsEz32KriW
 qU1/IjRHw/jyZ14k3Dyf7mEUvRUf/QhReWLPyV2hgJf1EMDz4763kyhOr4qcvx9aY7VY
 vOhw==
X-Gm-Message-State: AOJu0Ywx3rNrxz6YRZmy6TFL2gcNHhi2xnePtZzd4ck4Aj3S5keO4s6u
 OMoVd2eIlFkBvxEl+ccwgL7jQw==
X-Google-Smtp-Source: AGHT+IEupKFHyDb3vonl8zQ5x7VZNO5h1YI/CxeUi/9nNcOR18H4ZHYQ0KB7OG1aM4W2hJ5Abp8OZg==
X-Received: by 2002:a17:906:348c:b0:9e7:133a:5787 with SMTP id
 g12-20020a170906348c00b009e7133a5787mr9700088ejb.38.1701164308594; 
 Tue, 28 Nov 2023 01:38:28 -0800 (PST)
Received: from [192.168.69.100] (crb44-h02-176-184-13-61.dsl.sta.abo.bbox.fr.
 [176.184.13.61]) by smtp.gmail.com with ESMTPSA id
 gg6-20020a170906e28600b00a090b36d618sm5418130ejb.60.2023.11.28.01.38.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Nov 2023 01:38:28 -0800 (PST)
Message-ID: <c3e8f22b-c03e-4803-a960-699489afb92b@linaro.org>
Date: Tue, 28 Nov 2023 10:38:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/8] machine: Introduce helper is_cpu_type_supported()
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
 <20231126231210.112820-3-gshan@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231126231210.112820-3-gshan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
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

Hi Gavin,

On 27/11/23 00:12, Gavin Shan wrote:
> The logic, to check if the specified CPU type is supported in
> machine_run_board_init(), is independent enough. Factor it out into
> helper is_cpu_type_supported(). machine_run_board_init() looks a bit
> clean with this. Since we're here, @machine_class is renamed to @mc
> to avoid multiple line spanning of code. The error messages and comments
> are tweaked a bit either.
> 
> No functional change intended.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>   hw/core/machine.c | 90 +++++++++++++++++++++++++++--------------------
>   1 file changed, 51 insertions(+), 39 deletions(-)
> 
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index b3ef325936..05e1922b89 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -1387,13 +1387,57 @@ out:
>       return r;
>   }
>   
> +static void is_cpu_type_supported(const MachineState *machine, Error **errp)

Functions taking an Error** last argument should return a boolean value.

> +{
> +    MachineClass *mc = MACHINE_GET_CLASS(machine);
> +    ObjectClass *oc = object_class_by_name(machine->cpu_type);
> +    CPUClass *cc;
> +    int i;
> +
> +    /*
> +     * Check if the user specified CPU type is supported when the valid
> +     * CPU types have been determined. Note that the user specified CPU
> +     * type is provided through '-cpu' option.
> +     */
> +    if (mc->valid_cpu_types && machine->cpu_type) {
> +        for (i = 0; mc->valid_cpu_types[i]; i++) {
> +            if (object_class_dynamic_cast(oc, mc->valid_cpu_types[i])) {
> +                break;
> +            }
> +        }
> +
> +        /* The user specified CPU type isn't valid */
> +        if (!mc->valid_cpu_types[i]) {
> +            error_setg(errp, "Invalid CPU type: %s", machine->cpu_type);
> +            if (!mc->valid_cpu_types[1]) {
> +                error_append_hint(errp, "The only valid type is: %s",
> +                                  mc->valid_cpu_types[0]);
> +            } else {
> +                error_append_hint(errp, "The valid types are: %s",
> +                                  mc->valid_cpu_types[0]);
> +            }
> +
> +            for (i = 1; mc->valid_cpu_types[i]; i++) {
> +                error_append_hint(errp, ", %s", mc->valid_cpu_types[i]);
> +            }
> +
> +            error_append_hint(errp, "\n");
> +            return;
> +        }
> +    }
> +
> +    /* Check if CPU type is deprecated and warn if so */
> +    cc = CPU_CLASS(oc);
> +    if (cc && cc->deprecation_note) {
> +        warn_report("CPU model %s is deprecated -- %s",
> +                    machine->cpu_type, cc->deprecation_note);

Why did you move the deprecation warning within the is_supported check?

> +    }
> +}
>   
>   void machine_run_board_init(MachineState *machine, const char *mem_path, Error **errp)
>   {
>       ERRP_GUARD();
>       MachineClass *machine_class = MACHINE_GET_CLASS(machine);
> -    ObjectClass *oc = object_class_by_name(machine->cpu_type);
> -    CPUClass *cc;
>       Error *local_err = NULL;
>   
>       /* This checkpoint is required by replay to separate prior clock
> @@ -1449,43 +1493,11 @@ void machine_run_board_init(MachineState *machine, const char *mem_path, Error *
>           machine->ram = machine_consume_memdev(machine, machine->memdev);
>       }
>   
> -    /* If the machine supports the valid_cpu_types check and the user
> -     * specified a CPU with -cpu check here that the user CPU is supported.
> -     */
> -    if (machine_class->valid_cpu_types && machine->cpu_type) {
> -        int i;
> -
> -        for (i = 0; machine_class->valid_cpu_types[i]; i++) {
> -            if (object_class_dynamic_cast(oc,
> -                                          machine_class->valid_cpu_types[i])) {
> -                /* The user specified CPU is in the valid field, we are
> -                 * good to go.
> -                 */
> -                break;
> -            }
> -        }
> -
> -        if (!machine_class->valid_cpu_types[i]) {
> -            /* The user specified CPU is not valid */
> -            error_setg(&local_err, "Invalid CPU type: %s", machine->cpu_type);
> -            error_append_hint(&local_err, "The valid types are: %s",
> -                              machine_class->valid_cpu_types[0]);
> -            for (i = 1; machine_class->valid_cpu_types[i]; i++) {
> -                error_append_hint(&local_err, ", %s",
> -                                  machine_class->valid_cpu_types[i]);
> -            }
> -            error_append_hint(&local_err, "\n");
> -
> -            error_propagate(errp, local_err);
> -            return;
> -        }
> -    }
> -
> -    /* Check if CPU type is deprecated and warn if so */
> -    cc = CPU_CLASS(oc);
> -    if (cc && cc->deprecation_note) {
> -        warn_report("CPU model %s is deprecated -- %s", machine->cpu_type,
> -                    cc->deprecation_note);
> +    /* Check if the CPU type is supported */
> +    is_cpu_type_supported(machine, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);

This becomes:

        if (!is_cpu_type_supported(machine, errp)) {

> +        return;
>       }
>   
>       if (machine->cgs) {


