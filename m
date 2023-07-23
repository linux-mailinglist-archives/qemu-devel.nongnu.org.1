Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD69C75E0CF
	for <lists+qemu-devel@lfdr.de>; Sun, 23 Jul 2023 11:24:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNVIi-0008Sg-Qm; Sun, 23 Jul 2023 05:22:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qNVIa-0008SH-CB
 for qemu-devel@nongnu.org; Sun, 23 Jul 2023 05:22:44 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qNVIG-0000jb-Nh
 for qemu-devel@nongnu.org; Sun, 23 Jul 2023 05:22:44 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3fd190065a7so25963275e9.2
 for <qemu-devel@nongnu.org>; Sun, 23 Jul 2023 02:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690104142; x=1690708942;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dBIRvDvbAAgiSOiksnDiyA9EKIfEkbYD6lzcO0sEd38=;
 b=e4Kf0LCGaHlznWm2hBBqDIZXhmjU63dGW13mvpDVvX6vjVNf6aJyqRnSKvglMypt9u
 V2g5yVhQLaMxkJDMx0STlE0L5XxcU/bToSoNr6DqGmzgCTx53iz8fHyF5HJ5pwI87dmW
 N2m8zjQQROdbKRSh3QcoeZ+njZqe8nOJAB42zIgpKiMMBy2GkPxNW7iioWFEJR912TS9
 NCrTRWtrjOh4Scly0YyUJsnsElvKM2/qeMtbSdE2g3DSLH8Pg8gMWmk2nT3OIXSsqbsO
 gX6Syzm39X8015gvQlyd6n7/nOte5o3NqAoxoOiXzXLsaU4Vxq5q0saDComkQmprPjNo
 rfPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690104142; x=1690708942;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dBIRvDvbAAgiSOiksnDiyA9EKIfEkbYD6lzcO0sEd38=;
 b=BLA8JAuiCzXjFGOhIfEwdhuJt+PZwKM0SyoRaD160WMruEt5YyXFPjP9HaYMnDM1FZ
 xyrU/XDdVvuKPCt2iIaLj98CzsouCTm0zQVVyCHbuDXk3J2i/6vRiu/ckOFf7q5flItU
 6Lbtyvh/SmJreuvS6dIPnWJVhnCp0ai4txbjez6P9hxJ/mD3PKyGMiy4xVg2VgNsRH6S
 pkmBQdwUgspzd9dzso7XlvUo/E0I3BBSp3k8HGxvSluiJRRZq8qkEIqTDzxFvvEVyj/X
 z13l+ZD9tXRDaKd62pQf4lQ+UUbGRUk8wg/afrYRPizDlZeegAQINLZQt/cp2A/MpwzX
 EtMQ==
X-Gm-Message-State: ABy/qLYU7fI/3VAsRRoH49JiGPBg45u1nvbWnWKNh0Ggxn6sW+JrVpOP
 +aMCzs/cuiEDy/Vlf31NsRF+Ew==
X-Google-Smtp-Source: APBJJlF8kJUUQt5N+BTclwxu88TMu+d7QWmOq6WU63WshvfqPKy4SkMU6W5pkwNSP53EBhbmVOSbdQ==
X-Received: by 2002:adf:dd85:0:b0:314:124f:12be with SMTP id
 x5-20020adfdd85000000b00314124f12bemr5648673wrl.3.1690104142067; 
 Sun, 23 Jul 2023 02:22:22 -0700 (PDT)
Received: from [172.20.2.226]
 (179.181-106-213.static.virginmediabusiness.co.uk. [213.106.181.179])
 by smtp.gmail.com with ESMTPSA id
 f6-20020a5d58e6000000b00313f9085119sm9133419wrd.113.2023.07.23.02.22.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Jul 2023 02:22:21 -0700 (PDT)
Message-ID: <e9da711a-4c9e-594c-cf2a-88c8cd0a9af0@linaro.org>
Date: Sun, 23 Jul 2023 10:22:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 01/14] target/arm/ptw: Don't set fi->s1ptw for
 UnsuppAtomicUpdate fault
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20230714154648.327466-1-peter.maydell@linaro.org>
 <20230714154648.327466-2-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230714154648.327466-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x331.google.com
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
> For an Unsupported Atomic Update fault where the stage 1 translation
> table descriptor update can't be done because it's to an unsupported
> memory type, this is a stage 1 abort (per the Arm ARM R_VSXXT).  This
> means we should not set fi->s1ptw, because this will cause the code
> in the get_phys_addr_lpae() error-exit path to mark it as stage 2.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/ptw.c | 1 -
>   1 file changed, 1 deletion(-)

Confusingly named, but correctly documented.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

