Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 628BD7442D2
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 21:41:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFJzI-0007SH-PW; Fri, 30 Jun 2023 15:41:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFJzG-0007Ng-R0
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 15:40:58 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFJzF-0008VN-2I
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 15:40:58 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-3fbc0981756so20114455e9.0
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 12:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688154055; x=1690746055;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/ET0t9ocInYE5lPcMDCA+Xip7b7793CQYxXRvJWVVB0=;
 b=evNInPKarI+ti7Uvkw1slob5r2gCqrSHj1Ik+tLjXBk5Hmu3p3INm+GHcHj0/G9Ukv
 fUPX9OBS33P8sHd675csLMk+cfdHOsTiDVUS3AtDssiOqDeyXYebtrE+M0E3SMPvMeaF
 BQtfdJ6RaO7Vvy7fPsmdxQzFyUNMaf4eoYd9V3iVQROoCrZ71XkXGtPxLO5FaPY1gQYA
 uu7WAkvME3jU+fSmPnogsCmMCskQyOJZJ/lykUYmYsK67D+K0S6ylEn7HsZzjHmse8p/
 fIvDcPoSHbA+YTrI5DsWWUSt7ZOe2qJmJfruSmPeDtc+mZv9f1wlGazbAz9Ej8lXi135
 RGbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688154055; x=1690746055;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/ET0t9ocInYE5lPcMDCA+Xip7b7793CQYxXRvJWVVB0=;
 b=OB9ZC+9nQMLeuwTQKUKKB/CtnJys0DNQ0CLP3AMazLTnjHD/t7qDSrUn3aLMbMlu1E
 EF+YjVmHn/2v5Ve5WZNo16HzESo3+fb/Pke9JV5yphqoFwYLJDWPJRcJD1BZJpfp5mnU
 aRGkSYT7RcGi0NN3wr+2dFvD8iJ/HGrJH9RuqqwlJSC6NaNMpmS84Hd3cpPKIr4xpSgJ
 ci5XKYJw5mzxaH+suczActuQv/QJ5cgLdfrorj7DOxMQrraMHEaeSsb+Ws04xZgT0Iuk
 qTchQxL5WtrJJUfHYhh4bf+EintQ7hH2G22df5SN8cPFh1NEl5dc0zlDeb9hXtyI6gUc
 uUHg==
X-Gm-Message-State: AC+VfDxSwZP4yWDE1PG3QmZxIThQUrgyxuuLIw9FICLnl3YgACxu8mYo
 TpHASsdR4hOwPePxnGsVyfvKGg==
X-Google-Smtp-Source: ACHHUZ6y8nFoo1gEi0OSkeCRQTNOxLhj6Sb1tjfV+25lQ4bzeXrLXCa6PWC0LoXI6W1Z19wdsrFPVQ==
X-Received: by 2002:a7b:c353:0:b0:3fb:b70f:fc21 with SMTP id
 l19-20020a7bc353000000b003fbb70ffc21mr2849907wmj.35.1688154055064; 
 Fri, 30 Jun 2023 12:40:55 -0700 (PDT)
Received: from [192.168.1.208] ([139.47.41.96])
 by smtp.gmail.com with ESMTPSA id
 z12-20020a1c4c0c000000b003fa9554fb30sm15313544wmf.44.2023.06.30.12.40.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Jun 2023 12:40:54 -0700 (PDT)
Message-ID: <07f8c33c-8652-7913-8710-008f491cb3b8@linaro.org>
Date: Fri, 30 Jun 2023 21:40:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 08/24] bsd-user: Use page_check_range_empty for MAP_EXCL
Content-Language: en-US
To: Warner Losh <imp@bsdimp.com>
Cc: qemu-devel@nongnu.org, mjt@tls.msk.ru, laurent@vivier.eu,
 Kyle Evans <kevans@freebsd.org>
References: <20230630132159.376995-1-richard.henderson@linaro.org>
 <20230630132159.376995-9-richard.henderson@linaro.org>
 <CANCZdfqreYmDeAtZv=y2kke1H7xdU3Pi6jKKNKCE+i6WkAfq2w@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CANCZdfqreYmDeAtZv=y2kke1H7xdU3Pi6jKKNKCE+i6WkAfq2w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x332.google.com
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

On 6/30/23 20:46, Warner Losh wrote:
> 
> 
> On Fri, Jun 30, 2023 at 7:22 AM Richard Henderson <richard.henderson@linaro.org 
> <mailto:richard.henderson@linaro.org>> wrote:
> 
>     The previous check returned -1 when any page within
>     [start, start+len) is unmapped, not when all are unmapped.
> 
>     Cc: Warner Losh <imp@bsdimp.com <mailto:imp@bsdimp.com>>
>     Cc: Kyle Evans <kevans@freebsd.org <mailto:kevans@freebsd.org>>
>     Signed-off-by: Richard Henderson <richard.henderson@linaro.org
>     <mailto:richard.henderson@linaro.org>>
>     ---
>       bsd-user/mmap.c | 2 +-
>       1 file changed, 1 insertion(+), 1 deletion(-)
> 
>     diff --git a/bsd-user/mmap.c b/bsd-user/mmap.c
>     index 565b9f97ed..07b5b8055e 100644
>     --- a/bsd-user/mmap.c
>     +++ b/bsd-user/mmap.c
>     @@ -609,7 +609,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,
>               }
> 
>               /* Reject the mapping if any page within the range is mapped */
>     -        if ((flags & MAP_EXCL) && page_check_range(start, len, 0) < 0) {
>     +        if ((flags & MAP_EXCL) && !page_check_range_empty(start, end - 1)) {
> 
> 
> Won't computing end overflow if start is 1<<32 - len? Then subtracting one here would be 
> too late.

-fwrapv, so fully twos-compliment.

So start per above, end == 0, end - 1 == UINT32_MAX.

See also the rest of the linux-user code, wherein I work with "last == end - 1".
Which has the advantage of preserving comparison order: start < last.


r~

