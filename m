Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 77FC1748825
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 17:36:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH4Xp-0003jk-RV; Wed, 05 Jul 2023 11:35:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qH4Xm-0003Oa-Og
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 11:35:50 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qH4Xk-0007hR-7o
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 11:35:49 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-4f766777605so10695487e87.1
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 08:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688571346; x=1691163346;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ru07I0h2xoQPCun5MuggERVtGuI5Rom4FGynHtWi0uY=;
 b=DXEhMoIjmzZOkQFZkThKez/eZaK2LXodOUwzi4p7PpotHvVVx1F1YtZobR3Z602JYF
 2VaUJ9n9nB3wtRpEl67kaNRZRGJJxJidMhUkIJHuAFHHfXkYY3Fic68S2NcgFzUCkkIp
 PDxDR9gEokXNi8hUtq5h8Ahl35GB1JBRlPObfvF3cS65lnVYV1G/nfr1H2D06nYfM4U2
 XNkXEgXmxhHipgr3fzX3SjO6XKaqjyshcLcz0UBwnyS6DSF9grsk9tjNftP/9JCVhH4Y
 ta1wDHrNcYD6YL9HU7KNLZAXU0pdWKMYQfe9Jb4CiLISxw7seNFMYY8JNnXvd3M9vVf7
 dJOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688571346; x=1691163346;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ru07I0h2xoQPCun5MuggERVtGuI5Rom4FGynHtWi0uY=;
 b=SUbrbb0eMI6pV0RpHg2QTEty0O0Vw3MpYe+6JhiENb7TpKP9x/0ObVaJzXvU3h3WS9
 IjT5GYe118bGIIIQXLwECUriGS2oXhOiKd+ZeiakPKpp/YQ3ZMg3rFLOMiOOgDehG8sx
 WdCbpbDCXx45lujbCOt187txwYYlGDnzUQ1JUwLAuIrTAVIw/Lw0JaqvJ8o9ZGivLa2o
 CVV2mmryxL4sI3IidbuTN/T07mCdB391NOuq6r8ZdK3ayIGzD29brXhIC38hYcb/cG3w
 OXt+BK2UT2oCSZRNRF/SMvfzSnrNqQV+eNUO6fdoLB4VpwSCVGsYSRVGFRDzCa/k2/io
 RzEw==
X-Gm-Message-State: ABy/qLa37QVoIlSYfcjgJuHd9uSZsc/KtdqdxtqaU/BLb3YqHrfSiPo0
 XuLTbMRh/4j9MVmIHazHKkxCjA==
X-Google-Smtp-Source: APBJJlGYbKUUP8xV5Wf3Y9dIL7r573uh8T9qBNb5Lgwb6JGfiIwMelXiePbm9Y8bwrGW4ARrFpIgsw==
X-Received: by 2002:a05:6512:718:b0:4f9:557e:35ae with SMTP id
 b24-20020a056512071800b004f9557e35aemr10629597lfs.19.1688571345804; 
 Wed, 05 Jul 2023 08:35:45 -0700 (PDT)
Received: from [192.168.82.227] ([91.223.100.51])
 by smtp.gmail.com with ESMTPSA id
 f8-20020a19ae08000000b004fba8ebe559sm2793751lfc.191.2023.07.05.08.35.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jul 2023 08:35:45 -0700 (PDT)
Message-ID: <98c08222-3a29-1e50-86c8-274fced66e29@linaro.org>
Date: Wed, 5 Jul 2023 17:35:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 10/19] hw/timer/arm_timer: Rename arm_timer_init() ->
 arm_timer_new()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Sergey Kambalin <serg.oker@gmail.com>
References: <20230704145012.49870-1-philmd@linaro.org>
 <20230704145012.49870-11-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230704145012.49870-11-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x12d.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 7/4/23 16:50, Philippe Mathieu-Daudé wrote:
> QDev models often use foo_new() as the combination of
> foo_init() + foo_realize(). Here arm_timer_init() is
> a such combination, so rename it as arm_timer_new() to
> emphasis the returned device is already realized.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Reviewed-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   hw/timer/arm_timer.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

