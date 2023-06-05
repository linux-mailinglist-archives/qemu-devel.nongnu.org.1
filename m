Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 50ED8721C6B
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 05:11:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q60bH-0004YI-NG; Sun, 04 Jun 2023 23:09:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q60bB-0004Xs-Mk
 for qemu-devel@nongnu.org; Sun, 04 Jun 2023 23:09:37 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q60b7-0004p2-FE
 for qemu-devel@nongnu.org; Sun, 04 Jun 2023 23:09:35 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-65299178ac5so3748031b3a.1
 for <qemu-devel@nongnu.org>; Sun, 04 Jun 2023 20:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685934571; x=1688526571;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xAw/jcXHtcCZZ2DD1pDRcLincqQD57ddnXt4D5GXybw=;
 b=D1g+kBbuNQSVQo/BLW0MdgnUqykTBNR0ngxn522ftqBQDyadkbI9AcQdvfvC2BPBfJ
 fCrRKbBfU3KGA+qZu4b9BYox7kDjltjgst/VZfVkKdxPPvxzjw4dh6E2afEs8T7wf5pM
 Y20392vZLgvGE9xInB+cZEOX8FWBd+Ya/HX/WTWws5p4QG8Vofm+JBSLQudgoDXsu7d7
 KgEnZSOh7Y/tHXAZ+Xgfk/uLKBUUyZkaVTPKugJnYFOLJBM92wFtQgZZaNOTmNGxNq07
 JpEuHVhnPlVjZFiPn1UVaD9w1rKU9Dg+nEMQETP7/qruqkzsayWAqQ1i1lwxCfly+uTH
 OECA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685934571; x=1688526571;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xAw/jcXHtcCZZ2DD1pDRcLincqQD57ddnXt4D5GXybw=;
 b=XvJo6iWs5DFuhmKCKxMKbA9eBZ53ZF7nv1sCQOwZ0fPMyDR6t7HBznlHdegbyK7epz
 SpzOQNAy1oyklJuiWmvLR74W+Bimlcxei0LyeDO7gNbbetO0OESt9Uu4Og1F3zB/d6CV
 U/lxqtrv5t+3TvwMorNkxlKFpD9g2NhkmUazrD4hrECtH7yQ5H4VKq7NUh8qdF5VIWB0
 FSbnQCU4rbK46pz6MEIhMPiRQFEJK5b7MfC1qfymPrVw1CIU7mxhMcV03hoH+Ls6P7HH
 LCskxsiVCHdHP7y6LnlnRWx5qsPPH++unjuNWahIVQNuLIF15/lyUWVBHFcbZLaJ1G3L
 8C9Q==
X-Gm-Message-State: AC+VfDx7poZQ4Hdnwb2ZmwbhVCFT9Z/KqFabOtuvL9pJei6TnSpnw2W2
 X4oNNUGAn4oNHM0Fg8YQ/gmI+A==
X-Google-Smtp-Source: ACHHUZ63Bgazpu4vUsXxUfPhRy9wN5LilQ1JcaRCMXWtW5E9L4fuBKH7B7CijRTywMeT2WyCiumThg==
X-Received: by 2002:a05:6a00:1a51:b0:64f:4812:8c7e with SMTP id
 h17-20020a056a001a5100b0064f48128c7emr21454772pfv.19.1685934570973; 
 Sun, 04 Jun 2023 20:09:30 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:8c21:6140:6827:99be?
 ([2602:ae:1598:4c01:8c21:6140:6827:99be])
 by smtp.gmail.com with ESMTPSA id
 j9-20020a62e909000000b0065992d334f4sm1218510pfh.177.2023.06.04.20.09.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Jun 2023 20:09:30 -0700 (PDT)
Message-ID: <ccccffff-e5e1-f2dd-53c7-3d0d2fa0ff3d@linaro.org>
Date: Sun, 4 Jun 2023 20:09:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/4] target/ppc: Fix lqarx to set cpu_reserve
To: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org
References: <20230605025445.161932-1-npiggin@gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230605025445.161932-1-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 6/4/23 19:54, Nicholas Piggin wrote:
> lqarx does not set cpu_reserve, which causes stqcx. to never succeed.
> 
> Cc:qemu-stable@nongnu.org
> Fixes: 94bf2658676 ("target/ppc: Use atomic load for LQ and LQARX")
> Fixes: 57b38ffd0c6 ("target/ppc: Use tcg_gen_qemu_{ld,st}_i128 for LQARX, LQ, STQ")
> Signed-off-by: Nicholas Piggin<npiggin@gmail.com>
> ---
> v2:
> - Fix bugs vs memory access fault [Richard]
> 
>   target/ppc/translate.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

