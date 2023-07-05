Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D96B674863D
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 16:25:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH3Q6-0007pf-26; Wed, 05 Jul 2023 10:23:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qH3Q3-0007pH-KB
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 10:23:47 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qH3Q2-000737-3j
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 10:23:47 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3143b88faebso3028882f8f.3
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 07:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688567024; x=1691159024;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/w8C0TsFl/0Df7MloHT0i76ryBfelfU3M9Pi4ntb0Kc=;
 b=dIXG+ZcQhSHUcAzIuv5A/JB1zxcTgFpft/v9r2r+IUSOcawIxiB1CxmFDoJZtn6B6b
 TIsNOcdRFs44d4JSxTwW+hcJSS24576u1CCDEqYyQJMkxdrmPHNESYfivw9wEbjdP5Un
 dcOBYcBvzZf7RJFYyjzthph9pPdLkpK40dwPC50v+5EKwQbqY7u6BnLugFdHtGrD977C
 qei2aglykNDtXcZ+c/jf2Frhk7PlE9V0HXa/bX+p6AAj64/4qf5a2m38isANdozl9ALg
 qaOjO/dDe+U/bIeHiUxqiLdlXF+cYLKFPkYT5UF3FPcJypoaVr+y7Er5cxmG6oGzGR1L
 0OEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688567024; x=1691159024;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/w8C0TsFl/0Df7MloHT0i76ryBfelfU3M9Pi4ntb0Kc=;
 b=SsHuRk+5c/IZV1wqjnJMj2Q3ZyU+VTyx6r26OCLYOofTIec9vuY9wHpdiAoduiDXs8
 ht2JVP+Axb9I2Fu63SLK/qfd0Gyr+GFNxI53Dw5Yh83o6arXbLrjWFBvHqOd8Z+wslsx
 puV0Fp8vfx9rOxaC4X4+arPGnbmLeTPv7ZVaVWXm/wAIJOUSm7uUPkerc1BfFgVqlGlK
 D4VatRAqe5PhDnj3FLEWm73JXBoTYLHEU31N5QHkw+QdyhmV9KwLPvyu8VYZXjVoTOO6
 mVmP5PQGXk4kcXSE6ze02E55H6OnryMDN1wb5i9VjX2/JRcMJJQUJRKSLPTF2E5LJePW
 rNdQ==
X-Gm-Message-State: ABy/qLbK44bGidTNoQAU/rEXdIcJZdQMW4P0AEI2UWvGftuHr45PBmn6
 AnrS0R9DA33cnjkKD1B11dIa4w==
X-Google-Smtp-Source: APBJJlEgNFwGMENBmERZV+6pWWcYNH4DwHsrdtMzQpVPC5MGB50tkVogWoWp/y79SK/OxmmZGpy6vg==
X-Received: by 2002:adf:fc4e:0:b0:313:f9a0:c530 with SMTP id
 e14-20020adffc4e000000b00313f9a0c530mr16918319wrs.52.1688567023823; 
 Wed, 05 Jul 2023 07:23:43 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.142.96])
 by smtp.gmail.com with ESMTPSA id
 b3-20020a056000054300b002c70ce264bfsm31407155wrf.76.2023.07.05.07.23.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jul 2023 07:23:43 -0700 (PDT)
Message-ID: <7afd7d7c-fdc8-3853-01ff-a085a52395bc@linaro.org>
Date: Wed, 5 Jul 2023 16:23:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH] meson.build: Skip C++ detection unless we're targeting
 Windows
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
References: <20230705133639.146073-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230705133639.146073-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 5/7/23 15:36, Thomas Huth wrote:
> The only C++ code that we currently still have in the repository
> is the code in qga/vss-win32/ - so we can skip the C++ detection
> unless we are compiling binaries for Windows.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   meson.build | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


