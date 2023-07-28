Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 411747660BB
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 02:21:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPAwc-0005cz-57; Thu, 27 Jul 2023 20:02:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qPAwa-0005cq-7Z
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 20:02:56 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qPAwY-0006Nr-Ni
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 20:02:56 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-563d3e4f73cso875593a12.3
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 17:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690502572; x=1691107372;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IOWNs3M8Q7rxoijuf3VpUmwG0sB8W8o62na9Dm2jR44=;
 b=Ad6fsyghz2qVm3O+CYXLdSIrJDd6o0Y37SGnRNElGCBJ9iQ4SRHcnQs+I5aNyQ2pDe
 dtx71yLtVGjjaPLNk2eyUDQDNRMoznwZD1GZpByUDKGVNtby85lNgbDA4WeTEI2xsxco
 e3fdqvWflGftuMDdgD2Brb3u2C+9+AHWtFg9bIgIDFY+oEL55uSxdCyEHlxFj+mJCL/N
 lNoQxYi0fLeE+xUNwqVyPc9o9r2Q4tj4HGNSl3cML2FZc8KNgip6q0Upu61/g1C9rCXR
 O2sofZR9b6am4UBqJfvt/km6YerH0oPfyYf9dbJJ1mFyy96AQGD0NVJE0YMuDAV7alFs
 TB0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690502572; x=1691107372;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IOWNs3M8Q7rxoijuf3VpUmwG0sB8W8o62na9Dm2jR44=;
 b=UqHj1m20OrXlBeOPZZcxVvmyuYCc6AESsaBuBVWvcrJ9TeT38AwtjWxSbVeGOCF7Xj
 lREnCCyc6aBCcsJFgOJa/FcFEWWzeNtTms9dPM2/+mig2M7ITzi0zJkGHBtiy/PQfNTE
 apHAqJLc5xpBwkqSL+9gBdNpVH0ypn3PqfoLtxzn2KGr50H1H9pPYFIq3RRaWetwNJkl
 j/hY7tWNRDedVx7sa1nzMbbQljKHRvp6Myo1aK0y8XFH98l2fe/1B51t1qzTv+49sccZ
 KaKiNr2WM4jx9yYSdLj7tloZMwIL8V3ekKRi2Pv47dnNg4cNza0MhwN1DwHMM4cmudvq
 35XA==
X-Gm-Message-State: ABy/qLacci+jgmC+p/S6McU8L291dWdzmi3sQLah39P1IcCjtJV1zGKG
 ItqTuRNCWbOA3HxJvtDKWhARrg==
X-Google-Smtp-Source: APBJJlEHAmZOtPAiA3VJ+IvDOsf8U3QPrj7dm/UTSL0joR4kMTGeYM/tpL500BrnKA7enc3xgoUJHA==
X-Received: by 2002:a17:90b:4f81:b0:267:f893:d562 with SMTP id
 qe1-20020a17090b4f8100b00267f893d562mr79546pjb.8.1690502572490; 
 Thu, 27 Jul 2023 17:02:52 -0700 (PDT)
Received: from ?IPV6:2602:ae:154e:c001:943b:b6e1:1f00:9721?
 ([2602:ae:154e:c001:943b:b6e1:1f00:9721])
 by smtp.gmail.com with ESMTPSA id
 mg20-20020a17090b371400b00262fc3d911esm3249369pjb.28.2023.07.27.17.02.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jul 2023 17:02:52 -0700 (PDT)
Message-ID: <270f0cfd-b57a-24b8-7c13-789bb9ee13ed@linaro.org>
Date: Thu, 27 Jul 2023 17:02:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: avocado test failing INTERRUPTED for "Missing asset"
Content-Language: en-US
To: Cleber Rosa <crosa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Phil_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
References: <CAFEAcA--tJPhQO49W3BDO1MABQFHrr50MU=q54TFYpbkOxVWHw@mail.gmail.com>
 <CA+bd_6Krq9aCCQe01OjXxb+T-=3XrSnvVHrKs3F-3cwdZEGH8Q@mail.gmail.com>
 <CAFEAcA9txYV4GZQi-uRPWuXd1oOiVHB7ZUQ5-+=zA4T+Of-g1g@mail.gmail.com>
 <CA+bd_6LsQw3ao1KQk8Jk-VvAb9SZ1ioxSdBsghtNqJK-cnMRXA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CA+bd_6LsQw3ao1KQk8Jk-VvAb9SZ1ioxSdBsghtNqJK-cnMRXA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 7/27/23 12:08, Cleber Rosa wrote:
> Anyways, I'll look into, and report back on:
> 
> 1. expanding avocado.Test.fetch_asset() with a timeout parameter
> 2. making sure the newer implementation for the requirement types used
> by QEMU respect a timeout (they don't need to be smaller than the
> test, because they run completely outside of the test).
> 
> For now, are you OK with re-running those jobs if the servers stall
> the transfers? Or would you rather see a patch that changes the
> find_only parameter to True, so that if the pre-test attempt to
> download the asset fails, the transfer is never attempted during the
> test?

I would be perfectly happy with find_only.  From your description that more-or-less 
matches the behaviour of v103.  I would also suggest that if the pre-test attempt fails, 
trying again in just a few minutes during the test isn't likely to work either.


r~

