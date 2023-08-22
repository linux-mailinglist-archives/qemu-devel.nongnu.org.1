Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 336BD784679
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 18:04:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYTqH-0002eU-42; Tue, 22 Aug 2023 12:02:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYTqE-0002Xc-QT
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 12:02:50 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYTqC-0005lb-MM
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 12:02:50 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-689f9576babso3087975b3a.0
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 09:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692720167; x=1693324967;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yUM9W6DZOf2hjYZwOYag3UIR/IeQKfsCpE/7lK2sDxY=;
 b=X5gmUxu0mEgJoKT4D3K3T0Ckj0SenevCXfq7K/IfAlQcFOsXktTfSacOW0ixxFfskj
 uUfWnycxUR3ujwUNROMvSAIZeWOhMALoifaBvDxaLYZcFujcof3ydV44cgJYp1gesBEC
 uqIPWrZ+hAeyxXlfPF5mSSJYZPYWdqAvZTcEq2+SVznt4ksKtlkOE77b3F1i77yi5iFE
 njNvvLPQhsjdxdvVCFVwstT6WCX1qoFGQWSi2uDzQUFzf2pnXqIBwN2h4VaMKdx0UqaH
 kNJSKgynbtKlD4/H968O9Uqv4TE5hhJn0OfGS3svLmIP9/MrXbqQnQ0yOmSamgLnN3Ux
 32Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692720167; x=1693324967;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yUM9W6DZOf2hjYZwOYag3UIR/IeQKfsCpE/7lK2sDxY=;
 b=EKaJyXUnB3QDPu9bNatyMyr7c/qf9muNWtTEd/F0ksU77DhmJGKhOOBAI7uNeJbArV
 NfYsCjOPP+hbfSs8Lelwjuqdrr2cUCV1HHIBVa/0e5IsLkKO43/DV9eBkvUe/QNhvsgo
 I5BDS2Ec57II2miYyByM6ExyiK/D3SktLranDYROCG2+VdXPBXrftwKEhvn20NBJL2sn
 VPsWsQq9gvxsuqUvdZvIenzUn4gWDclW3oQW3ALjdVCY2K6AT0rCmL+jyRkxKg3QDV7m
 F8F3mi2eRczVyXW4ijoyjI5OoZaK/MSdBvTp3F6n3bqOZskIAdGboge3g1uPZioV58/H
 N2og==
X-Gm-Message-State: AOJu0YyiuxsfG491xE9inIoWg1h1bx5F/s0X1EvUXeohP/7BZ1Cpsnvi
 gNL5VkMc1X//3p7I2WzZ3Uz4Kw==
X-Google-Smtp-Source: AGHT+IHIllubwRlMAoh8+BQtaB94KjGI0QTv+4hJdSHE7RO4B/NTiDWChVkRBxMF7M7PlA5FEcd7AQ==
X-Received: by 2002:a17:90a:9a85:b0:26f:4685:5b69 with SMTP id
 e5-20020a17090a9a8500b0026f46855b69mr5501898pjp.7.1692720165312; 
 Tue, 22 Aug 2023 09:02:45 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:4e3c:f4a4:b92a:b5ab?
 ([2602:47:d483:7301:4e3c:f4a4:b92a:b5ab])
 by smtp.gmail.com with ESMTPSA id
 m6-20020a17090a414600b002633fa95ac2sm9887274pjg.13.2023.08.22.09.02.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Aug 2023 09:02:44 -0700 (PDT)
Message-ID: <7adb2607-2f0d-34af-eef3-5237be7ea508@linaro.org>
Date: Tue, 22 Aug 2023 09:02:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 4/7] tcg/tcg-op: Document hswap() byte pattern
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20230822093712.38922-1-philmd@linaro.org>
 <20230822093712.38922-5-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230822093712.38922-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

On 8/22/23 02:37, Philippe Mathieu-Daudé wrote:
> Document hswap_i32() and hswap_i64(), added in commit
> 46be8425ff ("tcg: Implement tcg_gen_{h,w}swap_{i32,i64}").
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   docs/devel/tcg-ops.rst |  4 ++++
>   tcg/tcg-op.c           | 26 +++++++++++++++++++-------
>   2 files changed, 23 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

