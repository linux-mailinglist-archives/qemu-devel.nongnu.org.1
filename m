Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D37A7DBEF8
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 18:31:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxW6I-0002Fr-Im; Mon, 30 Oct 2023 13:30:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qxW5y-0002DV-Uw
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 13:30:35 -0400
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qxW5x-0006tf-Bc
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 13:30:34 -0400
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-5a7b3d33663so46922367b3.3
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 10:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1698687031; x=1699291831; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9p9qTHVCKLKALToewqGHbSpen+vgplTQRv8pccf204c=;
 b=HmMVjl2uc8owa3NbT67P4x1IuQ4kjDiSrIBPtTS3UTfoIayb2sEcpt2mS/xWZtPyeM
 hA/Jndjue97NTgq+loDCptFO2Ody1d+HIp4Ed1qdju2C3eZ3172JWFHjr+jP35Q+Wjm0
 kxzqekm6B7J4/Fj5dTdXHBiij6ORTt45oA3x9qhhjcSgAEU/s31PkZOxpAQuTHFRaKIK
 w9JI8UvCs+U4lAOcZZNtxplOyg4STGwglksncEinvAa5IaaVbdXgKrP7sXp6ujBajbhw
 aDtLUCZuqaWcvD3vzAufF0PWmS2j/lzo5Rw8OoPdJCZrRXxO0idJR0EidlPFHWDSToWg
 ogzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698687031; x=1699291831;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9p9qTHVCKLKALToewqGHbSpen+vgplTQRv8pccf204c=;
 b=N5r79k2kOvfY1XKHdaa3pxYnISg4C8XZUh/tJ3TI4Amyukoy6HVdFeA4eHUrmPeyQy
 MfWeP4gyxIKaveNxhV2Er1Lm1JCfRa7Mp+FzfmSXLIrwk3Xv7sTkdk4pS749sSEcPLqF
 urTZhgwZVnZKO2Ro1ZdAlh51i+tLCDeh2/YudtjrUl+b2AdFR9y0h3BBS+/ZB1wr9+HD
 glKLXRDntk7b6uKcsOx1XCR1SJ5Qcl0rPlU9mgm1fBMoNWyM3SNRNi0+CfPpIOFp0i0i
 6y7J+vX49Imc+iWPgV6Itf6MI1HWvq/wUYvh+tOWzW52fPJk1FLCxb2bLOlfBM0fONk0
 CHdg==
X-Gm-Message-State: AOJu0YxPYNh6FWX/Lo/PjZ5CXJZEspsC5AMNvtjmCRYrsuNnBEqdK0tA
 URwhsoxoH548FoKScXASnLbVzg==
X-Google-Smtp-Source: AGHT+IGL8ZQjwSlyFc1DVnh8cEeMvT/LRVr2ZMMrvdb6yVpCPoTRC0ChfOfun6LxBw9rOVBXyEjW+w==
X-Received: by 2002:a81:7e4f:0:b0:5a8:286d:339e with SMTP id
 p15-20020a817e4f000000b005a8286d339emr9603602ywn.4.1698687031272; 
 Mon, 30 Oct 2023 10:30:31 -0700 (PDT)
Received: from [192.168.68.107] ([179.193.10.161])
 by smtp.gmail.com with ESMTPSA id
 i23-20020a81be17000000b005b03d703564sm3915791ywn.137.2023.10.30.10.30.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Oct 2023 10:30:30 -0700 (PDT)
Message-ID: <9becb007-d3c2-4835-8c02-7652845ed02f@ventanamicro.com>
Date: Mon, 30 Oct 2023 14:30:28 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/14] target/riscv: Add cfg properties for Zvks[c|g]
 extensions
Content-Language: en-US
To: Max Chou <max.chou@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Andrew Jones <ajones@ventanamicro.com>
References: <20231026151828.754279-1-max.chou@sifive.com>
 <20231026151828.754279-9-max.chou@sifive.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20231026151828.754279-9-max.chou@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-yw1-x1130.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 10/26/23 12:18, Max Chou wrote:
> Vector crypto spec defines the ShangMi algorithm suite related
> extensions (Zvks, Zvksc, Zvksg) combined by several vector crypto
> extensions.
> 
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/cpu_cfg.h     |  3 +++
>   target/riscv/tcg/tcg-cpu.c | 17 +++++++++++++++++
>   2 files changed, 20 insertions(+)
> 
> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> index fd07aa96a27..7b0ca657a6a 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -99,6 +99,9 @@ struct RISCVCPUConfig {
>       bool ext_zvkn;
>       bool ext_zvknc;
>       bool ext_zvkng;
> +    bool ext_zvks;
> +    bool ext_zvksc;
> +    bool ext_zvksg;
>       bool ext_zmmul;
>       bool ext_zvfbfmin;
>       bool ext_zvfbfwma;
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index e460701a13c..f9023ca75c7 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -519,6 +519,23 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
>           cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zvkt), true);
>       }
>   
> +    if (cpu->cfg.ext_zvksc) {
> +        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zvks), true);
> +        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zvbc), true);
> +    }
> +
> +    if (cpu->cfg.ext_zvksg) {
> +        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zvks), true);
> +        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zvkg), true);
> +    }
> +
> +    if (cpu->cfg.ext_zvks) {
> +        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zvksed), true);
> +        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zvksh), true);
> +        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zvkb), true);
> +        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zvkt), true);
> +    }
> +
>       if (cpu->cfg.ext_zvkt) {
>           cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zvbb), true);
>           cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zvbc), true);

