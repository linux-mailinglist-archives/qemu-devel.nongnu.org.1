Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D32754079
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 19:30:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKMcN-0007sf-KD; Fri, 14 Jul 2023 13:30:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qKMcG-0007qg-8r
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 13:30:04 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qKMcC-00021W-Fp
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 13:30:03 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-4fbbfaacfc1so3671862e87.1
 for <qemu-devel@nongnu.org>; Fri, 14 Jul 2023 10:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689355798; x=1691947798;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uxKRnAMEkn1OQJaj3F9rQnk/11WLKU5vpQ+bkl1czKE=;
 b=bKPwu3modFjUE7Pmdo3pN7YhOCxACnJ24kRkg260Yf40xZvPRO88yEDmb/Lo4JbwOI
 m0/TY+fQQbayNapVSCTPN1XP9gMnCTMrHp1NzKScpVdF+WvYkrACgGA7emhES0gLW6ht
 Bqzkd6szGkUEZiY6ytexEBK5gMGwwRExm1lmP/jejR5vvvqROdFzjIew64LQ7A81suMV
 HNURmJfzu/kEEUQs/2wP8Uk5y4ZbyizTGMiUwgbKn3aepAnIsn+MZSEYUf4jXA+802j1
 eH165k2uuruvjJNJMPCNGP46tSDp24lbndq2rEPo/JYMm0Pic0HKmMjo3RswlHFiAwUU
 zlZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689355798; x=1691947798;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uxKRnAMEkn1OQJaj3F9rQnk/11WLKU5vpQ+bkl1czKE=;
 b=PrGIIWEXgwosokMLQig7JptcsKEPysUICwS3WHzH13o23y2p2W8uXAH2xxlJjD1MU4
 HBxQhcmpo9IdGBw1JngVfS8InaLlZbyAVZ3QuQXdSEtsEeBHO3X5xILFDUGfA39lJtqK
 m6DQRmebyLbO+yxeOskg42oC4GpW9vvikXGkiYnFLmn9AMJ8+rgaY3CPZhqG5vQFGuAd
 40aXGsINc8iLFuSL8kAg1bTiQV+5ud9x2KkaogjUPE97xh8oSXnUvMiI3Np1FjVoB3we
 VrvnnJCAURpjJyf+ffadZsyXERlRDUlXIL/2CXJzUXe0R54+Jrm3Gloy+8h29S4wigMz
 Aizg==
X-Gm-Message-State: ABy/qLbAydHEF2CNJGUDlulfsQuC95RrgO+eUSmtN1KMnbc8kfm/1XWt
 1JzC5XHUIlThl87kRaHIqbiRgWM2swzvSpyuLipXdMt8aAtz5B24
X-Google-Smtp-Source: APBJJlGST3A4eDYH5ixz+JCLIkwXHT7GWIMbBVSyY1SMKrqZhY6nepVl6dcJRUtbwvIJotptox6ykWWU3InU0nAugwo=
X-Received: by 2002:a19:6703:0:b0:4f9:7aee:8dc5 with SMTP id
 b3-20020a196703000000b004f97aee8dc5mr3913247lfc.19.1689355798153; Fri, 14 Jul
 2023 10:29:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230714172602.397267-1-peter.maydell@linaro.org>
In-Reply-To: <20230714172602.397267-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Jul 2023 18:29:47 +0100
Message-ID: <CAFEAcA-CT1ruvpgYfFn81n-xPup_FPNNmmDiAXJMj0=voBxHpQ@mail.gmail.com>
Subject: Re: [PATCH] target/sparc: Handle FPRS correctly on big-endian hosts
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x131.google.com
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

On Fri, 14 Jul 2023 at 18:26, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> In CPUSparcState we define the fprs field as uint64_t.  However we
> then refer to it in translate.c via a TCGv_i32 which we set up with
> tcg_global_mem_new_ptr().  This means that on a big-endian host when
> the guest does something to writo te the FPRS register this value
> ends up in the wrong half of the uint64_t, and the QEMU C code that
> refers to env->fprs sees the wrong value.  The effect of this is that
> guest code that enables the FPU crashes with spurious FPU Disabled
> exceptions.  In particular, this is why
>  tests/avocado/machine_sparc64_sun4u.py:Sun4uMachine.test_sparc64_sun4u
> times out on an s390 host.
>
> There are multiple ways we could fix this; since there are actually
> only three bits in the FPRS register and the code in translate.c
> would be a bit painful to convert to dealing with a TCGv_i64, change
> the type of the CPU state struct field to match what translate.c is
> expecting.

> diff --git a/target/sparc/machine.c b/target/sparc/machine.c
> index 44b9e7d75d6..5a8502804a4 100644
> --- a/target/sparc/machine.c
> +++ b/target/sparc/machine.c
> @@ -168,7 +168,8 @@ const VMStateDescription vmstate_sparc_cpu = {
>          VMSTATE_UINT64_ARRAY(env.bgregs, SPARCCPU, 8),
>          VMSTATE_UINT64_ARRAY(env.igregs, SPARCCPU, 8),
>          VMSTATE_UINT64_ARRAY(env.mgregs, SPARCCPU, 8),
> -        VMSTATE_UINT64(env.fprs, SPARCCPU),
> +        VMSTATE_UINT32(env.fprs, SPARCCPU),
> +        VMSTATE_UNUSED(4), /* was unused high half of uint64_t fprs */

Whoops, these two fields are the wrong way around. The on-the-wire
format for migration is always big-endian, so we need to put
the VMSTATE_UNUSED() placeholder before the VMSTATE_UINT32(),
not after it.

thanks
-- PMM

