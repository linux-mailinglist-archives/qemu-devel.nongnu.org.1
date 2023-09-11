Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A90279B1B6
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 01:57:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfqlk-0004j0-WB; Mon, 11 Sep 2023 19:56:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qfqlj-0004iY-FQ
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 19:56:39 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qfqlg-00017D-L4
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 19:56:38 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1c39f2b4f5aso13562045ad.0
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 16:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694476595; x=1695081395; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZEAzcsh1XBS/ptuskL4I9wxxh2+GByDrkNla24eQbE4=;
 b=veWwHdSEq9NmctLBI4Za+AzDTk3lKSNQHO43jWGzYCICB/6gL/IN5bousiZ9iOG54A
 flDBU++qXIX5wSxIMonaOkNqOfxigEMWvS2hNJtApWydynbhHD+8bCihs+Acs6qOcRuB
 84DkAyhTLEKHgGXsOhXq3mOfoiyhqbLN/3V57pw4Y5ccDGDnw2IKLwY+NStW3BjE6eIN
 5CAacuSQIPcQVyuRnWG/0K1W14g7tCbueMlHc/3ry9Bf/L+J75ZkIpEKC4WKyVQaZTyJ
 x138N/x0sUTbkyNl+g1luLzoFhlfSMeugfdguNmeRmxYb/XOwDzzbTmf2AoL+Pv3k1Bw
 KzkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694476595; x=1695081395;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZEAzcsh1XBS/ptuskL4I9wxxh2+GByDrkNla24eQbE4=;
 b=v+Tl9wAiqwSBd/NU9iZNH/r9ZEBnRPk/ZsSD1liuy/Vw4Q3vkGfZYygjSaFak6nFlb
 yrtVobLXh2ODhUSMYJnmMN2tE1pRdThY6Q7gw+83ONShMFyFxB5KjiEZjCRKPezzXMTi
 zxffdPavs8yncO6zaKdGc18P2ZT8lS1t2Rs9rTVKMBJf3DXs7u8T0dtgrXGc58qugPVf
 vn8NZLEp58jqg1iz5o6xBcFWHqAIkDPC7izyvx82UgH5FsG6IBmobmUpN4ddo+Dzltkk
 nn1O9vM7uf3oYyzegDNiAC/RdV1KQnk72lRm2waJSYvHp824ryx2W9oFinVzMWXPhlC7
 HFog==
X-Gm-Message-State: AOJu0YwDbOEihi9Uget1W1biyGgs7iCI1yAsHV3bhW58XrQdu7VLKj2G
 UH4BEdV7WLohvBF+98i/tcc6dQ==
X-Google-Smtp-Source: AGHT+IEBDXaFiRNGOHsoQpMksuxSc17oHsAG+udCk3E3TL3qj1dyTVztZ2mvCoifNUXFjgwKH1chYQ==
X-Received: by 2002:a17:902:eccb:b0:1bf:70be:ca8b with SMTP id
 a11-20020a170902eccb00b001bf70beca8bmr11270436plh.43.1694476594924; 
 Mon, 11 Sep 2023 16:56:34 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 l20-20020a170903005400b001bdd719874esm7060624pla.168.2023.09.11.16.56.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Sep 2023 16:56:34 -0700 (PDT)
Message-ID: <97225446-50ff-7a76-ea30-fe8bd48a7dae@linaro.org>
Date: Mon, 11 Sep 2023 16:56:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v3 16/23] bsd-user: Implment madvise(2) to match the
 linux-user implementation.
Content-Language: en-US
To: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org
Cc: imp@bsdimp.com
References: <20230909193704.1827-1-kariem.taha2.7@gmail.com>
 <20230909193704.1827-17-kariem.taha2.7@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230909193704.1827-17-kariem.taha2.7@gmail.com>
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

On 9/9/23 12:36, Karim Taha wrote:
> Signed-off-by: Signed-off-by: Karim Taha<kariem.taha2.7@gmail.com>
> ---
>   bsd-user/bsd-mem.h            | 53 +++++++++++++++++++++++++++++++++++
>   bsd-user/freebsd/os-syscall.c |  4 +++
>   bsd-user/syscall_defs.h       |  2 ++
>   3 files changed, 59 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


> +    switch (advice) {
> +    case MADV_DONTNEED:
> +        if (page_check_range(start, len, PAGE_PASSTHROUGH)) {
> +            ret = get_errno(madvise(g2h_untagged(start), len, advice));
> +            if ((advice == MADV_DONTNEED) && (ret == 0)) {

Duplicate check for MADV_DONTNEED.
Useless parenthesis.


r~

