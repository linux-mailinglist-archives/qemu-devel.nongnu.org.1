Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F9B79096B
	for <lists+qemu-devel@lfdr.de>; Sat,  2 Sep 2023 22:03:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qcWoN-0001au-KB; Sat, 02 Sep 2023 16:01:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1qcWoL-0001aj-9f
 for qemu-devel@nongnu.org; Sat, 02 Sep 2023 16:01:37 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1qcWoJ-0002Bs-0k
 for qemu-devel@nongnu.org; Sat, 02 Sep 2023 16:01:37 -0400
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2bcb89b476bso2270141fa.1
 for <qemu-devel@nongnu.org>; Sat, 02 Sep 2023 13:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693684893; x=1694289693; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qIr/kl7MwjWViFTOLYqSvk6x7s4uHAWmcY9Rd8SKB4k=;
 b=bUEoIiZN9UzRb7HUSL5v16vJfFVG/5x/H0BOH9Dd/p/jWq+SA7Q57HkqAqWOQOaaGG
 TRYSkrn2hwuqT8WPbhVwDmizITc3VvZf6nljUUCEYDVe8GuKm3QDqISpb8tUTkwzI6O+
 e8IzmN3jN73aeN4atc7RtbHqqHcXCt8nReguUTmlWAB3A3Fzv1qn/zI33t+vUwwU3E66
 W0LhyEqx7csnDHfUf8I9aQz7DncwmY2TyVFUYaKKWLt3L5X1Sl3iVAIquvlfxly6ZhQL
 Csk7rgMIHxZfCBXW/iibF+0yZht7AiNzrRX6rJq/GBtBE9bSLUupDl142KhAkbkG+SBf
 s+MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693684893; x=1694289693;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qIr/kl7MwjWViFTOLYqSvk6x7s4uHAWmcY9Rd8SKB4k=;
 b=FAv3vPnLiXDxP6tmkhvE8PvdOrtW0QVfcqWQBRbM0ygluK+1BbQqaePZS7RSqZY2V4
 Ue+I+Na4vrtTY/UZTV2RO23EcEit+w2Yt+N+5OO7cBi1EQhc0Mjj0uIw28Lp6w5fgtC/
 ZGTiJgU4eIoXy+DaoTZcVe1EuaKo4RDiYuyp8E8b70H7ki5y2CxaskuMJJjV4ECFCU64
 YwW3PwMzeGyPd+xSVA+XybXxpZ7S7VrDPKk6tariFA58ra1MCMgqTZP2rqAFupeI/v+k
 7w4UxRv4WDEJscxxr4IhY2vnxj0Pyw2SbZqTz5yCMKR5N2qvexddZHMQd97qbiwFcskr
 ps3A==
X-Gm-Message-State: AOJu0Yx29V8UYVRgfbRcRckF4Fv79MFUxV/WBRIrf6hcwkjRoRGr722X
 zm2e6oMfKnhAs/2vLxu3RBr5qtPQknFV3hN8A1+RxQ==
X-Google-Smtp-Source: AGHT+IE4OVVeeSsKABKU1u1lN/Ym7sfAb6RHNUIKb76yzEsWVThbewgoHveURSgwRErqxbwS2jTmkQ==
X-Received: by 2002:a2e:87da:0:b0:2b6:9ed0:46f4 with SMTP id
 v26-20020a2e87da000000b002b69ed046f4mr4146286ljj.23.1693684892725; 
 Sat, 02 Sep 2023 13:01:32 -0700 (PDT)
Received: from [192.168.200.206] (83.11.188.80.ipv4.supernova.orange.pl.
 [83.11.188.80]) by smtp.gmail.com with ESMTPSA id
 s19-20020a170906455300b0098e0a937a6asm3780266ejq.69.2023.09.02.13.01.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 02 Sep 2023 13:01:32 -0700 (PDT)
Message-ID: <bcc0df2f-5fb7-41be-035a-210eccc5a495@linaro.org>
Date: Sat, 2 Sep 2023 22:01:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: /util/cpuinfo-aarch64.c:58:22: error: 'HWCAP_USCAT' undeclared
Content-Language: pl-PL, en-GB, en-HK
To: qemu-devel@nongnu.org
References: <8386D452-771E-4E4D-ACD1-F871BA458691@livius.net>
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Organization: Linaro
In-Reply-To: <8386D452-771E-4E4D-ACD1-F871BA458691@livius.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=mail-lj1-x22f.google.com
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

W dniu 2.09.2023 o 20:11, Liviu Ionescu pisze:
> When trying to build 8.1.0 on an Ubuntu 18.04 aarch64, I get the
> above error.

Ubuntu 18.04 is not supported anymore by Canonical. End-Of-Life was in
May 2023.

> The offending code in `/util/cpuinfo-aarch64.c` is:
> 
 > ```c
 > #ifdef CONFIG_LINUX
 >      unsigned long hwcap = qemu_getauxval(AT_HWCAP);
 >      info |= (hwcap & HWCAP_ATOMICS ? CPUINFO_LSE : 0);
 >      info |= (hwcap & HWCAP_USCAT ? CPUINFO_LSE2 : 0);
 >      info |= (hwcap & HWCAP_AES ? CPUINFO_AES: 0);
 > #endif
 > ```
> 
> The reason is that on this distribution the <bits/hwcap.h> header
> file does not define HWCAP_USCAT:

I would recommend either upgrading your distro or staying at QEMU 8.1
release.

HWCAP_USCAT was added to glibc in June 2018. As your distribution is not 
supported anymore you can also patch glibc in your system.

> I don't know if other distributions are also affected, my build
> platform for all xPack standalone binaries is Ubuntu 18.04 LTS.

I do not know any supported distribution release without it.

> I know that 18.04 is an old version, but I use the xPack QEMU mainly
> to run unit tests, and in some enterprise environments the machines
> used for testing are sometimes pretty outdated, thus 18.04 will
> remain the base build platform for a while.
> 
> It would be very nice if QEMU would still compile on Ubuntu 18.04, as
> it did before 8.1.0.

