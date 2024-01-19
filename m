Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B6E832915
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 12:42:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQnFq-0006CB-RX; Fri, 19 Jan 2024 06:41:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rQnFo-000615-N9
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 06:41:44 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rQnFm-0005XB-Ob
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 06:41:44 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40e80046264so7847925e9.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jan 2024 03:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705664501; x=1706269301; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qTz/xESkNAlsd1ynMvqRIt2ApbzhjD53VuhRc8LiQCQ=;
 b=oiUypbxY5HSDZv/VUQcx+vSQ9LebMnvG4avZ4pP5HoX/66ooMHRbJrwXHxNBFxfLLU
 yUtzHr3wqn/QHcPQjkA9hrUOZAZxbMSQE9uD2SY5LLs1KpW+fsm1kikW29hFaQStVYIU
 906nIUOf0UM2QPFSYZcc7cf02LsB3u/3I0wsGqhZ+8K08iWT3ihbeFoov9+dddDr5I6i
 aiKeee9mJ/rTxY/F2m/IdL/LjeGHUM3Ql3lm5EagVYrs/mdWVg3c4HHwGcZMJuv9aErR
 qA03ID6bS8ARDNIt5GcSKO+Xbzkw0KPL1rTRr0PVPF3GqMy98uaM+qy9fC2bc7VevR++
 TSeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705664501; x=1706269301;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qTz/xESkNAlsd1ynMvqRIt2ApbzhjD53VuhRc8LiQCQ=;
 b=gJpgbJl1zWZyLcumozY++qeShFX7Aad7sMLUijdg/MSwovbJPxR7rDGTmH6ac0kg89
 TfYK53cc6aMMFSDQZhAdhDCx3u2KOaPRq3x+isMFLhNktX3BhuqSWHCIpVLw0ClrmPvh
 B05XwBIJrvblnXj91H8rfnasImzVTfS3uHnn3ULcSEbSHDgv0wApfmi9VbRez8B5v+wH
 /0Fy7qqJhgRCkmEVpjwZZwTZ3shXzNlDUCRFc3Y2c6A6b4cry49Xz72qoXsdJHG8S4Bh
 f/c599NcHUldJXft099vIRNl+Bx/zO3Lo/pKgl3NZAqgtoojpT+D/JT/hU8SVZnYlrcK
 HmTQ==
X-Gm-Message-State: AOJu0YzJs3zL1rUEAtLzJF9upjHekSCDT7EaxvTQJAvChf2GygXbRi3A
 J25/lRlJloml10roJLSHRngCFPZJ/9dW8DqsiTtPIg5s+S5D23TAWe+nQ71ygcY=
X-Google-Smtp-Source: AGHT+IHTWhcGWpagqzMczeLPe7CN++3KDwEFQ4LEh5CrrZ9Tv+sJ55AVHZN+obOBtvgCUG8QJEsdGg==
X-Received: by 2002:adf:ef91:0:b0:337:d2c7:70c9 with SMTP id
 d17-20020adfef91000000b00337d2c770c9mr1218116wro.143.1705664501228; 
 Fri, 19 Jan 2024 03:41:41 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 b1-20020a5d4b81000000b0033920dfd287sm1245582wrt.19.2024.01.19.03.41.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jan 2024 03:41:40 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 92DFD5F8C8;
 Fri, 19 Jan 2024 11:41:40 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 qemu-arm@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 1/6] hw/arm/z2: convert DPRINTF to tracepoints
In-Reply-To: <021405f5ef53ebe80c7218e1df537635d34889b3.1705662313.git.manos.pitsidianakis@linaro.org>
 (Manos Pitsidianakis's message of "Fri, 19 Jan 2024 13:14:19 +0200")
References: <cover.1705662313.git.manos.pitsidianakis@linaro.org>
 <021405f5ef53ebe80c7218e1df537635d34889b3.1705662313.git.manos.pitsidianakis@linaro.org>
User-Agent: mu4e 1.11.27; emacs 29.1
Date: Fri, 19 Jan 2024 11:41:40 +0000
Message-ID: <87v87pft3f.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
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

Manos Pitsidianakis <manos.pitsidianakis@linaro.org> writes:

> Tracing DPRINTFs to stderr might not be desired. A developer that relies
> on tracepoints should be able to opt-in to each tracepoint and rely on
> QEMU's log redirection, instead of stderr by default.
>
> This commit converts DPRINTFs in this file that are used for tracing
> into tracepoints.
>
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>  hw/arm/trace-events |  8 ++++++++
>  hw/arm/z2.c         | 26 +++++++++-----------------
>  2 files changed, 17 insertions(+), 17 deletions(-)
>
> diff --git a/hw/arm/trace-events b/hw/arm/trace-events
> index cdc1ea06a8..a262ad2e6a 100644
> --- a/hw/arm/trace-events
> +++ b/hw/arm/trace-events
> @@ -55,3 +55,11 @@ smmuv3_notify_flag_add(const char *iommu) "ADD SMMUNot=
ifier node for iommu mr=3D%s
>  smmuv3_notify_flag_del(const char *iommu) "DEL SMMUNotifier node for iom=
mu mr=3D%s"
>  smmuv3_inv_notifiers_iova(const char *name, uint16_t asid, uint16_t vmid=
, uint64_t iova, uint8_t tg, uint64_t num_pages) "iommu mr=3D%s asid=3D%d v=
mid=3D%d iova=3D0x%"PRIx64" tg=3D%d num_pages=3D0x%"PRIx64
>=20=20
> +# z2.c
> +z2_lcd_cur_reg_update(uint8_t r) "reg: 0x%x"
> +z2_lcd_enable_disable(uint16_t v) "value: 0x%x"
> +z2_lcd_enable_disable_result(const char * result) "LCD %s"
> +z2_lcd_invalid_command(uint8_t value) "0x%x"
> +z2_aer915_send_too_log(int8_t msg) "message too long (%i bytes)"
> +z2_aer915_send(uint8_t reg, uint8_t value) "reg %d value 0x%02x"
> +z2_aer915_i2c_start_recv(uint16_t len) "I2C_START_RECV: short message wi=
th len %d"
> diff --git a/hw/arm/z2.c b/hw/arm/z2.c
> index 83741a4909..6c0889d698 100644
> --- a/hw/arm/z2.c
> +++ b/hw/arm/z2.c
> @@ -28,13 +28,7 @@
>  #include "cpu.h"
>  #include "qom/object.h"
>  #include "qapi/error.h"
> -
> -#ifdef DEBUG_Z2
> -#define DPRINTF(fmt, ...) \
> -        printf(fmt, ## __VA_ARGS__)
> -#else
> -#define DPRINTF(fmt, ...)
> -#endif
> +#include "trace.h"
>=20=20
>  static const struct keymap map[0x100] =3D {
>      [0 ... 0xff] =3D { -1, -1 },
> @@ -127,22 +121,22 @@ static uint32_t zipit_lcd_transfer(SSIPeripheral *d=
ev, uint32_t value)
>      if (z->pos =3D=3D 3) {

Maybe we could just have:

   trace_z2_lcd_reg_update(z->buf[0], z->buf[1], z->buf[2]);

here

>          switch (z->buf[0]) {
>          case 0x74:
> -            DPRINTF("%s: reg: 0x%.2x\n", __func__, z->buf[2]);
> +            trace_z2_lcd_cur_reg_update(z->buf[2]);

drop this

>              z->cur_reg =3D z->buf[2];
>              break;
>          case 0x76:
>              val =3D z->buf[1] << 8 | z->buf[2];
> -            DPRINTF("%s: value: 0x%.4x\n", __func__, val);
> +            trace_z2_lcd_enable_disable(val);

and this

>              if (z->cur_reg =3D=3D 0x22 && val =3D=3D 0x0000) {
>                  z->enabled =3D 1;
> -                printf("%s: LCD enabled\n", __func__);
> +                trace_z2_lcd_enable_disable_result("enabled");
>              } else if (z->cur_reg =3D=3D 0x10 && val =3D=3D 0x0000) {
>                  z->enabled =3D 0;
> -                printf("%s: LCD disabled\n", __func__);
> +                trace_z2_lcd_enable_disable_result("disabled");

and just have two trace points, one for enable and one for disable to
save spamming a string into the log.

>              }
>              break;
>          default:
> -            DPRINTF("%s: unknown command!\n", __func__);
> +            trace_z2_lcd_invalid_command(z->buf[0]);

drop this, it can be inferred if we trace the command stream above.

>              break;
>          }
>          z->pos =3D 0;
> @@ -212,14 +206,12 @@ static int aer915_send(I2CSlave *i2c, uint8_t data)
>=20=20
>      s->buf[s->len] =3D data;
>      if (s->len++ > 2) {
> -        DPRINTF("%s: message too long (%i bytes)\n",
> -            __func__, s->len);
> +        trace_z2_aer915_send_too_log(s->len);

long

>          return 1;
>      }
>=20=20
>      if (s->len =3D=3D 2) {
> -        DPRINTF("%s: reg %d value 0x%02x\n", __func__,
> -                s->buf[0], s->buf[1]);
> +        trace_z2_aer915_send(s->buf[0], s->buf[1]);
>      }
>=20=20
>      return 0;
> @@ -235,7 +227,7 @@ static int aer915_event(I2CSlave *i2c, enum i2c_event=
 event)
>          break;
>      case I2C_START_RECV:
>          if (s->len !=3D 1) {
> -            DPRINTF("%s: short message!?\n", __func__);
> +            trace_z2_aer915_i2c_start_recv(s->len);
>          }
>          break;
>      case I2C_FINISH:

maybe better just to have a:

  trace_aer915_event(event, s->len)

before the return?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

