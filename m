Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B23F736A22
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 13:01:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBZ5l-0002tM-FI; Tue, 20 Jun 2023 07:00:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBZ5i-0002sn-7u
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 07:00:06 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBZ5g-0001BJ-Gx
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 07:00:05 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-985b04c46caso684275766b.0
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 04:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687258802; x=1689850802;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rPwfOjVOdCImrYsaEUnmT/xTvMWss0vrm9gkhzhzpMA=;
 b=YrgVBJ9ZjXSynGioBxS+M4jSKsldwyEG03uIx0WpAL9SU6UTI9nLxDgXNdaPSiVGtR
 kKKpCA00IOTFsD/IEWorJl1Ro5SaL3/IwBpJJZrgWAtL8yRc9uhfIOFY85EevglPR6tB
 5RVlee+qbTNnAul5ucQK7OzXtjVDEpelCeq0KnjShBjvEH4vMW+6weyyl17eHQ4EesW/
 /B7jfd9ya9eqM3iGl8XRSKTzLzKNgLCQ8fB6Fw9kIOYJOlJUxdhll4GZB6SGXTLmNVjH
 eqfpP1aHD4qYEgR4cxbrb31QkKovqvY0AbNTQbtxsOmQkf5+AunzW9MAvS+lBsMlIAe+
 F7zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687258802; x=1689850802;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rPwfOjVOdCImrYsaEUnmT/xTvMWss0vrm9gkhzhzpMA=;
 b=Kat36GwDMxt8LIebxHtINbji741vAPGNiRtYy1Mtx94yAO8zBeFl1IT6KiStjyMlgP
 NJeZlnIryhL8NLxHWXJqQxBaJpWvjXm6+U31bXRWv+RKjnKfR+Zt6ThB8StpkcgDEsw+
 Rwzy9Hhsk6GLlXCM54Ws/Bjl6raGJY5V5/8NFfdQZZLeA+xcB3wTM9nagyWukJfwz/BI
 VZAW4+I3Rw5kNDqFJlUqBn85qnqn8Jiy5V2Kji8NGEIDA99e8qSp6x1w43r7JAKce/hm
 waWWC3f0LBQ7UgM9Prdyn8XB+N0CKeFG4xjT4uu7XGcXSWDdenLNGP43HqrxlsaX2uxh
 8juw==
X-Gm-Message-State: AC+VfDwZxsoQMsfFXHC6NtaqMFhlYRW14UXM03Cx3nFRUSLznzYL6CiQ
 FCq/cib3+fIaHOSivPCHSSjpUw==
X-Google-Smtp-Source: ACHHUZ5pmAcb7u16hmAMKluCEZtlUIGLXc5qb6VDYt7VHnVCQGjZa73DttTGN4lYKnQHjzMCJRkiEA==
X-Received: by 2002:a17:907:36c2:b0:965:fb87:4215 with SMTP id
 bj2-20020a17090736c200b00965fb874215mr11539171ejc.15.1687258802319; 
 Tue, 20 Jun 2023 04:00:02 -0700 (PDT)
Received: from [192.168.69.129] ([176.176.183.29])
 by smtp.gmail.com with ESMTPSA id
 n22-20020a170906b31600b00982c0ac984asm1176640ejz.176.2023.06.20.04.00.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jun 2023 04:00:02 -0700 (PDT)
Message-ID: <c891bb6a-7f61-78db-a28e-7240f2542784@linaro.org>
Date: Tue, 20 Jun 2023 12:59:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] x86_64/atomic128-ldst.h: fix arch include guard
Content-Language: en-US
To: =?UTF-8?B?RnLDqWTDqXJpYyBQw6l0cm90?=
 <frederic.petrot@univ-grenoble-alpes.fr>, qemu-trivial@nongnu.org,
 qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org
References: <20230620083918.9134-1-frederic.petrot@univ-grenoble-alpes.fr>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230620083918.9134-1-frederic.petrot@univ-grenoble-alpes.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x636.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 6/20/23 10:39, Frédéric Pétrot wrote:
> Fix arch name in the define that prevents multiple inclusions.
> 
> Signed-off-by: Frédéric Pétrot <frederic.petrot@univ-grenoble-alpes.fr>
> ---
>   host/include/x86_64/host/atomic128-ldst.h | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/host/include/x86_64/host/atomic128-ldst.h b/host/include/x86_64/host/atomic128-ldst.h
> index adc9332f91..d0240d4212 100644
> --- a/host/include/x86_64/host/atomic128-ldst.h
> +++ b/host/include/x86_64/host/atomic128-ldst.h
> @@ -8,8 +8,8 @@
>    * atomic primitive is meant to provide.
>    */
>   
> -#ifndef AARCH64_ATOMIC128_LDST_H
> -#define AARCH64_ATOMIC128_LDST_H
> +#ifndef X86_64_ATOMIC128_LDST_H
> +#define X86_64_ATOMIC128_LDST_H
>   
>   #ifdef CONFIG_INT128_TYPE
>   #include "host/cpuinfo.h"
> @@ -65,4 +65,4 @@ static inline void atomic16_set(Int128 *ptr, Int128 val)
>   #include "host/include/generic/host/atomic128-ldst.h"
>   #endif
>   
> -#endif /* AARCH64_ATOMIC128_LDST_H */
> +#endif /* X86_64_ATOMIC128_LDST_H */

Actually, I recently merged a fix for this: 8a2bd747877.


r~

