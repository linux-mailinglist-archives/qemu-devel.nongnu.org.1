Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E94793965F
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jul 2024 00:16:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW1JP-00036S-SL; Mon, 22 Jul 2024 18:15:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sW1JN-00035N-Kq
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 18:15:17 -0400
Received: from mail-il1-x134.google.com ([2607:f8b0:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sW1JL-0001dF-7H
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 18:15:17 -0400
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-397052a7b63so19020655ab.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 15:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721686512; x=1722291312; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9bm5ZHfIENt33oX18YmEAbA4/5twgdpC+ydOn+Iec70=;
 b=y24a1l9eo2qYVfu0x6P+vH5W2bY91iIjGZl9B9tPFnSRz1jPv4r3bQ6y+hwuCLk1g8
 Rci1P/NeBtjrVM5P1sNE0xUFSdwm7yjiezRsL63EIA4b4FaCTR3680iz4DUqIPgZXkmU
 5RX9rihcXy6NbB6fTwXHtN14EOA3QBDghUkeuJ+pld9n3k7xQG8KPNhZB/WrI0MXcv7O
 NIPG6p6MqHzmukCskr5DXJ+LDQqnypMqoMkvHfXFxkvCpzNpwagKpSKT6vbnXp1TaUP8
 NClVpp+eQDZkWaTsmwuILiNLveL7G7PwSDDMfUsQbeAV7NGVHEa27BwlluuSMlqONpxV
 raig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721686512; x=1722291312;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9bm5ZHfIENt33oX18YmEAbA4/5twgdpC+ydOn+Iec70=;
 b=KYqOI3BHvUBmg7wWJu2Qzw2eDFkLDv4VwM4S82sXZZzT+291ozKgr7xV0B1lP5yNk0
 6H7dOREdCXNb6NTdRNyOBKgnp1llVZry8cxkEdFYpDz7iAUvfSi0v7XtpMtdBc141GSU
 7DoqDLwhkiXQ6hstErQiFKOaZ9d1H3kxVRPIq/oTNRKhOgAwZkcgwRGSTX9LN0y4RNQg
 ztCxIAGxY9089dnukKIyevbbnopbjii+L3w/HdrNc453J0nQcYBBPkhfWG8lqap0t7cf
 Z9yVg+OzmJMC/MIkjTVDSvGbY1WNeL2SrBaJ8xl7nY77+xFpDZQZhkKaGFa6ieHdv4PR
 5Uuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+wp/jl18Ie5XdOqkn9KlWcmbHRRWQJ2n0PTgeVR4KqQpNdar3pDrw3PmPJmaDZx9Ru5SkkVPlzonGqszdhav+deY4Go8=
X-Gm-Message-State: AOJu0Yxd2aYu2rK/bdiAPDwf2HNiOTFBkmVZEUvNsXUnNvl9zz6FTJLS
 chfwxXmFGDpbHLP2U+3vylFQvUvvqV9j1K59Gz7pu/9lp+8gL2YTQ8DxyFvSTnM63wkSBRryE6X
 vD7npjA==
X-Google-Smtp-Source: AGHT+IFcvwdq3Sg6NfrW3uGlfsPfibAyRboiz3kqHLG63j3dvXnhrSzOETUwT5o/5lbi6eeKkq3H9Q==
X-Received: by 2002:a92:cdad:0:b0:397:ebac:e523 with SMTP id
 e9e14a558f8ab-398e8d584f9mr95591115ab.14.1721686512139; 
 Mon, 22 Jul 2024 15:15:12 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70d1d998317sm3069050b3a.175.2024.07.22.15.15.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jul 2024 15:15:11 -0700 (PDT)
Message-ID: <10a16394-ac70-4cf6-b72e-b39749d64871@linaro.org>
Date: Tue, 23 Jul 2024 08:14:37 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] target/arm: Various minor SME bugfixes
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
References: <20240722172957.1041231-1-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240722172957.1041231-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::134;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 7/23/24 03:29, Peter Maydell wrote:
> 
> Peter Maydell (4):
>    target/arm: Don't assert for 128-bit tile accesses when SVL is 128
>    target/arm: Fix UMOPA/UMOPS of 16-bit values
>    target/arm: Avoid shifts by -1 in tszimm_shr() and tszimm_shl()
>    target/arm: Ignore SMCR_EL2.LEN and SVCR_EL2.LEN if EL2 is not enabled

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

