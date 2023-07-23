Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA28675E3D7
	for <lists+qemu-devel@lfdr.de>; Sun, 23 Jul 2023 18:28:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNbwI-0003N9-DN; Sun, 23 Jul 2023 12:28:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qNbwG-0003Mm-RO
 for qemu-devel@nongnu.org; Sun, 23 Jul 2023 12:28:08 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qNbwF-0001ZV-C7
 for qemu-devel@nongnu.org; Sun, 23 Jul 2023 12:28:08 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3159da54e95so2503603f8f.3
 for <qemu-devel@nongnu.org>; Sun, 23 Jul 2023 09:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690129685; x=1690734485;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=au5injBrW/wgEIdZrabuz3Uf0cTT4jeosmGg1FMscZA=;
 b=SRMYnKJBufWSrZc2+VdmPg7yWy+uFmQe3WB64FgQ+FTG+B1T149G6ZuiqRwFVd3aGB
 Y4jpVAOu0o3VBqP4qokbAYamPvNSUr/Yk4t3eNu+6LhG4P++wltjgDvRvB8E5+c2kHNd
 ylCILGKyUcvEso6JXRF+oOIQT1Y26AwtZKPubRlXKfNzzhqqeJ1KGI55mT/4nmpZ5dUf
 zB085zYRcdkOhGUyPWHdP+qFGY3gJ4CiuoBeTqWuyjsrHIPk+NrA8GbY3e4fp8yl3aOA
 PI5fL05O+5wDedsatRzA2KUqw/FS0cGyJiox87x6fowgD43n+6MbaSVj5lUQIWzts+8p
 92gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690129685; x=1690734485;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=au5injBrW/wgEIdZrabuz3Uf0cTT4jeosmGg1FMscZA=;
 b=Ea8IZlGMJq2wZ82+djlZQ0eeI1dLhTmt15f9U0cgp6kp11kjD2SRqLSiiYCZO+A/KI
 wJtc/aeejbn0TH6J02u+VrWg4ZmE8/5e9cAfW0YnPXvcG05TGwY0IV/dartc81IfQaKJ
 XRgYtJOVRxzDQCjuU7TFxRuDxSPp1BRFfvUUc39rOS7dOq7FLj4934MMh+9Oqq8Lfh8K
 WOFYO+eQte62hgqajZpoAagr0LgmLu0po3WsbFqmcYe6YzRP05/aWA2PjDs2PFsAnDE5
 vaWxuq4nsLuDSgpMHyPJXRjgcBTMcvR3o8pFkh2RXuU5T5VUCLI4XxQ3U2MvAoc3Ikm+
 AKyw==
X-Gm-Message-State: ABy/qLa6eTHgddUj07veBPKyq1/Wku7emAozlQjMDnDGWjMjfkc0kh9s
 ExwtTTunBqI/ZG+IJB8nVx5U+1CQbU+8afHWQsDIUA==
X-Google-Smtp-Source: APBJJlFf55sg1Td3WDhxOwefSbPBAo/P9KTjZfMZGE1i7E7zoUjvPjYE0u2nLz3GTwPdUod+otipPA==
X-Received: by 2002:a5d:53c3:0:b0:317:568d:d69a with SMTP id
 a3-20020a5d53c3000000b00317568dd69amr2092129wrw.11.1690129685346; 
 Sun, 23 Jul 2023 09:28:05 -0700 (PDT)
Received: from [172.20.2.0] (179.181-106-213.static.virginmediabusiness.co.uk.
 [213.106.181.179]) by smtp.gmail.com with ESMTPSA id
 u9-20020a05600c210900b003fbcdba1a52sm10679643wml.3.2023.07.23.09.28.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Jul 2023 09:28:05 -0700 (PDT)
Message-ID: <bd4939e5-a848-bc94-6104-15657f59bf4b@linaro.org>
Date: Sun, 23 Jul 2023 17:28:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 03/14] target/s390x: Fix CONVERT TO LOGICAL/FIXED with
 out-of-range inputs
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand
 <david@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org
References: <20230719221310.1968845-1-iii@linux.ibm.com>
 <20230719221310.1968845-4-iii@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230719221310.1968845-4-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
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

On 7/19/23 23:11, Ilya Leoshkevich wrote:
> CONVERT TO LOGICAL/FIXED deviate from IEEE 754 in that they raise an
> inexact exception on out-of-range inputs. float_flag_invalid_cvti
> aligns nicely with that behavior, so convert it to
> S390_IEEE_MASK_INEXACT.
> 
> Cc:qemu-stable@nongnu.org
> Fixes: defb0e3157af ("s390x: Implement opcode helpers")
> Reviewed-by: David Hildenbrand<david@redhat.com>
> Signed-off-by: Ilya Leoshkevich<iii@linux.ibm.com>
> ---
>   target/s390x/tcg/fpu_helper.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

