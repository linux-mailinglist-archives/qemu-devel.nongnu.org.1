Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A878175E2F2
	for <lists+qemu-devel@lfdr.de>; Sun, 23 Jul 2023 17:59:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNbTW-0002sZ-87; Sun, 23 Jul 2023 11:58:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qNbTS-0002rj-LQ
 for qemu-devel@nongnu.org; Sun, 23 Jul 2023 11:58:23 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qNbTR-0002DR-8K
 for qemu-devel@nongnu.org; Sun, 23 Jul 2023 11:58:22 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3143ccb0f75so3122921f8f.0
 for <qemu-devel@nongnu.org>; Sun, 23 Jul 2023 08:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690127899; x=1690732699;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9IuWwTITZuejK1toXLD7lL6imMzLV/pyvVxYHAVJSXg=;
 b=TvIFjD+0wGEVngBBvjzLL1LlzJYgzcjHX/cJIwedQfvhpTlqEr80+fqhw1YVVG0EJm
 IhErWVJchP6/KoU974eljtTT2Z+6LwV+nfD/gaF1bECq+BVQ7Xk/nuBFKyLzm3fNTrC0
 R9L8iQVDIFStpoIwjJxuK7YxYJFZGvAchEoA8XKgCBTg7KMOqTMOWSU52Fn2FI1WAdpQ
 0oWwVfHTPOjl/PMSKQ8voon991ROJDbwxASwVgE7F3t5TVhSulEVwvIKZXhryjUnIVWd
 s/JFTbbmzDJnB4aOtAFkgZ4ykdVcjJHarwldVjkbWWfHxoMHnY6C0B2iWV3buCDscCdT
 tGfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690127899; x=1690732699;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9IuWwTITZuejK1toXLD7lL6imMzLV/pyvVxYHAVJSXg=;
 b=YhGLpV3WA3PUtiFKZQYQnz7c8+VHA/Xiq8pvwzIcjbCx9FVG5BEwd+XXGBHkGAZ6qT
 tU+g8io7FCYcx/TvkG++t3rNgtCNQLwliBUowey+u+uXTBa4rV+gG0y3exnjr+l6I/Oo
 MNHXm3UEh99eNeJ1klmqaVNGeRZVpamDWFGCfDQAYOW2sCmnUbSdy0MX9obLysFIRppt
 wLjFS5F0yBRhraQumWWohl52Bnj6Xo25R17HPu9zeadbkxALQl3XoIaDmnRaZOw7e6NX
 flkhjje1ipMYXnUXHZ4vB1oYosVRjYPXWJ4dMJ+e7PbWq6YTfD1GgVPydQqXze6NUWWM
 e88Q==
X-Gm-Message-State: ABy/qLbKl9PHLiATlgwYklJJQwNp9obmuFk+Rde2QTjyTxHzUo2oW7MU
 60ASSH1wJw76W4UQg8CkzJFpkhIvgEtJOkyKDm+S7w==
X-Google-Smtp-Source: APBJJlEkPcL/Oypq6odHBPzJaYxEwhCl4IczjKv552Q/PyWd0axeHjzjK0qGRk1TpwjtIB+1XIkVqA==
X-Received: by 2002:a05:6000:180e:b0:313:dfa3:4f7b with SMTP id
 m14-20020a056000180e00b00313dfa34f7bmr6321866wrh.20.1690127898975; 
 Sun, 23 Jul 2023 08:58:18 -0700 (PDT)
Received: from [172.20.2.224]
 (179.181-106-213.static.virginmediabusiness.co.uk. [213.106.181.179])
 by smtp.gmail.com with ESMTPSA id
 h17-20020adffd51000000b0030fa3567541sm10038512wrs.48.2023.07.23.08.58.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Jul 2023 08:58:18 -0700 (PDT)
Message-ID: <47134d04-e8d2-b8ee-88f1-09096d77e7f2@linaro.org>
Date: Sun, 23 Jul 2023 16:58:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 12/14] target/arm/ptw: Check for block descriptors at
 invalid levels
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20230714154648.327466-1-peter.maydell@linaro.org>
 <20230714154648.327466-13-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230714154648.327466-13-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x432.google.com
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
> The architecture doesn't permit block descriptors at any arbitrary
> level of the page table walk; it depends on the granule size which
> levels are permitted.  We implemented only a partial version of this
> check which assumes that block descriptors are valid at all levels
> except level 3, which meant that we wouldn't deliver the Translation
> fault for all cases of this sort of guest page table error.
> 
> Implement the logic corresponding to the pseudocode
> AArch64.DecodeDescriptorType() and AArch64.BlockDescSupported().
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/ptw.c | 25 +++++++++++++++++++++++--
>   1 file changed, 23 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

