Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DB072716EA2
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 22:27:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q45vN-0001CK-I6; Tue, 30 May 2023 16:26:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1q45vM-0001CB-JO
 for qemu-devel@nongnu.org; Tue, 30 May 2023 16:26:32 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1q45vK-0002tj-Va
 for qemu-devel@nongnu.org; Tue, 30 May 2023 16:26:32 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-4f5021faa16so3051917e87.2
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 13:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1685478388; x=1688070388;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3w/JWydRK6FkbOYN4byz+HZ1uFjOJMp9UQZILBRR/Xs=;
 b=mgj8i17yMDtThz5rlBpK/bCmAWxzm8gtesyHU2asP8vnN0Vfhko6IZy1XI9/bhoJI2
 ldH1ThObori51B66LFI2Cap1AQbccQ4S87D0t+D7hJ919m26VUAXfo1wwXzZLJfGdz+J
 qsFfrnK+YKBFzlqxx5d/TfOF7BlRkKhO15TPeOX9kQxECyXsQSeZo1ueGloAzfxNasFH
 oZiMY9pVRAjU7D3b7GbiYCOMQ7stdBnfGVSZd7n2fotcFmDsyY9NxNjEJz/BTbfgMwNj
 /l3eH8SP36jGWqSln9VFtsxjd3IeTuZDwaQLTRm5qAL+TEhVFt3XsnFLBSRNKeLPBZnL
 G6Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685478388; x=1688070388;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3w/JWydRK6FkbOYN4byz+HZ1uFjOJMp9UQZILBRR/Xs=;
 b=WOcKsSfszXSu5X6T9vLeEp35KTir8uEx9Ywt7twbbEuqwe6FDHZmXnb71CJYwi0KLg
 icOxnh3fY2ifioV2G09PSftYpd3L+96R3svrNcCTSsmugECHmW1I9TYFdOUBEGo8Bf5y
 G6M3lIMczNvydUYBevjsBoiQ7I4dgPaZaAoMTBpFAC4VYV6GWIZjm0BWp5iVbGg8hjsL
 GolhldiHJH4wTR0Nu4pMAH/L2DPZJ9UWEIRaDefEsySXOUgZbuKVSm89Hged1LEGVcqe
 ulWsR/jyEpQPeIckrMbk75ARi2WWPupWRRoqZSeG1F8eCIVl/8e+ZgBlzEq8abkftqPz
 AOvQ==
X-Gm-Message-State: AC+VfDx+wP67KOwzJLVwqAOocNUkdFh2TO2s4OMtTLQiCc6gg3EvnolC
 ggPpSZtk16vJ95RjK/YfCVJXbA==
X-Google-Smtp-Source: ACHHUZ7almwGzFxwlBXZ6gx/+fSKuQhN8at7+yzn3hj+yuI6uV4OMqu1uj055SrMtkgza6AAqaXAZw==
X-Received: by 2002:ac2:4570:0:b0:4f4:b771:3a5a with SMTP id
 k16-20020ac24570000000b004f4b7713a5amr1416586lfm.61.1685478388636; 
 Tue, 30 May 2023 13:26:28 -0700 (PDT)
Received: from [192.168.68.107] (200-162-225-121.static-corp.ajato.com.br.
 [200.162.225.121]) by smtp.gmail.com with ESMTPSA id
 r7-20020ac252a7000000b004e9bf853c27sm446325lfm.70.2023.05.30.13.26.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 May 2023 13:26:28 -0700 (PDT)
Message-ID: <c746c2a9-ef7b-4348-3567-4eb514f9dacb@ventanamicro.com>
Date: Tue, 30 May 2023 17:26:21 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 3/4] target/riscv: Support MSTATUS.MPV/GVA only when RVH
 is enabled
Content-Language: en-US
To: Weiwei Li <liweiwei@iscas.ac.cn>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, bin.meng@windriver.com,
 zhiwei_liu@linux.alibaba.com, wangjunqiang@iscas.ac.cn, lazyparser@gmail.com
References: <20230529121719.179507-1-liweiwei@iscas.ac.cn>
 <20230529121719.179507-4-liweiwei@iscas.ac.cn>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20230529121719.179507-4-liweiwei@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-lf1-x134.google.com
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
> MPV and GVA bits are added by hypervisor extension to mstatus
> and mstatush (if MXLEN=32).
> 
> Signed-off-by: Weiwei Li <liweiwei@iscas.ac.cn>
> Signed-off-by: Junqiang Wang <wangjunqiang@iscas.ac.cn>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/csr.c | 10 ++++------
>   1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 58499b5afc..6ac11d1f11 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -1311,11 +1311,9 @@ static RISCVException write_mstatus(CPURISCVState *env, int csrno,
>       }
>   
>       if (xl != MXL_RV32 || env->debugger) {
> -        /*
> -         * RV32: MPV and GVA are not in mstatus. The current plan is to
> -         * add them to mstatush. For now, we just don't support it.
> -         */
> -        mask |= MSTATUS_MPV | MSTATUS_GVA;
> +        if (riscv_has_ext(env, RVH)) {
> +            mask |= MSTATUS_MPV | MSTATUS_GVA;
> +        }
>           if ((val & MSTATUS64_UXL) != 0) {
>               mask |= MSTATUS64_UXL;
>           }
> @@ -1351,7 +1349,7 @@ static RISCVException write_mstatush(CPURISCVState *env, int csrno,
>                                        target_ulong val)
>   {
>       uint64_t valh = (uint64_t)val << 32;
> -    uint64_t mask = MSTATUS_MPV | MSTATUS_GVA;
> +    uint64_t mask = riscv_has_ext(env, RVH) ? MSTATUS_MPV | MSTATUS_GVA : 0;
>   
>       env->mstatus = (env->mstatus & ~mask) | (valh & mask);
>   

