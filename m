Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6577844D0
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 16:56:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYSns-00012T-93; Tue, 22 Aug 2023 10:56:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYSnp-00011W-QU
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 10:56:17 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYSnn-0007BW-NM
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 10:56:17 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1bdb7b0c8afso26603315ad.3
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 07:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692716174; x=1693320974;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GMWWU3jb+Aqy9RcSXkJwR3nMXoyivnNOhp61RgjSA68=;
 b=WjjBD5pyByydhtoYx9QPGPOscVCBYuJeamuVm7mKhoclcyDSDdwdw6l5GaU6gqgWnE
 B3i+sVON2yVNUUazn3/2jZDi+/1ggpD8CfasDmzJmrXShIcCDt061IsXtik9IkbHALF1
 /dxHWLVRpuzBcCdx+k/Y3FJqwXgJ0jSdntyM8rfhKdoe7s8tLL8izWEnBeVPRzjexrH3
 nOozeIAU1TTXzq09XeTwP4UObhZXDQ46aRyUOdjxszL394RX6aMxRy467rR2vHnWEaEf
 KmZolNZQxAmzKaLzYh1xjyyaWt1LnAJelFxlzxweSxLAKfnzNrmSjrW6mENr2EktcF3X
 g1ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692716174; x=1693320974;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GMWWU3jb+Aqy9RcSXkJwR3nMXoyivnNOhp61RgjSA68=;
 b=bImwK/+MJUbzogeulTLWp34225qc7XQsuZmzs115llj5FnXhOesoWcMP8WYqeX8aQI
 PWU3LLk+ZPBuJlaOFPMaTgkcTd00DikGSFUYhug82tjKNEz7+ck/z3QBIxN2o344afAd
 Uy+7Xmye/vYNPFYlIBofftcoC5yiLlrIA+HzOmSr+/c1gGDr1RvWOmKCL7rR9Y/Rvkse
 rgs2r5gF8qm/NUMHG2IgoQxcno7tPLqaoYYO4BO78KCzTq78TeQJhkgpm9n4a7s3S9TQ
 2McS/VS3em9qPwl/v8i8AvJVwWfid0oQoXKar5rOhUKoPNMAocWQAZsbYgKb1LJ+JvvM
 yiWA==
X-Gm-Message-State: AOJu0YxtIaaQ9jetBNNzBS1l9CFSOeaNp3f2GnkgL0u5Ez/FaLUr1iYZ
 76L4ZPEUzr2Fpwg/PKnDvcs2eA==
X-Google-Smtp-Source: AGHT+IEbIDjOLRwXkdZI67TPWhtKL6BMVGT/cFuctuCFctWhhmUMYvjRfGtDj39xnHYuhJ9smwx6Pw==
X-Received: by 2002:a17:902:d4ce:b0:1bd:f71c:3af3 with SMTP id
 o14-20020a170902d4ce00b001bdf71c3af3mr8506562plg.32.1692716174254; 
 Tue, 22 Aug 2023 07:56:14 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:4e3c:f4a4:b92a:b5ab?
 ([2602:47:d483:7301:4e3c:f4a4:b92a:b5ab])
 by smtp.gmail.com with ESMTPSA id
 q10-20020a17090311ca00b001bb0eebd90asm9191336plh.245.2023.08.22.07.56.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Aug 2023 07:56:13 -0700 (PDT)
Message-ID: <e42b389c-ec53-1b43-9813-1457281fe27b@linaro.org>
Date: Tue, 22 Aug 2023 07:56:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] target/arm: Use deposit_z() in BCF opcode
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20230822095156.39868-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230822095156.39868-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.767,
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

On 8/22/23 02:51, Philippe Mathieu-Daudé wrote:
> When clearing a bitfield we don't need to lead the
> source register. Use deposit_z_i32() with the BFC
> opcode to save a load_reg() call.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/arm/tcg/translate.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

