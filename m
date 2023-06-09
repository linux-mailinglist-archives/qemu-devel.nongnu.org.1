Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F17D72A1D3
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 20:10:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7gYy-0006bO-19; Fri, 09 Jun 2023 14:10:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q7gYo-0006Xt-Bv
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 14:10:07 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q7gYm-0000Fo-Qm
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 14:10:06 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-4f642a24568so2629451e87.2
 for <qemu-devel@nongnu.org>; Fri, 09 Jun 2023 11:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686334202; x=1688926202;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OShiSTwB5ZBBzVOwkqJpVH/3uelpFtTgousp8fuShFU=;
 b=fp/o9po/lv4AWYIxDW0V8gst/JHoYKWqcmcWRuj0FdfLIoJaSudNV/3yTewZ3BVkl8
 22bbv/EsekJBusA4NNwgEJSLx31pm4vxBzfaNfTaaHrmghUY03pvOYkAjqtC2+iuj+xh
 UPBCbBaJQUa1YSTcbQpXsWxWDAP0mIpR0i3ZmmuWwyFZLu6BHnRSLBTjcnyvS2LGP4qF
 cTQB5mc7tguH3MPRI+QcCgIQuGwSYtBSjyEB/LzA6dh1S1zFejA1qovzLnyCYZ31kv1E
 +KXHIkQdhKm953SuJrDLDjZO/AwtVIeuijs7ZOrTiyvqXLLTg6lnJclnPh16rpeTXtBy
 6HKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686334202; x=1688926202;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OShiSTwB5ZBBzVOwkqJpVH/3uelpFtTgousp8fuShFU=;
 b=CO0NLsSUsWdPGjAPT+BG1JyXCvXLxHwACjE2o1lSsrM8fMM/IWcSTVDIMyFIcG9xv3
 Yx4qgobM95QpZO959ODR204q211ap3xePh8La045aXz8t+16z8P3xG8+oWj4+fHIbe62
 uztfaFD+eUOtkis11fApjEoDNREjXzjz0z8xadrJVlVsFsoGX+7HAlIqxLOzitXxeiu5
 3y3fb0xqSJeWjYgClkodi72pCdXjzmg0QhdJr+m9OwIIUXJnZPSVrhcfI4OOH3E8lCNX
 GxNA+E7SuDe7gumtznhdcg8JKNEXT7Vtijj9qT7i5g3l1nHHpmOrU4c8IBgAMzYsFdS9
 rSrg==
X-Gm-Message-State: AC+VfDyNpARfeT4ocq/iXD6a8C4I1GT6TEHP/6AVW75kbWGmXfp+K31q
 YOLmdWei1E7RTJ+8xUP65h6wS1nzIV25nLp+qwcHFQ==
X-Google-Smtp-Source: ACHHUZ7n7lUA400eWRi8Ove0iTpM0sVOxipcnTEFxHBeLdgwfwYTMf/JwvQndzmzWBpTdjff39o4+uIm7m0kaoyLZkQ=
X-Received: by 2002:ac2:53ab:0:b0:4f2:5c4b:e699 with SMTP id
 j11-20020ac253ab000000b004f25c4be699mr1576900lfh.24.1686334202592; Fri, 09
 Jun 2023 11:10:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230609175841.748017-1-richard.henderson@linaro.org>
In-Reply-To: <20230609175841.748017-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 9 Jun 2023 19:09:51 +0100
Message-ID: <CAFEAcA8iOofUcRLDUUtBUsuEPA+c=UDSN6oOdGe5sVovSpyy7w@mail.gmail.com>
Subject: Re: [PATCH] host/include/x86_64: Use __m128i for "x" constraints
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x134.google.com
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

On Fri, 9 Jun 2023 at 18:58, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The macOS catalina compiler produces an error for __int128_t
> as the type for allocation with SSE inline asm constraint.
> Create a new X86Int128Union type and use the vector type for
> all SSE register inputs and outputs.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  host/include/x86_64/host/atomic128-ldst.h     | 25 ++++++++++++-------
>  .../x86_64/host/load-extract-al16-al8.h       |  8 +++---
>  2 files changed, 20 insertions(+), 13 deletions(-)

Yep, this fixes the build on my x86 macos box; thanks!

Tested-by: Peter Maydell <peter.maydell@linaro.org>

-- PMM

