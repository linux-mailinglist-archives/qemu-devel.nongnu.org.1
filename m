Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4977979FBD4
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 08:22:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgfk7-0006So-TF; Thu, 14 Sep 2023 02:22:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgfk5-0006SX-Uv
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 02:22:21 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgfk4-0001jP-6g
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 02:22:21 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-9ad8a33fd0dso72653066b.3
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 23:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694672537; x=1695277337; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hP01JpjVhAghEymlQp5fC7eYgVrV/Ngb7ZY8IMC2q4k=;
 b=uGaBSYChGS4hfIfT9il25elqlNVyjcetHva9qX6JZjMpn75ZVCOfjA9tS03wSTY74F
 wzTB/rkeqCZLjccNQx42ULR6nYwSKFZPcVcumhvBKuDXlbgv8xdplhS8cXQIirL+Iu/M
 oRGZAb2HNsYytIAYlnWkfJz91ZJuV5VPjZPUXPQASPXYR7XyUupPGdA2FDL4UziCqWvl
 dE97Z5g7LPBMJ1Lhl/HKr8Mnr/IPAg+v76gdqg2q+g7UPknAH4I1+XFt5LRqJ+T6aYWo
 IVLzpi+VxmFKp3uVfOP7fZ2OChmzCt04CEqVPZeJtUxWuw5aJiE0Cniu5x2tXc6t/B7l
 BIBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694672537; x=1695277337;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hP01JpjVhAghEymlQp5fC7eYgVrV/Ngb7ZY8IMC2q4k=;
 b=fbBdAhVAZhYYQZMHw5L8MzkK9UwDUMLdO8D+0WbzbapGafQ4UyWiG86sSxaDNZTznv
 yNdcmpfTncBZWk9wrxGSOJxPkhYDyfk3q8GbVn0n63vlDZRj4jB7Sy/RNiMjWCssM5ip
 0Nk5SKk9PfA1sC7oMhBU9RxIFgHuAO0LGKOOwpyF4BZuHTK9vSSWzq7zLfQpz3+UU1Ji
 TScTXbzjt1Bo/c7OazhRWCdWWRPH0E0DmFKbRlQxXTvE0zPplnTJT8gzGBThUaX5IEpu
 DHRbO0eCg+KLp61KpeuGDvGS5pp39w9tur0REsJoGufOcGln7HLzVq4A/bpOMM5hGYiY
 jNbg==
X-Gm-Message-State: AOJu0Yyk/usJKuW19T3vINMPYOuhaAMM01nR/JlqCZz3vP7P9MT/8pIi
 gpxNUfqn3HP0iB99F66qiC+Meg==
X-Google-Smtp-Source: AGHT+IGI7ghFph0XoqEwcnit7jkOGvEjrmpaL8dm7HU2SHTLIZALvFnmDQUFSRYgF6odt7bm3vNyLw==
X-Received: by 2002:a17:907:2cc9:b0:9a5:b8c1:2ce1 with SMTP id
 hg9-20020a1709072cc900b009a5b8c12ce1mr3289390ejc.31.1694672537599; 
 Wed, 13 Sep 2023 23:22:17 -0700 (PDT)
Received: from [192.168.69.115] (sem44-h01-176-172-56-29.dsl.sta.abo.bbox.fr.
 [176.172.56.29]) by smtp.gmail.com with ESMTPSA id
 gg23-20020a170906e29700b0099364d9f0e6sm507880ejb.117.2023.09.13.23.22.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Sep 2023 23:22:17 -0700 (PDT)
Message-ID: <ba8e2a44-710f-dc02-e571-1c36e8634332@linaro.org>
Date: Thu, 14 Sep 2023 08:22:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v2 21/24] accel/tcg: Use CPUState in atomicity helpers
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: anjo@rev.ng, ale@rev.ng
References: <20230914024435.1381329-1-richard.henderson@linaro.org>
 <20230914024435.1381329-22-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230914024435.1381329-22-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x634.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 14/9/23 04:44, Richard Henderson wrote:
> From: Anton Johansson <anjo@rev.ng>
> 
> Makes ldst_atomicity.c.inc almost target-independent, with the exception
> of TARGET_PAGE_MASK, which will be addressed in a future patch.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> Message-Id: <20230912153428.17816-8-anjo@rev.ng>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/cputlb.c             | 20 ++++----
>   accel/tcg/user-exec.c          | 16 +++----
>   accel/tcg/ldst_atomicity.c.inc | 88 +++++++++++++++++-----------------
>   3 files changed, 62 insertions(+), 62 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


