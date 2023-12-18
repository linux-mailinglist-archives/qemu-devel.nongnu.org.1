Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E4BE38177C2
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 17:43:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFGhY-00074n-3H; Mon, 18 Dec 2023 11:42:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFGhV-0006xO-ER
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 11:42:41 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFGhT-00021s-LD
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 11:42:40 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-54cb4fa667bso4061807a12.3
 for <qemu-devel@nongnu.org>; Mon, 18 Dec 2023 08:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702917758; x=1703522558; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kIpi/SFUK7LkV+dbaKMGjtF8g+sGAwH5XPmGl60jN5U=;
 b=RKXyZgJ15QXfbVx8KJTj7w+UH29lhM5yy5Y0zQweTNGqW6UeWsGvN/x4yeiT78ZFJ+
 IdcnXXbzzjUGeudITKpsbI2mrgLIe92pBcE0V3pnCG9YbT8F2BJc+z//C5JPPYbkC558
 V3j8UgyFR9ulQNiG5s8PKTqe6WTZ96eKH/4bvk9fpGwjYVn0JrVl69QtSd1cXfhvH2b7
 5LgMmUs+Phbe6yqyuAZs/cGgbQ4+/A7Hm7rr09u7gZp70M8txJVrY1PA8BIhhgPGj9V+
 RK80HHJ/1bEr/mU7ju+oetm91PmBd7JSTFsQFhr0oeZicRjS2VIOTNxJz5YagSPcCWIG
 hj+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702917758; x=1703522558;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kIpi/SFUK7LkV+dbaKMGjtF8g+sGAwH5XPmGl60jN5U=;
 b=QNsxnKaxagXekVQgMEjfZ6B0Q6VCGzgQsnFjdnm7M8cB3gVdWcpMUdBb9uesw8l9I1
 3x6ik7uMsIC6bRuA4oBaEte7cFTKxSOq0A8RjPhGHMKMhYeabBf5yeOhn3c4J7niLPgK
 rsJ2dEGZGqZCnHPMEPu42JqfmsVrsmvmLQNt32W9PWkyYyS+Z5Hpnpt331+0TMeIOz/K
 74QKIDfIhcDdeS6NHjNSpV36MLrgiqraPJNAXePjPuDVPyMAkwiur43JIX1K68GXXNxp
 0YB6MWHSc6k+VaBOWSkF3zhfeNDcX8fB8jDc6wwlW0NnsFTD5T9eeHZt1pl/8OMXlU3X
 4ixQ==
X-Gm-Message-State: AOJu0Yzp0rqk85MPTCR8pw0mZ5C+aX02xr9QmMKThOXM0YmKrtoYlggr
 stPN+FuEX0BlVwI9/ZTSoTQFelYnY7KDuED2964f+A==
X-Google-Smtp-Source: AGHT+IEMKQfSfZULiGLs/SrZ3/PAZgydECSTMXztl7v1EYvWXn2b8CBsMmPYZvCwUPuAAggrR/t1UadUEvZkvlfnymQ=
X-Received: by 2002:a50:8d15:0:b0:553:55e8:98eb with SMTP id
 s21-20020a508d15000000b0055355e898ebmr999145eds.34.1702917758080; Mon, 18 Dec
 2023 08:42:38 -0800 (PST)
MIME-Version: 1.0
References: <20231208023145.1385775-1-sergey.kambalin@auriga.com>
 <20231208023145.1385775-11-sergey.kambalin@auriga.com>
In-Reply-To: <20231208023145.1385775-11-sergey.kambalin@auriga.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 Dec 2023 16:42:27 +0000
Message-ID: <CAFEAcA_G-ZFnuZxrXwUEp1pViNHbCN1y8jz9sF12NEsZzYJEmQ@mail.gmail.com>
Subject: Re: [PATCH v4 10/45] Add BCM2838 checkpoint support
To: Sergey Kambalin <serg.oker@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Sergey Kambalin <sergey.kambalin@auriga.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
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

On Fri, 8 Dec 2023 at 02:33, Sergey Kambalin <serg.oker@gmail.com> wrote:
>
> Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
> ---
>  hw/arm/bcm2838_peripherals.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/arm/bcm2838_peripherals.c b/hw/arm/bcm2838_peripherals.c
> index c147b6e453..196fb890a2 100644
> --- a/hw/arm/bcm2838_peripherals.c
> +++ b/hw/arm/bcm2838_peripherals.c
> @@ -22,7 +22,7 @@ static void bcm2838_peripherals_init(Object *obj)
>  {
>      BCM2838PeripheralState *s = BCM2838_PERIPHERALS(obj);
>      BCM2838PeripheralClass *bc = BCM2838_PERIPHERALS_GET_CLASS(obj);
> -    RaspiPeripheralBaseState *s_base = RASPI_PERIPHERALS_BASE(obj);
> +    BCMSocPeripheralBaseState *s_base = BCM_SOC_PERIPHERALS_BASE(obj);
>
>      /* Lower memory region for peripheral devices (exported to the Soc) */
>      memory_region_init(&s->peri_low_mr, obj, "bcm2838-peripherals",
> --

I don't understand the commit message here, and the contents
of the patch look like something that maybe belongs in a
different patch?

thanks
-- PMM

