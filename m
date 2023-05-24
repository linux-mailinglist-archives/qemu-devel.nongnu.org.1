Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 178C170FE2C
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 21:05:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1tmz-0001rG-M7; Wed, 24 May 2023 15:04:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1tmx-0001qp-S9
 for qemu-devel@nongnu.org; Wed, 24 May 2023 15:04:47 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1tmv-0006ju-Qr
 for qemu-devel@nongnu.org; Wed, 24 May 2023 15:04:47 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1ae6b4c5a53so4391915ad.2
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 12:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684955084; x=1687547084;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=G84ipAdGubOM0FDUyEbPrBlTei+iFwORLXboEFro4U4=;
 b=vnnsLnqVuma47edK2cj40r35EXZHcHF8VVd4jl2LMfqXbBioKmmKwdItUJhAXekYfE
 joVbKblREZqLGXa9V8wcLthSE5LUqAkcRP9YtaIaC6KNtWdrizZ4/wrdIMMCmx2o4Bsv
 1qqkGSh9/FVpAjH0vyF/Ucis/pC+mC9DBx84oVgy5UQzUPJ/bfT4zKpluLvuQrW8rfY/
 vgFSjDcZLicWVGKijAHE6mFEZrmMT2Pml45VlEmUj03tqZ5OUlL0xxQT10bMO2Lfj9bJ
 4xhGgOyXK/q/o+MKkrAl2pUv9iMYusI395mg47ZIpilCKsTEANU3q/Moq/jEmMr05kRY
 divA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684955084; x=1687547084;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=G84ipAdGubOM0FDUyEbPrBlTei+iFwORLXboEFro4U4=;
 b=h219f1iP3EtkiwU76uGBWUr0QH39vsXM8QqjpDAAZVMiP3GwxwWffsuMeuKJLdW6X2
 1zuEEzUvLbPiNr/vXqhl/+zzsspFNZg9LlL+HzbZPKeh1bw0qtyEj2G9sbDnJJaVWmgD
 DcGP36BrDervM7OJBgr2P4PwDPCT3H6OpxPvc/zJi8pckWgN3GdWoJaUW9gGUdAHOh3y
 xowtViWiVUisN7W9ZTghZqiR2pwbB+QY4cs/EaZl1HhPg3i/kIuXQBYThK6Mb1GqPjKI
 MddYxRAeNBJIG3pu2bewpOBdREUPepbHEAeCQcQnUgkIxfif5XrEn2gxAN/C/EGhPCgS
 rg/g==
X-Gm-Message-State: AC+VfDzjOPFk+t7j/R5h3v0LUl/2ojh/13Tt6luHR9jD/uL00W0GWPrp
 DULN+vvj2kcDijX757h74yAUBw==
X-Google-Smtp-Source: ACHHUZ5tFZOPp9NBdl7sBzzVwc9t7oxPGCuXq8sw/bJh+xT0oZtI9gcB93ZqtYqGEJ1EpJSAPZw0aA==
X-Received: by 2002:a17:902:ea0f:b0:1ac:8062:4f0b with SMTP id
 s15-20020a170902ea0f00b001ac80624f0bmr19574561plg.59.1684955084373; 
 Wed, 24 May 2023 12:04:44 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:6b03:9af2:33c1:3d6b?
 ([2602:ae:1598:4c01:6b03:9af2:33c1:3d6b])
 by smtp.gmail.com with ESMTPSA id
 n2-20020a170902d2c200b001ae3f73b9c1sm9150911plc.101.2023.05.24.12.04.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 May 2023 12:04:43 -0700 (PDT)
Message-ID: <96867a81-5381-0be3-e28b-3e1a9f561e8e@linaro.org>
Date: Wed, 24 May 2023 12:04:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 03/10] hw/arm/realview: Introduce abstract
 RealviewMachineClass
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>
References: <20230524145906.33156-1-philmd@linaro.org>
 <20230524145906.33156-4-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230524145906.33156-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.107,
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

On 5/24/23 07:58, Philippe Mathieu-Daudé wrote:
> Introduce the abstract QOM TYPE_REALVIEW_MACHINE to
> handle fields common to all Realview machines.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/arm/realview.c | 22 ++++++++++++++++++----
>   1 file changed, 18 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

