Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 215A1744568
	for <lists+qemu-devel@lfdr.de>; Sat,  1 Jul 2023 01:54:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFNw0-0006yP-11; Fri, 30 Jun 2023 19:53:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qFNvx-0006yE-1P
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 19:53:49 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qFNvv-0002ad-Ag
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 19:53:48 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3fbc5d5742bso16957775e9.2
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 16:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688169226; x=1690761226;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pXhLLHXQ1KVup8GB+XtnBbPqxEi+XkaHagDKifWpWnA=;
 b=cadCUbqSMSi7yS9wKwWsZUgcyhHqKslgpgJ7JV9yYIzvT0QQX6CO+JIdTQIrmaGhGt
 hmXHSyrDXGG+zZxCspjTsw94HuAsXSq8pgKCuA9/8NKZcgVBex+XjfKHcuk/QRZAUDJk
 /NjoA3yEwEl9t6K++fpzAvj5K4JqjuFsP/kJAplnL6Fm5yfCAYN7b+imzDyyiII6GQ0V
 rlg5q9lo4p3oupT7/CmB+hCgtr+msgHgHeG6kvsL2si2qxH9sqfIz3/Xy9aMO5Bl1Kci
 zk5FVPe+GP+VHGUiANoKLjHnn6CkMEP0XoYB6GYqYN9CKbQWyjsDX+QRlt8TZLawhzQ/
 O28g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688169226; x=1690761226;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pXhLLHXQ1KVup8GB+XtnBbPqxEi+XkaHagDKifWpWnA=;
 b=Vck+Nl/jtSsYKklYF1BF+ErXKX0zExN3snxY5d4/ia7wDr+taSmyBOADDXM+AGr1jH
 yNHqEGIyg4MCcHW13byEG2lYrEvav/V8VQM1ediqLn1/13pt3Bcc6cYACQ7DtyzYNxDY
 yJwGMeIw9p/HyKnUII9hHG9N/GB/RmR46p73jSECI+l7Ar9ZSzQl7942nyZQQyk9/Wjd
 ISfImwmvmmnke6X08BgXw6osPZUCgT0TPqc9cTAwbH2pPVowaKo+ofHXwxVDO1BKNAAU
 IAXSmiUewlSSYjvpjc3W1+lgiQXDRESQwlpCQUvBM39G2/Ck5aDrEJEt1XKnSMExtVg9
 siiw==
X-Gm-Message-State: ABy/qLbrMCFt3XHSPgE1luLVi9DuJ3GddamuwJWtLG7mhoJEi5+XjVcw
 xHJNryXZ6uNS3pbU7kh1/l1DkA==
X-Google-Smtp-Source: APBJJlHMb9z0Vjrkt0b06FctvLpBegVO9rt/9nDLqC04M3FPLasZCoTM15GxdcCq2qaCn/EnbXAPZw==
X-Received: by 2002:a5d:5549:0:b0:314:db7:d132 with SMTP id
 g9-20020a5d5549000000b003140db7d132mr3240459wrw.61.1688169225968; 
 Fri, 30 Jun 2023 16:53:45 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.211.104])
 by smtp.gmail.com with ESMTPSA id
 c5-20020a5d4145000000b00314145e6d61sm5567855wrq.6.2023.06.30.16.53.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Jun 2023 16:53:45 -0700 (PDT)
Message-ID: <bf6e3ba0-7625-9a12-b0a9-ee6bb1d1e247@linaro.org>
Date: Sat, 1 Jul 2023 01:53:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v2 4/4] accel/tcg: Move perf and debuginfo support to tcg
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20230630234230.596193-1-iii@linux.ibm.com>
 <20230630234230.596193-5-iii@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230630234230.596193-5-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 1/7/23 01:40, Ilya Leoshkevich wrote:
> tcg/ should not depend on accel/tcg/, but perf and debuginfo
> support provided by the latter are being used by tcg/tcg.c.
> 
> Since that's the only user, move both to tcg/.
> 
> Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   accel/tcg/meson.build          | 2 --
>   accel/tcg/translate-all.c      | 2 +-
>   hw/core/loader.c               | 2 +-
>   linux-user/elfload.c           | 2 +-
>   linux-user/exit.c              | 2 +-
>   linux-user/main.c              | 2 +-
>   softmmu/vl.c                   | 2 +-
>   {accel/tcg => tcg}/debuginfo.c | 0
>   {accel/tcg => tcg}/debuginfo.h | 4 ++--
>   tcg/meson.build                | 3 +++
>   {accel/tcg => tcg}/perf.c      | 2 +-
>   {accel/tcg => tcg}/perf.h      | 4 ++--
>   tcg/tcg.c                      | 2 +-
>   13 files changed, 15 insertions(+), 14 deletions(-)
>   rename {accel/tcg => tcg}/debuginfo.c (100%)
>   rename {accel/tcg => tcg}/debuginfo.h (96%)
>   rename {accel/tcg => tcg}/perf.c (99%)
>   rename {accel/tcg => tcg}/perf.h (95%)

Easier that what I thought, thanks!

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


