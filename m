Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C17C72F3CF
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 06:53:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9IVr-0005nu-TV; Wed, 14 Jun 2023 00:53:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q9IVo-0005mf-Ta
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 00:53:41 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q9IVn-0005AN-6h
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 00:53:40 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-4f6283d0d84so7909748e87.1
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 21:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686718417; x=1689310417;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BwhnD+ZwjQ/WxV3YtLxXWyP7cPVFST1eWPiPfA8zpvA=;
 b=mAvwQRsPGu4s0P7qo8gA4hbiRY0u5baoQ7hbxWtdWmcRaqWYbxg52nYWq50TrIyNSb
 yDIrg9sX2LUpb1COCb77QXlzY2BRV3W2x9eFn+awvPPBGBZPq36l+iHMNo4vnvtuake5
 Ud6oyQFXnSMHe97zkRPOSBrH62TV1nm9mJvno32EOUusltYLiebr9TPz/Eb3dUBsG47y
 Ys+9LCrcsY2mBTuVo0uTyzpXBuVCKak7e8vhqsjSLs6Um8vTNpMfnvRnYSK8sPrYTxfy
 9gBN+7vlFeaAhgW1MQv94MoPl8A2tn1L9zUQLBaZsMnO64MCEtm8n7BcIpZbGdV/RlbE
 0AfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686718417; x=1689310417;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BwhnD+ZwjQ/WxV3YtLxXWyP7cPVFST1eWPiPfA8zpvA=;
 b=O09jQtvv88bW+Vw4oZdfOniD5+Un4FZfaxjTdWSybyDi99vpM/goSTY7W5faX5R+YV
 dkHu6tuf/ikyaFCW27nLJdFYNhWGEnMcZTcRP5KNYF2HyBWZ/hLc9sxQhYyqA1hRcx7l
 UfANYVM08q6WedYNRwK9Ub99WapDSvF+IwO4Rer+v+szjeS065rme0IteZwbAsDvh55t
 PwFOdBZ0+TEctH0Pk11I6DFUsBmkZXt5qHXNNm3AC2OTcHjehXnF/aEYD+asbjuweSBN
 GzRoqsXHA8AmEEIRrZODWYbxQ7pTQfKspSMutP9PPzwi7yukcMxd2rzhtYHvFQhrjCgA
 epWw==
X-Gm-Message-State: AC+VfDypo8SQpjqmDRGYJW93jhjZIyL27bKYM5hJSAu4Mt2PxiKzC/XC
 1A1QREkJ8M61nvlmc11HYdzvCQ==
X-Google-Smtp-Source: ACHHUZ4JlHOtrrYBfZjR8vpndfHVjnEbkt3be37JpbSE7AKBwZ7xIfrK5IHTAwICJuEUfP5sI5L+qQ==
X-Received: by 2002:a19:e003:0:b0:4ea:4793:facf with SMTP id
 x3-20020a19e003000000b004ea4793facfmr6448996lfg.13.1686718416964; 
 Tue, 13 Jun 2023 21:53:36 -0700 (PDT)
Received: from [192.168.4.112] (90-182-62-66.rcp.o2.cz. [90.182.62.66])
 by smtp.gmail.com with ESMTPSA id
 n5-20020a05600c294500b003f7ec896cefsm16281494wmd.8.2023.06.13.21.53.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Jun 2023 21:53:36 -0700 (PDT)
Message-ID: <0ae6d048-29d1-0574-23c5-ea3aa93f7874@linaro.org>
Date: Wed, 14 Jun 2023 06:53:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 21/26] target/arm/tcg: Extract M-profile definitions to
 'helper-m.h.inc'
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20230611085846.21415-1-philmd@linaro.org>
 <20230611085846.21415-22-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230611085846.21415-22-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x12c.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.098,
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

On 6/11/23 10:58, Philippe Mathieu-Daudé wrote:
> helper.h is used by all units, but not all require the
> M-profile definitions. Move them to a new header; the next
> commit will remove it from the common helper.h.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/arm/helper.h           | 17 ++---------------
>   target/arm/tcg/helper-m.h.inc | 23 +++++++++++++++++++++++
>   2 files changed, 25 insertions(+), 15 deletions(-)
>   create mode 100644 target/arm/tcg/helper-m.h.inc

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

