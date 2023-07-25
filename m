Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D912761BCC
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 16:31:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOJ44-0004Xv-6x; Tue, 25 Jul 2023 10:31:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qOJ3g-0004Rt-Q1
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 10:30:41 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qOJ3e-0003aD-LN
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 10:30:40 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-57a6df91b1eso68926497b3.1
 for <qemu-devel@nongnu.org>; Tue, 25 Jul 2023 07:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690295437; x=1690900237;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Vf94sm5OpJT9ACw+7t6pjWQG4NiDef3h0vyZnQLtonA=;
 b=SU4f+RIYAp2FSb7RrjDWl5NDmZj7fs412XLFMfi6OBzaBboD9z7LLLXjU5w7tBhx4g
 UHxC67yF5qySZvsg0yTCO1PSqF7tP7BYDOdlvklcc1uWUkINK9Aj69B3fzhL/l8vQPn6
 Lq9u/h9f6iDnsWJSKAzoKjX2dfFtxd5VLk1NrSF4uuvuzib89210fEzCRCB4Fv0fmUik
 FG9rZRuOw+dxsKKAWKiH5PBTGdeqyV97qs3Li+qH+mvyhr6JY0jNFPlBBOLIHB2he8+2
 Ktt2nAFytrdv4eVhucCnv1yfr1rEkI/Kz/0UUruY3J+ofSTREMOpzpbq9YGgbUbDwNfK
 RjQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690295437; x=1690900237;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Vf94sm5OpJT9ACw+7t6pjWQG4NiDef3h0vyZnQLtonA=;
 b=kwAB8+W/sFPFBYBq3LAiSb9ucroVPwfh6eh3qa4MRDd49BQBQkVMqt89n/O859k1ro
 3NA4GAf+aS6t6wEiKY5W5iAmcNGdqyTKoFPsl/qfVLJO7FvV4Zgpk4Al4JkWmHih1Oye
 RYuQsXvZJQozPpxGxa6EbpbHEKopRBUMBfFHN2/BHoCVNP2q60q+17hUyNiIp8H0DCdp
 KjsimoYy/0/HnUIfoM/0yHtGYzwdYbGEBMsG4Ue+5wJ8SpS6Q3e7OMqSy++6VcBopwDC
 QR1vw6uBofhd5QmfFFUDw+FfMhb52KI5i/iUUHqlgR5d9p8NmE+73CtyQ6LDJIqT0UPd
 7BrQ==
X-Gm-Message-State: ABy/qLamEnywNgxaMaxiyBt4KBJVgmewybQvX/0vyXGeEp0NavF0Bdk0
 //qWjO9ZP7wybesjcFIAt57q658VYse1AXmT9TQ=
X-Google-Smtp-Source: APBJJlEUYuFusdfltxR8ATlF5a6tsU+XnK1sRm0teYlnxhVqAXn+IPrgV4DoG/2h2lbeahTXgYkuskLmiYBAW4zIXeY=
X-Received: by 2002:a81:a087:0:b0:576:f0d6:3d68 with SMTP id
 x129-20020a81a087000000b00576f0d63d68mr11764867ywg.32.1690295437421; Tue, 25
 Jul 2023 07:30:37 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1689857559.git.manos.pitsidianakis@linaro.org>
 <f267d41957025b3849324f459a8ed476aa89f828.1689857559.git.manos.pitsidianakis@linaro.org>
In-Reply-To: <f267d41957025b3849324f459a8ed476aa89f828.1689857559.git.manos.pitsidianakis@linaro.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 25 Jul 2023 18:30:26 +0400
Message-ID: <CAJ+F1C++BFEThXQfu9jETdPZmkx7B4J1scmmSZHy26=-AZYaFA@mail.gmail.com>
Subject: Re: [PATCH v4 06/12] virtio-sound: handle VIRTIO_SND_R_PCM_INFO
 request
To: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, Igor Skalkin <Igor.Skalkin@opensynergy.com>, 
 Anton Yakovlev <Anton.Yakovlev@opensynergy.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>, 
 =?UTF-8?B?S8WRdsOhZ8OzLCBab2x0w6Fu?= <DirtY.iCE.hu@gmail.com>, 
 Alex Bennee <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000001cf23e0601509375"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-yw1-x1134.google.com
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

--0000000000001cf23e0601509375
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 20, 2023 at 4:59=E2=80=AFPM Emmanouil Pitsidianakis <
manos.pitsidianakis@linaro.org> wrote:

> Respond to the VIRTIO_SND_R_PCM_INFO control request with the parameters
> of each requested PCM stream.
>
> Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>  hw/virtio/trace-events |  1 +
>  hw/virtio/virtio-snd.c | 78 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 79 insertions(+)
>
> diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
> index 8a223e36e9..3e619f778b 100644
> --- a/hw/virtio/trace-events
> +++ b/hw/virtio/trace-events
> @@ -164,6 +164,7 @@ virtio_snd_vm_state_stopped(void) "vm state stopped"
>  virtio_snd_realize(void *snd) "snd %p: realize"
>  virtio_snd_unrealize(void *snd) "snd %p: unrealize"
>  virtio_snd_handle_ctrl(void *vdev, void *vq) "snd %p: handle ctrl event
> for queue %p"
> +virtio_snd_handle_pcm_info(uint32_t stream) "VIRTIO_SND_R_PCM_INFO calle=
d
> for stream %"PRIu32
>  virtio_snd_handle_code(uint32_t val, const char *code) "ctrl code msg va=
l
> =3D %"PRIu32" =3D=3D %s"
>  virtio_snd_handle_chmap_info(void) "VIRTIO_SND_CHMAP_INFO called"
>  virtio_snd_handle_event(void) "event queue callback called"
> diff --git a/hw/virtio/virtio-snd.c b/hw/virtio/virtio-snd.c
> index ca09c937c7..3f8b46f372 100644
> --- a/hw/virtio/virtio-snd.c
> +++ b/hw/virtio/virtio-snd.c
> @@ -134,6 +134,19 @@ virtio_snd_set_config(VirtIODevice *vdev, const
> uint8_t *config)
>      memcpy(&s->snd_conf, sndconfig, sizeof(s->snd_conf));
>  }
>
> +/*
> + * Get a specific stream from the virtio sound card device.
> + * Returns NULL if @stream_id is invalid or not allocated.
> + *
> + * @s: VirtIOSound device
> + * @stream_id: stream id
> + */
> +static VirtIOSoundPCMStream *virtio_snd_pcm_get_stream(VirtIOSound *s,
> +                                                       uint32_t stream_i=
d)
> +{
> +    return stream_id >=3D s->snd_conf.streams ? NULL :
> s->pcm->streams[stream_id];
> +}
> +
>  /*
>   * Get params for a specific stream.
>   *
> @@ -147,6 +160,69 @@ static VirtIOSoundPCMParams
> *virtio_snd_pcm_get_params(VirtIOSound *s,
>          : s->pcm->pcm_params[stream_id];
>  }
>
> +/*
> + * Handle the VIRTIO_SND_R_PCM_INFO request.
> + * The function writes the info structs to the request element.
> + *
> + * @s: VirtIOSound device
> + * @cmd: The request command queue element from VirtIOSound cmdq field
> + */
> +static void virtio_snd_handle_pcm_info(VirtIOSound *s,
> +                                       virtio_snd_ctrl_command *cmd)
> +{
> +    virtio_snd_query_info req;
> +    VirtIOSoundPCMStream *stream =3D NULL;
> +    g_autofree virtio_snd_pcm_info *pcm_info =3D NULL;
> +    size_t sz =3D iov_to_buf(cmd->elem->out_sg,
> +                           cmd->elem->out_num,
> +                           0,
> +                           &req,
> +                           sizeof(req));
> +    if (sz !=3D sizeof(virtio_snd_query_info)) {
> +        cmd->resp.code =3D VIRTIO_SND_S_BAD_MSG;
> +        return;
> +    }
> +
> +    if (iov_size(cmd->elem->in_sg, cmd->elem->in_num) <
> +        sizeof(virtio_snd_hdr) + req.size * req.count) {
> +        error_report("pcm info: buffer too small, got: %lu, needed: %lu"=
,
> +                iov_size(cmd->elem->in_sg, cmd->elem->in_num),
> +                sizeof(virtio_snd_pcm_info));
>

../hw/virtio/virtio-snd.c: In function 'virtio_snd_handle_pcm_info':
../hw/virtio/virtio-snd.c:200:22: error: format '%lu' expects argument of
type 'long unsigned int', but argument 2 has type 'size_t' {aka 'long long
unsigned int'} [-Werror=3Dformat=3D]
  200 |         error_report("pcm info: buffer too small, got: %lu, needed:
%lu",
      |
 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  201 |                 iov_size(cmd->elem->in_sg, cmd->elem->in_num),
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      |                 |
      |                 size_t {aka long long unsigned int}
../hw/virtio/virtio-snd.c:200:22: error: format '%lu' expects argument of
type 'long unsigned int', but argument 3 has type 'long long unsigned int'
[-Werror=3Dformat=3D]
  200 |         error_report("pcm info: buffer too small, got: %lu, needed:
%lu",
      |
 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  201 |                 iov_size(cmd->elem->in_sg, cmd->elem->in_num),
  202 |                 sizeof(virtio_snd_pcm_info));
      |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~
      |                 |
      |                 long long unsigned int


> +        cmd->resp.code =3D VIRTIO_SND_S_BAD_MSG;
> +        return;
> +    }
> +
> +    pcm_info =3D g_new0(virtio_snd_pcm_info, req.count);
> +    for (uint32_t i =3D req.start_id; i < req.start_id + req.count; i++)=
 {
> +        trace_virtio_snd_handle_pcm_info(i);
> +        stream =3D virtio_snd_pcm_get_stream(s, i);
> +
> +        if (!stream) {
> +            error_report("Invalid stream id: %"PRIu32, i);
> +            cmd->resp.code =3D VIRTIO_SND_S_BAD_MSG;
> +            return;
> +        }
> +
> +        pcm_info[i - req.start_id].hdr.hda_fn_nid =3D
> stream->info.hdr.hda_fn_nid;
> +        pcm_info[i - req.start_id].features =3D stream->features;
> +        pcm_info[i - req.start_id].formats =3D stream->formats;
> +        pcm_info[i - req.start_id].rates =3D stream->rates;
> +        pcm_info[i - req.start_id].direction =3D stream->direction;
> +        pcm_info[i - req.start_id].channels_min =3D stream->channels_min=
;
> +        pcm_info[i - req.start_id].channels_max =3D stream->channels_max=
;
> +
> +        memset(&pcm_info[i].padding, 0, sizeof(pcm_info[i].padding));
> +    }
> +
> +    cmd->resp.code =3D VIRTIO_SND_S_OK;
> +
> +    iov_from_buf(cmd->elem->in_sg,
> +                 cmd->elem->in_num,
> +                 sizeof(virtio_snd_hdr),
> +                 pcm_info,
> +                 sizeof(virtio_snd_pcm_info) * req.count);
> +}
> +
>  /*
>   * Set the given stream params.
>   * Called by both virtio_snd_handle_pcm_set_params and during device
> @@ -358,6 +434,8 @@ process_cmd(VirtIOSound *s, virtio_snd_ctrl_command
> *cmd)
>          cmd->resp.code =3D VIRTIO_SND_S_NOT_SUPP;
>          break;
>      case VIRTIO_SND_R_PCM_INFO:
> +        virtio_snd_handle_pcm_info(s, cmd);
> +        break;
>      case VIRTIO_SND_R_PCM_SET_PARAMS:
>      case VIRTIO_SND_R_PCM_PREPARE:
>      case VIRTIO_SND_R_PCM_START:
> --
> 2.39.2
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--0000000000001cf23e0601509375
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jul 20, 2023 at 4:59=E2=80=AF=
PM Emmanouil Pitsidianakis &lt;<a href=3D"mailto:manos.pitsidianakis@linaro=
.org">manos.pitsidianakis@linaro.org</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">Respond to the VIRTIO_SND_R_PCM_INFO co=
ntrol request with the parameters<br>
of each requested PCM stream.<br>
<br>
Signed-off-by: Emmanouil Pitsidianakis &lt;<a href=3D"mailto:manos.pitsidia=
nakis@linaro.org" target=3D"_blank">manos.pitsidianakis@linaro.org</a>&gt;<=
br>
---<br>
=C2=A0hw/virtio/trace-events |=C2=A0 1 +<br>
=C2=A0hw/virtio/virtio-snd.c | 78 +++++++++++++++++++++++++++++++++++++++++=
+<br>
=C2=A02 files changed, 79 insertions(+)<br>
<br>
diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events<br>
index 8a223e36e9..3e619f778b 100644<br>
--- a/hw/virtio/trace-events<br>
+++ b/hw/virtio/trace-events<br>
@@ -164,6 +164,7 @@ virtio_snd_vm_state_stopped(void) &quot;vm state stoppe=
d&quot;<br>
=C2=A0virtio_snd_realize(void *snd) &quot;snd %p: realize&quot;<br>
=C2=A0virtio_snd_unrealize(void *snd) &quot;snd %p: unrealize&quot;<br>
=C2=A0virtio_snd_handle_ctrl(void *vdev, void *vq) &quot;snd %p: handle ctr=
l event for queue %p&quot;<br>
+virtio_snd_handle_pcm_info(uint32_t stream) &quot;VIRTIO_SND_R_PCM_INFO ca=
lled for stream %&quot;PRIu32<br>
=C2=A0virtio_snd_handle_code(uint32_t val, const char *code) &quot;ctrl cod=
e msg val =3D %&quot;PRIu32&quot; =3D=3D %s&quot;<br>
=C2=A0virtio_snd_handle_chmap_info(void) &quot;VIRTIO_SND_CHMAP_INFO called=
&quot;<br>
=C2=A0virtio_snd_handle_event(void) &quot;event queue callback called&quot;=
<br>
diff --git a/hw/virtio/virtio-snd.c b/hw/virtio/virtio-snd.c<br>
index ca09c937c7..3f8b46f372 100644<br>
--- a/hw/virtio/virtio-snd.c<br>
+++ b/hw/virtio/virtio-snd.c<br>
@@ -134,6 +134,19 @@ virtio_snd_set_config(VirtIODevice *vdev, const uint8_=
t *config)<br>
=C2=A0 =C2=A0 =C2=A0memcpy(&amp;s-&gt;snd_conf, sndconfig, sizeof(s-&gt;snd=
_conf));<br>
=C2=A0}<br>
<br>
+/*<br>
+ * Get a specific stream from the virtio sound card device.<br>
+ * Returns NULL if @stream_id is invalid or not allocated.<br>
+ *<br>
+ * @s: VirtIOSound device<br>
+ * @stream_id: stream id<br>
+ */<br>
+static VirtIOSoundPCMStream *virtio_snd_pcm_get_stream(VirtIOSound *s,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t stream_id)<br>
+{<br>
+=C2=A0 =C2=A0 return stream_id &gt;=3D s-&gt;snd_conf.streams ? NULL : s-&=
gt;pcm-&gt;streams[stream_id];<br>
+}<br>
+<br>
=C2=A0/*<br>
=C2=A0 * Get params for a specific stream.<br>
=C2=A0 *<br>
@@ -147,6 +160,69 @@ static VirtIOSoundPCMParams *virtio_snd_pcm_get_params=
(VirtIOSound *s,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: s-&gt;pcm-&gt;pcm_params[stream_id];<br=
>
=C2=A0}<br>
<br>
+/*<br>
+ * Handle the VIRTIO_SND_R_PCM_INFO request.<br>
+ * The function writes the info structs to the request element.<br>
+ *<br>
+ * @s: VirtIOSound device<br>
+ * @cmd: The request command queue element from VirtIOSound cmdq field<br>
+ */<br>
+static void virtio_snd_handle_pcm_info(VirtIOSound *s,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0virtio_sn=
d_ctrl_command *cmd)<br>
+{<br>
+=C2=A0 =C2=A0 virtio_snd_query_info req;<br>
+=C2=A0 =C2=A0 VirtIOSoundPCMStream *stream =3D NULL;<br>
+=C2=A0 =C2=A0 g_autofree virtio_snd_pcm_info *pcm_info =3D NULL;<br>
+=C2=A0 =C2=A0 size_t sz =3D iov_to_buf(cmd-&gt;elem-&gt;out_sg,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0cmd-&gt;elem-&gt;out_num,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A00,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0&amp;req,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0sizeof(req));<br>
+=C2=A0 =C2=A0 if (sz !=3D sizeof(virtio_snd_query_info)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd-&gt;resp.code =3D VIRTIO_SND_S_BAD_MSG;<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (iov_size(cmd-&gt;elem-&gt;in_sg, cmd-&gt;elem-&gt;in_num=
) &lt;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 sizeof(virtio_snd_hdr) + req.size * req.count)=
 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;pcm info: buffer too small,=
 got: %lu, needed: %lu&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 iov_size(cmd-&gt;e=
lem-&gt;in_sg, cmd-&gt;elem-&gt;in_num),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sizeof(virtio_snd_=
pcm_info));<br></blockquote><div><br></div><div>../hw/virtio/virtio-snd.c: =
In function &#39;virtio_snd_handle_pcm_info&#39;:<br>../hw/virtio/virtio-sn=
d.c:200:22: error: format &#39;%lu&#39; expects argument of type &#39;long =
unsigned int&#39;, but argument 2 has type &#39;size_t&#39; {aka &#39;long =
long unsigned int&#39;} [-Werror=3Dformat=3D]<br>=C2=A0 200 | =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 error_report(&quot;pcm info: buffer too small, got: %lu, nee=
ded: %lu&quot;,<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~~~~~~~~~<br>=C2=A0 201 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 iov_size(cmd-&gt;elem-&gt;in_sg, cmd-&gt;elem-&gt;in_n=
um),<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~<br>=C2=A0 =C2=
=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |<br>=
=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 size_t {aka long long unsigned int}<br>../hw/virtio/virtio-snd.c:200:22=
: error: format &#39;%lu&#39; expects argument of type &#39;long unsigned i=
nt&#39;, but argument 3 has type &#39;long long unsigned int&#39; [-Werror=
=3Dformat=3D]<br>=C2=A0 200 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quo=
t;pcm info: buffer too small, got: %lu, needed: %lu&quot;,<br>=C2=A0 =C2=A0=
 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~<br>=C2=A0 =
201 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 iov_size(cmd-=
&gt;elem-&gt;in_sg, cmd-&gt;elem-&gt;in_num),<br>=C2=A0 202 | =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sizeof(virtio_snd_pcm_info));<br=
>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 ~~~~~~~~~~~~~~~~~~~~~~~~~~~<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |<br>=C2=A0 =C2=A0 =C2=A0 | =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 long long unsigned int=
<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd-&gt;resp.code =3D VIRTIO_SND_S_BAD_MSG;<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 pcm_info =3D g_new0(virtio_snd_pcm_info, req.count);<br>
+=C2=A0 =C2=A0 for (uint32_t i =3D req.start_id; i &lt; req.start_id + req.=
count; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_virtio_snd_handle_pcm_info(i);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 stream =3D virtio_snd_pcm_get_stream(s, i);<br=
>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!stream) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;Invalid strea=
m id: %&quot;PRIu32, i);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd-&gt;resp.code =3D VIRTIO_SND=
_S_BAD_MSG;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pcm_info[i - req.start_id].hdr.hda_fn_nid =3D =
stream-&gt;info.hdr.hda_fn_nid;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pcm_info[i - req.start_id].features =3D stream=
-&gt;features;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pcm_info[i - req.start_id].formats =3D stream-=
&gt;formats;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pcm_info[i - req.start_id].rates =3D stream-&g=
t;rates;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pcm_info[i - req.start_id].direction =3D strea=
m-&gt;direction;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pcm_info[i - req.start_id].channels_min =3D st=
ream-&gt;channels_min;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pcm_info[i - req.start_id].channels_max =3D st=
ream-&gt;channels_max;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 memset(&amp;pcm_info[i].padding, 0, sizeof(pcm=
_info[i].padding));<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 cmd-&gt;resp.code =3D VIRTIO_SND_S_OK;<br>
+<br>
+=C2=A0 =C2=A0 iov_from_buf(cmd-&gt;elem-&gt;in_sg,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cmd-&gt;elem=
-&gt;in_num,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sizeof(virti=
o_snd_hdr),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pcm_info,<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sizeof(virti=
o_snd_pcm_info) * req.count);<br>
+}<br>
+<br>
=C2=A0/*<br>
=C2=A0 * Set the given stream params.<br>
=C2=A0 * Called by both virtio_snd_handle_pcm_set_params and during device<=
br>
@@ -358,6 +434,8 @@ process_cmd(VirtIOSound *s, virtio_snd_ctrl_command *cm=
d)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cmd-&gt;resp.code =3D VIRTIO_SND_S_NOT_SU=
PP;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0case VIRTIO_SND_R_PCM_INFO:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 virtio_snd_handle_pcm_info(s, cmd);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
=C2=A0 =C2=A0 =C2=A0case VIRTIO_SND_R_PCM_SET_PARAMS:<br>
=C2=A0 =C2=A0 =C2=A0case VIRTIO_SND_R_PCM_PREPARE:<br>
=C2=A0 =C2=A0 =C2=A0case VIRTIO_SND_R_PCM_START:<br>
-- <br>
2.39.2<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=
=A9 Lureau<br></div></div>

--0000000000001cf23e0601509375--

