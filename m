Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B79278B657
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 19:23:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qafwu-0007Es-8a; Mon, 28 Aug 2023 13:22:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qafwn-00076C-Q6
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 13:22:45 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qafwl-0007UJ-JX
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 13:22:41 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-68a4bcf8a97so2149233b3a.1
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 10:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693243358; x=1693848158;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fL+nMGQ5meH92tojfII4wkzbC3jt5ef+3OhICWPiT3w=;
 b=Q9UnPezKjUQa26pMGjfcHK/SnRCft8yMlnFPewW4Sehke4Zd726fl+zvNKPkATbTHM
 N4kOKuLeXZhdAMvLL9ydMkrEcByZD0Gz8a8JfVG9VbYzVMD9apZiPxv6ftaoKafNEkmn
 W1F+4yH0AfdMkapAOGi9wxUXeGUQS8xqoQa9OQ8V/GEBXbd4joIIab+C6BfXpbUoSHPk
 6CkT0MsbZBBTNu0wNfWgw7RLKqbkjCerVHpTkjPDYaTfrlga18m6aICgyUpaTSjtv0ro
 AAwfSM8d7WPpS01FsFtYKo7popH8MOS4/NcK8BAUliG9awNnDPaSe4mq5OrVxn6X0NpY
 jVVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693243358; x=1693848158;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fL+nMGQ5meH92tojfII4wkzbC3jt5ef+3OhICWPiT3w=;
 b=FU3x9bc0ACYKicto75zEai4Ach5SeKUaNgoFHH7M3ySzU4/ydV9qQBExXdbxWIiQQ2
 vXigglMJrZVcRJ/3T37dBh3IEnNRHOgYp7uY+Filz1PdrcUrVunw2Mbz4FhS4OcGZAPw
 YfuSA7FtjmsItoo38ePC7f6xmBoviuMjhDoP5yETVonkZjqeXahtGcpe95C/p1KQcN2P
 XZR5Ba7eNsfz4fwNP+tF7BgshjN36+HTsg8ozV39a80myjQ1AxjoLVlHoig1hbLPY3e/
 oH7Rq/2eRh99fYI84Z8fXSC9o8O4StwzGX7xmlJZB1QAnGrgNTscwXFE7yYn7oD+v5MO
 e5VQ==
X-Gm-Message-State: AOJu0YzawaMdWlELOj3TEETPHRvoVfcnLGsdUv9q5LhtF7irixk4WEa/
 ICKl4nfO9u5CIuWGHkAbw5Hweg/gPZfE0B3lPtI=
X-Google-Smtp-Source: AGHT+IFEt04lyP3lT1lin47u9ek4VR17zrZbnzA2IqW6SavzsqXYML6Feod0ckOk3nGT7QRSRgBIXw==
X-Received: by 2002:a05:6a21:6d9b:b0:14b:8023:33c8 with SMTP id
 wl27-20020a056a216d9b00b0014b802333c8mr16558229pzb.2.1693243357971; 
 Mon, 28 Aug 2023 10:22:37 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 r22-20020a62e416000000b00686dd062207sm6928354pfh.150.2023.08.28.10.22.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Aug 2023 10:22:37 -0700 (PDT)
Message-ID: <5db7778e-5fe2-3333-1301-1456e14470fa@linaro.org>
Date: Mon, 28 Aug 2023 10:22:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 11/11] tcg/loongarch64: Lower bitsel_vec to vbitsel
Content-Language: en-US
To: Jiajie Chen <c@jia.je>, qemu-devel@nongnu.org
Cc: gaosong@loongson.cn, WANG Xuerui <git@xen0n.name>
References: <20230828152009.352048-1-c@jia.je>
 <20230828152009.352048-12-c@jia.je>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230828152009.352048-12-c@jia.je>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.169,
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

On 8/28/23 08:19, Jiajie Chen wrote:
> Signed-off-by: Jiajie Chen<c@jia.je>
> ---
>   tcg/loongarch64/tcg-target-con-set.h |  1 +
>   tcg/loongarch64/tcg-target.c.inc     | 11 ++++++++++-
>   tcg/loongarch64/tcg-target.h         |  2 +-
>   3 files changed, 12 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

