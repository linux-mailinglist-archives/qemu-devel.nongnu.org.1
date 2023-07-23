Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6432875E162
	for <lists+qemu-devel@lfdr.de>; Sun, 23 Jul 2023 12:27:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNWI8-0000wo-9e; Sun, 23 Jul 2023 06:26:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qNWHq-0000R6-2L
 for qemu-devel@nongnu.org; Sun, 23 Jul 2023 06:26:03 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qNWHn-0002HD-W5
 for qemu-devel@nongnu.org; Sun, 23 Jul 2023 06:26:01 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-31759e6a4a1so111260f8f.3
 for <qemu-devel@nongnu.org>; Sun, 23 Jul 2023 03:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690107958; x=1690712758;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qvPBiWYuHTwxKTsuDYlxGD0Kx/9gHBIQ65gjkU0jUIU=;
 b=V0P47sWYlLJuHM+RuO25QywVtILs8IPWuO04RqjnyUAbrcn/FALZUaIf8LhvmTu7oF
 uhlE2SnXprAhms7t55A2Ri45e8fzYsa1d9Wce5LmOlUq/BLNk8MWUnYzyYtlKXeFkYM8
 XI7IQxxH4ecxwOKxfq7l1WCLsgIFHK09kSHMOns6jDUA125M65bhBTlZvD0+ypc12As5
 /HphPyXOuicvqQaYlLVJwHd3QAXVQvj75nNCE6Ks/l6+1tiHYSQ0vUA4k6ubgLyBwfdj
 59PeeOBuv0zBP6fXFIlqP6vxcmWppj/tE5YfdT8NZGZ8lRhfCA0FDGKejZVn0RMxwKsu
 p/cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690107958; x=1690712758;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qvPBiWYuHTwxKTsuDYlxGD0Kx/9gHBIQ65gjkU0jUIU=;
 b=XEp5/r7NYPZPnatFqjxKcWLFSdgwobeYQXU5Wlxv5nkIf51JLEo3Pn0J0KXNN3G3DL
 3FDRPhM2qt2a6ZJyo5tkCTmm58VGvf74EfdU0kMLM3giChFpYAkWjWUX1MLiCqW29Ntz
 8ZRl0IvzsL+2tdgUyXBpQ92mKM8E4ASLtV+dUJSTgl5K5GVkXAjfjTrCXB2SRf+WIGDq
 6YVgqBnhz9BwXSWRA4sCJ1FrsupVygCe3kDaWmhgENMkWqRRMXHPIGDEIZXXHBqbLgb+
 75by2fjzgXJpy0EAWvKNnICAon70QsTwJ/Pt45ePLig98zHoN8I0DoTEPN5RdvlF3V+7
 I0Pg==
X-Gm-Message-State: ABy/qLYTJgkRmyYEGm5hxbOilqg0FpUr1j93tDMdMZlf3bPj819vQieI
 qoy5nzhXQObUaeLKXqFTxhSXeg==
X-Google-Smtp-Source: APBJJlGd/bQmnP5upW74NaSMs54Sk6A3BS1TIKOStbsM5FAWc4PJcAbKRx77b66nxVFd1tRIuw8YnA==
X-Received: by 2002:adf:e94b:0:b0:315:a6a5:fe95 with SMTP id
 m11-20020adfe94b000000b00315a6a5fe95mr4496982wrn.52.1690107958261; 
 Sun, 23 Jul 2023 03:25:58 -0700 (PDT)
Received: from [172.20.13.111]
 (179.181-106-213.static.virginmediabusiness.co.uk. [213.106.181.179])
 by smtp.gmail.com with ESMTPSA id
 r11-20020a056000014b00b0031437299fafsm9294675wrx.34.2023.07.23.03.25.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Jul 2023 03:25:57 -0700 (PDT)
Message-ID: <abbf5a84-d06e-b2de-c105-276bad2d8500@linaro.org>
Date: Sun, 23 Jul 2023 11:25:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 05/14] target/arm/ptw: Pass ARMSecurityState to
 regime_translation_disabled()
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20230714154648.327466-1-peter.maydell@linaro.org>
 <20230714154648.327466-6-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230714154648.327466-6-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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
> Plumb the ARMSecurityState through to regime_translation_disabled()
> rather than just a bool is_secure.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/ptw.c | 15 ++++++++-------
>   1 file changed, 8 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

