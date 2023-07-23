Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B31A75E2ED
	for <lists+qemu-devel@lfdr.de>; Sun, 23 Jul 2023 17:50:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNbK3-00083N-P7; Sun, 23 Jul 2023 11:48:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qNbK2-00082s-Al
 for qemu-devel@nongnu.org; Sun, 23 Jul 2023 11:48:38 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qNbK0-0006qw-Ox
 for qemu-devel@nongnu.org; Sun, 23 Jul 2023 11:48:38 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3fbc63c2e84so33539055e9.3
 for <qemu-devel@nongnu.org>; Sun, 23 Jul 2023 08:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690127315; x=1690732115;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Q+kr7SLHmjKHPZehm34/UP6SZCQ7koEyHzzD7U3bLCU=;
 b=Gfc5cFdEf10FitylbTLMLliSD9L3SaV8Buo+dccE11UZfAYhnVblUMbMcQ9Kbn1TzO
 EssrGDv4qXavNCfMEysZePS+Daoc9beW9y/x5mTlLnSMPNswxmW/oylb4wuaiMg/8jGK
 DlYPkBVFC2e+1tUS5FZieTkvMQYd4sWfNuSahPfLnyWGafpr/3cFhScFJbv1vkALp0Sb
 gz/uB2fRxFcyzBEoRRn2kHTqQN2BSUF2OC6vivZsL0nUKfNPQEdymVKrGfmcJLRUv3Wd
 yEguhKusflngfUalNOFmn9Xaop7LWctEd20fzvQ98HlCfW3vw5wfnnQECoXX9Ur0Gzyd
 Yyiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690127315; x=1690732115;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Q+kr7SLHmjKHPZehm34/UP6SZCQ7koEyHzzD7U3bLCU=;
 b=DiiUbaTkd9reiHCIg9e8ByaUaZv7FbF3xoTPKdbxbrKM565vO1sUARTc3CpqHoJ/zg
 TWywl52xu+xYG1Mam09F0yjqhrcqDUhvBgXUsCPpscKzvsn1rs95CDXmFVWa0zum57vd
 KPQz5BMHGUXRVV60qxMRHpKxX5fhhdop/WyUnAoi2V/TCQH4hrpnKOLegdLIYSQ1G1GH
 H9PzlqgNp8PbteGXNJuF4BhHY/iTZImcwKlhz7ZEJOxxcAOM1DOxlPukdrfRsTrY279f
 O1y0KV3Jf1Hxj0fefp57F6LTFZG47NodtWHscoQxNiMsIltq/yyN1nW1yYCZFOEWBXX0
 rvTg==
X-Gm-Message-State: ABy/qLaojuBLHX4D2dOn9FX23VGoHb9r28OjprzukH8RlzKWG1/xkBoH
 RTkaiCuypkfg0tTh/991+rJjaQ==
X-Google-Smtp-Source: APBJJlEHxLq73otlW5NZAWxAc+zTr++0iTppMKbaf6RqDy/TIsKazNxHKdjVi/baTWy6K+rUaKdlIw==
X-Received: by 2002:a05:600c:c3:b0:3fb:b67b:7f15 with SMTP id
 u3-20020a05600c00c300b003fbb67b7f15mr5718076wmm.21.1690127315101; 
 Sun, 23 Jul 2023 08:48:35 -0700 (PDT)
Received: from [172.20.15.116]
 (179.181-106-213.static.virginmediabusiness.co.uk. [213.106.181.179])
 by smtp.gmail.com with ESMTPSA id
 t8-20020a1c7708000000b003fa74bff02asm7871508wmi.26.2023.07.23.08.48.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Jul 2023 08:48:34 -0700 (PDT)
Message-ID: <179ce2a7-a15a-1af9-a4a3-4adfd2b329bc@linaro.org>
Date: Sun, 23 Jul 2023 16:48:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 09/14] target/arm/ptw: Remove S1Translate::in_secure
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20230714154648.327466-1-peter.maydell@linaro.org>
 <20230714154648.327466-10-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230714154648.327466-10-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
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

On 7/14/23 16:46, Peter Maydell wrote:
> We no longer look at the in_secure field of the S1Translate struct
> anyway, so we can remove it and all the code which sets it.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/ptw.c | 13 -------------
>   1 file changed, 13 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

