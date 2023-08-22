Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D68A784CB2
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 00:08:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYZXm-0002yL-34; Tue, 22 Aug 2023 18:08:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYZXk-0002yD-Ed
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 18:08:08 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYZXi-0000Y2-A4
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 18:08:08 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-31aec0a1a8bso2237078f8f.0
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 15:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692742084; x=1693346884;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Bos2WYncr3AY9pPdtYTgNgBxPBgg8yK2IK1eFJA6hfQ=;
 b=Dw39psRvGIYGnPv00dR1fCkU5MtKnLhmu3NPLayTnr9eka1XaIXAo6InTuH+aAWH1X
 f6PuQi5ncddK5H8JSvjolZhiwh1gd81GSe2mHTaVDSy0dG4rVtvllCsNEGJxNbF871fu
 Iw1lq+W30tl2OdyuEml1R3BDHzjZIbrcX8iZxsJQ7LfAgURGnGRT9yWZIgUe4v+T+k65
 PrCy267/fX9qxUS0ODWYucUvTJRhWnHOaqM5BPkZocnZELLATu5YwHgRx66xW81ywfqw
 vpkXjeohJo8f03q3BKL1JXFziEHoqDzG2Yd8Vdb+EtM8HRFXbwt0GLiR6A5W8hOS7B0n
 Vr2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692742084; x=1693346884;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Bos2WYncr3AY9pPdtYTgNgBxPBgg8yK2IK1eFJA6hfQ=;
 b=aadgbIbYUXGaa35vA139mpxg4lDsmOpDT78NBN2YTLRjeqFGaV6/34ORsswHuQyz/Z
 U1KqelHnGKOi8fqjkTgeWgQexSUwL8LgZ9gIbrkfqrLbEwJs4PxLDM7m0fcpwg+hCtku
 ccjKP/FW7FBhw6H0sNRYNxQR2U//Szu5iqq6musyDHVN6kWI2TDuP7F+qAbIUMwcX3Rq
 C5a0Q8M/JpXHSkucy3E3kP4pogw8IzGGADST4FDD664FWpz3YyDwY+Y2aiLnwTwWbErv
 TTx7TC6ZWp4zsKw+DrQ9lzBTqjxRI1FgJ/sxG3iOTy2tgM3pM+FXCYKVF5+QiJ4UoGir
 EqxQ==
X-Gm-Message-State: AOJu0YzIcENoDdurfUm+vMz6b5tDrrUPUnhN+P6BuPWESfKauqBTtSqd
 RPm3RRIFPR+onDCluELQVo0zLWNVkGNPFUGK0tI=
X-Google-Smtp-Source: AGHT+IFx/EbpKG3eQSdQjwyCFCn/HSb4fC7YzWABAv3BoHAAlXa7pCppPrDnoxeH1ljK8p8ZQfQpDg==
X-Received: by 2002:adf:ec8a:0:b0:317:de66:259b with SMTP id
 z10-20020adfec8a000000b00317de66259bmr8295477wrn.15.1692742084691; 
 Tue, 22 Aug 2023 15:08:04 -0700 (PDT)
Received: from [10.2.0.2] ([37.19.214.4]) by smtp.gmail.com with ESMTPSA id
 v26-20020a05600c215a00b003fbb618f7adsm16954865wml.15.2023.08.22.15.08.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Aug 2023 15:08:04 -0700 (PDT)
Message-ID: <09cdd7ed-2664-f3c2-a943-b652015d4048@linaro.org>
Date: Wed, 23 Aug 2023 00:08:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v3 1/3] linux-user: Split out die_with_signal
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: deller@gmx.de
References: <20230822203415.1184491-1-richard.henderson@linaro.org>
 <20230822203415.1184491-2-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230822203415.1184491-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

On 22/8/23 22:34, Richard Henderson wrote:
> Because we trap so many signals for use by the guest,
> we have to take extra steps to exit properly.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/signal.c | 52 ++++++++++++++++++++++++---------------------
>   1 file changed, 28 insertions(+), 24 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


