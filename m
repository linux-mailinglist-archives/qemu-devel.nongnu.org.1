Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E351874D2D9
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 12:07:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qInn2-0002pI-7R; Mon, 10 Jul 2023 06:06:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qInmq-0002m3-Ku
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 06:06:36 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qInmm-0003DA-Lf
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 06:06:31 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3143b88faebso4929873f8f.3
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 03:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688983586; x=1691575586;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YTzpxqQ3tcZCyathxE1IsYFNxLxQSDOOexQYope2eqs=;
 b=bym79lapWd+0Zyy8XxJzIP7fyCspr3/J4surZAtKdVEfjRvI8h+xDdBM1CAIj/DJFO
 Sb0hGY8nEqstkvSVFamiEDSpX7TC6C8o7NWnxqUhCAkgvmBeXrvszGWwbUqf/riob/Or
 kgUfftwjhIQ9Oo0nAJ0H6N3n9rYychpHp+VucqYbJMZjhqHB/IR8ov9pJhZKuh3aEIdP
 FAmR1GFp0vNYyj/sTg+08b4fVcvYvj59zeTk6FlO+f9dfXHdW6XTEC6NpCXvDYLE3NDw
 54H0HBQmy205V3+JwAJ7AVhO3pbu6kaQrI/33Z3WwQaxsTbyL9L0a1Nb+oJ2ijKLB7sU
 sGpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688983586; x=1691575586;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YTzpxqQ3tcZCyathxE1IsYFNxLxQSDOOexQYope2eqs=;
 b=iMZuaE4/7qmNXhs9F8BaIXQ5+ZvnuOl2q7HT6Kj31yi1A6IFbwdhfme9LpeMDGOHW9
 VJZXLtj2wmt7SxwZyJ/8PWJ1uRPTCgiR9wA9XnWSTGN95P/WjylmirlRZDDFJd0+S+Dm
 O9qPSfViWR1qw1TLAqSaSy2dyysk7CqAiMYB0ePfgXzwBmZyVyt4E02oYGQ5j+9aOAkS
 bNyp8hq9zCakIGAJ4wwzRTES626ikgaK4lg1IJpPZkSsv5Ngd1M5asZ/HgaTaFJp0vAX
 Drjd19zabCe+EISPJfQJRpF9n+JrH8v7eU8KfatkyoW7sWlQ4Mf62Rf5DhGLhJhIinov
 rLYg==
X-Gm-Message-State: ABy/qLaJSYmLjatm1KonD3mP72NO669sdvnrgIVo5WmEx+AZ/yAVCr2Q
 6RvI40XqL5wqm2hO9RxsM68kgQ==
X-Google-Smtp-Source: APBJJlF5l7vEzNxca9/ndr6MlTs2MFlRwegaesLbGp7ScjPWEpibwgsD2uQQ3qTp4pvDor2yDZbfSQ==
X-Received: by 2002:adf:ee07:0:b0:315:a190:d110 with SMTP id
 y7-20020adfee07000000b00315a190d110mr329090wrn.28.1688983585966; 
 Mon, 10 Jul 2023 03:06:25 -0700 (PDT)
Received: from [192.168.229.175] (70.red-88-28-30.dynamicip.rima-tde.net.
 [88.28.30.70]) by smtp.gmail.com with ESMTPSA id
 o2-20020a5d4742000000b0031434936f0dsm11251899wrs.68.2023.07.10.03.06.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Jul 2023 03:06:25 -0700 (PDT)
Message-ID: <d12fc73a-1e8d-5234-9b3d-ad2005cff3db@linaro.org>
Date: Mon, 10 Jul 2023 12:06:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH] docs/devel: Fix coding style in style.rst
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: qemu-trivial@nongnu.org, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, Markus Armbruster <armbru@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Konstantin Kostiuk <kkostiuk@redhat.com>
References: <20230710092638.161625-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230710092638.161625-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 10/7/23 11:26, Thomas Huth wrote:
> As defined earlier in this file, the opening curly brace of
> functions should be placed on a separate line. So we should
> do it in the examples here, too.
> 
> Reported-by: Konstantin Kostiuk <kkostiuk@redhat.com>
> Fixes: 821f296756 ("docs: document use of automatic cleanup functions in glib")
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   docs/devel/style.rst | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


