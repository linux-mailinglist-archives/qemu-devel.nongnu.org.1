Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 15733703E99
	for <lists+qemu-devel@lfdr.de>; Mon, 15 May 2023 22:26:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyelf-0005wV-Ny; Mon, 15 May 2023 16:26:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nieklinnenbank@gmail.com>)
 id 1pyeld-0005wD-7m; Mon, 15 May 2023 16:26:01 -0400
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nieklinnenbank@gmail.com>)
 id 1pyelV-0003Oj-0m; Mon, 15 May 2023 16:25:59 -0400
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-55a8e9e2c53so128844707b3.1; 
 Mon, 15 May 2023 13:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684182349; x=1686774349;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=loTe2ezm63dO8A2WnLhICsk8D4vhA7nIzOE3SNFN7b8=;
 b=ikfULmn0SwlZrdlQACf3PWwxuE4QIhFfJXtBW/k9fYgNBLLlZMhHAi5F8W2ggvClMi
 +QbxsMMiLFnJZ5sVPt7bg0il2cHynDXiW2fR7GJweAvB8nGdm6XtEj7ud+dfQ3OFMROI
 l3jdOFXKvLIM6VYbQOJG2E6O8cDx/pLg0ey3QdhRq5LHJUksF1lYIvMJv9pzkVwh7KdH
 H9EdXegto3rQ5nLFlc0/S9HkYshVJ89DsKuuivaLoGwyVAMK4xOeuOEqIV+/bVC2FP2T
 0VWaJvQO6YfjWaEbFHtKD17RfHyBvRYYIMY3GvlD8SRy1/tKROBvn3gez4GHhsnaGJRg
 sc4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684182349; x=1686774349;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=loTe2ezm63dO8A2WnLhICsk8D4vhA7nIzOE3SNFN7b8=;
 b=OeyXuwgHOGrivBjyjO/MiOzLMEekNp+fNwacth1EUNu8KLwKmeVPkRl+rZjXEsZhuc
 Uxh0WNIb5v3zEpD5ozrEl7kZ5rQDduPfZ0Itn3RzmkiD7sjAh7WgnyztpRFKODamoJyf
 9OqOu0UkWzGt88DJBBCWWZf7XvqgvYvFplyw0bRwzD7ZGhx4ZgfmetuSHW2II9bQ+k92
 +rVXdQSjpWjkjbUteGdLLma4Q4vxs6YBErl9/otRyGPUTdq9/EDR8sQER61euefcvVGk
 dhoITYhcJqkhJVp37iRmpBa/eJK2bmDp3dMRwV2e2Q6TOvSzkI5a6se1pBv4Z3oGW9zy
 Xvbw==
X-Gm-Message-State: AC+VfDzs4q8GguXY7aIN7Puu+QGyXERoS4yqcngVoRJZEOjmdNalFGQf
 v9hvDx0MUtCbmF+0T474oN5VvMdlx+5kaxu5DUc=
X-Google-Smtp-Source: ACHHUZ4xy7PdykCKDgeYvnH1IAoMZr8tsltgAbt26fnyJyAFLR6PtNJs5PQR6CSsWrd7m2XSh6TCPuhRcWuFEoe8Kuc=
X-Received: by 2002:a0d:ea96:0:b0:55a:dd:9d2a with SMTP id
 t144-20020a0dea96000000b0055a00dd9d2amr31886947ywe.52.1684182349693; 
 Mon, 15 May 2023 13:25:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230510103004.30015-1-qianfanguijin@163.com>
In-Reply-To: <20230510103004.30015-1-qianfanguijin@163.com>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Mon, 15 May 2023 22:25:38 +0200
Message-ID: <CAPan3WrukRx7NSBsCFkgfaRwbGD4j1P_SZpNiUJk5T3030aKug@mail.gmail.com>
Subject: Re: [PATCH v4 00/11] *** Add allwinner r40 support ***
To: qianfanguijin@163.com
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Beniamino Galvani <b.galvani@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000b0c7a505fbc142f6"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=nieklinnenbank@gmail.com; helo=mail-yw1-x112e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

--000000000000b0c7a505fbc142f6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Qianfan,

Thanks for sending the v4. I've reviewed all patches and replied to each
individual patch.

Great work so far!

One thing I wanted to mention is that when you receive a 'Reviewed-by:' or
'Tested-by:' line from a reviewer,
please feel free to include it in the commit message on the next version of
that patch. This helps you and reviewers
to keep track on what has been reviewed and what not.

For more details on this and the review process, also see this page:
https://www.qemu.org/docs/master/devel/submitting-a-patch.html#proper-use-o=
f-reviewed-by-tags-can-aid-review

Kind regards,
Niek

On Wed, May 10, 2023 at 12:30=E2=80=AFPM <qianfanguijin@163.com> wrote:

> From: qianfan Zhao <qianfanguijin@163.com>
>
>
> *** history ***
>
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
>  hw/sd/allwinner-sdhost.c              |  70 +++-
>  include/hw/arm/allwinner-r40.h        | 143 +++++++
>  include/hw/misc/allwinner-r40-ccu.h   |  65 ++++
>  include/hw/misc/allwinner-r40-dramc.h | 108 ++++++
>  include/hw/misc/allwinner-sramc.h     |  69 ++++
>  include/hw/sd/allwinner-sdhost.h      |   9 +
>  tests/avocado/boot_linux_console.py   | 176 +++++++++
>  20 files changed, 2679 insertions(+), 248 deletions(-)
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

--000000000000b0c7a505fbc142f6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Qianfan,</div><div><br></div><div>Thanks for sendi=
ng the v4. I&#39;ve reviewed all patches and replied to each individual pat=
ch.<br></div><div><br></div><div>Great work so far!</div><div><br></div><di=
v>One thing I wanted to mention is that when you receive a &#39;Reviewed-by=
:&#39; or &#39;Tested-by:&#39; line from a reviewer,</div><div>please feel =
free to include it in the commit message on the next version of that patch.=
 This helps you and reviewers</div><div>to keep track on what has been revi=
ewed and what not.</div><div><br></div><div>For more details on this and th=
e review process, also see this page:</div><div><a href=3D"https://www.qemu=
.org/docs/master/devel/submitting-a-patch.html#proper-use-of-reviewed-by-ta=
gs-can-aid-review">https://www.qemu.org/docs/master/devel/submitting-a-patc=
h.html#proper-use-of-reviewed-by-tags-can-aid-review</a></div><div><br></di=
v><div>Kind regards,</div><div>Niek<br></div><br><div class=3D"gmail_quote"=
><div dir=3D"ltr" class=3D"gmail_attr">On Wed, May 10, 2023 at 12:30=E2=80=
=AFPM &lt;<a href=3D"mailto:qianfanguijin@163.com">qianfanguijin@163.com</a=
>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Fro=
m: qianfan Zhao &lt;<a href=3D"mailto:qianfanguijin@163.com" target=3D"_bla=
nk">qianfanguijin@163.com</a>&gt;<br>
<br>
<br>
*** history ***<br>
<br>
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
=A0 |=C2=A0 70 +++-<br>
=C2=A0include/hw/arm/allwinner-r40.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 143 +++++=
++<br>
=C2=A0include/hw/misc/allwinner-r40-ccu.h=C2=A0 =C2=A0|=C2=A0 65 ++++<br>
=C2=A0include/hw/misc/allwinner-r40-dramc.h | 108 ++++++<br>
=C2=A0include/hw/misc/allwinner-sramc.h=C2=A0 =C2=A0 =C2=A0|=C2=A0 69 ++++<=
br>
=C2=A0include/hw/sd/allwinner-sdhost.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A09 =
+<br>
=C2=A0tests/avocado/boot_linux_console.py=C2=A0 =C2=A0| 176 +++++++++<br>
=C2=A020 files changed, 2679 insertions(+), 248 deletions(-)<br>
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

--000000000000b0c7a505fbc142f6--

