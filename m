Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0289A777CE6
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 17:57:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU81k-0006yq-9F; Thu, 10 Aug 2023 11:56:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qU81i-0006yh-FJ
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 11:56:42 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qU81h-0007OJ-16
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 11:56:42 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-4fe2d152f62so1696980e87.0
 for <qemu-devel@nongnu.org>; Thu, 10 Aug 2023 08:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691682999; x=1692287799;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KVIH7GxvUfpCxLU1VOTtbV+KIZEvvQudMpC18bda69s=;
 b=VqJMiump642uz8nZ8jD49EaGe6HrwJSMV8765ByWsNqIKjbGP/Vb5bmv5EbB99ixAq
 QVi7W7PeL7XFTxK1DEyYDRQSgvfrmzuQRjA5ijr/V/EstC7T9tPbyezLkAqvGCp+C1Us
 y3tBYY3Eun+Ff12wMTModEJbJU0FKqUvpuXV4yDJ+RrSN99L2CvKFSBhZNQACT6vqOeq
 HGR5tTG28ypmANXM+wNiq5NdGVutSOk3Xh7JJSgFr5HPiFj+CYdpApF9NCLNvtme4CDs
 4/de1Vb5N0GIzznRu228/ChfY1L339XwHG+MmZi0undHPMcIYcFOqWIKVLkkit0fWiA3
 GqYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691682999; x=1692287799;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KVIH7GxvUfpCxLU1VOTtbV+KIZEvvQudMpC18bda69s=;
 b=EE1KlCKaFJNixO3jXHc/4w5x0a9yA08Z6Qjvx9HoLpj5xtzQDdWI2i8bU4AncnCQkf
 LUn9tW/SPn8+iJc7qf6jBvg233gnGKfb0o+PTZA23IbhFKALJhZex/PnrKvey44+fpxr
 Gg8Fw4bdL7+lb+BPUsQgqZIu0VhmyxbstWjQtv3pNZw6qVK6cHVnwFMNkUXc/HXP4Zor
 QCNXoYzTizQnvH3Lnobj4Lra7/UvUWzRwritaCwLOD8Pu35Ug1r4tWX8QQR3zQcSlQrS
 kuPy1+DOt9L5b8dmHBBR/F69nY9am+VRo034R9g+I26l6LKKplOQteQRHWL2/XuxejyP
 Flag==
X-Gm-Message-State: AOJu0Yxlmlf9UnzalpiK3N5qQ1Clear7LqlD5KL0baFciG1j0XZEied8
 CKQGc7m0aFUis7pu6PARSJzOQU8gWgBanXYXeEsGxo6oeHkN5c2r
X-Google-Smtp-Source: AGHT+IF+JQG9fyX9NnXpLtBbrQDuwlUwc9cih0llCe6UfQErqlGZ7t5tUWiUQOcCcHejhGVGJfJM2A6ElkamxB8kv7Y=
X-Received: by 2002:a05:6512:1095:b0:4fe:8c4:44fb with SMTP id
 j21-20020a056512109500b004fe08c444fbmr2477664lfg.38.1691682998945; Thu, 10
 Aug 2023 08:56:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230810154802.16663-1-richard.henderson@linaro.org>
In-Reply-To: <20230810154802.16663-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 Aug 2023 16:56:27 +0100
Message-ID: <CAFEAcA9KWycM5qUsB+FRui=C_HA_7=enpKNYf=hyx+ZUEc4BCQ@mail.gmail.com>
Subject: Re: [PATCH for-8.1] accel/tcg: Avoid reading too much in load_atom_{2, 4}
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x129.google.com
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

On Thu, 10 Aug 2023 at 16:49, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> When load_atom_extract_al16_or_al8 is inexpensive, we want to use
> it early, in order to avoid the overhead of required_atomicity.
> However, we must not read past the end of the page.
>
> Reported-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---



>      if (HAVE_ATOMIC128_RO) {
> -        return load_atom_extract_al16_or_al8(pv, 2);
> +        intptr_t left_in_page = pi | TARGET_PAGE_MASK;

isn't left_in_page actually -(pi | TARGET_PAGE_MASK) ?
I feel like that would be clearer than leaving it
the negative of the number of bytes left in the page
and comparing against -16 (and assume the compiler
generates equivalent code).

(I always have trouble with expressions that combine
boolean operations and 2s-complement arithmetic, though.)

> +        if (likely(left_in_page <= -16)) {
> +            return load_atom_extract_al16_or_al8(pv, 2);
> +        }
>      }

Either way
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

