Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A98C82DB4B
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 15:31:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPNyy-0008SJ-Pm; Mon, 15 Jan 2024 09:30:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rPNyi-0008S2-MZ
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 09:30:17 -0500
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rPNyg-0002eF-8v
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 09:30:16 -0500
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2cdae52d355so15156961fa.2
 for <qemu-devel@nongnu.org>; Mon, 15 Jan 2024 06:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705329011; x=1705933811; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UOt9otSGzuv24Gpy09WTNsEnlNhZafFEPJoOqEAVPdc=;
 b=yd/rJE1HJI926wJXU7YfvyHogjCaJc0I8JRcXjHdg5q15p1OC4FXmGNZtZ/zkT459t
 uWz5YGIhIupA9OzDZaJzRGNNddW8rwyUPGU+1C6Ma85COmh8VET74XLNxnrQn+OrOvKU
 OR2KD35cbgI+xaTltPjuWQciFsCCw5FGqFnRi3aCxsYmd7h3hvaaG9zeJzq2Qodm2TmV
 kZJG7k9rC4XpwKgpxACXm1b5rp0a2vKkZ627jZmzVuL+Y+CzfgFrRUG8zRXwH8G9GbV2
 s3dKQgM5SukYgOBXuDCL97iMPCtXd/AxPofmZflQH2uk0+dqOypkN/QHQzuVHHllnq6+
 Xoqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705329011; x=1705933811;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UOt9otSGzuv24Gpy09WTNsEnlNhZafFEPJoOqEAVPdc=;
 b=gM1HAM3p9eZn5XjDlr1obgIRO3Yq7RGe8nO5IKorIJRmMLWkWVdqGgMrWjk5/Z7WHf
 V4RWzBOY9IuOl1rCVUck2249UnHAK13InfPSLD/bruYBFj3zPAQFPk/eblQy3c1y7Evk
 5SZ+9seMseiWNN+uU4KJNUONeChE47kLiDAy7imDTNSzVDZNnVehUO3SN8RfLetT0lH1
 VTlLMXEpHKs2N8+/L1QYWAGWR8+isWBTfs9IU0va+mqVhfWeeRfOi49i0/QHvcySwjAe
 +3VYj+wZi8OFlbiwLyf+D8tqCTYnmhGPs3zwdUwYG8Cc1vJGIR2t7qv1qIvVJ9c5P1OK
 7neQ==
X-Gm-Message-State: AOJu0YwY/2ab2kETxH13uBsDHuf1xu2EYPp+CK6tMfCADbFHAEEzwfLg
 CLUbgxiVREyMok2t2hbyANz7FBPdd5/9mzMbknzJotiljRSBvw==
X-Google-Smtp-Source: AGHT+IH92iTYkU/lz+uYCSThcIUA7Egt01kp8P1ehChysXs/js2W84xatqdmvVnE5ifnDsZ47i2VmP9KprRuo9segt4=
X-Received: by 2002:a2e:9853:0:b0:2cd:8175:73d with SMTP id
 e19-20020a2e9853000000b002cd8175073dmr2527895ljj.62.1705329010655; Mon, 15
 Jan 2024 06:30:10 -0800 (PST)
MIME-Version: 1.0
References: <20231208023145.1385775-1-sergey.kambalin@auriga.com>
 <20231208023145.1385775-19-sergey.kambalin@auriga.com>
In-Reply-To: <20231208023145.1385775-19-sergey.kambalin@auriga.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Jan 2024 14:29:59 +0000
Message-ID: <CAFEAcA_byUHzTboAA4bZdq4P2WDF6u8GK-OxXXkoV_AF7saNKQ@mail.gmail.com>
Subject: Re: [PATCH v4 18/45] Add RNG200 RNG and RBG
To: Sergey Kambalin <serg.oker@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Sergey Kambalin <sergey.kambalin@auriga.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x234.google.com
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

On Fri, 8 Dec 2023 at 02:40, Sergey Kambalin <serg.oker@gmail.com> wrote:
>
> Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
> ---
>  hw/misc/bcm2838_rng200.c         | 292 +++++++++++++++++++++++++++++--
>  include/hw/misc/bcm2838_rng200.h |  10 +-
>  2 files changed, 275 insertions(+), 27 deletions(-)
>
> diff --git a/hw/misc/bcm2838_rng200.c b/hw/misc/bcm2838_rng200.c
> index 8f64e6a20f..f91ea0754c 100644
> --- a/hw/misc/bcm2838_rng200.c
> +++ b/hw/misc/bcm2838_rng200.c
> @@ -8,25 +8,56 @@
>   */
>
>  #include "qemu/osdep.h"
> +#include "qemu/log.h"
>  #include "qapi/error.h"
>  #include "hw/qdev-properties.h"
>  #include "hw/misc/bcm2838_rng200.h"
> +#include "hw/registerfields.h"
>  #include "migration/vmstate.h"
>  #include "trace.h"
>
> -static const VMStateDescription vmstate_bcm2838_rng200_regs = {
> -    .name = "bcm2838_rng200_regs",
> -    .version_id = 1,
> -    .minimum_version_id = 1,
> -    .fields = (VMStateField[]) {
> -        VMSTATE_UINT32(ctrl, BCM2838_rng_regs_t),
> -        VMSTATE_UINT32(int_status, BCM2838_rng_regs_t),
> -        VMSTATE_UINT32(fifo_count, BCM2838_rng_regs_t),
> -        VMSTATE_UINT32(fifo_count_threshold, BCM2838_rng_regs_t),
> -        VMSTATE_UINT32(total_bit_count_threshold, BCM2838_rng_regs_t),
> -        VMSTATE_END_OF_LIST()
> -    }
> -};
> +/* RNG200 registers */
> +REG32(RNG_CTRL,               0x00)
> +    FIELD(RNG_CTRL, RBG_ENABLE,   0 , 1)
> +    FIELD(RNG_CTRL, RSVD,         1 , 12)
> +    FIELD(RNG_CTRL, DIV,         13 , 8)
> +
> +REG32(RNG_SOFT_RESET,                0x04)
> +REG32(RBG_SOFT_RESET,                0x08)
> +REG32(RNG_TOTAL_BIT_COUNT,           0x0C)
> +REG32(RNG_TOTAL_BIT_COUNT_THRESHOLD, 0x10)
> +
> +REG32(RNG_INT_STATUS,                               0x18)
> +    FIELD(RNG_INT_STATUS, TOTAL_BITS_COUNT_IRQ,         0, 1)
> +    FIELD(RNG_INT_STATUS, RSVD0,                        1, 4)
> +    FIELD(RNG_INT_STATUS, NIST_FAIL_IRQ,                5, 1)
> +    FIELD(RNG_INT_STATUS, RSVD1,                        6, 11)
> +    FIELD(RNG_INT_STATUS, STARTUP_TRANSITIONS_MET_IRQ,  17, 1)
> +    FIELD(RNG_INT_STATUS, RSVD2,                        18, 13)
> +    FIELD(RNG_INT_STATUS, MASTER_FAIL_LOCKOUT_IRQ,      30, 1)
> +
> +REG32(RNG_INT_ENABLE,                               0x1C)
> +    FIELD(RNG_INT_ENABLE, TOTAL_BITS_COUNT_IRQ,         0, 1)
> +    FIELD(RNG_INT_ENABLE, RSVD0,                        1, 4)
> +    FIELD(RNG_INT_ENABLE, NIST_FAIL_IRQ,                5, 1)
> +    FIELD(RNG_INT_ENABLE, RSVD1,                        6, 11)
> +    FIELD(RNG_INT_ENABLE, STARTUP_TRANSITIONS_MET_IRQ,  17, 1)
> +    FIELD(RNG_INT_ENABLE, RSVD2,                        18, 13)
> +    FIELD(RNG_INT_ENABLE, MASTER_FAIL_LOCKOUT_IRQ,      30, 1)
> +
> +REG32(RNG_FIFO_DATA, 0x20)
> +
> +REG32(RNG_FIFO_COUNT,              0x24)
> +    FIELD(RNG_FIFO_COUNT, COUNT,       0, 8)
> +    FIELD(RNG_FIFO_COUNT, THRESHOLD,   8, 8)
> +
> +
> +#define RNG_WARM_UP_PERIOD_ELAPSED           17
> +
> +#define SOFT_RESET    1
> +#define IRQ_PENDING   1
> +
> +#define BCM2838_RNG200_PTIMER_POLICY         (PTIMER_POLICY_CONTINUOUS_TRIGGER)
>
>  static const VMStateDescription vmstate_bcm2838_rng200 = {
>      .name = "bcm2838_rng200",
> @@ -37,33 +68,253 @@ static const VMStateDescription vmstate_bcm2838_rng200 = {
>          VMSTATE_UINT32(rng_fifo_cap, BCM2838Rng200State),
>          VMSTATE_BOOL(use_timer, BCM2838Rng200State),
>
> -        VMSTATE_STRUCT(regs, BCM2838Rng200State, 0, vmstate_bcm2838_rng200_regs,
> -                       BCM2838_rng_regs_t),
> +        VMSTATE_ARRAY(regs, BCM2838Rng200State, N_BCM2838_RNG200_REGS, 0,
> +                      vmstate_info_uint32, uint32_t),
>
>          VMSTATE_END_OF_LIST()
>      }
>  };
>
> -static void bcm2838_rng200_rng_reset(BCM2838Rng200State *state)
> +static bool is_rbg_enabled(BCM2838Rng200State *s)
> +{
> +    return FIELD_EX32(s->regs[R_RNG_CTRL], RNG_CTRL, RBG_ENABLE);
> +}
> +
> +static void increment_bit_counter_by(BCM2838Rng200State *s, uint32_t inc_val) {
> +    s->regs[R_RNG_TOTAL_BIT_COUNT] += inc_val;
> +}
> +
> +static void bcm2838_rng200_update_irq(BCM2838Rng200State *s)
> +{
> +    qemu_set_irq(s->irq,
> +                !!(s->regs[R_RNG_INT_ENABLE] & s->regs[R_RNG_INT_STATUS]));
> +}
> +
> +static void bcm2838_rng200_update_fifo(void *opaque, const void *buf,
> +                                       size_t size)
>  {
> -    state->regs.ctrl = 0;
> +    BCM2838Rng200State *s = (BCM2838Rng200State *)opaque;
> +    Fifo8 *fifo = &s->fifo;
> +    size_t num = MIN(size, fifo8_num_free(fifo));
> +    uint32_t num_bits = num * 8;
> +    uint32_t bit_threshold_left = 0;
> +    uint32_t bit_count = 0;
> +    uint32_t bit_count_thld = 0;
> +    uint32_t fifo_thld = 0;
> +
> +    increment_bit_counter_by(s, num_bits);
> +
> +    bit_count = s->regs[R_RNG_TOTAL_BIT_COUNT];
> +    bit_count_thld = s->regs[R_RNG_TOTAL_BIT_COUNT_THRESHOLD];
> +
> +    bit_threshold_left = (bit_count < bit_count_thld)
> +                       ? bit_count_thld - bit_count
> +                       : 0;
> +
> +    if (bit_threshold_left < num_bits) {
> +        num_bits -= bit_threshold_left;
> +    } else {
> +        num_bits = 0;
> +    }

Is it really correct that we first increment the
bit counter by num_bits, and then check for "is
there enough space between the bit counter and
the counter threshold" ? And then subtracting
threshold_left from num_bits also looks odd --
if we want to write 32 bits and we have 8 bits
left then this will cause us to write 24 bits ??

> +
> +    num = num_bits / 8;
> +    if ((num == 0) && (num_bits > 0)) {
> +        num = 1;
> +    }

This also looks odd -- why is "number of bits is
between 1 and 7" a special case when other numbers
of bits that aren't an even multiple of 8 are not?

> +    if (num > 0) {
> +        fifo8_push_all(fifo, buf, num);
> +
> +
> +        fifo_thld = FIELD_EX32(s->regs[R_RNG_FIFO_COUNT],
> +                               RNG_FIFO_COUNT, THRESHOLD);
> +
> +        if (fifo8_num_used(fifo) > fifo_thld) {
> +            s->regs[R_RNG_INT_STATUS] = FIELD_DP32(s->regs[R_RNG_INT_STATUS],
> +                                                   RNG_INT_STATUS,
> +                                                   TOTAL_BITS_COUNT_IRQ, 1);
> +        }
> +    }
> +
> +    s->regs[R_RNG_FIFO_COUNT] = FIELD_DP32(s->regs[R_RNG_FIFO_COUNT],
> +                                           RNG_FIFO_COUNT,
> +                                           COUNT,
> +                                           fifo8_num_used(fifo) >> 2);
> +    bcm2838_rng200_update_irq(s);
> +    trace_bcm2838_rng200_update_fifo(num, fifo8_num_used(fifo));
> +}
> +
> +static void bcm2838_rng200_fill_fifo(BCM2838Rng200State *s)
> +{
> +    rng_backend_request_entropy(s->rng, fifo8_num_free(&s->fifo),
> +                                bcm2838_rng200_update_fifo, s);
> +}
> +
> +/* This function will be implemnented in upcoming commits */

"implemented"

> +static void bcm2838_rng200_disable_rbg(BCM2838Rng200State *s
> +                                       __attribute__((unused)))
> +{
> +    trace_bcm2838_rng200_disable_rbg();
> +}
> +
> +static void bcm2838_rng200_enable_rbg(BCM2838Rng200State *s)
> +{
> +    s->regs[R_RNG_TOTAL_BIT_COUNT] = RNG_WARM_UP_PERIOD_ELAPSED;
> +
> +    bcm2838_rng200_fill_fifo(s);
> +
> +    trace_bcm2838_rng200_enable_rbg();
> +}
> +
> +static void bcm2838_rng200_rng_reset(BCM2838Rng200State *s)
> +{
> +    memset(s->regs, 0, sizeof(s->regs));
> +    s->regs[R_RNG_INT_STATUS] = FIELD_DP32(s->regs[R_RNG_INT_STATUS],
> +                                           RNG_INT_STATUS,
> +                                           STARTUP_TRANSITIONS_MET_IRQ,
> +                                           IRQ_PENDING);
> +    fifo8_reset(&s->fifo);
>
>      trace_bcm2838_rng200_rng_soft_reset();
>  }
>
> +static void bcm2838_rng200_rbg_reset(BCM2838Rng200State *s)
> +{
> +    trace_bcm2838_rng200_rbg_soft_reset();
> +}
> +
> +static uint32_t bcm2838_rng200_read_fifo_data(BCM2838Rng200State *s)
> +{
> +    Fifo8 *fifo = &s->fifo;
> +    const uint8_t *buf;
> +    uint32_t ret = 0;
> +    uint32_t num = 0;
> +    uint32_t max = MIN(fifo8_num_used(fifo), sizeof(ret));
> +
> +    if (max > 0) {
> +        buf = fifo8_pop_buf(fifo, max, &num);
> +        if ((buf != NULL) && (num > 0)) {
> +            memcpy(&ret, buf, num);
> +        }
> +    } else {
> +        qemu_log_mask(
> +            LOG_GUEST_ERROR,
> +            "bcm2838_rng200_read_fifo_data: FIFO is empty\n"
> +        );
> +    }
> +
> +    s->regs[R_RNG_FIFO_COUNT] = FIELD_DP32(s->regs[R_RNG_FIFO_COUNT],
> +                                           RNG_FIFO_COUNT,
> +                                           COUNT,
> +                                           fifo8_num_used(fifo) >> 2);
> +
> +    bcm2838_rng200_fill_fifo(s);
> +
> +    return ret;
> +}
> +
> +static void bcm2838_rng200_ctrl_write(BCM2838Rng200State *s, uint32_t value)
> +{
> +    bool currently_enabled = is_rbg_enabled(s);
> +    bool enable_requested = FIELD_EX32(value, RNG_CTRL, RBG_ENABLE);
> +
> +    s->regs[R_RNG_CTRL] = value;
> +
> +    if (!currently_enabled && enable_requested) {
> +        bcm2838_rng200_enable_rbg(s);
> +    } else if (currently_enabled && !enable_requested) {
> +        bcm2838_rng200_disable_rbg(s);
> +    }
> +}
> +
>  static uint64_t bcm2838_rng200_read(void *opaque, hwaddr offset,
>                                      unsigned size)
>  {
> +    BCM2838Rng200State *s = (BCM2838Rng200State *)opaque;
>      uint32_t res = 0;
>
> -    /* will be implemented in upcoming commits */
> +    switch (offset) {
> +    case A_RNG_CTRL:
> +        res = s->regs[R_RNG_CTRL];
> +        break;
> +    case A_RNG_SOFT_RESET:
> +    case A_RBG_SOFT_RESET:
> +        break;
> +    case A_RNG_INT_STATUS:
> +        res = s->regs[R_RNG_INT_STATUS];
> +        break;
> +    case A_RNG_INT_ENABLE:
> +        res = s->regs[R_RNG_INT_ENABLE];
> +        break;
> +    case A_RNG_FIFO_DATA:
> +        res = bcm2838_rng200_read_fifo_data(s);
> +        break;
> +    case A_RNG_FIFO_COUNT:
> +        res = s->regs[R_RNG_FIFO_COUNT];
> +        break;
> +    case A_RNG_TOTAL_BIT_COUNT:
> +        res = s->regs[R_RNG_TOTAL_BIT_COUNT];
> +        break;
> +    case A_RNG_TOTAL_BIT_COUNT_THRESHOLD:
> +        res = s->regs[R_RNG_TOTAL_BIT_COUNT_THRESHOLD];
> +        break;
> +    default:
> +        qemu_log_mask(
> +            LOG_GUEST_ERROR,
> +            "bcm2838_rng200_read: Bad offset 0x%" HWADDR_PRIx "\n",
> +            offset
> +        );
> +        res = 0;
> +        break;
> +    }
> +
> +    trace_bcm2838_rng200_read(offset, size, res);
>      return res;
>  }
>
>  static void bcm2838_rng200_write(void *opaque, hwaddr offset,
>                                   uint64_t value, unsigned size)
>  {
> -    /* will be implemented in upcoming commits */
> +    BCM2838Rng200State *s = (BCM2838Rng200State *)opaque;
> +
> +    trace_bcm2838_rng200_write(offset, value, size);
> +
> +    switch (offset) {
> +    case A_RNG_CTRL:
> +        bcm2838_rng200_ctrl_write(s, value);
> +        break;
> +    case A_RNG_SOFT_RESET:
> +        if (value & SOFT_RESET) {
> +            bcm2838_rng200_rng_reset(s);
> +        }
> +        break;
> +    case A_RBG_SOFT_RESET:
> +        if (value & SOFT_RESET) {
> +            bcm2838_rng200_rbg_reset(s);
> +        }
> +        break;
> +    case A_RNG_INT_STATUS:
> +        s->regs[R_RNG_INT_STATUS] &= ~value;
> +        bcm2838_rng200_update_irq(s);
> +        break;
> +    case A_RNG_INT_ENABLE:
> +        s->regs[R_RNG_INT_ENABLE] = value;
> +        bcm2838_rng200_update_irq(s);
> +        break;
> +    case A_RNG_FIFO_COUNT:
> +        s->regs[R_RNG_FIFO_COUNT] = value;
> +        break;
> +    case A_RNG_TOTAL_BIT_COUNT_THRESHOLD:
> +        s->regs[R_RNG_TOTAL_BIT_COUNT_THRESHOLD] = value;
> +        s->regs[R_RNG_TOTAL_BIT_COUNT] = value + 1;
> +        break;
> +    default:
> +        qemu_log_mask(
> +            LOG_GUEST_ERROR,
> +            "bcm2838_rng200_write: Bad offset 0x%" HWADDR_PRIx "\n",
> +            offset
> +        );
> +        break;
> +    }
>  }
>
>  static const MemoryRegionOps bcm2838_rng200_ops = {
> @@ -87,6 +338,7 @@ static void bcm2838_rng200_realize(DeviceState *dev, Error **errp)
>                                   errp);
>      }
>
> +    fifo8_create(&s->fifo, s->rng_fifo_cap);
>      sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq);
>  }
>
> @@ -116,6 +368,8 @@ static void bcm2838_rng200_init(Object *obj)
>  static void bcm2838_rng200_reset(DeviceState *dev)
>  {
>      BCM2838Rng200State *s = BCM2838_RNG200(dev);
> +
> +    bcm2838_rng200_rbg_reset(s);
>      bcm2838_rng200_rng_reset(s);
>  }
>
> diff --git a/include/hw/misc/bcm2838_rng200.h b/include/hw/misc/bcm2838_rng200.h
> index c9c52f84be..46fdba48da 100644
> --- a/include/hw/misc/bcm2838_rng200.h
> +++ b/include/hw/misc/bcm2838_rng200.h
> @@ -22,13 +22,7 @@
>  #define TYPE_BCM2838_RNG200 "bcm2838-rng200"
>  OBJECT_DECLARE_SIMPLE_TYPE(BCM2838Rng200State, BCM2838_RNG200)
>
> -typedef struct {
> -    uint32_t ctrl;
> -    uint32_t int_status;
> -    uint32_t fifo_count;
> -    uint32_t fifo_count_threshold;
> -    uint32_t total_bit_count_threshold;
> -} BCM2838_rng_regs_t;
> +#define N_BCM2838_RNG200_REGS 9
>
>  struct BCM2838Rng200State {
>      SysBusDevice busdev;
> @@ -45,7 +39,7 @@ struct BCM2838Rng200State {
>      Fifo8    fifo;
>      qemu_irq irq;
>
> -    BCM2838_rng_regs_t regs;
> +    uint32_t regs[N_BCM2838_RNG200_REGS];
>  };
>
>  #endif /* BCM2838_RNG200_H */
> --
> 2.34.1

thanks
-- PMM

