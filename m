Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 281487C7C6C
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 06:03:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qr9Na-0000B3-CT; Fri, 13 Oct 2023 00:02:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qr9NY-0000Ad-IG
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 00:02:24 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qr9NW-0005Ks-T1
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 00:02:24 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-27d0251d305so1114048a91.2
 for <qemu-devel@nongnu.org>; Thu, 12 Oct 2023 21:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697169741; x=1697774541; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lRzpVNUrD6iYnsyU56pg5uexnDjAhkYj9si0UWW1Oos=;
 b=OjtfPNnokvgsFm5xA/Tw6Hn61oLjkPXGlcUxdJNUbP0J2iS+HNRImNW/EEg8uAmcjN
 fMkxZEdzYoTateguyaqgBu2tfczsPZiFxPwmIQzAYxBwTOdzNjFuToOTkbV11t1NbFT0
 8M1RBLkW/fdFV0fCLU6dDFg+f+bDvhdxwH+LSOCYgbiqGaYn8jaby0Bkam0mE72M/pzD
 zBPgWVprGlvvuyS27kWW1sMUyQDk9ck0mPYo5SLsZ8/n2Y0qgk08G/FEWhfAvB6H24u0
 gBV0cFJLgvRBce/R0Qqb+TxwQv+2mGvXsgl02cuWhNpqoXvm1t1ZGDval/J7yoWmt8C0
 Xnqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697169741; x=1697774541;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lRzpVNUrD6iYnsyU56pg5uexnDjAhkYj9si0UWW1Oos=;
 b=KOzLS+qJGA1RgFscvMKRrxP+0ZZy+hZLLFmBhaRdVLzVv6StzoObFnRQ/wJv4TyghC
 zRqq6UntkUkmoPATun6QWU66Sf34fBWB7SeQfVESHHqq5PGwoziJTCLRaUF4kg+fbc1/
 647gRUxVS1wwHjrynltL7cs070ZSEp+esD5hA2nBgtuPuMv4sM1OeDp732jhlrJacuQd
 SYvGHv9MzWx5pxNU8eRu6gzCf0bGU5RBHsSrn816y32f8cUdKlX7LSSbIR0TlXPnh65X
 kxUzUMAMJyWp2IrFLRK+FWqTgND/rb4kde0eDjupzXpT9O2dq9hcmminjUUXeQKcXyLY
 zO9w==
X-Gm-Message-State: AOJu0Yxo1LF1eS0P9r9bET0+BT3B/cwrq94c3MnDlXu0613snSjkqtjx
 IEUuAAycbZ1yga5b29v21H++TJdE69EiQdiVVVM=
X-Google-Smtp-Source: AGHT+IE5qbMymYWRYTw3z84tSm0iWT9+wQxKpQJXDAHL+DUZTiAS3vmzT9a2uDxXIMJJX8lnqvS+ow==
X-Received: by 2002:a17:90a:5205:b0:268:5575:93d9 with SMTP id
 v5-20020a17090a520500b00268557593d9mr22388504pjh.10.1697169740935; 
 Thu, 12 Oct 2023 21:02:20 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 h1-20020a17090aea8100b002794fe14cabsm2604073pjz.12.2023.10.12.21.02.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Oct 2023 21:02:20 -0700 (PDT)
Message-ID: <b1594816-2735-4688-83ea-0838c8b040cd@linaro.org>
Date: Thu, 12 Oct 2023 21:02:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/18] target: Declare FOO_CPU_TYPE_NAME/SUFFIX in
 'cpu-qom.h'
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20231010092901.99189-1-philmd@linaro.org>
 <20231010092901.99189-5-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231010092901.99189-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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

On 10/10/23 02:28, Philippe Mathieu-Daudé wrote:
> Hegerogeneous code needs access to the FOO_CPU_TYPE_NAME()
> macro to resolve target CPU types. Move the declaration
> (along with the required FOO_CPU_TYPE_SUFFIX) to "cpu-qom.h".
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/alpha/cpu-qom.h   | 5 ++++-
>   target/alpha/cpu.h       | 2 --
>   target/avr/cpu-qom.h     | 5 ++++-
>   target/avr/cpu.h         | 2 --
>   target/cris/cpu-qom.h    | 5 ++++-
>   target/cris/cpu.h        | 2 --
>   target/i386/cpu-qom.h    | 3 +++
>   target/i386/cpu.h        | 2 --
>   target/m68k/cpu-qom.h    | 5 ++++-
>   target/m68k/cpu.h        | 2 --
>   target/mips/cpu-qom.h    | 3 +++
>   target/mips/cpu.h        | 2 --
>   target/rx/cpu-qom.h      | 5 ++++-
>   target/rx/cpu.h          | 2 --
>   target/s390x/cpu-qom.h   | 5 ++++-
>   target/s390x/cpu.h       | 2 --
>   target/sh4/cpu-qom.h     | 5 ++++-
>   target/sh4/cpu.h         | 2 --
>   target/sparc/cpu-qom.h   | 5 ++++-
>   target/sparc/cpu.h       | 2 --
>   target/tricore/cpu-qom.h | 5 +++++
>   target/tricore/cpu.h     | 2 --
>   target/xtensa/cpu-qom.h  | 5 ++++-
>   target/xtensa/cpu.h      | 2 --
>   24 files changed, 47 insertions(+), 33 deletions(-)

Seems ok.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

