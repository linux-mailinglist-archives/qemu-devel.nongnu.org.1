Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE6482595F
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 18:49:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLoIs-0005pO-Co; Fri, 05 Jan 2024 12:48:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rLoIq-0005nz-CE
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 12:48:16 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rLoIo-0007e5-52
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 12:48:16 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5572291a5abso1156456a12.1
 for <qemu-devel@nongnu.org>; Fri, 05 Jan 2024 09:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704476892; x=1705081692; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jT+1Fj9CgUZMOGxV3spXXzP+plgpceBw8GIXbcRQ2n0=;
 b=W6ON2kyPuy2kKj7bRL9RkjkOjtENoMGf0dTG6+470lADw/2f4ZEqD6scy35AYO0CwL
 S/SXdY97XgzasM/qaV8Q6tubMk8Aq7chByAA+FlJidoMG2uHyDpclyqy0bcdPDb24eAI
 AxEpRAfGp7duPZd/skWgzL0zexItwYryLqp4eKtqMMusVqbmccUm0j2VNX74EbrAaHoB
 Od8g5xta85moWDSdrQdTbPum3OAa+YWmEFnXxmM9q47oy3mBdMrd6iFUDq/VnZBgdDea
 WhuAZj+ZyyNTkw5y0CHnmg7jGvLufXiRdHRgXDCnCoV4Qk8dzrWxSyvVFc2f10gaxB8Q
 FNtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704476892; x=1705081692;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jT+1Fj9CgUZMOGxV3spXXzP+plgpceBw8GIXbcRQ2n0=;
 b=SWuGCyWn5lpFRQWxR2Ou6mSSgo2keH7AsiCUqbGiLKhYMNkfxLFGt0123nz8uVUyZr
 yZPPwB74TL5fC2Qf0gLIP/yyUCpEFvDJioIXKQa0Pho3paOgGjvxIHOcnVzuLn1XzeFo
 V0UlaMxDwEc9/yRemAHlAUi1BewrLC9W4wlqaBXYFKMb/eGwZEaASGtMWLVIDUe07T9l
 wP6HHwAO+18GFu9fBYfPPxxd3OlBbj+S2V3MNoe0+f6i9pU1DdtJG36Jq7+Efa/OgWl/
 tNv2BfU/TPuJeUU56sER50vFFM5NJSZlYLy8cp9eKiKun5wjDPk+nRArE/osBZycAIEV
 BEpA==
X-Gm-Message-State: AOJu0Yw4Hifro952WqPXFb9bj+K3TiOpLtEkJnxmScdln7ppUcFIX4gD
 7YqO06FPaEgvpdIQASmH8q2/cUGz5h+bWtz6Vy3WulEkbQ/NEw==
X-Google-Smtp-Source: AGHT+IFEtgpZLCB2JKdyeKHdgWJXfOfPi6QKcXVpHUL6O1d3LclTEBbpJ7udGGP5YIfuFrZf6CxxjP8oLDzLpQpxnRk=
X-Received: by 2002:a50:ab12:0:b0:557:2029:de30 with SMTP id
 s18-20020a50ab12000000b005572029de30mr635559edc.27.1704476892521; Fri, 05 Jan
 2024 09:48:12 -0800 (PST)
MIME-Version: 1.0
References: <20240103155337.2026946-1-sam@rfc1149.net>
 <20240103155337.2026946-3-sam@rfc1149.net>
In-Reply-To: <20240103155337.2026946-3-sam@rfc1149.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 5 Jan 2024 17:48:01 +0000
Message-ID: <CAFEAcA8k22X+8Ypw_gvpsFHVAm=pHnB2-_iVNwyMrHhhyP=JRA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] hw/arm/armv7m: alias the NVIC "num-prio-bits"
 property
To: Samuel Tardieu <sam@rfc1149.net>
Cc: qemu-devel@nongnu.org, Arnaud Minier <arnaud.minier@telecom-paris.fr>, 
 qemu-arm@nongnu.org, Anton Kochkov <anton.kochkov@proton.me>, 
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?B?SW7DqHMgVmFyaG9s?= <ines.varhol@telecom-paris.fr>, 
 Alexandre Iooss <erdnaxe@crans.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

On Wed, 3 Jan 2024 at 15:53, Samuel Tardieu <sam@rfc1149.net> wrote:
>
> A SoC will not have a direct access to the NVIC embedded in its ARM
> core. By aliasing the "num-prio-bits" property similarly to what is
> done for the "num-irq" one, a SoC can easily configure it on its
> armv7m instance.
>
> Signed-off-by: Samuel Tardieu <sam@rfc1149.net>
> ---
>  hw/arm/armv7m.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
> index d10abb36a8..4fda2d1d47 100644
> --- a/hw/arm/armv7m.c
> +++ b/hw/arm/armv7m.c
> @@ -256,6 +256,8 @@ static void armv7m_instance_init(Object *obj)
>      object_initialize_child(obj, "nvic", &s->nvic, TYPE_NVIC);
>      object_property_add_alias(obj, "num-irq",
>                                OBJECT(&s->nvic), "num-irq");
> +    object_property_add_alias(obj, "num-prio-bits",
> +                              OBJECT(&s->nvic), "num-prio-bits");
>
>      object_initialize_child(obj, "systick-reg-ns", &s->systick[M_REG_NS],
>                              TYPE_SYSTICK);

There's a comment in include/hw/arm/armv7m.h which documents
all the GPIO inputs, QOM properties, etc, that this device
has -- that also needs a line adding to it for this property.

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

