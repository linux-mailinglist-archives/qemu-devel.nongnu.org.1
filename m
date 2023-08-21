Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A309F7824F1
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 09:54:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXzja-0002MF-RG; Mon, 21 Aug 2023 03:53:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qXzjZ-0002M2-Ec
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 03:53:57 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qXzjX-00023i-B0
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 03:53:57 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-307d58b3efbso2709100f8f.0
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 00:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692604433; x=1693209233;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=y7yrKa6SuZpNMOED93+vMCHmPOfATG6FOyLkP8eRaoQ=;
 b=dKjWf237nq6RWN36vpyiva7LO34mYO/iiq611fG1t7IB/6cVgC/aJ3J2kya9p1GygX
 1eTvgD/kBj6rJHEJa/mCGyUOXjiiitY1UQMg4COYcxay1yr50CM1g1JS9C8fksqB00BJ
 cBJiMRBTphw2cNOTJ09islQbCih6keIt1csG9AYpsbzqST9f6DOIDsix1kVooQOqu//4
 VI6e0oPbYBSp9AZX1qlLf68e3h6okXQG2YyCN2jpzZbuSaw42JSeaN29Jq467/mW/jnV
 tvF7VjZWOI0sSMM6eXifdoIi4IhUVYerD7rB0sqLIVPE7mrlPG/1SCBJJLQdrJauqFXd
 LZZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692604433; x=1693209233;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=y7yrKa6SuZpNMOED93+vMCHmPOfATG6FOyLkP8eRaoQ=;
 b=ARCM6E07CQrerWnIMRsJhpAUyhRmYkjm0hahAEA4H8Sdf2DZWwaK9/94gTJP7FUHJr
 1wJm9dPSvQ3SMNnJu91SjgTU/WQgBS7Hj9f3n+mtNYxkdsp9Pxkd+x3wBnAXuaUVg47v
 5G7AFFzOryc+xfnayoIojpO7hhIWOgkUflR7+NVmWP3xp57FPPkHPswj79Qedr2Q5PzD
 LAUv5Am1+oy1+wRnSyAt4OSMJgeIf3TDO4JIuQzEM7ex8qA6Tehs0hdeX04R46xeqNeb
 suwWC3VeyLwNw0NmsSiXnhP7/Fc0Dn6LZTjw+aOBYlFmMCakleVynLF9hJVWToJ4ecJ5
 zXUg==
X-Gm-Message-State: AOJu0Yy20DjlI1hKFZO10Z2Tlp6RXMvYlvSvVrEtWWg6XVPDG5K4UQFr
 iJ1A96o2O0d9Xzigo+hxyNxdMklf/fJ1QRxtWY0=
X-Google-Smtp-Source: AGHT+IFk0LQ7hPRe0icOuOYl+G4e56rCnZkjgqvPDmncZOIqHBN59uDchmSnHP91UfsHFZ6uhbELBA==
X-Received: by 2002:adf:f64c:0:b0:317:718a:e83f with SMTP id
 x12-20020adff64c000000b00317718ae83fmr4207461wrp.68.1692604433717; 
 Mon, 21 Aug 2023 00:53:53 -0700 (PDT)
Received: from [192.168.69.115] (static-176-182-122-208.ncc.abo.bbox.fr.
 [176.182.122.208]) by smtp.gmail.com with ESMTPSA id
 a8-20020adfed08000000b003196dba130asm11525356wro.106.2023.08.21.00.53.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Aug 2023 00:53:53 -0700 (PDT)
Message-ID: <f0f37693-2334-286e-07e8-fa8f9b3b7028@linaro.org>
Date: Mon, 21 Aug 2023 09:53:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v2 10/18] target/arm: Use clmul_32* routines
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, ardb@kernel.org
References: <20230819010218.192706-1-richard.henderson@linaro.org>
 <20230819010218.192706-11-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230819010218.192706-11-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.279,
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

On 19/8/23 03:02, Richard Henderson wrote:
> Use generic routines for 32-bit carry-less multiply.
> Remove our local version of pmull_d.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/vec_helper.c | 14 +-------------
>   1 file changed, 1 insertion(+), 13 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


