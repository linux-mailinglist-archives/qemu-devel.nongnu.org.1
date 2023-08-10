Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 679E6777E2B
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 18:25:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU8T5-00077k-US; Thu, 10 Aug 2023 12:24:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qU8T4-00076J-8V
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 12:24:58 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qU8T2-00058a-1D
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 12:24:58 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-99bc9e3cbf1so231237266b.0
 for <qemu-devel@nongnu.org>; Thu, 10 Aug 2023 09:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691684694; x=1692289494;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NKzFWzq3o7yoHtgpH4lMpHDKTXKeav8BD70Hoz1nnBI=;
 b=e0++HBtDGMkopIReN6Ivx5APHJpB/Ojn/J9CF8xdFig8chYpZt/rUC+/w75qBhRWoN
 q/beVa0b52rXuXlzOOIxzY8sq+H0p5M7gOs1zDXsrkot4JBqmuJj5aZvDpEfGOTsXAw/
 yW5Todo+EDfzUtxG8VA+Lrqoi5Jeu2O8Nn/c95iRhFudiwDt+Y4HBAxX9JvKKwhTAkif
 Ia/T1v5z9LE05L3fQhZqMm6es9F7gluUKtzBbkdmCSQsMkt92Wfm0RH13a6pAY/upLbc
 9VmQGNozXTwFZDflI5nAmrCSJ/XJ5OhbzHBCoGY4NOYVSerqWuLbeTE++8b1F44xACmP
 2Gcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691684694; x=1692289494;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NKzFWzq3o7yoHtgpH4lMpHDKTXKeav8BD70Hoz1nnBI=;
 b=JBoKmYyqkuFlPTK3cB+ENwqiLXWAwaStyEtYI9ssYFOfLN4t2VXyKdAJkYVM0fD+Qp
 kqvOoI0+1vACruSzmp+usbL1VY0a0mExtEsoPJchd2FryJ8+oHG2743UcDvDilxcah5B
 rh1lgacgSGwk4+oqF9aLkJF1MR3dwPbQH6FgV5rsmn0Eadp92ijSYAyzBcJcSROjjnp1
 uY/+BXdgWF68kppPA/XfpGJ2BPhysj2vdqiy9rRJQzPBO37txcYmrKTFSdp9DeyV4dY1
 MgWDPa7YA0iTfSen2UdsmTRMnxf3xX9TC5CbgqArdIQlJ/WavKUm3C7G0TCecY3nXkRT
 as/A==
X-Gm-Message-State: AOJu0YydDNIQ/GYXql+wasXRxaKcEehlEun+0FpVGpoPhxjwr0n26x7L
 6qyhSq96Wdc3jUFBA13nxui1SWu9uDOiVrv8Pr0EOg==
X-Google-Smtp-Source: AGHT+IH9UjPwUs8PIr6ht7l7PMtAG0t/rIHGkvA4jesBb7RUy8PoFQW2CqFdv8480KUgkt47UAjC2iKQZvajy1kyCEc=
X-Received: by 2002:a17:907:8a04:b0:99d:ae3:80a3 with SMTP id
 sc4-20020a1709078a0400b0099d0ae380a3mr3231266ejc.0.1691684694459; Thu, 10 Aug
 2023 09:24:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230808031143.50925-1-richard.henderson@linaro.org>
 <20230808031143.50925-7-richard.henderson@linaro.org>
In-Reply-To: <20230808031143.50925-7-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 Aug 2023 17:24:43 +0100
Message-ID: <CAFEAcA8LYVyER2HN9-2wedpoKQCCoRPHOjDTZMF5u_Y7mDiywg@mail.gmail.com>
Subject: Re: [PATCH 06/24] target/openrisc: Use tcg_gen_negsetcond_*
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, 
 qemu-riscv@nongnu.org, qemu-s390x@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62e.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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

On Tue, 8 Aug 2023 at 04:13, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/openrisc/translate.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

