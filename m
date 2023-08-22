Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B11DA784CAC
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 00:06:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYZVg-0001xS-C4; Tue, 22 Aug 2023 18:06:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYZVZ-0001uf-HN
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 18:05:53 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYZVX-0008JW-6P
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 18:05:53 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3fe4a89e8c4so47706105e9.3
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 15:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692741950; x=1693346750;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0iqmPCXNVTCotILrfMzT9fXSKgsTj+4pJSfX3tbYOus=;
 b=S3AvOJ8KgBlDjIPtagxtkmko++3TWdtmVyiileXAqbFqstHa/U0GMCo2ufV9K0kNQm
 UP0MAV4w/F3rARX4H+6aJAcvHp0nETHrBlapzH00hWdC3R4CuPtAPrwc5iR63JdnKKlx
 AjPcByye7ycmsUpSbdOg04d21cUd+F9nHKEdvDFkeZ/K56NsvYG001n4JEdLQa6C1sTd
 h+wQA3uFWPkINbjpCcgHOvgITeS2wL9/USC7H6iPoiLsOZvKJz06XL7C/TksmfyQe00g
 cKR7kPNlIodxNPNhQDAmxoS6TO21EbpAX6wOaSDwWzIfdt2iS8Fzg1XIXNBOpWeV+1X2
 3l5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692741950; x=1693346750;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0iqmPCXNVTCotILrfMzT9fXSKgsTj+4pJSfX3tbYOus=;
 b=HfHoeyMdAtAVezQJSqFfhgCzKVKtjVanrR8jDCBiMtXlqAkB3tf2extVYADMzsbobZ
 J7YdpcR6vzGJxW+eJLxnPXxFBRzAKLJ6Z9erbyw9nn0TRD4y0ODmu97BvR71LdBNX/qk
 Z6+wQX/3F2b2aATRZsMQmCDvkgxo8LCz4EoDgmvatgB36idh/5HhHAfBqHYM2JcILrIX
 G8PxK61+KPzR5+nXz++0Q+74vdYMlxj/8TtDiHglWqJcaRdhjVHChhCd2kea2J9cssv1
 Yj1RzfMf4rQvvPw5T62NgCw2JP0CQWMiyF2903mGc25VD7d8D8+IVL0QBUUaRJjoNc5W
 dI1Q==
X-Gm-Message-State: AOJu0YyEDFImYp19+YJ3eKDtNu0YALvhCX3pV348Q6SMLadwN+AkhesH
 2K3aDOJxIjgBCV/1tOGsIT+EaQ==
X-Google-Smtp-Source: AGHT+IEYPXYSdekR3bQ9/CGcmYt8mj6fTIo2IKGTc5EOD8xXXUKBoGVPvpAO4MqvPJnaYY4YYEoB1g==
X-Received: by 2002:a05:600c:2117:b0:3fe:e074:1b7f with SMTP id
 u23-20020a05600c211700b003fee0741b7fmr8802148wml.18.1692741949606; 
 Tue, 22 Aug 2023 15:05:49 -0700 (PDT)
Received: from [10.2.0.2] ([37.19.214.4]) by smtp.gmail.com with ESMTPSA id
 c1-20020a7bc001000000b003fee567235bsm12783843wmb.1.2023.08.22.15.05.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Aug 2023 15:05:49 -0700 (PDT)
Message-ID: <19bce54d-5e47-e0f9-e804-434ef99839fc@linaro.org>
Date: Wed, 23 Aug 2023 00:05:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH] tcg: Unify TCG_TARGET_HAS_extr[lh]_i64_i32
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230822175127.1173698-1-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230822175127.1173698-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.767,
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

On 22/8/23 19:51, Richard Henderson wrote:
> Replace the separate defines with TCG_TARGET_HAS_extr_i64_i32,
> so that the two parts of backend-specific type changing cannot
> be out of sync.
> 
> Reported-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-opc.h        | 4 ++--
>   include/tcg/tcg.h            | 3 +--
>   tcg/aarch64/tcg-target.h     | 3 +--
>   tcg/i386/tcg-target.h        | 3 +--
>   tcg/loongarch64/tcg-target.h | 3 +--
>   tcg/mips/tcg-target.h        | 3 +--
>   tcg/ppc/tcg-target.h         | 3 +--
>   tcg/riscv/tcg-target.h       | 3 +--
>   tcg/s390x/tcg-target.h       | 3 +--
>   tcg/sparc64/tcg-target.h     | 3 +--
>   tcg/tci/tcg-target.h         | 3 +--
>   tcg/tcg-op.c                 | 4 ++--
>   tcg/tcg.c                    | 3 +--
>   13 files changed, 15 insertions(+), 26 deletions(-)

Clever than what I was thinking of, thanks!

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


