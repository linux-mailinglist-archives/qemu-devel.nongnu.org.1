Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E599C7EBAE4
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 02:23:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r34bS-0003Lu-FL; Tue, 14 Nov 2023 20:22:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r34bP-0003LX-Et
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 20:21:59 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r34bM-0002Hd-N8
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 20:21:59 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1cc938f9612so41876045ad.1
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 17:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700011315; x=1700616115; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vqldNi8W5ZSQmOmTP2mhZHk7Y/Imm7kkD5lpahgqx8A=;
 b=Dmne5vvurN8qNa61hOGzMdRz7aJiYkwm4QZDFFEjda9yan3PCrI8MsfQql5Kbjso0M
 SJqIquKA276NtG6zaZaoOVBcKZdF0x+/2ortS5SS/xkNw+c5hc6cb8Nphr6kCdd2ZaHI
 pivcTuvIXKOsg2iHXQgCEcCddQQsNMJfSCbZM0XzVdXoHpT4EDn1g9D8zgvJplIm41Fx
 WpcOEmO3ClDo7ju0tSqk02CY/CjDm7im8Iv8BV5UueB1Fbwo9M82z9mVJatBhezJro6B
 4cjvgbdyj32Zf2vtSjeH+E46kqFyzu1vPwoN21FCUV4SQSIQyzjyyLQ0kMeXtBddzx5y
 nV1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700011315; x=1700616115;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vqldNi8W5ZSQmOmTP2mhZHk7Y/Imm7kkD5lpahgqx8A=;
 b=lgXSBNpqtXOQ3+lJqiinoi04jYgOYiMJ1NC5IyvrXUs5rOQ2EoYUQEMV6hrJIVxdLJ
 BSRl9Yzcv/uumfh1MLid4WsYidKJ6SX6daZIGn6T3DHkoR4UYBEsDw8MyiOWOXMhZIaU
 YqOqf53k6opLVJOWhCWNNVzVcFVm2Zq7Tj3e6yDr4LLYNvulDqjO5gtsB9vINJ+Uzr17
 dvlfgrGtzhUcAmifABYZsXq+G5o16c6OefE3esD/ylWYhC5PDd9pa6Hb7+Vuch4k12EK
 7ywZYPaMH8T5fgfQCtD/g4dC5Cbv9yyrDke77aWLme61HgRxx3S2QJouKXCamDmHr2kY
 Jywg==
X-Gm-Message-State: AOJu0YwNgCLPGQHag/3ZcByk3UBOGViXzXaaszPF4TuaR3OLOYM4KiNV
 k+PBGbh9gQKKPapQS/BWS4GXLA==
X-Google-Smtp-Source: AGHT+IHoO87omWwIy+TeDSDYiG/13VIMP6eoXPFnzUj2sxJGO/rqoKjT7seD3e+rAMe41Pxe7mMmkA==
X-Received: by 2002:a17:902:d4c9:b0:1cc:53ed:cc78 with SMTP id
 o9-20020a170902d4c900b001cc53edcc78mr4589071plg.15.1700011315021; 
 Tue, 14 Nov 2023 17:21:55 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 y12-20020a170902ed4c00b001c9ba6c7287sm6319695plb.143.2023.11.14.17.21.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Nov 2023 17:21:54 -0800 (PST)
Message-ID: <e954760c-aca8-427b-a286-2c57bd7609a7@linaro.org>
Date: Tue, 14 Nov 2023 17:21:53 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 24/31] machine: Use error handling when CPU type is
 checked
Content-Language: en-US
To: Gavin Shan <gshan@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20231114235628.534334-1-gshan@redhat.com>
 <20231114235628.534334-25-gshan@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231114235628.534334-25-gshan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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
> QEMU will be terminated if the specified CPU type isn't supported
> in machine_run_board_init(). The list of supported CPU type names
> is tracked by mc->valid_cpu_types.
> 
> The error handling can be used to propagate error messages, to be
> consistent how the errors are handled for other situations in the
> same function.
> 
> No functional change intended.
> 
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>   hw/core/machine.c | 14 ++++++++------
>   1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 0c17398141..5b45dbbbd5 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -1394,6 +1394,7 @@ void machine_run_board_init(MachineState *machine, const char *mem_path, Error *
>       MachineClass *machine_class = MACHINE_GET_CLASS(machine);
>       ObjectClass *oc = object_class_by_name(machine->cpu_type);
>       CPUClass *cc;
> +    Error *local_err = NULL;


There is no need for local_error; just use errp throughout.

With that,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

>           if (!machine_class->valid_cpu_types[i]) {
>               /* The user specified CPU is not valid */
> -            error_report("Invalid CPU type: %s", machine->cpu_type);
> -            error_printf("The valid types are: %s",
> -                         machine_class->valid_cpu_types[0]);
> +            error_setg(&local_err, "Invalid CPU type: %s", machine->cpu_type);
> +            error_append_hint(&local_err, "The valid types are: %s",
> +                              machine_class->valid_cpu_types[0]);
>               for (i = 1; machine_class->valid_cpu_types[i]; i++) {
> -                error_printf(", %s", machine_class->valid_cpu_types[i]);
> +                error_append_hint(&local_err, ", %s",
> +                                  machine_class->valid_cpu_types[i]);
>               }
> -            error_printf("\n");
> +            error_append_hint(&local_err, "\n");
>   
> -            exit(1);
> +            error_propagate(errp, local_err);
>           }
>       }
>   


