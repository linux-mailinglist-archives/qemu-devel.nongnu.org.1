Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A37757B5D
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 14:07:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLjSK-00070a-5G; Tue, 18 Jul 2023 08:05:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qLjS0-000709-Bm
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 08:05:09 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qLjRv-0001JE-WC
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 08:05:07 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3141c3a7547so5251928f8f.2
 for <qemu-devel@nongnu.org>; Tue, 18 Jul 2023 05:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689681902; x=1692273902;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8K72sj1DTeAv7k9Ctg+LY+T6Wev0rYbapBcQ1+LBjhk=;
 b=OU5GTDd8Z24J4hQKirlsAEmHYDl2tJNtaymkyw7zhrpIK8YcuVDd/dk+c1ptO5dCeY
 J+pz5xgRBJVg3AoTjpO/FpFEXnVet5NDeq5e7wpRuGjGwmRs93aoBINWLMmF80OAW7vs
 4bX5Kz8hhp6bhRdso6TrO/wR+9H9zM5bWEJJY6/WZkITGIlX2gTiLf4JQg/TzCC8acV0
 9drhI5yvBR4s8bZvIUwAFixbJz5bU0W5zxpK2nv8MePCp762m9un/DDAv5L4Fui7EIXV
 CKDnoO08Zs0PA3mU/wISDAunmblVu1MNQjmbSy8OZpUDv8NwqsNUBAJtjb3cZ/rSKqCB
 1cXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689681902; x=1692273902;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8K72sj1DTeAv7k9Ctg+LY+T6Wev0rYbapBcQ1+LBjhk=;
 b=GTSjaTwlNtlmNcyRVHpS+mPymkLSveKAhURel3hb5BP/hZMAtS8cwhAqWgfaGAl5gr
 AHbY2+ddTUM33TH9r2O7e4NuRE2LOMBGrHQRQ0AfhmkBhIGjfm7hOnbUfCQ1vHRbqV1N
 gFh21oQFKrf1dufeOHuwUgeratKXYbv7n2wGz10033B3CzM+IKEoxIxGlOijVTOiVbUf
 i4/taKpi+n0VVcVIw3NQcifbVXVj3ESdneoXZp1BhbXQ7ciyOHy+0gf6yFV3BPSeAQuz
 XiJ0RTa8zRLwXRB4eDUauhrnDni3tpDCpV6jArxiAt4Pg5fzjl/rbiztxbCzUUnYHy+m
 9Bow==
X-Gm-Message-State: ABy/qLa3OQJEGEcFzAaAEfn7HUFrs6u/bfsb8tiLf6gtWYQ7mtPh5oDg
 yxK324SqTAtXaywu69YuGFsKQA==
X-Google-Smtp-Source: APBJJlGH+2ngTlLcHZC8Y2+gofGxgXH0LV8dzSjS65FY2HeTg0vLydch0g11tdjUwtnOz6bldK4B0w==
X-Received: by 2002:adf:f583:0:b0:314:4ac3:530c with SMTP id
 f3-20020adff583000000b003144ac3530cmr10180980wro.7.1689681902173; 
 Tue, 18 Jul 2023 05:05:02 -0700 (PDT)
Received: from [192.168.94.175] (140.red-95-127-46.staticip.rima-tde.net.
 [95.127.46.140]) by smtp.gmail.com with ESMTPSA id
 s18-20020a5d4ed2000000b003143853590csm2222225wrv.104.2023.07.18.05.05.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Jul 2023 05:05:01 -0700 (PDT)
Message-ID: <18b9ca41-c901-ac61-c959-5d8c36341a7f@linaro.org>
Date: Tue, 18 Jul 2023 14:05:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH] target/arm/tcg: Don't build AArch64 decodetree files for
 qemu-system-arm
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20230718104628.1137734-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230718104628.1137734-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.095,
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

On 18/7/23 12:46, Peter Maydell wrote:
> Currently we list all the Arm decodetree files together and add them
> unconditionally to arm_ss.  This means we build them for both
> qemu-system-aarch64 and qemu-system-arm.  However, some of them are
> AArch64-specific, so there is no need to build them for
> qemu-system-arm.  (Meson is smart enough to notice that the generated
> .c.inc file is not used by any objects that go into qemu-system-arm,
> so we only unnecessarily run decodetree, not anything more
> heavyweight like a recompile or relink, but it's still unnecessary
> work.)
> 
> Split gen into gen_a32 and gen_a64, and only add gen_a64 for
> TARGET_AARCH64 compiles.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/tcg/meson.build | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


