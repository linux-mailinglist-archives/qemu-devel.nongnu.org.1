Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8A073691B
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 12:22:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBYVC-0007NI-B1; Tue, 20 Jun 2023 06:22:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBYV9-0007Mj-FQ
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 06:22:19 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBYV7-0000GJ-Te
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 06:22:19 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5195c85fbb2so5685815a12.2
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 03:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687256535; x=1689848535;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8qZq7Sj9Z1+/AuLBZudyIsCXHiG9eyRrTdXAw5gAymg=;
 b=ncS2myg3xC2gWwpjNT0KJhDdTOEzU82KmTHmpoCF5ABIumileqf4nFUu9GERlN557Y
 /r2qbYjWq/4Lv6kW8SxzsZv/7Q1L3kFBsXmu3nmQuAztiSRWjSiNYN/bOUk/bsxQwP3n
 h7WJlrWT0T6fhfrbeExeUmsVgvDqSNNs7LAxXplhWmMNamlvUrxPUZB7wY8mGfxhJAKh
 DUA/yR/YGmtetiepg6tqWabXKsf5MT2xEZYaULpTna2+cLzTlEmrIMFLow1zPCLxYEGX
 Ul1MR6J2Rp8OwpUt2DJwQQkwWHQUkMo1TP6OXJR7lXhbs/zFl0fh3ejWuxJRK3hIwXfU
 NCJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687256535; x=1689848535;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8qZq7Sj9Z1+/AuLBZudyIsCXHiG9eyRrTdXAw5gAymg=;
 b=OC9zUB+YExZfRnakyiczsn8sYgciJN4+y/YANaq/7PdKgWb2aSGsUd/wvMBmkpfIGF
 BLGr3DtHFR6mXqkeLq8mWJ6UZ7vAPZsuMultABr0nC94UwmN6lNT2n0I8jwwqceSUbUQ
 ioaNKx8YH7CeXQSEHFd7UFDhHlDpy/8CtR3Ss8OUlRZx8pGpQOeuxs/3lyQgez6251Gy
 YsVFSTdyTeOmIvxWZlwstJyrrpyCon50r9I5roNBxOtTBM51HwFigq4at9JdDAXgBxZp
 EXydY6MaS2qt/bG5dJcmwe2bn1qoD46iUHuil0SQ39yb9r9S5rO7mZcJt/xPn7UOvy+3
 G+uQ==
X-Gm-Message-State: AC+VfDymMxur5k1u9HBUCPW1NBomykE2z2nKuWQsvPRk3dWAs4DYBXN1
 rQIGWEumMHri0edawLo+i39Blw==
X-Google-Smtp-Source: ACHHUZ7nYE69IBPSN2Wxcw9aH0u2qCBiqEPRGh+IEswMBUzabNLclLZQNrbL7F5XX1ytVil4q0aJhw==
X-Received: by 2002:a17:907:160d:b0:989:3ae0:772a with SMTP id
 hb13-20020a170907160d00b009893ae0772amr906325ejc.50.1687256535510; 
 Tue, 20 Jun 2023 03:22:15 -0700 (PDT)
Received: from [192.168.69.129] ([176.176.183.29])
 by smtp.gmail.com with ESMTPSA id
 ks25-20020a170906f85900b0098864f474cesm1108233ejb.126.2023.06.20.03.22.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jun 2023 03:22:15 -0700 (PDT)
Message-ID: <0b1d6388-7a7d-6eda-0405-0897aa8255ba@linaro.org>
Date: Tue, 20 Jun 2023 12:22:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 11/34] target/arm/tcg: Reduce 'helper-vfp.h.inc'
 inclusion
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20230619154302.80350-1-philmd@linaro.org>
 <20230619154302.80350-12-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230619154302.80350-12-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x529.google.com
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

On 6/19/23 17:42, Philippe Mathieu-Daudé wrote:
> Instead of including helper-vfp.h.inc via helper.h which
> is included by all TCG files, restrict it to the few files
> that require it.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/arm/helper.h               | 1 -
>   target/arm/tcg/mve_helper.c       | 4 ++++
>   target/arm/tcg/sve_helper.c       | 3 +++
>   target/arm/tcg/translate-a64.c    | 4 ++++
>   target/arm/tcg/translate-m-nocp.c | 5 +++++
>   target/arm/tcg/translate-neon.c   | 4 ++++
>   target/arm/tcg/translate-vfp.c    | 6 ++++++
>   target/arm/tcg/vec_helper.c       | 4 ++++
>   target/arm/vfp_helper.c           | 5 ++++-
>   9 files changed, 34 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

