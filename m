Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D36720AEC
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 23:18:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5C9g-0003il-NB; Fri, 02 Jun 2023 17:17:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q5C9c-0003i8-Sk
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 17:17:48 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q5C9b-0004lN-5n
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 17:17:48 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3f6dfc4dffaso24341835e9.0
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 14:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685740665; x=1688332665;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JkREzvBGYw+S/pUq/JQ6X3rp88ktrpWKwGCX1EQ6ga0=;
 b=YwFqzLY8/a/8pbIHjtmQifseyFFwBn6Rw/X1Q1UzFLhk+vzv9b6jUtYMxWeLWLsgxb
 Zmz5uR68OzBH76YehAJQ4RFEJWEx3gKuGVrOty9P3NYjPu1/hIniQyk9fdEDlnvHqYtg
 NPXFTv0p5screWhDi4EPRSjq6fHSR+E5QiOLAMn6TpCXNmjsdCuIACGgOdJnTREywfYQ
 WfHcbnA4NNwyk0L2ZDOQXx85jrnkPjPObl+jAgHDWfyz7d+XYf30xYiAKlbKOCJILI4k
 6cHwlLXgGshGIQ9jJxEX5YQpY5rZMB2DJGUpPTFDE4NBEKNmZAPa7TJB6Kh+1gakZy6i
 YHRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685740665; x=1688332665;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JkREzvBGYw+S/pUq/JQ6X3rp88ktrpWKwGCX1EQ6ga0=;
 b=LFRFZOu9MVVklQggtU9Cg3JpU4U9vliTlkklx6KLPD5G9/KURhwehOxGFsJxQ2X39V
 cy+xyNVpFuE/gYV5k0H2hKgGGCebdikf4s1p1dCsqdYE0s9PUTGPEJNg+6+d0qnhNSmP
 nBbQEujbKbZQZEDns/9FLanJddRHO3pBE8/dLfV4NMzxqsoEznm3mE1HW9cRn+CbdW3a
 6KBMey61IHErGXI6REHlk2jBQyo4hlq2YrF9XCUM2/sG+U4su/58vE2uv1n6k9cmm5V2
 P0N8RxrajActLsHEPjN/+fJqh8CLyYFHfKXxhpmpKXhQuSj+YEBRo5OoIVQ6w2Naky3G
 ZYlw==
X-Gm-Message-State: AC+VfDwWvZIKu2hG96+v3c9ixSqXyqxg55tAIf9Sq8b7ecie1jTtEvDZ
 XJPu+7qgrqvhklNDyUK1x0prmKaI6RH8trvSkWI=
X-Google-Smtp-Source: ACHHUZ62Zxvje+Fpi4d83mY3jqqh5N32fanSlscXHVeZjINS5MHStPJ71opG9UGSp67PpyL8IvUiQA==
X-Received: by 2002:a05:600c:24e:b0:3f5:fc21:5426 with SMTP id
 14-20020a05600c024e00b003f5fc215426mr2893991wmj.41.1685740665647; 
 Fri, 02 Jun 2023 14:17:45 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.218.254])
 by smtp.gmail.com with ESMTPSA id
 h8-20020adfe988000000b0030ae5a0516csm2666248wrm.17.2023.06.02.14.17.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Jun 2023 14:17:45 -0700 (PDT)
Message-ID: <ab5b8c14-b85c-5f97-981a-f1ad85d30318@linaro.org>
Date: Fri, 2 Jun 2023 23:17:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v3 23/48] tcg: Split helper-gen.h
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230531040330.8950-1-richard.henderson@linaro.org>
 <20230531040330.8950-24-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230531040330.8950-24-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 31/5/23 06:03, Richard Henderson wrote:
> Create helper-gen-common.h without the target specific portion.
> Use that in tcg-op-common.h.  Reorg headers in target/arm to
> ensure that helper-gen.h is included before helper-info.c.inc.
> All other targets are already correct in this regard.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/helper-gen-common.h |  17 ++++++
>   include/exec/helper-gen.h        | 101 ++-----------------------------
>   include/tcg/tcg-op-common.h      |   2 +-
>   include/exec/helper-gen.h.inc    | 101 +++++++++++++++++++++++++++++++
>   target/arm/tcg/translate.c       |   8 +--
>   5 files changed, 126 insertions(+), 103 deletions(-)
>   create mode 100644 include/exec/helper-gen-common.h
>   create mode 100644 include/exec/helper-gen.h.inc


> diff --git a/include/exec/helper-gen.h.inc b/include/exec/helper-gen.h.inc
> new file mode 100644
> index 0000000000..83bfa5b23f
> --- /dev/null
> +++ b/include/exec/helper-gen.h.inc
> @@ -0,0 +1,101 @@
> +/*
> + * Helper file for declaring TCG helper functions.
> + * This one expands generation functions for tcg opcodes.
> + * Define HELPER_H for the header file to be expanded,
> + * and static inline to change from global file scope.
> + */
> +
> +#include "tcg/tcg.h"
> +#include "tcg/helper-info.h"
> +#include "exec/helper-head.h"
> +
> +#define DEF_HELPER_FLAGS_0(name, flags, ret)                            \
> +extern TCGHelperInfo glue(helper_info_, name);                          \
> +static inline void glue(gen_helper_, name)(dh_retvar_decl0(ret))        \
> +{                                                                       \
> +    tcg_gen_call0(&glue(helper_info_, name), dh_retvar(ret));           \
> +}
[...]

File not guarded for multiple inclusions, otherwise:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



