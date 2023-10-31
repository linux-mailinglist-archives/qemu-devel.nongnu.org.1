Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E9F97DD0A3
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 16:37:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxqnB-0000BR-Q3; Tue, 31 Oct 2023 11:36:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qxqn3-0000B8-DD
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 11:36:26 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qxqn0-00036a-Dc
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 11:36:24 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-507adc3381cso8265295e87.3
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 08:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698766580; x=1699371380; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YmrrJA1BZAz2aGPPP5nJA8yvWyr4iedIcm49J1nM+gw=;
 b=zQbq7Fz14tBz2Aj3PhmInAkVMJF49Bj2St0YCbkP3Ak0afq+D3/gruuyo10XmMhIH+
 IlQyS2V2a8pLApsHDqb8K/pXZqmn7/8cgeaTlKMiX81MFDPJhFngVKEtH/QzS2t4ttDJ
 kg8St4XrGoR50VHhgZSkV5eLyA/esn268nBOzDuC9URZt3CdpuC/sTJCRHO/WnvtuXQN
 69GP0X91cggGGJ8/Is1DGYLzyigH85d8cZAIGTNCD3SMw4n83vtfiHLFtqJdVjnFGNvX
 TVnFuLS1qWVilB4zv3D1P5ugCkYU0EnAhEmDakQF+MGWbbSX/PTIeSmaGzK7a4JByLY0
 Ku8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698766580; x=1699371380;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YmrrJA1BZAz2aGPPP5nJA8yvWyr4iedIcm49J1nM+gw=;
 b=qVvNKOHZykN66qFjO8bWMUjUeWB1ZrAt6Vdh24sCeLyV8G+Qah/hR2QRfOCJrt01hN
 VLnkrdCZ+m5V78U5Lzm7ooeGBT368bF0WmYmbnrtb204wjcnDq1fL9Npxi6YxPkxidMX
 bKRZD4YPl8pY2KN5JCqWz5rFsXGOeTvqFQZZaE0ESCpkwdmw0teNTCQdL+rruMKDTVd1
 /r7nSq5RSJwKjogCOn4BDD4/Sbe/W/Yf7PbqnnoKfmhUGr+oH7pODLKvGoFw1nj5/OYQ
 qwH6I/5pYkO89b8uTQ0EiPFfRdlYnPA2y8lQwPl8eUSScjqCP9zMbj4YvMeZU4FqNyOn
 fIzw==
X-Gm-Message-State: AOJu0YyPnIPPpf6cNQ2sY65jUrVlv8dIjixA1mFyS4UNUUA2rEovVC/r
 7v3XsJmoeao9vkiqMPP3ObhGXJvnS4W+g4fn4EM=
X-Google-Smtp-Source: AGHT+IHBV6XckB9OBujz+S5PTQswPntKQyqci5ySVbDigCAqbF0zqkT6slCxvGB6RY2EqWbFSvpseQ==
X-Received: by 2002:a19:f80e:0:b0:500:7f71:e46b with SMTP id
 a14-20020a19f80e000000b005007f71e46bmr10073371lff.1.1698766579873; 
 Tue, 31 Oct 2023 08:36:19 -0700 (PDT)
Received: from [192.168.69.115] (gjh33-h01-176-171-208-14.dsl.sta.abo.bbox.fr.
 [176.171.208.14]) by smtp.gmail.com with ESMTPSA id
 v14-20020adfe4ce000000b0031980783d78sm1767814wrm.54.2023.10.31.08.36.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Oct 2023 08:36:19 -0700 (PDT)
Message-ID: <36d154ea-026f-6a3a-efae-89ae0439c980@linaro.org>
Date: Tue, 31 Oct 2023 16:36:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 5/8] docs/specs/standard-vga: Convert to rST
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20230927151205.70930-1-peter.maydell@linaro.org>
 <20230927151205.70930-6-peter.maydell@linaro.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230927151205.70930-6-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12f.google.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.053,
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

On 27/9/23 17:12, Peter Maydell wrote:
> Convert docs/specs/standard-vga.txt to rST format.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   docs/specs/index.rst        |  1 +
>   docs/specs/standard-vga.rst | 94 +++++++++++++++++++++++++++++++++++++
>   docs/specs/standard-vga.txt | 81 --------------------------------
>   hw/display/vga-isa.c        |  2 +-
>   hw/display/vga-pci.c        |  2 +-
>   5 files changed, 97 insertions(+), 83 deletions(-)
>   create mode 100644 docs/specs/standard-vga.rst
>   delete mode 100644 docs/specs/standard-vga.txt

$ ./scripts/get_maintainer.pl -f docs/specs/standard-vga.txt
get_maintainer.pl: No maintainers found, printing recent contributors.
get_maintainer.pl: Do not blindly cc: them on patches!  Use common sense.

./scripts/get_maintainer.pl -f hw/display/vga-isa.c
Gerd Hoffmann <kraxel@redhat.com> (maintainer:Standard VGA)
qemu-devel@nongnu.org (open list:All patches CC here)

Cc'ing Gerd.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Maybe worth squashing:

-- >8 --
diff --git a/MAINTAINERS b/MAINTAINERS
index cd8d6b140f..1fdaaad072 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2466,6 +2466,7 @@ F: hw/display/vga*
  F: hw/display/bochs-display.c
  F: include/hw/display/vga.h
  F: include/hw/display/bochs-vbe.h
+F: docs/specs/standard-vga.rst

---

> diff --git a/docs/specs/index.rst b/docs/specs/index.rst
> index 52bfab2f68b..ee84b8109d6 100644
> --- a/docs/specs/index.rst
> +++ b/docs/specs/index.rst
> @@ -28,3 +28,4 @@ guest hardware that is specific to QEMU.
>      edu
>      ivshmem-spec
>      pvpanic
> +   standard-vga
> diff --git a/docs/specs/standard-vga.rst b/docs/specs/standard-vga.rst
> new file mode 100644
> index 00000000000..992f429ced1
> --- /dev/null
> +++ b/docs/specs/standard-vga.rst
> @@ -0,0 +1,94 @@
> +
> +QEMU Standard VGA
> +=================
> +
> +Exists in two variants, for isa and pci.
> +
> +command line switches:
> +
> +``-vga std``
> +   picks isa for -M isapc, otherwise pci
> +``-device VGA``
> +   pci variant
> +``-device isa-vga``
> +   isa variant
> +``-device secondary-vga``
> +   legacy-free pci variant
> +
> +
> +PCI spec
> +--------
> +
> +Applies to the pci variant only for obvious reasons.
> +
> +PCI ID
> +   ``1234:1111``
> +
> +PCI Region 0
> +   Framebuffer memory, 16 MB in size (by default).
> +   Size is tunable via vga_mem_mb property.
> +
> +PCI Region 1
> +   Reserved (so we have the option to make the framebuffer bar 64bit).
> +
> +PCI Region 2
> +   MMIO bar, 4096 bytes in size (QEMU 1.3+)
> +
> +PCI ROM Region
> +   Holds the vgabios (QEMU 0.14+).
> +
> +
> +The legacy-free variant has no ROM and has ``PCI_CLASS_DISPLAY_OTHER``
> +instead of ``PCI_CLASS_DISPLAY_VGA``.
> +
> +
> +IO ports used
> +-------------
> +
> +Doesn't apply to the legacy-free pci variant, use the MMIO bar instead.
> +
> +``03c0 - 03df``
> +   standard vga ports
> +``01ce``
> +   bochs vbe interface index port
> +``01cf``
> +   bochs vbe interface data port (x86 only)
> +``01d0``
> +   bochs vbe interface data port
> +
> +
> +Memory regions used
> +-------------------
> +
> +``0xe0000000``
> +  Framebuffer memory, isa variant only.
> +
> +The pci variant used to mirror the framebuffer bar here, QEMU 0.14+
> +stops doing that (except when in ``-M pc-$old`` compat mode).
> +
> +
> +MMIO area spec
> +--------------
> +
> +Likewise applies to the pci variant only for obvious reasons.
> +
> +``0000 - 03ff``
> +  edid data blob.
> +``0400 - 041f``
> +  vga ioports (``0x3c0`` to ``0x3df``), remapped 1:1. Word access
> +  is supported, bytes are written in little endian order (aka index
> +  port first),  so indexed registers can be updated with a single
> +  mmio write (and thus only one vmexit).
> +``0500 - 0515``
> +  bochs dispi interface registers, mapped flat without index/data ports.
> +  Use ``(index << 1)`` as offset for (16bit) register access.
> +``0600 - 0607``
> +  QEMU extended registers.  QEMU 2.2+ only.
> +  The pci revision is 2 (or greater) when these registers are present.
> +  The registers are 32bit.
> +``0600``
> +  QEMU extended register region size, in bytes.
> +``0604``
> +  framebuffer endianness register.
> +  - ``0xbebebebe`` indicates big endian.
> +  - ``0x1e1e1e1e`` indicates little endian.
> diff --git a/docs/specs/standard-vga.txt b/docs/specs/standard-vga.txt
> deleted file mode 100644
> index 18f75f1b302..00000000000
> --- a/docs/specs/standard-vga.txt
> +++ /dev/null
> @@ -1,81 +0,0 @@
> -
> -QEMU Standard VGA
> -=================
> -
> -Exists in two variants, for isa and pci.
> -
> -command line switches:
> -    -vga std               [ picks isa for -M isapc, otherwise pci ]
> -    -device VGA            [ pci variant ]
> -    -device isa-vga        [ isa variant ]
> -    -device secondary-vga  [ legacy-free pci variant ]
> -
> -
> -PCI spec
> ---------
> -
> -Applies to the pci variant only for obvious reasons.
> -
> -PCI ID: 1234:1111
> -
> -PCI Region 0:
> -   Framebuffer memory, 16 MB in size (by default).
> -   Size is tunable via vga_mem_mb property.
> -
> -PCI Region 1:
> -   Reserved (so we have the option to make the framebuffer bar 64bit).
> -
> -PCI Region 2:
> -   MMIO bar, 4096 bytes in size (qemu 1.3+)
> -
> -PCI ROM Region:
> -   Holds the vgabios (qemu 0.14+).
> -
> -
> -The legacy-free variant has no ROM and has PCI_CLASS_DISPLAY_OTHER
> -instead of PCI_CLASS_DISPLAY_VGA.
> -
> -
> -IO ports used
> --------------
> -
> -Doesn't apply to the legacy-free pci variant, use the MMIO bar instead.
> -
> -03c0 - 03df : standard vga ports
> -01ce        : bochs vbe interface index port
> -01cf        : bochs vbe interface data port (x86 only)
> -01d0        : bochs vbe interface data port
> -
> -
> -Memory regions used
> --------------------
> -
> -0xe0000000 : Framebuffer memory, isa variant only.
> -
> -The pci variant used to mirror the framebuffer bar here, qemu 0.14+
> -stops doing that (except when in -M pc-$old compat mode).
> -
> -
> -MMIO area spec
> ---------------
> -
> -Likewise applies to the pci variant only for obvious reasons.
> -
> -0000 - 03ff : edid data blob.
> -0400 - 041f : vga ioports (0x3c0 -> 0x3df), remapped 1:1.
> -              word access is supported, bytes are written
> -              in little endia order (aka index port first),
> -              so indexed registers can be updated with a
> -              single mmio write (and thus only one vmexit).
> -0500 - 0515 : bochs dispi interface registers, mapped flat
> -              without index/data ports.  Use (index << 1)
> -              as offset for (16bit) register access.
> -
> -0600 - 0607 : qemu extended registers.  qemu 2.2+ only.
> -              The pci revision is 2 (or greater) when
> -              these registers are present.  The registers
> -              are 32bit.
> -  0600      : qemu extended register region size, in bytes.
> -  0604      : framebuffer endianness register.
> -              - 0xbebebebe indicates big endian.
> -              - 0x1e1e1e1e indicates little endian.
> diff --git a/hw/display/vga-isa.c b/hw/display/vga-isa.c
> index 2a5437d8037..c096ec93e52 100644
> --- a/hw/display/vga-isa.c
> +++ b/hw/display/vga-isa.c
> @@ -1,7 +1,7 @@
>   /*
>    * QEMU ISA VGA Emulator.
>    *
> - * see docs/specs/standard-vga.txt for virtual hardware specs.
> + * see docs/specs/standard-vga.rst for virtual hardware specs.
>    *
>    * Copyright (c) 2003 Fabrice Bellard
>    *
> diff --git a/hw/display/vga-pci.c b/hw/display/vga-pci.c
> index b351b8f299d..e4f45b4476d 100644
> --- a/hw/display/vga-pci.c
> +++ b/hw/display/vga-pci.c
> @@ -1,7 +1,7 @@
>   /*
>    * QEMU PCI VGA Emulator.
>    *
> - * see docs/specs/standard-vga.txt for virtual hardware specs.
> + * see docs/specs/standard-vga.rst for virtual hardware specs.
>    *
>    * Copyright (c) 2003 Fabrice Bellard
>    *


