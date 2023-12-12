Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B92980EE89
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 15:20:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD3ad-0005fb-Ux; Tue, 12 Dec 2023 09:18:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rD3ab-0005fI-QK
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 09:18:25 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rD3aZ-0000x1-Tm
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 09:18:25 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-551d5cd1c5fso332908a12.0
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 06:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702390701; x=1702995501; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HuqolziES5/eEvHD2lL+PelglCHWSOQ0N5TngbPuMs8=;
 b=nfjNFtNaTDse9rJImF2E4ikInyf6MnLB9teSomHEGimX3dh0CCOB5D9SU4UHqcEyvc
 PXx/vsWw+idjHExdgt3Lxzcr0Px7xRAgEn+iLQmeASZ0C2JNw2MU/9PgvtzomqAVwxpO
 1ubg6bHwaxRYsQejXCQB0KjEJIMAbaxZByBFYD7C+oAwA7PqQtizWlq4h7SibvubugCf
 MvmEfoWqMO9FFcvFyjtU/GgMQ0f7bbiUnT8OR6NedmTLZWaznLgCB3hTB42J5oOntrNc
 +/pol090ZTWbGAb9AcwS1r2uT4ehWIiCM5RJ5nvkXDqRly8ZMMGtLBGm8ljbtCz078PZ
 s33A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702390701; x=1702995501;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HuqolziES5/eEvHD2lL+PelglCHWSOQ0N5TngbPuMs8=;
 b=CFjuyBNA6NY8hSSnRw9bUpo6zO8lDslQx4x4IkL2N6/VSQsrQOxk47jU42oC3uD3js
 ziSSeK0t/2v+lromYYawdRKbXnccvIH9drzlYrmQUFBCe4rP1FDqY0LxuK79L57Jp1DK
 /aVybQ/LQ7A6mA8L7U6fka2Ay9YMQNj/x+gRgASw2I2evHNKkWJuhC+4SSHlzLGIGQ3Q
 TaDhkLD2WcC1dXFn4m7gof+47XnkDQvsNpv9syo3gOGabPJf4tueq0dC3k5TOkG0wz8F
 fyAWFAbuO3Cw+UaJD6XcvoCP+VgEaOo33sOvT9xTN4iq2NGc6o0km/jAK/97D5JM0C9h
 mbHQ==
X-Gm-Message-State: AOJu0YyMhESBaHZGuP8z9AmpnBkA2bNmSqvfMHsh8D/Jykt4nqhzQQmB
 XLvGVFzyUVrRGcU9xlyKM6Fsf6EQ8QKvK/Mg/v6lZA==
X-Google-Smtp-Source: AGHT+IExUetmAp3a3Hj00pqdLXF5snBe2labP215ZcsIQE/y8+uVKjFP9ooFiyokIr1ds/GEJX6229CvkPB2eixpSok=
X-Received: by 2002:a05:6402:2286:b0:54f:8019:fc8a with SMTP id
 cw6-20020a056402228600b0054f8019fc8amr5846387edb.7.1702390701483; Tue, 12 Dec
 2023 06:18:21 -0800 (PST)
MIME-Version: 1.0
References: <20231112092232.131-1-n.ostrenkov@gmail.com>
In-Reply-To: <20231112092232.131-1-n.ostrenkov@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 Dec 2023 14:18:09 +0000
Message-ID: <CAFEAcA8A8sGjknad1QpeJ8qank-mWWw+gRvR4PVBHk2zAHrEnQ@mail.gmail.com>
Subject: Re: [PATCH] fsl-imx: Add simple RTC emulation for i.MX6 and i.MX7
 boards
To: Nikita Ostrenkov <n.ostrenkov@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Andrey Smirnov <andrew.smirnov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Sun, 12 Nov 2023 at 09:22, Nikita Ostrenkov <n.ostrenkov@gmail.com> wrote:

Hi; thanks for this patch, and sorry I haven't got round
to reviewing it earlier.

> Signed-off-by: Nikita Ostrenkov <n.ostrenkov@gmail.com>
> ---
>  hw/misc/imx7_snvs.c         | 59 ++++++++++++++++++++++++++++++++-----
>  hw/misc/trace-events        |  4 +--
>  include/hw/misc/imx7_snvs.h | 14 ++++++++-
>  3 files changed, 67 insertions(+), 10 deletions(-)
>
> diff --git a/hw/misc/imx7_snvs.c b/hw/misc/imx7_snvs.c
> index a245f96cd4..7ef3e4901a 100644
> --- a/hw/misc/imx7_snvs.c
> +++ b/hw/misc/imx7_snvs.c
> @@ -13,29 +13,74 @@
>   */
>
>  #include "qemu/osdep.h"
> +#include "qemu/timer.h"
>  #include "hw/misc/imx7_snvs.h"
>  #include "qemu/module.h"
> +#include "sysemu/sysemu.h"
>  #include "sysemu/runstate.h"
>  #include "trace.h"
>
> +#define RTC_FREQ    32768ULL
> +
> +static uint64_t imx7_snvs_get_count(IMX7SNVSState *s)
> +{
> +    int64_t now_ms = qemu_clock_get_ns(rtc_clock) / 1000000;
> +    return s->tick_offset + now_ms * RTC_FREQ / 1000;

This kind of clock-to-ticks calculation should generally
be done with muldiv64() to avoid possible overflows:

    int64_t ticks = muldiv64(qemu_clock_get_ns(rtc_clock), RTC_FREQ,
NANOSECONDS_PER_SECOND);
    return s->tick_offset + ticks;

> +}
> +
>  static uint64_t imx7_snvs_read(void *opaque, hwaddr offset, unsigned size)
>  {
> -    trace_imx7_snvs_read(offset, 0);
> +    IMX7SNVSState *s = opaque;
> +    uint64_t ret = 0;
> +
> +    switch (offset) {
> +    case SNVS_LPSRTCMR:
> +        ret = (imx7_snvs_get_count(s) >> 32) & 0x7fffU;
> +        break;
> +    case SNVS_LPSRTCLR:
> +        ret = imx7_snvs_get_count(s) & 0xffffffffU;
> +        break;
> +    case SNVS_LPCR:
> +        ret = s->lpcr;
> +        break;
> +    }
> +
> +    trace_imx7_snvs_read(offset, ret, size);
>
> -    return 0;
> +    return ret;
>  }
>
>  static void imx7_snvs_write(void *opaque, hwaddr offset,
>                              uint64_t v, unsigned size)
>  {
> -    const uint32_t value = v;
> -    const uint32_t mask  = SNVS_LPCR_TOP | SNVS_LPCR_DP_EN;
> +    trace_imx7_snvs_write(offset, v, size);
>
> -    trace_imx7_snvs_write(offset, value);
> +    IMX7SNVSState *s = opaque;
>
> -    if (offset == SNVS_LPCR && ((value & mask) == mask)) {
> -        qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
> +    uint64_t new_value = 0;
> +
> +    switch (offset) {
> +    case SNVS_LPSRTCMR:
> +        new_value = (imx7_snvs_get_count(s) & 0xffffffffU) | (v << 32);
> +        break;
> +    case SNVS_LPSRTCLR:
> +        new_value = (imx7_snvs_get_count(s) & 0x7fff00000000ULL) | v;
> +        break;
> +    case SNVS_LPCR: {
> +        s->lpcr = v;
> +
> +        const uint32_t value = v;
> +        const uint32_t mask  = SNVS_LPCR_TOP | SNVS_LPCR_DP_EN;
> +
> +        if ((value & mask) == mask)
> +            qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
> +
> +        break;
> +    }
>      }
> +
> +    if (offset == SNVS_LPSRTCMR || offset == SNVS_LPSRTCLR)
> +        s->tick_offset += new_value - imx7_snvs_get_count(s);

Our coding standard requires braces on all if() statements,
even single line ones.

I think for this update-the-count handling we should call
imx7_snvs_get_count() only once, and then use that value
both in constructing new_value and also here where we
calculate the tick_offset.

>  }

I think you need to initialise s->tick_offset in the
device init routine, similar to what the pl031 device does.

>  static const struct MemoryRegionOps imx7_snvs_ops = {
> diff --git a/hw/misc/trace-events b/hw/misc/trace-events
> index 05ff692441..85725506bf 100644
> --- a/hw/misc/trace-events
> +++ b/hw/misc/trace-events
> @@ -116,8 +116,8 @@ imx7_gpr_read(uint64_t offset) "addr 0x%08" PRIx64
>  imx7_gpr_write(uint64_t offset, uint64_t value) "addr 0x%08" PRIx64 "value 0x%08" PRIx64
>
>  # imx7_snvs.c
> -imx7_snvs_read(uint64_t offset, uint32_t value) "addr 0x%08" PRIx64 "value 0x%08" PRIx32
> -imx7_snvs_write(uint64_t offset, uint32_t value) "addr 0x%08" PRIx64 "value 0x%08" PRIx32
> +imx7_snvs_read(uint64_t offset, uint64_t value, unsigned size) "i.MX SNVS read: offset 0x%08" PRIx64 " value 0x%08" PRIx64 " size %u"
> +imx7_snvs_write(uint64_t offset, uint64_t value, unsigned size) "i.MX SNVS write: offset 0x%08" PRIx64 " value 0x%08" PRIx64 " size %u"
>
>  # mos6522.c
>  mos6522_set_counter(int index, unsigned int val) "T%d.counter=%d"
> diff --git a/include/hw/misc/imx7_snvs.h b/include/hw/misc/imx7_snvs.h
> index 14a1d6fe6b..406c1fe97f 100644
> --- a/include/hw/misc/imx7_snvs.h
> +++ b/include/hw/misc/imx7_snvs.h
> @@ -20,7 +20,9 @@
>  enum IMX7SNVSRegisters {
>      SNVS_LPCR = 0x38,
>      SNVS_LPCR_TOP   = BIT(6),
> -    SNVS_LPCR_DP_EN = BIT(5)
> +    SNVS_LPCR_DP_EN = BIT(5),
> +    SNVS_LPSRTCMR = 0x050, /* Secure Real Time Counter MSB Register */
> +    SNVS_LPSRTCLR = 0x054, /* Secure Real Time Counter LSB Register */
>  };
>
>  #define TYPE_IMX7_SNVS "imx7.snvs"
> @@ -31,6 +33,16 @@ struct IMX7SNVSState {
>      SysBusDevice parent_obj;
>
>      MemoryRegion mmio;
> +
> +    /*
> +     * Needed to preserve the tick_count across migration, even if the
> +     * absolute value of the rtc_clock is different on the source and
> +     * destination.
> +     */
> +    int64_t tick_offset_vmstate;

You don't need tick_offset_vmstate -- it is only in the p031
RTC device as a backwards-compatibility thing for older versions
of QEMU. Migrating tick_offset alone is sufficient in a new
device. (It seems to have been unfortunately copied-and-pasted
into the goldfish RTC device; we should probably fix that bug.)

> +    int64_t tick_offset;
> +
> +    uint64_t lpcr;

We've now added state to this device, which means that it needs
a VMState structure to handle migration, and it needs a reset
function.

>  };
>
>  #endif /* IMX7_SNVS_H */
> --

thanks
-- PMM

