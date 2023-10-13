Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E1B7C7C79
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 06:10:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qr9UI-000347-Ua; Fri, 13 Oct 2023 00:09:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qr9UF-00033c-9u
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 00:09:19 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qr9UB-000651-MD
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 00:09:18 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-69af8a42066so1348428b3a.1
 for <qemu-devel@nongnu.org>; Thu, 12 Oct 2023 21:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697170154; x=1697774954; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=R+3CHnnNXz5apczQezbSmipXowkAp82423sOaMdNjdQ=;
 b=jOp14oAFoKIxk/HDuV6rOtw+IPWOVRH0pALQaawn4hKDmZ3fSiWoy5v+GesXXjeWS0
 pHHfFlfQw3PYqck1R3JAqSfpB5PyquH4u7qhvL3QP5dtnsh653GO0AWjpiM1zVLtjh4r
 Q3bnh1FVYf3aNkiKT03gx8ovrdIGxFPlTJlH2qmJ7e3pJ8qW3hBfknYJu/jzgdQ2987T
 s+fbWRjWfXC6Sz6pfaqQHYIcV/WTIgGdSG2wE8SgquwKbdVdwcEw42MBxYyoKgisFS3a
 IaBIxl51VPjnwlJeFXwlQtT6+ATO3wWj5KjMSWzgBC1VRDOIfyWDdh4JMvMLIkVmcKB1
 v2jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697170154; x=1697774954;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=R+3CHnnNXz5apczQezbSmipXowkAp82423sOaMdNjdQ=;
 b=IkoVQFGNxyP/jgWLXW2nWCCQgZqx82teoX3WE7Lu+XFvT5MWL3oxXUsfioP1bo1sCS
 oa5b6ux8UhWWphyYToW81wMiAdmwnfF+W9smi5idtsAXOl1wJtmkPIB5gDl8zz0pZuh+
 HhIIobdiopOVDzr65Gh7gb0AUkCzvY1k1idVEBM1YVR8JoG5560btIZ0oRa13G21CsJz
 n69mFxbl3aihu2K8X33+eeIRH2/JPjZK4Spg5y1B+zdS96uVkbP1nrU0x08Agun38ux+
 skr67YLgtdaZXA7Dj7uVGFurJN7RkccnM42nacp/cy2mqWTZiXllc6EtpThAaiyXs5g9
 P7hA==
X-Gm-Message-State: AOJu0YyB4Qxe1xRzvgy94bErZ2GxAuygfKPGdKWTF9+Psa3VTC9c+cOu
 +ZBqY5c8TacPVIX1Lrp1qLqWoQ==
X-Google-Smtp-Source: AGHT+IGYhRG4XNDabUDoe6vxDwgEpAHeJ4VZGNmFqqgr1Pt0usmYr9AJBs7zq6CH5rutIQop+hnFiQ==
X-Received: by 2002:a05:6a20:970c:b0:163:2dc7:d077 with SMTP id
 hr12-20020a056a20970c00b001632dc7d077mr20100863pzc.55.1697170153859; 
 Thu, 12 Oct 2023 21:09:13 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 ft9-20020a17090b0f8900b0027b13db9729sm2622014pjb.21.2023.10.12.21.09.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Oct 2023 21:09:13 -0700 (PDT)
Message-ID: <d8dc3061-4504-4e74-be68-44415d0d3a36@linaro.org>
Date: Thu, 12 Oct 2023 21:09:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/18] target/i386: Inline target specific
 TARGET_DEFAULT_CPU_TYPE definition
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20231010092901.99189-1-philmd@linaro.org>
 <20231010092901.99189-10-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231010092901.99189-10-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 10/10/23 02:28, Philippe Mathieu-Daudé wrote:
> TARGET_DEFAULT_CPU_TYPE depends on the TARGET_X86_64 definition
> which is target specific. Such target specific definition taint
> "cpu-qom.h".
> 
> Since "cpu-qom.h" must be target agnostic, remove this target
> specific definition uses by inlining TARGET_DEFAULT_CPU_TYPE in
> the two machines using it.
> 
> "target/i386/cpu-qom.h" is now fully target agnostic.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/i386/cpu.h | 6 ------
>   hw/i386/microvm.c | 6 +++++-
>   hw/i386/pc.c      | 6 +++++-
>   3 files changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 862e4f1ff5..7c976971c7 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -2243,12 +2243,6 @@ uint64_t cpu_get_tsc(CPUX86State *env);
>   
>   #define CPU_RESOLVING_TYPE TYPE_X86_CPU
>   
> -#ifdef TARGET_X86_64
> -#define TARGET_DEFAULT_CPU_TYPE X86_CPU_TYPE_NAME("qemu64")
> -#else
> -#define TARGET_DEFAULT_CPU_TYPE X86_CPU_TYPE_NAME("qemu32")
> -#endif
> -
>   #define cpu_list x86_cpu_list

This isn't cpu-qom.h, so the entire patch description is off...


r~

