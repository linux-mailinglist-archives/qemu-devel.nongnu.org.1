Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E5983812E76
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Dec 2023 12:24:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDjp2-0001Cd-IG; Thu, 14 Dec 2023 06:24:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rDjp1-0001CT-Bt
 for qemu-devel@nongnu.org; Thu, 14 Dec 2023 06:24:07 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rDjoz-0006mB-5Y
 for qemu-devel@nongnu.org; Thu, 14 Dec 2023 06:24:07 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-54c846da5e9so7496279a12.3
 for <qemu-devel@nongnu.org>; Thu, 14 Dec 2023 03:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702553043; x=1703157843; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s6GSrMHhCyV9l++DIiKx2H1WRv40mBKulk8S9B3/7L4=;
 b=FwPoAyJQ3Rf+XS1VMP9NKKL81lzuIVTKMMpdV0qnwC5VQAGqqrf6fpQ8EqkwqAv7ip
 QwbAP3tHlAzmLnNcEE2z2jgrHOtwdLz2y0X5KPnEWqlIkUV0hixgpSEj683HiqDi/ogr
 v8Tr5Op5DAkVxformi3zf+EMGMttJnykfBm44pqcT9P3oLYr0C8vngoudH1aiRQVGnF6
 0SZ5khwTIAUuHYSWLs7l8IGBAEqJOVFdqtnfKoc0aix9JDWGg/bYt0kX41533biRmzml
 d+Gzyd4QNBboKethTU3YBIkOwo+DKtLuqUtuxgneLWO/uKbo0nr55J6ssPYOAX+Cf9R9
 Vj4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702553043; x=1703157843;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s6GSrMHhCyV9l++DIiKx2H1WRv40mBKulk8S9B3/7L4=;
 b=XF1Jqqx0NTECs0UktJg7Dp52eyBdLTBJCm8G9PY4ObhJhByRLsW6o+QOkTU5XTzbTs
 t9tEb5Y5+r6rdkaqlS+CZXMGPEhIgK/FRFLWXtOTdNd0crIbX7dgV74fEJGFl8acqBdO
 bEaJqMaa4+moWKDYblani0+zAOnQwrtO1y4khTUErHgo0HzUGTJwEVl00vSFo1Ih04Jq
 SKs9t2i3WrU559QBexYJhEa2WcOfIQ14y8679GfT4zbW9GDdVYcamyAxW/HQlKIdhhsK
 SiFn1Hswp1irA7ohRPt2R70GsytJu70qD2dqxsspCKOM+UkThyhgdqh0akMuhWaF4mBp
 f1kQ==
X-Gm-Message-State: AOJu0YyEoRDU5Q7GOFjWY5+DFk3FNLnhzXOcbHaLYPUrsqaZxcM7ZBz8
 uGOrHHDaeDthMa49krw6OacUKBihEVhmEt2KkdIV2A==
X-Google-Smtp-Source: AGHT+IHF2imRye3WUk1lCA5A9KB4VhaBzCydQgDtKEhvOR38AXKOLiQIfTTxk4aNyloAtY9JpjtzF6ltehCWoMyGC7o=
X-Received: by 2002:a50:d50b:0:b0:552:72cf:1cf6 with SMTP id
 u11-20020a50d50b000000b0055272cf1cf6mr415427edi.27.1702553043096; Thu, 14 Dec
 2023 03:24:03 -0800 (PST)
MIME-Version: 1.0
References: <170198625302.23093.6056065304261752852-0@git.sr.ht>
 <170198625302.23093.6056065304261752852-2@git.sr.ht>
In-Reply-To: <170198625302.23093.6056065304261752852-2@git.sr.ht>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Dec 2023 11:23:52 +0000
Message-ID: <CAFEAcA-nLiWq9yZBDx+zGY4JMDE1pZE96v=TwF7V5=cr=3RQ-A@mail.gmail.com>
Subject: Re: [PATCH qemu v2 2/2] hw/arm: Add minimal support for the
 B-L475E-IOT01A board
To: "~inesvarhol" <inesvarhol@proton.me>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, alistair@alistair23.me, 
 philmd@linaro.org, alex.bennee@linaro.org, ines.varhol@telecom-paris.fr, 
 arnaud.minier@telecom-paris.fr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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

On Thu, 7 Dec 2023 at 21:57, ~inesvarhol <inesvarhol@git.sr.ht> wrote:
>
> From: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
>
> This commit adds a new B-L475E-IOT01A board using the STM32L475VG SoC.
> The implementation is derived from the Netduino Plus 2 machine.
> There are no peripherals implemented yet, only memory regions.
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>
> Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
> Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>

Hi; thanks for this patch.

> +++ b/hw/arm/b-l475e-iot01a.c
> @@ -0,0 +1,79 @@
> +/*
> + * B-L475E-IOT01A Discovery Kit machine
> + * (B-L475E-IOT01A IoT Node)
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later

This line says "this is under the GPL"...

> + *
> + * Copyright (c) 2023 Arnaud Minier <arnaud.minier@telecom-paris.fr>
> + * Copyright (c) 2023 Ines Varhol <ines.varhol@telecom-paris.fr>
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
> + * of this software and associated documentation files (the "Software"),=
 to deal
> + * in the Software without restriction, including without limitation the=
 rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or =
sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHA=
LL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR =
OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISI=
NG FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING=
S IN
> + * THE SOFTWARE.

...but this text is not the GPL, it is the MIT license.

> + *
> + * Heavily inspired by the netduinoplus2 by Alistair Francis.
> + * The reference used is the STMicroElectronics UM2153 User manual
> + * Discovery kit for IoT node, multi-channel communication with STM32L4.
> + * https://www.st.com/en/evaluation-tools/b-l475e-iot01a.html#documentat=
ion
> + */
> +

Can you clarify which license you want to use, please? We can't
take code that's confused about what license it's under.

thanks
-- PMM

