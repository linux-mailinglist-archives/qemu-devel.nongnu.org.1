Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E78787A4F08
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 18:33:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiHAL-0007f0-Pi; Mon, 18 Sep 2023 12:32:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qiHAJ-0007em-2u
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 12:32:03 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qiHAH-0001lo-F4
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 12:32:02 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-501eec0a373so7642484e87.3
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 09:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695054718; x=1695659518; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P1wGTThrKwaATWDcU7L863kuCrhCtS/X8l/lnh44RJY=;
 b=OVLgXcnIK6dWuEYJwRI9Fy2xUHz+zIIt+ykzCAfu07uqOxQ/2k8G5qr7gd4xr+GWD0
 fVUMQnY/OCfaCPfVmEYW4mmgW63kII58iVg+8fdH4irDk+zfEGChGnSh8mOrnZOuIK7S
 pZ5KIe0YEiXP1ogeg4wuKBodRzY2atpZ5ScHlYe9a4fErUp968VDDtjJjUyjIOaDemrb
 dH5Rtb1qRNyOOme+/0MY82LP/Dk1FfwNRbPVy0t76F8TIeYEeYdQrsd1fcr2SEIJmAyj
 siXlBdz36uvHs53KSN/Xa8e1dIQaxiKGArNb9tRjk010iIPy1xqWhvTEgvdvlcjsgn4C
 baQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695054718; x=1695659518;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P1wGTThrKwaATWDcU7L863kuCrhCtS/X8l/lnh44RJY=;
 b=PPHL1koxr0+CpKMK1dryj1EDfz+9s9IFO/Vn6AcHPa6g/Va2/LvYQr7eEdWiEEUply
 jcUfzby5ppxvw9PLNrDnV+7fh+BbYkRNZgEBPl/Nl/8J9r7vLOtsfng1nz7zKFc/xTIq
 byJ1LOzqRqrUhI3s07fTq5sMMU5chzVAzu04e8PY2AT1Ulnn1NcsUFo7+cdul8NSU6ZF
 nutjcwAPRxO4hAI2zp2U23Do+Z6S4w4mVJVL2lEn/FvYVuoWiUyzIsLFiiLV3Y9wznrX
 QXLyKfnVE9mV5m0qLSq1p5RGm077k0hk54Iba4WMau6oUHY14UC8U89q788NOCxYku/W
 gYsA==
X-Gm-Message-State: AOJu0Yxn8gJPq2ODw75ch8EVt9spqs8Lpn993kU1rxbthdja5ZHrIkXa
 oJdgM2lwIGAM/pr9C/RVzqN2lsk4/kMKpddPo2s5hw==
X-Google-Smtp-Source: AGHT+IEzRPYhgvpI4T59wL12KICLzNrGQXuwPCyPej1RckEtk9+3C/qbqlJB2iF9EQfSPn1R5ohC27gu9uHof292/qg=
X-Received: by 2002:a19:ca03:0:b0:503:28cb:c073 with SMTP id
 a3-20020a19ca03000000b0050328cbc073mr387465lfg.58.1695054718141; Mon, 18 Sep
 2023 09:31:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230918150259.11165-1-Jonathan.Cameron@huawei.com>
 <20230918150259.11165-3-Jonathan.Cameron@huawei.com>
In-Reply-To: <20230918150259.11165-3-Jonathan.Cameron@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 Sep 2023 17:31:38 +0100
Message-ID: <CAFEAcA_7-uq8LJO6-myGU1+qjErxZAWE+CMjqyJBph6Du9K0iA@mail.gmail.com>
Subject: Re: [PATCH 2/3] hw/mem/cxl_type3: Add missing copyright and license
 notice
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 Michael Tsirkin <mst@redhat.com>, Fan Ni <fan.ni@samsung.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 linuxarm@huawei.com, Yuquan Wang <wangyuquan1236@phytium.com.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12e.google.com
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

On Mon, 18 Sept 2023 at 16:04, Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> This has been missing from the start. Assume it should match
> with cxl/cxl-component-utils.c as both were part of early
> postings from Ben.

Sounds plausible -- is there an Intel person who could give us
an acked-by for this?

(Ideally we wouldn't have let more gpl-2-only code into the
codebase without a rationale...)

> Suggested-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  hw/mem/cxl_type3.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index c5855d4e7d..ad3f0f6a9d 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -1,3 +1,12 @@
> +/*
> + * CXL Type 3 (memory expander) device
> + *
> + * Copyright(C) 2020 Intel Corporation.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2. See =
the
> + * COPYING file in the top-level directory.
> + */
> +
>  #include "qemu/osdep.h"
>  #include "qemu/units.h"
>  #include "qemu/error-report.h"

-- PMM

