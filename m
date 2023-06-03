Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B8A720DD0
	for <lists+qemu-devel@lfdr.de>; Sat,  3 Jun 2023 06:35:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5IyG-0001Jm-Of; Sat, 03 Jun 2023 00:34:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5Iy8-0001Ii-NA
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 00:34:24 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5Iy7-0001l3-5D
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 00:34:24 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-5341737d7aeso2511750a12.2
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 21:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685766862; x=1688358862;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=N3+cYHL/d1QLHxVtLFxgxb/vgS2D735h1RLgfm/L5nk=;
 b=f4xedw4YVZOEI4Ys9kfJb1OW5r6to54PowN0t9di2SalwkK51TizEj+h+IPzCvQ/Yg
 6MOaTtqOtPZODNGw9l0DDWcPbCSgDj6PYZ9XjilirTuNvixP/5u+mV4QiWbs/ll7s6+y
 m0D916MVNw99QDvRryg556bfTGEj/s4Hy6qQe1p3U/FuWbGZQeTmFNUQjbqbK+095dAs
 SDwETCOLX+LCmisqLWiqZkUVG+TF7N0Kptvga+KNNXww53Ug0ybhVgvcdq9Lwp5DZfju
 V91LMVPQ361lXzjkkSmMn5xseaHwhxgJre9gdX7/KNuJLxV0y/WIY58W4uKvFYs1cv+D
 2cDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685766862; x=1688358862;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=N3+cYHL/d1QLHxVtLFxgxb/vgS2D735h1RLgfm/L5nk=;
 b=eYkZsEIDWQckwFwtAdCO9rZ+X7X99f7FJ7rmKiD+yrhJc83M0j+wboHBMFE0aPtwAZ
 ax5g3eEJYtrWv2HJAO4f0+W3ILhnK7uitjXVxzx6UFaRQGlNBplRyN4uWoxYk50Aju65
 Ju7kv7L0SRFHGC3ZnZilTTHgmcDZeDeeTrgeXCC8pNYpBqrjE133M5yLOFsA6Mn9BF53
 IT26u9TTb6AgpNRsWsHfHdXI4/EvZd43GbkVl1v/4tr7DfRmIO8tq3zmlLjHpnxVHuWr
 CKLo6Ug1e/dIwI3ROMzKIqdMavAK+UWNzIMj1LN+JF/I8skCkvAEc/R02XxzaMNAgtD6
 YSPA==
X-Gm-Message-State: AC+VfDx/QVIClrvWVzlxHH9ToN3c1V6kyHJAzwhNmQHz/GSDvqh63Qow
 kQ7bny99gvmoyjr+aGMQx+5t3oANkuGZmbjr3G4=
X-Google-Smtp-Source: ACHHUZ4rbJjZo4nxtRg4/vY/C6QIfweDwnOpbiTNgsiU59lQQVZGiNmpM9oeA6Nk/p2FEZjVtO+DGA==
X-Received: by 2002:a17:902:9005:b0:1af:fbb6:23b7 with SMTP id
 a5-20020a170902900500b001affbb623b7mr1815426plp.3.1685766861661; 
 Fri, 02 Jun 2023 21:34:21 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:66a6:82c2:d794:68f6?
 ([2602:ae:1598:4c01:66a6:82c2:d794:68f6])
 by smtp.gmail.com with ESMTPSA id
 jj21-20020a170903049500b001ac4d3d3f72sm2128216plb.296.2023.06.02.21.34.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Jun 2023 21:34:21 -0700 (PDT)
Message-ID: <8a6feaa6-1c0b-0d22-129c-de1e01a67524@linaro.org>
Date: Fri, 2 Jun 2023 21:34:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 00/48] tcg: Build once for system, once for user
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20230531040330.8950-1-richard.henderson@linaro.org>
 <afdebaa1-6c7c-af7b-2e53-297576f10964@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <afdebaa1-6c7c-af7b-2e53-297576f10964@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.095,
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

On 6/2/23 14:25, Philippe Mathieu-Daudé wrote:
> On 31/5/23 06:02, Richard Henderson wrote:
> 
>>   133 files changed, 3022 insertions(+), 2728 deletions(-)
> 
>>   create mode 100644 include/exec/helper-gen-common.h
>>   create mode 100644 include/exec/helper-proto-common.h
> 
>>   create mode 100644 include/exec/helper-gen.h.inc
>>   create mode 100644 include/exec/helper-proto.h.inc
>>   create mode 100644 include/exec/helper-info.c.inc
> 
> These new files miss a license.

The old file from which they were split didn't have one either.
But I think there's no reason not to add

    SPDX-License-Identifier: GPL-2.0-or-later

to the top of each.


r~

