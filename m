Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 85ED1A76D81
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Mar 2025 21:33:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzKrH-00067B-Oh; Mon, 31 Mar 2025 15:31:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzKrF-000670-2P
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 15:31:41 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzKrC-0000rm-Uw
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 15:31:40 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-39ac9aea656so3967080f8f.3
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 12:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743449497; x=1744054297; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PgKjDx16cMbHOU/aeCfkDN8fgf0i7WI7ytkAvB4TVOc=;
 b=YYiPZkr8cdIby8m5fXc95y9VmE1nOD8nLCanWUAmFHxT6aftn6tnHkMaNVS/Srkr2T
 kZJ5ookdmb8b115ZW4lr+t3PPmx33L4Y7XU3xm2S99QL5/up53nUmDW4yvuQNzSTsShb
 m53TiSEOkHou9b98++GVcnQdqWnJ+RjDQZbfuxrJK4dwIEO7LHLpjF9zcvKOQXo/DvFR
 GQS14ZToa6kXEMzi6Ae6VfTB1Ho7lI1+rcehSX2bjsM3yvwOzZNYMos0SZ7EMxqdJWgj
 QZd6XsztoBLbSxkwtu1pHLvZsL4Fy2csiMkKRha2nIVjnZHU5CY9L3XUmNK8lrYllrjN
 0/iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743449497; x=1744054297;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PgKjDx16cMbHOU/aeCfkDN8fgf0i7WI7ytkAvB4TVOc=;
 b=YK23pyRiJ4VHxWW/BKB/qMM7RXWIlwtBvDgW3Lo6MXFz53BUT+qdONtXWhIeYo1Syv
 C8vs6FWZPHwK9jyjJsM7kg/k/kTgANFENylFhgkE3End35leGMmchxtv6ItE3vHGR93w
 Wh+3+xmQeq9cwZvgE7uKaqtrtlRFtAAYcg06QvcX0S9VddWrw+P8593Ilvs3ZhHS4P0N
 Q22WD3A7y4yoJD65WUoWO6oSmZFNClZ3rKyTrkvCTvUGBo4lON1SeRDJlmlmoiZ8WHB0
 IGmuCzPInwVBd643B8ssbywvcG4O4UYvLH80jY+h2pPrh4pg3o8P/0LU0VuYwe5fE/e5
 c9fQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsJ8DYLxDLpqSsz286D/nXxeCQIwKVzhHHOAbvnUd1JNNNwp3g2T8tPcFT6v6bYSdT27nO0jtWUnPs@nongnu.org
X-Gm-Message-State: AOJu0YxHFEqjdG8rSO+Gv7bIQGwrjisUTmNJMjVR3l0VtC0Hrs2tjvGe
 1nE+S0S4F6v+CbWDzS8I6JaFvaM1AhKd9p2ZRcZRTKnkf2p9vY9XlTkeuMEYaw0=
X-Gm-Gg: ASbGncvJWBBouzYD+IHKky3S/lNB3Be/Snt1kJ/jqgcFuWoKkGVITP/5eQTMBULsfW9
 GObM4sPxgdWAiAA3c3B9uDOOnfjo2oCLWYv+DxYTb9gxpFxgLIB2ROdgOtJzCW2NusXWtBmifIR
 o+3rCbOnuYtOjlnPmRwWS8fDmOOCMjf9UDjbkKAWraempAMAEx6CeCui81JdYZCuXQyAz6+N6xv
 N/R6bUw9Fx9HYMTt7J20sL32kI8+qc+vqMdcufVNyWGI52anie5vmFWs7eGRwU0YxtXBU7ohOjX
 lD3XU+zVFPdYQFoa0RSbtfThm86YseQJavH6tH4vDHvX8KnmcPQmzuIn6Wtu45mPLvU2DEyLgza
 PO3aaYD0SFezkqubuCMPemAI=
X-Google-Smtp-Source: AGHT+IH6hoNg+uBy4GlJdlvokmvWf2x+cLQNg5fB2X365X8UcNX3hVlCc/sQ2ufo7nI869uFgcyAVA==
X-Received: by 2002:a05:6000:1aca:b0:391:1458:2233 with SMTP id
 ffacd0b85a97d-39c120cb5b1mr6927742f8f.11.1743449496712; 
 Mon, 31 Mar 2025 12:31:36 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b66ab6dsm11809744f8f.48.2025.03.31.12.31.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Mar 2025 12:31:36 -0700 (PDT)
Message-ID: <c9616706-3c10-439e-98be-0b026343abf4@linaro.org>
Date: Mon, 31 Mar 2025 21:31:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] pc-bios: Move device tree files in their own subdir
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 Stefan Weil <sw@weilnetz.de>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <cover.1743262839.git.balaton@eik.bme.hu>
 <bb208aab670cc59bdb1f7ea67239e2b72884f317.1743262839.git.balaton@eik.bme.hu>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <bb208aab670cc59bdb1f7ea67239e2b72884f317.1743262839.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

+Stefan

On 29/3/25 16:43, BALATON Zoltan wrote:
> We have several device tree files already and may have more in the
> future so add a new dtb subdirectory and move device tree files there
> so they are not mixed with ROM binaries.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   MAINTAINERS                                |   2 +-
>   pc-bios/{ => dtb}/bamboo.dtb               | Bin
>   pc-bios/{ => dtb}/bamboo.dts               |   0
>   pc-bios/{ => dtb}/canyonlands.dtb          | Bin
>   pc-bios/{ => dtb}/canyonlands.dts          |   0
>   pc-bios/dtb/meson.build                    |  23 +++++++++++++++++++++
>   pc-bios/{ => dtb}/petalogix-ml605.dtb      | Bin
>   pc-bios/{ => dtb}/petalogix-ml605.dts      |   0
>   pc-bios/{ => dtb}/petalogix-s3adsp1800.dtb | Bin
>   pc-bios/{ => dtb}/petalogix-s3adsp1800.dts |   0
>   pc-bios/meson.build                        |  23 +--------------------
>   system/datadir.c                           |   4 +++-
>   12 files changed, 28 insertions(+), 24 deletions(-)
>   rename pc-bios/{ => dtb}/bamboo.dtb (100%)
>   rename pc-bios/{ => dtb}/bamboo.dts (100%)
>   rename pc-bios/{ => dtb}/canyonlands.dtb (100%)
>   rename pc-bios/{ => dtb}/canyonlands.dts (100%)
>   create mode 100644 pc-bios/dtb/meson.build
>   rename pc-bios/{ => dtb}/petalogix-ml605.dtb (100%)
>   rename pc-bios/{ => dtb}/petalogix-ml605.dts (100%)
>   rename pc-bios/{ => dtb}/petalogix-s3adsp1800.dtb (100%)
>   rename pc-bios/{ => dtb}/petalogix-s3adsp1800.dts (100%)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d54b5578f8..9349950527 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1569,7 +1569,7 @@ F: hw/pci-host/ppc440_pcix.c
>   F: hw/display/sm501*
>   F: hw/ide/sii3112.c
>   F: hw/rtc/m41t80.c
> -F: pc-bios/canyonlands.dt[sb]
> +F: pc-bios/dtb/canyonlands.dt[sb]
>   F: pc-bios/u-boot-sam460ex-20100605.bin
>   F: roms/u-boot-sam460ex
>   F: docs/system/ppc/amigang.rst
> diff --git a/pc-bios/bamboo.dtb b/pc-bios/dtb/bamboo.dtb
> similarity index 100%
> rename from pc-bios/bamboo.dtb
> rename to pc-bios/dtb/bamboo.dtb
> diff --git a/pc-bios/bamboo.dts b/pc-bios/dtb/bamboo.dts
> similarity index 100%
> rename from pc-bios/bamboo.dts
> rename to pc-bios/dtb/bamboo.dts
> diff --git a/pc-bios/canyonlands.dtb b/pc-bios/dtb/canyonlands.dtb
> similarity index 100%
> rename from pc-bios/canyonlands.dtb
> rename to pc-bios/dtb/canyonlands.dtb
> diff --git a/pc-bios/canyonlands.dts b/pc-bios/dtb/canyonlands.dts
> similarity index 100%
> rename from pc-bios/canyonlands.dts
> rename to pc-bios/dtb/canyonlands.dts
> diff --git a/pc-bios/dtb/meson.build b/pc-bios/dtb/meson.build
> new file mode 100644
> index 0000000000..7a71835bca
> --- /dev/null
> +++ b/pc-bios/dtb/meson.build
> @@ -0,0 +1,23 @@
> +dtbs = [
> +  'bamboo.dtb',
> +  'canyonlands.dtb',
> +  'petalogix-ml605.dtb',
> +  'petalogix-s3adsp1800.dtb',
> +]
> +
> +dtc = find_program('dtc', required: false)
> +if dtc.found()
> +  foreach out : dtbs
> +    f = fs.replace_suffix(out, '.dts')
> +    custom_target(f,
> +        build_by_default: have_system,
> +        input: files(f),
> +        output: out,
> +        install: get_option('install_blobs'),
> +        install_dir: qemu_datadir / 'dtb',
> +        command: [ dtc, '-q', '-I', 'dts', '-O', 'dtb',
> +                        '-o', '@OUTPUT@', '@INPUT0@' ])
> +  endforeach
> +else
> +    install_data(dtbs, install_dir: qemu_datadir / 'dtb')
> +endif
> diff --git a/pc-bios/petalogix-ml605.dtb b/pc-bios/dtb/petalogix-ml605.dtb
> similarity index 100%
> rename from pc-bios/petalogix-ml605.dtb
> rename to pc-bios/dtb/petalogix-ml605.dtb
> diff --git a/pc-bios/petalogix-ml605.dts b/pc-bios/dtb/petalogix-ml605.dts
> similarity index 100%
> rename from pc-bios/petalogix-ml605.dts
> rename to pc-bios/dtb/petalogix-ml605.dts
> diff --git a/pc-bios/petalogix-s3adsp1800.dtb b/pc-bios/dtb/petalogix-s3adsp1800.dtb
> similarity index 100%
> rename from pc-bios/petalogix-s3adsp1800.dtb
> rename to pc-bios/dtb/petalogix-s3adsp1800.dtb
> diff --git a/pc-bios/petalogix-s3adsp1800.dts b/pc-bios/dtb/petalogix-s3adsp1800.dts
> similarity index 100%
> rename from pc-bios/petalogix-s3adsp1800.dts
> rename to pc-bios/dtb/petalogix-s3adsp1800.dts
> diff --git a/pc-bios/meson.build b/pc-bios/meson.build
> index 34d6616c32..34d8cc4f33 100644
> --- a/pc-bios/meson.build
> +++ b/pc-bios/meson.build
> @@ -86,31 +86,10 @@ blobs = [
>     'vof-nvram.bin',
>   ]
>   
> -dtc = find_program('dtc', required: false)
> -foreach f : [
> -  'bamboo.dts',
> -  'canyonlands.dts',
> -  'petalogix-s3adsp1800.dts',
> -  'petalogix-ml605.dts',
> -]
> -  out = fs.replace_suffix(f, '.dtb')
> -  if dtc.found()
> -    custom_target(f,
> -        build_by_default: have_system,
> -        input: files(f),
> -        output: out,
> -        install: get_option('install_blobs'),
> -        install_dir: qemu_datadir,
> -        command: [ dtc, '-q', '-I', 'dts', '-O', 'dtb',
> -                        '-o', '@OUTPUT@', '@INPUT0@' ])
> -  else
> -    blobs += out
> -  endif
> -endforeach
> -
>   if get_option('install_blobs')
>     install_data(blobs, install_dir: qemu_datadir)
>   endif
>   
>   subdir('descriptors')
> +subdir('dtb')
>   subdir('keymaps')
> diff --git a/system/datadir.c b/system/datadir.c
> index e450b84ce9..f96f8fc264 100644
> --- a/system/datadir.c
> +++ b/system/datadir.c
> @@ -44,9 +44,11 @@ char *qemu_find_file(QemuFileType type, const char *name)
>   
>       switch (type) {
>       case QEMU_FILE_TYPE_BIOS:
> -    case QEMU_FILE_TYPE_DTB:
>           subdir = "";
>           break;
> +    case QEMU_FILE_TYPE_DTB:
> +        subdir = "dtb/";
> +        break;
>       case QEMU_FILE_TYPE_KEYMAP:
>           subdir = "keymaps/";
>           break;

Apparently we also need:

-- >8 --
diff --git a/qemu.nsi b/qemu.nsi
index b186f223e14..d419986ca06 100644
--- a/qemu.nsi
+++ b/qemu.nsi
@@ -206,3 +206,2 @@ Section "Uninstall"
      Delete "$INSTDIR\*.dll"
-    Delete "$INSTDIR\*.dtb"
      Delete "$INSTDIR\*.fd"
@@ -217,2 +216,3 @@ Section "Uninstall"
      Delete "$INSTDIR\qemu-system-*.exe"
+    RMDir /r "$INSTDIR\dtb"
      RMDir /r "$INSTDIR\doc"
---

Stefan, WDYT?

