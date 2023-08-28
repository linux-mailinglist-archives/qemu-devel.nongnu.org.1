Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D0978B63F
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 19:19:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaftY-0002sK-OB; Mon, 28 Aug 2023 13:19:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qaftW-0002hh-OL
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 13:19:18 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qaftU-0006al-JX
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 13:19:18 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1c1e3a4a06fso6085385ad.3
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 10:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693243155; x=1693847955;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mnib+3X1fMq6LgstLNd+qEWEHe6MY9Afzv3CK1AtCKU=;
 b=dZ53+f177zYcnbOZMQKYs7rIg0CJmxy8WRi6IUkkNveHXhCVxSbJEanlRPhRRhOI9d
 IBMgwR3YK3BmbycTjzSS1deF/PmswDhyjFtv+8qnJVAncRzGvexXIs0a/HhsLHgdVyhL
 Zq93HuP6gJAVnUtqWkRtogz5iFhVVSHepltKRzFYrY+8JjIOl/Eq4PMMu51cXoZ6zHI8
 C4tQ3osaw8I6GJCUaT3/FgfykeU9i2WvAJFJHvkKCndiRyljU3rHNZd7e5umFO0BVtDG
 /MzIigFHzOahURaApHucIDbGe8rCRpNFg1WY2SlQTpj9CQnutLuKXXbAIsQGJsOKaQ8Y
 pzMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693243155; x=1693847955;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mnib+3X1fMq6LgstLNd+qEWEHe6MY9Afzv3CK1AtCKU=;
 b=RGyC2ji7fnhuCRavBR4mBTNQvaFz33r80HN9k7vJ5+F2742rMpaazB0f3oOL3ESSmC
 RtKqUHl4n3ROnjVq1AnFxRETJuOwOkjxvfEnjFcxcJeJ8Xvzlsm+nfh9f0HEx4mSUsHP
 tqaYHs2s6mma1j09OqJHhSJB4yqkZJtWk9FbkJGBHpR+cXpwVmenpL0FY9ovUGVbVif9
 teSA0hI2ph0v0DSa5kr1zRB2BmVYL4qpcaghDr1yv9W/04E8CaTiDB4qHCLC3vM4aRJB
 u1RoxCUxkA1MvxXoj0DHLzZAT8BDz22dJUVqODmW3e/fGE3WwgM/MotqUUGJO4zdIRCb
 z5JQ==
X-Gm-Message-State: AOJu0YwVOaAwvut7jQSDArJ8H3E7AuooEhiSu8l0ATgqaMj/quriOV/Z
 /PFVqYD5RW2UDJG7tlR8g0hiXw==
X-Google-Smtp-Source: AGHT+IEkHvp6lLCw9iQnsiyOl+yXHJgVTZo5cYl9WWcPoHrcR4/pUQyRXDxvdDdTAl3cg+XHmoC1Bg==
X-Received: by 2002:a17:902:9b82:b0:1c1:e7b2:27af with SMTP id
 y2-20020a1709029b8200b001c1e7b227afmr2553972plp.57.1693243155179; 
 Mon, 28 Aug 2023 10:19:15 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 h20-20020a170902f7d400b001b531e8a000sm7142325plw.157.2023.08.28.10.19.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Aug 2023 10:19:14 -0700 (PDT)
Message-ID: <b096b582-f06e-d1ed-48f6-6f15f569c27a@linaro.org>
Date: Mon, 28 Aug 2023 10:19:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 08/11] tcg/loongarch64: Lower vector min max ops
Content-Language: en-US
To: Jiajie Chen <c@jia.je>, qemu-devel@nongnu.org
Cc: gaosong@loongson.cn, WANG Xuerui <git@xen0n.name>
References: <20230828152009.352048-1-c@jia.je>
 <20230828152009.352048-9-c@jia.je>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230828152009.352048-9-c@jia.je>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.169,
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

On 8/28/23 08:19, Jiajie Chen wrote:
> Lower the following ops:
> 
> - smin_vec
> - smax_vec
> - umin_vec
> - umax_vec
> 
> Signed-off-by: Jiajie Chen<c@jia.je>
> ---
>   tcg/loongarch64/tcg-target.c.inc | 32 ++++++++++++++++++++++++++++++++
>   tcg/loongarch64/tcg-target.h     |  2 +-
>   2 files changed, 33 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

