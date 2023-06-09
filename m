Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4756172A4CB
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 22:39:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7irW-0003dP-GK; Fri, 09 Jun 2023 16:37:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q7irT-0003ci-2T
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 16:37:31 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q7irP-0004P5-JK
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 16:37:28 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1b025d26f4fso11478835ad.1
 for <qemu-devel@nongnu.org>; Fri, 09 Jun 2023 13:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686343045; x=1688935045;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YNPeX8XdOeVklglpjzvWIN7BvHsArbNso3VbGrb9+xo=;
 b=p6AzOmVLNoYvi5F+CDphEkCy3qbWTUXHjKjGQvVstgzmeagO+bgZgvR9j5D6cYoaI0
 vTuq0dkp3zETTN0za5Z1DiV0sq9ePDMsf+QYMMtz5R/ca3bUBELUWBR7N4YqmrRr+voW
 IbCkc6bzTbUrrN5Nle89VeBUog4Hno26o8wl7wW8g5B/uFuF7DOAeKHLQpIkGkTRIn2r
 yqYXdV/TCxJJUMaVF+7G6Oa51zCduziM3ez6RQroLnJgy5EeG+UAz9TGRwSuaMs/Tnk9
 FbMU19Gv+WopZ4pGCAElDknTv7kLAiePlbCvWhFJFyTxiMRb1gbdLbs5p4aIiRror7Jp
 SoiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686343045; x=1688935045;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YNPeX8XdOeVklglpjzvWIN7BvHsArbNso3VbGrb9+xo=;
 b=f5jQDDvbSU5GOxM7S7aMV9OMh5VBfq2vos5N/n+ovwwDHZigj73onqmMDIniNpeR8y
 Kw9u6AFkiNfjiKPXRterltEf1QrV8Lmt47eIMlAY7e53FWmGvLhgaIltpOpCsmVuE9xj
 XUU+WaZMsjIUlGLYdprZNWxioJ8XnqMNlMZhx7pTSCjo2JJpUqmy8YYaqVaAMilNThwv
 1VgX7qAba+bXO7yLdPoKqvah3dJYSbETcXkYjzVIbY4wBqMD5Gd9spEMG0gkGi/pSX/2
 Apd2Z7jLtTlzzvNm5q8p3cH0Wr9nLhgeFA36LLpedMNLrOrICnOg0PCuYP1kH0R1J+Kh
 j+gQ==
X-Gm-Message-State: AC+VfDzoUo5KLXAlLIUCgAPiUfpXZ7DDYwDyJdLAnbT+ZkzRC/up+mlq
 9YQmy8Ww2SYmJBiFDq8fP+7SGQ==
X-Google-Smtp-Source: ACHHUZ6gBXHTXe0V0zIYMKsytk2NpRcLfkUwKqvmtD4YVoCNR1oPNof23wg/RGRsE7jDiAw4StcwBg==
X-Received: by 2002:a17:903:2351:b0:1ae:5fb0:4256 with SMTP id
 c17-20020a170903235100b001ae5fb04256mr3058106plh.57.1686343045525; 
 Fri, 09 Jun 2023 13:37:25 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:20be:c4cb:f609:8cca?
 ([2602:ae:1598:4c01:20be:c4cb:f609:8cca])
 by smtp.gmail.com with ESMTPSA id
 h21-20020a170902f7d500b001a6cd1e4205sm3647141plw.279.2023.06.09.13.37.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jun 2023 13:37:25 -0700 (PDT)
Message-ID: <4954843f-41f9-d78e-d93d-328185f976e3@linaro.org>
Date: Fri, 9 Jun 2023 13:37:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 21/22] target/arm/tcg: Remove inclusions of
 'exec/helper-[proto/gen].h'
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20230609104717.95555-1-philmd@linaro.org>
 <20230609104717.95555-22-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230609104717.95555-22-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 6/9/23 03:47, Philippe Mathieu-Daudé wrote:
> diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
> index 8fb44a8b7f..5621728271 100644
> --- a/target/arm/tcg/vec_helper.c
> +++ b/target/arm/tcg/vec_helper.c
> @@ -19,12 +19,16 @@
>   
>   #include "qemu/osdep.h"
>   #include "cpu.h"
> -#include "exec/helper-proto.h"
>   #include "tcg/tcg-gvec-desc.h"
>   #include "fpu/softfloat.h"
>   #include "qemu/int128.h"
>   #include "vec_internal.h"
>   
> +#define HELPER_H "tcg/helper.h.inc"
> +#include "exec/helper-proto.h.inc"
> +#include "exec/helper-gen.h.inc"
> +#undef  HELPER_H

I am surprised that helper.h.inc would be required here and in most of the other 
foo_helper.c, where helper-foo.h.inc has already been used.


r~

