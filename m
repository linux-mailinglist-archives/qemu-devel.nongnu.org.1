Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C34187223C1
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 12:46:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q67ie-00069W-N8; Mon, 05 Jun 2023 06:45:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q67iK-000689-11
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 06:45:29 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q67iD-0007Qm-BA
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 06:45:27 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-30af86a96b4so3809949f8f.3
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 03:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685961919; x=1688553919;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BER6FqqlFlZwhQ7mFkNQkzoTv/vcZa2WEIOpCzfl/JQ=;
 b=V3rs/o6yTzmLRK2uwI34TyVWX5Fjx2ZGiA4Um7ms/5i+MbEAnOoptm611exvFfnOnl
 +8GatZtt0xp5GWlbNEB+af+T8x1AOtnLY6nJUbdpzSgyD35ejcyqw2QjLskCU/PV2rhm
 8yY0k2Nv9M1NS6vj7AunhQRs4RXxLbSKCGi/O+Yjsdxl5UvnQ2Ds8SpAAC76o7TmC9zG
 QudGEUTnzImqYJKDyKiKNP4r8pBtz91TGYWDF66HkR1poAJxGy9nOQ62ZbTvmJ+2xqMS
 BaO2lBIonfDbjtN0mTzIC3MdS7sbNyk6zh51jrU5WuxXriUDf4AdX8kBxPBkYVNBrk4I
 exjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685961919; x=1688553919;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BER6FqqlFlZwhQ7mFkNQkzoTv/vcZa2WEIOpCzfl/JQ=;
 b=DhWmClq6t4cVC7oZZJSmMgtvT10Ero8CEhj8m3fthNBe0UEndwH0b+N1GrCANY559p
 +MLxRNe5VFksTVKkGa6cd1Y2xNFQLicWI5yK/X9fpa3z/bKU5UxGsbGbwQPFzfsfmI/U
 aFTcpqxlkW4EEb8Nl6mJws6rO9hH4BLihSXZTWECienJMXwuxrwe44yJUkCp8ZnGUfot
 cEv4HQ4DPqprdcVxsL5EKW02jU0vtM2M+BJJNGdVWQ5h/JLBQ/QNbZM4T8tnxPGdnRiE
 yAW7n9+vsvadEQ5HToAfuwviyTlEcVc7Y3tVzajYalVroP6oXfhDbarwig71Y0NQWXW6
 nfsQ==
X-Gm-Message-State: AC+VfDxFPEfDs6CM1H0H6Z46yGhbsWOLVIZCBlj/KtQKcXFwWAnJsmIP
 hexmuE2I07jDWfczpyRjzc0UZw==
X-Google-Smtp-Source: ACHHUZ55zG0xJgZiV+1At/NT6D0gcUMWVZDoALVJcUWyLm48SBBILP0VKXONa5gqiHZNRZXBOhW8ZA==
X-Received: by 2002:a5d:52ca:0:b0:309:398d:3396 with SMTP id
 r10-20020a5d52ca000000b00309398d3396mr4430944wrv.33.1685961919363; 
 Mon, 05 Jun 2023 03:45:19 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.217.157])
 by smtp.gmail.com with ESMTPSA id
 w3-20020a5d6083000000b0030abe7c36b1sm9314720wrt.93.2023.06.05.03.45.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jun 2023 03:45:18 -0700 (PDT)
Message-ID: <bc89ede2-747f-c56e-5cca-e09289fb72f2@linaro.org>
Date: Mon, 5 Jun 2023 12:45:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH 02/35] target/arm: Move aesmc and aesimc tables to
 crypto/aes.c
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: ardb@kernel.org, berrange@redhat.com, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, pbonzini@redhat.com
References: <20230603023426.1064431-1-richard.henderson@linaro.org>
 <20230603023426.1064431-3-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230603023426.1064431-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 3/6/23 04:33, Richard Henderson wrote:
> We do not currently have a table in crypto/ for
> just MixColumns.  Move both tables for consistency.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/crypto/aes.h           |   6 ++
>   crypto/aes.c                   | 142 ++++++++++++++++++++++++++++++++
>   target/arm/tcg/crypto_helper.c | 143 ++-------------------------------
>   3 files changed, 153 insertions(+), 138 deletions(-)


>       union CRYPTO_STATE st = { .l = { rm[0], rm[1] } };
> +    const uint32_t *mc = decrypt ? AES_imc_rot : AES_mc_rot;
>       int i;
>   
>       for (i = 0; i < 16; i += 4) {
>           CR_ST_WORD(st, i >> 2) =
> -            mc[decrypt][CR_ST_BYTE(st, i)] ^
> -            rol32(mc[decrypt][CR_ST_BYTE(st, i + 1)], 8) ^
> -            rol32(mc[decrypt][CR_ST_BYTE(st, i + 2)], 16) ^
> -            rol32(mc[decrypt][CR_ST_BYTE(st, i + 3)], 24);
> +            mc[CR_ST_BYTE(st, i)] ^
> +            rol32(mc[CR_ST_BYTE(st, i + 1)], 8) ^
> +            rol32(mc[CR_ST_BYTE(st, i + 2)], 16) ^
> +            rol32(mc[CR_ST_BYTE(st, i + 3)], 24);

Matter of style, (since you are changing these lines), I find starting
the lines with the ^ operator clearer to review:

             mc[CR_ST_BYTE(st, i)]
             ^ rol32(mc[CR_ST_BYTE(st, i + 1)], 8)
             ^ rol32(mc[CR_ST_BYTE(st, i + 2)], 16)
             ^ rol32(mc[CR_ST_BYTE(st, i + 3)], 24);

Anyhow,
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>       }
>   
>       rd[0] = st.l[0];


