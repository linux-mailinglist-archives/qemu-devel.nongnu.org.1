Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 935E075E2DF
	for <lists+qemu-devel@lfdr.de>; Sun, 23 Jul 2023 17:36:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNb7G-0005LI-UR; Sun, 23 Jul 2023 11:35:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qNb7F-0005Kh-Bj
 for qemu-devel@nongnu.org; Sun, 23 Jul 2023 11:35:25 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qNb7D-0003xG-Mo
 for qemu-devel@nongnu.org; Sun, 23 Jul 2023 11:35:25 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3159d75606dso2424592f8f.1
 for <qemu-devel@nongnu.org>; Sun, 23 Jul 2023 08:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690126522; x=1690731322;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YE34jiLOIDKDRAGQcDCcvDTgRYQfLo40QWYGFt2Io+Q=;
 b=lE8x17IbbDtVh/hCj7rZR+cIK8zKxlfoPYPM76clLzd7osXPjzwNGWagMtbAAzIu9h
 dttQ8Kq2OZ8p5z+SOkXlE/Y8baQuFBpNkPAIcfzdhZoPc8Xn4FMcR5P+fo8T1X7bdkVY
 ulQO/4+/xLsHUNyuSurYKBqzHH4ppWD4FydmKQ9urXczcdRXqrG3DKfNAghVQq5D5A4r
 acbAhHxcrdkRmN0gDKxX995lF7Bmrsi/C+S4CahOyFGPNtWJUMF8YJxP0BbAHqOJwlrj
 IkQXB3hjeLJzB++V9px3Kg1OK40A4i/tvuVMqFQ8Xo2YZ2WZsNMnD+LmXp2Wt4O78AA1
 JmAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690126522; x=1690731322;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YE34jiLOIDKDRAGQcDCcvDTgRYQfLo40QWYGFt2Io+Q=;
 b=d7bpvWQjhLKEdDbakftTagWNj4VaXLhhLEzDRUo0BVC6YZE+u8unCaDdnFlqQWX5XY
 V8LEQT5n+cC58rRXqdeu4pwxf1SruxtFESi9vXG6MYnMsnLmbZ2QqVYIPF2Vy3QdsIsP
 tEwys4hJlQbMZElI9Ya0YsB9/h4u/LxnCDSys9RwVe3LHGfkdrf7dgrsmeL3ev1rtFlF
 Jggrrw/dq7yFmeVhHzqncxBZuwUBGUvfB4LG+v3FRBTZbxxAjRSoQFkcskIy/Aa5e/4q
 REyLoh5M785TAd8tAoagW5NCwworD0FVcMmqm8LqFyo7Xq4OCJZMNRlv0ZU77ruorkKI
 aoDw==
X-Gm-Message-State: ABy/qLZMDGoKPKrOhA/YnGResNqdJr6W/kkqfjYx2UMk8I9Jz73gA0JF
 91KrS5zhvfhNuZrTc/oOm56NxQ==
X-Google-Smtp-Source: APBJJlF93p4Ex1U6xfeT3q9jcDDZ6M2WlvCTQrJEwEE9kRTIjm47B846rlUhIpvt2od1XaLoDjDvtQ==
X-Received: by 2002:a05:6000:86:b0:317:389b:1a2d with SMTP id
 m6-20020a056000008600b00317389b1a2dmr3174593wrx.8.1690126521885; 
 Sun, 23 Jul 2023 08:35:21 -0700 (PDT)
Received: from [172.20.15.116]
 (179.181-106-213.static.virginmediabusiness.co.uk. [213.106.181.179])
 by smtp.gmail.com with ESMTPSA id
 q7-20020a5d5747000000b0031434936f0dsm10018436wrw.68.2023.07.23.08.35.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Jul 2023 08:35:21 -0700 (PDT)
Message-ID: <deb22897-b162-2574-35d0-7c0380205a54@linaro.org>
Date: Sun, 23 Jul 2023 16:35:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 08/14] target/arm/ptw: Remove last uses of ptw->in_secure
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20230714154648.327466-1-peter.maydell@linaro.org>
 <20230714154648.327466-9-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230714154648.327466-9-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42a.google.com
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
> Replace the last uses of ptw->in_secure with appropriate
> checks on ptw->in_space.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/ptw.c | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

