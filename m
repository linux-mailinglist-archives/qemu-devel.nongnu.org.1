Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA817F3B65
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 02:43:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5cFz-0002T3-Hp; Tue, 21 Nov 2023 20:42:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhoff749@gmail.com>)
 id 1r5cFy-0002Ss-JQ; Tue, 21 Nov 2023 20:42:22 -0500
Received: from mail-qt1-x833.google.com ([2607:f8b0:4864:20::833])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dhoff749@gmail.com>)
 id 1r5cFw-0006m1-M3; Tue, 21 Nov 2023 20:42:22 -0500
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-41eae4ebf61so37106591cf.2; 
 Tue, 21 Nov 2023 17:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700617339; x=1701222139; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=taSigf5Qrg8gYOQReEoEkAVRsKgXkwmqlDhWxBu8Qj4=;
 b=eZhH/YHbK3Wub33MrqDKowZ0NfbSs6/XeknDZtlO/05iSupQdOXfxRlTP0Wh9XU70f
 z3dcuKxcc7b3phUAQsqNO4iaUO2tYmvSiqwcmLKH/Xnh1WDkhAxCpPZSLwK63l9N5uob
 fvVQ+1xJQS8xw3GzGupxpaHHrBtg3pahKHPeij4e9CVcq7hOHGZym9zsb/jbNTiBiPNF
 hk9ElvwhOvYYdGDNQU6NvpgSi0Wj70nJoetm/oDusrwCsZk4nWZh5qgoIrnyZ9qUw7qY
 LFYnZyA30o9cBCmdhniEQHKPEV8MnMJkBwzOWlfCd2vG9X/Au+0+KacOFyimkegqGc0T
 1Mlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700617339; x=1701222139;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=taSigf5Qrg8gYOQReEoEkAVRsKgXkwmqlDhWxBu8Qj4=;
 b=vWhtPPz0EEKhki1K7NTAvQXPW91ZCAI7aEJtL+hewMY0ZqNbjCN56dL2x3vW76mQP/
 EVTrt9Pdwb4OsMj12RhWckpGxHkuZ/GS/iyiQB5AS3WhnF50QhDK4NryPcfF6pbgRUD8
 u7Kc9KHRhr23MF6QmuiWY1Ubw/A5QBiDleRz0n8RDOtT4YgUCerBI9CYoywy3uIhuycj
 T9TzDFIyl7HQzfe0b3miBRenF5wz4RhCNEmeR66BoibCcoo2jV+w9niYOgoK/6hyv+5S
 9lSC+T+79Lw85EtljEKAPQc/YaBcsaEBF270EPhuW5odjNsgOzPjBRxQXuYiK3mjKtaX
 sqEw==
X-Gm-Message-State: AOJu0YwW78xo0Q1FBxgBG5Npx/tx7YQFQIgDW7xGsmLlB/mJf0vm3O+u
 l0gXXlvoMbyC5o/1pcLvsF6Jo4IJewpJpka/NcfbHQ/p
X-Google-Smtp-Source: AGHT+IHRqXpL6Yrlk1Rr5pQ0rDTF6XNue0vgHJGyZ9rnuzuSsSm1tbIre6/kFHPpj9hsL7zYK3mFflxyuaT49tCCVfY=
X-Received: by 2002:ac8:5c09:0:b0:421:bcc0:d6c6 with SMTP id
 i9-20020ac85c09000000b00421bcc0d6c6mr1283807qti.28.1700617339100; Tue, 21 Nov
 2023 17:42:19 -0800 (PST)
MIME-Version: 1.0
References: <20231118231129.2840388-1-dhoff749@gmail.com>
In-Reply-To: <20231118231129.2840388-1-dhoff749@gmail.com>
From: Dan Hoffman <dhoff749@gmail.com>
Date: Tue, 21 Nov 2023 19:42:08 -0600
Message-ID: <CAFXChK+NELKJUcQSjKe-v_gcjnOPD07fe8c8bBVQFjqDQwZMMA@mail.gmail.com>
Subject: Re: [PATCH] hw/timer/hpet: Convert DPRINTF to trace events
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::833;
 envelope-from=dhoff749@gmail.com; helo=mail-qt1-x833.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

bump

On Sat, Nov 18, 2023 at 5:13=E2=80=AFPM Daniel Hoffman <dhoff749@gmail.com>=
 wrote:
>
> This conversion is pretty straight-forward. Standardized some formatting
> so the +0 and +4 offset cases can recycle the same message.
>
> Signed-off-by: Daniel Hoffman <dhoff749@gmail.com>
> ---
>  hw/timer/hpet.c       | 55 +++++++++++++++++--------------------------
>  hw/timer/trace-events | 16 +++++++++++++
>  2 files changed, 38 insertions(+), 33 deletions(-)
>
> diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
> index 6998094233a..f9d248b4cf7 100644
> --- a/hw/timer/hpet.c
> +++ b/hw/timer/hpet.c
> @@ -39,13 +39,7 @@
>  #include "hw/timer/i8254.h"
>  #include "exec/address-spaces.h"
>  #include "qom/object.h"
> -
> -//#define HPET_DEBUG
> -#ifdef HPET_DEBUG
> -#define DPRINTF printf
> -#else
> -#define DPRINTF(...)
> -#endif
> +#include "trace.h"
>
>  #define HPET_MSI_SUPPORT        0
>
> @@ -431,7 +425,7 @@ static uint64_t hpet_ram_read(void *opaque, hwaddr ad=
dr,
>      HPETState *s =3D opaque;
>      uint64_t cur_tick, index;
>
> -    DPRINTF("qemu: Enter hpet_ram_readl at %" PRIx64 "\n", addr);
> +    trace_hpet_ram_read(addr);
>      index =3D addr;
>      /*address range of all TN regs*/
>      if (index >=3D 0x100 && index <=3D 0x3ff) {
> @@ -439,7 +433,7 @@ static uint64_t hpet_ram_read(void *opaque, hwaddr ad=
dr,
>          HPETTimer *timer =3D &s->timer[timer_id];
>
>          if (timer_id > s->num_timers) {
> -            DPRINTF("qemu: timer id out of range\n");
> +            trace_hpet_timer_id_out_of_range(timer_id);
>              return 0;
>          }
>
> @@ -457,7 +451,7 @@ static uint64_t hpet_ram_read(void *opaque, hwaddr ad=
dr,
>          case HPET_TN_ROUTE + 4:
>              return timer->fsb >> 32;
>          default:
> -            DPRINTF("qemu: invalid hpet_ram_readl\n");
> +            trace_hpet_ram_read_invalid();
>              break;
>          }
>      } else {
> @@ -469,7 +463,7 @@ static uint64_t hpet_ram_read(void *opaque, hwaddr ad=
dr,
>          case HPET_CFG:
>              return s->config;
>          case HPET_CFG + 4:
> -            DPRINTF("qemu: invalid HPET_CFG + 4 hpet_ram_readl\n");
> +            trace_hpet_invalid_hpet_cfg(4);
>              return 0;
>          case HPET_COUNTER:
>              if (hpet_enabled(s)) {
> @@ -477,7 +471,7 @@ static uint64_t hpet_ram_read(void *opaque, hwaddr ad=
dr,
>              } else {
>                  cur_tick =3D s->hpet_counter;
>              }
> -            DPRINTF("qemu: reading counter  =3D %" PRIx64 "\n", cur_tick=
);
> +            trace_hpet_ram_read_reading_counter(0, cur_tick);
>              return cur_tick;
>          case HPET_COUNTER + 4:
>              if (hpet_enabled(s)) {
> @@ -485,12 +479,12 @@ static uint64_t hpet_ram_read(void *opaque, hwaddr =
addr,
>              } else {
>                  cur_tick =3D s->hpet_counter;
>              }
> -            DPRINTF("qemu: reading counter + 4  =3D %" PRIx64 "\n", cur_=
tick);
> +            trace_hpet_ram_read_reading_counter(4, cur_tick);
>              return cur_tick >> 32;
>          case HPET_STATUS:
>              return s->isr;
>          default:
> -            DPRINTF("qemu: invalid hpet_ram_readl\n");
> +            trace_hpet_ram_read_invalid();
>              break;
>          }
>      }
> @@ -504,8 +498,7 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
>      HPETState *s =3D opaque;
>      uint64_t old_val, new_val, val, index;
>
> -    DPRINTF("qemu: Enter hpet_ram_writel at %" PRIx64 " =3D 0x%" PRIx64 =
"\n",
> -            addr, value);
> +    trace_hpet_ram_write(addr, value);
>      index =3D addr;
>      old_val =3D hpet_ram_read(opaque, addr, 4);
>      new_val =3D value;
> @@ -515,14 +508,14 @@ static void hpet_ram_write(void *opaque, hwaddr add=
r,
>          uint8_t timer_id =3D (addr - 0x100) / 0x20;
>          HPETTimer *timer =3D &s->timer[timer_id];
>
> -        DPRINTF("qemu: hpet_ram_writel timer_id =3D 0x%x\n", timer_id);
> +        trace_hpet_ram_write_timer_id(timer_id);
>          if (timer_id > s->num_timers) {
> -            DPRINTF("qemu: timer id out of range\n");
> +            trace_hpet_timer_id_out_of_range(timer_id);
>              return;
>          }
>          switch ((addr - 0x100) % 0x20) {
>          case HPET_TN_CFG:
> -            DPRINTF("qemu: hpet_ram_writel HPET_TN_CFG\n");
> +            trace_hpet_ram_write_tn_cfg();
>              if (activating_bit(old_val, new_val, HPET_TN_FSB_ENABLE)) {
>                  update_irq(timer, 0);
>              }
> @@ -540,10 +533,10 @@ static void hpet_ram_write(void *opaque, hwaddr add=
r,
>              }
>              break;
>          case HPET_TN_CFG + 4: // Interrupt capabilities
> -            DPRINTF("qemu: invalid HPET_TN_CFG+4 write\n");
> +            trace_hpet_ram_write_invalid_tn_cfg(4);
>              break;
>          case HPET_TN_CMP: // comparator register
> -            DPRINTF("qemu: hpet_ram_writel HPET_TN_CMP\n");
> +            trace_hpet_ram_write_tn_cmp(0);
>              if (timer->config & HPET_TN_32BIT) {
>                  new_val =3D (uint32_t)new_val;
>              }
> @@ -566,7 +559,7 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
>              }
>              break;
>          case HPET_TN_CMP + 4: // comparator register high order
> -            DPRINTF("qemu: hpet_ram_writel HPET_TN_CMP + 4\n");
> +            trace_hpet_ram_write_tn_cmp(4);
>              if (!timer_is_periodic(timer)
>                  || (timer->config & HPET_TN_SETVAL)) {
>                  timer->cmp =3D (timer->cmp & 0xffffffffULL) | new_val <<=
 32;
> @@ -591,7 +584,7 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
>              timer->fsb =3D (new_val << 32) | (timer->fsb & 0xffffffff);
>              break;
>          default:
> -            DPRINTF("qemu: invalid hpet_ram_writel\n");
> +            trace_hpet_ram_write_invalid();
>              break;
>          }
>          return;
> @@ -631,7 +624,7 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
>              }
>              break;
>          case HPET_CFG + 4:
> -            DPRINTF("qemu: invalid HPET_CFG+4 write\n");
> +            trace_hpet_invalid_hpet_cfg(4);
>              break;
>          case HPET_STATUS:
>              val =3D new_val & s->isr;
> @@ -643,24 +636,20 @@ static void hpet_ram_write(void *opaque, hwaddr add=
r,
>              break;
>          case HPET_COUNTER:
>              if (hpet_enabled(s)) {
> -                DPRINTF("qemu: Writing counter while HPET enabled!\n");
> +                trace_hpet_ram_write_counter_write_while_enabled();
>              }
>              s->hpet_counter =3D
>                  (s->hpet_counter & 0xffffffff00000000ULL) | value;
> -            DPRINTF("qemu: HPET counter written. ctr =3D 0x%" PRIx64 " -=
> "
> -                    "%" PRIx64 "\n", value, s->hpet_counter);
> +            trace_hpet_ram_write_counter_written(0, value, s->hpet_count=
er);
>              break;
>          case HPET_COUNTER + 4:
> -            if (hpet_enabled(s)) {
> -                DPRINTF("qemu: Writing counter while HPET enabled!\n");
> -            }
> +            trace_hpet_ram_write_counter_write_while_enabled();
>              s->hpet_counter =3D
>                  (s->hpet_counter & 0xffffffffULL) | (((uint64_t)value) <=
< 32);
> -            DPRINTF("qemu: HPET counter + 4 written. ctr =3D 0x%" PRIx64=
 " -> "
> -                    "%" PRIx64 "\n", value, s->hpet_counter);
> +            trace_hpet_ram_write_counter_written(4, value, s->hpet_count=
er);
>              break;
>          default:
> -            DPRINTF("qemu: invalid hpet_ram_writel\n");
> +            trace_hpet_ram_write_invalid();
>              break;
>          }
>      }
> diff --git a/hw/timer/trace-events b/hw/timer/trace-events
> index 3eccef83858..474831a8c3b 100644
> --- a/hw/timer/trace-events
> +++ b/hw/timer/trace-events
> @@ -99,3 +99,19 @@ sifive_pwm_write(uint64_t data, uint64_t offset) "Writ=
e 0x%" PRIx64 " at address
>  sh_timer_start_stop(int enable, int current) "%d (%d)"
>  sh_timer_read(uint64_t offset) "tmu012_read 0x%" PRIx64
>  sh_timer_write(uint64_t offset, uint64_t value) "tmu012_write 0x%" PRIx6=
4 " 0x%08" PRIx64
> +
> +# hpet.c
> +hpet_timer_id_out_of_range(uint8_t timer_id) "timer id out of range: 0x%=
" PRIx8
> +hpet_invalid_hpet_cfg(uint8_t reg_off) "invalid HPET_CFG + 0x%x" PRIx8
> +hpet_ram_read(uint64_t addr) "enter hpet_ram_readl at 0x%" PRIx64
> +hpet_ram_read_reading_counter(uint8_t reg_off, uint64_t cur_tick) "readi=
ng counter + 0x%" PRIx8 " =3D 0x%" PRIx64
> +hpet_ram_read_invalid(void) "invalid hpet_ram_readl"
> +hpet_ram_write(uint64_t addr, uint64_t value) "enter hpet_ram_writel at =
0x%" PRIx64 " =3D 0x%" PRIx64
> +hpet_ram_write_timer_id(uint64_t timer_id) "hpet_ram_writel timer_id =3D=
 0x%" PRIx64
> +hpet_ram_write_tn_cfg(void) "hpet_ram_writel HPET_TN_CFG"
> +hpet_ram_write_invalid_tn_cfg(uint8_t reg_off) "invalid HPET_TN_CFG + %"=
 PRIx8 " write"
> +hpet_ram_write_tn_cmp(uint8_t reg_off) "hpet_ram_writel HPET_TN_CMP + %"=
 PRIx8
> +hpet_ram_write_invalid(void) "invalid hpet_ram_writel"
> +hpet_ram_write_counter_write_while_enabled(void) "Writing counter while =
HPET enabled!"
> +hpet_ram_write_counter_written(uint8_t reg_off, uint64_t value, uint64_t=
 counter) "HPET counter + %" PRIx8 "written. crt =3D 0x%" PRIx64 " -> 0x%" =
PRIx64
> +
> --
> 2.40.1
>

