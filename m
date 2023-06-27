Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D251C73F8B5
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 11:27:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE4yt-0003M1-Cy; Tue, 27 Jun 2023 05:27:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qE4yq-0003IG-UG
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 05:27:24 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qE4yp-0006Qk-4X
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 05:27:24 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-51d805cb33aso4418089a12.3
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 02:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687858041; x=1690450041;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+fMux/8SBuG7Ns+WLkwo7HjnOMz6k6/JvvcW5tQxzus=;
 b=UKHl6K3qzgXAHQ/sKkVpAoQi+Kx72ujxeXt3XVaGjiJ/iN6YSoHpImK4KHznpGt3eZ
 /BpYI1BoJAbCiazURT8izoCbYYuaEPyycoh5j+dSU7ZzeLLxD2F5/RNCeb1JheZP1DcA
 oFHT/Ki0f26kk0C+GVShiRMhAta5BhNYUi1hq44H49D3CvANt4HbNu9pYWnYfR9sDqfF
 j5Sr3E/CBmeOjikiAGM5zFTy50bHnJ8e8nAck9BX1AuNYiZL5cMIGXw/eoBTiOolIlwR
 vlxmNK56Rezh/xQlGWCq8MoXWBlj/PyfoZChqj4DQwk9vqs+Oalp6EvvdtXXbLUWErDG
 KCOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687858041; x=1690450041;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+fMux/8SBuG7Ns+WLkwo7HjnOMz6k6/JvvcW5tQxzus=;
 b=gw7YvQYNXk1+zFdmJNBZ73PSvLJ/H1BZkXT9CD1u0zuxtQjXRV1SBozqdubHdIf3BA
 b/bt51k0ZUjqZZYFVGql0TKokOER0QrlSwzgPNIMT3fj5WcN3sePtRtrf1w96G6BA6FW
 lVlxqwG8Wyc2dmI32kV3IyUvZWxmb1oZCr1gsC3P8HV2gAYIfjMMxiNawMj17O4H4I+3
 jcuQEUxpJzf4Jh3qH0yg+dEvnzRbZuHg8kKFQYxrE+imEIYMUZhuvD4+618QMd+skVn1
 oSXXNG0H14Y1TWUpqvJbfgqHukxzPeQGBkshlz/T6KdVgWY8tmn2DVA6WxjfmXU0eDVf
 OU7g==
X-Gm-Message-State: AC+VfDxVXeEMsymyZij57mWiZxLqKiOpAMntRHsMli5IloiBZmSBUdus
 jsFQVwx7OxH9CFCAlAuKHclqlw==
X-Google-Smtp-Source: ACHHUZ4I1ER+RSUCQ7zFkQh3qWPSf7qPwTtp0GaE0bh5ep1Rvv/JDquP599akd45dRYB2PzfEIKlqQ==
X-Received: by 2002:a17:907:6d8c:b0:992:1b2:4090 with SMTP id
 sb12-20020a1709076d8c00b0099201b24090mr2266456ejc.64.1687858041367; 
 Tue, 27 Jun 2023 02:27:21 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.199.204])
 by smtp.gmail.com with ESMTPSA id
 j9-20020a170906050900b00989027eb30asm4314548eja.158.2023.06.27.02.27.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Jun 2023 02:27:20 -0700 (PDT)
Message-ID: <006a9651-db64-de90-c41e-aff7cfbaac54@linaro.org>
Date: Tue, 27 Jun 2023 11:27:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 3/4] target/alpha: Use float64_to_int64_modulo for CVTTQ
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: christoph.muellner@vrull.eu, alex.bennee@linaro.org
References: <20230527141910.1885950-1-richard.henderson@linaro.org>
 <20230527141910.1885950-4-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230527141910.1885950-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x534.google.com
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

On 27/5/23 16:19, Richard Henderson wrote:
> For the most part we can use the new generic routine,
> though exceptions need some post-processing to sort
> invalid from integer overflow.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/alpha/fpu_helper.c | 85 +++++++++------------------------------
>   1 file changed, 18 insertions(+), 67 deletions(-)

To the best of my knowledge...
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


