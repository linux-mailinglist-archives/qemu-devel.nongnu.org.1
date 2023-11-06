Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA70E7E1A43
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 07:35:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qztCV-0008U9-2c; Mon, 06 Nov 2023 01:35:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qztCP-0008Sn-04
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 01:35:01 -0500
Received: from mail-qt1-x82d.google.com ([2607:f8b0:4864:20::82d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qztCL-0005jE-Q5
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 01:35:00 -0500
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-418201cb9e9so28316961cf.0
 for <qemu-devel@nongnu.org>; Sun, 05 Nov 2023 22:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699252496; x=1699857296; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fGpUp2UKUSvGL6EstICtpjvo6BfeSIzz8tXe6SxfjNQ=;
 b=jiSKxJ9t4lDBgiGBHqjRj5VcYY2MuY6T9U5EfkO85e5oB5hfPtx41OiKhql7uNi/cO
 9DbC2qSIb0RTBjHhHUqKqSkikr6dTZGOc7kkpduPNhd5NU9n022kjlKQDDQ2vvOqPM5V
 xMM8FUpqwR0Kuh29Ux2FbgduIAkZD1dLzSrQtRUySIB2XxGQwJ5grd0sn9e7iNzfYnol
 jvAyjOp2uhuM3GiCGUeqMKYf6A5EsQ8TR9/bCaPOjVUaBdTszGx8GMcqw4st/RouzF2a
 53+QQsjq3xJZO7Jnz68XR/IuzHS/sjHJbphBKUlpjdx1orV5/DQxjUFs6RgZWcmm/fRq
 Mhrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699252496; x=1699857296;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fGpUp2UKUSvGL6EstICtpjvo6BfeSIzz8tXe6SxfjNQ=;
 b=M3Ni6eYnt7M99SKfjH/+L42WRMuKcqi/zpplku8cSMZ2ACmjQ/ufQfCLdvaBke/NeU
 tTlTOou3brtTFg0k0AsfaGJCWCVihi2Vgf1wQArNE9/8vOHztAEAfQb/QtPefhiZjRmw
 ellmCYJ2gyVKkVC0Cqwr4vqrUBc25nIy2I2+DpFmVavl1pgTaRsI92WY2ZHC7uXh0MW8
 VQxorkrDhwPgtXYq8m/EO0YiNoRJoSbNdISw3ZqQLHf2RaSgb++62qJQ/6a8a2TdfXdH
 dU7HdRRn6rQjdmrF3np6ige/JYloyAeAJ8xlTSKNt2gW2ZImMmE7oRwS/i50LToX6Gz6
 gV+w==
X-Gm-Message-State: AOJu0YwW4fH0lEmXIV7ABswqUoFPmc2EQVEgGOAWYXPfEZ3Sbdz4+RMI
 3lxYndpL8iyPEIacpbJ5tgRxqznDEYM4QaA5DTM=
X-Google-Smtp-Source: AGHT+IF5FN9w+Tj3VzY095rG3wmtmd0EIV+NT7KmxXLNmKFYdeHyaPUjvsFE6JBRm+jj7YDmDKavTbHp2pwa4Il+mX8=
X-Received: by 2002:a05:622a:3:b0:41c:cd2a:f066 with SMTP id
 x3-20020a05622a000300b0041ccd2af066mr36744512qtw.34.1699252496388; Sun, 05
 Nov 2023 22:34:56 -0800 (PST)
MIME-Version: 1.0
References: <6f8b1f96-4520-49d5-8a09-b2935ab4bd9d@t-online.de>
 <20231105172552.8405-1-vr_qemu@t-online.de>
In-Reply-To: <20231105172552.8405-1-vr_qemu@t-online.de>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 6 Nov 2023 10:34:45 +0400
Message-ID: <CAJ+F1CKjY0V_qZ6cjxLVCpM2PcCtKpGGB+jH8jB4Skh5WmbnXA@mail.gmail.com>
Subject: Re: [PATCH 1/2] hw/audio/hda-codec: fix multiplication overflow
To: =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, M_O_Bz <M_O_Bz@163.com>, linwei6@ruijie.com.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82d;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Sun, Nov 5, 2023 at 9:26=E2=80=AFPM Volker R=C3=BCmelin <vr_qemu@t-onlin=
e.de> wrote:
>
> After a relatively short time, there is an multiplication overflow
> when multiplying (now - buft_start) with hda_bytes_per_second().
> While the uptime now - buft_start only overflows after 2**63 ns
> =3D 292.27 years, this happens hda_bytes_per_second() times faster
> with the multiplication. At 44100 samples/s * 2 channels
> * 2 bytes/channel =3D 176400 bytes/s that is 14.52 hours. After the
> multiplication overflow the affected audio stream stalls.
>
> Replace the multiplication and following division with muldiv64()
> to prevent a multiplication overflow.
>
> Fixes: 280c1e1cdb ("audio/hda: create millisecond timers that handle IO")
> Reported-by: M_O_Bz <m_o_bz@163.com>
> Signed-off-by: Volker R=C3=BCmelin <vr_qemu@t-online.de>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  hw/audio/hda-codec.c | 29 +++++++++++++++++++++--------
>  1 file changed, 21 insertions(+), 8 deletions(-)
>
> diff --git a/hw/audio/hda-codec.c b/hw/audio/hda-codec.c
> index b9ad1f4c39..f756e419bb 100644
> --- a/hw/audio/hda-codec.c
> +++ b/hw/audio/hda-codec.c
> @@ -22,6 +22,7 @@
>  #include "hw/qdev-properties.h"
>  #include "intel-hda.h"
>  #include "migration/vmstate.h"
> +#include "qemu/host-utils.h"
>  #include "qemu/module.h"
>  #include "intel-hda-defs.h"
>  #include "audio/audio.h"
> @@ -189,9 +190,9 @@ struct HDAAudioState {
>      bool     use_timer;
>  };
>
> -static inline int64_t hda_bytes_per_second(HDAAudioStream *st)
> +static inline uint32_t hda_bytes_per_second(HDAAudioStream *st)
>  {
> -    return 2LL * st->as.nchannels * st->as.freq;
> +    return 2 * (uint32_t)st->as.nchannels * (uint32_t)st->as.freq;
>  }
>
>  static inline void hda_timer_sync_adjust(HDAAudioStream *st, int64_t tar=
get_pos)
> @@ -222,12 +223,18 @@ static void hda_audio_input_timer(void *opaque)
>
>      int64_t now =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
>
> -    int64_t buft_start =3D st->buft_start;
> +    int64_t uptime =3D now - st->buft_start;
>      int64_t wpos =3D st->wpos;
>      int64_t rpos =3D st->rpos;
> +    int64_t wanted_rpos;
>
> -    int64_t wanted_rpos =3D hda_bytes_per_second(st) * (now - buft_start=
)
> -                          / NANOSECONDS_PER_SECOND;
> +    if (uptime <=3D 0) {
> +        /* wanted_rpos <=3D 0 */
> +        goto out_timer;
> +    }
> +
> +    wanted_rpos =3D muldiv64(uptime, hda_bytes_per_second(st),
> +                           NANOSECONDS_PER_SECOND);
>      wanted_rpos &=3D -4; /* IMPORTANT! clip to frames */
>
>      if (wanted_rpos <=3D rpos) {
> @@ -286,12 +293,18 @@ static void hda_audio_output_timer(void *opaque)
>
>      int64_t now =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
>
> -    int64_t buft_start =3D st->buft_start;
> +    int64_t uptime =3D now - st->buft_start;
>      int64_t wpos =3D st->wpos;
>      int64_t rpos =3D st->rpos;
> +    int64_t wanted_wpos;
> +
> +    if (uptime <=3D 0) {
> +        /* wanted_wpos <=3D 0 */
> +        goto out_timer;
> +    }
>
> -    int64_t wanted_wpos =3D hda_bytes_per_second(st) * (now - buft_start=
)
> -                          / NANOSECONDS_PER_SECOND;
> +    wanted_wpos =3D muldiv64(uptime, hda_bytes_per_second(st),
> +                           NANOSECONDS_PER_SECOND);
>      wanted_wpos &=3D -4; /* IMPORTANT! clip to frames */
>
>      if (wanted_wpos <=3D wpos) {
> --
> 2.35.3
>
>


--=20
Marc-Andr=C3=A9 Lureau

