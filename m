Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5937656D8
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 17:05:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP25t-0001ft-Dl; Thu, 27 Jul 2023 10:35:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qP25h-0001en-8d
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 10:35:47 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qP25d-0008Hd-5e
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 10:35:43 -0400
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-6b9aadde448so880696a34.0
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 07:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1690468539; x=1691073339;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kl+MtuSlJaqDuRE0rLePOkxRxcldTJlNtAo3zNGeDNE=;
 b=LdKi421ILH59AOYRnPMc02+V0tl8BvpDGSJxdL6m+dwmlHzAsKYXrRWilQ6X0MbcYB
 tqJ+INSYnaIbk/5hvk3roiL5vd79qmYkdmi2GQJI6hh/pbjcfArBqJgZuglBWhniTjah
 AokOEll8km58ppNpRHzqU19k1lcra4VVIhvxcf6bAeBE7kTBTz3SCvWJAlAmCPdF7W3i
 jS9ZhUZ2WsTFHyYe1w6y9VhXrHJetEhgt1H9X8Ka/xZcoTr4XettabItljSNjlN/+oaY
 ETteEnrxSVU3AfbHPI4mpW7CgRwUaAjos6wDMYgm8MtnJbsp3y7FsSukfMTCudgUiGpL
 1xgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690468539; x=1691073339;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kl+MtuSlJaqDuRE0rLePOkxRxcldTJlNtAo3zNGeDNE=;
 b=hwIMSeOeC/iEj9ha11jE/XSzqZQ81bV8dwZIemTfn9NslUJo70vcO1dVXHV8c/pdjU
 oYMnKgv6T2a5dp7JHwyKtBM3FfE83fO2yAmXOjteD1XA1/vl1V94YtWAcwsHqTmfjGCW
 5KSAvYrZFCY2fImfpM1Fm3e8xSXJtJC7pyOBmifcT4r4sgxrK9WMCIlVURKL8S1uZ9nQ
 Cj5QXb4NCDGobv00FFyYtmnlSlbFwHPBac2vepNFoOFkNKhuM1AsAut4x6fcsMicvxaE
 7j72mANFlDbH52xiljHWE8ZCAua+wSr4KKCf50Hro+omskyW5OHMZPjPuMTLT600FKKH
 +ZTw==
X-Gm-Message-State: ABy/qLa8ety8lNr8rL9AIsYR6ZvpB2kIo6mrLBMiNSlCE0c1JWWKpjWK
 q8l8g2Ct50q6tbyWrJevLBnI7EDonrfXF0e2P6sSeQ==
X-Google-Smtp-Source: APBJJlGHAOevBZsPbSVcrA23+cVJl9+O7pN/YI+g+jh0EzP5rzfgKmnPGTE+gZyyR/gyjkgU+gHs3w==
X-Received: by 2002:a05:6870:350f:b0:1bb:4d4e:ea69 with SMTP id
 k15-20020a056870350f00b001bb4d4eea69mr3511666oah.54.1690468539585; 
 Thu, 27 Jul 2023 07:35:39 -0700 (PDT)
Received: from [192.168.68.108] (201-69-66-36.dial-up.telesp.net.br.
 [201.69.66.36]) by smtp.gmail.com with ESMTPSA id
 a17-20020a056830009100b006b83a36c08bsm667393oto.53.2023.07.27.07.35.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jul 2023 07:35:39 -0700 (PDT)
Message-ID: <71f06817-1a63-efad-fa9f-bdbdb1eb1694@ventanamicro.com>
Date: Thu, 27 Jul 2023 11:35:34 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] hw/riscv: virt: Fix riscv,pmu DT node path
Content-Language: en-US
To: Conor Dooley <conor@kernel.org>, qemu-riscv@nongnu.org
Cc: Conor Dooley <conor.dooley@microchip.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
References: <20230727-groom-decline-2c57ce42841c@spud>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20230727-groom-decline-2c57ce42841c@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x32c.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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



On 7/27/23 11:24, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> On a dtb dumped from the virt machine, dt-validate complains:
> soc: pmu: {'riscv,event-to-mhpmcounters': [[1, 1, 524281], [2, 2, 524284], [65561, 65561, 524280], [65563, 65563, 524280], [65569, 65569, 524280]], 'compatible': ['riscv,pmu']} should not be valid under {'type': 'object'}
>          from schema $id: http://devicetree.org/schemas/simple-bus.yaml#
> That's pretty cryptic, but running the dtb back through dtc produces
> something a lot more reasonable:
> Warning (simple_bus_reg): /soc/pmu: missing or empty reg/ranges property
> 
> Moving the riscv,pmu node out of the soc bus solves the problem.
> 
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

> CC: Palmer Dabbelt <palmer@dabbelt.com>
> CC: Alistair Francis <alistair.francis@wdc.com>
> CC: Bin Meng <bin.meng@windriver.com>
> CC: Weiwei Li <liweiwei@iscas.ac.cn>
> CC: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> CC: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
> CC: qemu-riscv@nongnu.org
> CC: qemu-devel@nongnu.org
> ---
>   hw/riscv/virt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index d90286dc46..25dcc2616e 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -732,7 +732,7 @@ static void create_fdt_pmu(RISCVVirtState *s)
>       MachineState *ms = MACHINE(s);
>       RISCVCPU hart = s->soc[0].harts[0];
>   
> -    pmu_name = g_strdup_printf("/soc/pmu");
> +    pmu_name = g_strdup_printf("/pmu");
>       qemu_fdt_add_subnode(ms->fdt, pmu_name);
>       qemu_fdt_setprop_string(ms->fdt, pmu_name, "compatible", "riscv,pmu");
>       riscv_pmu_generate_fdt_node(ms->fdt, hart.cfg.pmu_num, pmu_name);

