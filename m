Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1007E7DEC1E
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 06:07:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyPuq-0004xC-J6; Thu, 02 Nov 2023 01:06:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyPum-0004wy-Un
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 01:06:44 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyPul-0004YY-6D
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 01:06:44 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6c0f14d6875so581612b3a.1
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 22:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698901601; x=1699506401; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AC92wWOKghbgDppYWfDLM6i3S2Eqgf8Dve2oNIs0Mw0=;
 b=my35hCOfUXKMbqrzEfyK95t0RUqG9yp+aXLUb7CXCRSg+47dYrDw5ur23Qp/FwQTwp
 2lOlhu/innNEPaoLmG5LS/n7fMRHQ7R2PBj3Db9uDCYTG5mbkr9EFouAAAShdcqF5JkU
 o3rulTDeFlGK6NaGT0v8YZ8EH+d9MNVad19ysJnkUBakyBjZrg8YLpz6hyXn6ltFQNHu
 0MxieLXdX7vXVgvka/doC/IuHksGaiFu5TcWyNx/jEouOknybCRqs8GcgcpbgQ0qBeDU
 k60XbFmEMddzxAdnAudCVxvKh8NRFf3MjmsxAoEPTvbnyTQmp8+Yrs1F9CWjLvx54YOV
 83Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698901601; x=1699506401;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AC92wWOKghbgDppYWfDLM6i3S2Eqgf8Dve2oNIs0Mw0=;
 b=Jp1eb1Ox7i3RfDZPISW25uO5eww+phM+INhUpoih1ROQJAQPiPirmU3Eo35q7RU8Sc
 cne0XCXRqEuJUOU4AnzYWt7NXeB0r0ryANh2LLuGw89pv0yJhuDJlR9MrYbryfinG32r
 qibgxYlrfBkj+u/bTUqEeJppU4TV75KqyLbPj2/ikG3gU1fsLPoXzKnCpGUKdbv6bzmS
 k1qfh7HRd7DygKwQmR9dvWscwxxkXhCfock9FCgP7B3YOf3s4TcPs8ImPbRlbGEiwC41
 WFAlBscgDwVtv5/pyTZHcx+BdCqVOr3UuLQo7KF0L9aP6ArUas9MCs0HjwbKAI06sPae
 usCA==
X-Gm-Message-State: AOJu0Yzg3k+MuAUaGZ5zVQLL3o7Yf5zEkpSz2+OY4C2Jt0QBHaycCD+g
 PrEKXYWWsPRCddkZLLMI0proVtAqlf2xNwAS8C4=
X-Google-Smtp-Source: AGHT+IE6oBHHU+uHxi66B25csFNha3nGJJV0sgP1lJ6ecCeU36fLb+5GhJ0Xso/FG/vC4MnqevYGtg==
X-Received: by 2002:a05:6a21:7885:b0:172:eda5:36ea with SMTP id
 bf5-20020a056a21788500b00172eda536eamr18541854pzc.7.1698901601418; 
 Wed, 01 Nov 2023 22:06:41 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 ev13-20020a17090aeacd00b002809d2d90e3sm1581651pjb.8.2023.11.01.22.06.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Nov 2023 22:06:41 -0700 (PDT)
Message-ID: <9a9202ee-f609-4746-b400-7c99bfc078e1@linaro.org>
Date: Wed, 1 Nov 2023 22:06:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 28/33] machine: Print CPU model name instead of CPU
 type name
Content-Language: en-US
To: Gavin Shan <gshan@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20231102002500.1750692-1-gshan@redhat.com>
 <20231102002500.1750692-29-gshan@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231102002500.1750692-29-gshan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

On 11/1/23 17:24, Gavin Shan wrote:
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
> index 2d78692df1..1dd0f8831b 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -1391,6 +1391,7 @@ static void is_cpu_type_supported(MachineState *machine, Error **errp)
>       MachineClass *mc = MACHINE_GET_CLASS(machine);
>       ObjectClass *oc = object_class_by_name(machine->cpu_type);
>       CPUClass *cc;
> +    char *model;

No need for this outside...


>       int i;
>   
>       /*
> @@ -1407,11 +1408,21 @@ static void is_cpu_type_supported(MachineState *machine, Error **errp)
>   
>           /* The user specified CPU type isn't valid */
>           if (!mc->valid_cpu_types[i]) {

... this block.

> -            error_setg(errp, "Invalid CPU type: %s", machine->cpu_type);
> -            error_append_hint(errp, "The valid types are: %s",
> -                              mc->valid_cpu_types[0]);
> +            model = cpu_model_from_type(machine->cpu_type);
> +            g_assert(model != NULL);
> +            error_setg(errp, "Invalid CPU type: %s", model);
> +            g_free(model);
> +
> +            model = cpu_model_from_type(mc->valid_cpu_types[0]);
> +            g_assert(model != NULL);
> +            error_append_hint(errp, "The valid types are: %s", model);
> +            g_free(model);
> +
>               for (i = 1; mc->valid_cpu_types[i]; i++) {
> -                error_append_hint(errp, ", %s", mc->valid_cpu_types[i]);
> +                model = cpu_model_from_type(mc->valid_cpu_types[i]);
> +                g_assert(model != NULL);
> +                error_append_hint(errp, ", %s", model);
> +                g_free(model);
>               }

I really don't like all of the replicated asserts for non-null.

You already know there's no path through cpu_model_from_type that doesn't return 
something...  And anyway, in extremis, "(nil)" will print just fine.


r~

