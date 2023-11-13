Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D0347EA296
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 19:12:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2bOg-0001QW-JX; Mon, 13 Nov 2023 13:10:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r2bOe-0001Pu-Vz
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 13:10:53 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r2bOc-0007jN-3E
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 13:10:52 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1cc3542e328so34044405ad.1
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 10:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699899046; x=1700503846; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=G5/qOWZgkeSPPtH0EpFhTGO8tdIfjkfMdQotq8wuAKg=;
 b=hS5n4KQr5sMeMgNVQB9EPU6gPDwNwciJrmkOR/M6Xi+Ml96mUgZsrF0605zQEO7Z1B
 xmYHqkx1dCe+PhB/3EYYyndeHLA3FeD3H6nqysLaUK8qultyHWdd27sy8NXP2RvGyu06
 cZTOIZxFXCt7ShSBe0jmVPsZJTX42ybzreRXimLNeNZ/Dgc7ID+j493dtonzm9Gzz/5c
 Sd++yh9C1R1m+rkOOQV1WsR2EkWs90NFeKs59om9zCXKcr2W96QAU9Ou5xtsra4K92XZ
 xPN5nr+E3Iiyk/nP7fluk0bJtUzKHEXxf3ICU4VGXmRTHCbDjxIc9OKFSrZP6mQDAF2j
 bT1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699899046; x=1700503846;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=G5/qOWZgkeSPPtH0EpFhTGO8tdIfjkfMdQotq8wuAKg=;
 b=AGFFekXwzaQg5CQyLmpwfX2Gb1MgdUfBATy6jOUui8J46pRUnN/QVT9EAG7Facgibc
 FpJcEcG+FiFhUpVJQzWdZObXl9My7uEfgGnn48vuAOghbTHwRVkokCtmilFMrSBRudGh
 hJpvbPTryU0zU5bPLIidpwi4mU5pz6KA6ohWG5SRi1bmKOh+N0TGFpvizpXcC35WnXIc
 zn1J7vVpKgiV/dr8vjJip62HGn9nkjdZ6Hlwd73Xa+Oh+iX240PrC9puaRufaRoVsYEs
 PItB3JxzjnU1Uzc67LFhwKSdxvvXurmodJW2/zqqJ13Ww2Y5iG3SJGNOHOrcFUj/aU3J
 Rivw==
X-Gm-Message-State: AOJu0YwNeiG5kh8iaU2HwSxYDI8iNQjhQcKxb0ylpxibQmbXGC08xt3y
 KlbxC8hsQHA4nxdWRrJggyd5MQ==
X-Google-Smtp-Source: AGHT+IHUViJUi40vcCWJAbjeC1I6xdrwoRGcxD8HWAB7g1Sz2zxxUOjf7IqWCp/nkqVYvgGeqTiuOQ==
X-Received: by 2002:a17:90a:1789:b0:27f:fcc8:9196 with SMTP id
 q9-20020a17090a178900b0027ffcc89196mr5441493pja.32.1699899046448; 
 Mon, 13 Nov 2023 10:10:46 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 k9-20020a17090a910900b00280c285f878sm3923719pjo.55.2023.11.13.10.10.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Nov 2023 10:10:46 -0800 (PST)
Message-ID: <365f998f-b7e0-4f5a-bd75-177d23946e4d@linaro.org>
Date: Mon, 13 Nov 2023 10:10:44 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0 01/10] sysemu/xen: Forbid using Xen headers in
 user emulation
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Woodhouse <dwmw@amazon.co.uk>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>, qemu-block@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Paul Durrant <paul@xen.org>
References: <20231113152114.47916-1-philmd@linaro.org>
 <20231113152114.47916-2-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231113152114.47916-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 11/13/23 07:21, Philippe Mathieu-Daudé wrote:
> Xen is a system specific accelerator, it makes no sense
> to include its headers in user emulation.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/sysemu/xen.h | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

