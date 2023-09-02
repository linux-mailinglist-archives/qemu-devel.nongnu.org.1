Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 724F7790A45
	for <lists+qemu-devel@lfdr.de>; Sun,  3 Sep 2023 01:32:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qca4s-0006pE-3z; Sat, 02 Sep 2023 19:30:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qca4p-0006l2-Vo
 for qemu-devel@nongnu.org; Sat, 02 Sep 2023 19:30:52 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qca4n-0004BA-Oa
 for qemu-devel@nongnu.org; Sat, 02 Sep 2023 19:30:51 -0400
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-6bb07d274feso280147a34.0
 for <qemu-devel@nongnu.org>; Sat, 02 Sep 2023 16:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693697448; x=1694302248; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KlpQPze/1zQAit7wFYZnAJ0Gz85EPbHjOHFa/p77/DQ=;
 b=XNdv2PM2VSiLRqHHRisiF0JnX36DqG10xC9J+peG20uQiCUfg0Cdx16t/VFYGZ501E
 4Locxz03p/AzlRh9IxV1SvJf7BrHHWcqIUQQnAEvwWEDGJ4mKy+SuNymFBXHU+55oYuS
 YnIkNUC2WwercmcBVt02qAN+YpG5WbjHfwwT0S/KqgBObyEb+EPz1R0xENYTeSpeaw4t
 jXEyvU0WQylAZRwLH4BSph1pg2wiTu3mKd8Tb7O0x19QTQSIa2c7oKTrdwU7W8RHWN9e
 00a0Z9jzJum0+vfZ3/CNByqAWVhPvUene073omZWdtJ8dsoVT+Y9g0eaDoqAWIGMIyEw
 mBIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693697448; x=1694302248;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KlpQPze/1zQAit7wFYZnAJ0Gz85EPbHjOHFa/p77/DQ=;
 b=J4qSumbs2P3aSFxhDS37GlfoZVzJIPEGYLkuF32fNJH8neFLnosl+QY4i8h5QC061J
 bC0IQuLQHK4w2EQ2AvS5B7qSUaK9EYBy4Ut9fM47yP/cqlLgCj0v0iCksBWt8QZrWp8w
 CiaNlcSfD70bWbgsBqK/24o5KJf6J+CrCyhywCODXrGoRKRHzPo3mvnf2O9QYHKmc8N8
 V4BeZG2c0TlGvaYSQHZxIZKCQFIMmDsgty93RVx69rAL06G05PDateXmgFVOeWKX9Er2
 Yb8gTUyRkjd+kc3t1BOwfQCUTwDsiJe9hO8NpAFxZ6qnrJR2nbASGNW3T3aKrRqAP8M8
 ev3Q==
X-Gm-Message-State: AOJu0YwY3CxsyqBH+YPF7OCU+j5Iu3ykvC2nlg6hsluobLr3zdNntfT2
 Yo4WACJQHE2YAO0dEYLjfBccvw==
X-Google-Smtp-Source: AGHT+IGzJKG3SogagUogaUEipBz0mxjYCuqqkHgwRXyALduIXic5Zz5lJFoNUp4bP6a1RVFTT3vpdQ==
X-Received: by 2002:a9d:7443:0:b0:6b9:cba6:b246 with SMTP id
 p3-20020a9d7443000000b006b9cba6b246mr6421682otk.9.1693697447778; 
 Sat, 02 Sep 2023 16:30:47 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 h8-20020a170902748800b001bdca6456b9sm5088642pll.17.2023.09.02.16.30.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 02 Sep 2023 16:30:47 -0700 (PDT)
Message-ID: <e6aef46b-e23d-daf8-b258-c43a185f0a41@linaro.org>
Date: Sat, 2 Sep 2023 16:30:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 06/15] configure: remove boolean variables for targets
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20230902125934.113017-1-pbonzini@redhat.com>
 <20230902125934.113017-7-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230902125934.113017-7-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x329.google.com
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

On 9/2/23 05:59, Paolo Bonzini wrote:
> Just use $targetos always.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   configure | 55 +++++++++++++------------------------------------------
>   1 file changed, 13 insertions(+), 42 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

