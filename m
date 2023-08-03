Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB6976EEB4
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 17:53:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRacl-0001Xi-DI; Thu, 03 Aug 2023 11:52:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qRace-0001We-W7
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 11:52:21 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qRacc-0003cD-B1
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 11:52:20 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-4fe48a2801bso2022416e87.1
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 08:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691077936; x=1691682736;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=I6TTnOyTZIXYcRolg2KXuOZGMRy9t0s0uYD8kqaHwBc=;
 b=qQLjUG8Ps6+af2a2HSSSI6kTBfyy6ZyBncPxMLgGFMUvBXQNscgxb8Xp+dML5nKoXy
 qVX5ipOnFsJSqoGyG9qDfvJd/rE1ARFItlx4fLM6MQ21nAZaMP9tPSPG8G7DvbH09q4W
 i2vH6BNOg+XD/8ZXVdLnbtPoxjjCTlwY4PVdOvQ8sGV13V8HAeQWqIcSUgqu7cwCJfHz
 3K0wDD70KsnqaxDowA+BvYNTVxOP3Uj+5zAhyQ1TBNuCeA0nM5BSjulJTpmpqMTGSGOc
 t05VNHIj7HTsm8HC2fNGpbyWeZNl7a/Iq7GFCEq5TwO2F0GsIO7iIet2FOGbiYxKAXgd
 IJJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691077936; x=1691682736;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=I6TTnOyTZIXYcRolg2KXuOZGMRy9t0s0uYD8kqaHwBc=;
 b=jUqyEhEZ/kE7MzcvJp2hfTR45zIAsxm1lHuSD8XA0DUD/Xo42Czfs1Y+uC6NosZPd9
 4IVyKVM0NGN8Iqj9iXNVDwrtxlZB+RFir+DiuQxvQvg+76msvfZE6lzoKLZwIL9M9rJ1
 uFp+iS1NzDuHZX9qEa85sIhEL0j9iwOMs6agsyCGc9M7vD2hfxmu9w4/qJUTrcH4Ags+
 3dNIcnEaMnjQ1jLFEwOiMNslyXM+SGPKNfvX1QoXB1hQDAL4wwTd6Thly1kuGE0vIUH3
 EyTxHdXcaKIJFJwdk1itJsAZKNlNLAmiytOF7LcMIR4O1jZRXr4w4u429QqnjykJH4Bp
 EQ2A==
X-Gm-Message-State: ABy/qLbwOfobZfHf7dwViliURg6EoOC2u65UuF19NXaI4VUUlgbKcVTu
 n8bR+nq810ecpdHEx4l3hmal6i//qtDGfCt/EUM+PA==
X-Google-Smtp-Source: APBJJlEIdSIxyyjlPLfAl9GJIl4K+vYNr26hRHuuhiumxP1Euj96ULh8WRXNiYDk+hFAqPZeVmTUA940HvrGomtkmhE=
X-Received: by 2002:ac2:47ea:0:b0:4fe:3a2f:681 with SMTP id
 b10-20020ac247ea000000b004fe3a2f0681mr6445939lfp.23.1691077936458; Thu, 03
 Aug 2023 08:52:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230726132512.149618-1-sergey.kambalin@auriga.com>
 <20230726132512.149618-3-sergey.kambalin@auriga.com>
In-Reply-To: <20230726132512.149618-3-sergey.kambalin@auriga.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Aug 2023 16:52:05 +0100
Message-ID: <CAFEAcA_Ts7hAtSBy8WVxk6u9doqTX7-0Jb70TvYaVDV1zZjwzg@mail.gmail.com>
Subject: Re: [PATCH 02/44] Split out common part of peripherals
To: Sergey Kambalin <serg.oker@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Sergey Kambalin <sergey.kambalin@auriga.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12d.google.com
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

On Wed, 26 Jul 2023 at 14:44, Sergey Kambalin <serg.oker@gmail.com> wrote:
>
> Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
> ---
>  hw/arm/bcm2835_peripherals.c         | 198 +++++++++++++++------------
>  hw/arm/bcm2836.c                     |  24 ++--
>  include/hw/arm/bcm2835_peripherals.h |  29 +++-
>  include/hw/arm/bcm2836.h             |   3 +-
>  4 files changed, 154 insertions(+), 100 deletions(-)
>
> diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
> index 0233038b95..4c0c0b1e7d 100644
> --- a/hw/arm/bcm2835_peripherals.c
> +++ b/hw/arm/bcm2835_peripherals.c
> @@ -30,9 +30,9 @@
>  #define SEPARATE_DMA_IRQ_MAX 10
>  #define ORGATED_DMA_IRQ_COUNT 4
>
> -static void create_unimp(BCM2835PeripheralState *ps,
> -                         UnimplementedDeviceState *uds,
> -                         const char *name, hwaddr ofs, hwaddr size)
> +void create_unimp(RaspiPeripheralBaseState *ps,

Something has gone wrong with the naming here. This is
the SoC implementation, and its peripherals should be
the same whether the BCM2838 is being used on the raspi,
or on any other board. The type names and so on should
be SoC-specific, not board-specific.

thanks
-- PMM

