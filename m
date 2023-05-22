Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E645970BA35
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 12:33:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q12qm-0004Vj-CO; Mon, 22 May 2023 06:33:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q12qj-0004U4-98
 for qemu-devel@nongnu.org; Mon, 22 May 2023 06:33:10 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q12qg-0007a7-Ca
 for qemu-devel@nongnu.org; Mon, 22 May 2023 06:33:08 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-510d8d7f8eeso10517843a12.0
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 03:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684751583; x=1687343583;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OnudcCLiwG9YUI6gaGxh+J6vsLzl8Q360NlX13+JxzQ=;
 b=aKmvWns+HDdkIf3t+M7Gh7+n38udf31K/z+RjV9tlDCbmdr93PhnrSVNlqAZS3EboI
 J7RuLnjE9X481gg8yurHhmGjPNJGnb7brped9VHGxBeaL0JkQjxtzvmgj294cUw7966F
 KiFwDcRS4oftP6d2U2mDEZVm+hvUpYT/4/cJ7GIzZyaXCJgTCtbWiR9154+xYLL3AYiZ
 2qAMNv0eO6lGJ2R8t8TEwwM/of4LG7ilTmDmjM0iC+HSBvw+OZLuJ7WHNqYiA8SQ4+fG
 jA9WGuGnmSNncrBwfGNxRkBS6hRgvx+5uKfO+Qk9Ia+otVGzpMEoQQjB6nH9Rsm6UDaA
 VQ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684751583; x=1687343583;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OnudcCLiwG9YUI6gaGxh+J6vsLzl8Q360NlX13+JxzQ=;
 b=hGsW0sywSTchHvo6pTOlcylET+kCe2cK9FiaE6h2Am8zHw7UkPbw0nIGW6E/Cpc8nx
 +YEG7pwsU8kNfN/uzDvx9QoKNKbR+giwc+U4qgLUfUjz5eoRQ/5rGP/ane6moqEe+mFc
 Dv64YZpHiZGhnT23cTxFi6Qb3gU+GEaIOuDZJkdny/Fibz7kSo/wgfDUkDK2/6KP4IXb
 x7abB5beT0WMcwloDASeP+1DXA7yzXFdPK0HTah+mLczhgQDsqbvBP7hmwHUgh2bFO0G
 YVRNRetARvd/b6tCdqRbir2yPTtUGw5eL4jPoYMEn3ZSq5+HAAJVBGx8VLdcV89qyUTG
 2ilg==
X-Gm-Message-State: AC+VfDxM/I/9YhXzDszoolg3pDod1fikPN9zbKkx5jWD4p5IkC/XXuyk
 kYHF6FXW4m74u1hfNe6iSeS1h/Wb9WHE1VkA/4iIJA==
X-Google-Smtp-Source: ACHHUZ7EPpHH2gUJMQvKSkjomBHXsxhrcgrLyDz6wWkhbFt8WXCNRkwwntv89azyYXgyQdgdX4mxofJst/6n+njneNk=
X-Received: by 2002:a05:6402:31e7:b0:50b:d23c:deb4 with SMTP id
 dy7-20020a05640231e700b0050bd23cdeb4mr8320830edb.42.1684751583644; Mon, 22
 May 2023 03:33:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230522102910.20942-1-sergey.kambalin@auriga.com>
In-Reply-To: <20230522102910.20942-1-sergey.kambalin@auriga.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 22 May 2023 11:32:52 +0100
Message-ID: <CAFEAcA_aV0DvL3DgqU9SKKRsqCoMrvwbPoomx+NA8fkXKkTytA@mail.gmail.com>
Subject: Re: [PATCH] [rpi4b] Make bootable rpi4b model
To: Sergey Kambalin <serg.oker@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Sergey Kambalin <sergey.kambalin@auriga.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Mon, 22 May 2023 at 11:29, Sergey Kambalin <serg.oker@gmail.com> wrote:
>
> Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
> ---
>  configs/devices/aarch64-softmmu/default.mak |   2 +
>  hw/arm/Kconfig                              |   7 +
>  hw/arm/bcm2835_peripherals.c                | 223 ++++++-----
>  hw/arm/bcm2836.c                            | 129 ++++---
>  hw/arm/bcm2838.c                            | 283 ++++++++++++++
>  hw/arm/bcm2838_peripherals.c                | 213 +++++++++++
>  hw/arm/meson.build                          |   5 +
>  hw/arm/raspi.c                              | 129 ++++---
>  hw/arm/raspi4b.c                            | 243 ++++++++++++
>  hw/arm/trace-events                         |   2 +
>  hw/gpio/bcm2838_gpio.c                      | 395 ++++++++++++++++++++
>  hw/gpio/meson.build                         |   1 +
>  hw/misc/bcm2835_powermgt.c                  |  37 ++
>  hw/misc/bcm2835_property.c                  | 318 +++++++++++++---
>  hw/misc/trace-events                        |  10 +
>  include/hw/arm/bcm2835_peripherals.h        |  29 +-
>  include/hw/arm/bcm2836.h                    |  30 +-
>  include/hw/arm/bcm2838.h                    |  26 ++
>  include/hw/arm/bcm2838_peripherals.h        |  50 +++
>  include/hw/arm/raspi4b_platform.h           |  58 +++
>  include/hw/arm/raspi_platform.h             |  34 ++
>  include/hw/display/bcm2835_fb.h             |   2 +
>  include/hw/gpio/bcm2838_gpio.h              |  45 +++
>  include/hw/misc/bcm2835_powermgt.h          |   2 +-
>  include/hw/misc/raspberrypi-fw-defs.h       | 169 +++++++++
>  tests/avocado/boot_linux_console.py         |  37 ++
>  26 files changed, 2210 insertions(+), 269 deletions(-)

Hi; this is far too large to be reviewable as a single patch.
It must be split into more digestible chunks (each of which
does a single reasonably coherent thing) before we can
do anything with it.

thanks
-- PMM

