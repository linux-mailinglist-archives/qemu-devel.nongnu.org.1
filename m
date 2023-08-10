Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4556B777A2C
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 16:11:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU6ME-00034y-VC; Thu, 10 Aug 2023 10:09:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qU6MB-00034T-UL
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 10:09:43 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qU6MA-0003DW-FG
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 10:09:43 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1bbc06f830aso7201745ad.0
 for <qemu-devel@nongnu.org>; Thu, 10 Aug 2023 07:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691676578; x=1692281378;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QnAEQiOQvtmH7zQVaumoa+YUlWC1yT129NWP6qmFRFA=;
 b=va9Ol2CZHGD3BkJ7OlKKE/zyMJ6xUiHQ9lT7/VdItpk+rnt2bK2MDOM3jKGLCG5AfH
 p+dvcoO1sNJpPRCguLvYWkHjgEYAZE6tHI/jAbbGNDYNwN0Vb5sHTkZ2cIZXO0in5oxt
 0k7HgccJZgPre/Hfqf/Dx+m8+XWqv45rfbqtvkSjkh0kWGx+sysmjQxcTu0n8VeAO05X
 f7yw6GJ+SJsipykxeaiC2LB2NwHG4vBVk4MSoa8uyMs01NrGOG+QXGkBJ0oc8+JG9VPP
 1VI3KMj9ho+vMYrvovVMz4dWXe6mx+icqnA2NYTpad/n/PO+JG11oYydylRm1iQU3GIn
 ysQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691676578; x=1692281378;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QnAEQiOQvtmH7zQVaumoa+YUlWC1yT129NWP6qmFRFA=;
 b=bwHhAaU3q9d5Ku8iGlTY0K1fTxERThJ8Zjx6sa9kqGsnDiZ+Z4S3k4+EAhVHJQFpl1
 oj+qSzxze4qjvSNC2Ga7ZBplBUGY30bLohylHn5Xsf49wpocZpZbUuPBgUuPJt0rzLeB
 +qHZ3WLeXXw1aN2QT5+SNa865PU1kIc+MdHLWRv1YH4rMAZTh6h2kQiISqIoxe08g2rB
 4VIvGf7U6w5OtZ2B5of/nA5dYJ51yfTIJPlMtfKwmj7hJ5AbujRE31XOwiT3Zv8Efsch
 PGS34AqWFLXtXeCca6T0Tdx9a2O5xTMZe8yZvuT+TNhnkEv4RK1JWaipAHo340+1V5ZO
 mcCA==
X-Gm-Message-State: AOJu0YwNaJK2T96a15x7GvQS3CyOCEf2aQsVo2FTmC0bjsxhhLiFT2Rj
 9knh31ohUGFEYnfq8c8Z0Y4q3Q==
X-Google-Smtp-Source: AGHT+IENsjFCevz+VcNDqStlsN5M7bIbw5RJkc8wPY87gs+1xJvMBtEGkImMX5Xyg/RtnYraIvh6bg==
X-Received: by 2002:a17:902:eccf:b0:1bc:210d:6365 with SMTP id
 a15-20020a170902eccf00b001bc210d6365mr2951246plh.2.1691676578292; 
 Thu, 10 Aug 2023 07:09:38 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:9e4d:b830:d4fd:9164?
 ([2602:47:d483:7301:9e4d:b830:d4fd:9164])
 by smtp.gmail.com with ESMTPSA id
 n6-20020a170902e54600b001b88da737c6sm1800324plf.54.2023.08.10.07.09.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Aug 2023 07:09:37 -0700 (PDT)
Message-ID: <72c80cd0-9ce7-5610-c4c0-0d09b1f1e5ac@linaro.org>
Date: Thu, 10 Aug 2023 07:09:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 1/6] target/loongarch: Fix loongarch_la464_initfn()
 misses setting LSPW.
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, maobibo@loongson.cn, yangxiaojuan@loongson.cn
References: <20230810124112.236640-1-gaosong@loongson.cn>
 <20230810124112.236640-2-gaosong@loongson.cn>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230810124112.236640-2-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.156,
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

On 8/10/23 05:41, Song Gao wrote:
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   target/loongarch/cpu.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
> index dd1cd7d7d2..95e00a044c 100644
> --- a/target/loongarch/cpu.c
> +++ b/target/loongarch/cpu.c
> @@ -391,6 +391,7 @@ static void loongarch_la464_initfn(Object *obj)
>       data = FIELD_DP32(data, CPUCFG2, LSX, 1),
>       data = FIELD_DP32(data, CPUCFG2, LLFTP, 1);
>       data = FIELD_DP32(data, CPUCFG2, LLFTP_VER, 1);
> +    data = FIELD_DP32(data, CPUCFG2, LSPW, 1);
>       data = FIELD_DP32(data, CPUCFG2, LAM, 1);
>       env->cpucfg[2] = data;
>   

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

