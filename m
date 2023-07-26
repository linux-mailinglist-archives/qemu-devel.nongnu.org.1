Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8EC763B7D
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 17:45:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOgMw-00085k-J3; Wed, 26 Jul 2023 11:24:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qOgKo-0006fg-VM
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 11:21:55 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qOgKm-0005D7-5e
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 11:21:54 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-68336d06620so6396354b3a.1
 for <qemu-devel@nongnu.org>; Wed, 26 Jul 2023 08:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690384910; x=1690989710;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jyFSn26+03PYKQzTN38TtIY6DBtGz4/lKos6BZEbKtI=;
 b=G4W4avAngWZ7HPW5KfhyhqVAeH5JjRRI0BsOlAcmf/4HNHQl8C0+RQhBrWy7xMD9Y6
 h0MmFo+0Q2uau8eC12rGkxe5eFkES65SLRIasIB/nQSZBU4WTjgIf95M+sjc6b+ksZjn
 CKCXurO3ozA5PQzBPrmmA9fSWCRDWbdKkcAGdDUN65zEcvCXPlkKivFN1g7XSXlreTnQ
 eI7adbO+gpzwR2/WbZBOEc+nLxWF57ZiiQ8JHn5wla2yOjiYbcXXx5gwH2ptI6XbQaBU
 LAQ2wpEFoRgdRbbuqhMfZJ7TscZrCoc3fLfliBNVj5ebGH7VITSGkShsZYHsFJGrwYDR
 dIng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690384910; x=1690989710;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jyFSn26+03PYKQzTN38TtIY6DBtGz4/lKos6BZEbKtI=;
 b=XVL51xukscKOrPTio9pxdrFepZE4ksxDFxX8gjW8ORqYVnKhtecb8B39O9eJXtZtry
 kQUeHvMEqiGooT84r0sNjBKHKnZi+QlPNF8UdcSukQ1qnqbDBXuNG9V50TeUOZGOUTnz
 t6apm4KxEXOdT1eG1JrLyKWAGhk+0Me3V6emfA++asX9n7n0cL2+yHF4OUOf+ySjKYK3
 t776H+Vqw6aN1VXWha4ihFDo3K7OSfNlxA0AjO/gBxSwb7xROcKlxDcRb21hbngs8dyi
 bUlfXIX5Fbtw0W/rj8U72skmxK9s4eK4XIwuTkfj32uQZKHV/RC70Veuo1jlCWTVJPGV
 l0ow==
X-Gm-Message-State: ABy/qLbR5bnqAvWyrNhfI6YZB5A0zVNf2AYdUE9iL0DTv0+s0UhvONVY
 tf2vf7jUQixAXbngBlygYo86cQ==
X-Google-Smtp-Source: APBJJlFsQk384mmp/1ZXOz/hgCGhHUo5NU5S6F/n/trPKc0ljwjRfghEkood5LqzN7FBJidp8XNDgQ==
X-Received: by 2002:a05:6a20:4d98:b0:133:83b5:c3cd with SMTP id
 gj24-20020a056a204d9800b0013383b5c3cdmr2651079pzb.53.1690384910199; 
 Wed, 26 Jul 2023 08:21:50 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:9456:37ab:20dc:17e1?
 ([2602:ae:1598:4c01:9456:37ab:20dc:17e1])
 by smtp.gmail.com with ESMTPSA id
 u6-20020aa78486000000b00682af82a9desm11921638pfn.98.2023.07.26.08.21.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Jul 2023 08:21:49 -0700 (PDT)
Message-ID: <9a05f370-1857-2c28-a184-a5197455b314@linaro.org>
Date: Wed, 26 Jul 2023 08:21:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] semihosting/uaccess.c: Replaced a malloc call with
 g_malloc.
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, dinglimin@cmss.chinamobile.com
Cc: Michael Tokarev <mjt@tls.msk.ru>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20230725080630.1083-1-dinglimin@cmss.chinamobile.com>
 <20230725090039.1271-1-dinglimin@cmss.chinamobile.com>
 <106cf02f-f746-e216-22be-8f7594028695@tls.msk.ru>
 <CAFEAcA-ErMrk60uZMu8M-0G15aTvhOZsYsvJD1F-YbLGOFDBYA@mail.gmail.com>
 <E1qOWH5-0002Du-U6@lists.gnu.org>
 <CAFEAcA8UdN4-DU4dAiY3VGLA77mLK-ohfFJs5+5fDt3v1mAAcg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA8UdN4-DU4dAiY3VGLA77mLK-ohfFJs5+5fDt3v1mAAcg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 7/26/23 02:43, Peter Maydell wrote:
> (Something went wrong with the quoting in your email. I've
> fixed it up.)
> 
> On Wed, 26 Jul 2023 at 05:38, <dinglimin@cmss.chinamobile.com> wrote:
>> Peter Maydell wrote:
>>> The third part here, is that g_malloc() does not ever
>>> fail -- it will abort() on out of memory. However
>>> the code here is still handling g_malloc() returning NULL.
>>> The equivalent for "we expect this might fail" (which we want
>>> here, because the guest is passing us the length of memory
>>> to try to allocate) is g_try_malloc().
> 
>> g_malloc() is preferred more than g_try_* functions, which return NULL on error,
>> when the size of the requested allocation  is small.
>> This is because allocating few bytes should not be a problem in a healthy system.
> 
> This is true. But in this particular case we cannot be sure
> that the size of the allocation is small, because the size
> is controlled by the guest. So we want g_try_malloc().

And why do we want to use g_try_malloc instead of just sticking with malloc?

I see no reason to change anything at all here.


r~


