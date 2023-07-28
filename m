Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E46C676727B
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 18:56:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPQZ6-00051l-Le; Fri, 28 Jul 2023 12:43:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qPQZ3-000503-HV
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 12:43:41 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qPQZ2-0004zb-3l
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 12:43:41 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1bba2318546so19026565ad.1
 for <qemu-devel@nongnu.org>; Fri, 28 Jul 2023 09:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690562618; x=1691167418;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=J2cWrxy3mDioZjNZP55jW0gNtONdh912ipDvrvjKeg4=;
 b=iQ/c7JMCerbAoZ9pGq2FGAsRi34fZKJpT6MYQy0P6EsK7geEiI/8zgSt3rnq/9NUjX
 8T4vlLHxNHWakEi9zHGmXa7VtlmAtOCZPIiJRo+ap8COnYRzolmXOHTm5S7JFJVBinyF
 KHjGLA0RMHIwfaLV4GiABmfpYw2W4jFxF4Xl+roIDqeIg82ftx+UkYLrgzngm6NQ+YJX
 OjmcQ9pZb/QbI1eng6LLf5oSFD/WFhMks5K53V33v3buqIGGYc8IzF2jRHkoB3MMRXhs
 pheOZux+JxSo2dX1Zl78bm3XZ6HNYLsimIJL5rAW3fitgQgqJE/27pLFF6Qy4Xt3lIEZ
 bKrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690562618; x=1691167418;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=J2cWrxy3mDioZjNZP55jW0gNtONdh912ipDvrvjKeg4=;
 b=HjFtDx4qMr6GVnbCAjFSKLGh7GClugTHS+cVfQDJEUxVnaywAL0SD9Z8BFb5BSUrk0
 ySEvh4FabQ0v0LI/TctoyzRsTqa2y6wBsdh9/p3PpayUOuLI0aFisvv43v4dXs9A2SUm
 mBpodpWWYteMCGJQauQL0iGaKBId5oge0uVg9Dq+YjC9nJmX4gEn+dZ5mn8iR2OoFDfF
 0x8fODRTZsGQXI/jrnMAtpR7d55vNgLuo9nIWr31srT7dDAMaK64CZwKA4aAWrQDXI2F
 6EIyu9OpYha7viGcWWcovcoGPtAAgSqOGK2TOMHOxW+FfuFXksu15Cdnw+MxU1X2tWI6
 LObA==
X-Gm-Message-State: ABy/qLbE3zLUF/VPhPoNysbFeGsdnG9cVXeEbS/WJBBabAxS16xS8wmO
 B79wb4gFFfHACmIaLnIXTUHhog==
X-Google-Smtp-Source: APBJJlFABN2E8Qon8LHduX+wsOfHwH3Mua0TypRCZzvrnFEcndl1Dr9h3df0HlajdKW9LcdiGgTNhg==
X-Received: by 2002:a17:902:e847:b0:1b9:ea60:cd82 with SMTP id
 t7-20020a170902e84700b001b9ea60cd82mr2689519plg.5.1690562618656; 
 Fri, 28 Jul 2023 09:43:38 -0700 (PDT)
Received: from ?IPV6:2602:ae:154e:c001:cfba:2f6a:7070:67a9?
 ([2602:ae:154e:c001:cfba:2f6a:7070:67a9])
 by smtp.gmail.com with ESMTPSA id
 x17-20020a1709027c1100b001bb33ee4057sm3825087pll.43.2023.07.28.09.43.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Jul 2023 09:43:38 -0700 (PDT)
Message-ID: <14787dc3-66ae-e15e-0bdf-14ca53bff17d@linaro.org>
Date: Fri, 28 Jul 2023 09:43:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: assert fails in s390x TCG
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
To: Claudio Fontana <cfontana@suse.de>, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>
References: <eaec32e3-d56a-e6a7-fcbe-860948e79658@suse.de>
 <def2df0d-fb58-8e67-a0eb-7d646da3be42@linaro.org>
 <0e06f694-7aeb-66d1-48d8-317a93f8f741@suse.de>
 <6a3e8443-2d0a-451e-a481-cc26575d8211@linaro.org>
In-Reply-To: <6a3e8443-2d0a-451e-a481-cc26575d8211@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.094,
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

On 7/28/23 09:05, Richard Henderson wrote:
> It's the page containing both code and a page table entry that concerns me.  It seems like 
> a kernel bug, though obviously we shouldn't crash.  I'm not sure what to do about it.

Bah.  Of course it's not a kernel bug, since the store is to LowCore.
And of course LowCore is part of a larger page, which easily has other stuff.

Still trying to work out what to do...


r~

