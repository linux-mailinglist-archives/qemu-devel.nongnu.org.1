Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D244073F4FC
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 08:55:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE2bt-0000cV-5L; Tue, 27 Jun 2023 02:55:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qE2bo-0000c8-7S
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 02:55:28 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qE2bm-00047R-Kw
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 02:55:27 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-312824aa384so3648600f8f.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 23:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687848925; x=1690440925;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8OLqYsHzPkoP3ZyodIdvHCkU3VVBtipdh5+Ak9HVdLM=;
 b=X8TuqN4ryjbJTX1l4E5GwNKOAt62ExmnDJ/UEadj1Q6D9W5OFaDcWrDPeXZMYAL6+A
 WZCNbjiIOwkyFFvQJWaR5R7vHyb7YqciGb5i67UV3whPB7JBm2MDIJfWsCZTcG7riWgJ
 I4wJVzXv3WlOdT2jCVUG/zZUKnRKCrlGpJ4sn5zWOTkppeFCz368Ww6y+NNi0EnhyGNV
 A48JHjSiTL4Y/wn1h6TBnpaTDLFMbFWovZQufWaV7Kqq4AiH4BFgu7NwyNSOqdbKmYYr
 vsFTXkkUQIJnmv2YjqueEmm3YmKrEreGLq9OJek2j11Uahs2rlD32VQfTgXWVdCa6h/p
 7ehQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687848925; x=1690440925;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8OLqYsHzPkoP3ZyodIdvHCkU3VVBtipdh5+Ak9HVdLM=;
 b=jRnvR4fbphqU6quuNfehz0LN1OAT7aSGoyY6zDMBO8xJdJ3zjZed7Njo79AbtnfPX3
 gHnikTmi9W3YQhZ49XOAGq7As5/+l6ifr5dgEc9Qiu+oH80K8kg6YUjqDOulUFzQyFZ+
 HVAVhwZHoeMoLyor69wUOukmq0qnvdndb+q8F/UqVM0YhLLPJzlnS3+ZMTU5hld4VXzW
 baPlPNJJE5JkStPqdlvSULTW5UB+kzvFkDokkNkmhO9a/wpPGHsJ0qPmz/EhWsszocXy
 vMSJdtT3NTYtiwgfqqhojAQB7iU7EPWOuGNMNl0woahF7AfslQAKeGhw4ZbOGmjMt4it
 L/Cg==
X-Gm-Message-State: AC+VfDwaQ1h9jsxCTO+yLiTq7anm2tl4hfp7EfdFo2STRwfMPmc493CJ
 D76QwGNXqoz6nzo2vZLfFELxRA==
X-Google-Smtp-Source: ACHHUZ4SE6JT7htgzUhnSxShOI9jnMKO/VPQEjT4my9vdObnQ1Jf/f4yD8aXmT+aqy2+TLgllS06QA==
X-Received: by 2002:a5d:68c6:0:b0:313:e952:e500 with SMTP id
 p6-20020a5d68c6000000b00313e952e500mr4365944wrw.7.1687848925103; 
 Mon, 26 Jun 2023 23:55:25 -0700 (PDT)
Received: from [192.168.157.227] ([139.47.41.103])
 by smtp.gmail.com with ESMTPSA id
 f18-20020adff452000000b003113b3bc9d7sm9428137wrp.32.2023.06.26.23.55.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Jun 2023 23:55:24 -0700 (PDT)
Message-ID: <32624588-a714-6317-77e3-39ce7cdaa8db@linaro.org>
Date: Tue, 27 Jun 2023 08:55:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 06/26] qemu-keymap: properly check return from
 xkb_keymap_mod_get_index
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
References: <20230626215926.2522656-1-alex.bennee@linaro.org>
 <20230626215926.2522656-7-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230626215926.2522656-7-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x431.google.com
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

On 6/26/23 23:59, Alex Bennée wrote:
> We can return XKB_MOD_INVALID which rightly gets flagged by sanitisers
> as an overly wide shift attempt.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   qemu-keymap.c | 24 ++++++++++++++++--------
>   1 file changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/qemu-keymap.c b/qemu-keymap.c
> index 229866e004..8c80f7a4ed 100644
> --- a/qemu-keymap.c
> +++ b/qemu-keymap.c
> @@ -140,6 +140,18 @@ static void usage(FILE *out)
>               names.options ?: "-");
>   }
>   
> +static xkb_mod_mask_t get_mod(struct xkb_keymap *map, const char *name)
> +{
> +    xkb_mod_index_t mod;
> +    xkb_mod_mask_t mask = 0;
> +
> +    mod = xkb_keymap_mod_get_index(map, name);
> +    if (mod != XKB_MOD_INVALID) {
> +        mask = (1 << mod);
> +    }
> +    return mask;
> +}

You have yet to answer Peter's question -- asked twice -- about what changes in the 
keymaps with this. If nothing, should it in fact be an assert instead?


r~

