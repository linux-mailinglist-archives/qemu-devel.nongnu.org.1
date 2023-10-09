Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB0F7BD8EE
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 12:47:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpnmS-0001zV-CE; Mon, 09 Oct 2023 06:46:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qpnmQ-0001zG-K3
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 06:46:30 -0400
Received: from mail-qt1-x82c.google.com ([2607:f8b0:4864:20::82c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qpnmN-0000Hh-Rr
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 06:46:30 -0400
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-419628fb297so27211801cf.1
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 03:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696848386; x=1697453186; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T/RDb+PJzO4WFOyHv3KfkPgGEpGcD6jSC0jA9WB0gm0=;
 b=EQUDMJv1g4wMyJerJHFfUCfw4o4/9Utut0EfYDOHQXWZM4gmABqm+gVAYi291hXpal
 AUJ8X0CHhCxfTOeCICyoF3mlDXiknAU0rOrAn26zjjgmeB4qzKaqmLpWhTxV0S8fpJwr
 HtiGgXp8CHxgfR7dHd8lvCGrFwwz97+m1d5j+dJ5NgF9v9igL4y/cZJgR0NMPZPkx5En
 CXaErBbQxkQ+pjsp/3V+J3/41V1kEw+Z8lZscGStuH3jH2nXoNv3aDz+d/hO36iMeuyf
 X+NTBP1VmvNxUCtto9s9YOsAKJpb8gFbaMdFHePvLfv/OKNZ3pEXucISEmxlA60ByxZi
 kpJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696848386; x=1697453186;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T/RDb+PJzO4WFOyHv3KfkPgGEpGcD6jSC0jA9WB0gm0=;
 b=MQbVW9WRvCI7Mn0My/bS+sjB3CBOx3WoK6gYB9M0J2QFJyG+VVcRelf02VZ8YSMotv
 XapXCHZYDmxeKAkAUvrqz4In8RPeCbh4D938vuSUDqJUEdaSqnTUh6brTwR8gAJJXt3x
 KZpnlMhlDZ40u8HS1EljeWJwn1IdyvlRRk6+k59ZB1C6/CXXMAuv7pw3LP7mv3wcrY4I
 E5l401M8XGesIeRlkouqMV6Hc0lR97r6fCpo10IOtbJkBIRy3Nnm9kqnVG6Az35kkPYP
 ML/DJOHVe/c/RNBICWp5/k3r7Eup0AMqOMCtGUFe8Nqu48Fe+5fQ++ZTnXdCfg5nohtZ
 E3eA==
X-Gm-Message-State: AOJu0YyTHFQ7/8dQDbicNPknrlit5cE0i2PQjLTrzR1uFZNLPzs9Oxiq
 rn+Xmkimx2UmiReag77z1bSynbcvKHFkYDGGdBc=
X-Google-Smtp-Source: AGHT+IHiATBAVl/rGGtDV31sIWeMFl4RuknoRPMr1Mgnv/2UE1K24lFb5juJMiIYQUPs1Y5ClWoziRotMeYkHH5Nl7s=
X-Received: by 2002:a05:622a:156:b0:413:5dbd:a926 with SMTP id
 v22-20020a05622a015600b004135dbda926mr20375890qtw.2.1696848386207; Mon, 09
 Oct 2023 03:46:26 -0700 (PDT)
MIME-Version: 1.0
References: <20231005125815.66082-1-pbonzini@redhat.com>
In-Reply-To: <20231005125815.66082-1-pbonzini@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 9 Oct 2023 14:46:14 +0400
Message-ID: <CAJ+F1C+39sVV+LoTE-F_-_q8GZ7q0PNvPaOMxJAUjGTH9NwPkg@mail.gmail.com>
Subject: Re: [PATCH 0/7] audio: redo default audio backend creation
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, balaton@eik.bme.hu, berrange@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82c;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Thu, Oct 5, 2023 at 5:01=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com> =
wrote:
>
> Currently, AUD_register_card picks the audio backend from either:
>
> - the first audiodev that was created
>
> - the audio_prio_list[] array, which can be customized at
>   configure time
>
> This series instead extends -audio to define a default audio
> backend if no "model" is used.  This preserves simple command line
> use where a single "-audio" option applies to all audio devices
> and captures, and also uses a single QAPI-based configuration
> syntax for both -audio and -audiodev.
>
> The current hack to use the first -audiodev as a default audio
> device is removed.  For migration purposes, the first audiodev
> is suggested in case of an error:
>
>   ./qemu-system-x86_64 -device sb16 -audiodev pa,id=3Ddefault
>   qemu-system-x86_64: -device sb16: no default audio driver available
>   Perhaps you wanted to set audiodev=3Ddefault?
>
> VNC is changed to reintroduce use of the default audio backend;
> still, compared to before the cleanup effort this will not be
> enabled if -nodefaults is use, which is an improvement as it
> removes magic.
>
> Paolo
>
>
> Paolo Bonzini (7):
>   audio: error hints need a trailing \n
>   audio: disable default backends if -audio/-audiodev is used
>   audio: extract audio_define_default
>   audio: extend -audio to allow creating a default backend
>   audio: do not use first -audiodev as default audio device
>   audio: reintroduce default audio backend for VNC
>   audio, qtest: get rid of QEMU_AUDIO_DRV
>

Series:
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

>  audio/audio.c                   | 85 +++++++++++++--------------------
>  audio/audio.h                   |  3 ++
>  docs/about/deprecated.rst       |  6 ---
>  docs/about/removed-features.rst | 14 ++++--
>  qemu-options.hx                 | 29 +++++++----
>  system/vl.c                     | 34 ++++++++-----
>  tests/qtest/libqtest.c          |  4 +-
>  ui/vnc.c                        |  2 +
>  8 files changed, 93 insertions(+), 84 deletions(-)
>
> --
> 2.41.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

