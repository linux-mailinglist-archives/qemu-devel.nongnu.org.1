Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 77391773094
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 22:40:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT70y-00028l-9V; Mon, 07 Aug 2023 16:39:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qT70v-00022o-GO
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 16:39:41 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qT70t-0004PV-Dw
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 16:39:41 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-686e29b058cso3477804b3a.1
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 13:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691440778; x=1692045578;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wqP3ahU9WRjLaKvK9Qu5mKDxMCywZy5ruY4d11wZ89w=;
 b=C6VXhQ8Q97+azootpzg1O/gTNJ7s2Z4AGtbRRI3CsTatjkhlDFoUh/MgYya00/N2Yt
 8N/t9oqWFs6FqwQEFcKJQW6098ssb7zfZfXxRohN5wmDx2xDgtbxuJo6Dk9aGgxslvf3
 Z3bj4RIcuhK/txlyMwcVvqRemjvv1SM/0z2O5B2m+cCVb7SiHQOX/Y+XdEpZ4vkmGb1W
 BGIgmH0USR/MtlVR9ZvXFWhds2osoSq+eOahHLdVcnEEVC7TS29zCqKaOGoA4tjfUk4O
 xlF84j/8QsMsFiMaTR8AM5N9bOpaOQw74BJGXlMu+JYMrQReHGgmFNkOpXpl0TNlw5dP
 z88Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691440778; x=1692045578;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wqP3ahU9WRjLaKvK9Qu5mKDxMCywZy5ruY4d11wZ89w=;
 b=aMDB2Qxe03mAQIob5FoIfclhjGxlC+O+z1m1eJXf7ACXO7wliTmuzM1/+GkDgsUUtI
 vCE7WnsYB2rMcfndSO4s9T9+epHoxd/CX/r/ujft0qi4yfcZqKG1kttWIWGEgzaujWLf
 jD/Mm/Zne5MNk5rHg2B7kUwwl45N2o/CDmj8ErLQIkIl6FhoayL9wn6Yqu5s24zxUq6+
 9TN3NBn9r6E3cg92uRH1d1OjXS8XlgJPW8UEjSMn//MQA9Bs5P1IFUSHB7i3wXr75rWv
 fX3x+T7jYXNpYLx+vggVDQpebr+VUMWvdqOTualjNeMwjPTWyB98GhGJBEhpiROobLHV
 aJrQ==
X-Gm-Message-State: AOJu0Yx2ivCT4xiBExSUiubfIraqIw04dfERRwYOJQ8uIEAPx1Uc1r86
 gfD3gDqgn4v45YsQx1nhDQM+Jw==
X-Google-Smtp-Source: AGHT+IEwuACxm8CBwjtQ/xNwZ1HKe6tZH9eJ9dKAYLOTeEEXfR/UUU7SoeK63kTZbILCPcFsxT5uOQ==
X-Received: by 2002:a05:6a20:9390:b0:134:15df:b148 with SMTP id
 x16-20020a056a20939000b0013415dfb148mr11407604pzh.29.1691440777687; 
 Mon, 07 Aug 2023 13:39:37 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:e306:567a:e0a1:341?
 ([2602:47:d490:6901:e306:567a:e0a1:341])
 by smtp.gmail.com with ESMTPSA id
 q24-20020a637518000000b0050f85ef50d1sm5325006pgc.26.2023.08.07.13.39.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Aug 2023 13:39:37 -0700 (PDT)
Message-ID: <8bf33fec-b26c-1f48-d817-319f17b3ad93@linaro.org>
Date: Mon, 7 Aug 2023 13:39:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] target/arm: Catch illegal-exception-return from EL3 with
 bad NSE/NS
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20230807150618.101357-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230807150618.101357-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.809,
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

On 8/7/23 08:06, Peter Maydell wrote:
> The architecture requires (R_TYTWB) that an attempt to return from EL3
> when SCR_EL3.{NSE,NS} are {1,0} is an illegal exception return. (This
> enforces that the CPU can't ever be executing below EL3 with the
> NSE,NS bits indicating an invalid security state.)
> 
> We were missing this check; add it.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/tcg/helper-a64.c | 9 +++++++++
>   1 file changed, 9 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

