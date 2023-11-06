Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A967E28CA
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 16:34:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r01bE-0000E6-2n; Mon, 06 Nov 2023 10:33:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r01b9-0008WS-58
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 10:33:07 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r01b6-0004Rp-FJ
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 10:33:06 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-53de8fc1ad8so7772171a12.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 07:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699284783; x=1699889583; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NkxbMiZhXYa1yAAfJaXtObCRe2D8oZJC8vauyifjOoI=;
 b=yBbVG3YZgJRxfkG1FDDmLV7jyczQe7alUFohheN1CD84D7bpNDFJUoBRQlDoT6lFCt
 +T9wXDvvz437CRAw8mhC3vY1G8/eH84vEJCEPBxkiN0Y+JPpyA7+ZQ1OnL8edTkEqjJc
 Qjn5iJnwW6jA9Vx+TTOyEg4yN8l9IbC0Q/iR8OPhHIz0LFRJY6TCmLyBd6ESbQG2t2Bz
 n/xgAKmbd8WcXSHDUjh9FJTty4xokwnCYRXS4Va7Tcw4zX+nSDOeoPyc2wtB6ErvnfWn
 7ehDxa0H3CXb9BfphEFpUHAqHUHeNx7N93etu56kp+WRiLgi6oM2DWa7SnKP653CVGVR
 CHRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699284783; x=1699889583;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NkxbMiZhXYa1yAAfJaXtObCRe2D8oZJC8vauyifjOoI=;
 b=pm8l9r2PO835vGQ+WtAF2ZiE63qYz7uzZj3Qna1GmTkgG32o+JZg2Wf/R6KcVe/seP
 s5UHEfbz3QQO560n3Lr0Pp2ORp5IVhY2xLT1VBU8eJcwAz8zw2a+321sL3mYydigRYAY
 RDREFKakb74F7CvzOFV8XQ3qoNas/PoutohGZrtDDePSFYln8sVmxpJN9QVeUDIrSdwt
 dex24OeanF87ye7TNaDwaGVH4PEIZWy6/iBJKB/xiIRPpH4U6XipNa/HxI1AqN7zMzp/
 866st/V5tSuntNjVGWwyV5tiopxIFzAYAa7zEkejD87OP2WmBetlE5SyAuheIM5AjqnE
 Gj3Q==
X-Gm-Message-State: AOJu0YyNtqhmoV3JKugvWW2bh/xU9c25F+KcHf8ljco8rFBcqfEtI23f
 AY6Q6w651ztA6Gpzrr9rBX2g1rSNfQSwzN3z2RY=
X-Google-Smtp-Source: AGHT+IH23BJeDhJVtuRXtcjugQL9DqePtjqcaX8svflHHySJyZWMrZQSMb1t/EqxNIE6AcT1aaZYMw==
X-Received: by 2002:a05:6402:278e:b0:53d:7be0:4a93 with SMTP id
 b14-20020a056402278e00b0053d7be04a93mr30132619ede.11.1699284782947; 
 Mon, 06 Nov 2023 07:33:02 -0800 (PST)
Received: from [192.168.69.115] ([176.172.125.26])
 by smtp.gmail.com with ESMTPSA id
 b67-20020a509f49000000b0053d9f427a6bsm4594338edf.71.2023.11.06.07.33.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Nov 2023 07:33:02 -0800 (PST)
Message-ID: <64253e7a-96cc-94e7-c63b-b6afe5d8e5fd@linaro.org>
Date: Mon, 6 Nov 2023 16:33:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v2 03/35] tcg/optimize: Split out do_constant_folding_cond1
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20231028194522.245170-1-richard.henderson@linaro.org>
 <20231028194522.245170-4-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231028194522.245170-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.085,
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

On 28/10/23 21:44, Richard Henderson wrote:
> Handle modifications to the arguments and condition
> in a single place.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/optimize.c | 57 ++++++++++++++++++++++++--------------------------
>   1 file changed, 27 insertions(+), 30 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


