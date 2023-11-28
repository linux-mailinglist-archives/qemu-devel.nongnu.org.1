Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C26D7FB668
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 10:57:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7uoh-0002gX-M7; Tue, 28 Nov 2023 04:55:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r7uog-0002gA-0U
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 04:55:42 -0500
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r7uoe-0005IY-35
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 04:55:41 -0500
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2c9b9191722so417761fa.1
 for <qemu-devel@nongnu.org>; Tue, 28 Nov 2023 01:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701165338; x=1701770138; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nxa3jYuPqiZHmE2B8TUKDEx3Z0xntheE02BxIoJ77yo=;
 b=utdlUNUmOTzYgjCv4YfmG7fPcF0rYnBpC3pUknzqYM7e3ynvYHFm0FDBiwXcIJskjp
 q0+qpcf32zhVawAXxrm+4ocrBSbWnJNBWqFaHCy9iDH2PBc+Co81r2VYFnlaSEYV/0L/
 2CvtwxCfNqune56FpRXSYTB924RCQghtSazTWIu9D8Hp8C4Zzybp4Icwei8tKdDpu7zd
 I7UsynD+bNn4dpNlgkSGHYlQ+XVHd3wJAjK368TcIudJGKNuBhsyn2e/QbaDxJKDSD4r
 S4BIC8nYK+1oLmuPDkzZTgDcfvasFXt0M4ClGI78WZVFRYuu9UdUX/ZYEOmGbbWDV1Z3
 HQ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701165338; x=1701770138;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nxa3jYuPqiZHmE2B8TUKDEx3Z0xntheE02BxIoJ77yo=;
 b=CwCzsusdZXmBtD/dDW43sdxKer3tNB4hL38DaGs/ObVuq/CtGIoexqzDlsFuUFJqlO
 jNuCqn1nfampweYAw8smtyNCj1l166klN2+jI8JWmAf7pm2u/JhgUSbX3LmY+FSQ4fmR
 LuLAuoLqneG7ykd4I4iXkyUmOAm0tBnsigGGX251MxhBs/p/gtYD1pVDy3iTNGyh0RHq
 i4EHStHGiECoBbYHp+Gv3Z54GGjfnJxWUiB59mYBafeNyPQtdOy4CeMHgFV5Tfi7A+34
 euN80Z1Mak4OaCm/Kp3Geuogt+T5IxA0oI51m7C9KkL+hcpeXYqSTNkP19oMf0XSDqBE
 w4dA==
X-Gm-Message-State: AOJu0YwZZ+/rD4G0uj0DotGXCKE7mVUJWGWqJUlK6wDnMIApT0ViwA1n
 VtRq/4n9gM0jzTnO7FFeWJUPXQ==
X-Google-Smtp-Source: AGHT+IH3WxE92HFdVREg7+BlJOeYiVJlL5QqeM1HhPm+Uxkv9bhXNivMT3JxZEaoOqZ/mWEiadxwyg==
X-Received: by 2002:a2e:a4cd:0:b0:2c9:986c:f1f3 with SMTP id
 p13-20020a2ea4cd000000b002c9986cf1f3mr6333501ljm.12.1701165338182; 
 Tue, 28 Nov 2023 01:55:38 -0800 (PST)
Received: from [192.168.69.100] (crb44-h02-176-184-13-61.dsl.sta.abo.bbox.fr.
 [176.184.13.61]) by smtp.gmail.com with ESMTPSA id
 ay12-20020a05600c1e0c00b0040588d85b3asm17637340wmb.15.2023.11.28.01.55.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Nov 2023 01:55:37 -0800 (PST)
Message-ID: <32bf41db-375b-4061-bbf3-17ae6b543926@linaro.org>
Date: Tue, 28 Nov 2023 10:55:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/8] machine: Print CPU model name instead of CPU type
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
 <20231126231210.112820-4-gshan@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231126231210.112820-4-gshan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x235.google.com
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
> The names of supported CPU models instead of CPU types should be
> printed when the user specified CPU type isn't supported, to be
> consistent with the output from '-cpu ?'.
> 
> Correct the error messages to print CPU model names instead of CPU
> type names.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>   hw/core/machine.c | 21 +++++++++++++++------
>   1 file changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 05e1922b89..898c25552a 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -1392,6 +1392,7 @@ static void is_cpu_type_supported(const MachineState *machine, Error **errp)
>       MachineClass *mc = MACHINE_GET_CLASS(machine);
>       ObjectClass *oc = object_class_by_name(machine->cpu_type);
>       CPUClass *cc;
> +    char *model;
>       int i;
>   
>       /*
> @@ -1408,17 +1409,25 @@ static void is_cpu_type_supported(const MachineState *machine, Error **errp)
>   
>           /* The user specified CPU type isn't valid */
>           if (!mc->valid_cpu_types[i]) {
> -            error_setg(errp, "Invalid CPU type: %s", machine->cpu_type);
> +            model = cpu_model_from_type(machine->cpu_type);
> +            g_assert(model != NULL);
> +            error_setg(errp, "Invalid CPU type: %s", model);
> +            g_free(model);

   g_autofree char *requested = cpu_model_from_type(machine->cpu_type);
   error_setg(errp, "Invalid CPU type: %s", requested);

> +
> +            model = cpu_model_from_type(mc->valid_cpu_types[0]);
> +            g_assert(model != NULL);
>               if (!mc->valid_cpu_types[1]) {
> -                error_append_hint(errp, "The only valid type is: %s",
> -                                  mc->valid_cpu_types[0]);
> +                error_append_hint(errp, "The only valid type is: %s", model);

   g_autofree char *model = cpu_model_from_type(mc->valid_cpu_types[0]);
   error_append_hint(errp, "The only valid type is: %s\n", model);

>               } else {
> -                error_append_hint(errp, "The valid types are: %s",
> -                                  mc->valid_cpu_types[0]);
> +                error_append_hint(errp, "The valid types are: %s", model);

Please move all the enumeration in this ladder, this makes the logic
simpler to follow:

   error_append_hint(errp, "The valid types are: ");
   for (i = 0; mc->valid_cpu_types[i]; i++) {
        g_autofree char *model =
                            cpu_model_from_type(mc->valid_cpu_types[i]);
        error_append_hint(errp, ", %s", model);
   }
   error_append_hint(errp, "\n");

>               }
> +            g_free(model);
>   
>               for (i = 1; mc->valid_cpu_types[i]; i++) {
> -                error_append_hint(errp, ", %s", mc->valid_cpu_types[i]);
> +                model = cpu_model_from_type(mc->valid_cpu_types[i]);
> +                g_assert(model != NULL);
> +                error_append_hint(errp, ", %s", model);
> +                g_free(model);
>               }
>   
>               error_append_hint(errp, "\n");


