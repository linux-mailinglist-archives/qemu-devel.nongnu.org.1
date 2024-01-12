Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FAD82C3DD
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 17:43:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOKbM-0007AO-PE; Fri, 12 Jan 2024 11:41:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rOKbK-00079y-NA
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 11:41:46 -0500
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rOKbI-0007ZZ-Ij
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 11:41:46 -0500
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2ccae380df2so72921711fa.1
 for <qemu-devel@nongnu.org>; Fri, 12 Jan 2024 08:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705077701; x=1705682501; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BEFF89OwKim9bxIDXoomIIhBg+ts+L6z4md1sRy870k=;
 b=t8TXCsl6lw8MzTJ9cKUX+ErTa804IzuWtmeZ3d/y7AhqK49yHB46MA4w4A+U2vCjrX
 sePW5Dt7LozXhToyNFxoXKhSorQmzuB+0v+t1ypkyxqEKgCGCW9c2U2sUMygsH5YhvlM
 6tQVjEvYkOUQBXVm6sLZkrag66fSHMiiWHWoD8c6kTO7hhHwyHWKgOphIM1mNkseOKUM
 Rr3VFFEsJpD08iGKsmGOjR5UDsbfFgcph1kYXG4oZt1MmlSq938pDCgzstYZiKbsBmIq
 Ig+lqwilkpqLmNXBT2+E/MOEhNF1+xYriVKlDGJoCGOAjlhRvabWbqosdf7utrKfqJwP
 vKzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705077701; x=1705682501;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BEFF89OwKim9bxIDXoomIIhBg+ts+L6z4md1sRy870k=;
 b=ARaGMUQGZCVo11ZVYxwQRkt670eubajjqTKo9ApnCCbcTDRG8Mo5KAJCzZtPZiCkN8
 VByZmpKkv1IH8G2H+muZuXv+1ZP6kFIueOSbiwcZcsNfAjQ7j7oDrlfb5kxubSCxZRfD
 jqpQS/DGRlA32GzIxXGFgYwQmiuleI2cHnbUKsMCIW+VxBclTqpMMJXLyA50GI9xwvMA
 MVWWluX6cPT1EOczTspbHfGLWdg36QlCH2pXgMrZzH9mwI+DZuVrU9OtFDGYoZwpUrgW
 9LMdwqSmTeADBF1PdnOfX3Yyf6Bv3heNA2i0uC9VOqnEXDf5TZiD9eUsS9CoSJpG0u4L
 954g==
X-Gm-Message-State: AOJu0YyIvt6lexIZGzWhaTnuCivLc8rhVUtYkUs2/5gcUS1X++regvHJ
 JP7fZmO2c0OwEsNHvb4+VZWtwrms/127E6j30JFHNuaNYTffxA==
X-Google-Smtp-Source: AGHT+IFWMfKEiJsqRmc2ekiDwya6XdYRUPze6mpsYCQFgZmzYlOBo+7MZfKmRu/+/hab5VSHqQsOJsMrZALMhW5mrc0=
X-Received: by 2002:a2e:8013:0:b0:2cc:ceb2:372a with SMTP id
 j19-20020a2e8013000000b002ccceb2372amr804945ljg.96.1705077701104; Fri, 12 Jan
 2024 08:41:41 -0800 (PST)
MIME-Version: 1.0
References: <20240102160455.68612-1-philmd@linaro.org>
 <20240102160455.68612-5-philmd@linaro.org>
In-Reply-To: <20240102160455.68612-5-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 12 Jan 2024 16:41:30 +0000
Message-ID: <CAFEAcA-qyLf_ACX-pD2nR8h+EcipqK_=re05wmBJBa93AOeg_Q@mail.gmail.com>
Subject: Re: [RFC PATCH 4/5] hw/arm/armv7m: Error if trying to set unavailable
 ARMCPU::vfp property
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-arm@nongnu.org, Luc Michel <luc.michel@amd.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Eduardo Habkost <eduardo@habkost.net>, 
 Frederic Konrad <fkonrad@amd.com>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x234.google.com
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

On Tue, 2 Jan 2024 at 16:05, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> Do not ignore impossible configuration requested by the user.
> For example, when trying to enable VFP on a Cortex-M33 we now get:
>
>   qemu-system-arm: 'cortex-m33-arm-cpu' does not support VFP
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  hw/arm/armv7m.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
> index 3610f6f4a1..12cdad09f9 100644
> --- a/hw/arm/armv7m.c
> +++ b/hw/arm/armv7m.c
> @@ -328,6 +328,9 @@ static void armv7m_realize(DeviceState *dev, Error **=
errp)
>          if (!object_property_set_bool(OBJECT(s->cpu), "vfp", s->vfp, err=
p)) {
>              return;
>          }
> +    } else if (s->vfp =3D=3D OPTIONAL_BOOL_TRUE) {
> +        error_setg(errp, "'%s' does not support VFP", s->cpu_type);
> +        return;
>      }

I'm not sure exactly what this series is trying to do, but
this isn't the right error message, at least at the moment.
Our Cortex-M33 model does support VFP -- in fact, there's
currently no way to turn it off, since we only expose the vfp
property for AArch64 CPUs.

I think we broke this in commit 4315f7c61474 last year,
accidentally restricting the definition of the "vfp"
property to ARM_FEATURE_AARCH64 CPUs only.
(filed https://gitlab.com/qemu-project/qemu/-/issues/2098
to track that)

I suppose if we fixed that regression then the error message
would become correct again, since we'd be back to exposing
the 'vfp' property only if the CPU did support VFP.

-- PMM

