Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 17CA08257BD
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 17:10:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLmlO-0008CE-Hs; Fri, 05 Jan 2024 11:09:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rLmlL-0008Br-Sl
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 11:09:36 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rLmlH-0005JJ-Jg
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 11:09:33 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40d60c49ee7so17652465e9.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jan 2024 08:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704470970; x=1705075770; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JPjS24N6aCuE7w72QsslxPMj1wECkZRdY4dZFhSTMGQ=;
 b=L+ZWppnvdMIivaK7xnL/l6gypYSE9C1YigDCR+Ps7DV1IWpHI/KcYRbjTSVnoW1bBm
 O+4HMlRGdsAbr6dlCop2NecEXlpT70NAg77BToDluuws1bvS+wF2KqjqYgNrkjCFgBTl
 wbqis3hn8ym/PD7ah+Qcb68WB5LZkXXz25qzgbOW8/2IUqI+EvCFyLs9gw6uqdYv0+4X
 uarMyGUrxJI9iXzfDzdfKHlcr0tsK4LwLaKapDcEZU5GE4K8AzsL9LcPzO2zaK+/RrZl
 Ya1R1C2bt/G2F8+BV81sI6NyB3URFbLzOnL4f/iFt9DiUMtAW8AV4a4INzEsNuJS6cis
 TUpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704470970; x=1705075770;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JPjS24N6aCuE7w72QsslxPMj1wECkZRdY4dZFhSTMGQ=;
 b=TEXB10zFH5QWoONArk/HtksqnkM0vCh0G08PsFzIaYSBtBe7w7oRZGQO9/Zz6mQJnu
 zm9lB1btcYqv76z9obd861YQPaktsnKcl6v+GwtiBHchdvd/c8Kh2o/zeEL2Jg1mdxeZ
 X5EBUlY8FMmOeMhiRfJs+bKl6HK7gzLO5x4No3HFpeWBaLi9XeDXJOLa5fBX9deiWZHr
 NHYUuZUQqWi842E5NuFRgnEDQJORVVWmu0ZQPFVXrr8ruUCwtqkqaZn/HpAjzbg8TtAy
 8iqY/rNdcI3o+MtQ7HFcgosblMeOfvdBdy9zEZrq3niFPn2I8jTMhurfsDyFRenoQxCq
 KADA==
X-Gm-Message-State: AOJu0YwW+XsOwNC8dqXrEsGZiyY2teS8Oti2aflZgqruSprE3K9TK/XX
 MwsVqo/SywKK69Ms/n/0BqrezR/br3Jh6A==
X-Google-Smtp-Source: AGHT+IFVgvkYokI7P2l5tvklCXid3qCE3ppbuWAimO0DAMUHfSfSv1G9f9CVAS/MkVLQFzp2ejEE/A==
X-Received: by 2002:a05:600c:3f8b:b0:40d:5fd4:ce2c with SMTP id
 fs11-20020a05600c3f8b00b0040d5fd4ce2cmr1261935wmb.53.1704470970048; 
 Fri, 05 Jan 2024 08:09:30 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 d10-20020a056000114a00b00336710ddea0sm1647921wrx.59.2024.01.05.08.09.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jan 2024 08:09:29 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 549BC5F933;
 Fri,  5 Jan 2024 16:09:29 +0000 (GMT)
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
 Jiqian" <Jiqian.Chen@amd.com>,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>,  AKASHI Takahiro
 <takahiro.akashi@linaro.org>
Subject: Re: [PATCH v6 11/11] virtio-gpu: make blob scanout use dmabuf fd
In-Reply-To: <87jzongb9u.fsf@draig.linaro.org> ("Alex =?utf-8?Q?Benn=C3=A9?=
 =?utf-8?Q?e=22's?= message of "Fri, 05 Jan 2024 13:28:13 +0000")
References: <20231219075320.165227-1-ray.huang@amd.com>
 <20231219075320.165227-12-ray.huang@amd.com>
 <87jzongb9u.fsf@draig.linaro.org>
User-Agent: mu4e 1.11.27; emacs 29.1
Date: Fri, 05 Jan 2024 16:09:29 +0000
Message-ID: <878r53g3t2.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
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

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Huang Rui <ray.huang@amd.com> writes:
>
>> From: Robert Beckett <bob.beckett@collabora.com>
>>
>> This relies on a virglrenderer change to include the dmabuf fd when
>> returning resource info.
>>
> <snip>
>> +static void virgl_cmd_set_scanout_blob(VirtIOGPU *g,
>> +                                       struct virtio_gpu_ctrl_command *=
cmd)
>> +{
>> +    struct virgl_gpu_resource *vres;
>> +    struct virtio_gpu_framebuffer fb =3D { 0 };
>> +    struct virtio_gpu_set_scanout_blob ss;
>> +    struct virgl_renderer_resource_info info;
>> +    uint64_t fbend;
>> +
>> +    VIRTIO_GPU_FILL_CMD(ss);
>> +    virtio_gpu_scanout_blob_bswap(&ss);
>> +    trace_virtio_gpu_cmd_set_scanout_blob(ss.scanout_id, ss.resource_id,
>> +                                          ss.r.width, ss.r.height, ss.r=
.x,
>> +                                          ss.r.y);
>> +
>> +    if (ss.scanout_id >=3D g->parent_obj.conf.max_outputs) {
>> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: illegal scanout id specifie=
d %d",
>> +                      __func__, ss.scanout_id);
>> +        cmd->error =3D VIRTIO_GPU_RESP_ERR_INVALID_SCANOUT_ID;
>> +        return;
>> +    }
>> +
>> +    if (ss.resource_id =3D=3D 0) {
>> +        virtio_gpu_disable_scanout(g, ss.scanout_id);
>> +        return;
>> +    }
>> +
>> +    if (ss.width < 16 ||
>> +        ss.height < 16 ||
>> +        ss.r.x + ss.r.width > ss.width ||
>> +        ss.r.y + ss.r.height > ss.height) {
>> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: illegal scanout %d bounds f=
or"
>> +                      " resource %d, rect (%d,%d)+%d,%d, fb %d %d\n",
>> +                      __func__, ss.scanout_id, ss.resource_id,
>> +                      ss.r.x, ss.r.y, ss.r.width, ss.r.height,
>> +                      ss.width, ss.height);
>> +        cmd->error =3D VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
>> +        return;
>> +    }
>> +
>> +    if (!console_has_gl(g->parent_obj.scanout[ss.scanout_id].con)) {
>> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: unable to scanout blot with=
out GL!\n", __func__);
>> +        return;
>> +    }
>> +
>> +    vres =3D virgl_gpu_find_resource(g, ss.resource_id);
>> +    if (!vres) {
>> +        qemu_log_mask(LOG_GUEST_ERROR,
>> +                      "%s: illegal resource specified %d\n",
>> +                      __func__, ss.resource_id);
>> +        cmd->error =3D VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
>> +        return;
>> +    }
>> +    if (virgl_renderer_resource_get_info(ss.resource_id, &info)) {
>> +        qemu_log_mask(LOG_GUEST_ERROR,
>> +                      "%s: illegal virgl resource specified %d\n",
>> +                      __func__, ss.resource_id);
>> +        cmd->error =3D VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
>> +        return;
>> +    }
>
> Minor nit, the format of the following needs to include braces.
>
>> +    if (!vres->res.dmabuf_fd && info.fd)
>> +        vres->res.dmabuf_fd =3D info.fd;
>
> However I'm seeing:
>
>   cc -m64 -mcx16 -Ilibcommon.fa.p -I../../common-user/host/x86_64 -I../..=
/linux-user/include/host/x86_64 -I../../linux-user/include -Iui -I../../ui =
-I/usr/include/capstone -I/usr/include/p11-kit-1 -I/usr/include/pixman-1 -I=
/usr/include/libpng16 -I/usr/include/spice-server -I/usr/include/spice-1 -I=
/usr/include/libusb-1.0 -I/usr/include/SDL2 -I/usr/include/glib-2.0 -I/usr/=
lib/x86_64-linux-gnu/glib-2.0/include -I/usr/include/libmount -I/usr/includ=
e/blkid -I/usr/include/gio-unix-2.0 -I/usr/include/slirp -I/usr/include/gtk=
-3.0 -I/usr/include/pango-1.0 -I/usr/include/harfbuzz -I/usr/include/freety=
pe2 -I/usr/include/fribidi -I/usr/include/cairo -I/usr/include/gdk-pixbuf-2=
.0 -I/usr/include/x86_64-linux-gnu -I/usr/include/atk-1.0 -I/usr/include/at=
-spi2-atk/2.0 -I/usr/include/at-spi-2.0 -I/usr/include/dbus-1.0 -I/usr/lib/=
x86_64-linux-gnu/dbus-1.0/include -I/usr/include/vte-2.91 -I/usr/include/vi=
rgl -I/home/alex/lsrc/qemu.git/builds/extra.libs/install/include -I/usr/inc=
lude/cacard -I/usr/include/nss -I/usr/include/nspr -I/usr/include/PCSC -I/u=
sr/include/pipewire-0.3 -I/usr/include/spa-0.2 -fdiagnostics-color=3Dauto -=
Wall -Winvalid-pch -Werror -std=3Dgnu11 -O2 -g -fstack-protector-strong -Wu=
ndef -Wwrite-strings -Wmissing-prototypes -Wstrict-prototypes -Wredundant-d=
ecls -Wold-style-declaration -Wold-style-definition -Wtype-limits -Wformat-=
security -Wformat-y2k -Winit-self -Wignored-qualifiers -Wempty-body -Wneste=
d-externs -Wendif-labels -Wexpansion-to-defined -Wimplicit-fallthrough=3D2 =
-Wmissing-format-attribute -Wno-missing-include-dirs -Wno-shift-negative-va=
lue -Wno-psabi -Wshadow=3Dlocal -isystem /home/alex/lsrc/qemu.git/linux-hea=
ders -isystem linux-headers -iquote . -iquote /home/alex/lsrc/qemu.git -iqu=
ote /home/alex/lsrc/qemu.git/include -iquote /home/alex/lsrc/qemu.git/host/=
include/x86_64 -iquote /home/alex/lsrc/qemu.git/host/include/generic -iquot=
e /home/alex/lsrc/qemu.git/tcg/i386 -pthread -D_GNU_SOURCE -D_FILE_OFFSET_B=
ITS=3D64 -D_LARGEFILE_SOURCE -fno-strict-aliasing -fno-common -fwrapv -fPIE=
 -D_DEFAULT_SOURCE -D_XOPEN_SOURCE=3D600 -DNCURSES_WIDECHAR=3D1 -D_REENTRAN=
T -DSTRUCT_IOVEC_DEFINED -MD -MQ libcommon.fa.p/hw_display_virtio-gpu-virgl=
.c.o -MF libcommon.fa.p/hw_display_virtio-gpu-virgl.c.o.d -o libcommon.fa.p=
/hw_display_virtio-gpu-virgl.c.o -c ../../hw/display/virtio-gpu-virgl.c
>   ../../hw/display/virtio-gpu-virgl.c: In function =E2=80=98virgl_cmd_set=
_scanout_blob=E2=80=99:
>   ../../hw/display/virtio-gpu-virgl.c:790:37: error: =E2=80=98struct virg=
l_renderer_resource_info=E2=80=99 has no member named =E2=80=98fd=E2=80=99
>     790 |     if (!vres->res.dmabuf_fd && info.fd)
>         |                                     ^
>   ../../hw/display/virtio-gpu-virgl.c:791:35: error: =E2=80=98struct virg=
l_renderer_resource_info=E2=80=99 has no member named =E2=80=98fd=E2=80=99
>     791 |         vres->res.dmabuf_fd =3D info.fd;
>         |                                   ^
>
> But searching my extra libs (for aemu/gfstream/rutabaga_ffi) I can see
> the bindings.rs but nothing generated a header:
>
>   $ ag -r "virgl_renderer_resource_info"=20
>   crosvm.git/rutabaga_gfx/src/generated/virgl_renderer_bindings.rs
>   33:pub const VIRGL_RENDERER_RESOURCE_INFO_EXT_VERSION: u32 =3D 0;
>   337:pub struct virgl_renderer_resource_info {
>   351:pub struct virgl_renderer_resource_info_ext {
>   353:    pub base: virgl_renderer_resource_info,
>   359:impl Default for virgl_renderer_resource_info_ext {
>   373:        info: *mut virgl_renderer_resource_info,
>   379:        info: *mut virgl_renderer_resource_info_ext,
>
> Which makes me think a) its picked up the older virgl headers and b) the
> crosvm/rutabaf_gfx install needs a fix.

Actually it was libvirglrenderer was too old (I got it the wrong way
round, the rust bindings come from libvirglrenderer). As we want to
build with older libvirglrenderers on older systems I think this needs a
tweak to meson.build, maybe something like:

    config_host_data.set('HAVE_VIRGL_RESOURCE_BLOB',
                         cc.has_function('virgl_renderer_resource_create_bl=
ob',
                                          prefix: '#include <virglrenderer.=
h>',
                                          dependencies: virgl)
                         and
                         cc.has_member('struct virgl_renderer_resource_info=
', 'fd',
                                       prefix: '#include <virglrenderer.h>',
                                       dependencies: virgl))

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

