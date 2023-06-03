Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF8E472139A
	for <lists+qemu-devel@lfdr.de>; Sun,  4 Jun 2023 00:06:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5ZMs-0003GZ-Dh; Sat, 03 Jun 2023 18:05:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5ZMq-0003G3-At
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 18:05:00 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5ZMo-0007Ri-7M
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 18:05:00 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-64d18d772bdso3924810b3a.3
 for <qemu-devel@nongnu.org>; Sat, 03 Jun 2023 15:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685829896; x=1688421896;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CN5TISTCW47lOoQ9v4MV01TT1tb560PxPMLhbzSVknQ=;
 b=WJJUeN8/XLXNT8s8DGvYRyY4kQRmLj9P+HFGUxCw6Ly/s7xTCtYl7TzX1aPRcgdK0u
 ztrbgAlTh5thGkRaaAstqsKVwSQZokYSIA2Pehc+zg3Lq8putRH9ZxUzkgY/KieFllUc
 bn55ZmWaKNxM6DJSPUEYoDSeXDg8xqR+iIVjli5Ex6LXnwXWa1j1tZgpChGWrgdvwduk
 bfZOZoBrh/exQyjpSHvBNCbgHzFVJdK9Ahh5Kn3PtqZ59dPit7rV1lYiBwzbJHjEO+JC
 q9FphD+BFHDfDJes54ISziHVu7xqiy9A07Cat/NB8tCtl7DjtqDO5HarIS93qTwbCst7
 XYiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685829896; x=1688421896;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CN5TISTCW47lOoQ9v4MV01TT1tb560PxPMLhbzSVknQ=;
 b=XH1Q53/wUw3IckDfU1mss7wph7GlyR17+80rPsZxza/N7m0tBaNRwlZPvlT61XKVfC
 9Xp213MTBwDg7MORK0LonPVrlCt7cEllskqQgJm8j53+3p+Zl6bJXQqi5OByjCi9HWOJ
 ni/DVgHM9TLYQw3aKGfj283KVNuo0/PJhosJYFY7JWykzg0Bc1Ipr0/qAiXmAWaAykSZ
 p1AwjLOehCsT68+NMW7dbgVN+j7CEL6I7qVqdAEVriFz7i7DbyMKNNBd900xFyghtfTJ
 kXZ7km3oezxKisJWPzHf+qid0KGCphJde64lZVE0nm9EXQV2gzawijPvcaXVOagA4sKK
 rJ8g==
X-Gm-Message-State: AC+VfDxhNf7kBQyMCqp14oG9EQAaD8sckDJx6pHIBUzGFv5d+3nqrSyB
 n6VHw6EcK9eSLOic4rideV3G3w==
X-Google-Smtp-Source: ACHHUZ6Li4TyY1O4o0YmSpl3f9HJG6RmxLW5KBh0MEEAGcOqsX0JRztp0pPO0nOG3f0iXX13ZjVSrA==
X-Received: by 2002:a05:6a00:2185:b0:654:ab4:305 with SMTP id
 h5-20020a056a00218500b006540ab40305mr3535687pfi.2.1685829896126; 
 Sat, 03 Jun 2023 15:04:56 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:9a37:84b6:b3f0:f301?
 ([2602:ae:1598:4c01:9a37:84b6:b3f0:f301])
 by smtp.gmail.com with ESMTPSA id
 h26-20020aa786da000000b006589cf6d88bsm18629pfo.145.2023.06.03.15.04.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 Jun 2023 15:04:55 -0700 (PDT)
Message-ID: <c6e43527-6590-9210-c51a-88ec01cf28d6@linaro.org>
Date: Sat, 3 Jun 2023 15:04:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] scripts: remove dead file
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20230603214342.471752-1-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230603214342.471752-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.095,
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

On 6/3/23 14:43, Paolo Bonzini wrote:
> scripts/test-driver.py was used when "make check" was already using meson
> introspection data, but it did not execute "meson test".  It is dead since
> commit 3d2f73ef75e ("build: use "meson test" as the test harness", 2021-12-23).
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   scripts/test-driver.py | 35 -----------------------------------
>   1 file changed, 35 deletions(-)
>   delete mode 100644 scripts/test-driver.py

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

