Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9826D753262
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 08:59:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKCkz-0008JW-KF; Fri, 14 Jul 2023 02:58:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qKCkx-0008Ik-2e
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 02:58:23 -0400
Received: from mail-oo1-xc29.google.com ([2607:f8b0:4864:20::c29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qKCku-0000ud-IN
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 02:58:21 -0400
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-55e04a83465so1087425eaf.3
 for <qemu-devel@nongnu.org>; Thu, 13 Jul 2023 23:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689317899; x=1691909899;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QmnCzcmepWJ9jFZ9N1npnKPGO126GU6O8MnKz9oa1P8=;
 b=dOhuEIrvXJMAeMxVhL1z3yCU+zLJQJnqaV0z0j9Z/098oVO6GCIFErpxbeGYlayCTQ
 klprQByUanBzCJ4Rn/RWCtC/WdyFmo4vn+et1/FSF/dCfb+IXl7af6Ap1Kp+Ubpqq+pI
 3cNrUQzdDQ1SaCdCCd4ET0sV74nd9m3RVspHLuzOpISbp4UTnjS66zGjnKbpv7v87JLA
 AupiWwxI9PNsy63VGUjrbxBlcrx2Mc/sgZJlcgpz0gtgTuYbm0tJgm2teSDLUxJMA6AR
 VIjzNg49D/IPWZNZGzg02ALbimV1v6bN/8tfI+XXQZqaylRK1mi5dZJORxN8y5HH+ob5
 TL1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689317899; x=1691909899;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QmnCzcmepWJ9jFZ9N1npnKPGO126GU6O8MnKz9oa1P8=;
 b=SuorVnIb3jdItwWB8WU+pcrgly9ZZvIjYga3Rs44LBju9eWTSq96WnwiX6OjNfM1xU
 mhV2Cp8RqQSxSQo9whdQ/Auo7hp9SP5CsPEaPWDpH5cyQqDVx912vqZjyleCt/I2ge8k
 hUcZrdCzlAyVcoGA8jOw4SOwHe/JLWIG+zvS/hSxAU9M14Z6XMpqawSQFQKC4tS2/FxY
 tNkw8wnqPwOO0nTB41xRfOZ4jnxiikRO8gDzNLuMaAFekNGP1pIiYLzU7zWT/Lsganrw
 MkJieOVkl+I6s0/ZS7oFYZuj+sMm/PN5HYIhk+q1o/YNUqc60ByxDbGlp5GOiTg7WpuD
 F+4w==
X-Gm-Message-State: ABy/qLb2wqbbB5EioSoo9S7dFo5i4XlLEhZeIPkOZAqmxmMoYjxKkl91
 Vw8iHp1BFxFm2mF/v7ItmN7InQ==
X-Google-Smtp-Source: APBJJlH5Foh8SLcvIM95/uxkfGG/nmZef4Qb78O9MuADZ6W4DtPbJpf7m7iOVX54Ntz7jWK96ehbQQ==
X-Received: by 2002:a05:6358:99a8:b0:134:e549:50d6 with SMTP id
 j40-20020a05635899a800b00134e54950d6mr4726592rwb.10.1689317899240; 
 Thu, 13 Jul 2023 23:58:19 -0700 (PDT)
Received: from [192.168.149.227] ([172.58.27.104])
 by smtp.gmail.com with ESMTPSA id
 e23-20020a62aa17000000b00679fef56287sm6666817pff.147.2023.07.13.23.58.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Jul 2023 23:58:18 -0700 (PDT)
Message-ID: <49918fad-56fc-150e-bb9c-bd00dc67df05@linaro.org>
Date: Fri, 14 Jul 2023 07:58:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 06/11] hw/char/pl011: Extract pl011_write_txdata() from
 pl011_write()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Evgeny Iakovlev <eiakovlev@linux.microsoft.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Gavin Shan <gshan@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org
References: <20230710175102.32429-1-philmd@linaro.org>
 <20230710175102.32429-7-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230710175102.32429-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c29;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc29.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.096,
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

On 7/10/23 18:50, Philippe Mathieu-Daudé wrote:
> +static void pl011_write_txdata(PL011State *s, const uint8_t *buf, int length)
> +{
> +    /* ??? Check if transmitter is enabled.  */
> +
> +    /* XXX this blocks entire thread. Rewrite to use
> +     * qemu_chr_fe_write and background I/O callbacks */
> +    qemu_chr_fe_write_all(&s->chr, buf, 1);

Not using length?


> +        pl011_write_txdata(s, (uint8_t *) &value, 1);

Host endianness error.  Copy to local uint8_t first.


r~

