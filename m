Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 56AF57C7C85
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 06:19:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qr9de-00061g-HP; Fri, 13 Oct 2023 00:19:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qr9dc-00061O-92
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 00:19:00 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qr9da-0007IU-Q9
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 00:19:00 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1c7373cff01so21924635ad.1
 for <qemu-devel@nongnu.org>; Thu, 12 Oct 2023 21:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697170737; x=1697775537; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=P8hxMU3ncmdb8xmcwogAO7olkZEiH7iuqsdCZDyfIxc=;
 b=bv2VIx7YD11eJLiHNW6mmTILfA4IlyWX4+cW2lJSN0h+r9xaSB5Pot3W7FfPvcKczB
 Q/6zWEUmO6JFRcHd8Me+q7rkxL/l2SGnDuhACHZlLm5IfPsR1Zv4e5+kbOT3/vKz6kuD
 FZ5jnN6qiYiONTtL+8Qeo64d2FbQQNwTfn2W1lhZZcWXoE+ZhQRbkpY4n6zxs2jgrPXR
 De0OddMxk+GsIal5R5A5XsPxvwB05L8jPZmFcL8LZoXyIoWaSQmRoocl5OjEXSbkdcFR
 eaj6R8ZPm77QMhyjKqy9lNtACkOBbpXtvpUblGaIs0o7aLDPGzO6g4vGv0lwFjNl/6NL
 OH1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697170737; x=1697775537;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=P8hxMU3ncmdb8xmcwogAO7olkZEiH7iuqsdCZDyfIxc=;
 b=ILUclNilSjEwi5It45p2cf0XDMc/XNYCpQMsWGqbifX+eDRnla5HF8wSKcf6DGcPux
 oKmPrllV6b4cKCbaSwEPhEZmjQ7Wa49mc7gm+l/vAjs58s7EV7OXQ3UxBysQRFrda8BQ
 0h6rPRjaLc82SEdHIDAmKKGGGRP3Ve+I2hyEdN25SpbV8FEy17NTA0D9Gz/1SsHhie4c
 idOh6RZRTqLGap0GSdC7w/WLjBdrXT7N63FsQvpBkCSYOiiGgyPSZr3HiR9L4HV9wK+d
 DoaLy4N5ih711M4FzyJQTP7tM8kLWMJUcKhzy5bsU1V26PrRoDY58pOiHjqSqCg6mnhS
 n9/Q==
X-Gm-Message-State: AOJu0Yz1oe4SDaMJf5NjrPj6fK7SHvprfgADYl4KQuRgHWCapoZuN0BX
 GK0OaqYnlnkQDfl4FgVOluPtkg==
X-Google-Smtp-Source: AGHT+IENyEN+EziQ9J/X2mdrmPiOfmsfBuaHXnLhqIbehRzZPY+gpBP4QH37OGNRNNCfvxKLI0OXZQ==
X-Received: by 2002:a17:902:e5d1:b0:1c6:362:3553 with SMTP id
 u17-20020a170902e5d100b001c603623553mr33306985plf.31.1697170737402; 
 Thu, 12 Oct 2023 21:18:57 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 x19-20020a170902ea9300b001c0a414695bsm2810744plb.43.2023.10.12.21.18.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Oct 2023 21:18:56 -0700 (PDT)
Message-ID: <59161d7a-d4c7-461a-a9c5-6363c7f141e2@linaro.org>
Date: Thu, 12 Oct 2023 21:18:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/18] target/mips: Declare CPU QOM types using
 DEFINE_TYPES() macro
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20231010092901.99189-1-philmd@linaro.org>
 <20231010092901.99189-13-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231010092901.99189-13-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

On 10/10/23 02:28, Philippe Mathieu-Daudé wrote:
> When multiple QOM types are registered in the same file,
> it is simpler to use the the DEFINE_TYPES() macro. In
> particular because type array declared with such macro
> are easier to review.
> 
> In few commits we are going to add more types, so replace
> the type_register_static() to ease further reviews.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/mips/cpu.c | 23 +++++++++++++----------
>   1 file changed, 13 insertions(+), 10 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

