Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DB77DEC18
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 06:02:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyPqa-0003V2-ES; Thu, 02 Nov 2023 01:02:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyPqY-0003Ut-Lq
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 01:02:22 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyPqX-0002MX-2a
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 01:02:22 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-5b9a456798eso372198a12.3
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 22:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698901338; x=1699506138; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0+lDlXeier9Bt5mIDW5NE0sYKGrYe1952vl2qSUQamc=;
 b=e92BMvmrZrP0G1KtKOUSe9uGLejV8/SpupZw2nLRxsCGGOFeBAZd05TXrsMGrZ6K7s
 M4BxHbDgjfnWRtiYN4Qc3C5h1NmgWOkn7u/8oKIRRUlNQXvrwhZ7xWp88r5HE0mRSimI
 o+vN9H9rpUKIgojPyjb7Fzo+Advwq62gauPWPGcsJ7twHWmc3QpXc7/dYvqhtGyxG/gy
 O8WhbW9gcttRXWaof3ZdY7qDisth+mR7Xat4PatjGrrqH0EouszXgjEm1Nm41BZDfTP4
 a2FY97JRnPsUTYuEgCgTBD/jiVc7GZ/JdZiAGouOxY7eKXm0Qhnm1RrLgLHs85caCslJ
 tstA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698901338; x=1699506138;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0+lDlXeier9Bt5mIDW5NE0sYKGrYe1952vl2qSUQamc=;
 b=w2VNIZJXrc+KDUYIfUGgKVz3gd2WJso1LXEHLr5BRKubGt2ce7jeG9Xf/LXeIFg+T7
 jykqRLpKlZcfbk/V82Xdm4j3rHIgyRtpLOkay/3c+/97QhUAt0TMy3ACy9PSTSyq+ER/
 1PloTw4JJTU90NEDx4LJyx162RvEEMIf8exUlkERrLiG/mCe/Ij4/60phdxBypJI+C7f
 FxbW9fMh8PTmAb+K0FkkjJmv+kkh/ZZbjeoPeY3Kw9Gb/eO9GxlBxQjq3gwWnMjc7xei
 nADm1R+Pp7ECL6E3Ivyi/aCQCSdQZBu2EfBgxc/DamKaVxyxkGu2m8mIXmGHen5sX36v
 sBiw==
X-Gm-Message-State: AOJu0Yy1WoN4QRtX77oA1GLBG60f5nLz4bLWWBFOQKT4aJqNRqz+1Pir
 boHNriVyRlzld7yO9g5k3d+Yfw==
X-Google-Smtp-Source: AGHT+IENen5NXxJ62k9wHHZGwusHxAhTxLzMXX6VV7U8EGLm1XdrJUpxmjtSP8WN03qfErs7wFyMGg==
X-Received: by 2002:a05:6a20:4c05:b0:171:8e16:ea83 with SMTP id
 fm5-20020a056a204c0500b001718e16ea83mr13461920pzb.29.1698901338479; 
 Wed, 01 Nov 2023 22:02:18 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 t5-20020a1709028c8500b001c5076ae6absm2075351plo.126.2023.11.01.22.02.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Nov 2023 22:02:18 -0700 (PDT)
Message-ID: <5003c041-0edc-4031-a9f7-0f14c9fa1105@linaro.org>
Date: Wed, 1 Nov 2023 22:02:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 27/33] machine: Introduce helper is_cpu_type_supported()
Content-Language: en-US
To: Gavin Shan <gshan@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20231102002500.1750692-1-gshan@redhat.com>
 <20231102002500.1750692-28-gshan@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231102002500.1750692-28-gshan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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
> The logic, to check if the specified CPU type is supported in
> machine_run_board_init(), is independent enough. Factor it out into
> helper is_cpu_type_supported(). machine_run_board_init() looks a bit
> clean with this. Since we're here, @machine_class is renamed to @mc
> to avoid multiple line spanning of code. The comments are tweaked a
> bit either.
> 
> No functional change intended.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>   hw/core/machine.c | 82 +++++++++++++++++++++++++----------------------
>   1 file changed, 44 insertions(+), 38 deletions(-)
> 
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 1c17a0d5bf..2d78692df1 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -1386,13 +1386,51 @@ out:
>       return r;
>   }
>   
> +static void is_cpu_type_supported(MachineState *machine, Error **errp)
> +{
> +    MachineClass *mc = MACHINE_GET_CLASS(machine);
> +    ObjectClass *oc = object_class_by_name(machine->cpu_type);

machine->cpu_type is used...

> +    CPUClass *cc;
> +    int i;
> +
> +    /*
> +     * Check if the user specified CPU type is supported when the valid
> +     * CPU types have been determined. Note that the user specified CPU
> +     * type is provided through '-cpu' option.
> +     */
> +    if (mc->valid_cpu_types && machine->cpu_type) {

... before checking that it is set.

> +        for (i = 0; mc->valid_cpu_types[i]; i++) {
> +            if (object_class_dynamic_cast(oc, mc->valid_cpu_types[i])) {
> +                break;
> +            }
> +        }
> +
> +        /* The user specified CPU type isn't valid */
> +        if (!mc->valid_cpu_types[i]) {
> +            error_setg(errp, "Invalid CPU type: %s", machine->cpu_type);
> +            error_append_hint(errp, "The valid types are: %s",
> +                              mc->valid_cpu_types[0]);
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

... and here you've not even checked that oc resolved correctly.

> +    if (cc && cc->deprecation_note) {

I guess you're assuming that CPU_CLASS is a plain cast, so this second check filters NULL.


r~

