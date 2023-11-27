Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E4C7F9A9F
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 08:15:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7VoF-0006zD-F6; Mon, 27 Nov 2023 02:13:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r7Vo9-0006xw-Vy; Mon, 27 Nov 2023 02:13:31 -0500
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r7Vo7-0008SB-6M; Mon, 27 Nov 2023 02:13:29 -0500
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3b843fea0dfso2330632b6e.3; 
 Sun, 26 Nov 2023 23:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701069204; x=1701674004; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+pZipqOZvK1ewdgkIYX9BcSo7tsJ4MT++dri8e8NAmQ=;
 b=b3WDyOOceZ68SqVLOX5O+R1E9d9E8WA9si9tcyaVdPqdFtr/Dhtra5K3a+YD4BzP6d
 hlBJZgdDRL5ypOLSVzE/8ydMr1g2VhLnHAMvb5fXiN82iFF1cA+Xrv2RFy7LrAB8hke6
 Sdycp/BrzdMj+IgACyUtYZNYbNqkl/qeLgMukzIirxIr7rKLjQyetF5g+zj3zq9D8Ypl
 +WcAxRpMfoEGdEHz6r1mgh/qaZH3tw6SbshMqkUwNzwhhQa0Bsf4oEDV+aXPi0Ds0S4Z
 BmR1z4nBzbdi3Fsp9eA+kme2SEUb7EcWRA89nQjwHBH/5p71b1/lzNTkLpxIVPtoFb+V
 WmBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701069204; x=1701674004;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+pZipqOZvK1ewdgkIYX9BcSo7tsJ4MT++dri8e8NAmQ=;
 b=SRCI33aHdTZxYtqyKE9NpwTK82EptxorqAE/pCg6k8iGRttxAo2EmgU3qlzJMgPxlv
 Ir7lxniwsk2yejreK6Rs5uQVVsp8M+AhkDJ/P29MZJ0wMMQQVRMc0IRKj6N4gNaNV+Rm
 hlNnlpZv5JbeOeubXhYqUaARCEl1LRBMlqO/7coHwZYxLkvGdx3uoDy4LqEeXfWajsuj
 XvOuTKpZm3IwLIJRDa9tVcrsm5eXGFKse6WG9t6Qj9thK87kSeFC859/TOtpHMr/cCCL
 suxtinCfYoOLsYXf/jyr2cz/etHEOH4gr7/m2q+5/KQbivj+sFdC2Z2bPZqs2BwmE1NN
 /Ecg==
X-Gm-Message-State: AOJu0YxiLuqL+3yFQQ2o40vag0WIxYTAAp/gKyEPNNmFENAFX2+rMUoF
 L/fVAZCZnsaAHoUl0FVQ/bI=
X-Google-Smtp-Source: AGHT+IHxEyZgK82X3lUOXI5IZS4EYnJXj6HronTUQiBNfCrzJmxTlM/695MVxZ+3Cyt4jpDOrloAzw==
X-Received: by 2002:a05:6871:3a0f:b0:1ef:b0d5:de4f with SMTP id
 pu15-20020a0568713a0f00b001efb0d5de4fmr12722707oac.23.1701069204516; 
 Sun, 26 Nov 2023 23:13:24 -0800 (PST)
Received: from localhost ([1.146.21.219]) by smtp.gmail.com with ESMTPSA id
 q25-20020aa79839000000b006cb75e0eb02sm6471504pfl.152.2023.11.26.23.13.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Nov 2023 23:13:21 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 27 Nov 2023 17:13:13 +1000
Message-Id: <CX9EPBH7MMHK.14A30GV035VAZ@wheely>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>, <clg@kaod.org>,
 <philmd@linaro.org>
Subject: Re: [PATCH v2 for-8.2] ppc/amigaone: Allow running AmigaOS without
 firmware image
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20231125163425.3B3BC756078@zero.eik.bme.hu>
In-Reply-To: <20231125163425.3B3BC756078@zero.eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::232;
 envelope-from=npiggin@gmail.com; helo=mail-oi1-x232.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Sun Nov 26, 2023 at 2:34 AM AEST, BALATON Zoltan wrote:
> The machine uses a modified U-Boot under GPL license but the sources
> of it are lost with only a binary available so it cannot be included
> in QEMU. Allow running without the firmware image with -bios none
> which can be used when calling a boot loader directly and thus
> simplifying booting guests. We need a small routine that AmigaOS calls
> from ROM which is added in this case to allow booting AmigaOS without
> external firmware image.
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
> v2: Unfortunately AmigaOS needs some additional ROM part which is added
> Please merge for 8.2 as it allows booting AmigaOS simpler without
> having to download separate firmware.

How to test this?

>
>  hw/ppc/amigaone.c | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
>
> diff --git a/hw/ppc/amigaone.c b/hw/ppc/amigaone.c
> index 992a55e632..a11d2d5556 100644
> --- a/hw/ppc/amigaone.c
> +++ b/hw/ppc/amigaone.c
> @@ -40,6 +40,16 @@
>  #define PROM_ADDR 0xfff00000
>  #define PROM_SIZE (512 * KiB)
> =20
> +/* AmigaOS calls this routine from ROM, use this if -bios none */
> +static const char dummy_fw[] =3D {
> +    0x38, 0x00, 0x00, 0x08, /* li      r0,8 */
> +    0x7c, 0x09, 0x03, 0xa6, /* mtctr   r0 */
> +    0x54, 0x63, 0xf8, 0x7e, /* srwi    r3,r3,1 */
> +    0x42, 0x00, 0xff, 0xfc, /* bdnz    0x8 */
> +    0x7c, 0x63, 0x18, 0xf8, /* not     r3,r3 */
> +    0x4e, 0x80, 0x00, 0x20, /* blr */
> +};

This is clever, but does anything else create blobs like this?
It could be put into a .S in pc-bios, which might be a bit more
consistent.

We might make a ppc/ subdirectory under there, but that's for
another time.

Thanks,
Nick

> +
>  static void amigaone_cpu_reset(void *opaque)
>  {
>      PowerPCCPU *cpu =3D opaque;
> @@ -94,17 +104,21 @@ static void amigaone_init(MachineState *machine)
>      }
> =20
>      /* allocate and load firmware */
> +    rom =3D g_new(MemoryRegion, 1);
> +    memory_region_init_rom(rom, NULL, "rom", PROM_SIZE, &error_fatal);
> +    memory_region_add_subregion(get_system_memory(), PROM_ADDR, rom);
>      filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, fwname);
>      if (filename) {
> -        rom =3D g_new(MemoryRegion, 1);
> -        memory_region_init_rom(rom, NULL, "rom", PROM_SIZE, &error_fatal=
);
> -        memory_region_add_subregion(get_system_memory(), PROM_ADDR, rom)=
;
>          sz =3D load_image_targphys(filename, PROM_ADDR, PROM_SIZE);
>          if (sz <=3D 0 || sz > PROM_SIZE) {
>              error_report("Could not load firmware '%s'", filename);
>              exit(1);
>          }
>          g_free(filename);
> +    } else if (!strcmp(fwname, "none")) {
> +        address_space_write_rom(&address_space_memory, 0xfff7ff80,
> +                                MEMTXATTRS_UNSPECIFIED, dummy_fw,
> +                                ARRAY_SIZE(dummy_fw));
>      } else if (!qtest_enabled()) {
>          error_report("Could not find firmware '%s'", fwname);
>          exit(1);


