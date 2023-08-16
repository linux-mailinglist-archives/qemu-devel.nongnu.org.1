Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B25677E58C
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 17:49:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWIka-0005lb-Rf; Wed, 16 Aug 2023 11:48:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qWIkX-0005l0-QG
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 11:47:58 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qWIkV-0005lr-IJ
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 11:47:57 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-26b1adbd655so3243758a91.1
 for <qemu-devel@nongnu.org>; Wed, 16 Aug 2023 08:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692200874; x=1692805674;
 h=content-transfer-encoding:in-reply-to:cc:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yY+xq14sElJyUOtPCOabxPDRCRgcN5QyILAOVkD09Qs=;
 b=no6rmilN6N8BZtXVt/tkndcYs7eu6gh9EFfKrm0jT5DJ0qLJLo1L5iEHOb7PtdVa17
 a/fmKujAcrW2L5KJHH8NRNAbdkezXi15a9FnVVEe+LjkK5zH4RmISibDAJGwVyBtvNKs
 OgEXneKpTQMhRg0cSnQmvMpEwDvrfGZe3o+k2M0bWw8NYI9A17TIL5jfdiVMgYOLBvrS
 LWsBJ2Ymo/OXinqoYSJt5uaTIoUJHuGbug9MrYk9Vvs6aJaM5aNWMq/24NVXXqBW2SmF
 5KHFT8IuDholuRHvbKXxy4k4iEWbJgcq8mgQtAGaErSb6G4Wo2dAbH5hhTtnFByLuejM
 VaIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692200874; x=1692805674;
 h=content-transfer-encoding:in-reply-to:cc:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yY+xq14sElJyUOtPCOabxPDRCRgcN5QyILAOVkD09Qs=;
 b=C5QopmZ5b1IC+hP1EFG4DCVy8DegUk9E4lnfZ4Q+7iESa3UTh2f7soMtxRIJf7Bd5i
 pmAcgIQfWjAywM73nqV4QVZorhiTWXtsuNcP+W8aDxyu11atP+nLvRVWdOQrrPLHSpax
 hGJtEzwth8GPmoaLnPCTDX4r0F4Uq9X4D0zDTt+0IypXTmWwUC30zjxz5mdfhFbWb3/V
 YT3+9vdEY9l5K6qXiawrrfUai3v4ttyJF0vu2lCRNt/9UJFR7zMHFSA4u6Ru9fEdXKJU
 ryv0Eky6PnEu0p5qVxRE0uSmfDnvoc+7kKUFSITxLb8gvDHo/y4vTobzqCkVtAFax5qh
 QkRg==
X-Gm-Message-State: AOJu0YzdpZZZoBSvmmdlHnQb49/t5C2xAIHL/82+BK5qaeZgPADf0nmJ
 OPNEJsIz5PgEXs23MDBveJ8Esi8NAfGcO8D/CqY=
X-Google-Smtp-Source: AGHT+IHHOYyMrAkm3BB/RSGEoWd7fEcmBB0Wq8ntlODE/ZaPtSJmF2TaUV4EjINYhyNAGa1s4n8nQw==
X-Received: by 2002:a17:90b:4c4f:b0:261:688:fd91 with SMTP id
 np15-20020a17090b4c4f00b002610688fd91mr1737500pjb.8.1692200873914; 
 Wed, 16 Aug 2023 08:47:53 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:a064:e3f9:a812:973b?
 ([2602:47:d483:7301:a064:e3f9:a812:973b])
 by smtp.gmail.com with ESMTPSA id
 5-20020a17090a018500b0026b0b4ed7b1sm12179466pjc.15.2023.08.16.08.47.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Aug 2023 08:47:53 -0700 (PDT)
Message-ID: <3461575d-6f5f-ffd0-4392-dbd9a84bfdc0@linaro.org>
Date: Wed, 16 Aug 2023 08:47:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 05/25] target/arm: Move the reference to arm-core.xml
Content-Language: en-US
To: Akihiko Odaki <akihiko.odaki@daynix.com>
References: <20230816145155.21049-1-akihiko.odaki@daynix.com>
 <20230816145155.21049-6-akihiko.odaki@daynix.com>
From: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>
In-Reply-To: <20230816145155.21049-6-akihiko.odaki@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.165,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 8/16/23 07:51, Akihiko Odaki wrote:
> Some subclasses overwrite gdb_core_xml_file member but others don't.
> Always initialize the member in the subclasses for consistency.
> 
> This especially helps for AArch64; in a following change, the file
> specified by gdb_core_xml_file is always looked up even if it's going to
> be overwritten later. Looking up arm-core.xml results in an error as
> it will not be embedded in the AArch64 build.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   target/arm/cpu.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 93c28d50e5..d71a162070 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -2354,7 +2354,6 @@ static void arm_cpu_class_init(ObjectClass *oc, void *data)
>       cc->sysemu_ops = &arm_sysemu_ops;
>   #endif
>       cc->gdb_num_core_regs = 26;
> -    cc->gdb_core_xml_file = "arm-core.xml";
>       cc->gdb_arch_name = arm_gdb_arch_name;
>       cc->gdb_get_dynamic_xml = arm_gdb_get_dynamic_xml;
>       cc->gdb_stop_before_watchpoint = true;
> @@ -2376,8 +2375,10 @@ static void arm_cpu_instance_init(Object *obj)
>   static void cpu_register_class_init(ObjectClass *oc, void *data)
>   {
>       ARMCPUClass *acc = ARM_CPU_CLASS(oc);
> +    CPUClass *cc = CPU_CLASS(acc);
>   
>       acc->info = data;
> +    cc->gdb_core_xml_file = "arm-core.xml";
>   }
>   
>   void arm_cpu_register(const ARMCPUInfo *info)

I guess this is ok.  I was going to say that the gdb_num_core_regs should be moved too 
(into here and into the m-profile copy).  But that gets fixed in the next patch.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

