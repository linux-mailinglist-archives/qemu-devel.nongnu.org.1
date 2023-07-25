Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D11761C4F
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 16:56:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOJRi-0001k8-LM; Tue, 25 Jul 2023 10:55:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qOJRQ-0001hV-QF
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 10:55:13 -0400
Received: from mail-qt1-x82f.google.com ([2607:f8b0:4864:20::82f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qOJRN-0008UY-Q4
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 10:55:12 -0400
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-403e7472b28so40951831cf.2
 for <qemu-devel@nongnu.org>; Tue, 25 Jul 2023 07:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690296908; x=1690901708;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qMkPRO9Ku8bU6aemO6P+aoU7dWUdQv55+BxJh/4t/6w=;
 b=nvIYC4ECniiTXMjD1QOTn1JvagIvoyKoC2EYVHTtGC9HHoGTS+RgxAC3NRsPkeidWy
 EgWNbYNNxNq7+z8+ctSpyL9OepV0hLQkcFc7hjjbtz49RHXuzTMA9NixyoR/75fiBc8X
 TkzD5TIoAHoF32Jw9FhlLMQwDfXu6Nzd/PnkOX09G3rPM00v6LXiPSDt5qULnq1K5Zj6
 ESOQwuo74h/ZhHnrGI2EOWH5vqjZSmzkeMQJWYJR4Hp8wRRNufEIlrYy2uXf+M0/mEli
 435M8NoeSEnY+Kk4P5WOKtrdT0ayK4XOHJaVF6M9QXFNlbBBK3Ace3n44ZxJDhNLXGDv
 aFJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690296908; x=1690901708;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qMkPRO9Ku8bU6aemO6P+aoU7dWUdQv55+BxJh/4t/6w=;
 b=SufZNKJYv/zN607va1ziaUkVitKcyNDbVt8+urApqjmJ0700/OeMBuWDqPugxMz0Gx
 rLkq4UqipOSXAh5cLg1ToweXvFW56Ri3Ss5JZ2wtNH3zmKB69rjVfjIZjm2dqFX9ly8m
 JTY9/ptZJd36QjaNP9lWO2nUIveNQ3u5Clzn6JZRkT6OLjjzeVMya53viKgIeSqY+aD4
 xg0KXb5b1LF4r7TwXC2PqrwCKX8l8qCR2Y/bhxeU2IMG1OiVNTpA7XSBX12jyDT7+94E
 zAU0KwtxWhHvHIk0qylnyf72emM8hmqaags0la3et2WrhMGAftX9VzYhSmOZaE2oLpUu
 MhBQ==
X-Gm-Message-State: ABy/qLaZkdpbN4BE+le8ydexhV/TQDbY9TEyILIm+vWrKcoJ8QyKck8Q
 xFAdgEGz4fZx0O/h/vc4Ky2T/PpA3Hb6rRoBQAY=
X-Google-Smtp-Source: APBJJlF49c14miajS5Db2kWgAY/MWqZSdXroGK9nc4JAq/YNAaHtOrrkY6kOZMGTjlJpWjZG5TccQmfg4opkMeD0mwQ=
X-Received: by 2002:ac8:58c4:0:b0:400:a976:fc71 with SMTP id
 u4-20020ac858c4000000b00400a976fc71mr3917489qta.65.1690296908246; Tue, 25 Jul
 2023 07:55:08 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1689857559.git.manos.pitsidianakis@linaro.org>
 <f267d41957025b3849324f459a8ed476aa89f828.1689857559.git.manos.pitsidianakis@linaro.org>
 <CAJ+F1C+H+82cA=mhpju-2nxRSA3BWnWJmp4-pi+G=Lsri0oGTw@mail.gmail.com>
 <20230725104417-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230725104417-mutt-send-email-mst@kernel.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 25 Jul 2023 18:54:56 +0400
Message-ID: <CAJ+F1CLZ-p=L-7h6BdP_eCYGe9Cn+k+hUi=7aj-5LrNj_W1E0g@mail.gmail.com>
Subject: Re: [PATCH v4 06/12] virtio-sound: handle VIRTIO_SND_R_PCM_INFO
 request
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org, Igor Skalkin <Igor.Skalkin@opensynergy.com>, 
 Anton Yakovlev <Anton.Yakovlev@opensynergy.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>, 
 =?UTF-8?B?S8WRdsOhZ8OzLCBab2x0w6Fu?= <DirtY.iCE.hu@gmail.com>, 
 Alex Bennee <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000c7f6d5060150ea87"
Received-SPF: pass client-ip=2607:f8b0:4864:20::82f;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--000000000000c7f6d5060150ea87
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Tue, Jul 25, 2023 at 6:47=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:

> On Tue, Jul 25, 2023 at 06:29:58PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> >
> >
> > On Thu, Jul 20, 2023 at 4:59=E2=80=AFPM Emmanouil Pitsidianakis <
> > manos.pitsidianakis@linaro.org> wrote:
> >
> >     Respond to the VIRTIO_SND_R_PCM_INFO control request with the
> parameters
> >     of each requested PCM stream.
> >
> >     Signed-off-by: Emmanouil Pitsidianakis <
> manos.pitsidianakis@linaro.org>
> >     ---
> >      hw/virtio/trace-events |  1 +
> >      hw/virtio/virtio-snd.c | 78
> ++++++++++++++++++++++++++++++++++++++++++
> >      2 files changed, 79 insertions(+)
> >
> >     diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
> >     index 8a223e36e9..3e619f778b 100644
> >     --- a/hw/virtio/trace-events
> >     +++ b/hw/virtio/trace-events
> >     @@ -164,6 +164,7 @@ virtio_snd_vm_state_stopped(void) "vm state
> stopped"
> >      virtio_snd_realize(void *snd) "snd %p: realize"
> >      virtio_snd_unrealize(void *snd) "snd %p: unrealize"
> >      virtio_snd_handle_ctrl(void *vdev, void *vq) "snd %p: handle ctrl
> event
> >     for queue %p"
> >     +virtio_snd_handle_pcm_info(uint32_t stream) "VIRTIO_SND_R_PCM_INFO
> called
> >     for stream %"PRIu32
> >      virtio_snd_handle_code(uint32_t val, const char *code) "ctrl code
> msg val
> >     =3D %"PRIu32" =3D=3D %s"
> >      virtio_snd_handle_chmap_info(void) "VIRTIO_SND_CHMAP_INFO called"
> >      virtio_snd_handle_event(void) "event queue callback called"
> >     diff --git a/hw/virtio/virtio-snd.c b/hw/virtio/virtio-snd.c
> >     index ca09c937c7..3f8b46f372 100644
> >     --- a/hw/virtio/virtio-snd.c
> >     +++ b/hw/virtio/virtio-snd.c
> >     @@ -134,6 +134,19 @@ virtio_snd_set_config(VirtIODevice *vdev, cons=
t
> >     uint8_t *config)
> >          memcpy(&s->snd_conf, sndconfig, sizeof(s->snd_conf));
> >      }
> >
> >     +/*
> >     + * Get a specific stream from the virtio sound card device.
> >     + * Returns NULL if @stream_id is invalid or not allocated.
> >     + *
> >     + * @s: VirtIOSound device
> >     + * @stream_id: stream id
> >     + */
> >     +static VirtIOSoundPCMStream *virtio_snd_pcm_get_stream(VirtIOSound
> *s,
> >     +                                                       uint32_t
> stream_id)
> >     +{
> >     +    return stream_id >=3D s->snd_conf.streams ? NULL : s->pcm->str=
eams
> >     [stream_id];
> >     +}
> >     +
> >      /*
> >       * Get params for a specific stream.
> >       *
> >     @@ -147,6 +160,69 @@ static VirtIOSoundPCMParams
> *virtio_snd_pcm_get_params
> >     (VirtIOSound *s,
> >              : s->pcm->pcm_params[stream_id];
> >      }
> >
> >     +/*
> >     + * Handle the VIRTIO_SND_R_PCM_INFO request.
> >     + * The function writes the info structs to the request element.
> >     + *
> >     + * @s: VirtIOSound device
> >     + * @cmd: The request command queue element from VirtIOSound cmdq
> field
> >     + */
> >     +static void virtio_snd_handle_pcm_info(VirtIOSound *s,
> >     +                                       virtio_snd_ctrl_command *cm=
d)
> >     +{
> >     +    virtio_snd_query_info req;
> >     +    VirtIOSoundPCMStream *stream =3D NULL;
> >     +    g_autofree virtio_snd_pcm_info *pcm_info =3D NULL;
> >     +    size_t sz =3D iov_to_buf(cmd->elem->out_sg,
> >     +                           cmd->elem->out_num,
> >     +                           0,
> >     +                           &req,
> >     +                           sizeof(req));
> >     +    if (sz !=3D sizeof(virtio_snd_query_info)) {
> >     +        cmd->resp.code =3D VIRTIO_SND_S_BAD_MSG;
> >     +        return;
> >     +    }
> >     +
> >     +    if (iov_size(cmd->elem->in_sg, cmd->elem->in_num) <
> >     +        sizeof(virtio_snd_hdr) + req.size * req.count) {
> >     +        error_report("pcm info: buffer too small, got: %lu, needed=
:
> %lu",
> >     +                iov_size(cmd->elem->in_sg, cmd->elem->in_num),
> >
> >
> >
> >     +                sizeof(virtio_snd_pcm_info));
> >     +        cmd->resp.code =3D VIRTIO_SND_S_BAD_MSG;
> >     +        return;
> >     +    }
> >     +
> >     +    pcm_info =3D g_new0(virtio_snd_pcm_info, req.count);
> >     +    for (uint32_t i =3D req.start_id; i < req.start_id + req.count=
;
> i++) {
> >     +        trace_virtio_snd_handle_pcm_info(i);
> >     +        stream =3D virtio_snd_pcm_get_stream(s, i);
> >     +
> >     +        if (!stream) {
> >     +            error_report("Invalid stream id: %"PRIu32, i);
> >     +            cmd->resp.code =3D VIRTIO_SND_S_BAD_MSG;
> >     +            return;
> >     +        }
> >     +
> >     +        pcm_info[i - req.start_id].hdr.hda_fn_nid =3D stream->
> >     info.hdr.hda_fn_nid;
> >     +        pcm_info[i - req.start_id].features =3D stream->features;
> >     +        pcm_info[i - req.start_id].formats =3D stream->formats;
> >     +        pcm_info[i - req.start_id].rates =3D stream->rates;
> >     +        pcm_info[i - req.start_id].direction =3D stream->direction=
;
> >     +        pcm_info[i - req.start_id].channels_min =3D
> stream->channels_min;
> >     +        pcm_info[i - req.start_id].channels_max =3D
> stream->channels_max;
> >     +
> >     +        memset(&pcm_info[i].padding, 0,
> sizeof(pcm_info[i].padding));
> >     +    }
> >     +
> >     +    cmd->resp.code =3D VIRTIO_SND_S_OK;
> >     +
> >     +    iov_from_buf(cmd->elem->in_sg,
> >     +                 cmd->elem->in_num,
> >     +                 sizeof(virtio_snd_hdr),
> >     +                 pcm_info,
> >     +                 sizeof(virtio_snd_pcm_info) * req.count);
> >     +}
> >     +
> >      /*
> >       * Set the given stream params.
> >       * Called by both virtio_snd_handle_pcm_set_params and during devi=
ce
> >     @@ -358,6 +434,8 @@ process_cmd(VirtIOSound *s,
> virtio_snd_ctrl_command
> >     *cmd)
> >              cmd->resp.code =3D VIRTIO_SND_S_NOT_SUPP;
> >              break;
> >          case VIRTIO_SND_R_PCM_INFO:
> >     +        virtio_snd_handle_pcm_info(s, cmd);
> >     +        break;
> >          case VIRTIO_SND_R_PCM_SET_PARAMS:
> >          case VIRTIO_SND_R_PCM_PREPARE:
> >          case VIRTIO_SND_R_PCM_START:
> >     --
> >     2.39.2
> >
> >
> >
>
>
> Marc-Andr=C3=A9 can you please stop with trying to use gmail web client?
>

Trying? I think I have almost exclusively used it over the past 15y or so :=
)


> Look here to see how it corrupts text by wrapping lines:
>
> https://lore.kernel.org/all/CAJ+F1C+H+82cA=3Dmhpju-2nxRSA3BWnWJmp4-pi+G=
=3DLsri0oGTw@mail.gmail.com/
>
> And please cut out irrelevant parts of message - I've no idea what you
> tried to say here.
>

that was my mistake, I sent it too quickly.. it happens.

--=20
Marc-Andr=C3=A9 Lureau

--000000000000c7f6d5060150ea87
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jul 25, 2023 at 6:47=E2=80=
=AFPM Michael S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.com">mst@redhat.c=
om</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">On Tue, Jul 25, 2023 at 06:29:58PM +0400, Marc-Andr=C3=A9 Lureau wrote:<b=
r>
&gt; <br>
&gt; <br>
&gt; On Thu, Jul 20, 2023 at 4:59=E2=80=AFPM Emmanouil Pitsidianakis &lt;<b=
r>
&gt; <a href=3D"mailto:manos.pitsidianakis@linaro.org" target=3D"_blank">ma=
nos.pitsidianakis@linaro.org</a>&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Respond to the VIRTIO_SND_R_PCM_INFO control reques=
t with the parameters<br>
&gt;=C2=A0 =C2=A0 =C2=A0of each requested PCM stream.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Signed-off-by: Emmanouil Pitsidianakis &lt;<a href=
=3D"mailto:manos.pitsidianakis@linaro.org" target=3D"_blank">manos.pitsidia=
nakis@linaro.org</a>&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0---<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0hw/virtio/trace-events |=C2=A0 1 +<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0hw/virtio/virtio-snd.c | 78 +++++++++++++++++=
+++++++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A02 files changed, 79 insertions(+)<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0diff --git a/hw/virtio/trace-events b/hw/virtio/tra=
ce-events<br>
&gt;=C2=A0 =C2=A0 =C2=A0index 8a223e36e9..3e619f778b 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0--- a/hw/virtio/trace-events<br>
&gt;=C2=A0 =C2=A0 =C2=A0+++ b/hw/virtio/trace-events<br>
&gt;=C2=A0 =C2=A0 =C2=A0@@ -164,6 +164,7 @@ virtio_snd_vm_state_stopped(voi=
d) &quot;vm state stopped&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0virtio_snd_realize(void *snd) &quot;snd %p: r=
ealize&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0virtio_snd_unrealize(void *snd) &quot;snd %p:=
 unrealize&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0virtio_snd_handle_ctrl(void *vdev, void *vq) =
&quot;snd %p: handle ctrl event<br>
&gt;=C2=A0 =C2=A0 =C2=A0for queue %p&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+virtio_snd_handle_pcm_info(uint32_t stream) &quot;=
VIRTIO_SND_R_PCM_INFO called<br>
&gt;=C2=A0 =C2=A0 =C2=A0for stream %&quot;PRIu32<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0virtio_snd_handle_code(uint32_t val, const ch=
ar *code) &quot;ctrl code msg val<br>
&gt;=C2=A0 =C2=A0 =C2=A0=3D %&quot;PRIu32&quot; =3D=3D %s&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0virtio_snd_handle_chmap_info(void) &quot;VIRT=
IO_SND_CHMAP_INFO called&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0virtio_snd_handle_event(void) &quot;event que=
ue callback called&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0diff --git a/hw/virtio/virtio-snd.c b/hw/virtio/vir=
tio-snd.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0index ca09c937c7..3f8b46f372 100644<br>
&gt;=C2=A0 =C2=A0 =C2=A0--- a/hw/virtio/virtio-snd.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0+++ b/hw/virtio/virtio-snd.c<br>
&gt;=C2=A0 =C2=A0 =C2=A0@@ -134,6 +134,19 @@ virtio_snd_set_config(VirtIODe=
vice *vdev, const<br>
&gt;=C2=A0 =C2=A0 =C2=A0uint8_t *config)<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0memcpy(&amp;s-&gt;snd_conf, snd=
config, sizeof(s-&gt;snd_conf));<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0}<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0+/*<br>
&gt;=C2=A0 =C2=A0 =C2=A0+ * Get a specific stream from the virtio sound car=
d device.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+ * Returns NULL if @stream_id is invalid or not al=
located.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+ *<br>
&gt;=C2=A0 =C2=A0 =C2=A0+ * @s: VirtIOSound device<br>
&gt;=C2=A0 =C2=A0 =C2=A0+ * @stream_id: stream id<br>
&gt;=C2=A0 =C2=A0 =C2=A0+ */<br>
&gt;=C2=A0 =C2=A0 =C2=A0+static VirtIOSoundPCMStream *virtio_snd_pcm_get_st=
ream(VirtIOSound *s,<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ui=
nt32_t stream_id)<br>
&gt;=C2=A0 =C2=A0 =C2=A0+{<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 return stream_id &gt;=3D s-&gt;snd_c=
onf.streams ? NULL : s-&gt;pcm-&gt;streams<br>
&gt;=C2=A0 =C2=A0 =C2=A0[stream_id];<br>
&gt;=C2=A0 =C2=A0 =C2=A0+}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0/*<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 * Get params for a specific stream.<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 *<br>
&gt;=C2=A0 =C2=A0 =C2=A0@@ -147,6 +160,69 @@ static VirtIOSoundPCMParams *v=
irtio_snd_pcm_get_params<br>
&gt;=C2=A0 =C2=A0 =C2=A0(VirtIOSound *s,<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: s-&gt;pcm-&gt;p=
cm_params[stream_id];<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0}<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0+/*<br>
&gt;=C2=A0 =C2=A0 =C2=A0+ * Handle the VIRTIO_SND_R_PCM_INFO request.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+ * The function writes the info structs to the req=
uest element.<br>
&gt;=C2=A0 =C2=A0 =C2=A0+ *<br>
&gt;=C2=A0 =C2=A0 =C2=A0+ * @s: VirtIOSound device<br>
&gt;=C2=A0 =C2=A0 =C2=A0+ * @cmd: The request command queue element from Vi=
rtIOSound cmdq field<br>
&gt;=C2=A0 =C2=A0 =C2=A0+ */<br>
&gt;=C2=A0 =C2=A0 =C2=A0+static void virtio_snd_handle_pcm_info(VirtIOSound=
 *s,<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0virtio_snd_ctrl_command *cmd)<br>
&gt;=C2=A0 =C2=A0 =C2=A0+{<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 virtio_snd_query_info req;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 VirtIOSoundPCMStream *stream =3D NUL=
L;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 g_autofree virtio_snd_pcm_info *pcm_=
info =3D NULL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 size_t sz =3D iov_to_buf(cmd-&gt;ele=
m-&gt;out_sg,<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cmd-&gt;elem-&gt;out_num,<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00,<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;req,<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sizeof(req));<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 if (sz !=3D sizeof(virtio_snd_query_=
info)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd-&gt;resp.code =3D =
VIRTIO_SND_S_BAD_MSG;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 if (iov_size(cmd-&gt;elem-&gt;in_sg,=
 cmd-&gt;elem-&gt;in_num) &lt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sizeof(virtio_snd_hdr)=
 + req.size * req.count) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;pcm=
 info: buffer too small, got: %lu, needed: %lu&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 iov_size(cmd-&gt;elem-&gt;in_sg, cmd-&gt;elem-&gt;in_num),<br>
&gt; <br>
&gt; =C2=A0<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 sizeof(virtio_snd_pcm_info));<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd-&gt;resp.code =3D =
VIRTIO_SND_S_BAD_MSG;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 pcm_info =3D g_new0(virtio_snd_pcm_i=
nfo, req.count);<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 for (uint32_t i =3D req.start_id; i =
&lt; req.start_id + req.count; i++) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_virtio_snd_handl=
e_pcm_info(i);<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 stream =3D virtio_snd_=
pcm_get_stream(s, i);<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!stream) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_re=
port(&quot;Invalid stream id: %&quot;PRIu32, i);<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd-&gt;=
resp.code =3D VIRTIO_SND_S_BAD_MSG;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pcm_info[i - req.start=
_id].hdr.hda_fn_nid =3D stream-&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0info.hdr.hda_fn_nid;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pcm_info[i - req.start=
_id].features =3D stream-&gt;features;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pcm_info[i - req.start=
_id].formats =3D stream-&gt;formats;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pcm_info[i - req.start=
_id].rates =3D stream-&gt;rates;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pcm_info[i - req.start=
_id].direction =3D stream-&gt;direction;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pcm_info[i - req.start=
_id].channels_min =3D stream-&gt;channels_min;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pcm_info[i - req.start=
_id].channels_max =3D stream-&gt;channels_max;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 memset(&amp;pcm_info[i=
].padding, 0, sizeof(pcm_info[i].padding));<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 cmd-&gt;resp.code =3D VIRTIO_SND_S_O=
K;<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 iov_from_buf(cmd-&gt;elem-&gt;in_sg,=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0cmd-&gt;elem-&gt;in_num,<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0sizeof(virtio_snd_hdr),<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0pcm_info,<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0sizeof(virtio_snd_pcm_info) * req.count);<br>
&gt;=C2=A0 =C2=A0 =C2=A0+}<br>
&gt;=C2=A0 =C2=A0 =C2=A0+<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0/*<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 * Set the given stream params.<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 * Called by both virtio_snd_handle_pcm_set_p=
arams and during device<br>
&gt;=C2=A0 =C2=A0 =C2=A0@@ -358,6 +434,8 @@ process_cmd(VirtIOSound *s, vir=
tio_snd_ctrl_command<br>
&gt;=C2=A0 =C2=A0 =C2=A0*cmd)<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cmd-&gt;resp.code=
 =3D VIRTIO_SND_S_NOT_SUPP;<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0case VIRTIO_SND_R_PCM_INFO:<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_snd_handle_pcm_=
info(s, cmd);<br>
&gt;=C2=A0 =C2=A0 =C2=A0+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0case VIRTIO_SND_R_PCM_SET_PARAM=
S:<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0case VIRTIO_SND_R_PCM_PREPARE:<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0case VIRTIO_SND_R_PCM_START:<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0--<br>
&gt;=C2=A0 =C2=A0 =C2=A02.39.2<br>
&gt; <br>
&gt; <br>
&gt; <br>
<br>
<br>
Marc-Andr=C3=A9 can you please stop with trying to use gmail web client?<br=
></blockquote><div><br></div><div>Trying? I think I have almost exclusively=
 used it over the past 15y or so :)</div><div>=C2=A0<br></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">
Look here to see how it corrupts text by wrapping lines:<br>
<a href=3D"https://lore.kernel.org/all/CAJ+F1C+H+82cA=3Dmhpju-2nxRSA3BWnWJm=
p4-pi+G=3DLsri0oGTw@mail.gmail.com/" rel=3D"noreferrer" target=3D"_blank">h=
ttps://lore.kernel.org/all/CAJ+F1C+H+82cA=3Dmhpju-2nxRSA3BWnWJmp4-pi+G=3DLs=
ri0oGTw@mail.gmail.com/</a><br>
<br>
And please cut out irrelevant parts of message - I&#39;ve no idea what you =
tried to say here.<br clear=3D"all"></blockquote><div><br></div><div>that w=
as my mistake, I sent it too quickly.. it happens. <br></div></div><br><spa=
n class=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" class=3D"=
gmail_signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--000000000000c7f6d5060150ea87--

