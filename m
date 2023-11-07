Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 204117E3916
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 11:27:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0JIU-0004nq-QH; Tue, 07 Nov 2023 05:27:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1r0JIS-0004lL-M4
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:27:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1r0JIQ-0005xj-TR
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:27:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699352817;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=32iHXOL2b+FyuXabWgmM/gZnmzR6vBSoNDBPdYmW/Kk=;
 b=N+vPPsVGt9MQReaGOqS3WwXcW6WVUMTro4CCs82ZRBJSDRoaNtvTEXLQ4gAt2KKYAP+n8I
 WAGMv2QZK5WI0FkVPoRteJUEtmgJwPvxqBJnUHEuW4L1v5PyXvx4ux9Q4pFhVZhBjv8dNz
 I8QVkx8IXSvpmWX4/ke5Wuhvn7PzPbc=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-nkGSCcw6PFm2Wp7eFC7xZw-1; Tue, 07 Nov 2023 05:26:50 -0500
X-MC-Unique: nkGSCcw6PFm2Wp7eFC7xZw-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-543d2bc7d9dso4196022a12.1
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 02:26:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699352808; x=1699957608;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=32iHXOL2b+FyuXabWgmM/gZnmzR6vBSoNDBPdYmW/Kk=;
 b=sLsIfw1zL89cutHjSwQfCdK8jhhDEy4Iio/VYN5fTTfjqJmRJzAmP9wZ7aShZ50obU
 +EOMl1LDpq87Wk3BC9KQZZHOobaSoc9gO/urZSNn6IUCo4tp1VBbFX7WlGeVES1ewY49
 JmrKE61xoWw6NBTK6mU6Ff62g1slUk1eQFyr08xsUjanxPDTHUDZ08hJIidkXZJFds97
 6qpurxsVf9S8UCWkHYWCxNYXnVcEIygb3B7UyxI+aR6RZfJHFKLE4O2se96WiF05z7pR
 IUVMNtNH/D1dK6wNESqe60qWXrREMPlZ34JfLt8MvgOaBjHWDzgDEF995fENdmTGM9Zw
 0DDA==
X-Gm-Message-State: AOJu0YyxdWviSUYjn9pqtc+AdZaJS4ngxUZALq25Y4z348zJDR4zrzb6
 BniKNGGDdmaYIYhePgVmT4HGjxXQyNNlfmpe67PK2bPZCx0sPUlyQUzMh8pcGCS5utgnNwxvGEW
 2zoWimR/g1+fCZOsh8gPy+u/M+Fu/53aF4AceuwWf7Q==
X-Received: by 2002:a50:cd1c:0:b0:543:bd27:f4a9 with SMTP id
 z28-20020a50cd1c000000b00543bd27f4a9mr14258240edi.12.1699352808579; 
 Tue, 07 Nov 2023 02:26:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGwa1/KgR94ClxJUx4fzhETCdbNciEWZeA+bw4R8UYNgumRlozG4v/ZLaQEOzvIKyu4ppvYjoZwQi9PRYnYjNM=
X-Received: by 2002:a50:cd1c:0:b0:543:bd27:f4a9 with SMTP id
 z28-20020a50cd1c000000b00543bd27f4a9mr14258232edi.12.1699352808310; Tue, 07
 Nov 2023 02:26:48 -0800 (PST)
MIME-Version: 1.0
References: <20231107101524.2993389-1-marcandre.lureau@redhat.com>
In-Reply-To: <20231107101524.2993389-1-marcandre.lureau@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 7 Nov 2023 14:26:36 +0400
Message-ID: <CAMxuvaxqMK3nzJ=aQjTgoGf8tnvMkQayxCsHYpmymxX15ZwtMg@mail.gmail.com>
Subject: Re: [PULL v3 00/25] Pixman patches
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi Stefan

On Tue, Nov 7, 2023 at 2:16=E2=80=AFPM <marcandre.lureau@redhat.com> wrote:
>
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> The following changes since commit bb541a7068d2eee51a9abbe2dedcdf27298b18=
72:
>
>   Merge tag 'pull-pa-20231106' of https://gitlab.com/rth7680/qemu into st=
aging (2023-11-07 15:01:17 +0800)
>
> are available in the Git repository at:
>
>   https://gitlab.com/marcandre.lureau/qemu.git tags/pixman-pull-request
>
> for you to fetch changes up to d017f28a2ee082f472ed69fedf0435b468000e92:
>
>   build-sys: make pixman actually optional (2023-11-07 14:04:25 +0400)
>
> ----------------------------------------------------------------
> Make Pixman an optional dependency
>
> ----------------------------------------------------------------
>
> Marc-Andr=C3=A9 Lureau (25):
>   build-sys: add a "pixman" feature
>   build-sys: drop needless warning pragmas for old pixman
>   ui: compile out some qemu-pixman functions when !PIXMAN
>   ui: add pixman-minimal.h
>   vl: drop needless -spice checks
>   qemu-options: define -vnc only #ifdef CONFIG_VNC
>   vl: simplify display_remote logic
>   vl: move display early init before default devices
>   ui/console: allow to override the default VC
>   ui/vc: console-vc requires PIXMAN
>   qmp/hmp: disable screendump if PIXMAN is missing
>   virtio-gpu: replace PIXMAN for region/rect test
>   ui/console: when PIXMAN is unavailable, don't draw placeholder msg
>   vhost-user-gpu: skip VHOST_USER_GPU_UPDATE when !PIXMAN
>   ui/gl: opengl doesn't require PIXMAN
>   ui/vnc: VNC requires PIXMAN
>   ui/spice: SPICE/QXL requires PIXMAN
>   ui/gtk: -display gtk requires PIXMAN
>   ui/dbus: do not require PIXMAN
>   arm/kconfig: XLNX_ZYNQMP_ARM depends on PIXMAN
>   hw/arm: XLNX_VERSAL depends on XLNX_CSU_DMA
>   hw/sm501: allow compiling without PIXMAN
>   hw/mips: FULOONG depends on VT82C686
>   hw/display/ati: allow compiling without PIXMAN

There is a kind of false-positive with check-patch here:
86: ERROR: suspect code indent for conditional statements (8, 8)

I think we can agree to ignore. thanks

>   build-sys: make pixman actually optional
>
>  meson.build                   |  25 ++++-
>  qapi/ui.json                  |   3 +-
>  include/ui/console.h          |   2 +
>  include/ui/pixman-minimal.h   | 195 ++++++++++++++++++++++++++++++++++
>  include/ui/qemu-pixman.h      |  15 +--
>  include/ui/rect.h             |  59 ++++++++++
>  hw/display/ati.c              |  15 ++-
>  hw/display/ati_2d.c           |  10 +-
>  hw/display/sm501.c            |  45 +++++---
>  hw/display/vhost-user-gpu.c   |   2 +
>  hw/display/virtio-gpu.c       |  30 ++----
>  system/vl.c                   |  84 ++++++++-------
>  ui/console-vc-stubs.c         |  33 ++++++
>  ui/console.c                  |  19 ++++
>  ui/dbus-listener.c            |  90 +++++++++++-----
>  ui/qemu-pixman.c              |   6 ++
>  ui/ui-hmp-cmds.c              |   2 +
>  ui/ui-qmp-cmds.c              |   2 +
>  ui/vnc-stubs.c                |  12 ---
>  Kconfig.host                  |   3 +
>  hmp-commands.hx               |   2 +
>  hw/arm/Kconfig                |   4 +-
>  hw/display/Kconfig            |   7 +-
>  hw/display/meson.build        |   4 +-
>  hw/mips/Kconfig               |   1 +
>  meson_options.txt             |   2 +
>  qemu-options.hx               |   2 +
>  scripts/meson-buildoptions.sh |   3 +
>  ui/meson.build                |  22 ++--
>  29 files changed, 560 insertions(+), 139 deletions(-)
>  create mode 100644 include/ui/pixman-minimal.h
>  create mode 100644 include/ui/rect.h
>  create mode 100644 ui/console-vc-stubs.c
>
> --
> 2.41.0
>


