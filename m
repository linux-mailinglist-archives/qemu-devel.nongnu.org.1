Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 935F474DE16
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 21:22:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIwSE-0008Qm-Oi; Mon, 10 Jul 2023 15:21:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIwSC-0008NT-KB
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 15:21:48 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIwSA-0005mY-VB
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 15:21:48 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3fbc63c2e84so54416375e9.3
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 12:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689016905; x=1691608905;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hkLpf3okNxDLwWs28e7kGeNq6piwdo8WQ2zxSFg8Pt8=;
 b=Luydle6aFh10z2i/ULFOKnU6IYZZo4cn/JxNcYBIzpz2RwJaSqUj8hXriiOC8o/naC
 anDXoqwAJ2PMjhYJwkb2lCKuJxj8jusWJGrnvsMFNIDDxnBoT/7CdhppnCMnu4JrafUN
 KA3rxGjTDwBUqc5Qf0QGu5NMTAiKeF+pZst0IlENySLInCUdzGlnvDw4F0AzJIBOSN6h
 xZRUlos9g1/UmZ6Rffzavob+ucCgCuYYR5dVQqPe5b49GrGylFemitmg3LJ6jB/qnKX7
 p1AmV0Z/DhRI7ScHGw+NespuAy4gOpGgIoSuhuecASzDAI8mwQzRIwgbknhvNYKmO75c
 UhjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689016905; x=1691608905;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hkLpf3okNxDLwWs28e7kGeNq6piwdo8WQ2zxSFg8Pt8=;
 b=EquVSrUeq/oppeX4buBVPXms1uJHDyMEYVsYrsz7fm53dJq1M+U5cKryMHOBPgVpCL
 2gicBU/aM8B3pWa9xQ0TXOpNbEkqwxyiHOVyGtQIqAKM5zKgSZsQTVn6Vn9qHtPPNw7v
 2uJC3LB2kUnghAxIJAxJ1HttAZl9aLIS4jXZItDJPYtJsvqwHDOxj9bDZ2SPpvUMyl0a
 zCBfekMplaH7iHE8wi1ysXsOXTcuPlooUTyWBnOk/2Ufm/0rd0XlkHnzqy2x/O0hM9lJ
 Q0bMH/+MN1R/9i70BKkaVVoFhMHonXS/8/T815ODKh84kW2mU1bsj29l9OG9Ztaex7RN
 O7DQ==
X-Gm-Message-State: ABy/qLbuTJAiMB2r3xxBYFZKyDBGrhxirOe9AKarTy7WfGEXmqq7iA0t
 zJ15ry3jvbPnpJdzbyVpg8/WECyDIzFHmLswH4oP7Q==
X-Google-Smtp-Source: APBJJlH/ThG8wGkICTzuR+ac0+fXkHNSI9xNxtHAMd7SU+6dRXwBG04O7AirJ7brOY3mbg93KoJfEw==
X-Received: by 2002:a05:600c:364c:b0:3fb:b5cb:1130 with SMTP id
 y12-20020a05600c364c00b003fbb5cb1130mr13348917wmq.34.1689016905424; 
 Mon, 10 Jul 2023 12:21:45 -0700 (PDT)
Received: from [192.168.69.115] (mst45-h01-176-184-47-225.dsl.sta.abo.bbox.fr.
 [176.184.47.225]) by smtp.gmail.com with ESMTPSA id
 c18-20020a7bc012000000b003fb40f5f553sm11165125wmb.31.2023.07.10.12.21.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Jul 2023 12:21:45 -0700 (PDT)
Message-ID: <c364a4fe-d849-6173-2cda-3d9d413a65e5@linaro.org>
Date: Mon, 10 Jul 2023 21:21:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH] target/mips: enable GINVx support for I6400 and I6500
Content-Language: en-US
To: Marcin Nowakowski <marcin.nowakowski@fungible.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
References: <20230630072806.3093704-1-marcin.nowakowski@fungible.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230630072806.3093704-1-marcin.nowakowski@fungible.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.101,
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

On 30/6/23 09:28, Marcin Nowakowski wrote:
> GINVI and GINVT operations are supported on MIPS I6400 and I6500 cores,
> so indicate that properly in CP0.Config5 register bits [16:15].
> 
> Signed-off-by: Marcin Nowakowski <marcin.nowakowski@fungible.com>
> ---
>   target/mips/cpu-defs.c.inc | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Thanks, queued to mips-next.

