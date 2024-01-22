Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F393A836FB5
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 19:22:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRyue-0006ij-2p; Mon, 22 Jan 2024 13:20:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rRyuc-0006hx-HM
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 13:20:46 -0500
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rRyua-0002xA-FB
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 13:20:46 -0500
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2cdeb954640so36920261fa.3
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 10:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705947642; x=1706552442; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uZ/1/rHerXAfPqeRODXv/KHpt4Wstv33M1/Pr1QvYPc=;
 b=YgNlRmkB7JxUJdQLe6QTW0GnRaKHrNNo1fgq6PqqEwqdyjYJrXH016eLiHHB7nZVUn
 gBPizfcDX8R80rdnTMi1sTuZUcb9bcUIEVgWacAF7z2EOku2oTGJKp3BKnBEtvSR9Cwn
 odueY+IjEomg1c/+3rcqJc2QAuVbL3vciiFdNw4qXPGvLykB4/RNMrey4RVXRDmrVBCA
 X4FCMr36Mr8PtL/B8GVnUjhcxgr0hfvT4NwdwouGUskE7WM4usRDaHFa8ApwVeimQNL9
 +iDBEAxzPdtxFC8bVxyQbk3FTUYXLClsOmeX3obgBwN3HJX+2K6KLZ8qcmV3+j+wwKtj
 u+kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705947642; x=1706552442;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uZ/1/rHerXAfPqeRODXv/KHpt4Wstv33M1/Pr1QvYPc=;
 b=oM6WIqCT2Y6jwSxSJf9nAPRDpHMvz//lV/Ix1ytVyZO04iU0psuhCQJkOx36BUsHFj
 Jjre1lLFURfutiXgpZe+Zk7XslGQm+h/UWgSm9t5mMSdKnNHwVz9KcD19L4VyoWurjSD
 rDPpP1jIYBcvcaSwitD2yIKR006Yg/aKn0Ta7xazxfNYBo8V2bHe4s4Jf3TJtSIu60Rb
 3Xgdqe3Nre0SB5ltshVacOCFaNcxn731aETRn8yARjznSH8l+FbI2HATmy9zVxy4Rj/n
 PAAnr+AqlGGonz8woECnd0womgoFGUxXXC68PGKFJWzCEL+19T0vQAlqIPmKgJvLwUhI
 REjg==
X-Gm-Message-State: AOJu0YxRHtek2EC6cElgzr0InhmDLRhJHUrJsn7egYm7iWqqS9+0I0TY
 3pibBa5RY/7o19Z043rGF+dd9QN+dmKNVBwHBtznoLi09CyUi3qu0RjYaCrG18gwbK9N9KAJiWR
 k/egomCgFobqAa+ZMu+FUcfSn5ZA6td4RKSM7jQ==
X-Google-Smtp-Source: AGHT+IE4xBKpLVXRqkrsWFVoSZ6Ltxm2fprn/gnfZ+ScHbYRIR+Yyy5YCdG6g2rzH1yVUzjGX79nVtCIauGzWvb8vHg=
X-Received: by 2002:a2e:a585:0:b0:2cc:d4cd:18a3 with SMTP id
 m5-20020a2ea585000000b002ccd4cd18a3mr2560723ljp.89.1705947641733; Mon, 22 Jan
 2024 10:20:41 -0800 (PST)
MIME-Version: 1.0
References: <cover.1705670342.git.manos.pitsidianakis@linaro.org>
 <339219e962d90f47cf125f2be2d64afb0833e905.1705670342.git.manos.pitsidianakis@linaro.org>
In-Reply-To: <339219e962d90f47cf125f2be2d64afb0833e905.1705670342.git.manos.pitsidianakis@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 22 Jan 2024 18:20:30 +0000
Message-ID: <CAFEAcA9sqoDju6vpD_AN2=At_BbChGsMSckumfYL+u3+g9SJ2Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] hw/arm/z2: convert DPRINTF to trace events and
 guest errors
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x230.google.com
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

On Fri, 19 Jan 2024 at 13:24, Manos Pitsidianakis
<manos.pitsidianakis@linaro.org> wrote:
>
> Tracing DPRINTFs to stderr might not be desired. A developer that relies
> on trace events should be able to opt-in to each trace event and rely on
> QEMU's log redirection, instead of stderr by default.
>
> This commit converts DPRINTFs in this file that are used for tracing
> into trace events. DPRINTFs that report guest errors are logged with
> LOG_GUEST_ERROR.
>
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>  hw/arm/strongarm.c  | 55 ++++++++++++++++++++++-----------------------
>  hw/arm/trace-events | 10 +++++++++
>  hw/arm/z2.c         | 27 +++++++---------------

Hi; thanks for sending these patches.

The strongarm.c and z2.c files aren't related (z2 uses
the pxa2xx CPU, not strongarm), so I think these are better
as two separate patches.

>  3 files changed, 45 insertions(+), 47 deletions(-)
>
> diff --git a/hw/arm/strongarm.c b/hw/arm/strongarm.c
> index fef3638aca..9fca0b302c 100644
> --- a/hw/arm/strongarm.c
> +++ b/hw/arm/strongarm.c
> @@ -46,8 +46,7 @@
>  #include "qemu/cutils.h"
>  #include "qemu/log.h"
>  #include "qom/object.h"
> -
> -//#define DEBUG
> +#include "trace.h"
>
>  /*
>   TODO
> @@ -66,12 +65,6 @@
>   - Enhance UART with modem signals
>   */
>
> -#ifdef DEBUG
> -# define DPRINTF(format, ...) printf(format , ## __VA_ARGS__)
> -#else
> -# define DPRINTF(format, ...) do { } while (0)
> -#endif
> -
>  static struct {
>      hwaddr io_base;
>      int irq;
> @@ -151,8 +144,9 @@ static uint64_t strongarm_pic_mem_read(void *opaque, hwaddr offset,
>      case ICPR:
>          return s->pending;
>      default:
> -        printf("%s: Bad register offset 0x" HWADDR_FMT_plx "\n",
> -                        __func__, offset);
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "Bad pic mem register read offset 0x%zu",
> +                      offset);

Message strings for qemu_log_mask() need a trailing "\n"
(unlike trace-event strings).

'offset' is type 'hwaddr', so the correct format string is
HWADDR_FMT_plx as the printf already has, not %zu. (Watch out
that the HWADDR_FMT_* macros include the "%", unlike the
POSIX style PRIx64 etc macros.) Getting the format string
wrong can cause compilation failures on some hosts (eg
32-bit hosts where the size_t etc types are different sizes.)

It's nice with these error messages to be a bit more
precise about the device that's produced them than
just "pic mem". In this case you could say "strongarm_pic".
(The 'mem' isn't really part of the device name.) Or
we are often lazy and use __func__.

Similarly with the other qemu_log_mask() calls below.

>          return 0;
>      }
>  }

> @@ -1029,8 +1024,11 @@ static void strongarm_uart_update_parameters(StrongARMUARTState *s)
>      s->char_transmit_time =  (NANOSECONDS_PER_SECOND / speed) * frame_size;
>      qemu_chr_fe_ioctl(&s->chr, CHR_IOCTL_SERIAL_SET_PARAMS, &ssp);
>
> -    DPRINTF(stderr, "%s speed=%d parity=%c data=%d stop=%d\n", s->chr->label,
> -            speed, parity, data_bits, stop_bits);
> +    trace_strongarm_uart_update_parameters(s->chr.chr->label?:"NULL",

Something's gone wrong here. The old code had 's->chr->label'
and the new code has got an extra '.chr' in it from somewhere.

(Did this really compile ? Check your configure options were
such that the file is being recompiled and the trace events
are being emitted.)

The code needs to handle s->chr being NULL (this will happen
if you start a strongarm machine with the command line argument
"-serial none").

> +                                           speed,
> +                                           parity,
> +                                           data_bits,
> +                                           stop_bits);
>  }
>

> @@ -1458,8 +1456,9 @@ static void strongarm_ssp_write(void *opaque, hwaddr addr,
>      case SSCR0:
>          s->sscr[0] = value & 0xffbf;
>          if ((s->sscr[0] & SSCR0_SSE) && SSCR0_DSS(value) < 4) {
> -            printf("%s: Wrong data size: %i bits\n", __func__,
> -                   (int)SSCR0_DSS(value));
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "Wrong data size: %i bits",
> +                          (int)SSCR0_DSS(value));

This message has no indication at all of what device is producing it.

>          }
>          if (!(value & SSCR0_SSE)) {
>              s->sssr = 0;

> diff --git a/hw/arm/trace-events b/hw/arm/trace-events
> index cdc1ea06a8..b0a56fcdc6 100644
> --- a/hw/arm/trace-events
> +++ b/hw/arm/trace-events
> @@ -55,3 +55,13 @@ smmuv3_notify_flag_add(const char *iommu) "ADD SMMUNotifier node for iommu mr=%s
>  smmuv3_notify_flag_del(const char *iommu) "DEL SMMUNotifier node for iommu mr=%s"
>  smmuv3_inv_notifiers_iova(const char *name, uint16_t asid, uint16_t vmid, uint64_t iova, uint8_t tg, uint64_t num_pages) "iommu mr=%s asid=%d vmid=%d iova=0x%"PRIx64" tg=%d num_pages=0x%"PRIx64
>
> +# z2.c
> +z2_lcd_reg_update(uint8_t cur, uint8_t _0, uint8_t _1, uint8_t _2, uint32_t value) "cur_reg = 0x%xd, buf = [0x%xd, 0x%xd, 0x%xd], value = 0x%x"

Don't use argument names starting with underscores; those are
reserved for the compiler and the system. Here I would
suggest buf0, buf1, buf2.

"%xd" will print the number in hex followed by a literal 'd' character.
For hex numbers, just "0x%x" is sufficient. (Look at other
trace lines in this file for examples.)

> +z2_lcd_enable_disable_result(const char * result) "LCD %s"

No space after the '*' in the argument type.

> +z2_aer915_send_too_long(int8_t msg) "message too long (%i bytes)"
> +z2_aer915_send(uint8_t reg, uint8_t value) "reg %d value 0x%02x"
> +z2_aer915_event(int8_t event, int8_t len) "i2c event =0x%x len=%d bytes"
> +
> +# strongarm.c
> +strongarm_uart_update_parameters(const char *label, int speed, char parity, int data_bits, int stop_bits) "%s speed=%d parity=%c data=%d stop=%d"
> +strongarm_ssp_read_underrun(void) "SSP rx underrun"

thanks
-- PMM

