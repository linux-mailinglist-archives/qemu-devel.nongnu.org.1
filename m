Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6B67487F3
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 17:26:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH4Oy-00033F-08; Wed, 05 Jul 2023 11:26:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qH4Os-00032O-Nl
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 11:26:38 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qH4Oq-0004cB-QZ
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 11:26:38 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-4faaaa476a9so11108745e87.2
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 08:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688570795; x=1691162795;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=B2Yile8esPPs/3ib7DpmTipXPKTF/5nmpEd6mDvqcWs=;
 b=KcZVLHmxf7RLbFfMarv4CFNu6NXbhrjMK+uAoOvZSJmovqmxQvh6H7BGbLHvaqLKGm
 2//EMXFkEXutnC5sh21PfQDb/jNQMg7K/hmBkL3P5W03q3oK1nOW7HBgeRN6ggopQEl9
 y97Ns5ARNLDtkND5P4Y4it82rkByiUEwYU7bf+6QSxdzUR04o7rqgoHuN4d949oBfzU+
 YKFByQ5LDSouUoQs/Ynqq3avsLRjbYVIRamFgCoVsBlCF6cpu0CnuXp81FwV0IZDH1ZF
 yg0QpPPCJBxSzujr2+Wo3Pux4tgcqwYGrlP6QkNLD31Tm866UmZbxOP23gcoQ/Aak1gr
 xyXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688570795; x=1691162795;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=B2Yile8esPPs/3ib7DpmTipXPKTF/5nmpEd6mDvqcWs=;
 b=Hh1nofC1TEkWRjEj9oB+qBNPQkir1X6uMTuAO6wSi0VvFJStuPuJIdAFJ0LjQk3I9E
 0yoZJxB59f6lbNet2RyCICSnaS+Ojm1HRjZxUfr5Cx4pgWuVM62ipkmPhJ9xzxNmqOxN
 zKk1Fn+ISAhNX7kCG78soklsHqcbDc4y4VxRt0EoxKfDKCng6vqb9y3mrH2duM989PAs
 hE8BXhMtYBnGw6qZq6BkV7nVJSEJsU4tIUwN9QfEnTieEtE9M17p/DpS7FjNJLlAAES/
 OscjyHA4r9129DxuFcTynpcWOVPYIb8d2023FXf8lPVv6f0HuXJPJ9qwlmCTbG7r3bRv
 9CpA==
X-Gm-Message-State: ABy/qLaM33gLyJx3o7NCBKpun3G9UnwHyBkwVM6Ki/ThXc4Js7QayRYP
 IoNm7QPi54Rp/NW4mqQ5Tyj2Gg==
X-Google-Smtp-Source: APBJJlERAlxBrejw+lOiHjyBMSrD4F88T/v5gQ6a9BqZCV+y7mv7ergsIKNBU3yOKU2vXsTzQAaovg==
X-Received: by 2002:a05:6512:714:b0:4f8:554f:36aa with SMTP id
 b20-20020a056512071400b004f8554f36aamr10002200lfs.29.1688570794934; 
 Wed, 05 Jul 2023 08:26:34 -0700 (PDT)
Received: from [192.168.82.227] ([91.223.100.51])
 by smtp.gmail.com with ESMTPSA id
 t3-20020a19ad03000000b004fa52552c82sm5410694lfc.155.2023.07.05.08.26.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jul 2023 08:26:34 -0700 (PDT)
Message-ID: <9ff6e150-5556-8a2a-5e0f-078cb9fae595@linaro.org>
Date: Wed, 5 Jul 2023 17:26:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 02/19] hw/timer/arm_timer: Remove pointless cast from
 void *
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Sergey Kambalin <serg.oker@gmail.com>
References: <20230704145012.49870-1-philmd@linaro.org>
 <20230704145012.49870-3-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230704145012.49870-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x12e.google.com
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

On 7/4/23 16:49, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Reviewed-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   hw/timer/arm_timer.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

