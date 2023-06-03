Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C807720DCC
	for <lists+qemu-devel@lfdr.de>; Sat,  3 Jun 2023 06:32:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5Iup-0008S3-S0; Sat, 03 Jun 2023 00:30:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5Iun-0008Ri-LC
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 00:30:57 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5IuY-0000YV-8S
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 00:30:57 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-64d18d772bdso3255254b3a.3
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 21:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685766640; x=1688358640;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=r5gU9bRMA9Xu52Q9YnbzS7WE4PFlXjEtt2/hFHj+7sk=;
 b=KOaZJq8fc+MYXJTXcpcMvLh/McuaEfI7Jy+WGqPXhLNO0jmQg+xGvA0U9Jk0aQYyc7
 czUSWJncCl/nAA/wuPVJugaJEsNSsi99vgiZlu/RiaxQ6M8s9bSqg+xXVzhd8j5Jm4nV
 PnPgHAXkSsMRYK1AZQcmkDTPcRYWdlYuZChzGz7yRptp8EA9h+CaJjBIkrZrAglxctLz
 leYxq+xikfH9CFUxkGczAHR0UvNg0y3GDclGUALKsjss+mxMNxWce6N15NKU1SIRJMqH
 0sN3sRimpBJHteDSissal2Mj87yiY0H/Zz+uUGwiR/+F+1aI6s5qbbLHYDAIAzBWIJ3m
 73dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685766640; x=1688358640;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=r5gU9bRMA9Xu52Q9YnbzS7WE4PFlXjEtt2/hFHj+7sk=;
 b=EO1NcstSQfS8qS8UEc+W5DkAGscpxWT+MFD/8fsCImMS4EfVPBY79x4uQg3irWBROZ
 Yot9WQOcJIdz6dj5OuXOtALUuhqX4jyAKxVVh3R+PpTpSF3ZSMVMEypuNrQ/tBPEi1jm
 hFMfJQuPGgRzkfA8pJMm23x0fkCbXcqPg2Ije4gNapSIhCdx8wD6k0kh3qMy9b+YBL+V
 Sz2s1uRcfIEA5m/yQFnGvPhu8lZe1BHWEF/F8VFfhEpyhJ4uJt7OycC+fJZeTR2BMhQM
 Y3eklc3SAFmkH6hopO3JLJ0g8ebxCMOTmIIS8PSdUWb3yu5ynKIvK0ddqLg3dbrZMM4H
 sIiA==
X-Gm-Message-State: AC+VfDzoZcOz2x195jizMj8XPfcDWlmMX0LzRmA+C0gQnvFddvz5ILzF
 PJD+5w6+GEZU1aaGPpefbtFInROb6YJ9PMPqCec=
X-Google-Smtp-Source: ACHHUZ5KDSNwMGGa+2kPDOasRpAoi9/zw7MN1ZvvopSF2PQvbyt3HS02vksnW8lptJhtuDDX35iADA==
X-Received: by 2002:a05:6a20:7f87:b0:10b:5ce1:beb9 with SMTP id
 d7-20020a056a207f8700b0010b5ce1beb9mr773118pzj.33.1685766640427; 
 Fri, 02 Jun 2023 21:30:40 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:66a6:82c2:d794:68f6?
 ([2602:ae:1598:4c01:66a6:82c2:d794:68f6])
 by smtp.gmail.com with ESMTPSA id
 c4-20020aa78c04000000b00654930008dfsm260310pfd.105.2023.06.02.21.30.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Jun 2023 21:30:39 -0700 (PDT)
Message-ID: <9ee41f18-0b8a-d374-33aa-77181d25aadb@linaro.org>
Date: Fri, 2 Jun 2023 21:30:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 35.5] target/pcc: Inline gen_icount_io_start()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, Greg Kurz <groug@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org
References: <20230531040330.8950-36-richard.henderson@linaro.org>
 <20230602095439.48102-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230602095439.48102-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, NICE_REPLY_A=-0.095, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 6/2/23 02:54, Philippe Mathieu-Daudé wrote:
> Now that gen_icount_io_start() is a simple wrapper to
> translator_io_start(), inline it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/ppc/translate.c                 | 63 ++++++++++++--------------
>   target/ppc/power8-pmu-regs.c.inc       | 10 ++--
>   target/ppc/translate/branch-impl.c.inc |  2 +-
>   3 files changed, 35 insertions(+), 40 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Added to my patch set.


r~

