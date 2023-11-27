Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C98537F9B4D
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 09:07:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7Wd5-0002aL-8u; Mon, 27 Nov 2023 03:06:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1r7Wd3-0002aA-BW
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 03:06:05 -0500
Received: from mail-qk1-x730.google.com ([2607:f8b0:4864:20::730])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1r7Wd1-0000Ye-UN
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 03:06:05 -0500
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-77d55e986ecso205893885a.2
 for <qemu-devel@nongnu.org>; Mon, 27 Nov 2023 00:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701072362; x=1701677162; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VMMij5pIH+nenk+kREWqVM6i6EYUmF3C0w/Nqk0xE8w=;
 b=i9VtrA0ZZym4Ss0HLdwxKp8ctUzje4K/TKbAlzRUwKFixJLgNQSB62VGINU+XRK/1z
 UtyingI8iwZXjIj4WsxzuT49VqiLZk32NiQGksmOzfcWdAiyTS6TcBfUzZOET2OqTaol
 ZIfYdNzzPTJYIGgSORSX2fB+x/PYE8c1j1rgOnXmEhUalvNXnqnxcQGVdmDAbBWgJQH8
 cVzjFVu9kehQSDMVdRQe6ldn8BLbP7wQY6uwwWSqdlHxA+QjVlpAXpKEN9yBrsOydlef
 m1/qbAVEEmQsUFtbHHJak1+CI4SB1uxu1t66go2FpannAXd02EzFy7GU11VU099/bZ71
 kTKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701072362; x=1701677162;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VMMij5pIH+nenk+kREWqVM6i6EYUmF3C0w/Nqk0xE8w=;
 b=r3qN5T5EsP3Dqsxf4bAY4VfNyDhHh1rZnLll1wia0PvIAsZ2ON+b9c87Dg2utBTfuZ
 LXNB9mgQtCdNuSMCTG8KEVXBAmtdjxmmQRRPGQtuXEZN4sgFnl7ighJzi1RUcND/3xev
 +ta8JsA9X7EEIMiq6hZT4BgzIINw/EX0TYigXa522EMMbTXsVulpGi0scmEKsOEoMbwD
 kdN/WCrJJI87gC114p3tI4ifGjppOqB7h2b4tgA73Wc7eE0N8OR3L8PkxWss+mt7o1L4
 NP/xLAwjRCf5YpFelF1YIEndU6w8CjQsmVh0uAOIynqu6GdWw9W3StG9hBwJe0I6ifTk
 T2GQ==
X-Gm-Message-State: AOJu0YwymJ9+bx1vU1ATzTZXDWLPCYvmlMRBid1J5HNlEBUyDx5ZiJYl
 +eoIdwhL6ll6hRi8S0z+ipNP0pOnF0EZBGqDvYQ=
X-Google-Smtp-Source: AGHT+IF8iliC8bYg0Vm3zIyDPjhG98PI3DwnjUheVvqZzWwyRQAgfWA+v+RTGQi4nNg6ARFhZi3K/UN9tOXv7B6VrQA=
X-Received: by 2002:ac8:7143:0:b0:423:a7e4:afa4 with SMTP id
 h3-20020ac87143000000b00423a7e4afa4mr5082181qtp.48.1701072362125; Mon, 27 Nov
 2023 00:06:02 -0800 (PST)
MIME-Version: 1.0
References: <20231125075408.131075-1-a_lijiejun@163.com>
In-Reply-To: <20231125075408.131075-1-a_lijiejun@163.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 27 Nov 2023 12:05:50 +0400
Message-ID: <CAJ+F1C+Vntsy0sEF2em2xA=BG-FiOqEOqJHO_2AGfye4RZip5Q@mail.gmail.com>
Subject: Re: [PATCH] ui: Optimization dirty rect empty check logic
To: lijiejun <a_lijiejun@163.com>
Cc: kraxel@redhat.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::730;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qk1-x730.google.com
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

Hi

On Sat, Nov 25, 2023 at 11:55=E2=80=AFAM lijiejun <a_lijiejun@163.com> wrot=
e:
>
> Reduce unnecessary code execution in function qemu_spice_create_update,
> such as "int blocks =3D DIV_ROUND_UP(surface_width(ssd->ds), blksize);"
> and "int bpp =3D surface_bytes_per_pixel(ssd->ds);".
>
> Signed-off-by: lijiejun <a_lijiejun@163.com>

This is a micro-optimization which makes the
qemu_spice_create_update() less complete, mixing caller/callee
responsibilities.

> ---
>  ui/spice-display.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/ui/spice-display.c b/ui/spice-display.c
> index 6eb98a5a5c..508e35ed0f 100644
> --- a/ui/spice-display.c
> +++ b/ui/spice-display.c
> @@ -194,10 +194,6 @@ static void qemu_spice_create_update(SimpleSpiceDisp=
lay *ssd)
>      int bpp =3D surface_bytes_per_pixel(ssd->ds);
>      uint8_t *guest, *mirror;
>
> -    if (qemu_spice_rect_is_empty(&ssd->dirty)) {
> -        return;
> -    };
> -
>      dirty_top =3D g_new(int, blocks);
>      for (blk =3D 0; blk < blocks; blk++) {
>          dirty_top[blk] =3D -1;
> @@ -488,7 +484,9 @@ void qemu_spice_display_refresh(SimpleSpiceDisplay *s=
sd)
>
>      WITH_QEMU_LOCK_GUARD(&ssd->lock) {
>          if (QTAILQ_EMPTY(&ssd->updates) && ssd->ds) {
> -            qemu_spice_create_update(ssd);
> +            if (!qemu_spice_rect_is_empty(&ssd->dirty)) {
> +                qemu_spice_create_update(ssd);
> +            }
>              ssd->notify++;
>          }
>      }
> --
> 2.25.1
>
>


--=20
Marc-Andr=C3=A9 Lureau

