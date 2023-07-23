Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3231C75E2EC
	for <lists+qemu-devel@lfdr.de>; Sun, 23 Jul 2023 17:50:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNbKk-0008Lc-1k; Sun, 23 Jul 2023 11:49:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qNbKi-0008IL-LH
 for qemu-devel@nongnu.org; Sun, 23 Jul 2023 11:49:20 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qNbKh-0007Wf-8U
 for qemu-devel@nongnu.org; Sun, 23 Jul 2023 11:49:20 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3fbc5d5746cso32922735e9.2
 for <qemu-devel@nongnu.org>; Sun, 23 Jul 2023 08:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690127358; x=1690732158;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DlvtnA0BBPcZVGQ/t30apURmyYPjD6OUZRJY9NzOoSM=;
 b=q98xLx6gCOi2JCpf0BR5JlfEkZIi5KFy5qaMrLQPe+ZiZc7uZjzNIOAPpg9bedhlV/
 z3EYwngRqE9DLZC8uh3oAu1c1cGf0liAlUUEv5GGSuEUc5W2LHI+B7Zlyj9SDLYs4CdP
 7drS0wV7zELZVHjUkO4vMhU5vSL0QYsiamhNLIcS6HIvaHNRVwEx8PcBONGHQybBg91n
 AYXs9glRxOkY5SaCAbYZ+UT9UZbzCMwrkSn9UL5HZNoApfYxFJwgN/B7MAZ2Lz97UkR1
 UYuKpOTfcs05i04YgYp8CpTXDfMV9JNlHC0Zn9HQvjPgfmB0Rq9k85nua4yiR9McrMkt
 RkPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690127358; x=1690732158;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DlvtnA0BBPcZVGQ/t30apURmyYPjD6OUZRJY9NzOoSM=;
 b=flcvEgQY1h5KNLrmX5GUM7Icq3hHKW1F1tOrLkrFi0v3/kfZD1/sQ6qsvMOjBqcNpt
 sQfncSf4FqJWI5mVfcc6ZhDmK6siHN0xlLUJ1IX+a7kxEDC9SonFDBzNXG60IXPa0f9m
 bUopGAOTs5WtLGo+wqPR5up7xY6kKTeDZbcNnuikRDq51S62CjSbv+DIaMrFrQgEMqhH
 G6xOZ1gc1ULeytZ2MDRh+Xfq8Nxa4rDmxvLo5GnbDW7SQweUOiVRX8+336Ypcpzhi7Xz
 82gc3n8I4gjwlTSJS0h0Y95IMxAPMV62aOOco/vaSsivhhW2MblpsopYZTiclIJMscp0
 uiYA==
X-Gm-Message-State: ABy/qLbglgpHXG13yJo4uz04DhHWwFphxJmhaoXFJY6Hpda9F8T7BAIW
 COLvtzGsK6/xMU5cudT/KvqT6Q==
X-Google-Smtp-Source: APBJJlGdtV4jShanrqIDJvQ4qBJ3qzJdQl4V+crMHPCQ+Ns+LaNKxxrtA5xnnUZ7OC+P6YVOWPd8mw==
X-Received: by 2002:a05:600c:22cf:b0:3fd:2dd9:6d58 with SMTP id
 15-20020a05600c22cf00b003fd2dd96d58mr3366864wmg.26.1690127357954; 
 Sun, 23 Jul 2023 08:49:17 -0700 (PDT)
Received: from [172.20.15.116]
 (179.181-106-213.static.virginmediabusiness.co.uk. [213.106.181.179])
 by smtp.gmail.com with ESMTPSA id
 g8-20020a7bc4c8000000b003fa8158135esm10767030wmk.11.2023.07.23.08.49.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Jul 2023 08:49:17 -0700 (PDT)
Message-ID: <0537f995-9b7a-5b76-724b-30eb201e671f@linaro.org>
Date: Sun, 23 Jul 2023 16:49:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 10/14] target/arm/ptw: Drop S1Translate::out_secure
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20230714154648.327466-1-peter.maydell@linaro.org>
 <20230714154648.327466-11-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230714154648.327466-11-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x335.google.com
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
> We only use S1Translate::out_secure in two places, where we are
> setting up MemTxAttrs for a page table load. We can use
> arm_space_is_secure(ptw->out_space) instead, which guarantees
> that we're setting the MemTxAttrs secure and space fields
> consistently, and allows us to drop the out_secure field in
> S1Translate entirely.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/ptw.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

