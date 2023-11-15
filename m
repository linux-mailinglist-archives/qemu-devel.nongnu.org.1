Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D60657EBAF0
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 02:33:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r34lK-00066N-9K; Tue, 14 Nov 2023 20:32:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r34lI-000661-T3
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 20:32:12 -0500
Received: from mail-il1-x12b.google.com ([2607:f8b0:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r34lF-0004va-MP
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 20:32:11 -0500
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-35aa6107e9fso18775005ab.0
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 17:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700011928; x=1700616728; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bnyM18GWbxTr2+1uLL36CuPQZ9ByvKq9AfsBxbpDY/A=;
 b=lDcQjsIQ3vVe5m4olwQctpSP677yU2GHH0I1cYcS+b64NLx1kgxioXNgboRGIWzjb0
 HCPnIXZiid/nwEVucdCp7YPiQs+rzSipy+Sl2QmIq2Ri3brbATkHPoflhuUv+K3tebef
 /8lBQ/hNzV6F2yF4gAeBtYPZ4VjKrkUSt3isVohZ7k1X43fkkEowXdJWx3XJKcXS5PZq
 Su7NcKZQk8crphFkm48ENcK+bhtntXtiamW1iLm67J2Kb2WnGWIk03bovRE9Rucif29a
 34Dxt3UKiNQ8kEqRow4toWZX3AGRStBg0MHpIkKnGDOYA+L7RK+Uu/BarPk9Pd2vuwsS
 doXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700011928; x=1700616728;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bnyM18GWbxTr2+1uLL36CuPQZ9ByvKq9AfsBxbpDY/A=;
 b=UEzObJsA/ZdI6rWF2/0c5K+3Jk4An2BE/PhFay+vHPCe9p8HHjXUfHoKGYhCBMorA8
 DfJ817eb/s9PDjm2Qr9TjzFi+/dcQfIThwgi22w1r/Z5wyn/OfJeXXgU+aVUaha57zJb
 0i4PIJXVaA0F8qIM9AQvzMUFdqRqC21fjYSyYU2CoZUXrv7SK7UEnIUMVATUGzKg76Oc
 QKIc5cemuvnfOpW7XhlPdGrwxMmDT5Z3XuC3cBq9yPZnzaMFkZDbNL9xI8pa62r72waf
 DqOuXlBIXI4tFPmwxn3NHz/vNb3lXhYLrZ1SlEPMBTrVy6NrzReLVEshVSoWFEb1oiFs
 MMIw==
X-Gm-Message-State: AOJu0YwyvFEUnbCcEWo4YNla310l0pi2itl/XO15ieIfG2WMULTPuab0
 jsxb1wlsyyrf147oH0uZSYP1qWdHFqh8Euxp1r0=
X-Google-Smtp-Source: AGHT+IG5PWrbSD6oMWVJrdbGuLjtHbGsBvCSDE5q7u3nnBMv5bVu345QQUvk5I3424La4DZhDW39XQ==
X-Received: by 2002:a05:6e02:18cf:b0:359:d24d:6274 with SMTP id
 s15-20020a056e0218cf00b00359d24d6274mr15956695ilu.0.1700011927915; 
 Tue, 14 Nov 2023 17:32:07 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 ff1-20020a056a002f4100b006a7083f9f6esm273108pfb.23.2023.11.14.17.32.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Nov 2023 17:32:07 -0800 (PST)
Message-ID: <84c136f2-73c0-417b-8513-ad9956ea631a@linaro.org>
Date: Tue, 14 Nov 2023 17:32:05 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 26/31] machine: Print CPU model name instead of CPU
 type name
Content-Language: en-US
To: Gavin Shan <gshan@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20231114235628.534334-1-gshan@redhat.com>
 <20231114235628.534334-27-gshan@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231114235628.534334-27-gshan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12b;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x12b.google.com
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

On 11/14/23 15:56, Gavin Shan wrote:
> The names of supported CPU models instead of CPU types should be
> printed when the user specified CPU type isn't supported, to be
> consistent with the output from '-cpu ?'.
> 
> Correct the error messages to print CPU model names instead of CPU
> type names.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>   hw/core/machine.c | 19 +++++++++++++++----
>   1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 49e0bc874d..58512b4b89 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -1392,6 +1392,7 @@ static void is_cpu_type_supported(MachineState *machine, Error **errp)
>       MachineClass *mc = MACHINE_GET_CLASS(machine);
>       ObjectClass *oc = object_class_by_name(machine->cpu_type);
>       CPUClass *cc;
> +    char *model;

Move to inner block.

> @@ -1408,11 +1409,21 @@ static void is_cpu_type_supported(MachineState *machine, Error **errp)
>   
>           /* The user specified CPU type isn't valid */
>           if (!mc->valid_cpu_types[i]) {
> -            error_setg(errp, "Invalid CPU type: %s", machine->cpu_type);
> -            error_append_hint(errp, "The valid types are: %s",
> -                              mc->valid_cpu_types[0]);
> +            model = cpu_model_from_type(machine->cpu_type);
> +            g_assert(model != NULL);
> +            error_setg(errp, "Invalid CPU type: %s", model);

I see no reason for these asserts -- printf of NULL will print "(nil)".
Aborting in the middle of error reporting won't be helpful.



r~

