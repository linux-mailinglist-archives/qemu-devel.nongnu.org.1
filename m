Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D470D73B59A
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 12:42:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCeDg-0005ep-FT; Fri, 23 Jun 2023 06:40:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qCeDX-0005eP-LD
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 06:40:40 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qCeDW-0008QZ-1s
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 06:40:39 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-51bdca52424so502795a12.3
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 03:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687516835; x=1690108835;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YXFZsyp/XL+X7Zfhbibx83TVd1DCnGHs3FLQL/min0U=;
 b=ZGaQRuN7yu9Ia9+5SDW6yRmrDMgAZNgebD3zq21cwS4kSCdcwOKdPihJbkVRbkCdbk
 6HWioHqfhx3uxtLIdqpqOM5vIW5oCeNsJvFRKeNwbmkOm12/B6nErIx3tiuBl5NKpWYk
 hV1b4az140L93jc7/2HfnBOE2DoxK+SoU3oZ0qYTDJCFugUBWjYz6m7hFgo8LmWvuQDp
 EyWCljMnD0+P3tARgzZb0udcw/wbkdTLtrjTsArYllFqkLo7quVP3awydrZZPOmUDmwm
 +DDBoE3r+kEr9e0PszauvbZ2wXowSfQHtQQkmLSObey+2rTN6RgbzJXfXLFbflp+HQoT
 J9cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687516835; x=1690108835;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YXFZsyp/XL+X7Zfhbibx83TVd1DCnGHs3FLQL/min0U=;
 b=LtQX7OI3xBtfTgPPduHvQcdIDb+EKkrUbAcikWxMKvq+UNMnlm8txuyWSmNIuzb4lZ
 1ZQSbhcYjEfCzMH7V42Y5oksZ6TYGeMaWMNs8knKHcZ6j0BlE924At2ZeTkaOhjQLA91
 1dCl/ipXlTGux9ZmSfyQDZsRHIYN1lPcKl2+i8HeNZdqKvd20ORqUqL6jTuoevSojWPB
 IS0e1u+pho3OhdJoxgfsRY1aVDF73w/FIGXDcyXSvmkkHEwA2b1AAcQGGFH67POe6JoC
 DAdGNgsOUAEqzBmDV3DTSqZZBwkI/26cZgtlPQD4nLEGNE+AU2sWn2SE24vTxcyMCzWp
 n2ZA==
X-Gm-Message-State: AC+VfDwaCUIIuOuEzkxxtfTcgOm42oO1THKulxVX8htDkrvVe5wOs35w
 zee+2DdbQFvJrwb9tBEIw2ii5f+/Bml2sNzXAX+3LQ==
X-Google-Smtp-Source: ACHHUZ7ZqMWPgNoO8OuNb/5VTaLf7NZozAS7sU2zRNgUMcxzAa5oViUN0yWh+4GnWNdvuJrDK+sd4jcO/5aTM1qZM9s=
X-Received: by 2002:aa7:d597:0:b0:51b:ecb7:23d2 with SMTP id
 r23-20020aa7d597000000b0051becb723d2mr2584226edq.18.1687516835730; Fri, 23
 Jun 2023 03:40:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230620134659.817559-1-richard.henderson@linaro.org>
In-Reply-To: <20230620134659.817559-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Jun 2023 11:40:24 +0100
Message-ID: <CAFEAcA-uEzWRu5q39DG2LrFcZk4iKJAUfZ=VvDxfHdjN01K=Gg@mail.gmail.com>
Subject: Re: [PATCH] target/arm: Fix sve prediate store, 8 <= VQ <= 15
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Mark Rutland <mark.rutland@arm.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
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

On Tue, 20 Jun 2023 at 14:47, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Brown bag time: store instead of load results in uninitialized temp.
>
> Reported-by: Mark Rutland <mark.rutland@arm.com>
> Fixes: e6dd5e782be ("target/arm: Use tcg_gen_qemu_{ld, st}_i128 in gen_sv=
e_{ld, st}r")
> Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> --

Applied to target-arm.next (with the subject message typo
fixed and the Resolves: line added), thanks.

-- PMM

