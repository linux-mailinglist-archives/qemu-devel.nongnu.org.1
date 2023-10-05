Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 983947B9AE0
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 07:17:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoGiU-0006wg-0Q; Thu, 05 Oct 2023 01:16:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qoGi7-0006wN-R6
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 01:15:44 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qoGi6-00067X-55
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 01:15:43 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-690bccb0d8aso483188b3a.0
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 22:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1696482940; x=1697087740;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sU++kcKulfN8WXL3zpT8Ued13p7GrWkUs75Tia+Bq1I=;
 b=MwMCkq0s71CoDwIcu+eynDc9Fui+bQDm07v0SIcbCy/BcGqz28Ps2PFIHx+dVD/Kj8
 Q5i1kYWUPJAxOXb8S0aN+P1W9US2Gya61HVlG280aLkp0xtSsIKGdq6IYB3PQ9osH+i5
 MJSBhxq0upIWzgxpNuZK4XsOWM+6ujQ7+o09Wrb+XZuOQ6egnTQlTMnoI44P7deWdeQG
 4PAM/bfoegwhtu62Rq6pwxqstrGMblRQwoIiBp9lGfJXLSmGSw3Hss+qhcemKv+Wx1w9
 Yfg69cQpRp6PGiDLgbOZpMw/rrmrNH0/bPpuXh0oLqR3nrqLNlA2q2iw0byID4O9o3JM
 uP+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696482940; x=1697087740;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sU++kcKulfN8WXL3zpT8Ued13p7GrWkUs75Tia+Bq1I=;
 b=hl4B+s9/Tf7w2mj9YKZpHXlI7Wg5bKxl6FO7MuJmpPiUggMdOpaTdDZ6M2aJzX/tUr
 ZDGe5IuZWYxu/otZvwfDh3R7Sie9pFQaW+4K4+00pkhuE3BBIxtefuH6/TCEYeb7A1In
 9/VHoL7k7rr16WOUYEosFXnMH7oBhavstOUS4TPkA+0DOqu6Cv83F3s7HvHV2IHBf/XB
 ZJ7dVMorI2FGj8qqTqQDUprrLJfdADgn/OLSGttp5a88gMLAvPrn1hWvV5mES2NoZ+cQ
 J4QPTRAC21DCANccFSkWN8RdDcCkwr4BYqGtVR1FdujnykZecjOMBqbKaRGNShZDmzcl
 RVYQ==
X-Gm-Message-State: AOJu0YwG1xt7RYWglkNzu6YdZ3K7Oh9YlwJ+6McmeJlOWCOTzPtSfhs4
 Vr5ok/uOgUxj+V3zpxfxMq/btQ==
X-Google-Smtp-Source: AGHT+IFvQ9AURDwE70IcKJZQ56whZKuXtK98xJ+F65xWu2TSJI63GA2b5CZetMlecfjBADd64BhixA==
X-Received: by 2002:a05:6a00:2f4a:b0:696:d529:b502 with SMTP id
 ff10-20020a056a002f4a00b00696d529b502mr3009790pfb.7.1696482940425; 
 Wed, 04 Oct 2023 22:15:40 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 k15-20020aa7820f000000b0068ff0a633fdsm431857pfi.131.2023.10.04.22.15.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Oct 2023 22:15:40 -0700 (PDT)
Message-ID: <9d226a96-b17b-45e0-b8d4-ba48d3f15c42@daynix.com>
Date: Thu, 5 Oct 2023 14:15:35 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/16] ui/cocoa: Clean up global variable shadowing
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20231004120019.93101-1-philmd@linaro.org>
 <20231004120019.93101-11-philmd@linaro.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20231004120019.93101-11-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::433;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x433.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2023/10/04 21:00, Philippe Mathieu-Daudé wrote:
> Fix:
> 
>    ui/cocoa.m:346:20: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
>        QemuCocoaView *cocoaView = userInfo;
>                       ^
>    ui/cocoa.m:342:16: note: previous declaration is here
>    QemuCocoaView *cocoaView;
>                   ^
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   ui/cocoa.m | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/ui/cocoa.m b/ui/cocoa.m
> index df6d13be38..15477288fd 100644
> --- a/ui/cocoa.m
> +++ b/ui/cocoa.m
> @@ -343,9 +343,9 @@ - (void) raiseAllKeys;
>   
>   static CGEventRef handleTapEvent(CGEventTapProxy proxy, CGEventType type, CGEventRef cgEvent, void *userInfo)
>   {
> -    QemuCocoaView *cocoaView = userInfo;
> +    QemuCocoaView *view = userInfo;
>       NSEvent *event = [NSEvent eventWithCGEvent:cgEvent];
> -    if ([cocoaView isMouseGrabbed] && [cocoaView handleEvent:event]) {
> +    if ([view isMouseGrabbed] && [view handleEvent:event]) {
>           COCOA_DEBUG("Global events tap: qemu handled the event, capturing!\n");
>           return NULL;
>       }

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>

