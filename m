Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 029D67188B0
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 19:44:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4PrJ-0001Kl-0l; Wed, 31 May 2023 13:43:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4PrF-0001KG-Dy
 for qemu-devel@nongnu.org; Wed, 31 May 2023 13:43:38 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4PrD-0004HQ-Ap
 for qemu-devel@nongnu.org; Wed, 31 May 2023 13:43:36 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-30b023b0068so25637f8f.0
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 10:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685555013; x=1688147013;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CO2Kxj0x6pMj+0gW1b+xk5neti5EyFtccsK7Kw/B6hk=;
 b=sP5qK5MAkniQrREQJiGbEaN0GJ4uF/HGfbhCx5FDDl/NhVgztdAlWCMzOjDq0iu3nw
 zAg1bDCRsAEdXw2YKcFH2/5IH+fYOxEfwv7EgsR7w70R5F+2EFBNO0L4y0/GgRoASW7F
 3UcfVvqRJo/outGw5sXkjR5M+NCDZfo0e08SB9Bu9UH8DZkpA1mIjybNq7gskJb63N9N
 8Vv2Y+Ab8cVgF4F1YDY6jliBGg6M4QFrn09NRf5dnBKB6fNkntWOpTPYK5VSYRiv4qG5
 bmM83RQ4fVKhDeI5RVJBKAYhCsBtiP9ZAUFJQjIdtCzmR56RG/CFFMvEv7eRTANVshlK
 octw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685555013; x=1688147013;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CO2Kxj0x6pMj+0gW1b+xk5neti5EyFtccsK7Kw/B6hk=;
 b=cgm/v77PLuuXqWDaKdG1jp+0GuGcjJug+h2qgfZsx9RQWD+TIq1smQMbfpDx8xoWDA
 0vOkOBsObcCyPuMfGXHKdKT1bg13+5+0TPbIQjpstPjE+ZdSGQLquF0kNmbU9JoKkFdz
 4hsxO7qolTFlv7paUzFksxaw9igR487UXhe+k3Ga+z7+UJ05Ll8FBNYe/hk/tYXb8usv
 zCL4864jIuhtJyOF+6uPb1j87fEnMZKm5qL4qKPivl1H4sD9gATfjOUubNXijFUfoOoF
 ZJPcLKsrmGx7CsLPYgbucHwNdyANyPfNfJT8wrJCX0tky3UBkN6+UL0U22y607t9BJv8
 is3g==
X-Gm-Message-State: AC+VfDz/GUIQIDpOKwcBFq4UxBXCrj/d1J1Did20L1qS5Rgkg8uN5OLs
 zx1a4bR0JHBXS/BeVJW3Jlk5ivcxfj1PaeIKcmk=
X-Google-Smtp-Source: ACHHUZ6UD7ogwCdC7SPotc403yPkjvbf0wUgj3l6h0zh7cwnMuVCRdMX4CfeF9LVHGQe90vf39bY/g==
X-Received: by 2002:a5d:4108:0:b0:30c:2b30:ec82 with SMTP id
 l8-20020a5d4108000000b0030c2b30ec82mr2065752wrp.18.1685555013487; 
 Wed, 31 May 2023 10:43:33 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.146.12])
 by smtp.gmail.com with ESMTPSA id
 y5-20020a7bcd85000000b003f09d7b6e20sm21585491wmj.2.2023.05.31.10.43.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 May 2023 10:43:32 -0700 (PDT)
Message-ID: <edd9f126-526e-ee57-767b-a1d307008a4d@linaro.org>
Date: Wed, 31 May 2023 19:43:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v2 05/23] q800: move CPU object into Q800MachineState
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, laurent@vivier.eu,
 qemu-devel@nongnu.org
References: <20230531125400.288917-1-mark.cave-ayland@ilande.co.uk>
 <20230531125400.288917-6-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230531125400.288917-6-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 31/5/23 14:53, Mark Cave-Ayland wrote:
> Also change the instantiation of the CPU to use object_initialize_child()
> followed by a separate realisation.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/m68k/q800.c         | 13 ++++++++-----
>   include/hw/m68k/q800.h |  2 ++
>   2 files changed, 10 insertions(+), 5 deletions(-)


> @@ -407,8 +407,10 @@ static void q800_machine_init(MachineState *machine)
>       }
>   
>       /* init CPUs */
> -    cpu = M68K_CPU(cpu_create(machine->cpu_type));
> -    qemu_register_reset(main_cpu_reset, cpu);
> +    object_initialize_child(OBJECT(machine), "cpu", &m->cpu,
> +                            M68K_CPU_TYPE_NAME("m68040"));

Shouldn't we keep using machine->cpu_type?

If the m68040 is the single CPU usable, we should set
MachineClass::valid_cpu_types[] in q800_machine_class_init().

> +    object_property_set_bool(OBJECT(&m->cpu), "realized", true, &error_fatal);
> +    qemu_register_reset(main_cpu_reset, &m->cpu);


