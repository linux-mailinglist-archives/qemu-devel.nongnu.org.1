Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D734775084
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 03:47:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTYIH-0008K6-3s; Tue, 08 Aug 2023 21:47:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTYIF-0008Jb-6s
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 21:47:23 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTYID-0004jM-Fv
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 21:47:22 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2681223aaacso331359a91.0
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 18:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691545640; x=1692150440;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=omPPpL2SGSkv94wFS5RXbNu0Nff+NPtphSgKgjWQ6P0=;
 b=YVQxqgIz5ZT249GoNvb0Q+EixElpI3HaFFbnB/79gAlSJJUvc6edkfUaCzgmZeq4y6
 szG8WuGal5xj0PwspGOUXbYFGcP7MgOvyU+K6N4JWwONoes4k1D3GADFkqsiQY1SLiPq
 i71pD2utoDStRf2QRsi7xCrGs0ziBPcUsiqtOZOwK6Ba1ukq0cynGMtkd2gt6G9X2C1R
 AocIgdxEEnf3aFmDV7u3SDzS259O1CxHaAhPcmqTs03wNfsFlaNfKL92QbINn4FRly6h
 rEiF/M78hQdEhOndTRYQKsFkOpSJdOoSFTfoG9t/+y95DdPnMtaLU5c2IS284JH99EaM
 19nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691545640; x=1692150440;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=omPPpL2SGSkv94wFS5RXbNu0Nff+NPtphSgKgjWQ6P0=;
 b=kpOCpZiydensabhsyJdbEczP/Hpaa7Da1efIruJ9FXZ7XYst68eEQbL8tNGU1PxLfv
 kyKnkN3UGWEdauipu2dBnKeLOh1IR6BcL0g5N4roQz8Fogko4wbCaQT5bd4/K0Xe14OT
 PgBA7CywmA26z3EY9xpI7RgvNWlvarr5FxcRoEDzU5FCui5ISw/+nSl5cmrFMTuUWU2n
 iHvWCoDCOydpEr0Ug0LnTxb71GksQYXapH7xpBRVSqide53ewCs759BbP7Xq+pxBF/YZ
 BaTeC8sFzoU0ShBcvWfjJv1aPJhcVoUhDquE3/qJof6L3A6TNjciX3hvZ07SrsN4YYPX
 elZQ==
X-Gm-Message-State: AOJu0YxjGdfQmiFrat2NCOHIEoFF9TEZgjo0GJ9sidqGIoJV1Kj9GADV
 ulUo/fImIcoIlQhXFxKfKvwxxNLBg4gT1zwoD9w=
X-Google-Smtp-Source: AGHT+IEBQfcUfP3CzcnAKNMXwkk7PBHsHHJDjAwE5kAUEYEBoovzsK/I3tcELVm3bKG3Xgf9hitYRg==
X-Received: by 2002:a17:90a:ba84:b0:267:6fd0:bd31 with SMTP id
 t4-20020a17090aba8400b002676fd0bd31mr1973630pjr.7.1691545639680; 
 Tue, 08 Aug 2023 18:47:19 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:63dc:2a47:f4bc:4a95?
 ([2602:47:d490:6901:63dc:2a47:f4bc:4a95])
 by smtp.gmail.com with ESMTPSA id
 pj1-20020a17090b4f4100b00263d3448141sm193159pjb.8.2023.08.08.18.47.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Aug 2023 18:47:19 -0700 (PDT)
Message-ID: <0a5370ca-ab9e-6a35-ea14-d685e1fa0540@linaro.org>
Date: Tue, 8 Aug 2023 18:47:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 03/33] Update the definitions of __put_user and __get_user
 macros
Content-Language: en-US
To: Warner Losh <imp@bsdimp.com>
Cc: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org
References: <20230808060815.9001-1-kariem.taha2.7@gmail.com>
 <20230808060815.9001-4-kariem.taha2.7@gmail.com>
 <d9caacde-d8ab-2fdc-372a-20988f22267c@linaro.org>
 <CANCZdfoMCNF-SuBz5Ab=rmeW+1VLbR4mcUvfYqkbuV91rdtyPg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CANCZdfoMCNF-SuBz5Ab=rmeW+1VLbR4mcUvfYqkbuV91rdtyPg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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

On 8/8/23 18:39, Warner Losh wrote:
>      > +#define __put_user_e(x, hptr, e)                                            \
>      > +    do {                                                                    \
>      > +        PRAGMA_DISABLE_PACKED_WARNING;                                      \
>      > +        (__builtin_choose_expr(sizeof(*(hptr)) == 1, stb_p,                 \
>      > +        __builtin_choose_expr(sizeof(*(hptr)) == 2, stw_##e##_p,            \
>      > +        __builtin_choose_expr(sizeof(*(hptr)) == 4, stl_##e##_p,            \
>      > +        __builtin_choose_expr(sizeof(*(hptr)) == 8, stq_##e##_p, abort))))  \
>      > +            ((hptr), (x)), (void)0);                                        \
>      > +        PRAGMA_REENABLE_PACKED_WARNING;                                     \
>      > +    } while (0)
>      > +
>      > +#define __get_user_e(x, hptr, e)                                            \
>      > +    do {                                                                    \
>      > +        PRAGMA_DISABLE_PACKED_WARNING;                                      \
>      > +        ((x) = (typeof(*hptr))(                                             \
>      > +        __builtin_choose_expr(sizeof(*(hptr)) == 1, ldub_p,                 \
>      > +        __builtin_choose_expr(sizeof(*(hptr)) == 2, lduw_##e##_p,           \
>      > +        __builtin_choose_expr(sizeof(*(hptr)) == 4, ldl_##e##_p,            \
>      > +        __builtin_choose_expr(sizeof(*(hptr)) == 8, ldq_##e##_p, abort))))  \
>      > +            (hptr)), (void)0);                                              \
>      > +        PRAGMA_REENABLE_PACKED_WARNING;                                     \
>      > +    } while (0)
> 
>     Hmm.  I guess this works.  The typeof cast in __get_user_e being required when
>     sizeof(x) >
>     sizeof(*hptr) in order to get the correct extension.
> 
> 
> This code was copied 100% from the current linux-user :) 

Ha ha indeed!  I should have known.


>     Is it clearer with _Generic?
> 
>           (x) = _Generic(*(hptr),
>                          int8_t: *(int8_t *)(hptr),
>                          uint8_t: *(uint8_t *)(hptr),
>                          int16_t: (int16_t)lduw_##e##_p(hptr),
>                          uint16_t: lduw_##e##_p(hptr),
>                          int32_t: (int32_t)ldl_##e##_p(hptr),
>                          uint32_t: (uint32_t)ldl_##e##_p(hptr),
>                          int64_t: (int64_t)ldq_##e##_p(hptr),
>                          uint64_t: ldq_##e##_p(hptr));
> 
>     In particular I believe the error message will be much prettier.
> 
> 
> Indeed. That looks cleaner. I'll see if I can test that against the latest bsd-user upstream.

I'll see if we can share this code via common-user.


r~

