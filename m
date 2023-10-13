Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8012E7C87E1
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 16:31:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrJCO-00076O-Qt; Fri, 13 Oct 2023 10:31:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrJCE-0006wy-Ud
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 10:31:24 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrJCB-0008Ns-Ez
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 10:31:22 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1c9d7a98abbso17536835ad.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 07:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697207474; x=1697812274; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KfY6lMJTV5y2sR7PQFWEBdwMIg00nzagWBLk5pSHkhM=;
 b=kOx80hsVfOiW87flFuK+5Cbnc+mfqXOsvxQZEVFOelJfYqRbEdv0xQnzyKGgHhIV7Y
 FBgYVhgl2GxmOmAZ6Up6BenG9DlPnFPBwzdaSl9wkZfZdhYs/mvo0uLPedzgKihNpiy3
 k0LVKBy6NRX27292wvngMPkZjRVo0a+pAu9TlVgRZY9Z8NLv0WIRqKEQzHRRQOughVcx
 VJMtFg+HIwJhzdyCcAvxk7qCjxGiOHUEWYei9tTp2TObVL9LcNkhngZ30tcshOKJlY29
 1C4Ot5i4514rffJhRMdjDknz2u/U3HomUjhmpokQVbX+h0KPBSPUEg5OPHG++fgBmxrk
 a3bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697207474; x=1697812274;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KfY6lMJTV5y2sR7PQFWEBdwMIg00nzagWBLk5pSHkhM=;
 b=wBkhmk0J5uIXoo8OtwTScqg3iMBh3uTQsWCOuIgmglau7eawqVgNPiTa0nNQvu2eck
 jDpDbb7xv3PEALTEfSnDk3LdfwBZhxpDgvJChdlPz3q4X0nPl6vAAEBBl15K9OxsaHT8
 l0pbG+by2IVXDYmAz2fqQqLpqNbD2MULgS1c9ZccOIYmYbDw/5PBWAoO6MZlCxEVlwK8
 Sz4gFfPCzDGBfUlPh17wbrFeaGWHm6ombSp5swoFqJzvs3QpOAJM1LKaQGXHMiYuzI2T
 J7rDekp7I+TA8OZD047G9sDe28o82B0cxnhVzlesISpa8EIcIsq8cZhGjR7iSRjbBJHj
 35DA==
X-Gm-Message-State: AOJu0YyHBhPsj40T9/lYU2uJsXAD2DSSX3l1AcTfNDzGyCcZHBzHH/fZ
 Nf317XVP8jQHOjNtpZj8/+QOPmhwrI1oC/gnEBE=
X-Google-Smtp-Source: AGHT+IG8A8cRb6/o/M+3fAiaaACVYFCtJS6Ykd7LV7vT09vKtIuKvV1K8jeZlCDWAHy9b/V2IzqS4Q==
X-Received: by 2002:a17:902:f683:b0:1c9:e830:160c with SMTP id
 l3-20020a170902f68300b001c9e830160cmr3714585plg.16.1697207474254; 
 Fri, 13 Oct 2023 07:31:14 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 e7-20020a17090301c700b001b3bf8001a9sm3958048plh.48.2023.10.13.07.31.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Oct 2023 07:31:13 -0700 (PDT)
Message-ID: <194edc32-25cf-4a8a-ae31-f3af583d3355@linaro.org>
Date: Fri, 13 Oct 2023 07:31:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/16] target/openrisc: Declare QOM definitions in
 'cpu-qom.h'
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20231013140116.255-1-philmd@linaro.org>
 <20231013140116.255-11-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231013140116.255-11-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 10/13/23 07:01, Philippe Mathieu-Daudé wrote:
> "target/foo/cpu.h" contains the target specific declarations.
> 
> A heterogeneous setup need to access target agnostic declarations
> (at least the QOM ones, to instantiate the objects).
> 
> Our convention is to add such target agnostic QOM declarations in
> the "target/foo/cpu-qom.h" header.
> 
> Extract QOM definitions from "cpu.h" to "cpu-qom.h".
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/openrisc/cpu-qom.h | 22 ++++++++++++++++++++++
>   target/openrisc/cpu.h     | 10 +---------
>   2 files changed, 23 insertions(+), 9 deletions(-)
>   create mode 100644 target/openrisc/cpu-qom.h

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

