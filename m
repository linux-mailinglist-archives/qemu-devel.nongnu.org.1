Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E21BC70FC72
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 19:18:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1s6Y-0006Mi-If; Wed, 24 May 2023 13:16:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1s6W-0006Im-8f
 for qemu-devel@nongnu.org; Wed, 24 May 2023 13:16:52 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1s6U-00064h-La
 for qemu-devel@nongnu.org; Wed, 24 May 2023 13:16:52 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-52cb78647ecso416353a12.1
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 10:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684948609; x=1687540609;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=N1jCPZGzUZx2R5fAkIKTQSo4Ro/fUaj18sYgDSrz+4A=;
 b=RFPKkTSwV1Arzwea7frwbEDCGmGTihGcbLn0QcCIUYrCisXUmeYtfiUPJ5W7TlFyLG
 pE38MOjYny/gLvxfJ7a/CVBHVR233kvF9i92lkv2Fwc+/wNmSx3Zc5+LCyvsbsAmOlw0
 SCsR9SbvEP8izpEntz5PpWfkcvEWWxqrT7wF5+Px5IvsugEohPM5Ww15LrDVH1jNUNRN
 hgUJfa+Lccw99tSr2L61uh4Dvk66kqoQEZC5084W7MQMHN2tGllGcduibxwZ8xlggDtL
 sLsxd4flBGLm9140A/796dyceT6bc7NYaK6kAz9elKRadgO908DipuBfXz5bc08iBbuP
 Cb3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684948609; x=1687540609;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=N1jCPZGzUZx2R5fAkIKTQSo4Ro/fUaj18sYgDSrz+4A=;
 b=eeX3cQzYzHqwNC1E4Qv1+k8UQqnV+gDgIEoR2FJjHqka7CaKIdzakmGxNgwMisRAIX
 A7goM2YjxmQuDijIH1GJdzjgMm4eEtwXQceAKnYCQxhEk9/6t9Vdcj/1hTdJjZwhpGWK
 g4tEuVrUbzznN1sUscXa9gVL5h0EsgQAk/iBdX1NnhJ+dsQklEOb1S6fBbrkOyOqSxBu
 rg9xwajYvkWs1TFz+1p9zz3p1+z41mbrHXm3VJc1B9WwBm4IosN3acIYg09NxK0HB9J9
 SvNPZkI7kqlO3X66uxLIljWTcFD+pYB+AtRBhGrRXHGmcnvzCg/J0zbLAlWEwnqjQQiP
 ZDBQ==
X-Gm-Message-State: AC+VfDxV9TT+2P9zycGnvYGwXCj/vw0NjvRIEiebxWhH/fu1z8ZV6dMj
 FtLC2zzewfEPIPIlHNhqS8+jXA==
X-Google-Smtp-Source: ACHHUZ44d81YVv2kP6EKOI8IXZAXZpUxamijVlBR4VXHU3MBeHHHklUi6vJwHYtywDIxTJTP87Lvsw==
X-Received: by 2002:a17:903:41cf:b0:1ad:bb89:16f6 with SMTP id
 u15-20020a17090341cf00b001adbb8916f6mr21771387ple.50.1684948609276; 
 Wed, 24 May 2023 10:16:49 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:6b03:9af2:33c1:3d6b?
 ([2602:ae:1598:4c01:6b03:9af2:33c1:3d6b])
 by smtp.gmail.com with ESMTPSA id
 l12-20020a170902d34c00b0019e5fc21663sm8967437plk.218.2023.05.24.10.16.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 May 2023 10:16:48 -0700 (PDT)
Message-ID: <c6a2f3a9-1d4e-36de-9841-ad28927a3554@linaro.org>
Date: Wed, 24 May 2023 10:16:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] checkpatch: Prefer DEFINE_TYPES() over type_init /
 type_register_static
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
References: <20230524145444.32820-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230524145444.32820-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.107,
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

On 5/24/23 07:54, Philippe Mathieu-Daudé wrote:
> When multiple QOM types are registered in the same file, it
> is clearer and simpler to use the the DEFINE_TYPES() macro.
> 
> Add a rule to checkpatch.pl to suggest using DEFINE_TYPES()
> instead of type_init() / type_register_static().
> 
> Suggested-by: Daniel Henrique Barboza<dbarboza@ventanamicro.com>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   scripts/checkpatch.pl | 6 ++++++
>   1 file changed, 6 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

