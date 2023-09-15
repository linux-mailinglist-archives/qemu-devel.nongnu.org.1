Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D25E7A1DB2
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 13:51:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qh7Li-00089C-Nr; Fri, 15 Sep 2023 07:51:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qh7Lg-000893-O6
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 07:51:00 -0400
Received: from mail-vk1-xa33.google.com ([2607:f8b0:4864:20::a33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qh7Lf-0004xs-A7
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 07:51:00 -0400
Received: by mail-vk1-xa33.google.com with SMTP id
 71dfb90a1353d-49351972cbeso791185e0c.2
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 04:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1694778658; x=1695383458; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=95Ng1IcNuDeQNh7n2sJMr+hIu95Vjo8RneQa2dox0gk=;
 b=motHNLyzeaG6w74oTI6PvefKhnuumC3Gvw7mY5pvOEcBnm4q9JUYJHi4n3C1ZOZu3i
 77C5wbpg28p61RE/esOX3mP9occnItOTSlQq9o/JEgGLqubY1CdLOqcPtj1KlovVVJqw
 ua8rt5XVo1Aj9rnIyKXrziIyaMw4yuqR7Kp0l0Gi7mtyG1UqBYYe/Mb8b6MaSibtdSLI
 EfrBfxY0cqzzOizHWkQ8QvA3mezShwj7HIUDKDLIIGDvBRWFRJCp5DJsa+eW/ijS801C
 8gguIH0BGuQc/h1XgGB2ogARKEEIw467QxD3bxLdfShZnO8ECK7snmw7WVfKzGhg/QCd
 Rdag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694778658; x=1695383458;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=95Ng1IcNuDeQNh7n2sJMr+hIu95Vjo8RneQa2dox0gk=;
 b=mDMD+K8sx5K9oFr2W3iowbOexgOUZ/B+O0C5TbztPyAtc3VR8U4jgJpfI+un1PnO0S
 N62h/xfj3+uF6+N41bhlXWQtl8bStvCYX2fTeiLikp3UjJvBf+VSJGx7ykHsYVSOJIdm
 e8ZRaFXN29qVhTd7EmJRMtHEsyXOXGjiRbFTQA3VL7t/I8EKm+SaPJcHvvAMuyOW6gDQ
 B5Y6ubly0ppXKBDF+GI31XRSN/wDorQDlT3YbHo6Y1DKLXjnIXapNl6gJ2+a3W0ZupMw
 +keuPU1RTheXzYFyiyJUtZRGYR3qLOKgis+jEONQ6wZjz1oAe232ynMW0BNsSNSadzxj
 +zkg==
X-Gm-Message-State: AOJu0YzeetqR4wqpi79qWVfseChE4z/ke7szXz75yvgCspq/o0kqwqYK
 NtvlmSHklOZ4Z+P072PVDnK/LcwHnxdQIuBKfVo=
X-Google-Smtp-Source: AGHT+IERcZxgzoA3jP7BjsbdA8qi3vk8dQ2f6u2FRbP+XkF2FCFMq7PaEP8u3glzbmEHsJPCf97H6zwmnJyIYBfd6AM=
X-Received: by 2002:a1f:4841:0:b0:495:c464:a2fe with SMTP id
 v62-20020a1f4841000000b00495c464a2femr1392590vka.2.1694778658112; Fri, 15 Sep
 2023 04:50:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230913144959.41891-1-lersek@redhat.com>
In-Reply-To: <20230913144959.41891-1-lersek@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 15 Sep 2023 15:50:47 +0400
Message-ID: <CAJ+F1CJfROA9ezKi6Tzs1hLun8jpnWhrQCjreQdWhGro97CAyA@mail.gmail.com>
Subject: Re: [PATCH 0/4] ui/console: multihead: fix crash, simplify logic
To: Laszlo Ersek <lersek@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a33;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-vk1-xa33.google.com
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

Hi Laszlo

On Wed, Sep 13, 2023 at 6:50=E2=80=AFPM Laszlo Ersek <lersek@redhat.com> wr=
ote:
>
> Fix a recent regression (crash) in the multihead check; clean up the
> code some more.
>
> Cc: "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@redhat.com> (odd fixer:Gra=
phics)
> Cc: Gerd Hoffmann <kraxel@redhat.com> (odd fixer:Graphics)
>
> Thanks,
> Laszlo
>
> Laszlo Ersek (4):
>   ui/console: make qemu_console_is_multihead() static
>   ui/console: only walk QemuGraphicConsoles in
>     qemu_console_is_multihead()
>   ui/console: eliminate QOM properties from qemu_console_is_multihead()
>   ui/console: sanitize search in qemu_graphic_console_is_multihead()

Series:
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

thanks

>
>  include/ui/console.h |  1 -
>  ui/console.c         | 24 +++++++++-----------
>  2 files changed, 11 insertions(+), 14 deletions(-)
>


--=20
Marc-Andr=C3=A9 Lureau

