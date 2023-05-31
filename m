Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4C2717BED
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 11:30:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4I8L-0005ZZ-CN; Wed, 31 May 2023 05:28:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1q4I8K-0005ZE-0l
 for qemu-devel@nongnu.org; Wed, 31 May 2023 05:28:44 -0400
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1q4I8I-0006wb-Hs
 for qemu-devel@nongnu.org; Wed, 31 May 2023 05:28:43 -0400
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-38dec65ab50so3677604b6e.2
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 02:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1685525321; x=1688117321;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Wbejtb5b3jCijsM3+gHxxSoaYoC2BvPXW9vDvOVEhRY=;
 b=hWRvUA5UMPK+o+63HFIGVp6fR1WJU6vTUDsxXkQZ10HN+3I7pRCH9LdGRSma0WL+Ua
 riXFxTOG4FrdVb4SGIN4rRG7kOlOh3nRYEUgepmk5z2J3UHhYeenrfNZfNmwzEKh1+iQ
 yhwolQyXSrIgfpGNwqS8p+n9kx840cI1HdSSIN93XB/lZI9OmaRJIPBzVrDyU9tlOiUR
 XNvSBIO+l3GyjgzJmEKt5QDCfyItOF9fhSiaXihelKJ3XBXKycrjEITHIGAj7E/vs+wr
 DNMh52Wu4dvccG1yPbXyEWXIbRAoYvZ44BHORIsDgfV7d26WeZoTnMpT1QIqJpC9FPZu
 QUcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685525321; x=1688117321;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Wbejtb5b3jCijsM3+gHxxSoaYoC2BvPXW9vDvOVEhRY=;
 b=Cl4f3jz5h0KAQrF11kTKk6y/U8PUeS9knDyNk4JsjdkxRc4N1AeC4jgLiOvHcMrW3q
 Aa9B/lLrgcjeeZMrjW6hv3dP8xxhIBlXV9KRljX6PN55DWVOEg1peSZXVSJiZXvmzOcO
 VIA6eirSE+1oMrLrh5xGpw0K2OUBm0v/zdqrAYcRokvcNR/GG2tKMVmRZ7xiN/I4EWqC
 dLxQhHvalv0/ayfytkH3ncYfpfFNGmv/7PGW54hmTrz98g/yKBEzCQL3EtFKC4xhqqAi
 9vfzpKxl3tvbrsAHInWtjT6G2vcryTlrVjxuUyzVwfVJFu4JuIuM4A8YsSloHDQ6/ACC
 kwrA==
X-Gm-Message-State: AC+VfDxW4D35yc2MpMqAQBZRwPH0AsIciFhfNFrFHSh7pD2RV2KNH1C3
 zAT7hrmLeg62Uu0Ve2UaRdCOVw==
X-Google-Smtp-Source: ACHHUZ6pfxmabJ4T3R639gxJL00vyVfcwVYBf4ZpJ+pLqcgC4QDaD8mV7lrXYalqpX4c7XbVbIHmcA==
X-Received: by 2002:a05:6808:d4b:b0:395:f7fd:cbcc with SMTP id
 w11-20020a0568080d4b00b00395f7fdcbccmr4151288oik.21.1685525321443; 
 Wed, 31 May 2023 02:28:41 -0700 (PDT)
Received: from [192.168.68.107] ([177.198.100.141])
 by smtp.gmail.com with ESMTPSA id
 v4-20020a544d04000000b00397da2a0acdsm316476oix.29.2023.05.31.02.28.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 May 2023 02:28:40 -0700 (PDT)
Message-ID: <813ddfaa-c1d3-6902-b172-7ec187d2cd3c@ventanamicro.com>
Date: Wed, 31 May 2023 06:28:37 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/4] target/riscv: Make MPV only work when MPP != PRV_M
Content-Language: en-US
To: Weiwei Li <liweiwei@iscas.ac.cn>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, bin.meng@windriver.com,
 zhiwei_liu@linux.alibaba.com, wangjunqiang@iscas.ac.cn, lazyparser@gmail.com
References: <20230529121719.179507-1-liweiwei@iscas.ac.cn>
 <20230529121719.179507-2-liweiwei@iscas.ac.cn>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20230529121719.179507-2-liweiwei@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22b;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oi1-x22b.google.com
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



On 5/29/23 09:17, Weiwei Li wrote:
> Upon MRET or explicit memory access with MPRV=1, MPV should be ignored
> when MPP=PRV_M.
> 
> Signed-off-by: Weiwei Li <liweiwei@iscas.ac.cn>
> Signed-off-by: Junqiang Wang <wangjunqiang@iscas.ac.cn>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/cpu_helper.c | 3 ++-
>   target/riscv/op_helper.c  | 3 ++-
>   2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 09ea227ceb..bd892c05d4 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -46,7 +46,8 @@ int riscv_cpu_mmu_index(CPURISCVState *env, bool ifetch)
>   
>           if (mode == PRV_M && get_field(status, MSTATUS_MPRV)) {
>               mode = get_field(env->mstatus, MSTATUS_MPP);
> -            virt = get_field(env->mstatus, MSTATUS_MPV);
> +            virt = get_field(env->mstatus, MSTATUS_MPV) &&
> +                   (mode != PRV_M);
>               if (virt) {
>                   status = env->vsstatus;
>               }
> diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
> index f563dc3981..9cdb9cdd06 100644
> --- a/target/riscv/op_helper.c
> +++ b/target/riscv/op_helper.c
> @@ -335,7 +335,8 @@ target_ulong helper_mret(CPURISCVState *env)
>           riscv_raise_exception(env, RISCV_EXCP_INST_ACCESS_FAULT, GETPC());
>       }
>   
> -    target_ulong prev_virt = get_field(env->mstatus, MSTATUS_MPV);
> +    target_ulong prev_virt = get_field(env->mstatus, MSTATUS_MPV) &&
> +                             (prev_priv != PRV_M);
>       mstatus = set_field(mstatus, MSTATUS_MIE,
>                           get_field(mstatus, MSTATUS_MPIE));
>       mstatus = set_field(mstatus, MSTATUS_MPIE, 1);

