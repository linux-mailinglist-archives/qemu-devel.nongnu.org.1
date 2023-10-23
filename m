Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EB12F7D3440
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 13:37:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qutDP-0006h2-LH; Mon, 23 Oct 2023 07:35:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qutD6-0006cJ-Ik
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 07:35:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qutD4-0004F7-Kv
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 07:35:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698060901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n/q/NO/pRi9jMkrVRFBS0odAr+jRA/bi/yczeynV3uU=;
 b=RYlUVhZRcIpWPUo0kpKxdkT1DngH3DuW/wHUGvA6n7YWenvnGTwfHKY/F0gkQPQYuWqviE
 omycfcau0XO/PEFWnTIYWeEP6vW3sTjVcLrxKdzem4ejd7eCkQUFvzPXxCc3ygZdsqkx/P
 dzMLeEM2F9aWBS+mUe4kkgS0CaWIBnc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-bY26DCeLMMmrcIHi1ToCYg-1; Mon, 23 Oct 2023 07:34:54 -0400
X-MC-Unique: bY26DCeLMMmrcIHi1ToCYg-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-32d8d17dcbaso1505958f8f.2
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 04:34:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698060893; x=1698665693;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=n/q/NO/pRi9jMkrVRFBS0odAr+jRA/bi/yczeynV3uU=;
 b=iVVyaW0VbqgXQiQMXtixzUXbgJtQCUyPHdFxuFiIN7gKSLgevC23rXi57h6a5zOnrB
 gCxZoPAU8kjPrafXD8LUjK6fG4aO1CaAF3FrzLwM+gxT27m/yt1txg4JP4TE0gkp9EY/
 tZauHw1ff7SPbAMJfZJMTYfv0Cu4K0DX7YfmW3AWmy9Wx2DJAy2h88zZQGtp4vT6GbcT
 LKEc2X/Z5GczV+VKaM1nfVJ85++kWHmoseiYOBZAV60rtTA/6DJdle5PkNQeywWuTSBU
 XydQyRCgXHH0vq94QrmhrIdbcwU30TN/Qwu0qzgj5mZWpR2bxS27/g5SRJU9wjnZB7vs
 UjwA==
X-Gm-Message-State: AOJu0Yw19yTai68g7K4Fr05N0MujYfzH5WSeIZKcyW1zDRXQVnL6C8lc
 Nqz8eoCBKyua8NwxAAQjrhlG40R06qXTDPHK2eEOfiGFE0cJS14ffZ6oGNd5+n/pAcifMrI/LnG
 DBPXUMadoAUplAwg=
X-Received: by 2002:a5d:590c:0:b0:32d:c09d:6ec9 with SMTP id
 v12-20020a5d590c000000b0032dc09d6ec9mr6970646wrd.7.1698060892991; 
 Mon, 23 Oct 2023 04:34:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIZjA4TEER53pN5LIC1Ccuvu9FrTqFEvAoN/RJzq9Q56SemBOY7qn5uxpCAhz6IPzrm5QPrA==
X-Received: by 2002:a5d:590c:0:b0:32d:c09d:6ec9 with SMTP id
 v12-20020a5d590c000000b0032dc09d6ec9mr6970621wrd.7.1698060892605; 
 Mon, 23 Oct 2023 04:34:52 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:e88f:2c2c:db43:583d:d30e])
 by smtp.gmail.com with ESMTPSA id
 n11-20020adffe0b000000b0032dbf26e7aesm7550729wrr.65.2023.10.23.04.34.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 04:34:52 -0700 (PDT)
Date: Mon, 23 Oct 2023 07:34:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, BALATON Zoltan <balaton@eik.bme.hu>,
 qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v5 00/19] Make Pixman an optional dependency
Message-ID: <20231023073430-mutt-send-email-mst@kernel.org>
References: <20231023113047.2572137-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231023113047.2572137-1-marcandre.lureau@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Oct 23, 2023 at 03:30:27PM +0400, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Hi,
> 
> QEMU system emulators can be made to compile and work without Pixman.
> 
> Only a few devices and options actually require it (VNC, Gtk, Spice for ex) and
> will have to be compiled out.
> 
> However, most of QEMU graphics-related code is based on pixman_image_t and
> format. If we want to provide mostly compatible QEMU machines with or without
> Pixman, all we need to do is to have a small compatibility header with just the
> bare minimum for those types (see "ui: add pixman-compat.h"). There are a
> limited number of operations related to geometry that are slightly better
> implemented in QEMU (without Pixman, see "virtio-gpu: replace PIXMAN for
> region/rect test").
> 
> Without this simple compatibility header approach, QEMU at runtime becomes a
> very different emulator (without graphics device/board, display etc) and full of
> "if PIXMAN" conditions in the code. This is a much worse outcome imho, compared
> to this small header maintainance and compatibility story.
> 
> Fixes:
> https://gitlab.com/qemu-project/qemu/-/issues/1172


virtio things:

Acked-by: Michael S. Tsirkin <mst@redhat.com>


> v5:
> - fixed "vl: move display early init before default devices" patch
> 
> v4:
> - added "vl: move display early init before default devices" patch
> - code style fixes
> - a-b from Zoltan
> 
> v3:
> - improve transient meson condition in first patch (Paolo)
> - use muxed console as fallback by default (Paolo)
> - make pixman-compat.h closer to original API
> - keep "x-pixman" property for sm501 (Zoltan)
> 
> Marc-André Lureau (19):
>   build-sys: add a "pixman" feature
>   ui: compile out some qemu-pixman functions when !PIXMAN
>   ui: add pixman-compat.h
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
>  configs/devices/mips64el-softmmu/default.mak |   2 +-
>  meson.build                                  |  25 ++-
>  qapi/ui.json                                 |   3 +-
>  include/ui/console.h                         |   2 +
>  include/ui/pixman-compat.h                   | 195 +++++++++++++++++++
>  include/ui/qemu-pixman.h                     |  11 +-
>  include/ui/rect.h                            |  59 ++++++
>  hw/display/sm501.c                           |  59 ++++--
>  hw/display/vhost-user-gpu.c                  |   2 +
>  hw/display/virtio-gpu.c                      |  30 ++-
>  system/vl.c                                  |  68 ++++---
>  ui/console-vc-stubs.c                        |  33 ++++
>  ui/console.c                                 |  19 ++
>  ui/dbus-listener.c                           |  90 ++++++---
>  ui/qemu-pixman.c                             |   6 +
>  ui/ui-hmp-cmds.c                             |   2 +
>  ui/ui-qmp-cmds.c                             |   2 +
>  Kconfig.host                                 |   3 +
>  hmp-commands.hx                              |   2 +
>  hw/arm/Kconfig                               |   3 +-
>  hw/display/Kconfig                           |   9 +-
>  hw/display/meson.build                       |   4 +-
>  meson_options.txt                            |   2 +
>  scripts/meson-buildoptions.sh                |   3 +
>  ui/meson.build                               |  24 +--
>  25 files changed, 541 insertions(+), 117 deletions(-)
>  create mode 100644 include/ui/pixman-compat.h
>  create mode 100644 include/ui/rect.h
>  create mode 100644 ui/console-vc-stubs.c
> 
> -- 
> 2.41.0


