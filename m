Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E0817915BF
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 12:35:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd6ur-00052q-AV; Mon, 04 Sep 2023 06:34:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qd6uf-00050E-IC
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 06:34:34 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qd6ub-00064Y-Pr
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 06:34:31 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-51a52a7d859so4610442a12.0
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 03:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693823668; x=1694428468; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=t4WeJUIB3h4B9ENqbpR1l0GRNpSh9pA0Ed9HJWM8pMo=;
 b=yXDtg3ifa4XwQbpZQ3vCljdrPXsUtWZAcFVsJnU0EOE8dRb3XPtUuY0xSuHfqoQvuB
 OuiqUw9WlRhrZL2DU91Vq9RyauWy3le5ox+khTSPo27ALlKxEuaLTC1Bz2Qvi2npjIJ7
 dC2JN7BXwaux9NvXahgizKs0jcLv+4J7mSRrfWuuWIFPbrsXaJJz1rDPikcCGJfOyugw
 b09bpK0aBUajQ3p8BItbleqIVbSQ8gaEv2WTfxyO9pcJ8WKY/3B9cca9fBo1VVBZt74F
 OMCEBUI2uZoEr4LpHj+NqoV6yUR8o/rFdEXvrfd+h8WcevywoaULRa9pGHsAePJE7nfz
 nY/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693823668; x=1694428468;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=t4WeJUIB3h4B9ENqbpR1l0GRNpSh9pA0Ed9HJWM8pMo=;
 b=iZWEycCpd7TwYBUIwy8E67S8z7huqeNxkO0ZPwDZNdbVlvbWox2woTtWCEayvZeaWs
 hRV5JYFEfz9WdzVh3nJ7iFMTs3Z6DcfSz/yaKA7RMwwqQywjIld5BZESNNE7c81scM1W
 yycNO9PjZ/9w1x+HHmSAQ+p9Bj/RA6AKookLctDSJPMqpiCAj2kh1FgbcYHVttdgDqnr
 aAczkVA4nVb6OFqVVijYTCvac3+KdW5UyaFLu5IVPPhiEyyjK9ve1jbdKK+oBh6W+D7k
 LWAWgOVjQ5H3gDYML7ATC/NXLEcZGsU1QPiuZI1CHlCeORinYqNtiy0LQeri0DRYpvZg
 YxvQ==
X-Gm-Message-State: AOJu0YzfYukcioGLf65FvTZ+DvIiY4bWmEgGfTaKA6eDUAvgKefHp21G
 oRYDMSY/rTCR6uQDV7YPTAyEGA==
X-Google-Smtp-Source: AGHT+IFE4WCKubwLFg0Zz8Dn4lWv3LUBQzb2ZF+GspABjsArUPUEakvktnGWRCroMvMZ7SY3Uo6W6A==
X-Received: by 2002:a05:6402:3449:b0:523:37f0:2d12 with SMTP id
 l9-20020a056402344900b0052337f02d12mr10514414edc.17.1693823668047; 
 Mon, 04 Sep 2023 03:34:28 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.209.227])
 by smtp.gmail.com with ESMTPSA id
 v19-20020aa7d653000000b0052540e85390sm5602257edr.43.2023.09.04.03.34.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Sep 2023 03:34:27 -0700 (PDT)
Message-ID: <2fdf3391-bef5-7d86-d066-1f687cec1285@linaro.org>
Date: Mon, 4 Sep 2023 12:34:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [RFC PATCH 1/3] Python: Drop support for Python 3.7
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: jsnow@redhat.com, armbru@redhat.com, peter.maydell@linaro.org,
 berrange@redhat.com
References: <20230904095720.154738-1-pbonzini@redhat.com>
 <20230904095720.154738-2-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230904095720.154738-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52b.google.com
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

On 4/9/23 11:57, Paolo Bonzini wrote:
> Debian 10 is not anymore a supported distro, since Debian 12 was
> released on June 10, 2023.  Our supported build platforms as of today
> all support at least 3.8 (and all of them except for Ubuntu 20.04
> support 3.9):
> 
> openSUSE Leap 15.5: 3.6.15 (3.11.2)
> CentOS Stream 8:    3.6.8  (3.8.13, 3.9.16, 3.11.4)
> CentOS Stream 9:    3.9.17 (3.11.4)
> Fedora 37:          3.11.4
> Fedora 38:          3.11.4
> Debian 11:          3.9.2
> Debian 12:          3.11.2
> Alpine 3.14, 3.15:  3.9.16
> Alpine 3.16, 3.17:  3.10.10
> Ubuntu 20.04 LTS:   3.8.10
> Ubuntu 22.04 LTS:   3.10.12
> NetBSD 9.3:         3.9.13*
> FreeBSD 12.4:       3.9.16
> FreeBSD 13.1:       3.9.18
> OpenBSD 7.2:        3.9.17
> 
> Note: NetBSD does not appear to have a default meta-package, but offers
> several options, the lowest of which is 3.7.15. However, "python39"
> appears to be a pre-requisite to one of the other packages we request
> in tests/vm/netbsd.
> 
> Since it is safe to under our supported platform policy, bump our

Is 'under' a verb? This sentence is not obvious to me.

> minimum supported version of Python to 3.8.  The two most interesting
> features to have by default include:
> 
> - the importlib.metadata module, whose lack is responsible for over 100
>    lines of code in mkvenv.py
> 
> - improvements to asyncio, for example asyncio.CancelledError
>    inherits from BaseException rather than Exception
> 
> In addition, code can now use the assignment operator ':='
> 
> Because mypy now learns about importlib.metadata, a small change to
> mkvenv.py is needed to pass type checking.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   configure                | 8 ++++----
>   python/Makefile          | 8 ++++----
>   python/scripts/mkvenv.py | 5 ++++-
>   python/setup.cfg         | 7 +++----
>   python/tests/minreqs.txt | 2 +-
>   scripts/qapi/mypy.ini    | 2 +-
>   6 files changed, 17 insertions(+), 15 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


