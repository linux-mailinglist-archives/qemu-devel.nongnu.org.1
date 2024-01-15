Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 035C582DB29
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 15:21:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPNoz-0005ZV-M9; Mon, 15 Jan 2024 09:20:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rPNov-0005Z0-3t
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 09:20:09 -0500
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rPNos-0000f6-3x
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 09:20:08 -0500
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2cd1ca52f31so100678091fa.3
 for <qemu-devel@nongnu.org>; Mon, 15 Jan 2024 06:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705328402; x=1705933202; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RocVOM2E5OVyv8T7N6cot2XBmdVPKoRvT9l6F16ZNdY=;
 b=TEKU1ptg+gSjrHqRAvFTUWQcrQ+UxDKgqx/ukEhTTrDDJw7eIfPlI0dK9S2XaMU2PV
 0tBpeIL/cW+S+EVTWDLq1Sl5njQYcACk7/qHyG0rKP2Mkd+MgXpN87qVd71coEQjLkGX
 nRyAziDlqE5xlTRile56sWcKWHd3pkrUufrIdePPsW7ImOsh9RvBJaLe1VRMPscwUZCO
 Xar92srWOiTTXdfUkKv5pWTzKdpA562n9qk44T0nAYZYawPRCpAXuSxksfcszMxaL0JY
 keVOYPN30ovOj4uo3pAycYbb34bMiesHYqIS+yaVkOWqziXm9MQRYIDtu1lLFn5J75+1
 AhlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705328402; x=1705933202;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RocVOM2E5OVyv8T7N6cot2XBmdVPKoRvT9l6F16ZNdY=;
 b=SWP0jUUzpAwvoTlRIBXHbcPG4CkXB1eUSCBY4gEkfg5JSSpDGTkKixO9aEmGSLyLqm
 9RqTxsP5QFP6d09OBqFASJ6nnGHKF+HLV2jGCX2thigzeu3QRC0huJ96F36CvTF20hRx
 8iRL8rvB6c7AIj26ImHmuo7rv5rRXG41EvbSk8kfTpGCLQos8AJ3Jl7GPUFqRx++VrNn
 LKeeXFe42rfniCdMB1FRh2dRqJJGUThGvyKjJoWaH9QuZCiHC71wkgzV0hRh+CujDpOP
 wkUGJi8iheVT6B/XhDbj9tPGpFaoSSwXomwNAUZnWfigu1RedlgKOnDkhW1gpDAJnZ1l
 GsTQ==
X-Gm-Message-State: AOJu0YyWKT3nLMC54yL0hHjZC9ZqolUzuBhogtYo5z9paSwZ5N1n9V52
 dA5gyocQpT8l4Iie1/86ZnnYx9VgVI3gSGQAMolr5t20L/6iQw==
X-Google-Smtp-Source: AGHT+IFQQ0cQH/pjGhsvcpCb6FYzUVet9GYHzpG3zdwPt9nunB1NCx4MeHJvaQbdEXhP401aUtwy9eMMndlFxnnEUsM=
X-Received: by 2002:a2e:5c44:0:b0:2cd:1d6e:74c9 with SMTP id
 q65-20020a2e5c44000000b002cd1d6e74c9mr2274120ljb.48.1705328402214; Mon, 15
 Jan 2024 06:20:02 -0800 (PST)
MIME-Version: 1.0
References: <20231208023145.1385775-1-sergey.kambalin@auriga.com>
 <20231208023145.1385775-18-sergey.kambalin@auriga.com>
In-Reply-To: <20231208023145.1385775-18-sergey.kambalin@auriga.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Jan 2024 14:19:50 +0000
Message-ID: <CAFEAcA95Ou+8RNyTQ5X_Lmibq2TcyhU+pO-fA9w0u+1NH1B6EA@mail.gmail.com>
Subject: Re: [PATCH v4 17/45] Add RNG200 skeleton
To: Sergey Kambalin <serg.oker@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Sergey Kambalin <sergey.kambalin@auriga.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22f.google.com
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
>  hw/misc/bcm2838_rng200.c         | 152 +++++++++++++++++++++++++++++++
>  hw/misc/meson.build              |   1 +
>  hw/misc/trace-events             |   9 ++
>  include/hw/misc/bcm2838_rng200.h |  51 +++++++++++
>  4 files changed, 213 insertions(+)
>  create mode 100644 hw/misc/bcm2838_rng200.c
>  create mode 100644 include/hw/misc/bcm2838_rng200.h
>
> diff --git a/hw/misc/bcm2838_rng200.c b/hw/misc/bcm2838_rng200.c
> new file mode 100644
> index 0000000000..8f64e6a20f
> --- /dev/null
> +++ b/hw/misc/bcm2838_rng200.c
> @@ -0,0 +1,152 @@
> +/*
> + * BCM2838 Random Number Generator emulation
> + *
> + * Copyright (C) 2022 Sergey Pushkarev <sergey.pushkarev@auriga.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "hw/qdev-properties.h"
> +#include "hw/misc/bcm2838_rng200.h"
> +#include "migration/vmstate.h"
> +#include "trace.h"
> +
> +static const VMStateDescription vmstate_bcm2838_rng200_regs = {
> +    .name = "bcm2838_rng200_regs",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINT32(ctrl, BCM2838_rng_regs_t),
> +        VMSTATE_UINT32(int_status, BCM2838_rng_regs_t),
> +        VMSTATE_UINT32(fifo_count, BCM2838_rng_regs_t),
> +        VMSTATE_UINT32(fifo_count_threshold, BCM2838_rng_regs_t),
> +        VMSTATE_UINT32(total_bit_count_threshold, BCM2838_rng_regs_t),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};

We add this vmstate struct in this patch, but then the
following patch deletes it again and opts to instead
define the registers with a simple uint32_t array.

The trace events are also added in this patch but not
used until the next patch.

Since this device isn't a very large one, I'm OK with
you squashing together this patch and the next patch
if you want, so that there's a single patch that implements
the whole device. That makes the patch more than our usual
preference for patch size, but it's probably less effort on
your end than moving code between the two patches so the
second patch isn't deleting parts the first one added.
(You can do that if you prefer, though.)

> +
> +static const VMStateDescription vmstate_bcm2838_rng200 = {
> +    .name = "bcm2838_rng200",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (VMStateField[]) {
> +        VMSTATE_UINT32(rbg_period, BCM2838Rng200State),
> +        VMSTATE_UINT32(rng_fifo_cap, BCM2838Rng200State),
> +        VMSTATE_BOOL(use_timer, BCM2838Rng200State),
> +
> +        VMSTATE_STRUCT(regs, BCM2838Rng200State, 0, vmstate_bcm2838_rng200_regs,
> +                       BCM2838_rng_regs_t),
> +
> +        VMSTATE_END_OF_LIST()
> +    }
> +};

thanks
-- PMM

