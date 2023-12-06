Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 35426806347
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Dec 2023 01:15:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAfZ7-0003D6-Ip; Tue, 05 Dec 2023 19:15:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rAfZ6-0003Cp-A2; Tue, 05 Dec 2023 19:15:00 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rAfZ4-00061J-HY; Tue, 05 Dec 2023 19:15:00 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-54c74b3cd4cso689306a12.1; 
 Tue, 05 Dec 2023 16:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701821696; x=1702426496; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fdjNmWiuEF9lWxKO+Opvwumv+Sg7nnoZ1YFL1CIw5sY=;
 b=mmc42XQMDin/FZXjiyEp+C2te2cYHY//l0k5c3G8syEEyY1uzlB51UX5HKbqFhBerP
 DatKDPPkNLf59w3HfG17hiTutz7HoiGaj5I9Ovhqm9RrvPlC2mgozIVeS0g6v8qhJtec
 FC8SI72y48egP2CCzHYWpgpuG6vnEnb/kKcuxLrHirO1DgyCHWW/PwD4kQo6A8cy9OUs
 RAUWBfwd1rQFK6EH4cbXtXnHfwl0MdTmN8t2zJy24a5Zngg2qaKwB5N56xN5dmxJYUDj
 kgQCb3AyMjHr9mbq017dn3HlAqo7BgpBinM3ygLeeeISzSNobWtxPRGl4pG/NDtFDNJZ
 1lGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701821696; x=1702426496;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fdjNmWiuEF9lWxKO+Opvwumv+Sg7nnoZ1YFL1CIw5sY=;
 b=MCUrdvn7vJ6TPY/DyHYifQGf1bix/yKt63AWpxVAV1AMa9pFb3yX4ppkfLXXt7/+77
 gu0+8VNZPNR9cHzGQuyAaQ01eeC4XspDBBhq+EDydDza0RNej+h8sxGjpEzJl1HohBB2
 qVt+JnBy1Tamowyms8321xVkbcgu3dxV3zhWk6KgO8D2aDh6x3+gK+cxreRDxOxyyENY
 mPaC71ZQcNwOPGq1pdYGSm73DxpebqP6dInhMsj/kPzK6ArULIbKEQrbtZBVnx4E5GTe
 E1E6YgmXmVex/5sCqa0OqDEqlEFo3Xf1yeJFgSkJyeP+UWe1mDmdFsXGwWhQ3rzREaE8
 gXzA==
X-Gm-Message-State: AOJu0YzkP3p8gDxdYVMNd2fxnN7cE1hoKqiXkSvuIoqslzsfY0J84WOq
 CFn18MDEt+jMVcnUYghOfAe6eYkE3DkIrZ+Ovp5H/hxNubn9Zw==
X-Google-Smtp-Source: AGHT+IFv9wGwhB2SjBDyqbgYFkZBchJODoKLlZ66z5OMza0WGNyNzRYTEigu0cZHcSXyTOSr86KYInYK9TGVNECIuHM=
X-Received: by 2002:a50:d744:0:b0:54c:b24d:a3bb with SMTP id
 i4-20020a50d744000000b0054cb24da3bbmr57391edj.1.1701821696046; Tue, 05 Dec
 2023 16:14:56 -0800 (PST)
MIME-Version: 1.0
References: <20231124143505.1493184-1-fkonrad@amd.com>
 <20231124143505.1493184-2-fkonrad@amd.com>
In-Reply-To: <20231124143505.1493184-2-fkonrad@amd.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 6 Dec 2023 10:14:28 +1000
Message-ID: <CAKmqyKMp8=dZuu0oAn_i5Ye2Hbb4mTLv9GuuxVzyLFfdnVmyMA@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] hw/ssi/xilinx_spips: fix an out of bound access
To: Frederic Konrad <fkonrad@amd.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, francisco.iglesias@amd.com, 
 peter.maydell@linaro.org, edgar.iglesias@gmail.com, alistair@alistair23.me, 
 luc.michel@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x534.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Sat, Nov 25, 2023 at 12:38=E2=80=AFAM Frederic Konrad <fkonrad@amd.com> =
wrote:
>
> The spips, qspips, and zynqmp-qspips share the same realize function
> (xilinx_spips_realize) and initialize their io memory region with differe=
nt
> mmio_ops passed through the class.  The size of the memory region is set =
to
> the largest area (0x200 bytes for zynqmp-qspips) thus it is possible to w=
rite
> out of s->regs[addr] in xilinx_spips_write for spips and qspips.
>
> This fixes that wrong behavior.
>
> Reviewed-by: Luc Michel <luc.michel@amd.com>
> Signed-off-by: Frederic Konrad <fkonrad@amd.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/ssi/xilinx_spips.c         | 7 ++++++-
>  include/hw/ssi/xilinx_spips.h | 3 +++
>  2 files changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
> index a3955c6c50..0bdfad7e2e 100644
> --- a/hw/ssi/xilinx_spips.c
> +++ b/hw/ssi/xilinx_spips.c
> @@ -973,6 +973,8 @@ static void xilinx_spips_write(void *opaque, hwaddr a=
ddr,
>
>      DB_PRINT_L(0, "addr=3D" HWADDR_FMT_plx " =3D %x\n", addr, (unsigned)=
value);
>      addr >>=3D 2;
> +    assert(addr < XLNX_SPIPS_R_MAX);
> +
>      switch (addr) {
>      case R_CONFIG:
>          mask =3D ~(R_CONFIG_RSVD | MAN_START_COM);
> @@ -1299,7 +1301,7 @@ static void xilinx_spips_realize(DeviceState *dev, =
Error **errp)
>      }
>
>      memory_region_init_io(&s->iomem, OBJECT(s), xsc->reg_ops, s,
> -                          "spi", XLNX_ZYNQMP_SPIPS_R_MAX * 4);
> +                          "spi", xsc->reg_size);
>      sysbus_init_mmio(sbd, &s->iomem);
>
>      s->irqline =3D -1;
> @@ -1435,6 +1437,7 @@ static void xilinx_qspips_class_init(ObjectClass *k=
lass, void * data)
>
>      dc->realize =3D xilinx_qspips_realize;
>      xsc->reg_ops =3D &qspips_ops;
> +    xsc->reg_size =3D XLNX_SPIPS_R_MAX * 4;
>      xsc->rx_fifo_size =3D RXFF_A_Q;
>      xsc->tx_fifo_size =3D TXFF_A_Q;
>  }
> @@ -1450,6 +1453,7 @@ static void xilinx_spips_class_init(ObjectClass *kl=
ass, void *data)
>      dc->vmsd =3D &vmstate_xilinx_spips;
>
>      xsc->reg_ops =3D &spips_ops;
> +    xsc->reg_size =3D XLNX_SPIPS_R_MAX * 4;
>      xsc->rx_fifo_size =3D RXFF_A;
>      xsc->tx_fifo_size =3D TXFF_A;
>  }
> @@ -1464,6 +1468,7 @@ static void xlnx_zynqmp_qspips_class_init(ObjectCla=
ss *klass, void * data)
>      dc->vmsd =3D &vmstate_xlnx_zynqmp_qspips;
>      device_class_set_props(dc, xilinx_zynqmp_qspips_properties);
>      xsc->reg_ops =3D &xlnx_zynqmp_qspips_ops;
> +    xsc->reg_size =3D XLNX_ZYNQMP_SPIPS_R_MAX * 4;
>      xsc->rx_fifo_size =3D RXFF_A_Q;
>      xsc->tx_fifo_size =3D TXFF_A_Q;
>  }
> diff --git a/include/hw/ssi/xilinx_spips.h b/include/hw/ssi/xilinx_spips.=
h
> index 1386d5ac8f..7a754bf67a 100644
> --- a/include/hw/ssi/xilinx_spips.h
> +++ b/include/hw/ssi/xilinx_spips.h
> @@ -33,7 +33,9 @@
>
>  typedef struct XilinxSPIPS XilinxSPIPS;
>
> +/* For SPIPS, QSPIPS.  */
>  #define XLNX_SPIPS_R_MAX        (0x100 / 4)
> +/* For ZYNQMP_QSPIPS.  */
>  #define XLNX_ZYNQMP_SPIPS_R_MAX (0x200 / 4)
>
>  /* Bite off 4k chunks at a time */
> @@ -125,6 +127,7 @@ struct XilinxSPIPSClass {
>      SysBusDeviceClass parent_class;
>
>      const MemoryRegionOps *reg_ops;
> +    uint64_t reg_size;
>
>      uint32_t rx_fifo_size;
>      uint32_t tx_fifo_size;
> --
> 2.25.1
>
>

