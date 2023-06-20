Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C436736932
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 12:25:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBYXO-0000pa-A0; Tue, 20 Jun 2023 06:24:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBYXL-0000on-Q2
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 06:24:35 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBYXK-0000bw-93
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 06:24:35 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-51a20c744ebso5311767a12.1
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 03:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687256673; x=1689848673;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iVYJ2VqMyIE4bNm2xHt6WeLaX6F02wLUlKxzdVquiuk=;
 b=fjcpGJE0O14qMTmT7SgTHrepugkxyky49/5GC+ACUqhRMdUIdfxzz9kylHaWOOCvCh
 QboE3WTzyjCzWenK7LTKIF4LwdTc4pAYzh3frD1HFVSDVRoBTwCK3lHCeVKG9iHjMkFv
 MK/Tk8218kQFlvQ60Q74Ri6yfKjnQrvyzLmbHGd+FVuUTwLkT1yD0rsXRSxr0Lgh1UCQ
 OOa+psXJ0432AZmig4HZvhFTrf0535H238MmBuTNmBiCblpxDrM7U3FoZ9uAIHt0w7K6
 /Kgj0C2YYn3pS3LVAWgVqSG/NI5SMA64q9TUuPHuh3/sLbouzFL2+lCVV9QibdBNXDTx
 OaNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687256673; x=1689848673;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iVYJ2VqMyIE4bNm2xHt6WeLaX6F02wLUlKxzdVquiuk=;
 b=OIthlBmIH0iz4z/Cjt7j6gfbbTzSQge6rWoKoD6zC7lMH6LdsNnYigG66g5WRXBK7E
 bqEGZEHLZlfD9o7TM6mtp7AsvM+gDZUGPgqTnvpTPNVF2NmtoxA0kSanOI/qmw/e5859
 PmEQYKdzPuK8Ib0XArOr3h8kXsCiIlm8wKbAIwSXjI//9Wi/Cmxj1jzEvjwnQ4lJ8UdD
 oKxdKP7NVEyiunNmq9mdWQrgkf0r2oaTbvxT9DtgPNAbaPr5fGXT17aZNCQtdXjqukhu
 rWqajlTlc6rvhtoTfL/lD6pkDz4n43kn5f/IsSAjYuZCvSKj+SD8vsYEOqKKP/Gx1x+A
 J1xQ==
X-Gm-Message-State: AC+VfDy71WlI9wNjkyk/KZF5ZGSf2EEQcNs+FMvHJWMSBy/Zvb9PoWwv
 hHa0UFK6lSPHuJJ3F6vqFMrXgzXxKK1UNytOHQmIy4+s
X-Google-Smtp-Source: ACHHUZ6B/F8iOWLfloivO0i/rxJGAOA3DGUu6CvxWi+qqlUAhibsf5ffEpJKDHESVMy/W6a1/TBnlw==
X-Received: by 2002:aa7:d5d5:0:b0:518:6a17:98b3 with SMTP id
 d21-20020aa7d5d5000000b005186a1798b3mr8930623eds.10.1687256672790; 
 Tue, 20 Jun 2023 03:24:32 -0700 (PDT)
Received: from [192.168.69.129] ([176.176.183.29])
 by smtp.gmail.com with ESMTPSA id
 r16-20020a056402035000b0051a2d2f82fdsm959594edw.6.2023.06.20.03.24.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jun 2023 03:24:32 -0700 (PDT)
Message-ID: <f50b8017-5f4b-5f8d-2604-ed8a4c3a09df@linaro.org>
Date: Tue, 20 Jun 2023 12:24:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 14/34] target/arm/tcg: Reduce 'helper-neon.h.inc'
 inclusion
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20230619154302.80350-1-philmd@linaro.org>
 <20230619155510.80991-1-philmd@linaro.org>
 <20230619155510.80991-2-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230619155510.80991-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x531.google.com
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

On 6/19/23 17:54, Philippe Mathieu-Daudé wrote:
> Instead of including helper-neon.h.inc via helper.h which
> is included by all TCG files, restrict it to the few files
> that require it.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/arm/helper.h             | 1 -
>   target/arm/tcg/neon_helper.c    | 5 ++++-
>   target/arm/tcg/translate-a64.c  | 4 ++++
>   target/arm/tcg/translate-neon.c | 6 ++++++
>   target/arm/tcg/translate-sme.c  | 4 ++++
>   target/arm/tcg/translate.c      | 4 ++++
>   target/arm/tcg/vec_helper.c     | 4 ++++
>   7 files changed, 26 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

