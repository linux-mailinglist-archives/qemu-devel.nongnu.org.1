Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 81FB375E2DB
	for <lists+qemu-devel@lfdr.de>; Sun, 23 Jul 2023 17:30:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNb1e-0003Om-CL; Sun, 23 Jul 2023 11:29:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qNb1b-0003OS-Ea
 for qemu-devel@nongnu.org; Sun, 23 Jul 2023 11:29:35 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qNb1Z-0001hq-VS
 for qemu-devel@nongnu.org; Sun, 23 Jul 2023 11:29:35 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3163eb69487so2823710f8f.1
 for <qemu-devel@nongnu.org>; Sun, 23 Jul 2023 08:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690126172; x=1690730972;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hMSbM4o/QNAWjg3NfP2THi27wvPf38ApXknvXZ92o34=;
 b=fDrd+yrOH+XLKUIqVS9/uyYlUFcc3nwqx6Z43w0M33on8vPoPLszrJ0jIB9K0XmQmc
 RB4Po5SiOtndhECiZvIkhjKAWpRYipe1D4bG9kSts8Hr7KHEzkS7wVrZsibKILLhOcrI
 BgbeA8Xtn7MJVS7GhoDTPFm0L7p+MQV6yt7Q5JGJzfGJa0VQBnHPWUh+fUg+SghC9nA1
 WEgcQQiEUPv0Ofv+UjSuQAlJf2ixyMTRkki4EC88LfP8LoLX+CTx4g8dInUbiq+1LtLO
 umzsXZ1pqdGKj+4hzCtqgNtazd6j2mFyGJAp+7nPMhpFn1QmC/F5j8gcG/u0JQAQgWLW
 LLqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690126172; x=1690730972;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hMSbM4o/QNAWjg3NfP2THi27wvPf38ApXknvXZ92o34=;
 b=k5oIwBDnmEyf9Y5LKj0VEE3fGmKRcCip+EprIMxaGVdc8Vh9Txd9ouQF5ShZhBl7pN
 jI04W9esk3oWhudXkkg24bfI5fTSZUxZc7f2HBeFKcshj9XzXZ6F4AjtwWw+dR5L9fon
 PeaRKi3NIgaT5xIvOscrzzB4c1NUpyOqKnn9TCC0gm4ax8tEplRA44FP70XI8YUV5o/D
 WG3v+3I8bZdCWD6b4Mx6HnmWdlUNBrnF1Vi2dlTTqjpGQqKmk5D6VkIxFDzQyYdTFLU3
 /ryrhGKqqf7KUFdWNdcJ/pdKqA5TZxGkkHl3eswdwKqAWofAoAd32g4GU8Jb+v7cU40U
 aiuQ==
X-Gm-Message-State: ABy/qLb7QuwIGJ6NOslWlzpu62KnHMc0A9jGt/Gm+qG/MJRCUQHqsWYF
 vDvhiafzWXAzz9CxdBrrVxBX4A==
X-Google-Smtp-Source: APBJJlHmL48potgprhGlXDn8zvrE2WG37rOg6T8O59+lz8Jfm/ZO5oK0RjvDqbC8kpQ32rcaaxYlAg==
X-Received: by 2002:a5d:53c2:0:b0:315:9ec6:7401 with SMTP id
 a2-20020a5d53c2000000b003159ec67401mr9533585wrw.21.1690126172540; 
 Sun, 23 Jul 2023 08:29:32 -0700 (PDT)
Received: from [172.20.15.116]
 (179.181-106-213.static.virginmediabusiness.co.uk. [213.106.181.179])
 by smtp.gmail.com with ESMTPSA id
 s11-20020a5d4ecb000000b003144b50034esm9970006wrv.110.2023.07.23.08.29.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Jul 2023 08:29:32 -0700 (PDT)
Message-ID: <1d76f32a-a9dc-bb38-b23b-0de89f303f17@linaro.org>
Date: Sun, 23 Jul 2023 16:29:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 07/14] target/arm/ptw: Only fold in NSTable bit effects in
 Secure state
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20230714154648.327466-1-peter.maydell@linaro.org>
 <20230714154648.327466-8-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230714154648.327466-8-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42a.google.com
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
> When we do a translation in Secure state, the NSTable bits in table
> descriptors may downgrade us to NonSecure; we update ptw->in_secure
> and ptw->in_space accordingly.  We guard that check correctly with a
> conditional that means it's only applied for Secure stage 1
> translations.  However, later on in get_phys_addr_lpae() we fold the
> effects of the NSTable bits into the final descriptor attributes
> bits, and there we do it unconditionally regardless of the CPU state.
> That means that in Realm state (where in_secure is false) we will set
> bit 5 in attrs, and later use it to decide to output to non-secure
> space.
> 
> We don't in fact need to do this folding in at all any more (since
> commit 2f1ff4e7b9f30c): if an NSTable bit was set then we have
> already set ptw->in_space to ARMSS_NonSecure, and in that situation
> we don't look at attrs bit 5.  The only thing we still need to deal
> with is the real NS bit in the final descriptor word, so we can just
> drop the code that ORed in the NSTable bit.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/ptw.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

