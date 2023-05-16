Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 82890704A19
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 12:09:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyrbn-0005rU-2p; Tue, 16 May 2023 06:08:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pyrbk-0005qQ-Pe
 for qemu-devel@nongnu.org; Tue, 16 May 2023 06:08:40 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pyrbh-0004Ko-UY
 for qemu-devel@nongnu.org; Tue, 16 May 2023 06:08:40 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-50bceaf07b8so25299853a12.3
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 03:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684231716; x=1686823716;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+HqN2yWbv/LOqDR5G4Q0DDuSZ56lxECwyUkJwxUG3V4=;
 b=SK1VAvZ+T3gn4AGNHFYXx/Q4iOH5CRREo9oikPY+WmFR8RzoqQtAFUGGghEcIcgVhg
 BHSdh8zZ6Lg9QZJ6wb2Kp+tdFPFMP5HSLQQjCmzn12iaixog9Ir0OPTR05MAifetJPYH
 cMy6qlnKsWVGN/0LvPoGhVLVGH0OrWHmKT5SLp8fgPhAghNQxm0yIFGstdDZ0sZ0ef9h
 PpxpIMPxEw61PHgSxnzCVrXuSKjFexI3ndSvlMmzp29w5mlFY85riTwuGj6NMjOfHcEc
 XJCIvdq8XEm+ecfwOnyRb1ff9lis45o/vLiHSEA1C+akMllgayY5nTkki3CmCdYaz7jR
 mx+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684231716; x=1686823716;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+HqN2yWbv/LOqDR5G4Q0DDuSZ56lxECwyUkJwxUG3V4=;
 b=O5GR42ZFI4BeG4cQR8cTFfTzOuPOX2LhKEvrITQ59YESqudKPXpAbIS1Qo6uAO7onr
 Io2K4Jyh8tWrvbntaDOTmMW1TetU2O2ivVvGtUZ/6AHYPhPVfEHp0RV56MmXdLK5apYP
 z8Q7tePidP0TZQ+vvN6K7QH9DUPzSBAIc6g9p1m3DvEa4Tar3h9OFCYncuFaQDMMqjkr
 +/ZAFpC+Tzi18NAd+VS61Q6yY5lkoSRMICsyrn3/jnLAQ5JTrXK1reEsfpm+XQ+aucgh
 CsfPPl6Z3F+D3NpA/zqBIEjD945zudfZL1XMMu8INSmZzqooq4OflYon3SGZXYKN/Hs8
 SjaQ==
X-Gm-Message-State: AC+VfDzwumR0+Z5LoZqb9WK9O+7NbN6UXq8y/ZSeG3BZDdVeeovDJ0dD
 GtcDFd/KmW6gi8WIa1vhj+RZWKUO1xyMRdsyfWCudQ==
X-Google-Smtp-Source: ACHHUZ5D+kwT2ixiA7froLudVd7w4xFj4h2S/R3fSW2jrnAIToLcU42F0diMpQ/pagqNTMevpR7P75Z/oUH2MNGg+yY=
X-Received: by 2002:aa7:c603:0:b0:50d:e0d8:cf31 with SMTP id
 h3-20020aa7c603000000b0050de0d8cf31mr14944796edq.21.1684231716409; Tue, 16
 May 2023 03:08:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230515143313.734053-1-richard.henderson@linaro.org>
 <20230515143313.734053-40-richard.henderson@linaro.org>
In-Reply-To: <20230515143313.734053-40-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 May 2023 11:08:25 +0100
Message-ID: <CAFEAcA8q45wYyX8O++wYbmjpAQm-c5a5JZQN1MhLCPfFqK69Pw@mail.gmail.com>
Subject: Re: [PATCH v5 39/54] tcg: Introduce atom_and_align_for_opc
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-s390x@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Mon, 15 May 2023 at 15:43, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Examine MemOp for atomicity and alignment, adjusting alignment
> as required to implement atomicity on the host.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> v5: Dropped r-b because of MO_ATOM_* reorg
>     Return a struct with the result pair (phil).
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

