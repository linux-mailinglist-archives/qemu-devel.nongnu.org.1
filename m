Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4F574565D
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 09:47:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGEGw-00057s-S9; Mon, 03 Jul 2023 03:46:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGEGp-00056d-GZ
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 03:46:51 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGEGn-0007dk-2r
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 03:46:51 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-3fbc0981756so38329675e9.0
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 00:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688370407; x=1690962407;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lIPJH8PZ+Te67CPqFmwDLk0RADZV744C10qjFrgmkNg=;
 b=m1dHfzhoGSQq9N8FUvmV51aWQye4n7mOu4qzHWG14R7hhQOf2fhGarvcsGc4CSBTi5
 7lxUPyyJ6OAVLZ6P48eW3Sl2lPGKeQ9pU07/hBmNC8pHLtXJ7NRNq0I79I4qI4xOS2qx
 rudj0tZEZ4JC/Fk9dT61rQbaEIM1TH297lzN0MB9mvAYCL8eRAkLddiyCmjl5CNGNNMf
 o7LRrM2mlwWbkT6kuyBvR/wNmes+V4DgRjHrl79WKj/QQp8Sq6dCQnEM+smu/O975N1H
 54t1hYSe+DrYuDERKfkflp80tITHEG1z1gCBIWfcQv4GRDsHrS0XAF7MkP2RWTRtT8V0
 0lHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688370407; x=1690962407;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lIPJH8PZ+Te67CPqFmwDLk0RADZV744C10qjFrgmkNg=;
 b=TSBe49SMuxUdHu1d6+YqilWPG5MJYjeOnPWEl3aSnw7n0pfHjn1Svu0T3l4vNR+Sz/
 ozvM1qBFTETAlfXM16S7awpj4E+Iw0o9Yq2SouOAckhACLTxNit7uIRRstOOnMaHVUgQ
 m/3mWGtsWYyRyazqxQ6mgT39DcVGV/InV2VxbQcgjry7HA2oOh/pxZPtFNbn8KR0+3eq
 SQx+Pd0EKJdtAxBDwze5a4qDk7oyyb35aNvMpU/2DiOG2symUPvUSAcxHPSXVf7ekels
 YRCFV9eaIpnIPFdTCGqx5+sF9I2AXNPEFh3d9HWMElZUiLY2Ua1hqkP/GTdoO0ungLxk
 9WUg==
X-Gm-Message-State: ABy/qLZjOU5J6s/ssFDHTSoZ7zS6k11UYeBXolGDOx27TcOCyZcynBAw
 PyU4bcskQ/Nz25K/LsBc7vlWGg==
X-Google-Smtp-Source: APBJJlGs2SXEv92kxuNpdYVf4HgnNBc5I+Aqs7IhtjaYOKdOIy4vtuOxoFVWZitB+eXDCLbJ9+FE1Q==
X-Received: by 2002:adf:fe85:0:b0:2d1:3eb9:c3c2 with SMTP id
 l5-20020adffe85000000b002d13eb9c3c2mr6938589wrr.54.1688370407478; 
 Mon, 03 Jul 2023 00:46:47 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.178.91])
 by smtp.gmail.com with ESMTPSA id
 e1-20020a5d5941000000b00313e59cb371sm23515317wri.12.2023.07.03.00.46.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jul 2023 00:46:47 -0700 (PDT)
Message-ID: <e08863cd-f4ac-9ffa-b79b-5f9c594f1db4@linaro.org>
Date: Mon, 3 Jul 2023 09:46:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH] riscv: Generate devicetree only after machine
 initialization is complete
Content-Language: en-US
To: Guenter Roeck <linux@roeck-us.net>, Palmer Dabbelt <palmer@dabbelt.com>
Cc: Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Alistair Francis <alistair23@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Bin Meng <bin.meng@windriver.com>,
 Jia Liu <proljc@gmail.com>, Leif Lindholm <quic_llindhol@quicinc.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paul Burton <paulburton@kernel.org>, Peter Maydell
 <peter.maydell@linaro.org>, Radoslaw Biernacki <rad@semihalf.com>,
 Song Gao <gaosong@loongson.cn>, Stafford Horne <shorne@gmail.com>,
 Weiwei Li <liweiwei@iscas.ac.cn>, Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20230703034614.3909079-1-linux@roeck-us.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230703034614.3909079-1-linux@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 3/7/23 05:46, Guenter Roeck wrote:
> If the devicetree is created before machine initialization is complete,
> it misses dynamic devices. Specifically, the tpm device is not added
> to the devicetree file and is therefore not instantiated in Linux.
> Create devicetree in virt_machine_done() to solve the problem.

This makes sense, but what about the other archs/machines?
Shouldn't we fix this generically?

> Cc: Alistair Francis <alistair23@gmail.com>
> Fixes: 325b7c4e75 hw/riscv: Enable TPM backends
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>   hw/riscv/virt.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index ed4c27487e..08876284f5 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -1248,6 +1248,11 @@ static void virt_machine_done(Notifier *notifier, void *data)
>       uint64_t kernel_entry = 0;
>       BlockBackend *pflash_blk0;
>   
> +    /* create devicetree if not provided */
> +    if (!machine->dtb) {
> +        create_fdt(s, memmap);
> +    }
> +
>       /*
>        * Only direct boot kernel is currently supported for KVM VM,
>        * so the "-bios" parameter is not supported when KVM is enabled.
> @@ -1508,15 +1513,13 @@ static void virt_machine_init(MachineState *machine)
>       }
>       virt_flash_map(s, system_memory);
>   
> -    /* load/create device tree */
> +    /* load device tree */
>       if (machine->dtb) {
>           machine->fdt = load_device_tree(machine->dtb, &s->fdt_size);
>           if (!machine->fdt) {
>               error_report("load_device_tree() failed");
>               exit(1);
>           }
> -    } else {
> -        create_fdt(s, memmap);
>       }
>   
>       s->machine_done.notify = virt_machine_done;


