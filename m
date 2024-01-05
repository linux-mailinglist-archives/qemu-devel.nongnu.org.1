Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F56825288
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 12:02:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLhwM-0004pR-Rv; Fri, 05 Jan 2024 06:00:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLhw8-0004on-3i
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 06:00:25 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLhw6-0004yY-6V
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 06:00:23 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5572a9b3420so801109a12.1
 for <qemu-devel@nongnu.org>; Fri, 05 Jan 2024 03:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704452420; x=1705057220; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2oQ8RmKNSwUYagdexe6ijrxEbemFp9CmA2w04t1AZZg=;
 b=Fa7ulPCj4jV8V51Tc3/gUyHzmNTISOk22BVxttN35FfmpVNEpI4zFnlBX4g5qKbSf3
 FcqNzRee1JcPcq34Xqz3XrD8IUnEjyk3Lh5ohRVyUg52K2tG4xCSwhtXwEEx/bJxKd05
 SrcR7AKj48Z0D/CvgqaH5fFnAR+SISo1VWVZticev5lQiggPogGjCpTG+G8fMB8EjQp0
 4tNwh1zMDa82sW9b06VlEh9XJF63EyD1qHaVPq3k/Tz43JuEYvGM63g3BGUQ2iumwZ9v
 gWV26jC429s+5tM1vAwopbOgPkzaxuih+ikD3xGDa0jkFMyZHNWj5uL+Jl69j0hUAQQP
 c/wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704452420; x=1705057220;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2oQ8RmKNSwUYagdexe6ijrxEbemFp9CmA2w04t1AZZg=;
 b=dSKbH+fdjkPM7WcExBSaKjVhGSfbs24Oick3bDWJHFhO1iOig3T94YIlRxkxhlQP4p
 5QqUOaTo759dumKqwocn/2NGBFP9dH55kxeLHG2YB1bMgnEeWeGHuN6Tj4ZD+w+hU376
 xDP9MeBG5X4/4tc/hjZ1uN7QvUxaN2nu7UiowMlVrTQB/bu0obbkWhsXrZclWY4OFtkR
 e/wUbgcuwMvg/N8B8tv9f9C0VkzBU/+//KForG78963/zgiLwYa6ipSCzYyMeIeBnBO7
 E/eW/bkATabJONu+LNJvJ5DSYqFQcg51YVJjGvbkk4eqVMSsrvmFFm1swblg0bn4489C
 BFAw==
X-Gm-Message-State: AOJu0Yy3xz0zgRnlAekupEY3OHXCbdnx6VmFNrhIQ4nGBKEAZEBHDQO4
 NNoOgeg6tH8fRIiFMPFuTiMCBRPsPYTX0A==
X-Google-Smtp-Source: AGHT+IHGXvSOgWuk2Rpu3bq4NXExCyNRQZBWEUQOfkpdbQfFG5G7NZpcy48gMhZS8I3K1CUpBva/PA==
X-Received: by 2002:a17:907:bb93:b0:a28:abfa:e405 with SMTP id
 xo19-20020a170907bb9300b00a28abfae405mr1912612ejc.58.1704452420161; 
 Fri, 05 Jan 2024 03:00:20 -0800 (PST)
Received: from [192.168.69.100] (juv34-h02-176-184-26-1.dsl.sta.abo.bbox.fr.
 [176.184.26.1]) by smtp.gmail.com with ESMTPSA id
 oz39-20020a170906cd2700b00a1f7ab65d3fsm751363ejb.131.2024.01.05.03.00.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Jan 2024 03:00:19 -0800 (PST)
Message-ID: <0bbd5bff-2f38-4625-9e0b-12245f512c01@linaro.org>
Date: Fri, 5 Jan 2024 12:00:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 1/9] machine: Use error handling when CPU type is
 checked
Content-Language: en-US
To: Gavin Shan <gshan@redhat.com>, armbru@redhat.com
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, peter.maydell@linaro.org,
 b.galvani@gmail.com, strahinja.p.jankovic@gmail.com, imammedo@redhat.com,
 kfting@nuvoton.com, wuhaotsh@google.com, nieklinnenbank@gmail.com,
 rad@semihalf.com, quic_llindhol@quicinc.com, marcin.juszkiewicz@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, wangyanan55@huawei.com,
 vijai@behindbytes.com, palmer@dabbelt.com, alistair.francis@wdc.com,
 bin.meng@windriver.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, shan.gavin@gmail.com, qemu-arm@nongnu.org
References: <20231204004726.483558-1-gshan@redhat.com>
 <20231204004726.483558-2-gshan@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231204004726.483558-2-gshan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x529.google.com
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

On 4/12/23 01:47, Gavin Shan wrote:
> Functions that use an Error **errp parameter to return errors should
> not also report them to the user, because reporting is the caller's
> job. The principle is violated by machine_run_board_init() because
> it calls error_report(), error_printf(), and exit(1) when the machine
> doesn't support the requested CPU type.
> 
> Clean this up by using error_setg() and error_append_hint() instead.
> No functional change, as the only caller passes &error_fatal.
> 
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> ---
> v9: Improved change log                                  (Markus)
> ---
>   hw/core/machine.c | 13 +++++++------
>   1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 0c17398141..bde7f4af6d 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -1466,15 +1466,16 @@ void machine_run_board_init(MachineState *machine, const char *mem_path, Error *
>   
>           if (!machine_class->valid_cpu_types[i]) {
>               /* The user specified CPU is not valid */
> -            error_report("Invalid CPU type: %s", machine->cpu_type);
> -            error_printf("The valid types are: %s",
> -                         machine_class->valid_cpu_types[0]);
> +            error_setg(errp, "Invalid CPU type: %s", machine->cpu_type);
> +            error_append_hint(errp, "The valid types are: %s",
> +                              machine_class->valid_cpu_types[0]);
>               for (i = 1; machine_class->valid_cpu_types[i]; i++) {
> -                error_printf(", %s", machine_class->valid_cpu_types[i]);
> +                error_append_hint(errp, ", %s",
> +                                  machine_class->valid_cpu_types[i]);
>               }
> -            error_printf("\n");
>   
> -            exit(1);
> +            error_append_hint(&errp, "\n");

This doesn't build:

hw/core/machine.c:1488:31: error: incompatible pointer types passing 
'Error ***' (aka 'struct Error ***') to parameter of type 'Error *const 
*' (aka 'struct Error *const *'); remove & 
[-Werror,-Wincompatible-pointer-types]
             error_append_hint(&errp, "\n");
                               ^~~~~

> +            return;
>           }
>       }
>   

Squashing:
-- >8 --
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 021044aaaf..1898d1d1d7 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -1487,3 +1487,3 @@ void machine_run_board_init(MachineState *machine, 
const char *mem_path, Error *

-            error_append_hint(&errp, "\n");
+            error_append_hint(errp, "\n");
              return;
---

