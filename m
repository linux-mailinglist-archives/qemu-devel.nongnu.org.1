Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DB44D7764BE
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 18:11:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTllu-0004nE-QM; Wed, 09 Aug 2023 12:10:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTlls-0004mm-9m
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 12:10:52 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTllq-0002BK-Pt
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 12:10:52 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1bc0d39b52cso214045ad.2
 for <qemu-devel@nongnu.org>; Wed, 09 Aug 2023 09:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691597449; x=1692202249;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=v07HobsrW78DX5f7W8oL61kDbknec09rpztRlRfCd2o=;
 b=ebS/jcLOZaSNMyoD7uYoAN3tF1T7Js7hE54WeBUts0kADvO7k8LCcz8F5nxnTrP13D
 XQFqSueidEMRu8OqS+XwUpV7M/Ws0fDggQArhk1IQv/Dsc17uLrfOOvBXbaoVlrUL20T
 mYLsKtqNlz86JD6IZME14P418FWHGH/DcHfhRxakYH2IbOsFJazC6nk2rb61Nyp3j4vc
 Fin11B+2qMky0hI0XoSljIFFYzDeKkk2DgzedU9eYeiobdiT7UrtrEMGl3L+X9pIq30i
 SDmLKRc17LawZx6y5BAqgS6CZP1f3HpNJNLevq2NxPEwk1h/m1lTitoy0gqOzZo/+T0/
 9yoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691597449; x=1692202249;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=v07HobsrW78DX5f7W8oL61kDbknec09rpztRlRfCd2o=;
 b=JHnfFycwf1zhpHb9+hkuGMeLSOQ+Mx3hjSVZ7FP7pzSCnWAqC5pWUe6OW8dyCh5r6P
 +YNPOG0nWAsMfeUDEnC7bBDr/oEJ5hZu1Cu0Fda51LN8mANv5McSPAPtLjGmYiYxTqOy
 dVxcXr+IHCoxx5UNheRYSQc8UAebCWniDsEJT+kClJZxozKItu6WQ93es0MgB0E6PHzC
 CdSOCxGHVhRBleqVQ58l2z2ZKhnajiD8LP5LuRCbhCm0Y0UTOkZ9akDjexbKIke0QCWF
 2OfA27N+Rv9kjOBd17nvlDq+fDAzcQ4/zoEix4ylIFrR94aKZpRQYWBOEw7wxQXZuBUU
 Ii2g==
X-Gm-Message-State: AOJu0YwX+DFtp1PRge2aQZog0xFjGWypPC9jXTu8SXOcpLhNqUNIjdEW
 ZM3UBswXR2mkdiNsXEqVf7t2ZA==
X-Google-Smtp-Source: AGHT+IHiKBnxkdChPRzagLnSC87mV4fXvZeaG7ZYy+YMPbQmM3q3xlGaKO24ZJilXECt6ZiNUBJvMA==
X-Received: by 2002:a17:902:da81:b0:1bb:c7c6:3454 with SMTP id
 j1-20020a170902da8100b001bbc7c63454mr3194269plx.48.1691597449027; 
 Wed, 09 Aug 2023 09:10:49 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:6bf0:9674:6ac4:f74c?
 ([2602:47:d483:7301:6bf0:9674:6ac4:f74c])
 by smtp.gmail.com with ESMTPSA id
 w13-20020a170902d3cd00b001b53be3d956sm11354059plb.167.2023.08.09.09.10.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Aug 2023 09:10:48 -0700 (PDT)
Message-ID: <451be3fb-1431-3ae6-241a-51ae1273fbda@linaro.org>
Date: Wed, 9 Aug 2023 09:10:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC v4 02/11] build: Implement libnative library and the build
 machinery for libnative
Content-Language: en-US
To: Yeqi Fu <fufuyqqqqqq@gmail.com>, alex.bennee@linaro.org
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Riku Voipio <riku.voipio@iki.fi>
References: <20230808141739.3110740-1-fufuyqqqqqq@gmail.com>
 <20230808141739.3110740-3-fufuyqqqqqq@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230808141739.3110740-3-fufuyqqqqqq@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
X-Spam_score_int: -61
X-Spam_score: -6.2
X-Spam_bar: ------
X-Spam_report: (-6.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.14,
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

On 8/8/23 07:17, Yeqi Fu wrote:
> +#if defined(i386) || defined(x86_64)
> +/*
> + * An unused instruction is utilized to mark a native call.
> + */
> +#define __CALL_EXPR ".byte 0x0f, 0xff;"
> +#endif

This is 2 of the 3 (or more) bytes of the UD0 instruction.
At minimum you should include a third byte for the modrm.

For example,

	0F FF C0	ud0	%eax, %eax

If you want to encode more data, or simply magic numbers, you can use

	0F FF 80
	78 56 34 12	ud0	0x12345678(%eax), %eax

or with modrm + sib bytes,

	0F FF 84 00
	78 56 34 12	ud0	0x12345678(%eax, %eax, 0), %eax

So you have up to 32 (displacement) + 3 * 3 (registers) + 2 (shift) = 43 bits that you can 
vary while staying within the encoding of UD0.

You can even have the assembler help encode a displacement to associated data:

	.text
0:	ud0	label-0b(%eax), %eax
	.rodata
label:	.byte	some stuff


r~

