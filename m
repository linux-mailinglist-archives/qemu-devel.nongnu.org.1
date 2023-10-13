Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D25C47C8C07
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 19:09:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrLdt-00059J-6Y; Fri, 13 Oct 2023 13:08:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qrLdp-00058v-Ly
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 13:08:01 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qrLdo-0004cB-2N
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 13:08:01 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40684f53bfcso23368595e9.0
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 10:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697216878; x=1697821678; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Icy7e5zl/BateRtTTMAd5fQSzz+F7jAjgfr37s2uhqo=;
 b=rhW7iYU6oMT7Eb2DCCuu1/VeLShK7BUDTf696d/Oy2qbXaNs49EMNve0AIyK/drYYz
 IBovvouEe+s9MZa2VCylIgcw+r7co+Dkdzef1TKfJtbY6NW/ukYjxSYQ45L8mxj+BLkQ
 jvtmKEFX07TpD0q3BQeJ/UGQ3xg6KUtrVZlX4/OkapLt1zCqHlmL40LIGwwDcPElNJRH
 El4q8nnM3UzJM5J4hS1FJfTXT5rAJhKhytwf3qUZljees0ZJSmOktFZbLTPx2WDI44yJ
 AvSnGLHrXNSMVGvrGzgaHFtNMJhYUFIUa+JsFR7/uyQX/RwLefcRIYzh+OKdY9ZUd9N3
 yyuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697216878; x=1697821678;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Icy7e5zl/BateRtTTMAd5fQSzz+F7jAjgfr37s2uhqo=;
 b=booZi9lKwf/o9QmYem6f4EuGWcEPE+D4WBb1OlUIXUwnuUJoIb7xCbeWt+gFpeK1Jz
 TXFi2CSczyQf3vxUpQ60RqZh5gChFjLsAnuRCdzTWKOWQHqocSm2H2SLxpkLLn61vIZd
 TzBBL/TYVbooT1Up+POhD7IDQWk9agmtRdv5wZ87mBUvKNKtQqmyPXOhXC5QS78lMZNu
 YThPc7fHpriYtIEI82bXGR7Pu7RVgFz/S/DE5vq6ur124q3M+rfg7WPT78FpPbdpD9VU
 y6iThwQOzmmZ25qmttv9AnF6PMHKG2+3GpvT7NUq9Q7kBSFgXZAQmeI0UgerxNyt7+E1
 UiIA==
X-Gm-Message-State: AOJu0Yw9hYY5stYlsC+SnNHJ4n0RnqYXNZggiBalU8uVG9A+OONOL3iR
 ZTQmfVCEtV+Sa86TvEtxIkNEwA==
X-Google-Smtp-Source: AGHT+IFtma9x52VhEhwh6mAK1IOLejCCY2cHsPnBB51ZAnezfXlZaOrbpowkz9pHQJNiBI0m+g731g==
X-Received: by 2002:a1c:4c09:0:b0:401:b204:3b97 with SMTP id
 z9-20020a1c4c09000000b00401b2043b97mr25421921wmf.4.1697216877817; 
 Fri, 13 Oct 2023 10:07:57 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 be3-20020a05600c1e8300b0040644e699a0sm640447wmb.45.2023.10.13.10.07.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 10:07:57 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0DF501FFBB;
 Fri, 13 Oct 2023 18:07:57 +0100 (BST)
References: <20231013141131.1531-1-philmd@linaro.org>
 <20231013141131.1531-10-philmd@linaro.org>
User-agent: mu4e 1.11.22; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Evgeny
 Iakovlev <eiakovlev@linux.microsoft.com>, =?utf-8?Q?Marc-Andr=C3=A9?=
 Lureau <marcandre.lureau@redhat.com>, Gavin Shan <gshan@redhat.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v3 9/10] hw/char/pl011: Add transmit FIFO to PL011State
Date: Fri, 13 Oct 2023 18:05:05 +0100
In-reply-to: <20231013141131.1531-10-philmd@linaro.org>
Message-ID: <87edhylac2.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
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


Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> In order to make the next commit easier to review,
> introduce the transmit FIFO, but do not yet use it.

might be worth mentioning the migration bits here as well.

>
> Uninline pl011_reset_tx_fifo().
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  include/hw/char/pl011.h |  2 ++
>  hw/char/pl011.c         | 35 +++++++++++++++++++++++++++++++++--
>  2 files changed, 35 insertions(+), 2 deletions(-)
>
> diff --git a/include/hw/char/pl011.h b/include/hw/char/pl011.h
> index d853802132..20898f43a6 100644
> --- a/include/hw/char/pl011.h
> +++ b/include/hw/char/pl011.h
> @@ -18,6 +18,7 @@
>  #include "hw/sysbus.h"
>  #include "chardev/char-fe.h"
>  #include "qom/object.h"
> +#include "qemu/fifo8.h"
>=20=20
>  #define TYPE_PL011 "pl011"
>  OBJECT_DECLARE_SIMPLE_TYPE(PL011State, PL011)
> @@ -53,6 +54,7 @@ struct PL011State {
>      Clock *clk;
>      bool migrate_clk;
>      const unsigned char *id;
> +    Fifo8 xmit_fifo;
>  };
>=20=20
>  DeviceState *pl011_create(hwaddr addr, qemu_irq irq, Chardev *chr);
> diff --git a/hw/char/pl011.c b/hw/char/pl011.c
> index 727decd428..9d98bd8f9a 100644
> --- a/hw/char/pl011.c
> +++ b/hw/char/pl011.c
> @@ -147,11 +147,13 @@ static inline void pl011_reset_rx_fifo(PL011State *=
s)
>      s->flags |=3D PL011_FLAG_RXFE;
>  }
>=20=20
> -static inline void pl011_reset_tx_fifo(PL011State *s)
> +static void pl011_reset_tx_fifo(PL011State *s)
>  {
>      /* Reset FIFO flags */
>      s->flags &=3D ~PL011_FLAG_TXFF;
>      s->flags |=3D PL011_FLAG_TXFE;
> +
> +    fifo8_reset(&s->xmit_fifo);
>  }
>=20=20
>  static void pl011_write_txdata(PL011State *s, uint8_t data)
> @@ -436,6 +438,22 @@ static const VMStateDescription vmstate_pl011_clock =
=3D {
>      }
>  };
>=20=20
> +static bool pl011_xmit_fifo_state_needed(void *opaque)
> +{
> +    return false;
> +}
> +
> +static const VMStateDescription vmstate_pl011_xmit_fifo =3D {
> +    .name =3D "pl011/xmit_fifo",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .needed =3D pl011_xmit_fifo_state_needed,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_FIFO8(xmit_fifo, PL011State),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>  static int pl011_post_load(void *opaque, int version_id)
>  {
>      PL011State* s =3D opaque;
> @@ -487,7 +505,11 @@ static const VMStateDescription vmstate_pl011 =3D {
>      .subsections =3D (const VMStateDescription * []) {
>          &vmstate_pl011_clock,
>          NULL
> -    }
> +    },
> +    .subsections =3D (const VMStateDescription * []) {
> +        &vmstate_pl011_xmit_fifo,
> +        NULL
> +    },
>  };

Doesn't this necessitate the bumping of the migration version data or
do we not worry about new -> old migrations?

>=20=20
>  static Property pl011_properties[] =3D {
> @@ -502,6 +524,7 @@ static void pl011_init(Object *obj)
>      PL011State *s =3D PL011(obj);
>      int i;
>=20=20
> +    fifo8_create(&s->xmit_fifo, PL011_FIFO_DEPTH);
>      memory_region_init_io(&s->iomem, OBJECT(s), &pl011_ops, s, "pl011", =
0x1000);
>      sysbus_init_mmio(sbd, &s->iomem);
>      for (i =3D 0; i < ARRAY_SIZE(s->irq); i++) {
> @@ -514,6 +537,13 @@ static void pl011_init(Object *obj)
>      s->id =3D pl011_id_arm;
>  }
>=20=20
> +static void pl011_finalize(Object *obj)
> +{
> +    PL011State *s =3D PL011(obj);
> +
> +    fifo8_destroy(&s->xmit_fifo);
> +}
> +
>  static void pl011_realize(DeviceState *dev, Error **errp)
>  {
>      PL011State *s =3D PL011(dev);
> @@ -557,6 +587,7 @@ static const TypeInfo pl011_arm_info =3D {
>      .parent        =3D TYPE_SYS_BUS_DEVICE,
>      .instance_size =3D sizeof(PL011State),
>      .instance_init =3D pl011_init,
> +    .instance_finalize =3D pl011_finalize,
>      .class_init    =3D pl011_class_init,
>  };

Otherwise:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

