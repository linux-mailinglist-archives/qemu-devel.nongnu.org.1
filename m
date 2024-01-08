Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B588271C3
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 15:47:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMqtu-0007fz-Iq; Mon, 08 Jan 2024 09:46:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rMqtp-0007fj-TT
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 09:46:45 -0500
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rMqto-0004IW-5e
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 09:46:45 -0500
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2ccae380df2so19383181fa.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 06:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704725202; x=1705330002; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rfJb/XDW2sMdwEW50xiC1ExpZZqBBkoIvzgus9dfrXw=;
 b=Dw9vQXwxj71nikzLs3dj+UNabrJZxiTEbEu6TuqsRLBBW/1VsfeBoSdieIRYaRgUOs
 HRpuYj8EwUJwk5ULvyRwiRxNPlBEdaKOCkBOdAvbpor0lU5q7qHLgDijEtbxBm0Y5lPO
 iYyKHgcR+CzaIueKoW+jqROUi95z8Oo1O79/AcZ011Xv/f1P1zLbxpTHxn9vGPm3SCtl
 aDTernOmkwE9cUGExV0Q0k9zJPaQLnj1oZivM9dqUOYDQ0fZlyKX/dFTsD4ijhF40iUZ
 mHWOEJZTmsEIAmRoBmUZKGNVnewvnmIUb4mRWVPyFL1a4flxrFbuWpCkn6bKvGj8wIJK
 +z8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704725202; x=1705330002;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rfJb/XDW2sMdwEW50xiC1ExpZZqBBkoIvzgus9dfrXw=;
 b=H8w6DK10w9qk+wf15QxnleDt+09mtvOFaf8PnhZHiteYETEnA+Df3XBkVReisDld3w
 aQfxqgkQRmKr/N9Uk/P8DH2VOff+PwscwQ/YG9MfBudvuAVDNyNFuk8aUfqvglUNNVpa
 smbUffgSkGa2GJSwUfd8pOJz2UL6KXnVi7mwbuUKOodpI1A2uD9RCDh9JTsBKCUQneNY
 cWRTWSStpVzUsSe+Q8d4P+5M0a3lWgVspkW/xXe4g87vKv5G/EH0X8tkzr6uYQWe0laH
 ySErDmVMBVe3+0Pwpxh/Naev9nl9y71qP8KmKs3gXab3t6iGxKGqvjQBNiQegkyTOi5N
 Qldg==
X-Gm-Message-State: AOJu0Ywt8n5BXrCntg5HXHuoaqg1mPOhhibzq7fj98W1NiGOJazK/Pn2
 3llKIRUOEuCZkqSha9W2YoTou6CIsZpr/zWzonOykCXLWUQHUw==
X-Google-Smtp-Source: AGHT+IFAv95+YsNh//IdZStDlls7Xr/lfWNU50Yn8vYpaRthtl6h/v+pPxS4x6tQRZ9WKT+Yhu6C62kZfCPl6Do3wV0=
X-Received: by 2002:a2e:86d4:0:b0:2cc:7db2:acb5 with SMTP id
 n20-20020a2e86d4000000b002cc7db2acb5mr1360536ljj.93.1704725202139; Mon, 08
 Jan 2024 06:46:42 -0800 (PST)
MIME-Version: 1.0
References: <20240108135849.351719-1-ines.varhol@telecom-paris.fr>
In-Reply-To: <20240108135849.351719-1-ines.varhol@telecom-paris.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Jan 2024 14:46:30 +0000
Message-ID: <CAFEAcA-ThK=fRQ0RNQJ0stNfYF3hH0bxP7z2N9sCvtWQD1b=Aw@mail.gmail.com>
Subject: Re: [PATCH v6 0/2] Add minimal support for the B-L475E-IOT01A board
To: =?UTF-8?B?SW7DqHMgVmFyaG9s?= <ines.varhol@telecom-paris.fr>
Cc: qemu-devel@nongnu.org, Samuel Tardieu <sam@rfc1149.net>, 
 Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Alexandre Iooss <erdnaxe@crans.org>, qemu-arm@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Alistair Francis <alistair@alistair23.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x230.google.com
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

On Mon, 8 Jan 2024 at 14:00, In=C3=A8s Varhol <ines.varhol@telecom-paris.fr=
> wrote:
>
> This patch adds a new STM32L4x5 SoC, it is necessary to add support for
> the B-L475E-IOT01A board.
> The implementation is derived from the STM32F405 SoC and NetduinoPlus2
> board.
> The implementation contains no peripherals, only memory regions are
> implemented.
>
> Changes from v5 to v6:
> - in `stm32l4x5_soc.c`: use boolean returned by `memory_region_init_rom()=
`
> and `memory_region_init_ram()` instead of checking `errp`
>
> Changes from v4 to v5:
> - in `b-l475e-iot01a.c`: adding missing machine/SoC parentship relation
> - in `b-l475e-iot01a.c`: renaming `SYSCLK_FRQ` macro
> to `MAIN_SYSCLK_FREQ_HZ`
> - in `b-l475e-iot01a.c`: fixing coding style issue
> - in `stm32l4x5_soc.h`: removing unused imports
>
> Changes from v3 to v4:
> - adding a documentation file for the B-L475E-IOT01A board
>
> Changes from v1 to v3:
> - changing the MIT license to GPL.
>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Acked-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
> Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>

Applied to target-arm.next. Thanks for this contribution
and for your work iterating through the code review process!

-- PMM

