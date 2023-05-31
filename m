Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FDBD71761A
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 07:24:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4EJI-0007VU-90; Wed, 31 May 2023 01:23:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4EIw-0007UC-6Y
 for qemu-devel@nongnu.org; Wed, 31 May 2023 01:23:26 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4EIu-0004jM-0I
 for qemu-devel@nongnu.org; Wed, 31 May 2023 01:23:25 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-3f6da07ff00so56188985e9.3
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 22:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685510602; x=1688102602;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nI1PAHNdz5yHy6T2h+UfeiFJDtJrWjn8WZijdphdb/E=;
 b=udlGScS7YBvIbZxgVH5kbN+3AWULuHcvgp8Ae8s4TjITW+KDgJD2QcsPkYuHo+ibh6
 9z9/JLIczn3YTMtDuK/J/8yggKVzr0L0CJaWvoMPZlZcWxxP54c4g3sjj/bBBdXmP64s
 KDYHnpyy4/HO/c/mg4+XNQWxxs6/uUgoCyb/JNCRIAUf7lYouu6CDY99W2pTDhSWk8kd
 kdqiBsmh74pHGlE9u8fvTnFmaemcSR96dsshbv2O2oWQWRFvvNavrbGM78LbCNgG8Y7N
 AjnH+asSdKyIL+OQJMN0EHIzo2cg/VRVeaS01qL1ZjoCnhz8IXsOnxCyJjWv6rXIf4Hz
 1p8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685510602; x=1688102602;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nI1PAHNdz5yHy6T2h+UfeiFJDtJrWjn8WZijdphdb/E=;
 b=GtVpKcPwQ0UVqqWOhladw0Yo0VWiBHA5um7v6X+fYMFP7S9c6qMSMEUAazco9ub+X+
 utWTfurJznQ505K2TD/dEhKkROKggnCLvMDiFTU/c0un3gj4Pkpyvp2W2LevKCltH6AD
 f717/J0wT8AlNd0E2M9IZzTOK2liL50G+DfjkPmwd+8fiD8TdjWkfnlGjOZwZEuVd/4T
 a2bQfjINW9Znz850KsACdaJIEGb3SM1W8cLU1KcDLpoaZgA8whJRJ2g6eHgKTVJNzS39
 2iVhugKY0QVBUCfnxeeCAh0ia8INzfz/P3AQwHcOhOEfl7JWyiZk6KOPOvgRJ4CWB8yS
 tkyA==
X-Gm-Message-State: AC+VfDzvF/ryWFLzKVlkCX3FO+Oij3fFtTaddq/R56DzmZK0/POSb+oq
 fr6LS68WMLRsFvoZu/TbVR5VigUO3PKVL9g0cunf4g==
X-Google-Smtp-Source: ACHHUZ4RNx2xU5VKBx6l7lfG2mXyq1OP6S6PpqrmOwIQMx6FAWlfb5TDc5AQfpku6fc3KLKAwOaZ1g==
X-Received: by 2002:a1c:7412:0:b0:3f6:53a:6665 with SMTP id
 p18-20020a1c7412000000b003f6053a6665mr3498151wmc.19.1685510602187; 
 Tue, 30 May 2023 22:23:22 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.146.12])
 by smtp.gmail.com with ESMTPSA id
 y8-20020a7bcd88000000b003f6038faa19sm22501435wmj.19.2023.05.30.22.23.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 May 2023 22:23:21 -0700 (PDT)
Message-ID: <bef04806-3f6c-bd06-4f6b-211953391276@linaro.org>
Date: Wed, 31 May 2023 07:23:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v3 37/48] target/arm: Tidy helpers for translation
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230531040330.8950-1-richard.henderson@linaro.org>
 <20230531040330.8950-38-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230531040330.8950-38-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 31/5/23 06:03, Richard Henderson wrote:
> Move most includes from *translate*.c to translate.h, ensuring
> that we get the ordering correct.  Ensure cpu.h is first.
> Use disas/disas.h instead of exec/log.h.
> Drop otherwise unused includes.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/translate.h        |  3 +++
>   target/arm/tcg/translate-a64.c    | 17 +++++------------
>   target/arm/tcg/translate-m-nocp.c |  2 --
>   target/arm/tcg/translate-mve.c    |  3 ---
>   target/arm/tcg/translate-neon.c   |  3 ---
>   target/arm/tcg/translate-sme.c    |  6 ------
>   target/arm/tcg/translate-sve.c    |  9 ---------
>   target/arm/tcg/translate-vfp.c    |  3 ---
>   target/arm/tcg/translate.c        | 17 +++++------------
>   9 files changed, 13 insertions(+), 50 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


