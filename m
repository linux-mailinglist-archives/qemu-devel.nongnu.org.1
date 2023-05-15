Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E2789703DE7
	for <lists+qemu-devel@lfdr.de>; Mon, 15 May 2023 21:55:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyeHK-0005tA-EG; Mon, 15 May 2023 15:54:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nieklinnenbank@gmail.com>)
 id 1pyeHH-0005pw-VY; Mon, 15 May 2023 15:54:39 -0400
Received: from mail-yb1-xb2a.google.com ([2607:f8b0:4864:20::b2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nieklinnenbank@gmail.com>)
 id 1pyeHF-0004NO-3f; Mon, 15 May 2023 15:54:39 -0400
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-ba76528fe31so211636276.1; 
 Mon, 15 May 2023 12:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684180475; x=1686772475;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hSJ84WBWRFdA0KAY4YSVO2Toewk4qdopM1R9Gge++kQ=;
 b=TT0P8XAcmcDvdBpWzCGiN8JfjpjTfmXOsAEDfOUDtSIXdixDjPNatyi0wUfBnMPGA0
 o9dHftVY5qs0THdxj9OFnIDZqvlt82PCxdpkj3kGf52PNlveD0kpXmPOJJQJvVniFQdz
 5wXKAI2W3nyIZUP/XHRMSEU785jnw6VtWGAG8xs7gyBXqgUB+0bDKgFoOJEi467TiucU
 wU0IBscqe6ho0zTdGdciXu99TwFKwLwlW3xmP8WgCMqoZAeJuDNE9etJUpnyrtu/r7sC
 7UFuoVwV/jFN+QzxKsLDWK+ne4MqfrPEqeWYYdUVfmujt1Z4r4FA5PhxkHbua8WkJNhL
 TpMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684180475; x=1686772475;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hSJ84WBWRFdA0KAY4YSVO2Toewk4qdopM1R9Gge++kQ=;
 b=FziC8Ew9zKWn+CeDe0Vj205ZSOqe7l1GwSOQeR6H42+Zz4cWvuYEvIWd551mAgnRWk
 z3SomgC0j1JLJC3jiWEa8Qx6blf2NM6yAKDM/o+MLmShoMaOkGaqV/qSartrwmpz9BGd
 M3+CvghSgPTKP9kqOT2Ap2xoKZU+UJXqglOPaHnuWq1QAAYdRdq5neUy25SmIuMkEYBp
 MJ/Nqm1l8oBlJmC+g8sxxctsHyPtYpCtHQa2g9aaZ2/6DJuXeuKo3rf4ir14EYG65C6n
 PPZQju6q0r59Xp+auc4FyHcdfkFi7NYgti5tf3YPeOnWihqmzE5EkEKIq3OshrfuwkFO
 9vTw==
X-Gm-Message-State: AC+VfDytXGv/uotc5B13ReYTr5mwOSTJqwiHsCbORxssXyfDpel+g3Te
 eit5XLsTRAW7njK3jbb5dDbeQDym5bgNqH5GObk=
X-Google-Smtp-Source: ACHHUZ58k5iIv5YXUfP1fnMDV0knSYIBu395fdXZFU4ZPub3GQCCjBFZMp1T3C1Yi24Wrq5/8OH7R950RepRNCt4avM=
X-Received: by 2002:a05:6902:1107:b0:ba8:a3b:8e26 with SMTP id
 o7-20020a056902110700b00ba80a3b8e26mr757913ybu.16.1684180475401; Mon, 15 May
 2023 12:54:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230510103004.30015-1-qianfanguijin@163.com>
 <20230510103004.30015-8-qianfanguijin@163.com>
In-Reply-To: <20230510103004.30015-8-qianfanguijin@163.com>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Mon, 15 May 2023 21:54:24 +0200
Message-ID: <CAPan3WrwJLpGAFf=wwoxFhdjom7yAogcBB2JC_kmCz54SR7Tmg@mail.gmail.com>
Subject: Re: [PATCH v4 07/11] hw: sd: allwinner-sdhost: Add sun50i-a64 SoC
 support
To: qianfanguijin@163.com
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Beniamino Galvani <b.galvani@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000f9657605fbc0d2fc"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2a;
 envelope-from=nieklinnenbank@gmail.com; helo=mail-yb1-xb2a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--000000000000f9657605fbc0d2fc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 10, 2023 at 12:30=E2=80=AFPM <qianfanguijin@163.com> wrote:

> From: qianfan Zhao <qianfanguijin@163.com>
>
> A64's sd register was similar to H3, and it introduced a new register
> named SAMP_DL_REG location at 0x144. The dma descriptor buffer size of
> mmc2 is only 8K and the other mmc controllers has 64K.
>
> Also fix allwinner-r40's mmc controller type.
>
> Signed-off-by: qianfan Zhao <qianfanguijin@163.com>
> ---
>  hw/arm/allwinner-r40.c           |  2 +-
>  hw/sd/allwinner-sdhost.c         | 70 ++++++++++++++++++++++++++++++--
>  include/hw/sd/allwinner-sdhost.h |  9 ++++
>  3 files changed, 77 insertions(+), 4 deletions(-)
>
> diff --git a/hw/arm/allwinner-r40.c b/hw/arm/allwinner-r40.c
> index 0e4542d35f..b148c56449 100644
> --- a/hw/arm/allwinner-r40.c
> +++ b/hw/arm/allwinner-r40.c
> @@ -271,7 +271,7 @@ static void allwinner_r40_init(Object *obj)
>
>      for (int i =3D 0; i < AW_R40_NUM_MMCS; i++) {
>          object_initialize_child(obj, mmc_names[i], &s->mmc[i],
> -                                TYPE_AW_SDHOST_SUN5I);
> +                                TYPE_AW_SDHOST_SUN50I_A64);
>      }
>
>      object_initialize_child(obj, "twi0", &s->i2c0, TYPE_AW_I2C_SUN6I);
> diff --git a/hw/sd/allwinner-sdhost.c b/hw/sd/allwinner-sdhost.c
> index 92a0f42708..f4fa2d179b 100644
> --- a/hw/sd/allwinner-sdhost.c
> +++ b/hw/sd/allwinner-sdhost.c
> @@ -77,6 +77,7 @@ enum {
>      REG_SD_DATA1_CRC  =3D 0x12C, /* CRC Data 1 from card/eMMC */
>      REG_SD_DATA0_CRC  =3D 0x130, /* CRC Data 0 from card/eMMC */
>      REG_SD_CRC_STA    =3D 0x134, /* CRC status from card/eMMC during wri=
te
> */
> +    REG_SD_SAMP_DL    =3D 0x144, /* Sample Delay Control (sun50i-a64) */
>      REG_SD_FIFO       =3D 0x200, /* Read/Write FIFO */
>  };
>
> @@ -158,6 +159,7 @@ enum {
>      REG_SD_RES_CRC_RST      =3D 0x0,
>      REG_SD_DATA_CRC_RST     =3D 0x0,
>      REG_SD_CRC_STA_RST      =3D 0x0,
> +    REG_SD_SAMPLE_DL_RST    =3D 0x00002000,
>      REG_SD_FIFO_RST         =3D 0x0,
>  };
>
> @@ -459,6 +461,7 @@ static uint64_t allwinner_sdhost_read(void *opaque,
> hwaddr offset,
>  {
>      AwSdHostState *s =3D AW_SDHOST(opaque);
>      AwSdHostClass *sc =3D AW_SDHOST_GET_CLASS(s);
> +    bool out_of_bounds =3D false;
>      uint32_t res =3D 0;
>
>      switch (offset) {
> @@ -577,13 +580,24 @@ static uint64_t allwinner_sdhost_read(void *opaque,
> hwaddr offset,
>      case REG_SD_FIFO:      /* Read/Write FIFO */
>          res =3D allwinner_sdhost_fifo_read(s);
>          break;
> +    case REG_SD_SAMP_DL: /* Sample Delay */
> +        if (sc->can_calibrate) {
> +            res =3D s->sample_delay;
> +        } else {
> +            out_of_bounds =3D true;
> +        }
> +        break;
>      default:
> -        qemu_log_mask(LOG_GUEST_ERROR, "%s: out-of-bounds offset %"
> -                      HWADDR_PRIx"\n", __func__, offset);
> +        out_of_bounds =3D true;
>          res =3D 0;
>          break;
>      }
>
> +    if (out_of_bounds) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: out-of-bounds offset %"
> +                      HWADDR_PRIx"\n", __func__, offset);
> +    }
> +
>      trace_allwinner_sdhost_read(offset, res, size);
>      return res;
>  }
> @@ -602,6 +616,7 @@ static void allwinner_sdhost_write(void *opaque,
> hwaddr offset,
>  {
>      AwSdHostState *s =3D AW_SDHOST(opaque);
>      AwSdHostClass *sc =3D AW_SDHOST_GET_CLASS(s);
> +    bool out_of_bounds =3D false;
>
>      trace_allwinner_sdhost_write(offset, value, size);
>
> @@ -725,10 +740,21 @@ static void allwinner_sdhost_write(void *opaque,
> hwaddr offset,
>      case REG_SD_DATA0_CRC: /* CRC Data 0 from card/eMMC */
>      case REG_SD_CRC_STA:   /* CRC status from card/eMMC in write
> operation */
>          break;
> +    case REG_SD_SAMP_DL: /* Sample delay control */
> +        if (sc->can_calibrate) {
> +            s->sample_delay =3D value;
> +        } else {
> +            out_of_bounds =3D true;
> +        }
> +        break;
>      default:
> +        out_of_bounds =3D true;
> +        break;
> +    }
> +
> +    if (out_of_bounds) {
>          qemu_log_mask(LOG_GUEST_ERROR, "%s: out-of-bounds offset %"
>                        HWADDR_PRIx"\n", __func__, offset);
> -        break;
>      }
>  }
>
> @@ -777,6 +803,7 @@ static const VMStateDescription
> vmstate_allwinner_sdhost =3D {
>          VMSTATE_UINT32(response_crc, AwSdHostState),
>          VMSTATE_UINT32_ARRAY(data_crc, AwSdHostState, 8),
>          VMSTATE_UINT32(status_crc, AwSdHostState),
> +        VMSTATE_UINT32(sample_delay, AwSdHostState),
>          VMSTATE_END_OF_LIST()
>      }
>  };
> @@ -815,6 +842,7 @@ static void allwinner_sdhost_realize(DeviceState *dev=
,
> Error **errp)
>  static void allwinner_sdhost_reset(DeviceState *dev)
>  {
>      AwSdHostState *s =3D AW_SDHOST(dev);
> +    AwSdHostClass *sc =3D AW_SDHOST_GET_CLASS(s);
>
>      s->global_ctl =3D REG_SD_GCTL_RST;
>      s->clock_ctl =3D REG_SD_CKCR_RST;
> @@ -855,6 +883,10 @@ static void allwinner_sdhost_reset(DeviceState *dev)
>      }
>
>      s->status_crc =3D REG_SD_CRC_STA_RST;
> +
> +    if (sc->can_calibrate) {
> +        s->sample_delay =3D REG_SD_SAMPLE_DL_RST;
> +    }
>  }
>
>  static void allwinner_sdhost_bus_class_init(ObjectClass *klass, void
> *data)
> @@ -888,6 +920,24 @@ static void
> allwinner_sdhost_sun5i_class_init(ObjectClass *klass, void *data)
>      sc->is_sun4i =3D false;
>  }
>
> +static void allwinner_sdhost_sun50i_a64_class_init(ObjectClass *klass,
> +                                                   void *data)
> +{
> +    AwSdHostClass *sc =3D AW_SDHOST_CLASS(klass);
> +    sc->max_desc_size =3D 64 * KiB;
> +    sc->is_sun4i =3D false;
> +    sc->can_calibrate =3D true;
>

For the existing functions allwinner_sdhost_sun4i_class_init() and
allwinner_sdhost_sun5i_class_init(), could you please add
'sc->can_calibrate =3D false'?
That way, we make it explicit that those types do not support the sample
delay register.

With that resolved, the code looks good to me:

Reviewed-by: Niek Linnenbank <nieklinnenbank@gmail.com>


> +}
> +
> +static void allwinner_sdhost_sun50i_a64_emmc_class_init(ObjectClass
> *klass,
> +                                                        void *data)
> +{
> +    AwSdHostClass *sc =3D AW_SDHOST_CLASS(klass);
> +    sc->max_desc_size =3D 8 * KiB;
> +    sc->is_sun4i =3D false;
> +    sc->can_calibrate =3D true;
> +}
> +
>  static const TypeInfo allwinner_sdhost_info =3D {
>      .name          =3D TYPE_AW_SDHOST,
>      .parent        =3D TYPE_SYS_BUS_DEVICE,
> @@ -910,6 +960,18 @@ static const TypeInfo allwinner_sdhost_sun5i_info =
=3D {
>      .class_init    =3D allwinner_sdhost_sun5i_class_init,
>  };
>
> +static const TypeInfo allwinner_sdhost_sun50i_a64_info =3D {
> +    .name          =3D TYPE_AW_SDHOST_SUN50I_A64,
> +    .parent        =3D TYPE_AW_SDHOST,
> +    .class_init    =3D allwinner_sdhost_sun50i_a64_class_init,
> +};
> +
> +static const TypeInfo allwinner_sdhost_sun50i_a64_emmc_info =3D {
> +    .name          =3D TYPE_AW_SDHOST_SUN50I_A64_EMMC,
> +    .parent        =3D TYPE_AW_SDHOST,
> +    .class_init    =3D allwinner_sdhost_sun50i_a64_emmc_class_init,
> +};
> +
>  static const TypeInfo allwinner_sdhost_bus_info =3D {
>      .name =3D TYPE_AW_SDHOST_BUS,
>      .parent =3D TYPE_SD_BUS,
> @@ -922,6 +984,8 @@ static void allwinner_sdhost_register_types(void)
>      type_register_static(&allwinner_sdhost_info);
>      type_register_static(&allwinner_sdhost_sun4i_info);
>      type_register_static(&allwinner_sdhost_sun5i_info);
> +    type_register_static(&allwinner_sdhost_sun50i_a64_info);
> +    type_register_static(&allwinner_sdhost_sun50i_a64_emmc_info);
>      type_register_static(&allwinner_sdhost_bus_info);
>  }
>
> diff --git a/include/hw/sd/allwinner-sdhost.h
> b/include/hw/sd/allwinner-sdhost.h
> index 30c1e60404..1b951177dd 100644
> --- a/include/hw/sd/allwinner-sdhost.h
> +++ b/include/hw/sd/allwinner-sdhost.h
> @@ -38,6 +38,12 @@
>  /** Allwinner sun5i family and newer (A13, H2+, H3, etc) */
>  #define TYPE_AW_SDHOST_SUN5I TYPE_AW_SDHOST "-sun5i"
>
> +/** Allwinner sun50i-a64 */
> +#define TYPE_AW_SDHOST_SUN50I_A64 TYPE_AW_SDHOST "-sun50i-a64"
> +
> +/** Allwinner sun50i-a64 emmc */
> +#define TYPE_AW_SDHOST_SUN50I_A64_EMMC  TYPE_AW_SDHOST "-sun50i-a64-emmc=
"
> +
>  /** @} */
>
>  /**
> @@ -110,6 +116,7 @@ struct AwSdHostState {
>      uint32_t startbit_detect;   /**< eMMC DDR Start Bit Detection Contro=
l
> */
>      uint32_t response_crc;      /**< Response CRC */
>      uint32_t data_crc[8];       /**< Data CRC */
> +    uint32_t sample_delay;      /**< Sample delay control */
>      uint32_t status_crc;        /**< Status CRC */
>
>      /** @} */
> @@ -132,6 +139,8 @@ struct AwSdHostClass {
>      size_t max_desc_size;
>      bool   is_sun4i;
>
> +    /** does the IP block support autocalibration? */
> +    bool can_calibrate;
>  };
>
>  #endif /* HW_SD_ALLWINNER_SDHOST_H */
> --
> 2.25.1
>
>

--=20
Niek Linnenbank

--000000000000f9657605fbc0d2fc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, May 10, 2023 at 12:30=E2=80=
=AFPM &lt;<a href=3D"mailto:qianfanguijin@163.com">qianfanguijin@163.com</a=
>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Fro=
m: qianfan Zhao &lt;<a href=3D"mailto:qianfanguijin@163.com" target=3D"_bla=
nk">qianfanguijin@163.com</a>&gt;<br>
<br>
A64&#39;s sd register was similar to H3, and it introduced a new register<b=
r>
named SAMP_DL_REG location at 0x144. The dma descriptor buffer size of<br>
mmc2 is only 8K and the other mmc controllers has 64K.<br>
<br>
Also fix allwinner-r40&#39;s mmc controller type.<br>
<br>
Signed-off-by: qianfan Zhao &lt;<a href=3D"mailto:qianfanguijin@163.com" ta=
rget=3D"_blank">qianfanguijin@163.com</a>&gt;<br>
---<br>
=C2=A0hw/arm/allwinner-r40.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 2 +-<br>
=C2=A0hw/sd/allwinner-sdhost.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 70 ++++++=
++++++++++++++++++++++++--<br>
=C2=A0include/hw/sd/allwinner-sdhost.h |=C2=A0 9 ++++<br>
=C2=A03 files changed, 77 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/hw/arm/allwinner-r40.c b/hw/arm/allwinner-r40.c<br>
index 0e4542d35f..b148c56449 100644<br>
--- a/hw/arm/allwinner-r40.c<br>
+++ b/hw/arm/allwinner-r40.c<br>
@@ -271,7 +271,7 @@ static void allwinner_r40_init(Object *obj)<br>
<br>
=C2=A0 =C2=A0 =C2=A0for (int i =3D 0; i &lt; AW_R40_NUM_MMCS; i++) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0object_initialize_child(obj, mmc_names[i]=
, &amp;s-&gt;mmc[i],<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TYPE_AW_SDHOST_SUN5I);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TYPE_AW_SDHOST_SUN50I_A64);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0object_initialize_child(obj, &quot;twi0&quot;, &amp;s-&=
gt;i2c0, TYPE_AW_I2C_SUN6I);<br>
diff --git a/hw/sd/allwinner-sdhost.c b/hw/sd/allwinner-sdhost.c<br>
index 92a0f42708..f4fa2d179b 100644<br>
--- a/hw/sd/allwinner-sdhost.c<br>
+++ b/hw/sd/allwinner-sdhost.c<br>
@@ -77,6 +77,7 @@ enum {<br>
=C2=A0 =C2=A0 =C2=A0REG_SD_DATA1_CRC=C2=A0 =3D 0x12C, /* CRC Data 1 from ca=
rd/eMMC */<br>
=C2=A0 =C2=A0 =C2=A0REG_SD_DATA0_CRC=C2=A0 =3D 0x130, /* CRC Data 0 from ca=
rd/eMMC */<br>
=C2=A0 =C2=A0 =C2=A0REG_SD_CRC_STA=C2=A0 =C2=A0 =3D 0x134, /* CRC status fr=
om card/eMMC during write */<br>
+=C2=A0 =C2=A0 REG_SD_SAMP_DL=C2=A0 =C2=A0 =3D 0x144, /* Sample Delay Contr=
ol (sun50i-a64) */<br>
=C2=A0 =C2=A0 =C2=A0REG_SD_FIFO=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 0x200, /* Rea=
d/Write FIFO */<br>
=C2=A0};<br>
<br>
@@ -158,6 +159,7 @@ enum {<br>
=C2=A0 =C2=A0 =C2=A0REG_SD_RES_CRC_RST=C2=A0 =C2=A0 =C2=A0 =3D 0x0,<br>
=C2=A0 =C2=A0 =C2=A0REG_SD_DATA_CRC_RST=C2=A0 =C2=A0 =C2=A0=3D 0x0,<br>
=C2=A0 =C2=A0 =C2=A0REG_SD_CRC_STA_RST=C2=A0 =C2=A0 =C2=A0 =3D 0x0,<br>
+=C2=A0 =C2=A0 REG_SD_SAMPLE_DL_RST=C2=A0 =C2=A0 =3D 0x00002000,<br>
=C2=A0 =C2=A0 =C2=A0REG_SD_FIFO_RST=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 0x=
0,<br>
=C2=A0};<br>
<br>
@@ -459,6 +461,7 @@ static uint64_t allwinner_sdhost_read(void *opaque, hwa=
ddr offset,<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0AwSdHostState *s =3D AW_SDHOST(opaque);<br>
=C2=A0 =C2=A0 =C2=A0AwSdHostClass *sc =3D AW_SDHOST_GET_CLASS(s);<br>
+=C2=A0 =C2=A0 bool out_of_bounds =3D false;<br>
=C2=A0 =C2=A0 =C2=A0uint32_t res =3D 0;<br>
<br>
=C2=A0 =C2=A0 =C2=A0switch (offset) {<br>
@@ -577,13 +580,24 @@ static uint64_t allwinner_sdhost_read(void *opaque, h=
waddr offset,<br>
=C2=A0 =C2=A0 =C2=A0case REG_SD_FIFO:=C2=A0 =C2=A0 =C2=A0 /* Read/Write FIF=
O */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0res =3D allwinner_sdhost_fifo_read(s);<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
+=C2=A0 =C2=A0 case REG_SD_SAMP_DL: /* Sample Delay */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (sc-&gt;can_calibrate) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 res =3D s-&gt;sample_delay;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 out_of_bounds =3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
=C2=A0 =C2=A0 =C2=A0default:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR, &quot;%s: out-o=
f-bounds offset %&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 HWADDR_PRIx&quot;\n&quot;, __func__, offset);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 out_of_bounds =3D true;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0res =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
+=C2=A0 =C2=A0 if (out_of_bounds) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_log_mask(LOG_GUEST_ERROR, &quot;%s: out-o=
f-bounds offset %&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 HWADDR_PRIx&quot;\n&quot;, __func__, offset);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0trace_allwinner_sdhost_read(offset, res, size);<br>
=C2=A0 =C2=A0 =C2=A0return res;<br>
=C2=A0}<br>
@@ -602,6 +616,7 @@ static void allwinner_sdhost_write(void *opaque, hwaddr=
 offset,<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0AwSdHostState *s =3D AW_SDHOST(opaque);<br>
=C2=A0 =C2=A0 =C2=A0AwSdHostClass *sc =3D AW_SDHOST_GET_CLASS(s);<br>
+=C2=A0 =C2=A0 bool out_of_bounds =3D false;<br>
<br>
=C2=A0 =C2=A0 =C2=A0trace_allwinner_sdhost_write(offset, value, size);<br>
<br>
@@ -725,10 +740,21 @@ static void allwinner_sdhost_write(void *opaque, hwad=
dr offset,<br>
=C2=A0 =C2=A0 =C2=A0case REG_SD_DATA0_CRC: /* CRC Data 0 from card/eMMC */<=
br>
=C2=A0 =C2=A0 =C2=A0case REG_SD_CRC_STA:=C2=A0 =C2=A0/* CRC status from car=
d/eMMC in write operation */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
+=C2=A0 =C2=A0 case REG_SD_SAMP_DL: /* Sample delay control */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (sc-&gt;can_calibrate) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;sample_delay =3D value;<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 out_of_bounds =3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
=C2=A0 =C2=A0 =C2=A0default:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 out_of_bounds =3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (out_of_bounds) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_log_mask(LOG_GUEST_ERROR, &quot;%s: =
out-of-bounds offset %&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0HWADDR_PRIx&quot;\n&quot;, __func__, offset);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
@@ -777,6 +803,7 @@ static const VMStateDescription vmstate_allwinner_sdhos=
t =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VMSTATE_UINT32(response_crc, AwSdHostStat=
e),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VMSTATE_UINT32_ARRAY(data_crc, AwSdHostSt=
ate, 8),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VMSTATE_UINT32(status_crc, AwSdHostState)=
,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(sample_delay, AwSdHostState),<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VMSTATE_END_OF_LIST()<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0};<br>
@@ -815,6 +842,7 @@ static void allwinner_sdhost_realize(DeviceState *dev, =
Error **errp)<br>
=C2=A0static void allwinner_sdhost_reset(DeviceState *dev)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0AwSdHostState *s =3D AW_SDHOST(dev);<br>
+=C2=A0 =C2=A0 AwSdHostClass *sc =3D AW_SDHOST_GET_CLASS(s);<br>
<br>
=C2=A0 =C2=A0 =C2=A0s-&gt;global_ctl =3D REG_SD_GCTL_RST;<br>
=C2=A0 =C2=A0 =C2=A0s-&gt;clock_ctl =3D REG_SD_CKCR_RST;<br>
@@ -855,6 +883,10 @@ static void allwinner_sdhost_reset(DeviceState *dev)<b=
r>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0s-&gt;status_crc =3D REG_SD_CRC_STA_RST;<br>
+<br>
+=C2=A0 =C2=A0 if (sc-&gt;can_calibrate) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;sample_delay =3D REG_SD_SAMPLE_DL_RST;<b=
r>
+=C2=A0 =C2=A0 }<br>
=C2=A0}<br>
<br>
=C2=A0static void allwinner_sdhost_bus_class_init(ObjectClass *klass, void =
*data)<br>
@@ -888,6 +920,24 @@ static void allwinner_sdhost_sun5i_class_init(ObjectCl=
ass *klass, void *data)<br>
=C2=A0 =C2=A0 =C2=A0sc-&gt;is_sun4i =3D false;<br>
=C2=A0}<br>
<br>
+static void allwinner_sdhost_sun50i_a64_class_init(ObjectClass *klass,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void *data)<br>
+{<br>
+=C2=A0 =C2=A0 AwSdHostClass *sc =3D AW_SDHOST_CLASS(klass);<br>
+=C2=A0 =C2=A0 sc-&gt;max_desc_size =3D 64 * KiB;<br>
+=C2=A0 =C2=A0 sc-&gt;is_sun4i =3D false;<br>
+=C2=A0 =C2=A0 sc-&gt;can_calibrate =3D true;<br></blockquote><div><br></di=
v><div>For the existing functions allwinner_sdhost_sun4i_class_init() and a=
llwinner_sdhost_sun5i_class_init(), could you please add &#39;sc-&gt;can_ca=
librate =3D false&#39;?</div><div>That way, we make it explicit that those =
types do not support the sample delay register.</div><div><br></div><div>Wi=
th that resolved, the code looks good to me:</div><div><br></div><div>Revie=
wed-by: Niek Linnenbank &lt;<a href=3D"mailto:nieklinnenbank@gmail.com">nie=
klinnenbank@gmail.com</a>&gt;<br></div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
+}<br>
+<br>
+static void allwinner_sdhost_sun50i_a64_emmc_class_init(ObjectClass *klass=
,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 void *data)<br>
+{<br>
+=C2=A0 =C2=A0 AwSdHostClass *sc =3D AW_SDHOST_CLASS(klass);<br>
+=C2=A0 =C2=A0 sc-&gt;max_desc_size =3D 8 * KiB;<br>
+=C2=A0 =C2=A0 sc-&gt;is_sun4i =3D false;<br>
+=C2=A0 =C2=A0 sc-&gt;can_calibrate =3D true;<br>
+}<br>
+<br>
=C2=A0static const TypeInfo allwinner_sdhost_info =3D {<br>
=C2=A0 =C2=A0 =C2=A0.name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_AW_SDH=
OST,<br>
=C2=A0 =C2=A0 =C2=A0.parent=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_SYS_BUS_DEV=
ICE,<br>
@@ -910,6 +960,18 @@ static const TypeInfo allwinner_sdhost_sun5i_info =3D =
{<br>
=C2=A0 =C2=A0 =C2=A0.class_init=C2=A0 =C2=A0 =3D allwinner_sdhost_sun5i_cla=
ss_init,<br>
=C2=A0};<br>
<br>
+static const TypeInfo allwinner_sdhost_sun50i_a64_info =3D {<br>
+=C2=A0 =C2=A0 .name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_AW_SDHOST_S=
UN50I_A64,<br>
+=C2=A0 =C2=A0 .parent=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_AW_SDHOST,<br>
+=C2=A0 =C2=A0 .class_init=C2=A0 =C2=A0 =3D allwinner_sdhost_sun50i_a64_cla=
ss_init,<br>
+};<br>
+<br>
+static const TypeInfo allwinner_sdhost_sun50i_a64_emmc_info =3D {<br>
+=C2=A0 =C2=A0 .name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_AW_SDHOST_S=
UN50I_A64_EMMC,<br>
+=C2=A0 =C2=A0 .parent=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_AW_SDHOST,<br>
+=C2=A0 =C2=A0 .class_init=C2=A0 =C2=A0 =3D allwinner_sdhost_sun50i_a64_emm=
c_class_init,<br>
+};<br>
+<br>
=C2=A0static const TypeInfo allwinner_sdhost_bus_info =3D {<br>
=C2=A0 =C2=A0 =C2=A0.name =3D TYPE_AW_SDHOST_BUS,<br>
=C2=A0 =C2=A0 =C2=A0.parent =3D TYPE_SD_BUS,<br>
@@ -922,6 +984,8 @@ static void allwinner_sdhost_register_types(void)<br>
=C2=A0 =C2=A0 =C2=A0type_register_static(&amp;allwinner_sdhost_info);<br>
=C2=A0 =C2=A0 =C2=A0type_register_static(&amp;allwinner_sdhost_sun4i_info);=
<br>
=C2=A0 =C2=A0 =C2=A0type_register_static(&amp;allwinner_sdhost_sun5i_info);=
<br>
+=C2=A0 =C2=A0 type_register_static(&amp;allwinner_sdhost_sun50i_a64_info);=
<br>
+=C2=A0 =C2=A0 type_register_static(&amp;allwinner_sdhost_sun50i_a64_emmc_i=
nfo);<br>
=C2=A0 =C2=A0 =C2=A0type_register_static(&amp;allwinner_sdhost_bus_info);<b=
r>
=C2=A0}<br>
<br>
diff --git a/include/hw/sd/allwinner-sdhost.h b/include/hw/sd/allwinner-sdh=
ost.h<br>
index 30c1e60404..1b951177dd 100644<br>
--- a/include/hw/sd/allwinner-sdhost.h<br>
+++ b/include/hw/sd/allwinner-sdhost.h<br>
@@ -38,6 +38,12 @@<br>
=C2=A0/** Allwinner sun5i family and newer (A13, H2+, H3, etc) */<br>
=C2=A0#define TYPE_AW_SDHOST_SUN5I TYPE_AW_SDHOST &quot;-sun5i&quot;<br>
<br>
+/** Allwinner sun50i-a64 */<br>
+#define TYPE_AW_SDHOST_SUN50I_A64 TYPE_AW_SDHOST &quot;-sun50i-a64&quot;<b=
r>
+<br>
+/** Allwinner sun50i-a64 emmc */<br>
+#define TYPE_AW_SDHOST_SUN50I_A64_EMMC=C2=A0 TYPE_AW_SDHOST &quot;-sun50i-=
a64-emmc&quot;<br>
+<br>
=C2=A0/** @} */<br>
<br>
=C2=A0/**<br>
@@ -110,6 +116,7 @@ struct AwSdHostState {<br>
=C2=A0 =C2=A0 =C2=A0uint32_t startbit_detect;=C2=A0 =C2=A0/**&lt; eMMC DDR =
Start Bit Detection Control */<br>
=C2=A0 =C2=A0 =C2=A0uint32_t response_crc;=C2=A0 =C2=A0 =C2=A0 /**&lt; Resp=
onse CRC */<br>
=C2=A0 =C2=A0 =C2=A0uint32_t data_crc[8];=C2=A0 =C2=A0 =C2=A0 =C2=A0/**&lt;=
 Data CRC */<br>
+=C2=A0 =C2=A0 uint32_t sample_delay;=C2=A0 =C2=A0 =C2=A0 /**&lt; Sample de=
lay control */<br>
=C2=A0 =C2=A0 =C2=A0uint32_t status_crc;=C2=A0 =C2=A0 =C2=A0 =C2=A0 /**&lt;=
 Status CRC */<br>
<br>
=C2=A0 =C2=A0 =C2=A0/** @} */<br>
@@ -132,6 +139,8 @@ struct AwSdHostClass {<br>
=C2=A0 =C2=A0 =C2=A0size_t max_desc_size;<br>
=C2=A0 =C2=A0 =C2=A0bool=C2=A0 =C2=A0is_sun4i;<br>
<br>
+=C2=A0 =C2=A0 /** does the IP block support autocalibration? */<br>
+=C2=A0 =C2=A0 bool can_calibrate;<br>
=C2=A0};<br>
<br>
=C2=A0#endif /* HW_SD_ALLWINNER_SDHOST_H */<br>
-- <br>
2.25.1<br>
<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"l=
tr"><div>Niek Linnenbank<br><br></div></div></div></div>

--000000000000f9657605fbc0d2fc--

