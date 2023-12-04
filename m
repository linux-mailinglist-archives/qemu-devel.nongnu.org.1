Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E4F8038C3
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 16:27:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAAqO-0004dl-Nw; Mon, 04 Dec 2023 10:26:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rAAqK-0004U9-D8
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 10:26:44 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rAAqI-00066l-U9
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 10:26:44 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40b479ec4a3so45636435e9.2
 for <qemu-devel@nongnu.org>; Mon, 04 Dec 2023 07:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701703600; x=1702308400; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uwwu+BKOuZEzElf9a1WXAQF0FIQMm/WMUwYay9A2h4Q=;
 b=ZIA8x265O0XQb45sPa0KP1cCnrBU2f63ypI20ci6USqNNr31vA+Y43vKQkc7RGL37p
 5zDapfvLoMTAzG3DET8dUB6gVY80HiQnKIgb+MDN9RbebFQu1ANRpgffF7b+ZhbPB7BQ
 uo8mP0Teol6HrPtIi3J+rsCA5xrQSr1Icm9A4d5JGi0PjFcZJl+IaJsaTYRuSmZsu8RS
 74PP4LSl0M3hhpnQVL4tLWUjMUo4tM03xSBCleE7VzWkPIoAKqccLXnjxhvUn2nfYnnP
 ubL6pKrC+f+tFHja/7XdKqtPamX6L4ocId79Us5dOdKZXX0EfAAgFkdZqUCPWkytP5+3
 RXFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701703600; x=1702308400;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uwwu+BKOuZEzElf9a1WXAQF0FIQMm/WMUwYay9A2h4Q=;
 b=nruDYM32TyW95wxvaUnSLvzhQzBcgXRHw9sHB/KCIThZG230JB+Li3UFQuNS6MBF8Q
 lTiOWLvW5oiUQFlxPF3WwiTP11KHFHWAkYY7jOh7w0IF2iSLscV1XOh4gnY1dMM/EGuR
 TqyN+iyzU6DX4CyUjNiWvJ+ms7fBlW5vT9uTJAsoLhL8SFfgtpXqhXxDkjY8Uv88Ow1/
 66yIRCzHAEWuwOpajQ/ElGxEBlG8O1Q+07AcweHpsweaYrU2RAomkGoBgkRjOGyclSJE
 BAAa7VTAdZe2B0rmyk2ggbPPgMgzMIbDMYBT3jk+ohN5CGypIDXDid17wbnXzTlhng5g
 c6Dg==
X-Gm-Message-State: AOJu0Yy+FXmQp4r2X9CgemM4ck5AACFaJFqVJ+dC1sDZ6jFEJs75RRMr
 /DGmxuM2e4t5Q8pZNriaSNG3nQ==
X-Google-Smtp-Source: AGHT+IE1jW3YgQ1w8H6U1Bv1T1RNjImov0Hx/BTyXX0goeFb3l6hkrufs8VVNZhTRQzoz6AwgSRmxQ==
X-Received: by 2002:a05:600c:54eb:b0:40b:5e94:e2dc with SMTP id
 jb11-20020a05600c54eb00b0040b5e94e2dcmr3119141wmb.86.1701703595614; 
 Mon, 04 Dec 2023 07:26:35 -0800 (PST)
Received: from [192.168.69.100] ([176.176.140.35])
 by smtp.gmail.com with ESMTPSA id
 m8-20020a05600c4f4800b0040b37f107c4sm15390842wmq.16.2023.12.04.07.26.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Dec 2023 07:26:35 -0800 (PST)
Message-ID: <4a9cbc08-ced7-47d2-ae4c-49b2c6851666@linaro.org>
Date: Mon, 4 Dec 2023 16:26:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] tests/avocado: mark
 ReplayKernelNormal.test_mips64el_malta as flaky
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
References: <20231201201027.2689404-1-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231201201027.2689404-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 1/12/23 21:10, Alex Bennée wrote:
> I missed this when going through the recent failure logs. I can run
> the test 30 times without failure locally but it seems to hang pretty
> reliably on GitLab's CI infra-structure.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   tests/avocado/replay_kernel.py | 3 +++
>   1 file changed, 3 insertions(+)

Thanks, queued in misc-fixes.

