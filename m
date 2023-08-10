Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB7B777A2B
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 16:11:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU6MB-000340-46; Thu, 10 Aug 2023 10:09:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qU6M5-000321-U5
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 10:09:38 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qU6M4-0003Bx-9H
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 10:09:37 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5236c9ff275so1257894a12.1
 for <qemu-devel@nongnu.org>; Thu, 10 Aug 2023 07:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691676574; x=1692281374;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Or+SN1P+qniOlJa7fh3LeBLSqmGsi514YxLEzNOhGGw=;
 b=MeJj0qTcznUHqVWV609a82Fz5okb1XIz9PpD2ZU5F2fndqOdd0Iq/J9OxnV9CntGyU
 NiA69s2t0HNJt7owvlg5jS6IHc3ahrZxWUo4zeZAgsHrMHoiPEMYcqVbSOx1TcpoYbRa
 ufDSCVpbeP8P5hZyywbzRa45uizgYH3WA1o5xuCC8HxLapc9BrW1NuAMBFDqSHsXw1Rv
 9q+0fYjMabNOZgHuB0jjPSjXU9smV6Nw4+SZuhEMjd7iLTurhJ6SyJuE+PetEt4p4IUy
 trC88GyGIFdN2eg4FSMd5fcERBsv0coJc9GNvbsgfxtfc+4VFcO0CEqb+KBWeeJc9MJw
 yowA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691676574; x=1692281374;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Or+SN1P+qniOlJa7fh3LeBLSqmGsi514YxLEzNOhGGw=;
 b=Qy20zz3fly76eyOLCtlG0xIQp4x1DsrFjHC8A3Ny144D0KM7jkFIDUTrHa/TJC2z3j
 DwfbCM4z/k440LH8iBzkZE0D4xTQrSmsfH6Ad2RrubzJ6yJfJz/w+gZDQDW03zoJKllk
 AjDtxRq1llcLjHaeEa6WiU+9ou3Rj4o7VuuLJVGmoMGviciPshxSuPNsrV3Hiwx9gDmm
 xmtB8eSri9d7PLdOPpQf4NKG1eXK+Ka+c+8RuGKkbQKn4yMnn6s47a32eUPG5cofoAgY
 NV4EtvFGT+PPA1EYef1W2ZAx9HslOuqJsDRr7mFTgml0c1qiXGqs8Ey26bavw8l63A9S
 7tPQ==
X-Gm-Message-State: AOJu0Yz30qnmYgN7aV/whAFiNcCIGDjKj0O3LJWQVhGajCfznd5I8ibS
 EpdFoMQj5hJVpaN++N05Ro/svsIiIMNcfOKIO50oaA==
X-Google-Smtp-Source: AGHT+IE9JsPB4+MRylV0pxDNCfflj0nIhBEkJ3f6eV/AmT5ZLfLmjqIaoXumK8GeJy/K3yhpaF2dD5y+U56DuuufWaA=
X-Received: by 2002:aa7:c30f:0:b0:523:3e61:c044 with SMTP id
 l15-20020aa7c30f000000b005233e61c044mr2329873edq.23.1691676573668; Thu, 10
 Aug 2023 07:09:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230810023548.412310-1-richard.henderson@linaro.org>
 <20230810023548.412310-3-richard.henderson@linaro.org>
In-Reply-To: <20230810023548.412310-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 Aug 2023 15:09:22 +0100
Message-ID: <CAFEAcA9JC_-R5AsvmtBK+ngb7LEuvaxU_7UT2U+jDvze7CqyxQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] target/arm: Reduce dcz_blocksize to uint8_t
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
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

On Thu, 10 Aug 2023 at 03:37, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This value is only 4 bits wide.

True. Any particular reason to change the type, though?

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

