Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 256537A20C8
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 16:24:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qh9jn-0003Rq-0H; Fri, 15 Sep 2023 10:24:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qh9jb-0003Qe-UX
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 10:23:52 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qh9ja-0001OX-9z
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 10:23:51 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-31aeef88a55so1917613f8f.2
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 07:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694787827; x=1695392627; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=T7P5lmIXyoTdkYaNDAXw92bAgTHk4zwBBPIFAs4SYrE=;
 b=MgG+5YJSKhVV/nTK4eWO/RXFFF/Vo9x2DJts6drXXHp1Oz9QAx4Y1auTFat2IRHiO8
 CY9hiJCJldF2xJux/h3lhyAUOuwe5s514nzTpDijrd1ObzgmDVVHrIc17dh1k6wa51Eq
 zNUZxsivhUnOM7rimBHoO1eh1c80qVQdZ/JZRQHJq6DfqbSQ2q0ROLCxkjYPm5RzFxo1
 TRlxGWQ2FSU+4OKhuElvGHo7B2sDwDkfVT4dzwtEuzSEufel49uLdDBD43Oe/jrNq05D
 CQUD/lihFcHqdOuFFVZL3DogrcMXsabWFHAoBnyt8aMlgrhjKzqOw/OKoeW2UPBaeZZR
 Wq6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694787827; x=1695392627;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=T7P5lmIXyoTdkYaNDAXw92bAgTHk4zwBBPIFAs4SYrE=;
 b=P81LO0FOl5DUA60kbu5c7zKLyAKJ70f2uNvdfv6Rs/h9IJX6160OtGowBtSd8hDGs6
 EzH/ACQ+e+Xh1aW7D+5KPQ+adOn8UUHp1WXZhdD4mVfbdMqr1MdjK+aa9sZelP+gxhbG
 AyI8XF6TOrcIJYkDkR0VSavD5Ib5mP+ioZXiUMq/LPLI/bkfom5S4ATg2EwX9fOudao6
 JURf1o2kCbZGS6kceIK86WcP0hnX9A0ht2qKpBfDMNRnKLO7euEF1XbSIPQuub1nFOf3
 Hu07i51T1eEUM9eCljyWzI2OwEax1sFpNI54iyEzCCpoKjz1OQF46d3DUthX3H/bXxaK
 pgEw==
X-Gm-Message-State: AOJu0YyPSR9bJiWnYesiaRKKgyAHxtzc2puHyT9JovPlLKxiNgLS2KN6
 tAldbm6v2r4THyJ+ZQ+E7cZjz463RB9w9fRKhA6Zjg==
X-Google-Smtp-Source: AGHT+IFrVLA/jzEk9vo+deKGTg9WSA9acpLMzHW8zSgYPfQqnSaECm0zojRFjomlXhYp38EKsLIGoZggq9GuwAwPDys=
X-Received: by 2002:a5d:46c4:0:b0:31d:cf59:8de with SMTP id
 g4-20020a5d46c4000000b0031dcf5908demr1772896wrs.19.1694787827290; Fri, 15 Sep
 2023 07:23:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230905201425.118918-1-strahinja.p.jankovic@gmail.com>
 <20230905201425.118918-6-strahinja.p.jankovic@gmail.com>
In-Reply-To: <20230905201425.118918-6-strahinja.p.jankovic@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Sep 2023 15:23:27 +0100
Message-ID: <CAFEAcA-601OV-RDDy4V+b7+2Ciyer8LSRiz+tfLHMWBTgwXvPg@mail.gmail.com>
Subject: Re: [RFC Patch 5/5] hw/input: Add Allwinner-A10 PS2 emulation
To: Strahinja Jankovic <strahinjapjankovic@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Beniamino Galvani <b.galvani@gmail.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
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

On Tue, 5 Sept 2023 at 21:14, Strahinja Jankovic
<strahinjapjankovic@gmail.com> wrote:
>
> Add emulation for PS2-0 and PS2-1 for keyboard/mouse.
>
> Signed-off-by: Strahinja Jankovic <strahinja.p.jankovic@gmail.com>



> +static int allwinner_a10_ps2_fctl_is_irq(AwA10PS2State *s)
> +{
> +    return (s->regs[REG_INDEX(REG_FCTL)] & FIELD_REG_FCTL_TXRDY_IEN) ||
> +        (s->pending &&
> +         (s->regs[REG_INDEX(REG_FCTL)] & FIELD_REG_FCTL_RXRDY_IEN));

It looks a little odd that you need a separate s->pending bool here.
Sometimes hardware does odd things, but the most usual situation
is that the pending status of an interrupt is directly reflected
in a register bit somewhere, and "is the interrupt high" logic
is then just "is the pending bit set and is the enable bit set".
Often the bit positions are deliberately the same in the two
registers and then "is an interrupt set" is something like
  if (s->regs[REG_INDEX(REG_FCTL)] & s->regs[REG_INDEX(REG_FSTS)] &
      (TXRDY_IEN | RXRDY_IEN))



> +}
> +
> +static void allwinner_a10_ps2_update_irq(AwA10PS2State *s)
> +{
> +    int level = (s->regs[REG_INDEX(REG_GCTL)] & FIELD_REG_GCTL_INT_EN) &&
> +        allwinner_a10_ps2_fctl_is_irq(s);
> +
> +    qemu_set_irq(s->irq, level);
> +}
> +
> +static void allwinner_a10_ps2_set_irq(void *opaque, int n, int level)
> +{
> +    AwA10PS2State *s = (AwA10PS2State *)opaque;
> +
> +    s->pending = level;
> +    allwinner_a10_ps2_update_irq(s);
> +}
> +
> +static uint64_t allwinner_a10_ps2_read(void *opaque, hwaddr offset,
> +                                       unsigned size)
> +{
> +    AwA10PS2State *s = AW_A10_PS2(opaque);
> +    const uint32_t idx = REG_INDEX(offset);
> +
> +    switch (offset) {
> +    case REG_FSTS:
> +        {
> +            uint32_t stat = FIELD_REG_FSTS_TX_RDY;
> +            if (s->pending) {
> +                stat |= FIELD_REG_FSTS_RX_LEVEL1 | FIELD_REG_FSTS_RX_RDY;
> +            }
> +            return stat;

The logic here also suggests that the code would be simpler if you
keep the TX_RDY and RX_RDY state directly in this register value,
rather than hardcoding TX_RDY to always-set and keeping RX_RDY
in a separate pending field.

> +        }
> +        break;
> +    case REG_DATA:
> +        if (s->pending) {
> +            s->last = ps2_read_data(s->ps2dev);
> +        }
> +        return s->last;

You could keep the last returned data in s->regs[REG_IDX(REG_DATA)]
and avoid having to have an extra s->last field in the state struct.

> +    case REG_GCTL:
> +        {
> +            if (allwinner_a10_ps2_fctl_is_irq(s)) {
> +                s->regs[idx] |= FIELD_REG_GCTL_INT_FLAG;
> +            } else {
> +                s->regs[idx] &= FIELD_REG_GCTL_INT_FLAG;
> +            }
> +        }
> +        break;
> +    case REG_LCTL:
> +    case REG_LSTS:
> +    case REG_FCTL:
> +    case REG_CLKDR:
> +        break;
> +    case 0x1C ... AW_A10_PS2_IOSIZE:
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: out-of-bounds offset 0x%04x\n",
> +                      __func__, (uint32_t)offset);
> +        return 0;
> +    default:
> +        qemu_log_mask(LOG_UNIMP, "%s: unimplemented read offset 0x%04x\n",
> +                      __func__, (uint32_t)offset);
> +        return 0;
> +    }
> +
> +    return s->regs[idx];
> +}
> +
> +static void allwinner_a10_ps2_write(void *opaque, hwaddr offset,
> +                                   uint64_t val, unsigned size)
> +{
> +    AwA10PS2State *s = AW_A10_PS2(opaque);
> +    const uint32_t idx = REG_INDEX(offset);
> +
> +    s->regs[idx] = (uint32_t) val;
> +
> +    switch (offset) {
> +    case REG_GCTL:
> +        allwinner_a10_ps2_update_irq(s);
> +        s->regs[idx] &= ~FIELD_REG_GCTL_SOFT_RST;
> +        break;
> +    case REG_DATA:
> +        /* ??? This should toggle the TX interrupt line.  */
> +        /* ??? This means kbd/mouse can block each other.  */

I don't understand this comment. It looks like it was cut-and-pasted
from another device where it was originally written in 2005 (and
I don't understand it there either). We should either understand
what we mean here, or else not have the comment at all...

> +        if (s->is_mouse) {
> +            ps2_write_mouse(PS2_MOUSE_DEVICE(s->ps2dev), val);
> +        } else {
> +            ps2_write_keyboard(PS2_KBD_DEVICE(s->ps2dev), val);
> +        }
> +        break;
> +    case REG_LCTL:
> +    case REG_LSTS:
> +    case REG_FCTL:
> +    case REG_FSTS:
> +    case REG_CLKDR:
> +        break;
> +    case 0x1C ... AW_A10_PS2_IOSIZE:
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: out-of-bounds offset 0x%04x\n",
> +                      __func__, (uint32_t)offset);
> +        break;
> +    default:
> +        qemu_log_mask(LOG_UNIMP, "%s: unimplemented write offset 0x%04x\n",
> +                      __func__, (uint32_t)offset);
> +        break;
> +    }
> +}

thanks
-- PMM

