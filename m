Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B91A765941
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 18:53:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP3l1-0003Dh-7J; Thu, 27 Jul 2023 12:22:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qP3kz-0003DR-J7
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 12:22:29 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qP3kx-0007Pa-RW
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 12:22:29 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1bb7b8390e8so7055285ad.2
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 09:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690474946; x=1691079746;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dE+RaGmoN2KwC/lSwdCLBe3OQltgtBdSPDAyLwGX1Ec=;
 b=bDr07gO9c+DqSTUH8bpYuSJ91WGFXG+p/LISkHL3fP+u+l88aeS9Hg05MSbPdw7W+d
 KbLyVTNZCFi2QZlGrQ4mHBy2SXMn5NC+C2uhZKT/UjvCZkA1oaxamtOdsvUQRbe2Mhoi
 CFga/LfMwXwzYfVUKYrh+5xNfgh2xLI3It3Ow8oIFb6DoKiyYh0dU0xxq52TF/uSX+JD
 AOdJO4MIvYf9sd9tG5SYdrsF17r/OnOI4/mbZJVoOEDroOzxhakHNsL4ThB1rDgOJ6gN
 pSdpbXlI/lygw5GNbmt/JAF9tTicPuc/AYT18E5uXPFHZKdBzeuKPREcBigwsIHHqZCv
 G8qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690474946; x=1691079746;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dE+RaGmoN2KwC/lSwdCLBe3OQltgtBdSPDAyLwGX1Ec=;
 b=YO4WMtg/BdmYuSMmIVaAizCneVnZi/ysoTKlTGl1al/rtzfGDAicSYcpc4b2LCJO3w
 GyF2jSwmDCI2Ofa6+qjaocUoeyJ/34lOKWbEtD+1gNvmpdZFD7/Z4gujXtlj9qdWtzk2
 OVA3QLfVQ+0ZOHfMYu9l/UlKSjcTL1bgrztE5TvRmIBZ85moKn/bM/uumXc1YQ8JPZV7
 yeHD6B16WIUFLjU4DZVcj7Yvn9LIzv+PCRIzBv40ZaksAvLxDOZzDgN3qVb2I/pC6Ndw
 JhcJjue9WTG5qZ/dGR/H2jEQE952KyRmC9hug2pyJd87zBUVg+xqtYbr8gU6YUTWO01K
 y9yA==
X-Gm-Message-State: ABy/qLaISA3dtPWQjPvJWTzPQUaL71L/RvE3MmcjuoGkKbMxgZ3d1ZcN
 w49gYFXqhv4V14ea8jSaCSi1dg==
X-Google-Smtp-Source: APBJJlG8PkCGvJGfztoM4pfdSaiQcUPRcl9nIh8bg9Qd2Fc2pZ3+E/SMt6TBRYLd1nLqdUSXfnmBPQ==
X-Received: by 2002:a17:90a:cf10:b0:268:522a:e31 with SMTP id
 h16-20020a17090acf1000b00268522a0e31mr3782232pju.42.1690474946075; 
 Thu, 27 Jul 2023 09:22:26 -0700 (PDT)
Received: from ?IPV6:2602:ae:154e:c001:caf5:5ae2:432a:1bdf?
 ([2602:ae:154e:c001:caf5:5ae2:432a:1bdf])
 by smtp.gmail.com with ESMTPSA id
 w24-20020a170902d71800b001b8052d58a0sm1815818ply.305.2023.07.27.09.22.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jul 2023 09:22:25 -0700 (PDT)
Message-ID: <f1b9a6d3-026c-33ef-c5d5-9ab32ebe8d71@linaro.org>
Date: Thu, 27 Jul 2023 09:22:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] target/arm: Avoid writing to constant TCGv in trans_CSEL()
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
References: <20230727103906.2641264-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230727103906.2641264-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 7/27/23 03:39, Peter Maydell wrote:
> In commit 0b188ea05acb5 we changed the implementation of
> trans_CSEL() to use tcg_constant_i32(). However, this change
> was incorrect, because the implementation of the function
> sets up the TCGv_i32 rn and rm to be either zero or else
> a TCG temp created in load_reg(), and these TCG temps are
> then in both cases written to by the emitted TCG ops.
> The result is that we hit a TCG assertion:
> 
> qemu-system-arm: ../../tcg/tcg.c:4455: tcg_reg_alloc_mov: Assertion `!temp_readonly(ots)' failed.
> 
> (or on a non-debug build, just produce a garbage result)
> 
> Adjust the code so that rn and rm are always writeable
> temporaries whether the instruction is using the special
> case "0" or a normal register as input.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 0b188ea05acb5 ("target/arm: Use tcg_constant in trans_CSEL")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> These insns are v8.1M-only, which is why this bug has
> lingered for so long.
> ---
>   target/arm/tcg/translate.c | 15 ++++++++-------
>   1 file changed, 8 insertions(+), 7 deletions(-)


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

