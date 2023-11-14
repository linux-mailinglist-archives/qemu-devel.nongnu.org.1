Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A570E7EB4F8
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 17:35:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2wNb-0002qh-7E; Tue, 14 Nov 2023 11:35:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2wNX-0002pz-Un
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 11:35:08 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2wNV-0007MR-4V
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 11:35:07 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5437d60fb7aso8828892a12.3
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 08:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699979703; x=1700584503; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Nmc4TDfSGmZzJN59GWwXuqyEv0UMAktVI+9IEfsf1J8=;
 b=AE/vml5qUKybmbNpbTR/VnbimWicBvxeOCBSU2MqNaRTtPDoMyy09bYfN4RxZlHZAy
 MmQm5rBDpCvDO1F+dMa8OLJ8BHeVX1DCpxeFdxZ764o0CAiBVQQFno6FruF/OkBcn645
 BCpLHnNMntp8aid3TKJmLHPO6RCcNSw8HhR4hQZVTU0Ae+w1Oxt2p4BS8GYPaLNR/oGJ
 XVarg/Awl7/wVM8+XLkZp2F4E+b7V6ZPvt6uCFObGYXZklrgMj4HXL9jgWPtR3t2+nZ5
 KMzDVe2ObgNVDYvewg6VIOI5GjSVSiB+VykL/WtgLJ1QGSRP+d8UPA4QR35x2d0eOCDZ
 Cviw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699979703; x=1700584503;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Nmc4TDfSGmZzJN59GWwXuqyEv0UMAktVI+9IEfsf1J8=;
 b=Zc357jltKHWqt9uK2LW+AsVO9nOjgbEmNnvqPX7sG0HDyUmnNtMeQiK+yUa8sHS0sl
 UUhWPfRhpuctBT5fCZNGO6KoS12/lvjyEJaDm05JP+cMP+6Ll+ivJw92YcGY38963eFZ
 JmwGtMLS8xjYwmhj9nSIo5kx5TT8+sn98ULjGtF1uJZoEJML1jKrHvTvRc2+ZnIu0/WB
 qhUBiSU5GEd6LkRAxQqX23V1fIMRP7D+1C2XcYvCw2KlgkEPdnIJbvxWZdSYiIqr8M61
 NoKIr+2Roa89pZU6RAEPQxpRZksKnqkUi1/qFORcFT4tcpI5Ou/iUrjMsmUGsT3hHetR
 v/TA==
X-Gm-Message-State: AOJu0YzLScHnYXJuH/0NgZ07zYdly1nm04+4AuN2WJyzmPS+atwHkJYA
 SPHTq4GnOKqJjdANjkHqEAr5UHCkYF7X00N/Au8=
X-Google-Smtp-Source: AGHT+IFWC9gK2SVELnoabf/vAVYu7Qtv4eJw03Y5OlJBS+/4BsnZ0aroyYSPMoFZT1ivRUS1omYz0A==
X-Received: by 2002:aa7:d5cd:0:b0:53b:9948:cc1f with SMTP id
 d13-20020aa7d5cd000000b0053b9948cc1fmr8032428eds.12.1699979703537; 
 Tue, 14 Nov 2023 08:35:03 -0800 (PST)
Received: from [192.168.69.100] (cac94-h02-176-184-25-155.dsl.sta.abo.bbox.fr.
 [176.184.25.155]) by smtp.gmail.com with ESMTPSA id
 x11-20020a50ba8b000000b0053d9cb67248sm5388374ede.18.2023.11.14.08.35.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Nov 2023 08:35:03 -0800 (PST)
Message-ID: <7d276a5f-2c13-4499-9315-2e49f8ef037f@linaro.org>
Date: Tue, 14 Nov 2023 17:35:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/avocado/reverse_debugging: Disable the ppc64 tests
 by default
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 qemu-ppc@nongnu.org
References: <20231114163115.298041-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231114163115.298041-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 14/11/23 17:31, Thomas Huth wrote:
> The tests seem currently to be broken. Disable them by default
> until someone fixes them.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/avocado/reverse_debugging.py | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)

Acked-by: Philippe Mathieu-Daudé <philmd@linaro.org>


