Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E417DA8D9
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 21:16:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwomD-0000U6-1i; Sat, 28 Oct 2023 15:15:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qwols-0000Mm-Rq
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 15:14:59 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qwolq-0007Q8-1N
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 15:14:55 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1cc1e1e74beso16514425ad.1
 for <qemu-devel@nongnu.org>; Sat, 28 Oct 2023 12:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698520492; x=1699125292; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FWfgOmpD03xMcKIhwsa03FBWIi+OsBbpkr9OMmUyifI=;
 b=tu7EOCtJBn4Ei/e+KfwghqWy9He/mUQFUqlU+WsJJFleOsKYNtzYYe2/4k+cOqpptZ
 vDKtwu/lIGuN28fcfFCDrMGEKlX3YR0dGRSGcGutAqnsCMtmnKpniU2R5nnFnq9OMyJs
 65SeNHUVHi0bJPiPagg44GRQa/yBk9ua65eom99mnicM3V3Y+0CvLTXhZ70J72JmKS4q
 pikvNVZfzf82ICgCKc0HtjpRB9M+PWkfQZIjUGVVHydlyftbJZ1hxdvSnBkhZF+iNFRu
 l55OytaygZCDRynVpJaL3iygMB4x4S3LvWYmVp9XtoMLQr1p3NVkzVljnWbZ9+0tnoqV
 dnFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698520492; x=1699125292;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FWfgOmpD03xMcKIhwsa03FBWIi+OsBbpkr9OMmUyifI=;
 b=gWBvCSgP/1y7no7dmu+TfKdTou/izfKk6LFbeui4hmwO65M2MIdLHpDd4KQ1srqrLM
 V1WxiboYt0kPJP+wOnSgoDTiB6l3rHBLrjrnZUlt4qxWQ2LBTYrkElcR9MBuiPgljAlq
 mEk7TpRWP77vn/Tj59fZzzGU2b3t7+IHXUcthWz85HDcxWEfTmuP88tpFFEvb67XYPeP
 g0zScquN82OdX7XtAKTGGW7nf6vq7k4BHNNXYvsCUm9ijzofLUqqvPkCVayCArcCMI6W
 8q+G/VVEPhAbsNyYCMjaXA681zHd9Jc7jJGv3Q5zaV7UZCpN+u0d9HSo+iI1Ymry1ybE
 HxNQ==
X-Gm-Message-State: AOJu0YwLnLGYEQdSG2UTX2GxgOWQo/aHK0ZImqIAV/s9w/oALw7vT6AP
 vGnbf8tu4073Xh3VVUsalPdTGw==
X-Google-Smtp-Source: AGHT+IGUER525YgqpLmm9vkSy0KzmNJzfl/65A2GcUIpwxiXNuHUjbjz9A8qCcmdRraxZ+UyGFdG4w==
X-Received: by 2002:a17:902:8c85:b0:1c9:c0fa:dfb7 with SMTP id
 t5-20020a1709028c8500b001c9c0fadfb7mr6031095plo.57.1698520492119; 
 Sat, 28 Oct 2023 12:14:52 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 u2-20020a1709026e0200b001c57aac6e5esm3620938plk.23.2023.10.28.12.14.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 28 Oct 2023 12:14:51 -0700 (PDT)
Message-ID: <6cdaaab2-6349-44d6-b6a0-688340835c4f@linaro.org>
Date: Sat, 28 Oct 2023 12:14:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/17] tests/tcg: Add -fno-stack-protector
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20231028103311.347104-1-alex.bennee@linaro.org>
 <20231028103311.347104-3-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231028103311.347104-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 10/28/23 03:32, Alex Bennée wrote:
> From: Akihiko Odaki <akihiko.odaki@daynix.com>
> 
> A build of GCC 13.2 will have stack protector enabled by default if it
> was configured with --enable-default-ssp option. For such a compiler,
> it is necessary to explicitly disable stack protector when linking
> without standard libraries.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Message-Id: <20230731091042.139159-3-akihiko.odaki@daynix.com>
> [AJB: fix comment string typo]
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   tests/tcg/mips/hello-mips.c       | 4 ++--
>   tests/tcg/Makefile.target         | 2 +-
>   tests/tcg/aarch64/Makefile.target | 2 +-
>   tests/tcg/arm/Makefile.target     | 2 +-
>   tests/tcg/cris/Makefile.target    | 2 +-
>   tests/tcg/hexagon/Makefile.target | 2 +-
>   tests/tcg/i386/Makefile.target    | 2 +-
>   tests/tcg/minilib/Makefile.target | 2 +-
>   tests/tcg/mips/Makefile.target    | 2 +-
>   9 files changed, 10 insertions(+), 10 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

