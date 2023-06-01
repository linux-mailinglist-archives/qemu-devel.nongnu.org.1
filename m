Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C8DB71F258
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 20:48:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4nLY-0001J1-Iv; Thu, 01 Jun 2023 14:48:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nieklinnenbank@gmail.com>)
 id 1q4nLB-00010Z-Ix; Thu, 01 Jun 2023 14:48:07 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nieklinnenbank@gmail.com>)
 id 1q4nL9-0005nG-6b; Thu, 01 Jun 2023 14:48:05 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-565cdb77b01so11214847b3.0; 
 Thu, 01 Jun 2023 11:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685645281; x=1688237281;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0u4QpJtg7Y432atmDsMZRS+s1fSyoLU6X98JegFDOpA=;
 b=sKPcEo9RjYIO2A0YUC8EmvRE/EpsxPGMV1k0q41vDqnthyISf+Nxh4iXiuka7o0qmH
 pPPZA/NsWtSIps+YyHp6FuuYYMxVw2DMkc3OKk4IRwGNgYRQbA5b4TRgWx5GmPEZ6zUQ
 25qRBMr0jE1cp2Ebg8x4+G9i0NvSFKeb2e56uJY2ezQnjeraO77tBKVqxgA42WWimG2j
 E/35x2KN53q9IQuan1fKZ7kt45wGMJELwcFYnOA3AaGX2ERVBj+CsRhQpEoTJXB6CB0Z
 qYuqHGcL5JPySrHqsZ1IQV/RGtHgsvitT74zZVvtoaESrAWH/Tdr+bRw3T7LtxiUWblE
 Nb2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685645281; x=1688237281;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0u4QpJtg7Y432atmDsMZRS+s1fSyoLU6X98JegFDOpA=;
 b=Bi8RQPk+QtMWtvKq14DTbG87Z7qI23LmczAoaswFOzdoGPMFX6NNIyqp/QMyNbNmE9
 d7PmNXEMB1tjJuE5xobtvmayEmENxUjvHjAohC3njcJfbVRfYHg59wb0iV7+lgnfdPKK
 WAU/o8Ek/j3xpjbqRmykOhIXLq0Q5WGjxrWRi/6NksQ4uw7TEYsxzXO7nBgfYg6AvIfL
 J6KWNRdquiygAj+PXtjtCUSu5VqdFBgKMBMg84QEhN/oCOR+72urew3lToiJgL1GMIFJ
 z+uKVLYTH+BOr7JWLm+iL3Y9+FTqtTe2Gp79AJOJs8vMvaQiZLdFokA+4xPqSn7w7Jyj
 KuFw==
X-Gm-Message-State: AC+VfDz2i6Ayu71G1IvbBa4n07s6QTxWMLFu3aSvoxdE8c4JPNCRAJpV
 32/2CLEPCNIbuVeqxO25GL0bQBRpzAE+E1YMT40=
X-Google-Smtp-Source: ACHHUZ4gjPzYPrqeaZsCOn0b9IGNdTvKfjsuufxYSPXrQ7YZ3x5aALgRs/vlFgKtWpfXzd5MZ8nH2Y5ELEeDaJmArIc=
X-Received: by 2002:a81:5e54:0:b0:565:2f72:f65c with SMTP id
 s81-20020a815e54000000b005652f72f65cmr9788182ywb.44.1685645281537; Thu, 01
 Jun 2023 11:48:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230523100508.32564-1-qianfanguijin@163.com>
In-Reply-To: <20230523100508.32564-1-qianfanguijin@163.com>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Thu, 1 Jun 2023 20:47:50 +0200
Message-ID: <CAPan3Wr1phuot=613sXh-hT0An1-A5vuhcxMZ9SCGTze9w_PdQ@mail.gmail.com>
Subject: Re: [PATCH v5 00/11] *** Add allwinner-r40 support ***
To: qianfanguijin@163.com
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Beniamino Galvani <b.galvani@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000039359a05fd15e09e"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=nieklinnenbank@gmail.com; helo=mail-yw1-x1134.google.com
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

--00000000000039359a05fd15e09e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Qianfan,

Thanks for sending the v5. From my side, I have no further comments on the
content.
So please feel free to add the following to each of the patches 01-11 in
the series:

Reviewed-by: Niek Linnenbank <nieklinnenbank@gmail.com>

As a reminder and explained here on this page, you'll need to make sure
these lines gets added to each of the commit messages:
https://www.qemu.org/docs/master/devel/submitting-a-patch.html#proper-use-o=
f-reviewed-by-tags-can-aid-review

Doing so would require you to send another updated v6, and baselined on the
latest master.

Thanks again for contributing this to Qemu, hopefully we can see it merged
soon.

Regards,
Niek

On Tue, May 23, 2023 at 12:05=E2=80=AFPM <qianfanguijin@163.com> wrote:

> From: qianfan Zhao <qianfanguijin@163.com>
>
> ***History***
> # v1: 2023-03-21
>
> The first version which add allwinner-r40 support, supported features:
>
> + ccu
> + dram controller
> + uart
> + i2c and pmic(axp221)
> + sdcard
> + emac/gmac
>
> Also provide a test case under avocado, running quickly test:
>
> $ AVOCADO_ALLOW_LARGE_STORAGE=3Dyes tests/venv/bin/avocado \
>     --verbose --show=3Dapp,console run -t machine:bpim2u \
>     ../tests/avocado/boot_linux_console.py
>
> # v2: 2023-03-28
>
> 1. Fix the waring and error reported by checkpatch.pl
> 2. Remove the other i2c controllers except that i2c0
> 3. Use an array to register mmc and uart devices
> 4. Rename axp209 to axp22x and add axp221 support
> 5. Add a basic SRAM controller
>
> # v3: 2023-04-18
>
> 1. Update some commit messages
> 2. Squash those two commit about sdcard
>    hw: sd: allwinner-sdhost: Add sun50i-a64 SoC support
>    hw: arm: allwinner-r40: Fix the mmc controller's type
>
> # v4: 2023-05-10
>
> 1. Rebase to master
>
> # v5: 2023-05-23
>
> 1. Rebase to master
> 2. Update based on Niek Linnenbank's guide.
>
> qianfan Zhao (11):
>   hw: arm: Add bananapi M2-Ultra and allwinner-r40 support
>   hw/arm/allwinner-r40: add Clock Control Unit
>   hw: allwinner-r40: Complete uart devices
>   hw: arm: allwinner-r40: Add i2c0 device
>   hw/misc: Rename axp209 to axp22x and add support AXP221 PMU
>   hw/arm/allwinner-r40: add SDRAM controller device
>   hw: sd: allwinner-sdhost: Add sun50i-a64 SoC support
>   hw: arm: allwinner-r40: Add emac and gmac support
>   hw: arm: allwinner-sramc: Add SRAM Controller support for R40
>   tests: avocado: boot_linux_console: Add test case for bpim2u
>   docs: system: arm: Introduce bananapi_m2u
>
>  docs/system/arm/bananapi_m2u.rst      | 138 +++++++
>  hw/arm/Kconfig                        |  14 +-
>  hw/arm/allwinner-r40.c                | 526 ++++++++++++++++++++++++++
>  hw/arm/bananapi_m2u.c                 | 145 +++++++
>  hw/arm/meson.build                    |   1 +
>  hw/misc/Kconfig                       |   5 +-
>  hw/misc/allwinner-r40-ccu.c           | 209 ++++++++++
>  hw/misc/allwinner-r40-dramc.c         | 513 +++++++++++++++++++++++++
>  hw/misc/allwinner-sramc.c             | 184 +++++++++
>  hw/misc/axp209.c                      | 238 ------------
>  hw/misc/axp2xx.c                      | 283 ++++++++++++++
>  hw/misc/meson.build                   |   5 +-
>  hw/misc/trace-events                  |  26 +-
>  hw/sd/allwinner-sdhost.c              |  72 +++-
>  include/hw/arm/allwinner-r40.h        | 143 +++++++
>  include/hw/misc/allwinner-r40-ccu.h   |  65 ++++
>  include/hw/misc/allwinner-r40-dramc.h | 108 ++++++
>  include/hw/misc/allwinner-sramc.h     |  69 ++++
>  include/hw/sd/allwinner-sdhost.h      |   9 +
>  tests/avocado/boot_linux_console.py   | 176 +++++++++
>  20 files changed, 2681 insertions(+), 248 deletions(-)
>  create mode 100644 docs/system/arm/bananapi_m2u.rst
>  create mode 100644 hw/arm/allwinner-r40.c
>  create mode 100644 hw/arm/bananapi_m2u.c
>  create mode 100644 hw/misc/allwinner-r40-ccu.c
>  create mode 100644 hw/misc/allwinner-r40-dramc.c
>  create mode 100644 hw/misc/allwinner-sramc.c
>  delete mode 100644 hw/misc/axp209.c
>  create mode 100644 hw/misc/axp2xx.c
>  create mode 100644 include/hw/arm/allwinner-r40.h
>  create mode 100644 include/hw/misc/allwinner-r40-ccu.h
>  create mode 100644 include/hw/misc/allwinner-r40-dramc.h
>  create mode 100644 include/hw/misc/allwinner-sramc.h
>
> --
> 2.25.1
>
>

--=20
Niek Linnenbank

--00000000000039359a05fd15e09e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Qianfan,<br></div><div><br></div><div>=
Thanks for sending the v5. From my side, I have no further comments on the =
content. <br></div><div>So please feel free to add the following to each of=
 the patches 01-11 in the series:</div><div><br></div><div>Reviewed-by: Nie=
k Linnenbank &lt;<a href=3D"mailto:nieklinnenbank@gmail.com">nieklinnenbank=
@gmail.com</a>&gt;</div><div><br></div><div>As a reminder and explained her=
e on this page, you&#39;ll need to make sure these lines gets added to each=
 of the commit messages:<br></div><div><a href=3D"https://www.qemu.org/docs=
/master/devel/submitting-a-patch.html#proper-use-of-reviewed-by-tags-can-ai=
d-review" target=3D"_blank">https://www.qemu.org/docs/master/devel/submitti=
ng-a-patch.html#proper-use-of-reviewed-by-tags-can-aid-review</a></div><div=
><br></div><div>Doing so would require you to send another updated v6, and =
baselined on the latest master.</div><div><br></div><div>Thanks again for c=
ontributing this to Qemu, hopefully we can see it merged soon.</div><div><b=
r></div><div>Regards,</div><div>Niek<br></div><div><br></div><div class=3D"=
gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, May 23, 2023 at =
12:05=E2=80=AFPM &lt;<a href=3D"mailto:qianfanguijin@163.com">qianfanguijin=
@163.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">From: qianfan Zhao &lt;<a href=3D"mailto:qianfanguijin@163.com" tar=
get=3D"_blank">qianfanguijin@163.com</a>&gt;<br>
<br>
***History***<br>
# v1: 2023-03-21<br>
<br>
The first version which add allwinner-r40 support, supported features:<br>
<br>
+ ccu<br>
+ dram controller<br>
+ uart<br>
+ i2c and pmic(axp221)<br>
+ sdcard<br>
+ emac/gmac<br>
<br>
Also provide a test case under avocado, running quickly test:<br>
<br>
$ AVOCADO_ALLOW_LARGE_STORAGE=3Dyes tests/venv/bin/avocado \<br>
=C2=A0 =C2=A0 --verbose --show=3Dapp,console run -t machine:bpim2u \<br>
=C2=A0 =C2=A0 ../tests/avocado/boot_linux_console.py<br>
<br>
# v2: 2023-03-28<br>
<br>
1. Fix the waring and error reported by <a href=3D"http://checkpatch.pl" re=
l=3D"noreferrer" target=3D"_blank">checkpatch.pl</a><br>
2. Remove the other i2c controllers except that i2c0<br>
3. Use an array to register mmc and uart devices<br>
4. Rename axp209 to axp22x and add axp221 support<br>
5. Add a basic SRAM controller<br>
<br>
# v3: 2023-04-18<br>
<br>
1. Update some commit messages<br>
2. Squash those two commit about sdcard<br>
=C2=A0 =C2=A0hw: sd: allwinner-sdhost: Add sun50i-a64 SoC support<br>
=C2=A0 =C2=A0hw: arm: allwinner-r40: Fix the mmc controller&#39;s type<br>
<br>
# v4: 2023-05-10<br>
<br>
1. Rebase to master<br>
<br>
# v5: 2023-05-23<br>
<br>
1. Rebase to master<br>
2. Update based on Niek Linnenbank&#39;s guide.<br>
<br>
qianfan Zhao (11):<br>
=C2=A0 hw: arm: Add bananapi M2-Ultra and allwinner-r40 support<br>
=C2=A0 hw/arm/allwinner-r40: add Clock Control Unit<br>
=C2=A0 hw: allwinner-r40: Complete uart devices<br>
=C2=A0 hw: arm: allwinner-r40: Add i2c0 device<br>
=C2=A0 hw/misc: Rename axp209 to axp22x and add support AXP221 PMU<br>
=C2=A0 hw/arm/allwinner-r40: add SDRAM controller device<br>
=C2=A0 hw: sd: allwinner-sdhost: Add sun50i-a64 SoC support<br>
=C2=A0 hw: arm: allwinner-r40: Add emac and gmac support<br>
=C2=A0 hw: arm: allwinner-sramc: Add SRAM Controller support for R40<br>
=C2=A0 tests: avocado: boot_linux_console: Add test case for bpim2u<br>
=C2=A0 docs: system: arm: Introduce bananapi_m2u<br>
<br>
=C2=A0docs/system/arm/bananapi_m2u.rst=C2=A0 =C2=A0 =C2=A0 | 138 +++++++<br=
>
=C2=A0hw/arm/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 14 +-<br>
=C2=A0hw/arm/allwinner-r40.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 | 526 ++++++++++++++++++++++++++<br>
=C2=A0hw/arm/bananapi_m2u.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0| 145 +++++++<br>
=C2=A0hw/arm/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
=C2=A0hw/misc/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A05 +-<br>
=C2=A0hw/misc/allwinner-r40-ccu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
 209 ++++++++++<br>
=C2=A0hw/misc/allwinner-r40-dramc.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 513 =
+++++++++++++++++++++++++<br>
=C2=A0hw/misc/allwinner-sramc.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0| 184 +++++++++<br>
=C2=A0hw/misc/axp209.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 | 238 ------------<br>
=C2=A0hw/misc/axp2xx.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 | 283 ++++++++++++++<br>
=C2=A0hw/misc/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A05 +-<br>
=C2=A0hw/misc/trace-events=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 26 +-<br>
=C2=A0hw/sd/allwinner-sdhost.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 72 +++-<br>
=C2=A0include/hw/arm/allwinner-r40.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 143 +++++=
++<br>
=C2=A0include/hw/misc/allwinner-r40-ccu.h=C2=A0 =C2=A0|=C2=A0 65 ++++<br>
=C2=A0include/hw/misc/allwinner-r40-dramc.h | 108 ++++++<br>
=C2=A0include/hw/misc/allwinner-sramc.h=C2=A0 =C2=A0 =C2=A0|=C2=A0 69 ++++<=
br>
=C2=A0include/hw/sd/allwinner-sdhost.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A09 =
+<br>
=C2=A0tests/avocado/boot_linux_console.py=C2=A0 =C2=A0| 176 +++++++++<br>
=C2=A020 files changed, 2681 insertions(+), 248 deletions(-)<br>
=C2=A0create mode 100644 docs/system/arm/bananapi_m2u.rst<br>
=C2=A0create mode 100644 hw/arm/allwinner-r40.c<br>
=C2=A0create mode 100644 hw/arm/bananapi_m2u.c<br>
=C2=A0create mode 100644 hw/misc/allwinner-r40-ccu.c<br>
=C2=A0create mode 100644 hw/misc/allwinner-r40-dramc.c<br>
=C2=A0create mode 100644 hw/misc/allwinner-sramc.c<br>
=C2=A0delete mode 100644 hw/misc/axp209.c<br>
=C2=A0create mode 100644 hw/misc/axp2xx.c<br>
=C2=A0create mode 100644 include/hw/arm/allwinner-r40.h<br>
=C2=A0create mode 100644 include/hw/misc/allwinner-r40-ccu.h<br>
=C2=A0create mode 100644 include/hw/misc/allwinner-r40-dramc.h<br>
=C2=A0create mode 100644 include/hw/misc/allwinner-sramc.h<br>
<br>
-- <br>
2.25.1<br>
<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"l=
tr"><div>Niek Linnenbank<br><br></div></div></div></div>

--00000000000039359a05fd15e09e--

