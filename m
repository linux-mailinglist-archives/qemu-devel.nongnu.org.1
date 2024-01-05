Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3F8825475
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 14:29:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLkFM-0003Rj-FW; Fri, 05 Jan 2024 08:28:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rLkFJ-0003Qn-D8
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 08:28:21 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rLkFF-0004fR-7E
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 08:28:20 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3368ae75082so302742f8f.1
 for <qemu-devel@nongnu.org>; Fri, 05 Jan 2024 05:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704461295; x=1705066095; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W+nznXisO2RYjzhLV92DU75Gbl2Luk+CfaiuHjsEqz4=;
 b=EQz+5c3xtb6Dru341ufBzgh4PaO8B64BUH0fm3BtQiygI197bEvgOKq4MYK2XnFA1C
 RepLe3ykUemnQsl1b8Ieyo+G9kmJFlPoXgyhr7GkdGBtYpZmD7MQ9Rr55LypQaTuTLD7
 OJgmo51pk0zYjRA2ZdoXnFx2TQMuaaymxG07lvgolgVg8GJuf0Q1Ywkyi6XFKFXVCSi2
 hwYOs4S1S9WNe+2LU6FeXOwMQd1uyc7MdOy9mwMKnG6PshJquOywrsJIlsnp10bgfQYS
 MA+4b92pO4gw4JEzPy8PA3aglim6XwA+FFMUtXwrZeWZQQBvsOHWGkJ0BV6T8aup7Icf
 2qpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704461295; x=1705066095;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=W+nznXisO2RYjzhLV92DU75Gbl2Luk+CfaiuHjsEqz4=;
 b=kZZLMp5u2q5vb31txPeQm6mQIaS3UraQlTxdqOivbNg1Fn8ocJ8zTExTd8CkNkn8F7
 GquM5MIl50GKV7NlVdKlnMtI/ZC+tZxcsRP+yyL1dkuha3TkgwQc8HO6VFCmtSNeV5sp
 zCk/jDPRT7wDP/du+SBTWnGVxVIE2P8rzcIgQWkUFaJStbEVKFbFmJscDaFVgw/yNfyp
 tLdU83fSvwFO4rgK49ox5ktWa33kTOYf30C6j2xBQrOZvDOsN2OTpR0NQWd8M3vsaOVq
 wDQPS9wlle6pEdnLabuFR0IEE/fz28K4C+BdK9QSYmrbuBAoCuinwjJZkrx0o3eWuqQ9
 ap2w==
X-Gm-Message-State: AOJu0Yz15W3gYIe6lecRwjukGMg4TjAX9uLo0x097L5krjXZgYkEdro9
 IVruz/bQnrSZzRMzsVZqkRPKgXlNe3jvXA==
X-Google-Smtp-Source: AGHT+IHOG8IUfwKAVC8ut9ElsstIjLu6dL48QYO12QNDqpajE4/ZBkXzwk2yH0skphSmP2Vb8MlBCQ==
X-Received: by 2002:a05:600c:1c9f:b0:40c:31f1:1464 with SMTP id
 k31-20020a05600c1c9f00b0040c31f11464mr1129028wms.139.1704461294651; 
 Fri, 05 Jan 2024 05:28:14 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 t7-20020a05600c198700b0040d6b91efd9sm1588578wmq.44.2024.01.05.05.28.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jan 2024 05:28:14 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id AB8405F933;
 Fri,  5 Jan 2024 13:28:13 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Huang Rui <ray.huang@amd.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,  =?utf-8?Q?Marc-Andr=C3=A9?=
 Lureau
 <marcandre.lureau@gmail.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,  "Michael S . Tsirkin"
 <mst@redhat.com>,  "Stefano Stabellini" <sstabellini@kernel.org>,  Anthony
 PERARD <anthony.perard@citrix.com>,  Antonio Caggiano
 <quic_acaggian@quicinc.com>,  "Dr . David Alan Gilbert"
 <dgilbert@redhat.com>,  Robert Beckett <bob.beckett@collabora.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,  Gert Wollny
 <gert.wollny@collabora.com>,  <qemu-devel@nongnu.org>,
 <xen-devel@lists.xenproject.org>,  Gurchetan Singh
 <gurchetansingh@chromium.org>,  <ernunes@redhat.com>,  Alyssa Ross
 <hi@alyssa.is>,  Roger Pau =?utf-8?Q?Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,  Stefano Stabellini
 <stefano.stabellini@amd.com>,  Christian =?utf-8?Q?K=C3=B6nig?=
 <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,  Pierre-Eric Pelloux-Prayer
 <pierre-eric.pelloux-prayer@amd.com>,  "Honglei Huang"
 <honglei1.huang@amd.com>,  Julia Zhang <julia.zhang@amd.com>,  "Chen
 Jiqian" <Jiqian.Chen@amd.com>, Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>, AKASHI Takahiro
 <takahiro.akashi@linaro.org>
Subject: Re: [PATCH v6 11/11] virtio-gpu: make blob scanout use dmabuf fd
In-Reply-To: <20231219075320.165227-12-ray.huang@amd.com> (Huang Rui's message
 of "Tue, 19 Dec 2023 15:53:20 +0800")
References: <20231219075320.165227-1-ray.huang@amd.com>
 <20231219075320.165227-12-ray.huang@amd.com>
User-Agent: mu4e 1.11.27; emacs 29.1
Date: Fri, 05 Jan 2024 13:28:13 +0000
Message-ID: <87jzongb9u.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42d.google.com
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

Huang Rui <ray.huang@amd.com> writes:

> From: Robert Beckett <bob.beckett@collabora.com>
>
> This relies on a virglrenderer change to include the dmabuf fd when
> returning resource info.
>
<snip>
> +static void virgl_cmd_set_scanout_blob(VirtIOGPU *g,
> +                                       struct virtio_gpu_ctrl_command *c=
md)
> +{
> +    struct virgl_gpu_resource *vres;
> +    struct virtio_gpu_framebuffer fb =3D { 0 };
> +    struct virtio_gpu_set_scanout_blob ss;
> +    struct virgl_renderer_resource_info info;
> +    uint64_t fbend;
> +
> +    VIRTIO_GPU_FILL_CMD(ss);
> +    virtio_gpu_scanout_blob_bswap(&ss);
> +    trace_virtio_gpu_cmd_set_scanout_blob(ss.scanout_id, ss.resource_id,
> +                                          ss.r.width, ss.r.height, ss.r.=
x,
> +                                          ss.r.y);
> +
> +    if (ss.scanout_id >=3D g->parent_obj.conf.max_outputs) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: illegal scanout id specified=
 %d",
> +                      __func__, ss.scanout_id);
> +        cmd->error =3D VIRTIO_GPU_RESP_ERR_INVALID_SCANOUT_ID;
> +        return;
> +    }
> +
> +    if (ss.resource_id =3D=3D 0) {
> +        virtio_gpu_disable_scanout(g, ss.scanout_id);
> +        return;
> +    }
> +
> +    if (ss.width < 16 ||
> +        ss.height < 16 ||
> +        ss.r.x + ss.r.width > ss.width ||
> +        ss.r.y + ss.r.height > ss.height) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: illegal scanout %d bounds fo=
r"
> +                      " resource %d, rect (%d,%d)+%d,%d, fb %d %d\n",
> +                      __func__, ss.scanout_id, ss.resource_id,
> +                      ss.r.x, ss.r.y, ss.r.width, ss.r.height,
> +                      ss.width, ss.height);
> +        cmd->error =3D VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
> +        return;
> +    }
> +
> +    if (!console_has_gl(g->parent_obj.scanout[ss.scanout_id].con)) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: unable to scanout blot witho=
ut GL!\n", __func__);
> +        return;
> +    }
> +
> +    vres =3D virgl_gpu_find_resource(g, ss.resource_id);
> +    if (!vres) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: illegal resource specified %d\n",
> +                      __func__, ss.resource_id);
> +        cmd->error =3D VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
> +        return;
> +    }
> +    if (virgl_renderer_resource_get_info(ss.resource_id, &info)) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: illegal virgl resource specified %d\n",
> +                      __func__, ss.resource_id);
> +        cmd->error =3D VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
> +        return;
> +    }

Minor nit, the format of the following needs to include braces.

> +    if (!vres->res.dmabuf_fd && info.fd)
> +        vres->res.dmabuf_fd =3D info.fd;

However I'm seeing:

  cc -m64 -mcx16 -Ilibcommon.fa.p -I../../common-user/host/x86_64 -I../../l=
inux-user/include/host/x86_64 -I../../linux-user/include -Iui -I../../ui -I=
/usr/include/capstone -I/usr/include/p11-kit-1 -I/usr/include/pixman-1 -I/u=
sr/include/libpng16 -I/usr/include/spice-server -I/usr/include/spice-1 -I/u=
sr/include/libusb-1.0 -I/usr/include/SDL2 -I/usr/include/glib-2.0 -I/usr/li=
b/x86_64-linux-gnu/glib-2.0/include -I/usr/include/libmount -I/usr/include/=
blkid -I/usr/include/gio-unix-2.0 -I/usr/include/slirp -I/usr/include/gtk-3=
.0 -I/usr/include/pango-1.0 -I/usr/include/harfbuzz -I/usr/include/freetype=
2 -I/usr/include/fribidi -I/usr/include/cairo -I/usr/include/gdk-pixbuf-2.0=
 -I/usr/include/x86_64-linux-gnu -I/usr/include/atk-1.0 -I/usr/include/at-s=
pi2-atk/2.0 -I/usr/include/at-spi-2.0 -I/usr/include/dbus-1.0 -I/usr/lib/x8=
6_64-linux-gnu/dbus-1.0/include -I/usr/include/vte-2.91 -I/usr/include/virg=
l -I/home/alex/lsrc/qemu.git/builds/extra.libs/install/include -I/usr/inclu=
de/cacard -I/usr/include/nss -I/usr/include/nspr -I/usr/include/PCSC -I/usr=
/include/pipewire-0.3 -I/usr/include/spa-0.2 -fdiagnostics-color=3Dauto -Wa=
ll -Winvalid-pch -Werror -std=3Dgnu11 -O2 -g -fstack-protector-strong -Wund=
ef -Wwrite-strings -Wmissing-prototypes -Wstrict-prototypes -Wredundant-dec=
ls -Wold-style-declaration -Wold-style-definition -Wtype-limits -Wformat-se=
curity -Wformat-y2k -Winit-self -Wignored-qualifiers -Wempty-body -Wnested-=
externs -Wendif-labels -Wexpansion-to-defined -Wimplicit-fallthrough=3D2 -W=
missing-format-attribute -Wno-missing-include-dirs -Wno-shift-negative-valu=
e -Wno-psabi -Wshadow=3Dlocal -isystem /home/alex/lsrc/qemu.git/linux-heade=
rs -isystem linux-headers -iquote . -iquote /home/alex/lsrc/qemu.git -iquot=
e /home/alex/lsrc/qemu.git/include -iquote /home/alex/lsrc/qemu.git/host/in=
clude/x86_64 -iquote /home/alex/lsrc/qemu.git/host/include/generic -iquote =
/home/alex/lsrc/qemu.git/tcg/i386 -pthread -D_GNU_SOURCE -D_FILE_OFFSET_BIT=
S=3D64 -D_LARGEFILE_SOURCE -fno-strict-aliasing -fno-common -fwrapv -fPIE -=
D_DEFAULT_SOURCE -D_XOPEN_SOURCE=3D600 -DNCURSES_WIDECHAR=3D1 -D_REENTRANT =
-DSTRUCT_IOVEC_DEFINED -MD -MQ libcommon.fa.p/hw_display_virtio-gpu-virgl.c=
.o -MF libcommon.fa.p/hw_display_virtio-gpu-virgl.c.o.d -o libcommon.fa.p/h=
w_display_virtio-gpu-virgl.c.o -c ../../hw/display/virtio-gpu-virgl.c
  ../../hw/display/virtio-gpu-virgl.c: In function =E2=80=98virgl_cmd_set_s=
canout_blob=E2=80=99:
  ../../hw/display/virtio-gpu-virgl.c:790:37: error: =E2=80=98struct virgl_=
renderer_resource_info=E2=80=99 has no member named =E2=80=98fd=E2=80=99
    790 |     if (!vres->res.dmabuf_fd && info.fd)
        |                                     ^
  ../../hw/display/virtio-gpu-virgl.c:791:35: error: =E2=80=98struct virgl_=
renderer_resource_info=E2=80=99 has no member named =E2=80=98fd=E2=80=99
    791 |         vres->res.dmabuf_fd =3D info.fd;
        |                                   ^

But searching my extra libs (for aemu/gfstream/rutabaga_ffi) I can see
the bindings.rs but nothing generated a header:

  $ ag -r "virgl_renderer_resource_info"=20
  crosvm.git/rutabaga_gfx/src/generated/virgl_renderer_bindings.rs
  33:pub const VIRGL_RENDERER_RESOURCE_INFO_EXT_VERSION: u32 =3D 0;
  337:pub struct virgl_renderer_resource_info {
  351:pub struct virgl_renderer_resource_info_ext {
  353:    pub base: virgl_renderer_resource_info,
  359:impl Default for virgl_renderer_resource_info_ext {
  373:        info: *mut virgl_renderer_resource_info,
  379:        info: *mut virgl_renderer_resource_info_ext,

Which makes me think a) its picked up the older virgl headers and b) the
crosvm/rutabaf_gfx install needs a fix.


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

