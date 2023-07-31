Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 514AE76930B
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 12:24:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQQ3g-0007SD-Jf; Mon, 31 Jul 2023 06:23:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qQQ3Z-0007R0-Ky
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 06:23:17 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qQQ3X-0006Ju-LL
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 06:23:17 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1b9cdef8619so26283635ad.0
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 03:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1690798989; x=1691403789;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=auzwPJ5W1ozZXffcuF3MVP4+P65KGexYdfpCTJfxnf0=;
 b=VZ/XL36Hz/JArAzfeRHtwEsM/PKEt9Ogly3+GOp5oxm/57QHxRX5y3EyNw03bzsPSz
 mcRofXZrPf7xkDfHNQ6d4vcfU0TtVSyZZJPTlpxTqLbj5LQk0whJbUwksnqrgpZUhG3k
 oc5yrsMV5EMwGl3vbCpYGfsnP88h3MDx9mIr2nvQrYm8lgPjliRv6Vo/w+Y0OrVYFrtv
 wc/dFS9cqQCX/7DsX8vYOcIUucET765yf+OcSdh/5+jIyttcDcCS7iSTG3J3g3zmHs0q
 65YJZ6kEJ8nxI+yDgnmGk7OPcEyx4wAOnuo9/COl9qGlf+mKgmr2L7b2GgL8MbT4wdd7
 pSWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690798989; x=1691403789;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=auzwPJ5W1ozZXffcuF3MVP4+P65KGexYdfpCTJfxnf0=;
 b=L5OcwwWw3go/D2vgIrffg+2AHn9f7p+qXiJD/a2oVaNcHs3lKJ2NJxq1iihEJKjgIM
 WD0qDfX6/uHv51tnGQ++8ZoKVwBGq6YcONWEAWi9qbRbo8mV6ZI1hxGFe7RuAzzxGB68
 GWS/f4L13/vbKp1LydJkEIFpc8d/qWNrPdqi36sYW5KgyfJqKuu+2o75xCeAE9wcZjdm
 fxakCtXx6jltDvnHqTGrmFrBNFoqBH+4YGo0FOY3A2JccrOwH1Fvewh0dBPvixgBNn2d
 La5voQgTfSmZvGT5ZgiFW3ts5SfpHVEDS3/uzoYFZewpdJB8ZCH4W05N/vOJQijDe+Z/
 BjLQ==
X-Gm-Message-State: ABy/qLaOVo7YexpjlnbiH3TBkjTB8ncjSb1wHJwfhe2rUPED7ZQ8rNAx
 kcvoDXKWhiydTir+9iZYcqNjFmuXhqOeNktbvbo=
X-Google-Smtp-Source: APBJJlGWXJIWfhilk3CfrqM32az0dWUXQdQkOrqf4XcO/FhL64Da3gqBDUBoHwYEPFArriabDpMKtA==
X-Received: by 2002:a17:903:230b:b0:1b8:17e8:5475 with SMTP id
 d11-20020a170903230b00b001b817e85475mr9513192plh.24.1690798989049; 
 Mon, 31 Jul 2023 03:23:09 -0700 (PDT)
Received: from [157.82.204.253] ([157.82.204.253])
 by smtp.gmail.com with ESMTPSA id
 b11-20020a170903228b00b001b895336435sm8187141plh.21.2023.07.31.03.23.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Jul 2023 03:23:08 -0700 (PDT)
Message-ID: <0643c953-bfa8-45a9-5b07-714bc18c03a6@daynix.com>
Date: Mon, 31 Jul 2023 19:23:06 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] linux-user: brk/mmap fixes
Content-Language: en-US
To: Helge Deller <deller@gmx.de>, Joel Stanley <joel@jms.id.au>,
 Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>
References: <20230731080317.112658-1-akihiko.odaki@daynix.com>
 <3088d223-64fd-9aab-3c08-000f0924607c@tls.msk.ru>
 <CACPK8XfcOkn281JZNYc7+AhDAxP_N9__G4Snxtx=ZhXgVChXgg@mail.gmail.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CACPK8XfcOkn281JZNYc7+AhDAxP_N9__G4Snxtx=ZhXgVChXgg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2023/07/31 19:17, Joel Stanley wrote:
> On Mon, 31 Jul 2023 at 09:31, Michael Tokarev <mjt@tls.msk.ru> wrote:
>>
>> 31.07.2023 11:03, Akihiko Odaki wrote:
>>> linux-user was failing on M2 MacBook Air. Digging into the details, I found
>>> several bugs in brk and mmap so here are fixes.
>>
>> There's another work in this area by Helge Deller, have you seen it?
>> ("linux-user: Fix and optimize target memory layout", a v5 already).
> 
> Applying this series fixes the qemu-arm running the static armhf
> binary on my ppc64le host that I reported here[1].
> 
> Tested-by: Joel Stanley <joel@jms.id.au>

Thanks for testing.

> 
> The changes conflict with Helge's patches, so it would be good to work
> out which of your changes should be combined with his.

I suggest Helge to rebase his change to my series. The below is some 
detailed explanation:

It is almost orthogonal to my series, but patch 2 will conflict with my 
series since it changes how the initial brk is calculated.

Unfortunately I think patch 2 has a bug. Without my patch, do_brk() 
assumes the heap is aligned with the host page size, but the patch does 
not consider the case that the host and target page sizes are different.

My patch makes the heap aligned with the target page size so it will fix 
the bug.

Regards,
Akihiko Odaki

> 
> Cheers,
> 
> Joel
> 
> [1] https://lore.kernel.org/qemu-devel/CACPK8XeyqcEDyyL3Jw2WYWs_gGdtTCf2=Ly04CMgkshSMdj7RA@mail.gmail.com/

