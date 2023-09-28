Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D3547B279F
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 23:40:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlyk6-0003B0-5n; Thu, 28 Sep 2023 17:40:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qlyk5-0003An-0X
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 17:40:17 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qlyk3-0006ux-Cr
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 17:40:16 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2777a5e22b5so5534604a91.1
 for <qemu-devel@nongnu.org>; Thu, 28 Sep 2023 14:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695937214; x=1696542014; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rPoF1h8neW9FVdlqtneGAGk+0DxxTqlRTNk6aWj2UWs=;
 b=VtpIsMsBsKiZNonXfKxlvUjqpXlxlWe34eGZZ6sOmSFntkwJHN58StW/jt6HFuKLLN
 vT6vbLhtXuZkEBELxKkVUVeeKgnkLtGECv6ESB1ANcSbjFOgpf9Yq3YaNMNZ0vv0VQdI
 KZAwdYVoEfZceS6nYsBfy9OzwMNL9E4I78YvlrU3WoX2P49rU+drlJe8G4clJJ1OyNh9
 nLcjGnFRMGeImfCevqLrfq1/GlsnX+orfCPyl+kWMxNpLWUaJIH5zoXyj5k4sqnbNxid
 eOZyLjffuzMcyoHu84afj+qmByj21qASfiJh9XnH+5UBukyyJWMsQztuqrY7BDjNXwm/
 fCgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695937214; x=1696542014;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rPoF1h8neW9FVdlqtneGAGk+0DxxTqlRTNk6aWj2UWs=;
 b=ATSKVRhaxMeXR8eBj77NyshV3bcKSWey7RRg9YW/qcPNKH5LAFn9nQXcfzgUE9N4sm
 Dkut1mJtHq9gEYXn4u6UJsffhGSv4ZD2U0HyntOMSpWswbeLqv6WvBvU29cVM80MIFBQ
 LE8ePLNd4qqwX2j/6IQRjS3gncY/J08rYdGMnrX2RbRkcySyIug9n7tOMdHJcc0uv30H
 yH0zVGt5357vdgTYdzFzOII+EWt1vliG2n2x2M5/wKSuTLIVOv5gswMe6gqV95tSlAx7
 klfWzA82bMbQ8HSQxBjAFKSaRe4+TA+oO44IQ8GeFFJCBR72+ku2d1KhxxEmJoInwxlc
 qOCA==
X-Gm-Message-State: AOJu0Yx2rBj95VH/2Sch4LIbmubhacXFOq0qe5dxiy2XvJro0vFpCAOG
 V49BE21HfsPu3w2ISkuY9mLw3w==
X-Google-Smtp-Source: AGHT+IFUMC+kyianhyv1+lITZFIExDrADR6h8fxCUII3MtkRBkXnPWZLXXh17KDe+KEIaNWgMaML0g==
X-Received: by 2002:a17:90a:bc92:b0:273:4944:2eba with SMTP id
 x18-20020a17090abc9200b0027349442ebamr2360564pjr.40.1695937213816; 
 Thu, 28 Sep 2023 14:40:13 -0700 (PDT)
Received: from [192.168.0.4] (174-21-146-124.tukw.qwest.net. [174.21.146.124])
 by smtp.gmail.com with ESMTPSA id
 23-20020a17090a031700b0025dc5749b4csm20416pje.21.2023.09.28.14.40.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Sep 2023 14:40:13 -0700 (PDT)
Message-ID: <a617709e-4567-a10e-26e0-e4ffb2308573@linaro.org>
Date: Thu, 28 Sep 2023 14:40:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 8/8] target/sparc: Fix VIS subtraction instructions.
Content-Language: en-US
To: Nick Bowler <nbowler@draconx.ca>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
References: <20230925050545.30912-1-nbowler@draconx.ca>
 <20230925050545.30912-9-nbowler@draconx.ca>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230925050545.30912-9-nbowler@draconx.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 9/24/23 01:03, Nick Bowler wrote:
> All of the VIS subtraction instructions are documented to subtract the
> second input operand from the first.  This is also consistent with how
> the instructions actually work on a real UltraSparc II.
> 
> But the emulator is implementing the subtraction in the wrong order,
> subtracting the first input from the second, so the results are wrong
> in all nontrivial cases.
> 
> Signed-off-by: Nick Bowler <nbowler@draconx.ca>
> ---
>   target/sparc/vis_helper.c | 18 +++++++++---------
>   1 file changed, 9 insertions(+), 9 deletions(-)

While this patch works, better to use

void tcg_gen_vec_add16_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b);
void tcg_gen_vec_add16_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b);
void tcg_gen_vec_add32_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b);

void tcg_gen_vec_sub16_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b);
void tcg_gen_vec_sub16_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b);
void tcg_gen_vec_sub32_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b);

from "tcg/tcg-op-gvec.h" and remove the sparc helpers.


r~

