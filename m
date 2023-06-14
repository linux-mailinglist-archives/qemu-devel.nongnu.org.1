Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D5EA972F462
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 08:04:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9JbZ-0004bv-Uj; Wed, 14 Jun 2023 02:03:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q9JbO-0004bI-Ag
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 02:03:30 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q9JbM-0004O6-85
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 02:03:29 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3f8cdb12719so1763555e9.1
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 23:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686722606; x=1689314606;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Z1mflwoxiIcBk9lnaXGGSMIDSBExg6+3pv6d7Z4z+S8=;
 b=BVkHKrOCZ9Q7rGH/9e+IsUckdyK7TVTeOZT506pfXHrQ+2KZf58fORbc5qHZZchg9o
 M2lHyQGceuQMKUBhwtPoqmGjS4kcwMCp3RjwSYBfqH6/zuqzpnIPN/bKYmw0/anPX0iQ
 Xqnb0sIo+xG0ppGsGlJ0PQKanvTH8QwvJB9riTZooBngQeOaQ0am10vnLByRAVuRV6Xb
 y1i1pP/wFSS87SH1AJ9sGGisF0B1fYcJ4ESkEh4sTFVzYud4dFI5LL/O1ehi+wmShYtK
 hF95aWmMkO6l4lmhG06+JyxZEpeRQCn6knLwQpVDiMxVzzvej5yBQeaWe7i2TQezpxcd
 Xwqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686722606; x=1689314606;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Z1mflwoxiIcBk9lnaXGGSMIDSBExg6+3pv6d7Z4z+S8=;
 b=EZu2NQdawvFiR7A1VmQK3gsLqO7w2Vb7maDz25givw8SB+HSc0+N0MUC7K/6lWq6dG
 0JeVx1+yyhPfNbapJICzWVqpOtDiB0Mm1GQd7+bdkm8lYCBrS0f52vdWirj2+vOwRozL
 Lo8Q9hrO/4ZN/dc80iCD+Qet4pypyZasCq1dDyJP8IHNZIWHZDUDuRQm2p1b3eiDljXe
 1x9O2Z59G6R2v3K4ZUEljb+ZoA05L9zFjZ10dg84OMeYD9gC6yFKxnnOdGuR+fkbEdkQ
 Ww71fp3QETitr3iM5qE7QIcE6XyqTR8saL/YUFRUrYE+GalANmR5Suyq37DLGqNmgW6a
 UwIg==
X-Gm-Message-State: AC+VfDzN3iGgd9hdsDxZS3F4xj5d5ToUih0iK7cw1LYiyuLbzypVa5U1
 0HdGzXj8QzT0DGeI/wIyuWkUPA==
X-Google-Smtp-Source: ACHHUZ4Oy0q0ObfSzblcLeHe8n7VAQtlX3ACcxY8s+TdjCsHeqYR9HQCZovA2Ij8zyNT0zXI8ZolXQ==
X-Received: by 2002:a7b:c40b:0:b0:3f4:27ff:7d48 with SMTP id
 k11-20020a7bc40b000000b003f427ff7d48mr9406197wmi.19.1686722606261; 
 Tue, 13 Jun 2023 23:03:26 -0700 (PDT)
Received: from [192.168.4.112] (90-182-62-66.rcp.o2.cz. [90.182.62.66])
 by smtp.gmail.com with ESMTPSA id
 m21-20020a7bce15000000b003f8cd4892b3sm3581895wmc.3.2023.06.13.23.03.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Jun 2023 23:03:25 -0700 (PDT)
Message-ID: <d3444e45-a75c-4a48-eb18-5ea807aecfef@linaro.org>
Date: Wed, 14 Jun 2023 08:03:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 2/4] hw/misc/bcm2835_property: Use
 'raspberrypi-fw-defs.h' definitions
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Sergey Kambalin <sergey.kambalin@auriga.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
References: <20230612223456.33824-1-philmd@linaro.org>
 <20230612223456.33824-3-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230612223456.33824-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x335.google.com
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

On 6/13/23 00:34, Philippe Mathieu-Daudé wrote:
> From: Sergey Kambalin<sergey.kambalin@auriga.com>
> 
> Replace magic property values by a proper definition,
> removing redundant comments.
> 
> Signed-off-by: Sergey Kambalin<sergey.kambalin@auriga.com>
> Message-Id:<20230531155258.8361-1-sergey.kambalin@auriga.com>
> [PMD: Split from bigger patch: 2/4]
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/misc/bcm2835_property.c | 101 +++++++++++++++++++------------------
>   1 file changed, 51 insertions(+), 50 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

