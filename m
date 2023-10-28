Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3777F7DA8EB
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 21:26:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwowL-0006oX-9Y; Sat, 28 Oct 2023 15:25:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qwowB-0006n8-Dl
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 15:25:37 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qwow8-0000mc-SA
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 15:25:34 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6b36e1fcea0so2820212b3a.1
 for <qemu-devel@nongnu.org>; Sat, 28 Oct 2023 12:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698521131; x=1699125931; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ysHUVbdIC75PlqjlpRi2h57MQUHdVdBhfuP2F5uDVMY=;
 b=mmLxmkaa7gKpKzv117se6fs/kBfjHUgn2FMJRl/lPIZQl41ZJEveR/IeKQn4cJY8RT
 Z2BAK3e8/8d1V69iWQnC44B6Qy7wXRO//bGu/FD09qvXgTc3GaIm28Dfg+Akrr1cD3kh
 XjX7/rrI2BwSo3zgIXeWVLXKJ4a1hneIsJzbadw6bTMKU1mJGo8OeDVr+xr7m0Dj/Y6Y
 ZJtL43hC7LnSJ9PzRTBoZNhKwRfshpFyu09zhX+BfASPXGR1ZPrIp7GRNaMIzPWT6R6F
 iGtUF5hGza2Hq2s/DNwOIHP7BWk6ZFPdEv7pT3Yj9UFLPu/l1onTZuNuJEll6a/K7n8b
 //+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698521131; x=1699125931;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ysHUVbdIC75PlqjlpRi2h57MQUHdVdBhfuP2F5uDVMY=;
 b=krCAZPvrmV6qxXx7G51kNF8YFqQss2WP4NpDC5uZLRMLSJSyrxNk2qhExQIAEBSWiu
 SibJUfXGKrghv03VraTkpcaZ+W2boWLmU9AXY+7+3vC1ko/tBH07owFQLgCfJhXybOvM
 COSS//ipCG1ehnjYyvEUw6dJGccq5OAgtdosYBduSA03/7P4PpyQX4tpi819QRh21Eed
 vq8WxhnFTMP8OGA6YHj3S/J/t1PN9080XUeZ8gWLANxaG9bgQvdwvSeStsCP1koZBQ4O
 9jzdgGc8ipHIz+rhMNw6ozGgWgG3MHsSBfkB8TGcbNCKClc5I6rQxODUBnkpvnIi4NHJ
 pMvw==
X-Gm-Message-State: AOJu0Yy6OtPYxLq3pMAA1d+KTI1spumG0ktGsNC9XH3OYwE+bZVed0h/
 0vcCBjIwkSXReWTvqtxuwTB2Uw9SEL54/Pngw70=
X-Google-Smtp-Source: AGHT+IHwBTR1BwjlUNXAyvReOgwBrN6qBiJAdoR5gkXN8jqugxErC+OGzA5gNyrPSaU1kVqypf1XpQ==
X-Received: by 2002:a05:6a00:2d09:b0:68a:52ec:3d36 with SMTP id
 fa9-20020a056a002d0900b0068a52ec3d36mr5637899pfb.31.1698521131664; 
 Sat, 28 Oct 2023 12:25:31 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 fn4-20020a056a002fc400b006b4ac8885b4sm3390045pfb.14.2023.10.28.12.25.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 28 Oct 2023 12:25:30 -0700 (PDT)
Message-ID: <582d2de2-945e-4315-a20f-5cfe57f83c8a@linaro.org>
Date: Sat, 28 Oct 2023 12:25:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/17] tests/docker: use debian-all-test-cross for mips
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20231028103311.347104-1-alex.bennee@linaro.org>
 <20231028103311.347104-11-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231028103311.347104-11-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 10/28/23 03:33, Alex Bennée wrote:
> Maintaining two sets of containers for test building is silly. While
> it makes sense for the QEMU cross-compile targets to have their own
> fat containers built by lcitool we might as well merge the other
> random debian based compilers into the same one used on gitlab.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   configure                                     |  4 ++++
>   .gitlab-ci.d/container-cross.yml              |  6 ------
>   tests/docker/Makefile.include                 |  1 -
>   .../dockerfiles/debian-mips-cross.docker      | 19 -------------------
>   4 files changed, 4 insertions(+), 26 deletions(-)
>   delete mode 100644 tests/docker/dockerfiles/debian-mips-cross.docker

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

