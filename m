Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D176873DC8A
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 12:53:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDjpW-0001Qh-Rn; Mon, 26 Jun 2023 06:52:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDjpV-0001Q9-Ea
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 06:52:21 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDjpT-00037a-91
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 06:52:20 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-312824aa384so2593222f8f.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 03:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687776737; x=1690368737;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BGpHfYyI0rfAiIXWy8iGVZ1aOyx0A38cePkr/L3YmZg=;
 b=lK8U7u6nmId9hlzZ0H/jTbJHjjEH5J2i08UcQC9IFNB0CDlAgbW0h/K+9djEHqvG+v
 lrR5UZWmGZIZRLQ6GUX3Ufi6t3pC+YjyzJIfHoUg0eagBk8aVW1t2nhyjRBrBQ+B82At
 OuKrBvDO4gYNdoCZjzZ+GI7Qoau+zibdKovPE8/s1IVEHyy9Mwt/0s7SEoDFbZuOvCBt
 Zbjnw9b07+REP9Nxw6WIaAeAbysVkR005r7qtDuoITkgKVZhufgbtH8BRP4w4gWEb2tc
 DuoFG87ljlRjSNKZBSgpDSN+A5qF4aNxW934dtQ1k6BtomYA2mRKjtl+7g+6/OBeL5+1
 8OWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687776737; x=1690368737;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BGpHfYyI0rfAiIXWy8iGVZ1aOyx0A38cePkr/L3YmZg=;
 b=fd2+H2nmnE+rjPtneDhx5WRHXcIXY/W1ttF+HkOFLukA3p3WRnajKF9lQnJ6Fed5aC
 THwIg5XTeblLQo3y0GZM8otpXXAq5m6A/ldNMCfDbHKJ3fZmw4oO9JmsjgzVIkf/yaVb
 mTTrYfmah6pwPEs2l8v/laHGUa4B7przSC/jVN1y1WwfhSmXHXvdNu5WKgT40stZX5Qg
 WTp/tR5O75a8a/ORN44ThmpcRQ/Fzjz53grgKMzf2odLueSoNE/ZBgEPpIj6eTeu39OK
 t/KQkH9dfIViyLMEBpmja40aDN23fPt5Pw4G17gFVX618gceNtaRYaAhZtKK4H4zcZQB
 pM4A==
X-Gm-Message-State: AC+VfDylyczRgbrJBp0ruhG4xK6pvShULbHCmRZsWJF5I4S4PS/5kVQ4
 R1Ae/TBBsuA+dyE7nnsvV/y0Ccmo8i6AEDuqP1v0qfUE
X-Google-Smtp-Source: ACHHUZ6SoZk8DWeDgIIbUUiJ1QVPhO1kZgLUPUrLsLAV0mAlm/RT+IuLU+nkpWynZSvRk5/xKnzaog==
X-Received: by 2002:adf:e7c2:0:b0:313:f347:eea0 with SMTP id
 e2-20020adfe7c2000000b00313f347eea0mr1194849wrn.60.1687776737423; 
 Mon, 26 Jun 2023 03:52:17 -0700 (PDT)
Received: from [192.168.44.231] (141.pool92-176-132.dynamic.orange.es.
 [92.176.132.141]) by smtp.gmail.com with ESMTPSA id
 d10-20020adfe2ca000000b0031272fced4dsm7026169wrj.52.2023.06.26.03.52.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Jun 2023 03:52:17 -0700 (PDT)
Message-ID: <2d67c3a1-196e-f8b9-e172-dbcef7d01e7e@linaro.org>
Date: Mon, 26 Jun 2023 12:52:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 0/5] tcg: Issue memory barriers for guest memory model
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20230619142333.429028-1-richard.henderson@linaro.org>
In-Reply-To: <20230619142333.429028-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 6/19/23 16:23, Richard Henderson wrote:
> v1: https://lore.kernel.org/qemu-devel/20210316220735.2048137-1-richard.henderson@linaro.org/
> v2: https://lore.kernel.org/qemu-devel/20230306015710.1868853-1-richard.henderson@linaro.org/
> 
> Changes for v3:
>    * Update for tcg-built-once.
>    * Require TCG_GUEST_DEFAULT_MO if TARGET_SUPPORTS_MTTCG.
> 
> 
> r~
> 
> 
> Richard Henderson (5):
>    target/microblaze: Define TCG_GUEST_DEFAULT_MO
>    tcg: Do not elide memory barriers for !CF_PARALLEL in system mode
>    tcg: Elide memory barriers implied by the host memory model
>    tcg: Add host memory barriers to cpu_ldst.h interfaces
>    accel/tcg: Remove check_tcg_memory_orders_compatible
> 
>   accel/tcg/internal.h    | 34 ++++++++++++++++++++++++++++++++++
>   target/microblaze/cpu.h |  3 +++
>   accel/tcg/cputlb.c      | 10 ++++++++++
>   accel/tcg/tcg-all.c     | 39 ++++++++++-----------------------------
>   accel/tcg/user-exec.c   | 10 ++++++++++
>   tcg/tcg-op.c            | 20 ++++++++++++++++++--
>   6 files changed, 85 insertions(+), 31 deletions(-)
> 

Applied to tcg-next.


r~

