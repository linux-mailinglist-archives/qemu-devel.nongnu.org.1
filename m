Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9302E7E1D78
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 10:51:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzwFs-000541-ST; Mon, 06 Nov 2023 04:50:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qzwFp-00053o-Ml
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 04:50:45 -0500
Received: from mail-qt1-x82f.google.com ([2607:f8b0:4864:20::82f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qzwFn-0007Df-Tu
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 04:50:45 -0500
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-41cc44736f2so29896371cf.3
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 01:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699264242; x=1699869042; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aaENb0Qr9KmT8yQmAHRAZ9yQXHsqpHSqbIMVCZyrCL4=;
 b=RHDebSii5mPv6PojHeUOHx71VF2i+Acfx2hQHzV466HM9UHRTEGMu3W1jMtO6ZmrxM
 XBiVJnUN+WsEVbpuRx18nIegl8rp/OxPOw0rZpWf/Y82A5RKwSipHiPU/2VvAnc95TqZ
 aPdtplw61J+ugK3SabLXfTWpfOtgnKn8jMa0a5+UXirQlhZPoDF/wP4A+MhuzY6qSmnC
 a4uOCu/amptK1d3L9H8FoER4JnJmS6jhkY43j/a4seK4kje7+IfoKj5XocpPXYsteXl1
 ILH+SgAhy44ugh8L7B38p9GwlVhx5IFN7fKNkEVjqEVkfz/bpWKA9fmBc0bHY6Xo0bvS
 BgUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699264242; x=1699869042;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aaENb0Qr9KmT8yQmAHRAZ9yQXHsqpHSqbIMVCZyrCL4=;
 b=D5jWtsal+jKgX/UwasH1ooYteTvFFRcVMVEwH6k/WtQ+iQDd+C2wM2YsNZ6p1JsK7L
 YwKdCg3QIt2ynTm+9vQunT/W3UHDlGEIWiANGeKoIlwPAdYHvjYXiKCmXB4ql/waYy/n
 +d/vh9K0uRl056TBPGn5tsUj8/VSkTM8dlrnZ7JkPgM3WfpjoTsCEELC3Sg8IzpOI1v/
 K44YlwEuqGH1R4nVBhap+o1W3gVZy+6lGIZV50qL7jAyRDOBXwsIi3C1JoGgKnlxnXbB
 IfhvqFoy7E29Rf1t0/ABndY1Zaf90mGJ5SJ0mQpoe9aUpQ7m6PoV+KWHy3X6DQYNSOev
 vYTQ==
X-Gm-Message-State: AOJu0Yzasv7eS20+a/ksr76KWQSarATEzxWcX7FDMzcn3KeXPexMzbAn
 1x5FNbSZkWnXSPC+ggJDrHctiBcIys0AK2NkPUkjdm8hGIvYxw==
X-Google-Smtp-Source: AGHT+IFhIqESOkALrzw41mFZIXjvTy3qTffUkaFmiVFgG36DudvFrxtU83u34lcySbpynCTAljmqIxarenh42bqPXi8=
X-Received: by 2002:a05:622a:18a:b0:41c:c5bd:712 with SMTP id
 s10-20020a05622a018a00b0041cc5bd0712mr33692650qtw.62.1699264242560; Mon, 06
 Nov 2023 01:50:42 -0800 (PST)
MIME-Version: 1.0
References: <20231106072313.1742543-1-marcandre.lureau@redhat.com>
In-Reply-To: <20231106072313.1742543-1-marcandre.lureau@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 6 Nov 2023 13:50:31 +0400
Message-ID: <CAJ+F1C+-L1R713Q2ptCxwNkaNf8SFOJsW3QcRX=LaHwsvjoU8g@mail.gmail.com>
Subject: Re: [PULL 00/23] Pixman patches
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82f;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82f.google.com
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

On Mon, Nov 6, 2023 at 11:24=E2=80=AFAM <marcandre.lureau@redhat.com> wrote=
:
>
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> The following changes since commit d762bf97931b58839316b68a570eecc6143c9e=
3e:
>
>   Merge tag 'pull-target-arm-20231102' of https://git.linaro.org/people/p=
maydell/qemu-arm into staging (2023-11-03 10:04:12 +0800)
>
> are available in the Git repository at:
>
>   https://gitlab.com/marcandre.lureau/qemu.git tags/pixman-pull-request
>
> for you to fetch changes up to 3055379992496c8ff6a02d46dcc5a1337be72499:
>
>   build-sys: make pixman actually optional (2023-11-06 10:25:05 +0400)
>
> ----------------------------------------------------------------
> Make Pixman an optional dependency
>
> ----------------------------------------------------------------
>
> Marc-Andr=C3=A9 Lureau (23):
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
>   hw/sm501: allow compiling without PIXMAN
>   hw/display: make ATI_VGA depend on PIXMAN
>   build-sys: make pixman actually optional
>
>  configs/devices/mips64el-softmmu/default.mak |   3 +-
>  meson.build                                  |  25 ++-
>  qapi/ui.json                                 |   3 +-
>  include/ui/console.h                         |   2 +
>  include/ui/pixman-minimal.h                  | 195 +++++++++++++++++++
>  include/ui/qemu-pixman.h                     |  15 +-
>  include/ui/rect.h                            |  59 ++++++
>  hw/display/sm501.c                           |  46 +++--
>  hw/display/vhost-user-gpu.c                  |   2 +
>  hw/display/virtio-gpu.c                      |  30 ++-
>  system/vl.c                                  |  84 ++++----
>  ui/console-vc-stubs.c                        |  33 ++++
>  ui/console.c                                 |  19 ++
>  ui/dbus-listener.c                           |  90 ++++++---
>  ui/qemu-pixman.c                             |   6 +
>  ui/ui-hmp-cmds.c                             |   2 +
>  ui/ui-qmp-cmds.c                             |   2 +
>  ui/vnc-stubs.c                               |  12 --
>  Kconfig.host                                 |   3 +
>  hmp-commands.hx                              |   2 +
>  hw/arm/Kconfig                               |   3 +-
>  hw/display/Kconfig                           |  10 +-
>  hw/display/meson.build                       |   4 +-
>  hw/mips/Kconfig                              |   2 +
>  meson_options.txt                            |   2 +
>  qemu-options.hx                              |   2 +
>  scripts/meson-buildoptions.sh                |   3 +
>  ui/meson.build                               |  22 +--
>  28 files changed, 542 insertions(+), 139 deletions(-)
>  create mode 100644 include/ui/pixman-minimal.h
>  create mode 100644 include/ui/rect.h
>  create mode 100644 ui/console-vc-stubs.c
>
> --
> 2.41.0
>

I realize a bit late that it also requires this, for some reason:

diff --git a/hw/mips/Kconfig b/hw/mips/Kconfig
index 5d40795c0b..c120b784aa 100644
--- a/hw/mips/Kconfig
+++ b/hw/mips/Kconfig
@@ -34,6 +34,7 @@ config FULOONG
     bool
     default y if MIPS64
     select PCI_BONITO
+    select VT82C686
     depends on ATI_VGA

sending V2


--=20
Marc-Andr=C3=A9 Lureau

