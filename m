Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C1E72A363
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 21:50:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7i7M-0005dL-4M; Fri, 09 Jun 2023 15:49:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q7i7K-0005cy-LB
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 15:49:50 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q7i7J-0001Cf-7G
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 15:49:50 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-65311774e52so1741890b3a.3
 for <qemu-devel@nongnu.org>; Fri, 09 Jun 2023 12:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686340188; x=1688932188;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Drg4WP1wZ1Y1t8wan6VVGf2/z7ogGRSmyqWKwVjUdNQ=;
 b=dySVUljN4ItoVwKeb/mv+hvLVi6105w5FishF3qHcBA39yh0jvMp6fjvwpJzC9Ty1D
 kIXYNQbUb9OJkALGoFytZo/5j1aoC7rK5Dbe5kUXIlKYrU/Y3hclPXSC1Efz/WLYtNeh
 aHN7IXjH4IR8429YcvKlVpv2JY/VksUW4fYkNcAbOV3auCYQ8xA385/ig3NXelmeCP1e
 8OGXDajhGonJ0PHrylBDgegx3Z+5AAofvMmgQ5CZI+k4WdbL8ytyR7miq+sK2N8uzy/b
 Hql5GZwvGut//CJ6LDaJ7IE1yLc69sNx3VL6AHuQstxCGm0tsKG4vskNWSpERSfeG7ld
 AXIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686340188; x=1688932188;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Drg4WP1wZ1Y1t8wan6VVGf2/z7ogGRSmyqWKwVjUdNQ=;
 b=leVVxj0+1ib2g2QVaq2MfrP+HblbnHR9Fv9mS4BKXFqem/nCVdn9IVct7I7ueMam9q
 ZuxpzTwmk/bV9mKJkQITzT68wAFsIvAeR38N6CetzH0EL2AIwZutaN/47anWHNVC4Pqd
 fImEHtalBFH9KNvAeKOL5If8ADZGk5T0FNdofI4TPoZXAkPHMqleaRcisPcHdy80IxNh
 1be1f/l/5Xq+Po5gKb8hIKn3ROXzv9FoD9Ekk+xurQNzv0nCxxezVzu1qTYE71VkOyOg
 cn0qWgMSbKZpNVvrtPZpsbBi9ZXnxjUyaCANr/a2pzkSEEAogWcRkiGypNRV3FFn62Pc
 m3Ng==
X-Gm-Message-State: AC+VfDzvdW9UHK8NS3U2P7a6ArsKTRrPTYXZ2bMMPruZfbknMbqFq3tn
 x4wNl0dFu38iIi9PB9n4XBYrscQRjBuLYuWExw8=
X-Google-Smtp-Source: ACHHUZ5XVmNmHgomYUzoBeA7tPIpigsuB4Nqwo7nwTGP1yW4WPn3ThbQzz2hjS16fdQbsx0fbyIvGQ==
X-Received: by 2002:a05:6a20:1004:b0:110:29b9:9652 with SMTP id
 gs4-20020a056a20100400b0011029b99652mr1685440pzc.56.1686340188001; 
 Fri, 09 Jun 2023 12:49:48 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:20be:c4cb:f609:8cca?
 ([2602:ae:1598:4c01:20be:c4cb:f609:8cca])
 by smtp.gmail.com with ESMTPSA id
 l4-20020a63ba44000000b005443c83b176sm2971812pgu.69.2023.06.09.12.49.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jun 2023 12:49:47 -0700 (PDT)
Message-ID: <fdf5b36e-a8f1-0a41-b957-0720f2c53cb6@linaro.org>
Date: Fri, 9 Jun 2023 12:49:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 05/22] target/arm/tcg: Extract iwMMXt helpers from the
 generic 'helper.h'
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20230609104717.95555-1-philmd@linaro.org>
 <20230609104717.95555-6-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230609104717.95555-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 6/9/23 03:47, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/arm/helper.h                |  96 +-----------------------
>   target/arm/tcg/helper-iwmmxt.h.inc | 114 +++++++++++++++++++++++++++++
>   2 files changed, 115 insertions(+), 95 deletions(-)
>   create mode 100644 target/arm/tcg/helper-iwmmxt.h.inc

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

