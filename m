Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B78787F19
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 06:53:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZOob-0006II-BB; Fri, 25 Aug 2023 00:52:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qZOoY-0006EF-Um
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 00:52:55 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qZOoW-0001e6-PS
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 00:52:54 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-52683b68c2fso794370a12.0
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 21:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692939171; x=1693543971;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hbfzkN1qjTsE4T+Lt82/wSi6Q/yIxr1PTc3IIdoFbXI=;
 b=M5fyec0iaoaQBqZw1WJhz7lwbFzRRCOfPqYdwufeVJG9XjMvcLPU4jNIbH700NB5V7
 jXUMKAjetAQaiDWxDu2RvkgbrP+Mdy6gRbY4tYaADELYVqCbmixJCuMT0lfKjEJgHEW9
 cIlFz5g8Kl7c91VzG04yhirbhp251lNi6Zjm4a0/W9bHgGEMaYNoCUsIei+gqjqSulUC
 ny7qqFAdsxAAXTn3qAscavGWSlPjnGHSNs8cpwlkpZ5TKvMKAhm429D8uHUtqqWJB83V
 iZxVFMW408sybRafKpC2KZ+1TndWxDboOvbwjZZSbas2P/FtRiQd/qpjF14DPNQImXD9
 GF4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692939171; x=1693543971;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hbfzkN1qjTsE4T+Lt82/wSi6Q/yIxr1PTc3IIdoFbXI=;
 b=RyrNemks2NREZ2GfJ6EIOGVMXjvhzood8VitpJA/mWhJqcW5uAjXopTp7wGZFOAjfW
 afZG0tlbPQmVf0YnL/6mK7/+G9e4dYH0ajiUgI1/G5VwotK919p6ZtYVCGuJm9E6qgi6
 QQbhpMOcdcxhJqPHwO8A85xo4Jd88Ie+hRgcHlDBZvcogv4wr6E7t9BUf+w0TzuMAhia
 RlNUaVtiKTwHrl061GXU0XphfjKVgU8AXQUyznZA0FlCspxasGjXq4jJolRDqrAwAdoj
 MsJGLk8JGZCQgFBTeX+2VMxHT+Q7Usf4qwahwheiBr5Oueht5wo1pxehqJ1LP8Dxkvht
 s5PQ==
X-Gm-Message-State: AOJu0Yy6fNMZ59CCh3e9z4MXz5iUZUtW6UJZ13vdZZxP+HDEGuh2mdHs
 Ij9cl2KFi0Qxi1vp6MXJoqlh0g==
X-Google-Smtp-Source: AGHT+IFvyHQecnvbiq+X3vBJurcuKoggCnDqMGofWjr6tQypNLzBUAc0Wlrm3SilGFO373L+JAGncg==
X-Received: by 2002:a05:6402:398:b0:523:2e30:aaee with SMTP id
 o24-20020a056402039800b005232e30aaeemr12203214edv.32.1692939171195; 
 Thu, 24 Aug 2023 21:52:51 -0700 (PDT)
Received: from [192.168.69.115] ([176.164.69.26])
 by smtp.gmail.com with ESMTPSA id
 x11-20020aa7d6cb000000b0052284228e3bsm561290edr.8.2023.08.24.21.52.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Aug 2023 21:52:50 -0700 (PDT)
Message-ID: <f49f0020-c860-96be-0b18-dbcdcfe7a465@linaro.org>
Date: Fri, 25 Aug 2023 06:52:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH] tests/qtest/netdev-socket: Avoid variable-length array in
 inet_get_free_port_multiple()
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>
References: <20230824164535.2652070-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230824164535.2652070-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.919,
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

On 24/8/23 18:45, Peter Maydell wrote:
> We use a variable-length array in inet_get_free_port_multiple().
> This is only test code called at the start of a test, so switch to a
> heap allocation instead.
> 
> The codebase has very few VLAs, and if we can get rid of them all we
> can make the compiler error on new additions.  This is a defensive
> measure against security bugs where an on-stack dynamic allocation
> isn't correctly size-checked (e.g.  CVE-2021-3527).
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   tests/qtest/netdev-socket.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


