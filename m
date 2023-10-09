Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0DE7BDA3E
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 13:47:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpohu-0003O9-4Q; Mon, 09 Oct 2023 07:45:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qpohk-0003JB-MY
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 07:45:44 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qpohi-0003gp-7i
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 07:45:44 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1c877f27e8fso35136275ad.1
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 04:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1696851939; x=1697456739; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PPonpOK0od+dn5EFgbrIZZ8JVanHxWrm5XlWfzQyIbo=;
 b=GcILGU+XHmS32ta+F7gtbc/CIndHGNjmdAeLTW6/6J63SD/48x9DsM7lYVEhuV89ut
 5+RRRokFVHB7ky5/USZZzKvQQO8Dtp8dz4aXveb01zqv3JZsTRTOWOjVm7xv2HwuENWM
 HVTPas+BQ0pNreru96eh8DW/azu5dbC/ydIgdLm039OE+gf7LFo63yXA9qvxViRsp64i
 yooBMbVt9Ac8m+O5LsHfRnfZzo+ekMv6GazxI+YNewOBU6Kyiiiy2N1hkxVVXXF7gODD
 gSNPcQ5BhfD+4SxfFR9XXixgRKMMZkx+038zxUKsjus6Mf0AbpZ/IT6gFFlibTFzVrls
 CLeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696851939; x=1697456739;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PPonpOK0od+dn5EFgbrIZZ8JVanHxWrm5XlWfzQyIbo=;
 b=iRbzsyM/6IAZaQBObxrd5tluBkOM7mWICM8JihU/7q9yoOvSnBt91dTUydecZl2K//
 CrHTr38WoJpwwmzLU0VWoHbc+C+7GojGY9Mcf5VC3/XJPgtxWwDGz3BOYw/j82ACob85
 SvetneUimkK1xpP+CfgSqW7rV0onnC/1CzecZyeZ9M1mqztGz3SWUmuPLKmVJ580qlN/
 W1SZ2SYwbci+MJQJCGABGuij9uIoMdSNcfQmTLUu81cK+4ftEgMVgFzI5Ctd3ALJW9EE
 lpEQV3CIRailSUozHuCjsfDLHoBlZ0CaQT0+TfuGneeoYDmw4GGivrNwNd7dk+FvWfTt
 QLrg==
X-Gm-Message-State: AOJu0YyGksIHjgZFy72P8R4+F6UUmasqKvTur6k9LdaOuG7iVkvP4TkN
 LasViuzDiJMHNsR1Xp1UpoDT/Ldk2MTObQvn74s=
X-Google-Smtp-Source: AGHT+IGZ6nRJh5cL/AJ65Cu/iAshCY1yyfIOOSuuAcRqsRKkmOTcnt3nfwzquMfKtjJ0Y7ilSI4loQ==
X-Received: by 2002:a17:902:9a44:b0:1be:384:7b29 with SMTP id
 x4-20020a1709029a4400b001be03847b29mr13899958plv.34.1696851939335; 
 Mon, 09 Oct 2023 04:45:39 -0700 (PDT)
Received: from [192.168.68.108] ([177.94.42.196])
 by smtp.gmail.com with ESMTPSA id
 y7-20020a17090322c700b001c726147a46sm9340195plg.234.2023.10.09.04.45.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Oct 2023 04:45:38 -0700 (PDT)
Message-ID: <7e31c247-23a2-41b9-bd25-86a21f06e819@ventanamicro.com>
Date: Mon, 9 Oct 2023 08:45:33 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] target/ppc: Use env_archcpu() in
 helper_book3s_msgsndp()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 qemu-s390x@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 Bin Meng <bin.meng@windriver.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Cameron Esfahani <dirty@apple.com>, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, Max Filippov <jcmvbkbc@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Nicholas Piggin <npiggin@gmail.com>
References: <20231009110239.66778-1-philmd@linaro.org>
 <20231009110239.66778-2-philmd@linaro.org>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20231009110239.66778-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x634.google.com
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



On 10/9/23 08:02, Philippe Mathieu-Daudé wrote:
> When CPUArchState* is available (here CPUPPCState*), we
> can use the fast env_archcpu() macro to get ArchCPU* (here
> PowerPCCPU*). The QOM cast POWERPC_CPU() macro will be
> slower when building with --enable-qom-cast-debug.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/ppc/excp_helper.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index 7926114d5c..a42743a3e0 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -3136,7 +3136,7 @@ void helper_book3s_msgclrp(CPUPPCState *env, target_ulong rb)
>   void helper_book3s_msgsndp(CPUPPCState *env, target_ulong rb)
>   {
>       CPUState *cs = env_cpu(env);
> -    PowerPCCPU *cpu = POWERPC_CPU(cs);
> +    PowerPCCPU *cpu = env_archcpu(env);


Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>       CPUState *ccs;
>       uint32_t nr_threads = cs->nr_threads;
>       int ttir = rb & PPC_BITMASK(57, 63);

