Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 505E774602F
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 17:56:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGLuF-0000j6-Jc; Mon, 03 Jul 2023 11:56:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGLuC-0000in-KI
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 11:56:02 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGLuB-00048s-3v
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 11:56:00 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-3fbc54caad5so40227375e9.2
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 08:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688399757; x=1690991757;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HWMxDmCOmLiDZMgxX+qO3reRSKgAhl030DyhJw1HlV8=;
 b=gVqSoPx4K3+SGJK6HgKFQKsicDfc0P7PYblLG091hZqMCfFhQM2NqV6OMMCugXJHRZ
 dd4HgR2DzKp25QBSlax5P0lKPGk57VZhkzp9WCKf4ENvVoKQw+F+2rZZ20Ajfl55DjY8
 ObEQ31dGTO1+Yk0Vjw0YDZVsIWL2d8ThhB1bO8dVA/zIfNDmOL+bFXf3nTYSO5qejXd+
 rWKLXmiQ3WazaxUDHcMJsIZtOIs+ZtBrl2PmbrH52Ho5Z//UxZXpYtvbzd90kFKASG9m
 mCC08/uMM+glTCPBA2Jw8wVW+JCp8oLR2B8mUsClkJscwi5EWfB2LnH3Cm7uxCYkZMxJ
 bbew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688399757; x=1690991757;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HWMxDmCOmLiDZMgxX+qO3reRSKgAhl030DyhJw1HlV8=;
 b=OsSw3xMyKeyeBhSjqPb/sRESf+NXQp+4sEQaKihh3u3MPsI5aSWrE4YE9DFB547tJh
 wTcdBu7zbEL6rHqt7njhOczfk+60e3fJfY2YlO7JhZRqZDLBkej1LiyXjgOtmqohsu8g
 GtAqkYsP/UniSqVy28JJprtMGTq4lyOXk2oo/f9htXH2vTes4u8dGcPRA4FA73wsZkPZ
 z9n8wWJjzfEUO+8t/BAoqpdYtgjgLcjXQzU4yH0lPEMUZymKUefx4hwP4BrO3L17meS8
 QWJUFQB56G5meQQaQIWTAtt7YbVKZebnzIYjkTGxZXuKzcICA/bEqFGcDKakQa4iMF0B
 OkMg==
X-Gm-Message-State: AC+VfDyx9l9VpAZ0O18ldMMSWDvSRFI6ceOnLYy82nubt8RCa2GnOxHX
 arosOe7382xfq5ul07oWC+Sypr78sx1zXdvIUvw2EQ==
X-Google-Smtp-Source: ACHHUZ57QH7KRfg67aWQJDSkqtC/NFucKMswqb6IBpotixeOMS6IIB3h33twYPsaS19AmMdlFh8Swg==
X-Received: by 2002:a05:600c:364f:b0:3f9:b1e7:8a4b with SMTP id
 y15-20020a05600c364f00b003f9b1e78a4bmr8352060wmq.21.1688399757576; 
 Mon, 03 Jul 2023 08:55:57 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.178.91])
 by smtp.gmail.com with ESMTPSA id
 t24-20020a1c7718000000b003fba9db141esm17081850wmi.38.2023.07.03.08.55.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jul 2023 08:55:57 -0700 (PDT)
Message-ID: <4d883f31-93ea-d5c0-3b98-3aa8740d8f7a@linaro.org>
Date: Mon, 3 Jul 2023 17:55:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 02/24] linux-user: Fix formatting of mmap.c
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mjt@tls.msk.ru, laurent@vivier.eu
References: <20230630132159.376995-1-richard.henderson@linaro.org>
 <20230630132159.376995-3-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230630132159.376995-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 30/6/23 15:21, Richard Henderson wrote:
> Fix all checkpatch.pl errors within mmap.c.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/mmap.c | 199 ++++++++++++++++++++++++++++------------------
>   1 file changed, 122 insertions(+), 77 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



