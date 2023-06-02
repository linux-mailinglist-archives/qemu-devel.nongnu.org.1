Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A949F720AEA
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 23:16:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5C79-0002Zl-8u; Fri, 02 Jun 2023 17:15:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q5C76-0002ZL-GX
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 17:15:12 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q5C6x-00032Z-T7
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 17:15:12 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3f6ffc2b314so28688565e9.0
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 14:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685740502; x=1688332502;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VEnkOqUebp+7NXf5UKmlwkSukckhBZbDe86QGOz1N6U=;
 b=dY9/S4p5n1YG0MUtJPXLcb8X9zRfkYgzPtgucQA9OSt1Y+5GnUiDAXufw3YOKoOO1+
 qCXHOCH0A5HrAcZ+qdhgYsMVuDammoH39JpBoi5IGNzFiXmDfbUdsLY+tJJ2mbH5Sew0
 SwXvxkOuOAhnXm2a0LxnYOxi7Nx4eG+jalSvNs674UFsWg+zcLrMUtm6xC/Sv6ne5lVv
 HfOkruNQAj9KvZDBIbkUROEbFdOVTcn0p00rYOEPID28WH3l7vQ3Xk7ntIjxaijwgPfg
 6aZ8DJ7e0wv/I6Xl38zCIjvO8OYkNFQ4lhP8wQ6MIinZf3XFlvFlwlpS1HdjeYgZYhei
 fiVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685740502; x=1688332502;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VEnkOqUebp+7NXf5UKmlwkSukckhBZbDe86QGOz1N6U=;
 b=eDoHyhvIhUvwXfxdDNgnhZ81Hn/GaGej/FC+4jqVxRq3Fih0m0jzPkej71n/sVVI8b
 x84pkldjn9EBi8s4oAidJzRC+wL3pDjWjewoulukUhAc1nGi9ROHtZMByadYau0e0l02
 rbpFTwwEaRByiA7SZ3dIfttnsYEAKiZHxKgPu1g0z+VjVrDNlVaN2kwRNfQkumjd+2OD
 7ZUvqv0QlmLL3bCaLI2XVfaIvfPvxtnd57EcrgJ5u9yrcqZXDtSIRKw03fgqopjZl1zx
 1P8b2zCCcitCPZ3GXcR8mycW8P7YaQvnMmKG5sUWl2ssJUeke1SKEWhHV9g7UkJsVu4R
 fPwQ==
X-Gm-Message-State: AC+VfDyzyfSUWPl5Ml9xH8Ocop82CMNvK7QEAHekNoYWM3twOv9EkqND
 Dv5U0tqbhzowdqTRQwno5Yj2pCzMZEUsC3Mmp9Q=
X-Google-Smtp-Source: ACHHUZ5ncRYwuhSharPBliy8ighMKcClldNFe4d33GXeYV/5QufyUlDq2b0yTcYrr+bJNZn+dGNgmQ==
X-Received: by 2002:a05:600c:8511:b0:3f6:ff08:6ad4 with SMTP id
 gw17-20020a05600c851100b003f6ff086ad4mr2931467wmb.3.1685740501885; 
 Fri, 02 Jun 2023 14:15:01 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.218.254])
 by smtp.gmail.com with ESMTPSA id
 k2-20020a5d4282000000b003047ea78b42sm2619909wrq.43.2023.06.02.14.15.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Jun 2023 14:15:01 -0700 (PDT)
Message-ID: <b1f6be3c-a275-8e3a-63e5-a9a7d804749a@linaro.org>
Date: Fri, 2 Jun 2023 23:14:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v3 24/48] tcg: Split helper-proto.h
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230531040330.8950-1-richard.henderson@linaro.org>
 <20230531040330.8950-25-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230531040330.8950-25-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.095,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 31/5/23 06:03, Richard Henderson wrote:
> Create helper-proto-common.h without the target specific portion.
> Use that in tcg-op-common.h.  Include helper-proto.h in target/arm
> and target/hexagon before helper-info.c.inc; all other targets are
> already correct in this regard.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/helper-proto-common.h | 17 +++++++
>   include/exec/helper-proto.h        | 72 ++++--------------------------
>   include/tcg/tcg-op-common.h        |  2 +-
>   include/exec/helper-proto.h.inc    | 67 +++++++++++++++++++++++++++
>   accel/tcg/cputlb.c                 |  3 +-
>   accel/tcg/plugin-gen.c             |  2 +-
>   accel/tcg/tcg-runtime-gvec.c       |  2 +-
>   accel/tcg/tcg-runtime.c            |  2 +-
>   target/arm/tcg/translate.c         |  1 +
>   target/hexagon/translate.c         |  1 +
>   10 files changed, 99 insertions(+), 70 deletions(-)
>   create mode 100644 include/exec/helper-proto-common.h
>   create mode 100644 include/exec/helper-proto.h.inc


> diff --git a/include/exec/helper-proto.h.inc b/include/exec/helper-proto.h.inc
> new file mode 100644
> index 0000000000..f6f0cfcacd
> --- /dev/null
> +++ b/include/exec/helper-proto.h.inc
> @@ -0,0 +1,67 @@
> +/*
> + * Helper file for declaring TCG helper functions.
> + * This one expands prototypes for the helper functions.
> + * Define HELPER_H for the header file to be expanded.
> + */
> +
> +#include "exec/helper-head.h"
> +
> +/*
> + * Work around an issue with --enable-lto, in which GCC's ipa-split pass
> + * decides to split out the noreturn code paths that raise an exception,
> + * taking the __builtin_return_address() along into the new function,
> + * where it no longer computes a value that returns to TCG generated code.
> + * Despite the name, the noinline attribute affects splitter, so this
> + * prevents the optimization in question.  Given that helpers should not
> + * otherwise be called directly, this should have any other visible effect.
> + *
> + * See https://gitlab.com/qemu-project/qemu/-/issues/1454
> + */
> +#define DEF_HELPER_ATTR  __attribute__((noinline))
> +
> +#define DEF_HELPER_FLAGS_0(name, flags, ret) \
> +dh_ctype(ret) HELPER(name) (void) DEF_HELPER_ATTR;
> +
> +#define DEF_HELPER_FLAGS_1(name, flags, ret, t1) \
> +dh_ctype(ret) HELPER(name) (dh_ctype(t1)) DEF_HELPER_ATTR;
> +
> +#define DEF_HELPER_FLAGS_2(name, flags, ret, t1, t2) \
> +dh_ctype(ret) HELPER(name) (dh_ctype(t1), dh_ctype(t2)) DEF_HELPER_ATTR;
> +
> +#define DEF_HELPER_FLAGS_3(name, flags, ret, t1, t2, t3) \
> +dh_ctype(ret) HELPER(name) (dh_ctype(t1), dh_ctype(t2), \
> +                            dh_ctype(t3)) DEF_HELPER_ATTR;
> +
> +#define DEF_HELPER_FLAGS_4(name, flags, ret, t1, t2, t3, t4) \
> +dh_ctype(ret) HELPER(name) (dh_ctype(t1), dh_ctype(t2), dh_ctype(t3), \
> +                            dh_ctype(t4)) DEF_HELPER_ATTR;
> +
> +#define DEF_HELPER_FLAGS_5(name, flags, ret, t1, t2, t3, t4, t5) \
> +dh_ctype(ret) HELPER(name) (dh_ctype(t1), dh_ctype(t2), dh_ctype(t3), \
> +                            dh_ctype(t4), dh_ctype(t5)) DEF_HELPER_ATTR;
> +
> +#define DEF_HELPER_FLAGS_6(name, flags, ret, t1, t2, t3, t4, t5, t6) \
> +dh_ctype(ret) HELPER(name) (dh_ctype(t1), dh_ctype(t2), dh_ctype(t3), \
> +                            dh_ctype(t4), dh_ctype(t5), \
> +                            dh_ctype(t6)) DEF_HELPER_ATTR;
> +
> +#define DEF_HELPER_FLAGS_7(name, flags, ret, t1, t2, t3, t4, t5, t6, t7) \
> +dh_ctype(ret) HELPER(name) (dh_ctype(t1), dh_ctype(t2), dh_ctype(t3), \
> +                            dh_ctype(t4), dh_ctype(t5), dh_ctype(t6), \
> +                            dh_ctype(t7)) DEF_HELPER_ATTR;
> +
> +#define IN_HELPER_PROTO
> +
> +#include HELPER_H
> +
> +#undef IN_HELPER_PROTO
> +
> +#undef DEF_HELPER_FLAGS_0
> +#undef DEF_HELPER_FLAGS_1
> +#undef DEF_HELPER_FLAGS_2
> +#undef DEF_HELPER_FLAGS_3
> +#undef DEF_HELPER_FLAGS_4
> +#undef DEF_HELPER_FLAGS_5
> +#undef DEF_HELPER_FLAGS_6
> +#undef DEF_HELPER_FLAGS_7
> +#undef DEF_HELPER_ATTR

Should we guard this header for multiple inclusions?

Otherwise:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


