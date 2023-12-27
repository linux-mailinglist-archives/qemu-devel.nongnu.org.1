Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2A381F2E8
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Dec 2023 00:01:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIcu6-0005xv-1D; Wed, 27 Dec 2023 18:01:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rIcu4-0005x3-5h
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 18:01:32 -0500
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rIcu2-0006af-J6
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 18:01:31 -0500
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-5cd54e5fbb2so1516752a12.2
 for <qemu-devel@nongnu.org>; Wed, 27 Dec 2023 15:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703718089; x=1704322889; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9r/yEVJ+mBLJ3aom8HmY8tt/YOCxiKBpVIFqRkW5Do0=;
 b=Bje95/4+p5I7gfVDpgN7MBXosRUZQ6ohlBSudjIv+Cq1wcNU9WKhcj8Jw/+Sw1WGiZ
 oz2CLVh9YGrT0pBxXM6no3lFCoxIiiBPNfcORbl5afLp3fCNT2QXtrdQU/mgEae5L9Ca
 4B6Zpxi+McEbC2cXZV+htl4tT9v88ba7U/DvR43h1tHuIVjtygJcSE62HCE6tQy1aCKK
 o9uyLaTJ7juUyI26bcq1o72EAFvX+LkvnUPkdGunuM9lKwolCVxJVtO/AeVg8XY9EDkH
 CA124zbXM7SPxB9N7pMrRxVyvyndDJKTEzm4slggtdzYQRxfk5v0Df7eUe424sDiS4hJ
 i8nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703718089; x=1704322889;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9r/yEVJ+mBLJ3aom8HmY8tt/YOCxiKBpVIFqRkW5Do0=;
 b=jAWBCOlWDWsnGLXKVG/XpFP4iLp3Wtq5I+PwVOBxXiB7Bb8aMYh0uJ4tLAkGzD+gCu
 93q5MbI1Mq7LJMPkZUtGBjZ0htpn4hbL4jEm8NMWFGczgX2XJOd7Ff/OylMfWiI9nrh3
 oaoZqHVN7FvRjWN0roZqU7BYuxuHtKLA1wMqnC6/BP5lkgRSVInezsAyfhqmz/+JTAAF
 DpeYnbK22Jd+Ll7yFycfCNJPO7WTvUP5r0sGLxKf4HjUa0P++YCT5iT9ddaq7QQw4Jmd
 XK47VMzlLsTExYYIkKiI3I7W786MOnOdmHCtdKQUUlGvJQxNsh/lWSi7On2xfsNiC5tl
 BVyg==
X-Gm-Message-State: AOJu0YwyC30pOYqSVPi+uNRzuRuDhOd0f/ZkDe0LIqtv8+80ZFdlK1Ap
 jV7gTvUWt/KPA7QbyFv9pyPk5qTOogBtug==
X-Google-Smtp-Source: AGHT+IG89dD9gPSZ2HD6FYTHhHv5tbCgUBO6TUYTwYeONKrlZj4jFoitx33pJLhIW6hmSMhwzG6Q/A==
X-Received: by 2002:a17:903:32c5:b0:1d4:4ca8:eee3 with SMTP id
 i5-20020a17090332c500b001d44ca8eee3mr2620306plr.68.1703718089222; 
 Wed, 27 Dec 2023 15:01:29 -0800 (PST)
Received: from ?IPV6:2001:8003:c020:6900:12c1:9684:874a:fb3a?
 ([2001:8003:c020:6900:12c1:9684:874a:fb3a])
 by smtp.gmail.com with ESMTPSA id
 s16-20020a170902ea1000b001d331bd4d4csm12493472plg.95.2023.12.27.15.01.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Dec 2023 15:01:28 -0800 (PST)
Message-ID: <9ae6d5d6-51c1-4c7e-ab21-4da2a3bbd681@linaro.org>
Date: Thu, 28 Dec 2023 10:01:23 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 23/35] target/arm: Implement VNCR_EL2 register
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20231218113305.2511480-1-peter.maydell@linaro.org>
 <20231218113305.2511480-24-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231218113305.2511480-24-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 12/18/23 22:32, Peter Maydell wrote:
> For FEAT_NV2, a new system register VNCR_EL2 holds the base
> address of the memory which nested-guest system register
> accesses are redirected to. Implement this register.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/cpu.h    |  3 +++
>   target/arm/helper.c | 26 ++++++++++++++++++++++++++
>   2 files changed, 29 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

