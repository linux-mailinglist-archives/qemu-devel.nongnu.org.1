Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 23DB27B3BBE
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 23:04:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmKeM-00089j-DD; Fri, 29 Sep 2023 17:03:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qmKeJ-00083j-Qy
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 17:03:47 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qmKeI-0008Nt-55
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 17:03:47 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-277336b8717so7745491a91.2
 for <qemu-devel@nongnu.org>; Fri, 29 Sep 2023 14:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696021423; x=1696626223; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HJsj2SFHIBjE4N0RFqUdZ3ILYB4BdfGyg2Dnsj6U8P0=;
 b=isxlFU0NaK5baIqHlnsYi+fpvaNGBuOS+Nh1NxaBnkup9t8Ju15uo3ZZhslYJxksPH
 WsyK/tXZiMHoXooKo0DJNWD4pVPhSzQKopr1hluE6vwPcW/vodbAj+K9EAlS3jsi45xt
 kkPH4VMKvhZUuWydjv3ymflpCfj4MTGnbVc4c9crpPzoBymEzjsUL2Ul/7LeC8c9rMmK
 VpLZkC/iOm/bg2guJiXxtA8CQXSqfTlkVcSYn3lHoqzCemwNXFx5GcZd0KGgNW+Ppqth
 ihlRUEAgmfz1F/gxLlEHgiiUjta5BDAkeFnCIeiosVsuMhkPLRV7CYbKASEKFNljBYKP
 DOSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696021423; x=1696626223;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HJsj2SFHIBjE4N0RFqUdZ3ILYB4BdfGyg2Dnsj6U8P0=;
 b=uzOnIpc4hff6/otT0lOBXlTwa51/P9Cg/QGe9lt4g036uGv1i3zDBZTYuRUNuMqVpp
 QnDoHeA8qLB0Z0mEI1VJl+OYFhQH1R0M8qxg2+gvruQxarSHWCUbOySp2ZL0z4wFsAaA
 QWezoH8Ybssjv3+HCnpzr26wuuEMeEOD8E800KZCccgY1NVDQPyAMJOrml6O8BfIUUdX
 8+hCVz3vdPgCWgjxi3nGtUx7+pLpZgOK4K9GbyqG9/Ag4vnwOKU0UB1SipTGJDn7M22R
 3EhqLeIx6jWzOIQmbJoAI+sfYDwi6oM9sPjSsDUpvPO55h24IIbsr9d0WfHTFfQ8Vjmz
 EsMQ==
X-Gm-Message-State: AOJu0Yx4V/lWVfxjdbDaA7/bF4H5tNd1+53Zjv6E4b+tz0quBT6c1Gec
 rLHc95DFYaZ6zvuEznqm1xbw+Q==
X-Google-Smtp-Source: AGHT+IEkoPl7veGfXyEnBsiwGJWMRG32rCj5c9jED4q68MuTAMGgl0IGtBr9sDYPZK6WNLIHCSD3SA==
X-Received: by 2002:a17:90a:950e:b0:277:1355:f9e9 with SMTP id
 t14-20020a17090a950e00b002771355f9e9mr4681529pjo.22.1696021423116; 
 Fri, 29 Sep 2023 14:03:43 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 fw1-20020a17090b128100b00262eb0d141esm1901548pjb.28.2023.09.29.14.03.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Sep 2023 14:03:42 -0700 (PDT)
Message-ID: <1f52dca1-1458-7ea9-c0ef-6e24c120bee9@linaro.org>
Date: Fri, 29 Sep 2023 14:03:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC PATCH 04/22] exec/cpu: Never call cpu_reset() before
 cpu_realize()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20230918160257.30127-1-philmd@linaro.org>
 <20230918160257.30127-5-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230918160257.30127-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.295,
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

On 9/18/23 09:02, Philippe Mathieu-Daudé wrote:
> QDev instance is expected to be in an unknown state until full
> object realization. Thus we shouldn't call DeviceReset() on an
> unrealized instance. Move the cpu_reset() call from*before*
> the parent realize() handler (effectively cpu_common_realizefn)
> to*after*  it.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
> RFC:
> I haven't audited all the call sites, but plan to do it,
> amending the result to this patch description. This used
> to be a problem on some targets, but as of today's master
> this series pass make check-{qtest,avocado}.
> ---
>   target/arm/cpu.c       | 2 +-
>   target/avr/cpu.c       | 2 +-
>   target/cris/cpu.c      | 2 +-
>   target/hexagon/cpu.c   | 3 +--
>   target/i386/cpu.c      | 2 +-
>   target/loongarch/cpu.c | 2 +-
>   target/m68k/cpu.c      | 2 +-
>   target/mips/cpu.c      | 2 +-
>   target/nios2/cpu.c     | 2 +-
>   target/openrisc/cpu.c  | 2 +-
>   target/riscv/cpu.c     | 2 +-
>   target/rx/cpu.c        | 2 +-
>   target/s390x/cpu.c     | 2 +-
>   target/sh4/cpu.c       | 2 +-
>   target/tricore/cpu.c   | 2 +-
>   15 files changed, 15 insertions(+), 16 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

