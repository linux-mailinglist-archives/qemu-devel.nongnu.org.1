Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 455B17745ED
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 20:48:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTRkw-0008P3-Db; Tue, 08 Aug 2023 14:48:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTRku-0008Oq-Bn
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 14:48:32 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTRks-0004WE-Pt
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 14:48:32 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-26830595676so3997965a91.2
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 11:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691520509; x=1692125309;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NML/iGK3EMnCNJh/XgThozNq4Y3L58AsGQeJ5A4vXCI=;
 b=Kitmo8Gq+QV2um2LlgkMmoqAEoRs13vUEcGflGEe3tmWFZkA5jWdoSBpJg/JYy2jzz
 iCIVHHVF9ZVWBnIFjKVU7j2cHzs2xOX2iNMfJ/DPXPOwKwGzE+L0AYHpo/HlLd2K6I7B
 O5r+bIOIaxuV0F9kFz0oP4ArmzDWYTsy27nRzVYW34PqEVf8oObAJYFy0RmUIDQLTFQO
 YxTxRVfg9epjB6rvDfdebxQqcql8fGs4MoOiTmd/ZnBijwD8kcm4bp/0xRcvrHl9crha
 t593AJrhzO7UOSg0R0kQPF98pfIjxQ8t4rwfPgENkNp8O6Qi7kN2D1fHotxjAjmgs6hM
 Nssg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691520509; x=1692125309;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NML/iGK3EMnCNJh/XgThozNq4Y3L58AsGQeJ5A4vXCI=;
 b=QS2SBSA4qHRdpJHfEINMoLfl4Loquu3U59AylYjzcGdTLtn+RT6ZGi/+cg+pYOfunu
 Udi5LhoRvaALB/4622pZ3fjS9V7ayd4DEv04PCWiyD04J2QzNuSuml25nrSQc2hOXoNP
 RTp1YpKWDj3N1xoNv7znCsW/BOLQgTeqFGllJiEg2F5/Hdf3cqGukfOLkUxghqor58O0
 WGhcT5yLoVYoJvlyHbFkTCTo+3Yz0nFjZLbhdq1/2ljS5Sqg3MuztJuc8m8Ix24O4hn7
 sdqS1fu8EzMUCAMhTDi3KAtg8wzwq6Bv1B6ZPdtwVqEiJBGG8l5nr1OM0nW3gW2BHWXb
 G0bQ==
X-Gm-Message-State: AOJu0YwwxAuwHf4oa3f0mBCjnmTG0Mp0Kjs2+ZL6gHkIJYM8evLhbc5M
 J9drtePYpmyqpEwB0K4dJ29QNQ==
X-Google-Smtp-Source: AGHT+IEVQ1BzYrWdzsPZTW2FTLWBMoQgmo7PaBrseU1Gr6bRujjkwYqQcnj00z7r8Iqjz54dBfU9kA==
X-Received: by 2002:a17:90a:3808:b0:261:1141:b716 with SMTP id
 w8-20020a17090a380800b002611141b716mr318894pjb.33.1691520509301; 
 Tue, 08 Aug 2023 11:48:29 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:63dc:2a47:f4bc:4a95?
 ([2602:47:d490:6901:63dc:2a47:f4bc:4a95])
 by smtp.gmail.com with ESMTPSA id
 d10-20020a170902ceca00b001b7e63cfa19sm9383530plg.234.2023.08.08.11.48.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Aug 2023 11:48:28 -0700 (PDT)
Message-ID: <bb7294c3-1f2b-d6df-06fe-833233beca5d@linaro.org>
Date: Tue, 8 Aug 2023 11:48:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 08/11] target/loongarch: Reject la64-only instructions
 in la32 mode
Content-Language: en-US
To: Jiajie Chen <c@jia.je>, qemu-devel@nongnu.org
Cc: yijun@loongson.cn, shenjinyang@loongson.cn, gaosong@loongson.cn,
 i.qemu@xen0n.name
References: <20230808015506.1705140-1-c@jia.je>
 <20230808015506.1705140-9-c@jia.je>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230808015506.1705140-9-c@jia.je>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -61
X-Spam_score: -6.2
X-Spam_bar: ------
X-Spam_report: (-6.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.14,
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

On 8/7/23 18:54, Jiajie Chen wrote:
> -TRANS(addi_d, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_addi_tl)
> -TRANS(alsl_w, gen_rrr_sa, EXT_NONE, EXT_SIGN, gen_alsl)
> -TRANS(alsl_wu, gen_rrr_sa, EXT_NONE, EXT_ZERO, gen_alsl)
> -TRANS(alsl_d, gen_rrr_sa, EXT_NONE, EXT_NONE, gen_alsl)
> +TRANS_64(addi_d, gen_rri_c, EXT_NONE, EXT_NONE, tcg_gen_addi_tl)
> +TRANS_64(alsl_w, gen_rrr_sa, EXT_NONE, EXT_SIGN, gen_alsl)
> +TRANS_64(alsl_wu, gen_rrr_sa, EXT_NONE, EXT_ZERO, gen_alsl)
> +TRANS_64(alsl_d, gen_rrr_sa, EXT_NONE, EXT_NONE, gen_alsl)

alsl.w is in LA32, according to the table 2 on page 15.


> +/* for LoongArch64-only instructions */
> +#define TRANS_64(NAME, FUNC, ...) \
> +    static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
> +    { \
> +        if (ctx->la32) { \
> +            return false; \
> +        } \
> +        return FUNC(ctx, a, __VA_ARGS__); \
> +    }

With the change suggested for patch 7, this becomes

   return ctx->la64 && FUNC(...)


r~

