Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1EE7B2695
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 22:28:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlxam-0000o6-0Q; Thu, 28 Sep 2023 16:26:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qlxaj-0000nS-2w
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 16:26:33 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qlxah-0003L6-DM
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 16:26:32 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1c1ff5b741cso120779825ad.2
 for <qemu-devel@nongnu.org>; Thu, 28 Sep 2023 13:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695932790; x=1696537590; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EWOO8jCQcutgbslrnR2UNLBsL4KqnEPWgcrfNQiOLdA=;
 b=CwYv5e3jd4kUlq49Wkp37Sfpwbkxbf27HOzY9FGdFTr5auUt8Z5g/SU5RJ+yxY5sbV
 JD7Ywgwf6loQnIDDjZhTU4FkgLf93of804qagMez4kCHRzuiMPhRycMD3GWhy1pLr8c0
 v77+WN3jO4+JfWtUIFbwkW31pWk41gD2rgvZj0pjpbxqTOyyhoCcxKcqsWu7XBs53foz
 ZZgNKyI39QdYwAOB0fy8FXvW6tvDxAR92Qd4aC3RD27ONhVxlzLlYSekS+sSaTIOJ6C8
 sbg/FFvsxLOxsTUsDKEnojS5C2b9m4mJg+0gCzF3Vabx2R/ZFzje5eO1KajhYQ8ZnGZx
 76Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695932790; x=1696537590;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EWOO8jCQcutgbslrnR2UNLBsL4KqnEPWgcrfNQiOLdA=;
 b=gZuvO6Q9GLEwb9GJd8jQujXcHIkZ+ETLIeP6juXry7jXaK5cwm20QVHEYj3VTnyWxr
 aL/4wDy8nTAJh/CqR5M8LhdiXMrf79GWAM7QUEQg4j3lJtCtO40D16KG3z2Gk64Zq1cZ
 vjm4RXWHKxvoUgW2hu82CQns3PFKNKee1vm0wfks4zqG6+K8jo5yuMU0S2YqmrfnLUWy
 ujiX6mpBaX0zdt4Y53JsHXTADEhm6CcuxnSGKnCOrYfc7/xrChJmlKFBER77G5ns2LK3
 5NI+iQNx0PcFZ73s0O1TCgwhQoGaYfTg/sRFEgcdtZ2lFNsmIZ3caDLZmHnQcxdP8ktF
 Ie8g==
X-Gm-Message-State: AOJu0YwGa3TBKgmc2CZX2wAQgXxLsIDeVDY/etWHgz9cPW2zNMwgqIlo
 3E5vHScUiIaeXnvdJ+fJTaDGeA==
X-Google-Smtp-Source: AGHT+IFEHqhM0puuss2gNZLLjZV46nf1KK//QCf56WN07Xzui5IfT80dWrgmHNBWb8a6OF3Ff/LdXg==
X-Received: by 2002:a17:903:11d2:b0:1c7:2697:ec0a with SMTP id
 q18-20020a17090311d200b001c72697ec0amr2417399plh.30.1695932789764; 
 Thu, 28 Sep 2023 13:26:29 -0700 (PDT)
Received: from [192.168.0.4] (174-21-146-124.tukw.qwest.net. [174.21.146.124])
 by smtp.gmail.com with ESMTPSA id
 i11-20020a170902eb4b00b001c61921d4d2sm8966449pli.302.2023.09.28.13.26.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Sep 2023 13:26:28 -0700 (PDT)
Message-ID: <4648e9df-5cff-c470-6c7f-e34f505d294f@linaro.org>
Date: Thu, 28 Sep 2023 13:26:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] target/arm/arm-powerctl: Correctly init CPUs when powered
 on to lower EL
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20230926155619.4028618-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230926155619.4028618-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/26/23 11:56, Peter Maydell wrote:
> Resolves:https://gitlab.com/qemu-project/qemu/-/issues/1899
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/cpu.h          | 22 +++++++++
>   hw/arm/boot.c             | 95 ++++++++++-----------------------------
>   target/arm/arm-powerctl.c | 53 +---------------------
>   target/arm/cpu.c          | 95 +++++++++++++++++++++++++++++++++++++++
>   4 files changed, 141 insertions(+), 124 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

