Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A0582A04E
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 19:32:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNdNV-0007fZ-Fy; Wed, 10 Jan 2024 13:32:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rNdNN-0007dV-Mh
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 13:32:29 -0500
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rNdNM-0004Ld-1h
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 13:32:29 -0500
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-5ce07cf1e5dso2309346a12.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 10:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1704911546; x=1705516346; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pWiq8kTUh+mdL1XsRJNdTllaoAxLxDDvBnyzL1CSrv0=;
 b=chFOXK/2XOdioiotdSmsh8J93WI0XYhmJ/0UhzyiqE+VZEVh49AUKBsCXXfAGEZhqq
 Ki2H1gqRB0JAPWFHETuxIxf5rx06Pgo71WmnLenZUxh+LLuIxlgC/AQ29kn9WGg/fiY7
 UsOvy0C4Ux7xw2etBtaqrFfFnylTwAYo3/cpY4yUMFZzvOExGF2626CGDASRhLpGjuL9
 rH5ZfGr9GVBZLhJt1e7f1Ys9cT2AsInKzHxb5PoKSlHzpYq0A8MbQEPixYkgEGCszOnp
 dWgcQx3+71o/WaCo9zpzJdCATZE48rlR7iB2Q+gqWAF/ZJia2/QFqyRnum+pRkRPAHZJ
 ijQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704911546; x=1705516346;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pWiq8kTUh+mdL1XsRJNdTllaoAxLxDDvBnyzL1CSrv0=;
 b=qrwLCewexlQFvB9GTtKBy2XyneUCPE1IwNpc/B8aP26TVILoaedIPPYq9LKOF3xQ4f
 w10cUvZUM/1m0fc3EpRtvus2EQnyQVJ+N9bqJ8SyOkyntnchUkKQVc7L2vHTBlRohsbX
 uJtCigGS+EdZQRw42VfG1at4vM+Ru09J9rc0j1vpfRQNg8xXwjiitsOqvN+ID6ckzext
 bXNeHT+JWg0Sc5WPNUmDOipev3BHsGATNBF/iNtOlyZLtbiPD/hH5uC+ZuvsdFJz7eRt
 H9VbSkieJiS74mlFaLcm6nDSUjPN9M784BrHCBv/TeNCoqgv+1b6/JL0hKrMqD4jQNaK
 iMHQ==
X-Gm-Message-State: AOJu0YzejzNal26zTglvt8JtlR89wKgxwmSOS+GClgqgnH6Wms8Cuj0T
 p/CHYieu32p1donbY2O3GANpseeu3VNqAA==
X-Google-Smtp-Source: AGHT+IGVNiBTr6nIEP1vCVzDHHnFKArHMz4EWw7ScuFg9qwE6fhPEj1cQsss0C6P9G4SzkHJjouttw==
X-Received: by 2002:a17:90b:1d8c:b0:28b:ea0c:f9b8 with SMTP id
 pf12-20020a17090b1d8c00b0028bea0cf9b8mr920866pjb.64.1704911546278; 
 Wed, 10 Jan 2024 10:32:26 -0800 (PST)
Received: from [192.168.68.110] ([152.234.123.64])
 by smtp.gmail.com with ESMTPSA id
 d11-20020a170902aa8b00b001d4cb49a28bsm3932331plr.277.2024.01.10.10.32.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jan 2024 10:32:25 -0800 (PST)
Message-ID: <de442ad9-0479-4a7e-bccf-97fcd081a35e@ventanamicro.com>
Date: Wed, 10 Jan 2024 15:32:21 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] target/riscv: Enable 'B' extension on max CPU type
Content-Language: en-US
To: Rob Bradford <rbradford@rivosinc.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, atishp@rivosinc.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com
References: <20240109171848.32237-1-rbradford@rivosinc.com>
 <20240109171848.32237-4-rbradford@rivosinc.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240109171848.32237-4-rbradford@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x534.google.com
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



On 1/9/24 14:07, Rob Bradford wrote:
> Signed-off-by: Rob Bradford <rbradford@rivosinc.com>
> ---
>   target/riscv/tcg/tcg-cpu.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index f10871d352..9705daec93 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -999,7 +999,8 @@ static void riscv_init_max_cpu_extensions(Object *obj)
>       const RISCVCPUMultiExtConfig *prop;
>   
>       /* Enable RVG, RVJ and RVV that are disabled by default */
> -    riscv_cpu_set_misa(env, env->misa_mxl, env->misa_ext | RVG | RVJ | RVV);
> +    riscv_cpu_set_misa(env, env->misa_mxl,
> +                       env->misa_ext | RVG | RVJ | RVV | RVB);

I'm aware that we decided a while ago the 'max' CPU could only have non-vendor and
non-experimental extensions enabled. RVB is experimental, so in theory we shouldn't
enable it.

But RVB is an alias for zba, zbb and zbs, extensions that the 'max' CPU is already
enabling. In this case I think it's sensible to enable RVB here since it would just
reflect stuff that it's already happening.


Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>




>   
>       for (prop = riscv_cpu_extensions; prop && prop->name; prop++) {
>           isa_ext_update_enabled(cpu, prop->offset, true);

