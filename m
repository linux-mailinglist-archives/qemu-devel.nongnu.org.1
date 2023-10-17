Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B4C7CC445
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 15:16:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsjux-0004kk-LD; Tue, 17 Oct 2023 09:15:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qsjuv-0004kR-J9
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 09:15:25 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qsjut-00077D-66
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 09:15:25 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5230a22cfd1so9908591a12.1
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 06:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697548521; x=1698153321; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3PIWlHOQf7Ft7I/UGJCbQJoTYFAbgm10uV10vlFL3rE=;
 b=ppLcLrlA7oiIYMmLIIjY9fafUuBSGrHZswZZVL0Tw9CLhXansnErghLy0z0ljOvIvn
 RP1aehRRnmCNRZyYPxdpJ/pImVeCfA4ra0O74WIWSXUSXorUd8GCdtRTdHguBbhSg1XD
 c/J3VHpf+kFOlhAQcWatFabg1C+8S+75SfQ7XhfLSdDacu7H+NHGnjzGPycWuyZKlmTb
 sMBipWXl8dsFeIA9sxb6ruKgjyBtvY8cjQb4wQ252XOVxtYa1cIqYMHerwrAve8/rAli
 XYOdHA5TbvQDb/EF8M2t18d8FZ19MqFCiDhaWMUUUyKL84GkDAkBjXe0EZnk68CB5MK5
 DsjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697548521; x=1698153321;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3PIWlHOQf7Ft7I/UGJCbQJoTYFAbgm10uV10vlFL3rE=;
 b=fPCp2yjPHUZUGZQsUmBhT3GVSuHMDIHwsLCkYBVhIuF6t6FBKy6nDDjve7fxlfs89l
 speXo/jKqd+Yl1broLWGFKXESjegSHr7OB3whO+tl/fNECRFwL/8PtdNsA6f+vL/oH3T
 IoHs+AveWsqhRihAKRoQVbSOaFjFyYpBYlaKdDzaZcfvKjDwCI1cutI52MXroatKZRq0
 inaijmDCSKodXCLbaUHxl7UE0dYZrNybjjl7EC//6WbAFZ3A8Krm/RCKL9EFZj2w9p0o
 nKcArMBu8YFLJ9Dq9F0wK1wCVwqWrt/HAcI9laCVkilqP2Jd/4NuLcQGnhgy8uNY5mvg
 GGLw==
X-Gm-Message-State: AOJu0YwRlsm4qdJaf98ithHSALpN2liQiExAzVmRAIwjajRvy7jkRdRd
 +hq14ee5Bjw9ow6q3LhH8fmNQkl7oEYNPqmJrSqRpA==
X-Google-Smtp-Source: AGHT+IEmSM3IGHq67WOE0iUOvJFyOSu/ketZvIuYgKJ70TFQyVirbIMNkUnxCPdWP1mJurzHVUH3fsZrL8R0Gok/Fuo=
X-Received: by 2002:a50:ab16:0:b0:53d:9f84:3882 with SMTP id
 s22-20020a50ab16000000b0053d9f843882mr1582919edc.1.1697548521278; Tue, 17 Oct
 2023 06:15:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230920221819.1106029-1-nabihestefan@google.com>
In-Reply-To: <20230920221819.1106029-1-nabihestefan@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Oct 2023 14:15:09 +0100
Message-ID: <CAFEAcA8wcEr0+7VUZA6FRCvvGBmhQ=BtGQ43Cu+r7vd9DSqpJA@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] Implementation of NPI Mailbox and GMAC
 Networking Module
To: Nabih Estefan <nabihestefan@google.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 wuhaotsh@google.com, jasonwang@redhat.com, avi.fishman@nuvoton.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi; just a note that I am assuming that some of the other
Google or Nuvoton folks on cc will be reviewing this patchset.

thanks
-- PMM

On Wed, 20 Sept 2023 at 23:18, Nabih Estefan <nabihestefan@google.com> wrote:
>
> From: Nabih Estefan Diaz <nabihestefan@google.com>
>
> [Changes since v1]
> Fixed some errors in formatting.
> Fixed a merge error that I didn't see in v1.
> Removed Nuvoton 8xx references since that is a separate patch set.
>
> [Original Cover]
> Creates NPI Mailbox Module with data verification for read and write (internal and external),
> wiring to the Nuvoton SoC, and QTests.
>
> Also creates the GMAC Networking Module. Implements read and write functionalities with cooresponding descriptors
> and registers. Also includes QTests for the different functionalities.
>
> Hao Wu (5):
>   hw/misc: Add Nuvoton's PCI Mailbox Module
>   hw/arm: Add PCI mailbox module to Nuvoton SoC
>   hw/misc: Add qtest for NPCM7xx PCI Mailbox
>   hw/net: Add NPCMXXX GMAC device
>   hw/arm: Add GMAC devices to NPCM7XX SoC
>
> Nabih Estefan Diaz (6):
>   \tests/qtest: Creating qtest for GMAC Module
>   include/hw/net: Implemented Classes and Masks for GMAC Descriptors
>   hw/net: General GMAC Implementation
>   hw/net: GMAC Rx Implementation
>   hw/net: GMAC Tx Implementation
>   tests/qtest: Adding PCS Module test to GMAC Qtest
>
>  docs/system/arm/nuvoton.rst         |   2 +
>  hw/arm/npcm7xx.c                    |  53 +-
>  hw/misc/meson.build                 |   1 +
>  hw/misc/npcm7xx_pci_mbox.c          | 324 ++++++++++
>  hw/misc/trace-events                |   5 +
>  hw/net/meson.build                  |   2 +-
>  hw/net/npcm_gmac.c                  | 939 ++++++++++++++++++++++++++++
>  hw/net/trace-events                 |  20 +
>  include/hw/arm/npcm7xx.h            |   4 +
>  include/hw/misc/npcm7xx_pci_mbox.h  |  81 +++
>  include/hw/net/npcm_gmac.h          | 340 ++++++++++
>  tests/qtest/meson.build             |  12 +-
>  tests/qtest/npcm7xx_pci_mbox-test.c | 238 +++++++
>  tests/qtest/npcm_gmac-test.c        | 341 ++++++++++
>  14 files changed, 2353 insertions(+), 9 deletions(-)
>  create mode 100644 hw/misc/npcm7xx_pci_mbox.c
>  create mode 100644 hw/net/npcm_gmac.c
>  create mode 100644 include/hw/misc/npcm7xx_pci_mbox.h
>  create mode 100644 include/hw/net/npcm_gmac.h
>  create mode 100644 tests/qtest/npcm7xx_pci_mbox-test.c
>  create mode 100644 tests/qtest/npcm_gmac-test.c
>
> --
> 2.42.0.459.ge4e396fd5e-goog

