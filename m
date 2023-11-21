Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BD9B57F2489
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 04:13:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5HBe-00031V-By; Mon, 20 Nov 2023 22:12:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r5HBc-000314-98
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 22:12:28 -0500
Received: from mail-vs1-xe2b.google.com ([2607:f8b0:4864:20::e2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r5HBa-0006qp-Ep
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 22:12:28 -0500
Received: by mail-vs1-xe2b.google.com with SMTP id
 ada2fe7eead31-45d9689b65dso1749017137.0
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 19:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700536345; x=1701141145; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z+QDwOhUKdUv7XOnYpS5//i17TyVUEkBppmpUr9LCdc=;
 b=KyGK5oS1pNNw5M1ywKwgOnL4gLpTGJCDSHWTxUuLzRoPYPRBAz7BbfA5QnjqGjysre
 pU9y8BMwkpRvyGVB5O6L9A7vqFmacZozoJofslygmPtelOTxXL4gYCvoF7U43nBPuvPD
 +fyFFoM0P6nDLwIprAE3OxjmZhJUbLX3jThh06wzcdLhrftnPAmOrVCy7ZHy3Q9tAbFP
 yEcD3Fk/TN0Go6rqALEAp4eHofB1bWXFUrwcrVVYEUX3s7a57Dd9Gq2240J588JhXnCk
 jGzT8QWtDmACCemMT1U6wsjYl/pFlZSbQKGk8ZtxfsaiFzjf8e6YxrXzn1Pps+j3w7x5
 9/UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700536345; x=1701141145;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z+QDwOhUKdUv7XOnYpS5//i17TyVUEkBppmpUr9LCdc=;
 b=DawtbdzATw1xsN6PukpSPs7GRsFhO+Ge/dauJQyd+rho5Lo5aGck0PbexG3AlN81mJ
 jOpOKKTrmPeNOxvIISsAq9KygyT2gOHsHgjL+FYHOie6aLahsWavx54CAcoP65PsL9mZ
 49XtdKmg7UEAslW0gqyI7PqvTsdAC71/oIuzF6ZTsSJN/cFz4y1CBuVgOrcM14W+Wtfe
 6BETDO9beHwUmmHa1pEGZHeB5fLg0Ojr57bAOqlqHxj3o6rHH5LtEcT42miJLZll2OD1
 wUF9QJ2H4w/qycD/zjgXFH5gt0FxNiIafN3rd85wi4kZFr0SCbI9oO2g3RHm3q0S1xoo
 1UGA==
X-Gm-Message-State: AOJu0Yz+vh10w3PV+rTyJ50If4nQwemDVa6UQCBrHMaKNjq3vRn8SqHk
 LhIoDk/9jiEjP5UjRLFNBQBtHmB4YuJQ8y0cFOA=
X-Google-Smtp-Source: AGHT+IGhsJ8JgTK77Shy+IvajpLBG3Q/EKHi/Omal7X/mwRR6n0v7F72CesHzZBmMJvmFXyLKgH6ehbq5Q+lQVzVFFI=
X-Received: by 2002:a67:c19b:0:b0:45d:91b2:f087 with SMTP id
 h27-20020a67c19b000000b0045d91b2f087mr4547317vsj.6.1700536345050; Mon, 20 Nov
 2023 19:12:25 -0800 (PST)
MIME-Version: 1.0
References: <20231117114457.177308-1-thuth@redhat.com>
 <20231117114457.177308-3-thuth@redhat.com>
In-Reply-To: <20231117114457.177308-3-thuth@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 21 Nov 2023 13:11:58 +1000
Message-ID: <CAKmqyKPCqr-VeADABOrLQi-g24oBUVF492goo21wgcH=Yp4CKw@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] hw: Replace anti-social QOM type names (again)
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, 
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Eduardo Habkost <eduardo@habkost.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2b;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2b.google.com
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

On Fri, Nov 17, 2023 at 9:47=E2=80=AFPM Thomas Huth <thuth@redhat.com> wrot=
e:
>
> From: Markus Armbruster <armbru@redhat.com>
>
> QOM type names containing ',' result in awful UI.  We got rid of them
> in v6.0.0 (commit e178113ff64 hw: Replace anti-social QOM type names).
> A few have crept back since:
>
>     xlnx,cframe-reg
>     xlnx,efuse
>     xlnx,pmc-efuse-cache
>     xlnx,versal-cfu-apb
>     xlnx,versal-cfu-fdro
>     xlnx,versal-cfu-sfr
>     xlnx,versal-crl
>     xlnx,versal-efuse
>     xlnx,zynqmp-efuse
>
> These are all device types.  They can't be plugged with -device /
> device_add, except for "xlnx,efuse" (I'm not sure that one is
> intentional).
>
> They *can* be used with -device / device_add to request help.
> Usability is poor, though: you have to double the comma, like this:
>
>     $ qemu-system-aarch64 -device xlnx,,pmc-efuse-cache,help
>
> They can also be used with -global, where you must *not* double the
> comma:
>
>     $ qemu-system-aarch64 -global xlnx,efuse.drive-index=3D2
>
> Trap for the unwary.
>
> "xlnx,efuse", "xlnx,versal-efuse", "xlnx,pmc-efuse-cache",
> "xlnx-zynqmp-efuse" are from v6.2.0, "xlnx,versal-crl" is from v7.1.0,
> and the remainder are new.
>
> Rename them all to "xlnx-FOO", like commit e178113ff64 did.
>
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  docs/system/arm/xlnx-versal-virt.rst     | 2 +-
>  include/hw/misc/xlnx-versal-cframe-reg.h | 2 +-
>  include/hw/misc/xlnx-versal-cfu.h        | 6 +++---
>  include/hw/misc/xlnx-versal-crl.h        | 2 +-
>  include/hw/nvram/xlnx-efuse.h            | 2 +-
>  include/hw/nvram/xlnx-versal-efuse.h     | 4 ++--
>  include/hw/nvram/xlnx-zynqmp-efuse.h     | 2 +-
>  7 files changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/docs/system/arm/xlnx-versal-virt.rst b/docs/system/arm/xlnx-=
versal-virt.rst
> index 9a4b2ff55f..0bafc76469 100644
> --- a/docs/system/arm/xlnx-versal-virt.rst
> +++ b/docs/system/arm/xlnx-versal-virt.rst
> @@ -212,7 +212,7 @@ To use a different index value, N, from default of 1,=
 add:
>
>  .. code-block:: bash
>
> -  -global xlnx,efuse.drive-index=3DN
> +  -global xlnx-efuse.drive-index=3DN
>
>  .. warning::
>    In actual physical Versal, BBRAM and eFUSE contain sensitive data.
> diff --git a/include/hw/misc/xlnx-versal-cframe-reg.h b/include/hw/misc/x=
lnx-versal-cframe-reg.h
> index a14fbd7fe4..f403b00e31 100644
> --- a/include/hw/misc/xlnx-versal-cframe-reg.h
> +++ b/include/hw/misc/xlnx-versal-cframe-reg.h
> @@ -23,7 +23,7 @@
>  #include "hw/misc/xlnx-versal-cfu.h"
>  #include "qemu/fifo32.h"
>
> -#define TYPE_XLNX_VERSAL_CFRAME_REG "xlnx,cframe-reg"
> +#define TYPE_XLNX_VERSAL_CFRAME_REG "xlnx-cframe-reg"
>  OBJECT_DECLARE_SIMPLE_TYPE(XlnxVersalCFrameReg, XLNX_VERSAL_CFRAME_REG)
>
>  #define TYPE_XLNX_VERSAL_CFRAME_BCAST_REG "xlnx.cframe-bcast-reg"
> diff --git a/include/hw/misc/xlnx-versal-cfu.h b/include/hw/misc/xlnx-ver=
sal-cfu.h
> index 86fb841053..8c581c0797 100644
> --- a/include/hw/misc/xlnx-versal-cfu.h
> +++ b/include/hw/misc/xlnx-versal-cfu.h
> @@ -22,13 +22,13 @@
>  #include "hw/misc/xlnx-cfi-if.h"
>  #include "qemu/fifo32.h"
>
> -#define TYPE_XLNX_VERSAL_CFU_APB "xlnx,versal-cfu-apb"
> +#define TYPE_XLNX_VERSAL_CFU_APB "xlnx-versal-cfu-apb"
>  OBJECT_DECLARE_SIMPLE_TYPE(XlnxVersalCFUAPB, XLNX_VERSAL_CFU_APB)
>
> -#define TYPE_XLNX_VERSAL_CFU_FDRO "xlnx,versal-cfu-fdro"
> +#define TYPE_XLNX_VERSAL_CFU_FDRO "xlnx-versal-cfu-fdro"
>  OBJECT_DECLARE_SIMPLE_TYPE(XlnxVersalCFUFDRO, XLNX_VERSAL_CFU_FDRO)
>
> -#define TYPE_XLNX_VERSAL_CFU_SFR "xlnx,versal-cfu-sfr"
> +#define TYPE_XLNX_VERSAL_CFU_SFR "xlnx-versal-cfu-sfr"
>  OBJECT_DECLARE_SIMPLE_TYPE(XlnxVersalCFUSFR, XLNX_VERSAL_CFU_SFR)
>
>  REG32(CFU_ISR, 0x0)
> diff --git a/include/hw/misc/xlnx-versal-crl.h b/include/hw/misc/xlnx-ver=
sal-crl.h
> index 2857f4169a..dfb8dff197 100644
> --- a/include/hw/misc/xlnx-versal-crl.h
> +++ b/include/hw/misc/xlnx-versal-crl.h
> @@ -13,7 +13,7 @@
>  #include "hw/register.h"
>  #include "target/arm/cpu.h"
>
> -#define TYPE_XLNX_VERSAL_CRL "xlnx,versal-crl"
> +#define TYPE_XLNX_VERSAL_CRL "xlnx-versal-crl"
>  OBJECT_DECLARE_SIMPLE_TYPE(XlnxVersalCRL, XLNX_VERSAL_CRL)
>
>  REG32(ERR_CTRL, 0x0)
> diff --git a/include/hw/nvram/xlnx-efuse.h b/include/hw/nvram/xlnx-efuse.=
h
> index 58414e468b..cff7924106 100644
> --- a/include/hw/nvram/xlnx-efuse.h
> +++ b/include/hw/nvram/xlnx-efuse.h
> @@ -30,7 +30,7 @@
>  #include "sysemu/block-backend.h"
>  #include "hw/qdev-core.h"
>
> -#define TYPE_XLNX_EFUSE "xlnx,efuse"
> +#define TYPE_XLNX_EFUSE "xlnx-efuse"
>  OBJECT_DECLARE_SIMPLE_TYPE(XlnxEFuse, XLNX_EFUSE);
>
>  struct XlnxEFuse {
> diff --git a/include/hw/nvram/xlnx-versal-efuse.h b/include/hw/nvram/xlnx=
-versal-efuse.h
> index a873dc5cb0..86e2261b9a 100644
> --- a/include/hw/nvram/xlnx-versal-efuse.h
> +++ b/include/hw/nvram/xlnx-versal-efuse.h
> @@ -29,8 +29,8 @@
>
>  #define XLNX_VERSAL_EFUSE_CTRL_R_MAX ((0x100 / 4) + 1)
>
> -#define TYPE_XLNX_VERSAL_EFUSE_CTRL  "xlnx,versal-efuse"
> -#define TYPE_XLNX_VERSAL_EFUSE_CACHE "xlnx,pmc-efuse-cache"
> +#define TYPE_XLNX_VERSAL_EFUSE_CTRL  "xlnx-versal-efuse"
> +#define TYPE_XLNX_VERSAL_EFUSE_CACHE "xlnx-pmc-efuse-cache"
>
>  OBJECT_DECLARE_SIMPLE_TYPE(XlnxVersalEFuseCtrl, XLNX_VERSAL_EFUSE_CTRL);
>  OBJECT_DECLARE_SIMPLE_TYPE(XlnxVersalEFuseCache, XLNX_VERSAL_EFUSE_CACHE=
);
> diff --git a/include/hw/nvram/xlnx-zynqmp-efuse.h b/include/hw/nvram/xlnx=
-zynqmp-efuse.h
> index 6b051ec4f1..f5beacc2e6 100644
> --- a/include/hw/nvram/xlnx-zynqmp-efuse.h
> +++ b/include/hw/nvram/xlnx-zynqmp-efuse.h
> @@ -29,7 +29,7 @@
>
>  #define XLNX_ZYNQMP_EFUSE_R_MAX ((0x10fc / 4) + 1)
>
> -#define TYPE_XLNX_ZYNQMP_EFUSE "xlnx,zynqmp-efuse"
> +#define TYPE_XLNX_ZYNQMP_EFUSE "xlnx-zynqmp-efuse"
>  OBJECT_DECLARE_SIMPLE_TYPE(XlnxZynqMPEFuse, XLNX_ZYNQMP_EFUSE);
>
>  struct XlnxZynqMPEFuse {
> --
> 2.42.0
>
>

