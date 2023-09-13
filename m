Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B84379ED26
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 17:35:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgRsB-0004ND-Hs; Wed, 13 Sep 2023 11:33:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qgRs0-0004AD-Va
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 11:33:41 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qgRrx-000520-ST
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 11:33:35 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1c336f3f449so61115175ad.3
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 08:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694619212; x=1695224012; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xJMrqKZRUHk8/HtrhGEOXel85p0g+0Tehn58+TOL8pk=;
 b=K3TrfDYzfjRYR6SCSz5XLdsYkovguH6JJ4xnp+e1xhj2e2bBs6lYQi8wds8Wv4S4QF
 6yUcpg+gk5UZleGDAa9tmBUo45juSqDvcUwVpZEuS6eqvGODQxavAvB4WDkUEecDjw+h
 F1MV9Pbh7VDsBpUQc8UQh2cdr49eNqUJWwNBK0qSfvnaXnJq+FaI71O2+0orpHTKvaYB
 2GFQ3ZFHaaU0RkenGX0bC1/v3Yi75RFGYXw8gGi4gW3+IQKCu/uxx8c2plJDw/pRSDi1
 sf8RgrJGnne7ISHHEu+S6wdcSw0V6kS2BQIe+zjaL+bVnCqhdE9P/60EafGp566iUDT7
 neeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694619212; x=1695224012;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xJMrqKZRUHk8/HtrhGEOXel85p0g+0Tehn58+TOL8pk=;
 b=O33gRRCAb0I03X88C21phE8bzUDKqb8Ayk+EhS+x5WJHNDI3TbtlSAmEBpodmuqgjE
 pqHGaSKAcqDTwizPHQP25KdC5KEyLMd+t7vYBMjfrzqA1y4Mfr7KyhpQ05BZ24j/EMAb
 iNnG12eVO7Rk1FdPyhLJY/RCZ7n8gMSbbGBWL6eCad4SIxR2CUVpOvQa4hm8tjT89Tb1
 z691xjker9N0Pvrh+ghKujL0BmkmJmxLwdB3b3/eA302Z51c0wS+motqG2ovGizdhIxu
 qRe0TfUzKi0tueuQNhNq3kP/NlnUXMDhSCB0wRFP2KzqCqkL3GUtgIUmb4LyN8z2OZlK
 OjuQ==
X-Gm-Message-State: AOJu0YxDGQlr9CZAQWNk7M4neEZ2jhgnNGAQyJuu/Xk80pJYYkN31Y05
 MwWr7AQI4hGwLZYumXWIIZE9lg==
X-Google-Smtp-Source: AGHT+IFNcbr1qvY385MB/j9HIaEYMG3ZQbdeZjh8xCfrLv79ZdpDx7AdLqTqbf1qK95VL8LuC3voOw==
X-Received: by 2002:a17:902:e84d:b0:1b8:8af0:416f with SMTP id
 t13-20020a170902e84d00b001b88af0416fmr3494607plg.1.1694619212059; 
 Wed, 13 Sep 2023 08:33:32 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 w5-20020a1709029a8500b001bb3beb2bc6sm8405703plp.65.2023.09.13.08.33.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Sep 2023 08:33:31 -0700 (PDT)
Message-ID: <1231b992-7122-45a4-ca0e-0d1be57edb7c@linaro.org>
Date: Wed, 13 Sep 2023 08:33:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v3 21/23] bsd-user: Implement shmctl(2)
Content-Language: en-US
To: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>
References: <20230909193704.1827-1-kariem.taha2.7@gmail.com>
 <20230909193704.1827-22-kariem.taha2.7@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230909193704.1827-22-kariem.taha2.7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 9/9/23 12:37, Karim Taha wrote:
> From: Stacey Son<sson@FreeBSD.org>
> 
> Signed-off-by: Stacey Son<sson@FreeBSD.org>
> Signed-off-by: Karim Taha<kariem.taha2.7@gmail.com>
> 
> Reviewed-by: Warner Losh<imp@bsdimp.com>
> ---
>   bsd-user/bsd-mem.h            | 39 +++++++++++++++++++++++++++++++++++
>   bsd-user/freebsd/os-syscall.c |  4 ++++
>   2 files changed, 43 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

