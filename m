Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C878718F4F
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 02:01:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4Vit-0001A1-0z; Wed, 31 May 2023 19:59:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4Vir-00019f-7Q
 for qemu-devel@nongnu.org; Wed, 31 May 2023 19:59:21 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4Vip-000672-A3
 for qemu-devel@nongnu.org; Wed, 31 May 2023 19:59:20 -0400
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-6af6b5cf489so308488a34.3
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 16:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685577558; x=1688169558;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SmLdKTwAJMbI+NBmCaOlJ/gWQUoHsLa0kelKydpe2O4=;
 b=XqaCxXHi9FnuGaJXAL8Ipqr8THKPfz2ohyj7C6+sb+8YeY7cQI9L1n2QEIIwpFsRu5
 RmUCx/8l/N8b5ayZMY89cVnlri64Hrt8eJJBsQKEtVxB6sZ3AaDPy1gWl03AOkYXNTNu
 C8QOAcEYm9NWdIqVpebt28B5qBJEeKjtQ8VZWpjkg0xNy7HUWJXsODuE60EOefWYTVXz
 4WgYCqA1b4g2C4nfPl8oa7xBd49G4k/6KtofN3qgtRcIq9Umt3ChVMJablrWi1xr7+fU
 si4+pb6U6pi8F5kKnW4UjN19pqiIKrpB2GeWsUTXFTIwFIjayElXrIuOQj+UD0I7823I
 CKow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685577558; x=1688169558;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SmLdKTwAJMbI+NBmCaOlJ/gWQUoHsLa0kelKydpe2O4=;
 b=VzbQwCv2N6fyWrZw1WkNS3A3qRH2HMHhPtW+ziCsTrlpuSGFhy84tddf7Tu/YJvUPl
 dXofNYShV2lrHMyPgXmKxvuEvOrMo//ryOy1+Czbfv3m8GrXoOWos+FTEABrC3IAhRXs
 yXJ2G5ARmnDcKUL3Hpk+kUrudFAdS4azezFbKobcneKbW3NeWLCj0WgRRqrBgS++wsmU
 FZ+pT05tYLWbD34Sz0GwLDULK7O34NWbwVRAKAQgir0AopArEKV7f7kj3mPLk5Dyshym
 nA5IpHlGOT5VwtejaAEvi5wP5jvoPvFoUH31Z1V8FqKw6AMtNjwAktBH/NUhtYTPkeBq
 5WFg==
X-Gm-Message-State: AC+VfDwcGtwFmt/yIU3naRVqC4szMnxKhInIo8yX1fgv8x/LyVQ0+mTU
 4cQZBBJv04qwsHgYa8oNju0YJw==
X-Google-Smtp-Source: ACHHUZ5T7+lI14oCVwMaz+V6oD3vEcTX3sWtOeoJogUNwVLPk6y+6Sb0+VsOinve7eKzefybHCfBtQ==
X-Received: by 2002:a9d:4d86:0:b0:6af:991d:126b with SMTP id
 u6-20020a9d4d86000000b006af991d126bmr3954488otk.22.1685577557545; 
 Wed, 31 May 2023 16:59:17 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:3019:d9fa:8bb1:50d7?
 ([2602:ae:1598:4c01:3019:d9fa:8bb1:50d7])
 by smtp.gmail.com with ESMTPSA id
 z3-20020aa791c3000000b0063d2dae6247sm3866674pfa.77.2023.05.31.16.59.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 May 2023 16:59:16 -0700 (PDT)
Message-ID: <3653fd43-6fde-7974-f723-51f1c06c069f@linaro.org>
Date: Wed, 31 May 2023 16:59:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v14 02/10] accel/tcg: introduce TBStatistics structure
Content-Language: en-US
To: Fei Wu <fei2.wu@intel.com>, alex.bennee@linaro.org, qemu-devel@nongnu.org
Cc: "Vanderson M. do Rosario" <vandersonmr2@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20230530083526.2174430-1-fei2.wu@intel.com>
 <20230530083526.2174430-3-fei2.wu@intel.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230530083526.2174430-3-fei2.wu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::330;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x330.google.com
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

On 5/30/23 01:35, Fei Wu wrote:
> +    /*
> +     * We want to fetch the stats structure before we start code
> +     * generation so we can count interesting things about this
> +     * generation.
> +     */
> +    if (tb_stats_collection_enabled()) {
> +        tb->tb_stats = tb_get_stats(phys_pc, pc, cs_base, flags);

If cflags & CF_PCREL, then 'pc' should not be cached or matched.
Using 'phys_pc' will suffice, so pass 0 in that case.


r~

