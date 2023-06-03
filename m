Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D4450720E0B
	for <lists+qemu-devel@lfdr.de>; Sat,  3 Jun 2023 08:10:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5KSa-00028G-0q; Sat, 03 Jun 2023 02:09:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5KST-00025x-Q1
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 02:09:49 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5KSS-0006ER-28
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 02:09:49 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-5341737d7aeso2551951a12.2
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 23:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685772586; x=1688364586;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/BVnUD4/xN8HMF9BgOMr9cFZMOeJV+sr1gI7zpdYz7U=;
 b=XgyLmhZaGkZwURE1s53X0ydbTQyQFp28RIJKITsuo28cBGU3aJmgvTZoW2gvJ+hbil
 vE012mf9KPyt4I1zGMcqv/qChVnZAp+Kzi3St/KL7QJU/7l141oQ4PafAeliHL3+E7yL
 hhajZEa67+jEx5yS99L150cOs7hdAcfAIFbmb0DQilNMtAQ8xsoU8gQ4XRH3cRf4naNM
 U8mMH5UQv/27NaBkoaaRVIiHNZzgjZQ3LGScQmXCYuSmlWaY+0NQFWJQcU0rrqW92lUv
 64mRf33O43yQbQYmImkauwakMSCkmLwL88OyvtMhtI/p6u2pgf//2stSycnmX3B/DOXt
 ReUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685772586; x=1688364586;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/BVnUD4/xN8HMF9BgOMr9cFZMOeJV+sr1gI7zpdYz7U=;
 b=ijaRs6DTtSv9C7eXgELnpSPOHNHrsf/C+pChOc+3UtaU7XWe/KjhIvN3gtwGpxZ8FS
 ns+t7GrFSCWdGNEykoPNV+U8StyIyJPDHi7Or7KVXkiXQqcbGgbBGel61Zv8VF55I2Pr
 ezDuUN8HRH4CPILDKn5G1u/r/uYJXKYgHkwFXywi25xiBAIC3aMciJKWEGB5U+WgoPvm
 PLmyOJkONfnMK4yUPHY9hj84i2g1ERbJK+GNJjRKOfCxRQQVHCShpTq9jc77Zk4x/bML
 2cgsWyvG42isRn2IiJYP2s4XZO6a6a4aQtj/ZtntaXms2F+rvqGrApmNQ7xHohrtAE1E
 Lvcg==
X-Gm-Message-State: AC+VfDxY/s05ootx4UCS71Nuq1EW37lh0zwpUpDYbL7GNAHB/ddsMKz6
 FP8OT/CtBdAhJcVA1+Om7BhmbA==
X-Google-Smtp-Source: ACHHUZ77RwADa/JJUayCFWG5USdw8Z52TOOGluY8XNYQfkpAPdKiRrAT2seU5lzRbCFCdRY/7xGU0w==
X-Received: by 2002:a17:903:22c9:b0:1ac:4a41:d38d with SMTP id
 y9-20020a17090322c900b001ac4a41d38dmr2244726plg.51.1685772586545; 
 Fri, 02 Jun 2023 23:09:46 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:66a6:82c2:d794:68f6?
 ([2602:ae:1598:4c01:66a6:82c2:d794:68f6])
 by smtp.gmail.com with ESMTPSA id
 q5-20020a170902c74500b001ac55a5e5eesm2375372plq.121.2023.06.02.23.09.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Jun 2023 23:09:46 -0700 (PDT)
Message-ID: <f887f9c5-a870-e5c9-c859-77ddbdcee76b@linaro.org>
Date: Fri, 2 Jun 2023 23:09:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 07/20] target/arm: Convert exception generation
 instructions to decodetree
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20230602155223.2040685-1-peter.maydell@linaro.org>
 <20230602155223.2040685-8-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230602155223.2040685-8-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.095,
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

On 6/2/23 08:52, Peter Maydell wrote:
> Convert the exception generation instructions SVC, HVC, SMC, BRK and
> HLT to decodetree.
> 
> The old decoder decoded the halting-debug insnns DCPS1, DCPS2 and
> DCPS3 just in order to then make them UNDEF; as with DRPS, we don't
> bother to decode them, but document the patterns in a64.decode.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/tcg/a64.decode      |  15 +++
>   target/arm/tcg/translate-a64.c | 173 ++++++++++++---------------------
>   2 files changed, 79 insertions(+), 109 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

