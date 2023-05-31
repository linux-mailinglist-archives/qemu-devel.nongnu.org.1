Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D07718212
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 15:37:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4M0x-0002Rn-0D; Wed, 31 May 2023 09:37:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4M0s-0002RF-ES
 for qemu-devel@nongnu.org; Wed, 31 May 2023 09:37:19 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4M0q-0007Se-Pl
 for qemu-devel@nongnu.org; Wed, 31 May 2023 09:37:18 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-30ae5f2ac94so4196610f8f.1
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 06:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685540235; x=1688132235;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=w6N9RJJmIUUpPqiihXzaDd1Rlc3oJrQsIFXe5vOYn0M=;
 b=dsH+wmAsKU2UWRLoY7SY4yZ1uV5bWNoFADeshowNEoP0b8Itla4yYsHbTzL3JV7mvs
 zgg/OklOP9ZBlHtQ/Kitz7ILW7mWKJ4KqvaflgYFp242htEFH97gcYWF79STZvgLhOKj
 Oq+C6212qGZAO25yanj4vnuNuoM0ZTlYYZwzICuKxy7V8tUBy/ecQbkAkL8VaETDOgnv
 lsD+kKzgZIuZUOgbFYk35N6IrmBt7D1EMBse7zHjjzHi9DPsYN0B4TAomemQgfeOfe4O
 0k9z1jzo9fgwyvXeUWYSso5PrTzzXJOj0gBJTSyg2mbaMKYz09A6QEW5sDFKxPe5Qz1B
 +Tvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685540235; x=1688132235;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=w6N9RJJmIUUpPqiihXzaDd1Rlc3oJrQsIFXe5vOYn0M=;
 b=HJieCTu/TZlLlVAcdaU6YCroncFTf3h/hE1/ZEFdBevnVI7tULcppAPJv/JZuqnaT9
 SBBaL6geQ+w+QiEm242LDEEgze6cbUn9qvNfPsKkD/J27iMQg3wthRHDXEFC06ffceh+
 ME8XoULgJA1HwxOFBZGOAo2kK8k3nFk8LsEZkZPTr4eHfz70iso6nNShMKO5nT9x9S9T
 kLhAliao5AsYme1hMfr6s2/r864lKjUG4mhiNba2JPSNtoR1ZGsAA6MWd1XtQehua6nM
 0CDhvZhvFr6DSnTMYDfD3lcTX28Xbj2Ktx+BuT697S4N1lqzC0k9ksoY/UiCqq0gO0Yb
 wzeg==
X-Gm-Message-State: AC+VfDyYaxQhb6cj8IWD/ZkZs0dB4XRM6j6tegrf4nhQlCf8LO4KwfAT
 qnhlytGZZ29Ssc4zbRFrb/sxMqfmZ909Ks1DTZM=
X-Google-Smtp-Source: ACHHUZ63X7rVbp/VtUtIhaodsrO0RR6ropRCnP8mORGX/73FLZZfsP19/x49IgZMnC/CRz5dj5dZBw==
X-Received: by 2002:a05:6000:1003:b0:2fb:1d3a:93ff with SMTP id
 a3-20020a056000100300b002fb1d3a93ffmr3891572wrx.61.1685540235211; 
 Wed, 31 May 2023 06:37:15 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.146.12])
 by smtp.gmail.com with ESMTPSA id
 j12-20020a5d564c000000b0030af31c8c63sm6159361wrw.47.2023.05.31.06.37.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 May 2023 06:37:14 -0700 (PDT)
Message-ID: <e5edd116-b6cf-8bf4-7a9f-2a827355994a@linaro.org>
Date: Wed, 31 May 2023 15:37:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v2 03/23] q800: introduce Q800MachineState
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, laurent@vivier.eu,
 qemu-devel@nongnu.org
References: <20230531125400.288917-1-mark.cave-ayland@ilande.co.uk>
 <20230531125400.288917-4-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230531125400.288917-4-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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
> This provides an overall container and owner for Machine-related objects such
> as MemoryRegions.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> ---
>   MAINTAINERS            |  1 +
>   hw/m68k/q800.c         |  2 ++
>   include/hw/m68k/q800.h | 37 +++++++++++++++++++++++++++++++++++++
>   3 files changed, 40 insertions(+)
>   create mode 100644 include/hw/m68k/q800.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4b025a7b63..51e62efe1b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1234,6 +1234,7 @@ F: include/hw/misc/mac_via.h
>   F: include/hw/nubus/*
>   F: include/hw/display/macfb.h
>   F: include/hw/block/swim.h
> +F: include/hw/m68k/q800.h
>   
>   virt
>   M: Laurent Vivier <laurent@vivier.eu>
> diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
> index bb9e857632..93a3f96991 100644
> --- a/hw/m68k/q800.c
> +++ b/hw/m68k/q800.c
> @@ -38,6 +38,7 @@
>   #include "standard-headers/asm-m68k/bootinfo.h"
>   #include "standard-headers/asm-m68k/bootinfo-mac.h"
>   #include "bootinfo.h"
> +#include "hw/m68k/q800.h"
>   #include "hw/misc/mac_via.h"
>   #include "hw/input/adb.h"
>   #include "hw/nubus/mac-nubus-bridge.h"
> @@ -749,6 +750,7 @@ static void q800_machine_class_init(ObjectClass *oc, void *data)
>   static const TypeInfo q800_machine_typeinfo = {
>       .name       = MACHINE_TYPE_NAME("q800"),
>       .parent     = TYPE_MACHINE,
> +    .instance_size = sizeof(Q800MachineState),
>       .class_init = q800_machine_class_init,
>   };
>   
> diff --git a/include/hw/m68k/q800.h b/include/hw/m68k/q800.h
> new file mode 100644
> index 0000000000..76ea6560b2
> --- /dev/null
> +++ b/include/hw/m68k/q800.h
> @@ -0,0 +1,37 @@
> +/*
> + * QEMU Motorla 680x0 Macintosh hardware System Emulator
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a copy
> + * of this software and associated documentation files (the "Software"), to deal
> + * in the Software without restriction, including without limitation the rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> + * THE SOFTWARE.
> + */
> +
> +#ifndef HW_Q800_H
> +#define HW_Q800_H
> +
> +/*
> + * The main Q800 machine
> + */
> +
> +struct Q800MachineState {
> +    MachineState parent_obj;

Declared in "hw/boards.h",

> +};
> +
> +#define TYPE_Q800_MACHINE MACHINE_TYPE_NAME("q800")
> +OBJECT_DECLARE_SIMPLE_TYPE(Q800MachineState, Q800_MACHINE)

defined in "qom/object.h".

> +#endif

With the 2 missing includes:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


