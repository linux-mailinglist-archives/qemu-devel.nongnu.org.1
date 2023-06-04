Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5677213D9
	for <lists+qemu-devel@lfdr.de>; Sun,  4 Jun 2023 02:01:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5bAX-0003zr-MN; Sat, 03 Jun 2023 20:00:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5bAU-0003zR-9W
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 20:00:22 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5bAS-0007pT-LG
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 20:00:22 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2566e60cc5aso2781242a91.3
 for <qemu-devel@nongnu.org>; Sat, 03 Jun 2023 17:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685836819; x=1688428819;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3MIQSj9A0aKXbJkw1n9u2EcYhEhpCvpzm+49Umo0DSA=;
 b=fw0u/9xYuk14if4cgd0+YFnu0eaTHIuIVDHiiIT/dq/FjbBD7eCw+w7aSuAQDr3ZpS
 9tRVjTrMTLb2WdSnu6gUh2/md+xh37msqfRlG/FkO6KwM7gv7jC4BqkhMzu551fKhI2Q
 HO86LGY2jE4K0ebShweyCTXDvTE3K5AnoyMv8t2wgouFdPJGyr/FsvQh0BatK1Xexvu8
 u1pdpXXGIQFiBN6LhW4oJLiqYbW+/7QqfXYXX5tnfDZTmVrnRXATKtWWlWdfa45EFsPq
 IZ1+hAq8QShm4DmngIeblLtxm6jH0uYYgIXt4b50iTH3nylVYHojBQM93hjWvmjEKPBp
 4OsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685836819; x=1688428819;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3MIQSj9A0aKXbJkw1n9u2EcYhEhpCvpzm+49Umo0DSA=;
 b=bWSDpu/WGyGSG4izOZ0tIbpaBrWQTLq1CkBWUTOG/vfASfK7nisPx6pdmIKdB/tecv
 rRdtP+Zv2a9JWxJ9v3HlGnDMiM8bh9xo4DiioDaLTi7DbjarfDFrRy4gil9dnPR4bVEl
 oc1fCbC+ANc2vjgyP3gso2RkoFMaLJ99NcISmyYyzbZ01PcU+GRGPG5N7WAWyPgkdSfb
 urltfISk8BJ0gxpvEQ0hkUHvVmuqljzSqll912hMokpquiG+SaWUkrgDoQZU0N/2zkhu
 1C7x3pG5VKpa7c6tSRbv5tZlk8T1X5suqIDv56bRY9E52OmnoRfPm6IFt3XmzJJxUkkq
 /4+g==
X-Gm-Message-State: AC+VfDz4qi6V923nZN7dzRBWOTFzVkc5Ai3gGcW4Gh9GTD3s1qR+BHC2
 4hVjf1UjSALQjrGRfTzMHDKvHw==
X-Google-Smtp-Source: ACHHUZ6G3lxhprCt5itAIwmnKNyh8qhRZxzoI9DldxKlmFFFoJLN/lrLwpeb/eJ8RJ/mCWmDh7oVqQ==
X-Received: by 2002:a17:90a:4e8f:b0:256:937:48dc with SMTP id
 o15-20020a17090a4e8f00b00256093748dcmr3648090pjh.40.1685836819086; 
 Sat, 03 Jun 2023 17:00:19 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:9a37:84b6:b3f0:f301?
 ([2602:ae:1598:4c01:9a37:84b6:b3f0:f301])
 by smtp.gmail.com with ESMTPSA id
 o1-20020a17090ab88100b0024dfbac9e2fsm5168772pjr.21.2023.06.03.17.00.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 Jun 2023 17:00:18 -0700 (PDT)
Message-ID: <10d8ac29-2266-93f7-b55c-59b1f66a1841@linaro.org>
Date: Sat, 3 Jun 2023 17:00:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 18/20] target/arm: Convert load/store (multiple
 structures) to decodetree
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20230602155223.2040685-1-peter.maydell@linaro.org>
 <20230602155223.2040685-19-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230602155223.2040685-19-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.095,
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

On 6/2/23 08:52, Peter Maydell wrote:
> Convert the instructions in the ASIMD load/store multiple structures
> instruction classes to decodetree.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/tcg/a64.decode      |  20 +++
>   target/arm/tcg/translate-a64.c | 220 ++++++++++++++++-----------------
>   2 files changed, 129 insertions(+), 111 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

