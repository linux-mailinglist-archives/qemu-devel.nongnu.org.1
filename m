Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 720799B424A
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Oct 2024 07:18:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5fS7-0002A1-O2; Tue, 29 Oct 2024 02:11:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t5fRg-0001l6-Fr
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 02:11:13 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t5fRf-0007Iz-4E
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 02:11:12 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43155afca99so41282315e9.1
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2024 23:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730182270; x=1730787070; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ni+wtJb/H/ha3fv3BexxavA0siKsZDnpq8q6IPWdmn8=;
 b=u1739Dz20brF3NeVBnORfUSCABTWNS7Tm4XsKKDOVhpaPdtmsfwomEuOKbyv1vNDcX
 TH+Laz4dOnZsu0coOpJEZEVvzsS67tQ6t71KvaV3EYP9txJQdrPm6rc99tBB4oPLtdUr
 LHvzAWsPS+D50alhoT57wuC4pF9ywn3YjQltCOtgtQ6HhtxDjeXvBmvSlcyAaop9wnzR
 JZhbtrcrXEBChE67rI7fmvLyPsg9FLjNByrJ2PstBtEFJiLd6xhXDWI5yb1DYGXc2n1F
 KZuox1SylR7AKxV9Y6T0MIxGwrjN4jhdDQ/p85m9U1Na3+TZOo0KOruXMy3T0dqS0/wE
 oEWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730182270; x=1730787070;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ni+wtJb/H/ha3fv3BexxavA0siKsZDnpq8q6IPWdmn8=;
 b=WXgkLmX88VRnqjXPS6v7r1oop1Jl6IwmG3d6pxS4vAUmtVKZKOK+m8YASNXJGcjZZM
 88FP2/WNJEhHH1H7075egHA3F/StpY0SvOJkwZ5JsO0GpJ/x+t3NmOQLt1RK9FJeZD7K
 9nwyy59AENzq9CdQ1HwmrzQIn+XKPpDAr6CFRCJthRJ7cGS2VfNasr/IC3weUPOJBIGf
 QQvLYdA5JfGULouGX/rqRcGcsVBOjNQFiAiToCPlz9MFzmHBHg8UWXHYkWEEPr7FwnMl
 +qVk5TyzvoZjPk/u5l9t05oK69td45YR36viuULfE4cgpry66IEq3BHLC6HXH34egsyI
 MLrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUq/rp6/S7FialdGLceUvCKSwbu64ko2fn1G1RITHq16GOHejyrMbH8vqQAN5WvqgqlQGFacMJjuDED@nongnu.org
X-Gm-Message-State: AOJu0YymigkU2rHXDHE/2nORlhsaFaliZIjrDgADMbkOeiJ8+1M8tVHr
 eYL2AyS7At9eyHTFCp0tJXP0gbwDwYyKGuvCk9Vy0PgNzTHZl7qAxvwUoD01KI4=
X-Google-Smtp-Source: AGHT+IHy3gv6qkp+GoU12B7cOXA6z9p6DAaV9/nIpMy+V9ilkfPupaZfPHPppNX2SDlialh2lnsIAg==
X-Received: by 2002:a05:600c:1f84:b0:42c:b697:a62c with SMTP id
 5b1f17b1804b1-431b55e5defmr6282595e9.5.1730182269762; 
 Mon, 28 Oct 2024 23:11:09 -0700 (PDT)
Received: from [192.168.21.227] ([90.197.151.65])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431b45aa058sm12150405e9.1.2024.10.28.23.11.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Oct 2024 23:11:09 -0700 (PDT)
Message-ID: <470da50b-3f49-438f-98fe-d07df8cbfd52@linaro.org>
Date: Mon, 28 Oct 2024 12:25:48 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/21] target/microblaze: Move setting of float rounding
 mode to reset
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Eduardo Habkost <eduardo@habkost.net>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aleksandar Rikalo
 <arikalo@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org
References: <20241025141254.2141506-1-peter.maydell@linaro.org>
 <20241025141254.2141506-18-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241025141254.2141506-18-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 10/25/24 15:12, Peter Maydell wrote:
> Although the floating point rounding mode for Microblaze is always
> nearest-even, we cannot set it just once in the CPU initfn.  This is
> because env->fp_status is in the part of the CPU state struct that is
> zeroed on reset.
> 
> Move the call to set_float_rounding_mode() into the reset fn.
> 
> (This had no guest-visible effects because it happens that the
> float_round_nearest_even enum value is 0, so when the struct was
> zeroed it didn't corrupt the setting.)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/microblaze/cpu.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

