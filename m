Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE96A7244D3
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 15:49:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6X3R-0002tW-2w; Tue, 06 Jun 2023 09:48:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1q6X3J-0002qT-Bk
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 09:48:51 -0400
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1q6X3H-0000Ry-Qx
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 09:48:49 -0400
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-39aa1517037so1161068b6e.2
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 06:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1686059326; x=1688651326;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/9tYaZoRGJ5NOSOzv48HhCH8mfZEyM/2QpMdJUXS86Y=;
 b=ZsTUmqqW12KMlutqNM5M2BrXZE4H9g/ehGQJC2R8nmj5S4LdDEVUOdfNvfsM44+Wk3
 FreLWSpJ9S4sNo1Pt41Q0LHzV3MfMLIJxgvFgyeJVBK30vWTtx7d+zIklp5JnydddOES
 baLchg1YBf7qqDmvtJZogq7XlVTCmDGGW+0U5nwm68I5whwnQkbKEQkn8lvn4sFdnFvb
 9fdYVLsFtbyvz4lM2MPz4WOGerJr5k4q+gVacPnzxztMr1Pua10ceZWqi6bNNB5z7hW3
 TujfPo7oQYhZgd3sxDY7B4/4L/2p868mErzRzFD71AIlkNKHoXi6PwB5RxUDWw9Tru8n
 LMVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686059326; x=1688651326;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/9tYaZoRGJ5NOSOzv48HhCH8mfZEyM/2QpMdJUXS86Y=;
 b=MQtJUAkHsb05fXmRGJg41Owrt4p1wPQZR21IX/mDoyLQ5msgI+tzIP4oktQ3OeCLRL
 DG8pZ8eNW9D/qXaYIPrDuRrkAPLIZfVgUWcfGxJ6ctvKpIXmKnnFs44FXZZudeWNNZ9C
 XpaJLwczOQupDL704LqwCxHn/oh3XkUmA71ekc4OJ3lYu6cjEDg9g3MJFe4Z7KMl0GTW
 lpweh+gjo1/nubVu6RvN3JCT0XTz+Mw5rtK2wqi8scr6cBgqhEseMJAvbEyVit3YA8MN
 XfD4u48ZSduM036AZYAFkwK+vamqBl5ttTYYFEmxfs8+UoD3CEP8tF08P0D6WH6NDI8w
 rOCw==
X-Gm-Message-State: AC+VfDwICC5ibmJw3CHq60NPTFhQC+zG5WlPqBowmgKZcVky6QMC9IOi
 Swy63cnOeU44YwWByaXvhXYDdA==
X-Google-Smtp-Source: ACHHUZ7U0DbfALgkOJfKZPnVi9XzkplneTUFzCjzMMW9S+FY6SrYuUxaRPNjQvhkeU+FzaUs/PVNAA==
X-Received: by 2002:a54:401a:0:b0:39a:aa6d:b9e0 with SMTP id
 x26-20020a54401a000000b0039aaa6db9e0mr982116oie.45.1686059326331; 
 Tue, 06 Jun 2023 06:48:46 -0700 (PDT)
Received: from [192.168.68.107] ([177.170.117.52])
 by smtp.gmail.com with ESMTPSA id
 b23-20020a056808011700b00383d9700294sm4288560oie.40.2023.06.06.06.48.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Jun 2023 06:48:45 -0700 (PDT)
Message-ID: <b19bb5eb-3e9a-e9bd-35cd-f08033c1193c@ventanamicro.com>
Date: Tue, 6 Jun 2023 10:48:40 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 6/6] target/riscv: select KVM AIA in riscv virt machine
Content-Language: en-US
To: Yong-Xuan Wang <yongxuan.wang@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, rkanwal@rivosinc.com, anup@brainfault.org,
 atishp@atishpatra.org, vincent.chen@sifive.com, greentime.hu@sifive.com,
 frank.chang@sifive.com, jim.shu@sifive.com
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20230526062509.31682-1-yongxuan.wang@sifive.com>
 <20230526062509.31682-7-yongxuan.wang@sifive.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20230526062509.31682-7-yongxuan.wang@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::236;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oi1-x236.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.094,
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



On 5/26/23 03:25, Yong-Xuan Wang wrote:
> Select KVM AIA when the host kernel has in-kernel AIA chip support.
> 
> Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
> Reviewed-by: Jim Shu <jim.shu@sifive.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   hw/riscv/virt.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 18b94888ab..57a07fa6c5 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -35,6 +35,7 @@
>   #include "hw/riscv/virt.h"
>   #include "hw/riscv/boot.h"
>   #include "hw/riscv/numa.h"
> +#include "kvm_riscv.h"
>   #include "hw/intc/riscv_aclint.h"
>   #include "hw/intc/riscv_aplic.h"
>   #include "hw/intc/riscv_imsic.h"
> @@ -1217,6 +1218,15 @@ static DeviceState *virt_create_aia(RISCVVirtAIAType aia_type, int aia_guests,
>               msimode, false, aplic_m);
>       }
>   
> +    if (kvm_irqchip_in_kernel()) {
> +        kvm_riscv_aia_create(
> +            aplic_s, msimode, socket,
> +            VIRT_IRQCHIP_NUM_SOURCES,
> +            hart_count,
> +            memmap[VIRT_APLIC_S].base + socket * memmap[VIRT_APLIC_S].size,
> +            memmap[VIRT_IMSIC_S].base + socket * VIRT_IMSIC_GROUP_MAX_SIZE);
> +    }
> +
>       return kvm_enabled() ? aplic_s : aplic_m;
>   }
>   

