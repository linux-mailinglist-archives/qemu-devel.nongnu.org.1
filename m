Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D95B7728ED
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 17:20:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT21A-0001KZ-PE; Mon, 07 Aug 2023 11:19:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qT218-0001KL-N0
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 11:19:34 -0400
Received: from mail-oo1-xc32.google.com ([2607:f8b0:4864:20::c32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qT217-0002MR-4s
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 11:19:34 -0400
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-56d455462c2so2166452eaf.2
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 08:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691421572; x=1692026372;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XQ2IGkxK9lhxr9cmcp68Q3htmP3auQ/alI+Ztg3C12U=;
 b=WopQhYTKA4aNWE7Yz6bjKIGH3XAuEmTwYcdHt8pjuU9B1aWFv8xhDIoeJvRhWv70SP
 /UM+gYLolPz2fqLhgWcFdKIat+QT12KPY17G8b9ReWiDyN7ypl9tjEA7QDT/i1i/gbPc
 s5wJ7DGkJ2SS9QHLb2IvvxcpLAcdReAC38bjlm4jqyWQlf8+Aq50Rc0v+PE66LZr5iEl
 cfAMV1JFaO70xWo9g2TPqDwtg0aXT/YoK6VvQTU3Gy4S7cBD0We5cmfBU/ygikFJMpA9
 tXldGrzatVO7LSGuCKTM3cRMGzV1oC83LNA6iNUqyQysLsPjXbWeau3Jh6SrxkFtWa1/
 1oIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691421572; x=1692026372;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XQ2IGkxK9lhxr9cmcp68Q3htmP3auQ/alI+Ztg3C12U=;
 b=aCvaURpwaK+x58VhkGH+JJX96mYxMMq6fXUw8U2HGL8AZN3CXHBHqQMlsLWFlXAPRa
 IWQiWXmN8Qr6var6HkwJ0ktAKp0Z72whub9qf6/Cp0W/JVRyvx3bkK4H1K12JWcel12H
 GQBGX7VgjYVyckHK9Sxge7Mmm69ADISiDTFzfolXb2SKmISkywQOWKxlRyxSEBojIrgq
 E0VR00X+/55byXhxKVXFaT1W5ncaB6KVloGB9SmaCyRLHoWk3jS3k5WiumK3OwpjHxSv
 Pig4cHmn8sgOCJQt/Be4yZCV+xd0sB+JDAY7/zubA/VcFLI+S7H6mBPuC5mcscapLUzC
 VAEw==
X-Gm-Message-State: AOJu0YwqINshxPHF7+Ttz4VQbX3PMaCwJ2RQ9F1NcGRhP7oesmWYzCll
 jOVXF4/G2ZK8DTp7Od/J0RqyEw==
X-Google-Smtp-Source: AGHT+IGGV6zreCXV0eKudWG7h2lZhe5e9k6eRVG+OT+FWK+WdxPZpavAKf/kdUOnBNE29khDPIAjNQ==
X-Received: by 2002:a05:6358:419b:b0:134:ce45:b782 with SMTP id
 w27-20020a056358419b00b00134ce45b782mr7141391rwc.21.1691421571781; 
 Mon, 07 Aug 2023 08:19:31 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:e306:567a:e0a1:341?
 ([2602:47:d490:6901:e306:567a:e0a1:341])
 by smtp.gmail.com with ESMTPSA id
 l125-20020a633e83000000b0051b8172fa68sm5191004pga.38.2023.08.07.08.19.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Aug 2023 08:19:31 -0700 (PDT)
Message-ID: <9c777523-1a95-fdbb-acf8-80345cd76289@linaro.org>
Date: Mon, 7 Aug 2023 08:19:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 3/6] target/loongarch: Add GDB support for loongarch32
 mode
Content-Language: en-US
To: Jiajie Chen <c@jia.je>, qemu-devel@nongnu.org
Cc: yijun@loongson.cn, shenjinyang@loongson.cn,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>, Song Gao <gaosong@loongson.cn>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
References: <20230807094505.2030603-1-c@jia.je>
 <20230807094505.2030603-4-c@jia.je>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230807094505.2030603-4-c@jia.je>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c32;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc32.google.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.809,
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

On 8/7/23 02:45, Jiajie Chen wrote:
> GPRs and PC are 32-bit wide in loongarch32 mode.
> 
> Signed-off-by: Jiajie Chen<c@jia.je>
> ---
>   configs/targets/loongarch64-softmmu.mak |  2 +-
>   gdb-xml/loongarch-base32.xml            | 45 +++++++++++++++++++++++++
>   target/loongarch/cpu.c                  | 10 +++++-
>   target/loongarch/gdbstub.c              | 32 ++++++++++++++----
>   4 files changed, 80 insertions(+), 9 deletions(-)
>   create mode 100644 gdb-xml/loongarch-base32.xml

With the test for LA64 vs LA32 corrected,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

You may wish to use a small inline function for testing the mode.


r~

