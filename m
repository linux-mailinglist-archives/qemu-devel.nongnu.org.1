Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E657D2267
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 11:47:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quV3P-0007Fv-4M; Sun, 22 Oct 2023 05:47:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1quV3N-0007Fg-Ai
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:47:25 -0400
Received: from mail-ed1-f51.google.com ([209.85.208.51])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1quV3L-0004Qx-OP
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:47:25 -0400
Received: by mail-ed1-f51.google.com with SMTP id
 4fb4d7f45d1cf-53e08e439c7so3563392a12.0
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 02:47:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697968042; x=1698572842;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8GjMZTBqeVIdzMHIlHHej3fWThNQOlQRlgMRRNJVCxM=;
 b=nL1q4EMt1Nk90mPDHyF4ZykTsk3MYdWviBEmWnQfRSbx34jIciwuvhKq7z3ku+PY20
 bGrg6l2yLnCC+tRyysprZYX5+HJ2VcQn252A8O9l7ToTONesUUpvP6xhgg73vOeVYzmt
 2zKJ+vKQCOahG4l101CEaHQDQGFeMuMQv3IBwy5S9h3Z7I6Kl9VmKzDMbx40cUiPk/Uz
 GurZincNH4J61pymCuo8msWsnPwH8pdMYVJeryOvqnakFnpr3b9s7oCuqE5CywvjqzmS
 Qdf4JVijH09c5s5ZUDD7uYuyIlGeSxS/SHVmQniJKSZLxqnMUqnZLLsGNjz98lK4xIt0
 uijA==
X-Gm-Message-State: AOJu0YwhF0kqTxiu1yD2HAdsYsu1D5HavWrXVaHPXu4RWKa1LM5/37st
 IH/pXYnz2os6ljWy1KKvwT60DZ1MafE=
X-Google-Smtp-Source: AGHT+IEuGHnxyIP49KV66D7hSPzj94kxbJo10t533l4hcHuTNCD/ilIUCbT1IaSilQwty0VIQ5/jvw==
X-Received: by 2002:a50:d593:0:b0:53d:a0c9:dbd4 with SMTP id
 v19-20020a50d593000000b0053da0c9dbd4mr3927540edi.21.1697968042212; 
 Sun, 22 Oct 2023 02:47:22 -0700 (PDT)
Received: from fedora (ip-109-43-176-141.web.vodafone.de. [109.43.176.141])
 by smtp.gmail.com with ESMTPSA id
 a11-20020a50858b000000b0052e1783ab25sm4557975edh.70.2023.10.22.02.47.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 02:47:21 -0700 (PDT)
Date: Sun, 22 Oct 2023 11:47:20 +0200
From: Thomas Huth <huth@tuxfamily.org>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH] hw/char/mcf_uart: Have mcf_uart_create() return
 DeviceState
Message-ID: <20231022114720.3da1f2eb@fedora>
In-Reply-To: <20231019104929.16517-1-philmd@linaro.org>
References: <20231019104929.16517-1-philmd@linaro.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.208.51; envelope-from=th.huth@gmail.com;
 helo=mail-ed1-f51.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Am Thu, 19 Oct 2023 12:49:29 +0200
schrieb Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>:

> There is no point in having mcf_uart_init() demote the DeviceState
> pointer and return a void one. Directly return the real typedef.
>=20
> mcf_uart_init() do both init + realize: rename as mcf_uart_create().
>=20
> Similarly, mcf_uart_mm_init() do init / realize / mmap: rename as
> mcf_uart_create_mmap().
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  include/hw/m68k/mcf.h |  4 ++--
>  hw/char/mcf_uart.c    | 13 +++++++------
>  hw/m68k/mcf5206.c     |  6 +++---
>  hw/m68k/mcf5208.c     |  6 +++---
>  4 files changed, 15 insertions(+), 14 deletions(-)
>=20
> diff --git a/include/hw/m68k/mcf.h b/include/hw/m68k/mcf.h
> index 8cbd587bbf..5d9f876ffe 100644
> --- a/include/hw/m68k/mcf.h
> +++ b/include/hw/m68k/mcf.h
> @@ -10,8 +10,8 @@ uint64_t mcf_uart_read(void *opaque, hwaddr addr,
>                         unsigned size);
>  void mcf_uart_write(void *opaque, hwaddr addr,
>                      uint64_t val, unsigned size);
> -void *mcf_uart_init(qemu_irq irq, Chardev *chr);
> -void mcf_uart_mm_init(hwaddr base, qemu_irq irq, Chardev *chr);
> +DeviceState *mcf_uart_create(qemu_irq irq, Chardev *chr);
> +DeviceState *mcf_uart_create_mmap(hwaddr base, qemu_irq irq, Chardev *ch=
r);
> =20
>  /* mcf_intc.c */
>  qemu_irq *mcf_intc_init(struct MemoryRegion *sysmem,
> diff --git a/hw/char/mcf_uart.c b/hw/char/mcf_uart.c
> index 6fa4ac502c..f9cbc9bdc4 100644
> --- a/hw/char/mcf_uart.c
> +++ b/hw/char/mcf_uart.c
> @@ -342,25 +342,26 @@ static void mcf_uart_register(void)
> =20
>  type_init(mcf_uart_register)
> =20
> -void *mcf_uart_init(qemu_irq irq, Chardev *chrdrv)
> +DeviceState *mcf_uart_create(qemu_irq irq, Chardev *chrdrv)
>  {
> -    DeviceState  *dev;
> +    DeviceState *dev;
> =20
>      dev =3D qdev_new(TYPE_MCF_UART);
>      if (chrdrv) {
>          qdev_prop_set_chr(dev, "chardev", chrdrv);
>      }
>      sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> -
>      sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq);
> =20
>      return dev;
>  }
> =20
> -void mcf_uart_mm_init(hwaddr base, qemu_irq irq, Chardev *chrdrv)
> +DeviceState *mcf_uart_create_mmap(hwaddr base, qemu_irq irq, Chardev *ch=
rdrv)
>  {
> -    DeviceState  *dev;
> +    DeviceState *dev;
> =20
> -    dev =3D mcf_uart_init(irq, chrdrv);
> +    dev =3D mcf_uart_create(irq, chrdrv);
>      sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
> +
> +    return dev;
>  }

Changing the return type (and name) of mcf_uart_mm_init() seems to be
unnecessary. Could you please drop that change?

 Thomas


> diff --git a/hw/m68k/mcf5206.c b/hw/m68k/mcf5206.c
> index 2ab1b4f059..673861574c 100644
> --- a/hw/m68k/mcf5206.c
> +++ b/hw/m68k/mcf5206.c
> @@ -167,7 +167,7 @@ typedef struct {
>      MemoryRegion iomem;
>      qemu_irq *pic;
>      m5206_timer_state *timer[2];
> -    void *uart[2];
> +    DeviceState *uart[2];
>      uint8_t scr;
>      uint8_t icr[14];
>      uint16_t imr; /* 1 =3D=3D interrupt is masked.  */
> @@ -599,8 +599,8 @@ static void mcf5206_mbar_realize(DeviceState *dev, Er=
ror **errp)
>      s->pic =3D qemu_allocate_irqs(m5206_mbar_set_irq, s, 14);
>      s->timer[0] =3D m5206_timer_init(s->pic[9]);
>      s->timer[1] =3D m5206_timer_init(s->pic[10]);
> -    s->uart[0] =3D mcf_uart_init(s->pic[12], serial_hd(0));
> -    s->uart[1] =3D mcf_uart_init(s->pic[13], serial_hd(1));
> +    s->uart[0] =3D mcf_uart_create(s->pic[12], serial_hd(0));
> +    s->uart[1] =3D mcf_uart_create(s->pic[13], serial_hd(1));
>      s->cpu =3D M68K_CPU(qemu_get_cpu(0));
>  }
> =20
> diff --git a/hw/m68k/mcf5208.c b/hw/m68k/mcf5208.c
> index be1033f84f..d22d8536db 100644
> --- a/hw/m68k/mcf5208.c
> +++ b/hw/m68k/mcf5208.c
> @@ -261,9 +261,9 @@ static void mcf5208evb_init(MachineState *machine)
>      /* Internal peripherals.  */
>      pic =3D mcf_intc_init(address_space_mem, 0xfc048000, cpu);
> =20
> -    mcf_uart_mm_init(0xfc060000, pic[26], serial_hd(0));
> -    mcf_uart_mm_init(0xfc064000, pic[27], serial_hd(1));
> -    mcf_uart_mm_init(0xfc068000, pic[28], serial_hd(2));
> +    mcf_uart_create_mmap(0xfc060000, pic[26], serial_hd(0));
> +    mcf_uart_create_mmap(0xfc064000, pic[27], serial_hd(1));
> +    mcf_uart_create_mmap(0xfc068000, pic[28], serial_hd(2));


