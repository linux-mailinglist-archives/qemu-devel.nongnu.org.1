Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D198736999
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 12:42:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBYoD-0000Jn-7f; Tue, 20 Jun 2023 06:42:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBYoB-0000Cd-F7
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 06:41:59 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBYo9-00052K-UL
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 06:41:59 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-988aefaa44eso304082166b.2
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 03:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687257716; x=1689849716;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rvw/sEEbL9whA2gx93lDZGKq4/tPIOZ6bvR2C4hNqvg=;
 b=d2cVAcMDeVB2EZcdaWZcCRXjcnPkboNZSq6uguuY03lcsT8HnZ52ud/3MGtLz8ajFf
 Ize8eMytDB+wDaZC2PK8jOMg5qfkXsMJie8uzcu0KwytS8I5M4VAAJGwdPBOI0/IHbdx
 hRqcKj2LKBPcL2/EX3SwFFTP9lG5g4dEeZvZoxD9+7aY6Yho2fwVPDWIXyvp8txEANkD
 1HVbgUtKg0qk9eJT9c3MnUkDD9dBDWfK2ljSsMFVuNgKauzkyTYERg5uT9VEMlOm+Kz8
 L+bP+LntjtRQhtyc6/NPSrMrh38tcWkCwNlTmSCSdVvAzqXuiIeMywkQLR7LAU+UfdKC
 lkyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687257716; x=1689849716;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rvw/sEEbL9whA2gx93lDZGKq4/tPIOZ6bvR2C4hNqvg=;
 b=QLPAyDitjdcCsa4HGj57ZGyPHzNtt0K92WsDGPqGN+YwM64KsV4LY9/mt7IqoucgN+
 VR3RR1CipD2Z90me7c1/7w4LzbmWsVJ1UnlHwiCfCqRphHAhftBS+cdf56exhU0G3fkU
 SW7tS9kvmSsaOd/nKqMSdBFIBwJ8QEw0V/cKY/aJwdeMkadE22eHkjzAIrms5BEY177M
 di4hkXbR5b137G0njz5CmUmU7n265z5WwWCXimzbU/9DHObHsuolwJhrIVP1bJUMKVzi
 c42U4jc7L5IuRqjM2mPBdj1t7Y4ejyiawuISIwcoD2+6fJEzjPy75FoT3rzCVAjEe8Fx
 3ynQ==
X-Gm-Message-State: AC+VfDwMNrqSX6ok5zvPEswfZyoZ0axlJ4i2Xhkv1q9pWA2IoEjDYPe/
 1h46lwYpQdOvEzouYlLvGy6AGg==
X-Google-Smtp-Source: ACHHUZ7XeHJCNL4d0TcFOG63NiDEcrh50rpZ8Bqja10p2mOiCc7K1CJQE7DOzFp4FQN7oYnY3tnuAA==
X-Received: by 2002:a17:907:9284:b0:974:1ef7:1e88 with SMTP id
 bw4-20020a170907928400b009741ef71e88mr10429576ejc.13.1687257716324; 
 Tue, 20 Jun 2023 03:41:56 -0700 (PDT)
Received: from [192.168.69.129] ([176.176.183.29])
 by smtp.gmail.com with ESMTPSA id
 p8-20020a170906614800b00989065149d0sm1152056ejl.86.2023.06.20.03.41.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jun 2023 03:41:56 -0700 (PDT)
Message-ID: <07fb2856-c3a7-1df8-8575-71a056669c84@linaro.org>
Date: Tue, 20 Jun 2023 12:41:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 28/34] target/arm/tcg: Move v8m_stackcheck() from
 op_helper.c to m_helper.c
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20230619154302.80350-1-philmd@linaro.org>
 <20230619155510.80991-1-philmd@linaro.org>
 <20230619155510.80991-16-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230619155510.80991-16-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x634.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 6/19/23 17:55, Philippe Mathieu-Daudé wrote:
> No need to have the v8m_stackcheck() helper in the generic
> op_helper.c, move it with the rest of the M-profile helpers.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/arm/tcg/m_helper.c  | 16 ++++++++++++++++
>   target/arm/tcg/op_helper.c | 16 ----------------
>   2 files changed, 16 insertions(+), 16 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

