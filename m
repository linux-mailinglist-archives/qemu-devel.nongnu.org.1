Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C66F799C41
	for <lists+qemu-devel@lfdr.de>; Sun, 10 Sep 2023 03:47:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qf9XP-0007dD-59; Sat, 09 Sep 2023 21:46:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qf9XM-0007Rr-AY
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 21:46:56 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qf9XK-0007yG-3f
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 21:46:56 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1c39bc0439bso3690625ad.0
 for <qemu-devel@nongnu.org>; Sat, 09 Sep 2023 18:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694310412; x=1694915212; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7sUAlhmjYdQg3v68zO0+RdMvYzPJpxKtQjx4bFJUh1c=;
 b=QL+HQurHWZnZ/UZPHDRze7sqlhaJBz6lnZ2yteZ0ddUWLcG5vrlXpQD180DWmz9hix
 f4PGeguDAG9YhwrDIJr3XNAio/mSiyy4TmDlIyFkoW4aw3c0lkBUdKgxiZEr3w/CjbQB
 A/wpIktiz7F6PGckGNIF2qWBMZQtVuuQ9pBtg+KwNLWRj8CATQ+nj5q6BvB5HeupGvrn
 VZqUbQ3iTyIyVro92y9Xd15Dx0BvFARdxzuZUbMB56gyFG8+9OQmYLtKwGjlSbS+vhhQ
 aCLJSXFzAkTkGJUY5krqYETbR7z+ZiGDCaBuoTrbfe1KpdJ8woQZw8y2+8NqvBsUHu2D
 0G3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694310412; x=1694915212;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7sUAlhmjYdQg3v68zO0+RdMvYzPJpxKtQjx4bFJUh1c=;
 b=APzC/xpjxvvAiOs6p58A/NozKKk23FRUKRP9i5lmRFfCW+bNd7C101TGIZk82WePyw
 obVknO6CufKVO5nJ+uEYYUHl0RSLtA1XtPe8b9x54fSJ//d3p3jcw4XjP1didxA66Ejg
 6nyl2d9lQ1XU/Kq/haEMkMhHmYZVN/Aj3hvC7rMiFsNmhMeHnv1luQMfJHGVhbkGAkiA
 nndqk/ZXe5k7jv5tI+YyppxznwwSOVRa5YUCuGN2445wVnioKQTVC+C1+2yAAIIUH3Pf
 1Vv5A+cby4GfoMfBAglrT7SAD1xF1wAfrNEt1UXMdJLUfm6Hx+xrzDOyX/7jPGusHlTa
 SA9A==
X-Gm-Message-State: AOJu0Yw6lunQ812ab3QY3+PcHdLhLyrCPAWYPyFUFC703WZ/7VaGtwIf
 f9ZfIOizTh9evLzNivxpFOUydQ1m6UKUMAFVlus=
X-Google-Smtp-Source: AGHT+IEJgi2KVK9jn1U5LOiEUyGQPDQxI3JWQsg6oR7crR6t+rcvdKPreD/TqWXNJbUjqojlfFeUDQ==
X-Received: by 2002:a17:903:244f:b0:1bc:edd:e891 with SMTP id
 l15-20020a170903244f00b001bc0edde891mr13387062pls.1.1694310412278; 
 Sat, 09 Sep 2023 18:46:52 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 p9-20020a170902e74900b001c3721897fcsm3780258plf.277.2023.09.09.18.46.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Sep 2023 18:46:51 -0700 (PDT)
Message-ID: <c1396a1e-437e-1714-1be4-ea3632bc48f4@linaro.org>
Date: Sat, 9 Sep 2023 18:46:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH RESEND v5 15/57] target/loongarch: Implement xvreplgr2vr
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: maobibo@loongson.cn
References: <20230907083158.3975132-1-gaosong@loongson.cn>
 <20230907083158.3975132-16-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230907083158.3975132-16-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 9/7/23 01:31, Song Gao wrote:
> --- a/target/loongarch/insn_trans/trans_vec.c.inc
> +++ b/target/loongarch/insn_trans/trans_vec.c.inc
> @@ -4407,27 +4407,42 @@ static bool trans_vpickve2gr_du(DisasContext *ctx, arg_rv_i *a)
>       return true;
>   }
>   
> -static bool gvec_dup(DisasContext *ctx, arg_vr *a, MemOp mop)
> +static bool gvec_dup_vl(DisasContext *ctx, arg_vr *a,
> +                        uint32_t oprsz, MemOp mop)
>   {
>       TCGv src = gpr_src(ctx, a->rj, EXT_NONE);
>   
> -    if (!avail_LSX(ctx)) {
> -        return false;
> -    }
> +    tcg_gen_gvec_dup_i64(mop, vec_full_offset(a->vd),
> +                         oprsz, ctx->vl/8, src);
> +    return true;
> +}
>   
> +static bool gvec_dup(DisasContext *ctx, arg_vr *a, MemOp mop)
> +{
>       if (!check_vec(ctx, 16)) {
>           return true;
>       }

check_vec in gvec_dup_vl instead.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

