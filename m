Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 533FA743D4D
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 16:19:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFEyP-0001OA-QX; Fri, 30 Jun 2023 10:19:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFEyI-0001HN-GZ
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 10:19:38 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFEyG-0003I2-QM
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 10:19:38 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-4fb761efa7aso3092456e87.0
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 07:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688134775; x=1690726775;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=U8i6aJwSo0jzis3W3h3lAz3WKVYWWeVJY1RTONPPpIs=;
 b=n6153ANFevdvro80wTBTZUsuuTDkWG7shNTfNQkRyRlkVUEMQJTlO8gY9Nfp+3+PJX
 tr4dNJk0+hfphK+T8WP4BH44S9GQq/GYeFuJdvlLiyIoKvbNt8clwQBHsh+uHWfVALPV
 udQoYzbp942ojJ/xGP9XWdQNbsw8lZbgRZeEV2tZ1a0KM6b7vwQsCrFUSkUNbcMmplbp
 mr4QnZS0q2b2vrJ5cLv5rI0P9dUQO/N0Rug49reUGsfedjabMc1n26Tl2FrkSW6aNCDd
 nzqV5Lr61bgknyRpGu2zuMiXI5BvzapPdIMJj4OO7a/RrpSHAWJtZPKROjYLC9AQUout
 OMPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688134775; x=1690726775;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=U8i6aJwSo0jzis3W3h3lAz3WKVYWWeVJY1RTONPPpIs=;
 b=XmDcb7/Eq7/CetxmopDuxHh2rDmy7sTCiaN6/6eiEW10Uo01dZbi9/um6ErwBA+Y9x
 4frKchjJWgtGheEn+kAle9ZEuMF39LCNUcRfi8C85iHam5B+t5Uq+IPJP8CGEUMH3Dbz
 Y3EBm9QVrTs2jGsGW6oZaIriDE0odZmBUOhP0W2TuMuHZmKzviLruWpvrX2HMz4C+7oZ
 5b9sLPGkRAeC7c0MVwjkAF4tz4p9ejA1Vxf1c1DqliDn2C4KC5S15mrh28uMYKlce5Uh
 25yzQ7+L5ad7PydVnrwZw0nkoWGa19VW86xjtLzzFsqkNVwLEojMvWlu4a3hPsKO5P7C
 gMog==
X-Gm-Message-State: ABy/qLaHVEeCwOU1WtMn9fG8zNptV+iMdjqtOJf/FS7u6De2gmkdXt5f
 mqcExdTzsayy4YxnRqETcBcrxw==
X-Google-Smtp-Source: APBJJlE2iJBhMemh7TcR+hfU2QI+J5jtpP9w8P2i5UFttUTdMS7B0dhzz6BXSk1YUeoqrf1aMdt2xg==
X-Received: by 2002:a05:6512:308f:b0:4f9:52f3:9a2b with SMTP id
 z15-20020a056512308f00b004f952f39a2bmr2841223lfd.54.1688134774697; 
 Fri, 30 Jun 2023 07:19:34 -0700 (PDT)
Received: from [192.168.1.208] ([139.47.41.96])
 by smtp.gmail.com with ESMTPSA id
 x9-20020a05600c21c900b003fb40ec9475sm12077706wmj.11.2023.06.30.07.19.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Jun 2023 07:19:34 -0700 (PDT)
Message-ID: <bd3618d9-549b-994d-55a9-d333e7f1a905@linaro.org>
Date: Fri, 30 Jun 2023 16:19:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 4/9] include/hw: introduce CPU_MAX_NEGATIVE_ENV_OFFSET
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: ale@rev.ng, pbonzini@redhat.com, eduardo@habkost.net, philmd@linaro.org,
 marcel.apfelbaum@gmail.com, peter.maydell@linaro.org, wangyanan55@huawei.com
References: <20230630122551.21766-1-anjo@rev.ng>
 <20230630122551.21766-5-anjo@rev.ng>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230630122551.21766-5-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x135.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.095,
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

On 6/30/23 14:25, Anton Johansson wrote:
> For reasons related to code-generation quality, the offset of
> CPUTLBDescFast and IcountDecr from CPUArchState needs to fit within
> 11 bits of displacement (arm[32|64] and riscv addressing modes).
> 
> This commit introduces a new constant to store the maximum allowed
> negative offset, so it can be statically asserted to hold later on.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   include/hw/core/cpu.h | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index c226d7263c..0377f74d48 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -259,6 +259,17 @@ struct qemu_work_item;
>   
>   #define CPU_UNSET_NUMA_NODE_ID -1
>   
> +/*
> + * For reasons related to code-generation quality the fast path
> + * CPUTLBDescFast array and IcountDecr fields need to be located within a
> + * small negative offset of CPUArchState.  This requirement comes from
> + * host-specific addressing modes of arm[32|64] and riscv which uses 12-
> + * and 11 bits of displacement respectively.
> + */
> +#define CPU_MIN_DISPLACEMENT_BITS 11
> +#define CPU_MAX_NEGATIVE_ENV_OFFSET \
> +    (-(1 << CPU_MIN_DISPLACEMENT_BITS))

You'd want 6 bits, for AArch64 LDP (7-bit signed immediate).


r~

