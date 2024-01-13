Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B9182CEE6
	for <lists+qemu-devel@lfdr.de>; Sat, 13 Jan 2024 23:18:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOmJj-0004mS-Ce; Sat, 13 Jan 2024 17:17:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <42.hyeyoo@gmail.com>)
 id 1rOmJY-0004mC-0U
 for qemu-devel@nongnu.org; Sat, 13 Jan 2024 17:17:16 -0500
Received: from mail-qk1-x729.google.com ([2607:f8b0:4864:20::729])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <42.hyeyoo@gmail.com>)
 id 1rOmJW-0007hM-70
 for qemu-devel@nongnu.org; Sat, 13 Jan 2024 17:17:15 -0500
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-783293278adso433711185a.3
 for <qemu-devel@nongnu.org>; Sat, 13 Jan 2024 14:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705184233; x=1705789033; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PoQlO4MKUIvweMwdVro8g0ITgnHI1IyT1pBZzi+Gnv4=;
 b=ZaWRWafJQaNQJKrVariroEq7eyHy2Rpz88r7HKlsBRPTlKTD43nMHh/mWv8tPMJ7p7
 Ar0Y7qEHlWHOX16UB6LTWldjnizuEIarMwDWn5X869wGez6Q/ZMT3duhfFi+NN9mx/rv
 QGceaCqmSVwdtn16wKuQ9KPTSkolrTwgp/6ASEWzWrSoJoyrFGs4kyta2C6Iknw9RTyL
 r4a9ldrW4rc/Uk67ktLDtBG3Dj0o7AdZ0E1l15KIHB5mhPmUd6dTddfUTXd6n+gBPWXh
 wqzrHqMoFpsS8+VY9qjZgu/HvTqnPP2hhVlxNSPQW1F9o/OlnXRRBM3ZmH5plcNe7qAJ
 WgTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705184233; x=1705789033;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PoQlO4MKUIvweMwdVro8g0ITgnHI1IyT1pBZzi+Gnv4=;
 b=OYWjGeobfHEuUn+ppju7kMYHk5m0hfqAutRz+IEngx4T+vS8Cz+OFwQRvZQeG33iNV
 3kPc5+OT/f7vHOoJ58I6ZckXKqTF94monpHeWxiaHiWMnnn7dvF3zjnhPivAnDN1niEk
 kN6mo4nSUZxw3LLjVFHzBnWM89SlJT8p/lGWh8LmOr3i5Hjm9LQuMfA5iN70sbCokD2L
 CwUZp/E/JHJoLJUgjaVK4w6+KcQ6/XwVY2ShwjsvDLp25oj2wnWmBvb6LKcuawu2U+Vy
 c84MuzcASWjKtm80BNKF+W2cBzMaSEAOSplahTz1vbbj2iXDtJXNxJ8eMbf70HOZ/uED
 3ABg==
X-Gm-Message-State: AOJu0YzomllR5ZcAmPcAaayBheAsUdO9JXDmCpdcR1ytsXSE+GmHBuKX
 lCo6i7ceRp+PvIdizIvSPqmrN5idUScnp6SvzjM=
X-Google-Smtp-Source: AGHT+IHsK+p/V02eOSPdiecI6IrJhpKWVGzdV/UL9ZxwDqGmqwc2mYi/Sm/DUXLr0kD5qxnanSxnaoLLUWV4GrYzHxY=
X-Received: by 2002:a05:620a:1245:b0:783:2c23:271e with SMTP id
 a5-20020a05620a124500b007832c23271emr3929034qkl.138.1705184232667; Sat, 13
 Jan 2024 14:17:12 -0800 (PST)
MIME-Version: 1.0
References: <20240111145905.19797-1-Jonathan.Cameron@huawei.com>
In-Reply-To: <20240111145905.19797-1-Jonathan.Cameron@huawei.com>
From: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Date: Sat, 13 Jan 2024 17:16:59 -0500
Message-ID: <CAB=+i9SMSYHX_YTOOreJNikHiNmDxdPAuyBYPh_=1c97gjN55g@mail.gmail.com>
Subject: Re: [PATCH v2 qemu] hw/cxl/device: read from register values in
 mdev_reg_read()
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, qemu-devel@nongnu.org, 
 Davidlohr Bueso <dave@stgolabs.net>, Fan Ni <fan.ni@samsung.com>,
 linuxarm@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::729;
 envelope-from=42.hyeyoo@gmail.com; helo=mail-qk1-x729.google.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HK_RANDOM_ENVFROM=0.998, HK_RANDOM_FROM=0.998, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Thu, Jan 11, 2024 at 9:59=E2=80=AFAM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> From: Hyeonggon Yoo <42.hyeyoo@gmail.com>
>
> In the current mdev_reg_read() implementation, it consistently returns
> that the Media Status is Ready (01b). This was fine until commit
> 25a52959f99d ("hw/cxl: Add support for device sanitation") because the
> media was presumed to be ready.
>
> However, as per the CXL 3.0 spec "8.2.9.8.5.1 Sanitize (Opcode 4400h)",
> during sanitation, the Media State should be set to Disabled (11b). The
> mentioned commit correctly sets it to Disabled, but mdev_reg_read()
> still returns Media Status as Ready.
>
> To address this, update mdev_reg_read() to read register values instead
> of returning dummy values.
>
> Note __toggle_media() was overwriting the mailbox capability
> register, but nothing was reading that after this so that bug had no
> obvious effect unless the driver was reloaded.
>
> Fixes: commit 25a52959f99d ("hw/cxl: Add support for device sanitation")
> Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> Link: https://lore.kernel.org/r/20231222090051.3265307-3-42.hyeyoo@gmail.=
com
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> --
>
> Hyeonggon - I've kept your sign-off. Let me know if this is ok.

Yeah, it's fine!

I either missed that it overwrites the mailbox capability register,
thank you so much for noticing. the new version looks fine to me.

> Dropped RBs etc as this has changed quite a bit.
>
> I plan to send out a group of fixes including this soon, but given
> I've been pointing out the original fix didn't work thought I'd send
> this one out for early review!
>
> ---
>  include/hw/cxl/cxl_device.h |  9 +++++++--
>  hw/cxl/cxl-device-utils.c   | 17 +++++++++++------
>  2 files changed, 18 insertions(+), 8 deletions(-)
>
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index befb5f884b..31d2afcd3d 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -202,6 +202,9 @@ typedef struct cxl_device_state {
>          };
>      };
>
> +    /* Stash the memory device status value */
> +    uint64_t memdev_status;
> +
>      struct {
>          bool set;
>          uint64_t last_set;
> @@ -353,8 +356,10 @@ static inline void __toggle_media(CXLDeviceState *cx=
l_dstate, int val)
>  {
>      uint64_t dev_status_reg;
>
> -    dev_status_reg =3D FIELD_DP64(0, CXL_MEM_DEV_STS, MEDIA_STATUS, val)=
;
> -    cxl_dstate->mbox_reg_state64[R_CXL_MEM_DEV_STS] =3D dev_status_reg;
> +    dev_status_reg =3D cxl_dstate->memdev_status;
> +    dev_status_reg =3D FIELD_DP64(dev_status_reg, CXL_MEM_DEV_STS, MEDIA=
_STATUS,
> +                                val);
> +    cxl_dstate->memdev_status =3D dev_status_reg;
>  }
>  #define cxl_dev_disable_media(cxlds)                    \
>          do { __toggle_media((cxlds), 0x3); } while (0)
> diff --git a/hw/cxl/cxl-device-utils.c b/hw/cxl/cxl-device-utils.c
> index 61a3c4dc2e..40b619ffd9 100644
> --- a/hw/cxl/cxl-device-utils.c
> +++ b/hw/cxl/cxl-device-utils.c
> @@ -229,12 +229,9 @@ static void mailbox_reg_write(void *opaque, hwaddr o=
ffset, uint64_t value,
>
>  static uint64_t mdev_reg_read(void *opaque, hwaddr offset, unsigned size=
)
>  {
> -    uint64_t retval =3D 0;
> -
> -    retval =3D FIELD_DP64(retval, CXL_MEM_DEV_STS, MEDIA_STATUS, 1);
> -    retval =3D FIELD_DP64(retval, CXL_MEM_DEV_STS, MBOX_READY, 1);
> +    CXLDeviceState *cxl_dstate =3D opaque;
>
> -    return retval;
> +    return cxl_dstate->memdev_status;
>  }
>
>  static void ro_reg_write(void *opaque, hwaddr offset, uint64_t value,
> @@ -371,7 +368,15 @@ static void mailbox_reg_init_common(CXLDeviceState *=
cxl_dstate)
>      cxl_dstate->mbox_msi_n =3D msi_n;
>  }
>
> -static void memdev_reg_init_common(CXLDeviceState *cxl_dstate) { }
> +static void memdev_reg_init_common(CXLDeviceState *cxl_dstate)
> +{
> +    uint64_t memdev_status_reg;
> +
> +    memdev_status_reg =3D FIELD_DP64(0, CXL_MEM_DEV_STS, MEDIA_STATUS, 1=
);
> +    memdev_status_reg =3D FIELD_DP64(memdev_status_reg, CXL_MEM_DEV_STS,
> +                                   MBOX_READY, 1);
> +    cxl_dstate->memdev_status =3D memdev_status_reg;
> +}
>
>  void cxl_device_register_init_t3(CXLType3Dev *ct3d)
>  {
> --
> 2.39.2
>

