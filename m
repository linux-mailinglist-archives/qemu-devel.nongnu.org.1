Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CEB07FC102
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 19:08:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r82Ug-000421-Vt; Tue, 28 Nov 2023 13:07:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r82Ue-0003qb-0T
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 13:07:32 -0500
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r82Uc-0000Tp-BS
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 13:07:31 -0500
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2c59a4dd14cso66300261fa.2
 for <qemu-devel@nongnu.org>; Tue, 28 Nov 2023 10:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701194848; x=1701799648; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lFGN14zvp60qAt3NInvly2tP8Yf34w7cJxhjep4yuTo=;
 b=KxRrmr8d0Mds7XCvuZi3drQHuSoNvIC6i1H/DZFKPGK/Nv91aMncyXggrKvSXAUjkj
 jNdD6adRGHnHT52SLLg6CF6fvGMW5rnneSW6Dd1OdGPmrD/uwnkt05PmvMm5p270Kq3j
 yeP1aMC7qy3i1+OSn2t6SAaZrBwWCh33YPEXcadse+p5XDFDxNnUh59D0T01sL1frkW8
 V+vR/kqSIwcQvcaMpSdnMwmiyggWccM1BmMU2F3yhp42HMA+lEx4+HKsnWUzuX080GOQ
 V5Z3HCpCnjTs6VdGG5XSm73+i1neHJjl+CD1o+YakPsdknSJcV/jhtVOKfb2KIr/Z628
 Q5PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701194848; x=1701799648;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lFGN14zvp60qAt3NInvly2tP8Yf34w7cJxhjep4yuTo=;
 b=UC1QOStDePW+Q1ilkyyVfXFila0iXpyBcUTu6R3UoJB9RVLiOLRZNHpqtWRwkj+fV8
 VGCKSRKjf26GStRWC+k59MxvFknKddGBxGD/Xl4mQ9Kwlos/tkv2OfKfkRNc3G++ng3D
 6q/w4BBgxcSXtKJ/ouMPmRKMl9ZzIu7K5V/uLqXPKYXfyXt8PEI7ERLNh+t2sXhKXFYG
 cEcRmC2+ySM1a+de7wiN4U8x5vft85VNc9D/gHwDaY/icmVLUXecbmc3S//U06AzILOA
 gIbSCtqUFdStf/wJOhuy2tZGWWL3aY+lYgzqjo6Zd9+I/cpboqXE7LXVmbaOnRTsO5UX
 jI7Q==
X-Gm-Message-State: AOJu0Yw9tb3e0FCjyJMmhE+37qiY147WOxJpxF4EsHuu8kWD3ptX/Z44
 fW0VEucHsTD/Rq5A3RDaCexMog==
X-Google-Smtp-Source: AGHT+IH2eY5Uc7bh0yNCWV+ofgHFyFFjx+VuN5v0tdMwLqIDIRj7KeG7ri5MwjqHHMmEJS4vkeiwoQ==
X-Received: by 2002:a2e:541c:0:b0:2c9:a22b:dff5 with SMTP id
 i28-20020a2e541c000000b002c9a22bdff5mr5468075ljb.22.1701194847729; 
 Tue, 28 Nov 2023 10:07:27 -0800 (PST)
Received: from [192.168.174.227] ([91.223.100.55])
 by smtp.gmail.com with ESMTPSA id
 a27-20020a2ebe9b000000b002bcdbfe36a1sm1760596ljr.84.2023.11.28.10.07.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Nov 2023 10:07:27 -0800 (PST)
Message-ID: <fd6f4fa5-8122-4ac3-87c1-0521baefdf4d@linaro.org>
Date: Tue, 28 Nov 2023 12:07:10 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] target/arm: Add support for DC CVAP & DC CVADP ins
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, quintela@redhat.com, dgilbert@redhat.com,
 shameerali.kolothum.thodi@huawei.com, eric.auger@redhat.com,
 qemu-arm@nongnu.org, pbonzini@redhat.com
References: <20191105234100.22052-1-beata.michalska@linaro.org>
 <20191105234100.22052-5-beata.michalska@linaro.org>
 <95cc7c22-939f-4ce0-aecd-d0ff7b0e7c9c@linaro.org>
 <CAFEAcA-G7hbnRv52btWkpDs-1rgFqyVGgRVx-hG40i7zgsykaQ@mail.gmail.com>
 <2830159e-3d6d-430b-aed7-43b1b4fce56e@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <2830159e-3d6d-430b-aed7-43b1b4fce56e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x22a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 11/28/23 05:44, Philippe Mathieu-Daudé wrote:
> Thank you Peter. In this case I'm compiling HVF, but this is the
> same reasoning. I'll add #ifdef'ry similar to ats_write() (commit
> 9fb005b02d "target/arm: Restrict the Address Translate write operation
> to TCG accel"):
> 
> -- >8 --
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 99c7da9ca4..a05e613e10 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -7629,6 +7629,7 @@ static const ARMCPRegInfo rndr_reginfo[] = {
>   static void dccvap_writefn(CPUARMState *env, const ARMCPRegInfo *opaque,
>                             uint64_t value)
>   {
> +#ifdef CONFIG_TCG
>       ARMCPU *cpu = env_archcpu(env);
>       /* CTR_EL0 System register -> DminLine, bits [19:16] */
>       uint64_t dline_size = 4 << ((cpu->ctr >> 16) & 0xF);
> @@ -7653,6 +7654,10 @@ static void dccvap_writefn(CPUARMState *env, const ARMCPRegInfo 
> *opaque,
>           }
>   #endif /*CONFIG_USER_ONLY*/
>       }
> +#else
> +    /* Handled by hardware accelerator. */
> +    g_assert_not_reached();
> +#endif /* CONFIG_TCG */
>   }

Yep.

r~


