Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 62493743AC8
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 13:25:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFCEd-0005Oo-DZ; Fri, 30 Jun 2023 07:24:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qFCEb-0005OT-PO
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 07:24:17 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qFCEa-0003hw-5q
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 07:24:17 -0400
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-39ca48cd4c6so1292196b6e.0
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 04:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1688124255; x=1690716255;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UDk4XZVXc0Ta9Ahi0MKQ7QNVtwL7dqqAyjQqmnRos6A=;
 b=O2wNWUpATdu+aSr7VqtsRhdEJc5O0koFWyoc2koi0Yyt6RMN5bdr5AmQofyRNYFiUz
 9k+efSaCu6GrN+w5ozYEl2W5YrKPjvxn2itmlfRTovVMArF6WeZ2mr66o66IhLldqWHS
 pnY4A8O1oL62/IgcD9DBu4CVd8OjNwkAb2V18oLpA30ypEDumTCAvQZLIJPaC8P1iYbE
 IFxU8ZloW7REwBTZtD7AJli7GDbdPcJJGkky1yP4FbijXkyRNvA0Ja/TY/VWHqCEUwR+
 6AWBPCIZ3WcgEvUe2KkDf7WE2TkdJnTCrHWH8BwrqQO8wmb3x9C0ZewBWA1h+okf0wuI
 Wv/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688124255; x=1690716255;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UDk4XZVXc0Ta9Ahi0MKQ7QNVtwL7dqqAyjQqmnRos6A=;
 b=I1/838/nykh74KFl2rWEYw6J/FGVhABacNPkH7VMgd0Cbmp4IxFN1TO6RjoJFe1Mf9
 QhYH6HKa213XGrgLUNbdWsCPXmSmnhdzH7rAlwozfOCCUQ7yms/hrM+VGX3ORQ/gewRx
 Eua0+rvkbsrggkHJnjfqi8UOdDyxtpg5r2Z2P/S4i+16PTQ0EMaRxIZj4+lpCQVqkhxf
 uREPEXm7M2g/4ctZG/UIXYVITlJlUWo0t9hvJzZRGt8lqeD8xzaZ941Y+4UDwurERj2l
 RYZybi8o0/PQblE404537rRxDZC7j2HBB1380Tz2iGZu/461vP6KGeF6rNxrnJnS3YeG
 7w1Q==
X-Gm-Message-State: AC+VfDz0qiAhVSaSitKieKw+1PuIqFcwJmvrEc4Rcsb20p817xTnilGR
 TpwMbKdotFFf4gr6G6uV5XRWEA==
X-Google-Smtp-Source: ACHHUZ5A10BBigbkrC5QdRPO5Tv0wIlnKyXe4SsvL5rUXQK/bB+nAirHPFSomiZd56p4g8PfWJjjgw==
X-Received: by 2002:a05:6808:4ce:b0:3a3:75d3:9bed with SMTP id
 a14-20020a05680804ce00b003a375d39bedmr2016185oie.54.1688124254863; 
 Fri, 30 Jun 2023 04:24:14 -0700 (PDT)
Received: from ?IPV6:2804:18:1005:1891:f8a0:1703:4d3b:4d5d?
 ([2804:18:1005:1891:f8a0:1703:4d3b:4d5d])
 by smtp.gmail.com with ESMTPSA id
 j5-20020aca6545000000b003a363f14f5dsm2626095oiw.50.2023.06.30.04.24.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Jun 2023 04:24:14 -0700 (PDT)
Message-ID: <9e359abd-9a25-1b82-195b-900118f25f4d@ventanamicro.com>
Date: Fri, 30 Jun 2023 08:24:08 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/2] hw/riscv/virt: Restrict ACLINT to TCG
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Bin Meng <bin.meng@windriver.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 Weiwei Li <liweiwei@iscas.ac.cn>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20230629121103.87733-1-philmd@linaro.org>
 <20230629121103.87733-3-philmd@linaro.org>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20230629121103.87733-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oi1-x22f.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.095,
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



On 6/29/23 09:11, Philippe Mathieu-Daudé wrote:
> The Advanced Core Local Interruptor (ACLINT) device can
> only be used with TCG. Check for TCG enabled instead of
> KVM being not. Only add the property when TCG is used.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   docs/system/riscv/virt.rst |  1 +
>   hw/riscv/virt.c            | 18 ++++++++++--------
>   2 files changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/docs/system/riscv/virt.rst b/docs/system/riscv/virt.rst
> index b33f45e5b3..f9a2eac544 100644
> --- a/docs/system/riscv/virt.rst
> +++ b/docs/system/riscv/virt.rst
> @@ -93,6 +93,7 @@ The following machine-specific options are supported:
>   
>     When this option is "on", ACLINT devices will be emulated instead of
>     SiFive CLINT. When not specified, this option is assumed to be "off".
> +  This option is restricted to the TCG accelerator.
>   
>   - aia=[none|aplic|aplic-imsic]
>   
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 68ccd0bde1..cdb88a1529 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -44,6 +44,7 @@
>   #include "chardev/char.h"
>   #include "sysemu/device_tree.h"
>   #include "sysemu/sysemu.h"
> +#include "sysemu/tcg.h"
>   #include "sysemu/kvm.h"
>   #include "sysemu/tpm.h"
>   #include "hw/pci/pci.h"
> @@ -776,7 +777,7 @@ static void create_fdt_sockets(RISCVVirtState *s, const MemMapEntry *memmap,
>   
>           g_free(clust_name);
>   
> -        if (!kvm_enabled()) {
> +        if (tcg_enabled()) {
>               if (s->have_aclint) {
>                   create_fdt_socket_aclint(s, memmap, socket,
>                       &intc_phandles[phandle_pos]);
> @@ -1370,7 +1371,7 @@ static void virt_machine_init(MachineState *machine)
>                                   hart_count, &error_abort);
>           sysbus_realize(SYS_BUS_DEVICE(&s->soc[i]), &error_fatal);
>   
> -        if (!kvm_enabled()) {
> +        if (tcg_enabled()) {
>               if (s->have_aclint) {
>                   if (s->aia_type == VIRT_AIA_TYPE_APLIC_IMSIC) {
>                       /* Per-socket ACLINT MTIMER */
> @@ -1682,12 +1683,13 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
>       machine_class_allow_dynamic_sysbus_dev(mc, TYPE_TPM_TIS_SYSBUS);
>   #endif
>   
> -    object_class_property_add_bool(oc, "aclint", virt_get_aclint,
> -                                   virt_set_aclint);
> -    object_class_property_set_description(oc, "aclint",
> -                                          "Set on/off to enable/disable "
> -                                          "emulating ACLINT devices");
> -
> +    if (tcg_enabled()) {
> +        object_class_property_add_bool(oc, "aclint", virt_get_aclint,
> +                                       virt_set_aclint);
> +        object_class_property_set_description(oc, "aclint",
> +                                              "Set on/off to enable/disable "
> +                                              "emulating ACLINT devices");
> +    }
>       object_class_property_add_str(oc, "aia", virt_get_aia,
>                                     virt_set_aia);
>       object_class_property_set_description(oc, "aia",

