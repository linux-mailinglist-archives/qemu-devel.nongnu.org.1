Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 67FB3735B7D
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 17:49:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBH7s-0004dW-8l; Mon, 19 Jun 2023 11:49:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBH7q-0004cN-Ax
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 11:49:06 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBH7n-0002YQ-Gj
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 11:49:06 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-9786fc23505so438601966b.2
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 08:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687189741; x=1689781741;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OnRUndu/KGxA4Oi1FycbLx9ZltHBMnugOg0m5DnvrG0=;
 b=I+Kl8IWUvqM/fHEYgEKvdk/Cl+45/ipatZTsPhan08/6k/GKvdrdfT/vr+Cvjcv93f
 kdrCrOcVsfaBerjw4exoVDagiTM02OSYLeF8fsY3DH83ub9XQcq6ILDVE9yLkQL/c7bx
 2Q1GSFKlt/PWFodSf89OK+wknummENlCPz2fSw1BTD7SdqS6HJURydcAh2pe+qheicwe
 UGq9dWeheBrR+TO4m/EwdTKsFkLPpN719S61B/Iji2p+XoAUjyRi68PAQwl3AQOG/Igd
 6zGoO0XTo2p4wd/t2fnHMlJgkwSxBaZShLwQYGBSACe48n1bniRbsyMW0N3Zcpkgha6a
 +R8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687189741; x=1689781741;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OnRUndu/KGxA4Oi1FycbLx9ZltHBMnugOg0m5DnvrG0=;
 b=hVDoRQhNZZpo8v2nIhBYAg40WIoh7GyyvZ3IVaItfnmLYLkHZPtsLWdjHYULOdZjFI
 xilwbPx4h6hp65HBhJr0u4ATmh6yM8XlnFkfiYyr2VKDTZXtlcABqEULNhfxtF3+yjKU
 bG0RAQiT2yEWaFPA4h4K2DvnH46eouMJS3Eed5tuV3y/N5x5rpkOO47rxhIE7FR6Tj62
 HYxfgiO8OgYe7G9dpni39n2oHbGIxD/B/M5XgDxmFj8k3sdclilgt4G8ONRBXWPiSVmF
 8xVORWJaVkJaE6XRbQpgWDgTCi/Es2WbX3j8WbAcAw6dCBEv3KoqDeUEWKqrpdWtkySj
 A7xw==
X-Gm-Message-State: AC+VfDwv1OGBAICxutyMRKx87v9Yitq/AjQlSHF1GPrw0bDBNdpfKz7B
 kZP+0neUO8VpiBEyYfNesz7b6Q==
X-Google-Smtp-Source: ACHHUZ4K+Nt28okODIRTd+sMX5+xfv+HH2bm93smi+hQ8f0nXtwJLwiLZe1ILwZNUklcII3cQtjbqg==
X-Received: by 2002:a17:907:9706:b0:988:b921:6e86 with SMTP id
 jg6-20020a170907970600b00988b9216e86mr2015529ejc.38.1687189741585; 
 Mon, 19 Jun 2023 08:49:01 -0700 (PDT)
Received: from [192.168.69.129] (sar95-h02-176-184-10-225.dsl.sta.abo.bbox.fr.
 [176.184.10.225]) by smtp.gmail.com with ESMTPSA id
 f2-20020a170906390200b00988cfb8ccd4sm1089902eje.142.2023.06.19.08.49.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Jun 2023 08:49:01 -0700 (PDT)
Message-ID: <94a453bc-cfd5-5fb0-289d-dbb321c8b172@linaro.org>
Date: Mon, 19 Jun 2023 17:48:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/4] target/ppc: Ensure stcx size matches larx
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
References: <20230604102858.148584-1-npiggin@gmail.com>
 <20230604102858.148584-2-npiggin@gmail.com>
 <CT4I52C30RXG.AESIFCY16U6T@wheely>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CT4I52C30RXG.AESIFCY16U6T@wheely>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x632.google.com
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

On 6/5/23 08:27, Nicholas Piggin wrote:
> On Sun Jun 4, 2023 at 8:28 PM AEST, Nicholas Piggin wrote:
>> Differently-sized larx/stcx. pairs can succeed if the starting address
>> matches. Add a size check to require stcx. exactly match the larx that
>> established the reservation.
> 
> Hmm, question: reserve_addr is a VMSTATE field, but reserve_val is not
> (nor reserve_size after this patch).
> 
> Blue Swirl added that with commit a456d59c20f ("VM load/save support for
> PPC CPU"), and when reserve_val was added in commit 18b21a2f83a
> ("target-ppc: retain l{w,d}arx loaded value") it did not get migrated.
> 
> Could we end up with reserve_addr != -1, but with a bogus reserve_val,
> which could then permit a stcx. incorrectly? Not entirely outlandish if
> reserve_val starts out initialised to zero.
> 
> Could we just clear the reserve in cpu_post_load? It is permitted to be
> lost for an implementation-specific reason. Doesn't seem necessary to
> try keep it alive over a migration.

It's not a bad idea to flush the reservation over migrate.
You can do

-       VMSTATE_UINTTL(env.reserve_addr, PowerPCCPU),
+       VMSTATE_UNUSED(sizeof(target_long))

when making that change.

Peter, any thoughts on this?  If we're going to do one guest, we might ought to do the 
same for all load-lock/store-conditional guests.


r~

