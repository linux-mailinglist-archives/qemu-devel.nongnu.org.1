Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4E27660E1
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 02:48:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPAj7-0002cP-G5; Thu, 27 Jul 2023 19:49:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qPAiy-0002c3-MO
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 19:48:53 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qPAix-0000Zr-4s
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 19:48:52 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-267fcd6985cso1055513a91.2
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 16:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690501728; x=1691106528;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WLxNPOBzULVKYVKdnNiqLUg+vmLBWe5W8HRjr/iUQMk=;
 b=eCkyev24dBHJtTlRBDzYXXjFSNWwacgCqWB9QzVH99ipa/zqayanARghX8uiDKemke
 iRFzcaiAhiKP2hnzMcZEaEbcNL8eom8mebcCfo12YVpZ5TtbC3fZPweBZztjYl08d/mR
 JUMpC7VY5LnyThMs5OsfGLeVMLmd3/1fI5RaevzysHft52MBnvNX/90+B+1DoKReZ8tN
 U3JWsnj3LVTD23xZWBCMbJFzIRaI+sC7xHngbZpAgfUV0D/mBWtfHYx1eedSzuaw6qb3
 55ke6ULx6ZBbgvjs64aFQR0rBw3Gbk16JkXF6Rg0I+X3dYc7W2mi7y42rgodG6a0lRd9
 gD7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690501728; x=1691106528;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WLxNPOBzULVKYVKdnNiqLUg+vmLBWe5W8HRjr/iUQMk=;
 b=kcIT+JhswOUfRAIJ1OPyhg3AXSabtLYkysUII0iBjJ9IrsF2YwYp7ydHUpjcA7A+Xe
 8HMGY3+yb8moy79vOJ6IOvEHVR1OK84DKjzQnAB33xFnpVX54uffmcmhDvw2VBLKBvC8
 2293res9IZoBIDoXa+VNcVW1A/p5QnB0Zap1UtlQtzTfzecMkLJa2T5FCDNshKtyAxLP
 JKGnmcEkweuBcThQ6vD7lEIJFC4JWxPY+aB2f94nd70+JaBTA6JZ4moYI1HfrM1oSiul
 BUDb8BWtVAQhCaX6E/O6UB5FRMx05BYTHEudSzTo39Ry5l6KEO44aBTwDfLT2QriFe+m
 nC9w==
X-Gm-Message-State: ABy/qLbZ50KTqwp5UyKajBw5KcCCWN56kOIcr5ICMv6laq0PEq9ESZEw
 YjAOFcM3FWa1FEz04z80rIJoOA==
X-Google-Smtp-Source: APBJJlF3qxj7Uh06enILFwctWT9k4PL3y7+77hyyfdUZcMo1F3jyTFO3IhjvidllLnVXk/OhT8oTlg==
X-Received: by 2002:a17:90a:6304:b0:268:17a8:3b91 with SMTP id
 e4-20020a17090a630400b0026817a83b91mr83724pjj.28.1690501728305; 
 Thu, 27 Jul 2023 16:48:48 -0700 (PDT)
Received: from ?IPV6:2602:ae:154e:c001:943b:b6e1:1f00:9721?
 ([2602:ae:154e:c001:943b:b6e1:1f00:9721])
 by smtp.gmail.com with ESMTPSA id
 c16-20020a17090ad91000b00265a7145fe5sm3258533pjv.41.2023.07.27.16.48.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jul 2023 16:48:47 -0700 (PDT)
Message-ID: <88ff156e-5ec3-6306-3b83-6a8e2b103551@linaro.org>
Date: Thu, 27 Jul 2023 16:48:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 5/9] Replace target_ulong with abi_ptr in cpu_[st|ld]*()
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: ale@rev.ng, pbonzini@redhat.com, philmd@linaro.org, agraf@csgraf.de,
 dirty@apple.com, rbolshakov@ddn.com, anielhb413@gmail.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com,
 ysato@users.sourceforge.jp, peter.maydell@linaro.org
References: <20230721205827.7502-1-anjo@rev.ng>
 <20230721205827.7502-6-anjo@rev.ng>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230721205827.7502-6-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 7/21/23 13:58, Anton Johansson wrote:
> Changes the address type of the guest memory read/write functions from
> target_ulong to abi_ptr. (abi_ptr is currently typedef'd to target_ulong
> but that will change in a following commit.) This will reduce the
> coupling between accel/ and target/.
> 
> Note: Function pointers that point to cpu_[st|ld]*() in target/riscv and
> target/rx are also updated in this commit.
> 
> Signed-off-by: Anton Johansson<anjo@rev.ng>
> ---
>   accel/tcg/atomic_template.h  | 16 ++++++++--------
>   include/exec/cpu_ldst.h      | 24 ++++++++++++------------
>   accel/tcg/cputlb.c           | 10 +++++-----
>   target/riscv/vector_helper.c |  2 +-
>   target/rx/op_helper.c        |  6 +++---
>   5 files changed, 29 insertions(+), 29 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

