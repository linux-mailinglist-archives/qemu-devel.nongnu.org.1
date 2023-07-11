Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B81EA74E9C9
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 11:03:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJ9Gq-0005Rs-N3; Tue, 11 Jul 2023 05:02:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qJ9Gf-0005Rh-UQ
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 05:02:45 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qJ9Ge-0001FO-4Y
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 05:02:45 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3fbc656873eso67814505e9.1
 for <qemu-devel@nongnu.org>; Tue, 11 Jul 2023 02:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689066161; x=1691658161;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+O3/wEqkLklEEqlF0ZGIFQwFiiKUZGb+YriXJ8Gy0aU=;
 b=sD8WRVk+L2ehb1A2d0IhAsohYEnNav9PT3sIZWnT+5uNJ64TsZqDp0ZjSSMPDp58gs
 ej5+XTnPiWgz5T5ASyrydodT+Gz0WXPmXgyQ/sTKyBEEfivEfg8phJMmGnb5Tpp9XYsn
 s3PjRd3EhqhwZDeNECzQq4CnvrhcyCBLyWBnKWbsq5aSUSDnZMu7DEmfDYAFQAtEOgc5
 oBnb0aPnSys0hXSz0CYwOj+K60y+wTU5rDxsq+6TgTnbs28IYtuL0KEaZ7doUN6MoNFt
 Vc0I1TO7EeB9V9ZF4w1N9lwpeNerCdkxUl+TLHNU4Z2+FBHuPV8dLiIZxwnuMT2ATIzW
 MW4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689066161; x=1691658161;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+O3/wEqkLklEEqlF0ZGIFQwFiiKUZGb+YriXJ8Gy0aU=;
 b=R9O21iATPq1rBeIvP+SErrZZEWj4XsrfIoF1KknLVKTZERHaoYDMAKjdEom1kgnN0X
 OZ5zeglOBV9JehSJZCd58oBe6+JMoE2DImGr7lyAZhsGl3nsAEDy1hfcGT1IZNnQ/Krz
 AhLYL4OyBcyQ8p3jmv9DSECc38/SJ+4SHlvoE4BWL+0THPwiE4PBfraCCIBlC2MS3HOw
 eVgt553LPvxNQGrD968aehnHSeicJyRwhCyxVCjVPWs1BuJy+3T96eTrKZsss/82M78I
 14prI5TcrXXqwXlog9/cqBw9Nh2LXm4wm8ctQ4gSn2eikAx71Zp1EOqos+v11Ot15S7O
 MBcA==
X-Gm-Message-State: ABy/qLZJv4K+4YK8Mm3i/qCJMrRyhdtELBKFKkmGlu751Wy761U6q4S2
 i1ILfANfBxHnaqyYIS8zlCmw7dAr1J29vEdzkL7i2A==
X-Google-Smtp-Source: APBJJlHJtUxGT9vZ1bAQ11UYMYBokRCbuqBhvebyd6oHYros6t6DAcq5jP5P8PSERdn/Xu365nh8HQ==
X-Received: by 2002:a5d:4cc5:0:b0:314:7fb:92c2 with SMTP id
 c5-20020a5d4cc5000000b0031407fb92c2mr18413631wrt.30.1689066161158; 
 Tue, 11 Jul 2023 02:02:41 -0700 (PDT)
Received: from [192.168.69.115] (mst45-h01-176-184-47-225.dsl.sta.abo.bbox.fr.
 [176.184.47.225]) by smtp.gmail.com with ESMTPSA id
 u2-20020a5d4682000000b00313e2abfb8dsm1668731wrq.92.2023.07.11.02.02.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Jul 2023 02:02:40 -0700 (PDT)
Message-ID: <45565778-bab4-36dc-bd97-e7fdd13b3b9c@linaro.org>
Date: Tue, 11 Jul 2023 11:02:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [hotfix PATCH-for-8.1] meson: Fix cross-building for RISCV host
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20230711085409.53309-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230711085409.53309-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.101,
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

On 11/7/23 10:54, Philippe Mathieu-Daudé wrote:
> While when building on native Linux the host architecture
> is reported as "riscv32" or "riscv64", when cross-compiling
> it is detected as "riscv". Meson handles the cross-detection
> but displays a warning:
> 
>    WARNING: Unknown CPU family riscv, please report this at https://github.com/mesonbuild/meson/issues/new
> 
> Commit 278c1bcef5 was tested on native host but not under
> cross environment, and now we get there [*]:

Richard, if this works for you, please scratch this " [*]",
I meant to list 
"https://gitlab.com/qemu-project/qemu/-/jobs/4627545569#L128" but then 
realized this link will
expire in few days so be irrelevant in the commit desc.

> 
>    ../meson.build:684:6: ERROR: Problem encountered: Unsupported CPU riscv, try --enable-tcg-interpreter
> 
> Instead of:
> 
>    Found pkg-config: /usr/bin/riscv64-linux-gnu-pkg-config (1.8.1)
> 
> As a kludge, re-introduce "riscv" in the supported_cpus[] array.
> 
> Fixes: 278c1bcef5 ("target/riscv: Only unify 'riscv32/64' -> 'riscv' for host cpu in meson")
> Reported-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   meson.build | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

