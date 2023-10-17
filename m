Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E0D7CC3A0
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 14:47:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsjTb-0001FE-H3; Tue, 17 Oct 2023 08:47:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qsjTY-0001ER-Fn
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 08:47:08 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qsjTW-0000mA-RS
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 08:47:08 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-9adb9fa7200so1170476466b.0
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 05:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697546825; x=1698151625; darn=nongnu.org;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OhWiqKdqc4IWNI0ikX3Da4TpeJOOZbRl2oVG65NdZtc=;
 b=Bv3Idrqhjew5IJYsGYSCbdHLOzAptP6z0VYIlcxk7dhdTp8vxGtKcaBytEzOKvhrNt
 lKiYQvj/7rrIJxRnluTjvGCjzn/zi4bv0zxIPVJbQ9gn9qy29T/ylBsivCbH1HZuKsWr
 Kf7Jd+doeP9u84UpWnIlntO/PaVBCMbNXf/GmZq38KpckagTn6bGGfDcceAWGlv0hNtO
 +dcT7dzKMPxz5QUiFxniHDDnxwqiU6NmaNSN0lM7DaGVLkl/28Cf8xJG1xK2PVfuL1d1
 Ow+sP4KnCZfM2bgJEq5AG31hT8E+HZwHDWHpe2CMEP/uw1AkS037lAOu0TrOVUF3LGqB
 Nmaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697546825; x=1698151625;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OhWiqKdqc4IWNI0ikX3Da4TpeJOOZbRl2oVG65NdZtc=;
 b=Lux9LuCqa1A5LktKw6XZ/T+sHL9WIpGI+z4jXq57zoG2HMU/w3NpwCA1QcJtRmzHhK
 qxd/o9m7S9qzNF/aiPx9lvCM12H8cx0KpvJZBoI4yKIewliJMw3Iwejm+TeR3lkfNA5y
 /om8cmfbTRyvHRPLVeYuqGHm4dctgJCdTkHJPKo8yd0xOCj6t/A6sdgEITM38fxhkuSn
 n/WOptZOnD7CkGrDIsduRCfau7GSmX7z6IdwYhtedx84trgUYXzKTYtmbpvA7Cf59tka
 bRbjodSm0288G1Ey/Z7nRz9/03ztcCGiJ/+wMODf4VT8DXIroZk2LNfHgf3B/jxei62L
 8xyg==
X-Gm-Message-State: AOJu0YzLpixF5jHYHLLSkIq9jYR+VF1KJzM5lpffYmNnCqp1w5tfGu7Z
 sWfvZysbSx55pkxclVxMXelMp4w0ntkF9ZeYg2qDf5zchdcQR+SK
X-Google-Smtp-Source: AGHT+IH8bvsc5a1W6/TwC2manClxwUK7Baako4+g/mX8314z6Ls9m/VpDVAOB05poFMij2Uw53mbxA5AWiaLM6KFyfw=
X-Received: by 2002:a17:906:c149:b0:9a9:405b:26d1 with SMTP id
 dp9-20020a170906c14900b009a9405b26d1mr1656600ejc.5.1697546825157; Tue, 17 Oct
 2023 05:47:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230927151205.70930-1-peter.maydell@linaro.org>
In-Reply-To: <20230927151205.70930-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Oct 2023 13:46:54 +0100
Message-ID: <CAFEAcA_D22BEn6P0O1NKXuXRccfSPpyMY+YyFB1EZXb1bc-udA@mail.gmail.com>
Subject: Re: [PATCH 0/8] docs/specs: Convert txt files to rST
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x635.google.com
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

Ping for code review ?

thanks
-- PMM

On Wed, 27 Sept 2023 at 16:12, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> This patchseries converts most of the remaining .txt files in
> docs/specs to rST format and integrates tem with our documentation.
> (The one remaining .txt file is rocker.txt, which I left to do
> later because at over 1000 lines it is much bigger than these.)
>
> These are mostly simple conversions with not too much effort
> put into the formatting/markup. In a few cases I dropped
> parts of the text already covered elsewhere or made light
> fixes for grammar/spelling; see individual patch commit
> messages for more detail.
>
> thanks
> -- PMM
>
> Peter Maydell (8):
>   docs/specs/vmw_pvscsi-spec: Convert to rST
>   docs/specs/edu: Convert to rST
>   docs/specs/ivshmem-spec: Convert to rST
>   docs/specs/pvpanic: Convert to rST
>   docs/specs/standard-vga: Convert to rST
>   docs/specs/virt-ctlr: Convert to rST
>   docs/specs/vmcoreinfo: Convert to rST
>   docs/specs/vmgenid: Convert to rST
>
>  MAINTAINERS                                   |   5 +-
>  docs/specs/{edu.txt => edu.rst}               |  84 +++---
>  docs/specs/index.rst                          |   8 +
>  .../{ivshmem-spec.txt => ivshmem-spec.rst}    |  63 ++---
>  docs/specs/pci-ids.rst                        |   2 +-
>  docs/specs/{pvpanic.txt => pvpanic.rst}       |  41 ++-
>  docs/specs/standard-vga.rst                   |  94 +++++++
>  docs/specs/standard-vga.txt                   |  81 ------
>  docs/specs/{virt-ctlr.txt => virt-ctlr.rst}   |  12 +-
>  docs/specs/{vmcoreinfo.txt => vmcoreinfo.rst} |  33 +--
>  docs/specs/vmgenid.rst                        | 246 ++++++++++++++++++
>  docs/specs/vmgenid.txt                        | 245 -----------------
>  docs/specs/vmw_pvscsi-spec.rst                | 115 ++++++++
>  docs/specs/vmw_pvscsi-spec.txt                |  92 -------
>  docs/system/devices/ivshmem.rst               |   2 +-
>  hw/display/vga-isa.c                          |   2 +-
>  hw/display/vga-pci.c                          |   2 +-
>  17 files changed, 595 insertions(+), 532 deletions(-)
>  rename docs/specs/{edu.txt => edu.rst} (64%)
>  rename docs/specs/{ivshmem-spec.txt => ivshmem-spec.rst} (88%)
>  rename docs/specs/{pvpanic.txt => pvpanic.rst} (64%)
>  create mode 100644 docs/specs/standard-vga.rst
>  delete mode 100644 docs/specs/standard-vga.txt
>  rename docs/specs/{virt-ctlr.txt => virt-ctlr.rst} (70%)
>  rename docs/specs/{vmcoreinfo.txt => vmcoreinfo.rst} (50%)
>  create mode 100644 docs/specs/vmgenid.rst
>  delete mode 100644 docs/specs/vmgenid.txt
>  create mode 100644 docs/specs/vmw_pvscsi-spec.rst
>  delete mode 100644 docs/specs/vmw_pvscsi-spec.txt
>
> --
> 2.34.1
>

