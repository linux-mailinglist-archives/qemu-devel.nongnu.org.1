Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F6472F3CC
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 06:53:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9IUz-0004aQ-2W; Wed, 14 Jun 2023 00:52:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q9IUx-0004Zh-0a
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 00:52:47 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q9IUv-00055E-An
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 00:52:46 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3f8d176396bso2016215e9.2
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 21:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686718363; x=1689310363;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MtrpCegBwZK90b7OkPnODh2IkxezOYP4vr9cegDFRxs=;
 b=GYfxWp9fMWgEPI196ws9hVF9lxSXz/zKFanM1kU65gY3GSIuT99EDzxh+4dhdhmhXA
 y9fQ5M6NPPtxaao0Dc7J4/WzFkNKYlSY1IEwF/36xCo9cjEtQzL7FzQ1erEcYJl4lA5Z
 KIaZhU4eg+8rVjld2EcRIaAVwOs2xA9RYRP3dOxuDhUUlq+AVg56iIjy3MUOQc7PO8tJ
 cHDFw+TsBdxIk0b86SWw9zVVLySqkcTjoB3BNOYKseKMdOyP8b34znzNnez5p0zKGofI
 cJ0rxYduASRdxW3uFoR9bAK91E/OuQwx32ntrucGnwx9xis5Gb/fOWZFz6BxzuUUAS57
 /pWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686718363; x=1689310363;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MtrpCegBwZK90b7OkPnODh2IkxezOYP4vr9cegDFRxs=;
 b=CsckHndyBjCgGg+F0EQw7KaqaBZ2OCvpqrCXyAgYFWgrBQ7beCoICWWBWoiTvOB3vH
 ZzcW3nkdipStP+XPvo52ffVcjVAdKfNHQ2lmzlpLG+0Ce95dfGvpPcHKRzlITMEO8U+k
 0LvdS6hQWUM+OuUnmdHXq7WBzPrbAvrthJXFfTwrPXqnKpJXHHaIhtD17rNTmARjS1aJ
 5b1FcVh6TIgxar7j6UucQrNDlq/FRw1nzxbgfnk+X+TqGqk+uOD8RrMrUe+Pxe9JEuUH
 VB+VRlcPtSpoOXKhWRptLeqP9qylAY4qFVD16YPkOFZAJZYJ7lCTafjIC2N+JTIxA+8y
 l0wg==
X-Gm-Message-State: AC+VfDy1oRMhVHQ6H+pZbp2xsbDvyaWVahZRPBhoxIHUWVm9wBxYykkN
 8cMALm/PxYKfpt8XplYfVF1qVw==
X-Google-Smtp-Source: ACHHUZ4oQ8s0AutZdGNSJHZvnswINJ6N0D3Us9/m7aQTYCh4d4JzPAMwdqsayjyqIU28Y0hPxuWwbA==
X-Received: by 2002:a05:600c:228d:b0:3f7:8fbf:a21d with SMTP id
 13-20020a05600c228d00b003f78fbfa21dmr9705027wmf.32.1686718363603; 
 Tue, 13 Jun 2023 21:52:43 -0700 (PDT)
Received: from [192.168.4.112] (90-182-62-66.rcp.o2.cz. [90.182.62.66])
 by smtp.gmail.com with ESMTPSA id
 q11-20020a056000136b00b002f9e04459desm16843788wrz.109.2023.06.13.21.52.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Jun 2023 21:52:43 -0700 (PDT)
Message-ID: <60f532b5-a6f5-21a6-93b2-d063d1a9b663@linaro.org>
Date: Wed, 14 Jun 2023 06:52:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 19/26] target/arm/tcg: Reduce 'helper-a64.h.inc'
 inclusion
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20230611085846.21415-1-philmd@linaro.org>
 <20230611085846.21415-20-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230611085846.21415-20-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.098,
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

On 6/11/23 10:58, Philippe Mathieu-Daudé wrote:
> Instead of including helper-a64.h.inc via helper.h which
> is included by all TCG files, restrict it to the few files
> that require it.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/arm/helper.h            | 4 ----
>   target/arm/tcg/helper-a64.c    | 4 ++++
>   target/arm/tcg/mte_helper.c    | 4 +++-
>   target/arm/tcg/pauth_helper.c  | 4 +++-
>   target/arm/tcg/sve_helper.c    | 5 ++++-
>   target/arm/tcg/translate-a64.c | 6 ++++++
>   target/arm/tcg/vec_helper.c    | 4 ++++
>   7 files changed, 24 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

