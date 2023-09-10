Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ABFE799C39
	for <lists+qemu-devel@lfdr.de>; Sun, 10 Sep 2023 03:05:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qf8t1-0000f4-EK; Sat, 09 Sep 2023 21:05:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qf8ss-0000WG-KM
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 21:05:06 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qf8sq-0006SJ-EN
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 21:05:06 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-68fba57030fso60272b3a.3
 for <qemu-devel@nongnu.org>; Sat, 09 Sep 2023 18:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694307900; x=1694912700; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aKDYv9yZCJpCXrCRJSwwwHRZvnVLixe/Rwxkw3EnP8o=;
 b=qNw0xeo0lnoqud1dfbmdd16S5bUGdYG5z86PUPnzCP8iYm6q1dqq2BKqBMr9N3ONnB
 ZN4fw1AZTb27xWXEKy43y3aPCtCCvPOJz43VWcDKF/i1w8GyIWdGlj6gHLdU/s295LFZ
 DPdAGtgjIjuSj8EWQKR4Q9hIaKhlx/bh2Aps1hn59N8hzFlZsvZIFGX5vt2q+WkBoYR5
 yMvJS2ksHgAC+YUcXyiLc7b9ra/CEVv74ewxDjpTnMbsI3673JCLPfWJSIrdeiQX3Vej
 /f3byIo/bkiPvEjo4HdpNrVfrmyg2fh2G7/KuFLhHHi5Xrxwes6Gmt/746/jBnjKyMy9
 hVyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694307900; x=1694912700;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aKDYv9yZCJpCXrCRJSwwwHRZvnVLixe/Rwxkw3EnP8o=;
 b=Fjp14jKaPdprV/f93kpZwtitQEVH81FZcyPllJwPT4ESJpIX2V/fyMAWUBKWtEg73w
 jyJS3yTv8yAJJZEQy3fr/tskzdte3BSMmuw7cnakhe/hrRGKICavLSR4thib4KyxYbX/
 VLRd9XKIBMEzwkfQPg7VZ7wdestsXYgczKkVAGYAkm5249vfxozlp9mD/x2J7L+EJ850
 U8J/bD3yZqhsIfJIFmawrKeXciaQazC4qucwjV5VOjmlS9wq5Ihybkx5/Db/rRWSkR26
 mJlBYFpsum8X/F7ApIvpasaH4QhWVoKmefRUs70d5NgklAyEgxc7y63la7qVjJ2BMtTq
 tcuw==
X-Gm-Message-State: AOJu0YyL86iOcIhyG9MN75b0xVQbKELwEF8yFQ2E6MKj5M93AQcBY+JT
 fZ3uXhqf+IgZ096mu7R+H5T9TccaK3afzU+l57o=
X-Google-Smtp-Source: AGHT+IHOu31OrB35GXAHAkMezRVKRhCYMgGjBb4Vgly1KwBHaaO8JGVpaLrmcWkjWFff5ZxK+dWdxQ==
X-Received: by 2002:a17:902:d4c6:b0:1c3:8464:cad1 with SMTP id
 o6-20020a170902d4c600b001c38464cad1mr6191243plg.26.1694307900541; 
 Sat, 09 Sep 2023 18:05:00 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 u2-20020a17090341c200b001bba373919bsm3748339ple.261.2023.09.09.18.04.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Sep 2023 18:04:59 -0700 (PDT)
Message-ID: <261dc21a-648c-98f6-393f-343e6e89b5e0@linaro.org>
Date: Sat, 9 Sep 2023 18:04:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH RESEND v5 10/57] target/loongarch: Replace CHECK_SXE to
 check_vec(ctx, 16)
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: maobibo@loongson.cn
References: <20230907083158.3975132-1-gaosong@loongson.cn>
 <20230907083158.3975132-11-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230907083158.3975132-11-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

On 9/7/23 01:31, Song Gao wrote:
> Intrudce a new function check_vec to replace CHECK_SXE
> 
> Signed-off-by: Song Gao<gaosong@loongson.cn>
> ---
>   target/loongarch/insn_trans/trans_vec.c.inc | 248 +++++++++++++++-----
>   1 file changed, 192 insertions(+), 56 deletions(-)

Introduce.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

