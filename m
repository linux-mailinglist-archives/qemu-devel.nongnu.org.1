Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B670A70FE50
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 21:13:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1tuu-0006ne-2F; Wed, 24 May 2023 15:13:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1tug-0006l0-Gf
 for qemu-devel@nongnu.org; Wed, 24 May 2023 15:12:48 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1tuc-0008Vt-9y
 for qemu-devel@nongnu.org; Wed, 24 May 2023 15:12:45 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-64d41763796so973992b3a.2
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 12:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684955561; x=1687547561;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gAq2fsDgD506O1XwE5EUT6+UfdTDa3xInx9SxnTNMQU=;
 b=B3NZN87s+ylRg6KeB/3JKO97fxlKzVqoGJ7uLYRsyof8UtfitNMxIZr+Rh7JSbb1Sj
 JLSdvWx6xFdygYvvwMy3BJ84awm9ogbbz4sZyFe/UP1fAoBuFmViWf7Pyg8hAdStqdUK
 WS0BS+ozRINTTLuw6hfWKO4fzTLK72+8A2qJ7YFr+DQB9dTwLmj6gMo52+wLKgZwl0HT
 2TPEuwbSaDdRIrq1V0lsORhFPZUdw7FXf2ytRThjyGMYMXPp1Q2IXG6fkUEVSomYb44n
 adsnL7V5ZbygIY5vMhiYf+KqtJXLXG+Rx7Xny/kHx/ZvR3TMzNKRAgi0yISV9OfTC8js
 AJdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684955561; x=1687547561;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gAq2fsDgD506O1XwE5EUT6+UfdTDa3xInx9SxnTNMQU=;
 b=QmnTtB5byC25zSgbdLGdNjQr5zL8Clm1ZgyrBKD9aLUmJMB0cQrw7frjVgYlhH+65G
 ZP37LQSzO42dcR8ZRDw07PK7Ana4h89FHWZWUWRPbnzxPTaW2Inj4en4M8VS+RIn6ki7
 P/srgNHm1bbsIlUcZtkFIe4WsvWs4UavXWHmIpVwXkiVPLX2VqvcySSiCB56m43MUyHe
 z5QVrwZyL2MxjlW2aoTiY1k8pKyJtP6dmHQ5jRcv80MmKWfzbYDwi/ernGFv1yD7Vw02
 4LkGfOMj7ghSDkIt/euJa+DUDibU5jSbLYqxuHCzLkQgVtNupe0PM7Hn61+6vVW6GWjg
 VVZw==
X-Gm-Message-State: AC+VfDz7aK6LZw7+a1Y5xdl+eH+wP+/oYbeSIqZih7gWFAV0wvbmCBHb
 8Ttysaxaw1YLFmySHqrV9X/fibKBGBO68vGfly0=
X-Google-Smtp-Source: ACHHUZ4Y0vvkftUfh553D0J18jXKXvbB1iqDsWSrYTPsTaVyJ+7DWFuzEFJaLC/q6d+C9TxP9aKerQ==
X-Received: by 2002:a05:6a20:3c91:b0:10e:ce12:356c with SMTP id
 b17-20020a056a203c9100b0010ece12356cmr1282039pzj.17.1684955560712; 
 Wed, 24 May 2023 12:12:40 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:6b03:9af2:33c1:3d6b?
 ([2602:ae:1598:4c01:6b03:9af2:33c1:3d6b])
 by smtp.gmail.com with ESMTPSA id
 n3-20020a17090ab80300b00253298287ccsm1681026pjr.14.2023.05.24.12.12.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 May 2023 12:12:40 -0700 (PDT)
Message-ID: <fac72b97-71b6-c911-c2d9-68e823d347d3@linaro.org>
Date: Wed, 24 May 2023 12:10:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 08/10] hw/arm/realview: Move 'loader_start' to
 RealviewMachineClass
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>
References: <20230524145906.33156-1-philmd@linaro.org>
 <20230524145906.33156-9-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230524145906.33156-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

On 5/24/23 07:59, Philippe Mathieu-Daudé wrote:
> Instead of having each machine instance resolve its loader
> start address, set it once in their class_init() handler.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/arm/realview.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

