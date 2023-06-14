Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F8DD72FE70
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 14:24:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9PWA-0003n9-0k; Wed, 14 Jun 2023 08:22:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q9PW1-0003la-CH
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 08:22:22 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q9PVz-000775-He
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 08:22:21 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-98220bb31c6so107592266b.3
 for <qemu-devel@nongnu.org>; Wed, 14 Jun 2023 05:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686745336; x=1689337336;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jGZc5/1KWKkNLD7TY5wQU6OjmxqzV1EOG+Us2N48M8M=;
 b=o0dhQiutxi/oWgIdHkaQxMNE+O6qIJsR3fcscuu3hd9GGbKoZeWIp4pbsUuoPMHcV2
 8ZHnelCt07LRgD5zYOq52nIWSwLYX6lA+6EWCmlSshpLqmaZhjU1G73GecrXuaZPAnbi
 cyNBpZVUqE9J/MMwjpaU2zi/XtR0npzQGKFrD8YSitNdoyPQ05zgaBI8pxnVn5EDz1+y
 a62C0yklzq45pSALVqzhZOEqPGzgV5Vb5NRENQQChCiFLORy16Go7OI8Uue/9RBX/Nc+
 r9CcWhVgYKiPr81YQeuCxI/0R1ej2CjNikTGIG0qZ5b0L/p1YQcBz1ukspHx1NcYN7HY
 oSxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686745336; x=1689337336;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jGZc5/1KWKkNLD7TY5wQU6OjmxqzV1EOG+Us2N48M8M=;
 b=RMvup5+iDQ8dB2i4iWP1MXxgwYjfkGDtbgtk2vju/aqU4ePN9wIpc32dIpH5ueGCNH
 wjO5VTkEFBxBxXHjKNdcZ3fpylNIKITd9/WrRFF6ObZPhxTIIrOZY5UMpPBEYUzn0wVg
 GLYopqxpyskYCkQN/YTCLjaCoDaORQ0ajvrIh8OIGb2i6z27a+joJNMZ30geSA1zx0sA
 YqOLW5YKiSHM8ifUzSmwiAki5ViBTWteHMQOcn3Rx2LmY+MVeTwQVhJQnJ1pEgps6tPw
 x/HOMJIXYoC5BYQ9B5SMhrojCp+Wd28SmpNOh4roftRojLSBjMZx5ifreVhUQ5S3OKJ+
 nunA==
X-Gm-Message-State: AC+VfDxSM2OuaKnlpCHATSi5m93wU9JXy+IppyZ/wMtL0gN+7iAeOjW6
 zYfZbICPYQjNsVcFSZJKuSRTgA==
X-Google-Smtp-Source: ACHHUZ5aUbCs7ocRzyuanPbq0/l4Ck/kPLQezcaNkV1Aqvyu6mZViNAIJX2LYLUD/vw3Eayjx2/f1w==
X-Received: by 2002:a17:906:dc94:b0:966:634d:9d84 with SMTP id
 cs20-20020a170906dc9400b00966634d9d84mr18802708ejc.20.1686745336263; 
 Wed, 14 Jun 2023 05:22:16 -0700 (PDT)
Received: from [10.14.201.118] ([213.175.39.66])
 by smtp.gmail.com with ESMTPSA id
 u2-20020a17090663c200b009662b4230cesm8066070ejk.148.2023.06.14.05.22.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Jun 2023 05:22:15 -0700 (PDT)
Message-ID: <d7404559-407e-5742-666c-6330da3d3e2c@linaro.org>
Date: Wed, 14 Jun 2023 14:22:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH] Fix handling of AVR interrupts above 33.
To: Lucas Dietrich <ld.adecy@gmail.com>
Cc: qemu-devel@nongnu.org, mrolnik@gmail.com, qemu-trivial@nongnu.org
References: <20230614140748.3584-1-ld.adecy@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230614140748.3584-1-ld.adecy@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x636.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.098,
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

On 14/6/23 16:07, Lucas Dietrich wrote:
> This commit addresses a bug in the AVR interrupt handling code.
> The modification involves replacing the usage of the ctz32 function
> with ctz64 to ensure proper handling of interrupts above 33 in the AVR
> target.
> 
> Previously, timers 3, 4, and 5 interrupts were not functioning correctly
> because most of their interrupt vectors are numbered above 33.
> 
> Signed-off-by: Lucas Dietrich <ld.adecy@gmail.com>
> ---
>   target/avr/helper.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Thanks for insisting with the patch posting process :)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


