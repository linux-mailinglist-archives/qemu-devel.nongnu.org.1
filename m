Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 940F7761A29
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 15:39:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOIFE-00026z-Jz; Tue, 25 Jul 2023 09:38:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qOIFC-00026f-K7
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 09:38:30 -0400
Received: from mail-yb1-xb30.google.com ([2607:f8b0:4864:20::b30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qOIFA-00084g-JS
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 09:38:30 -0400
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-d08658c7713so3651886276.3
 for <qemu-devel@nongnu.org>; Tue, 25 Jul 2023 06:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690292307; x=1690897107;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6RRhr/9qcWR1Bc0TD35MGocQD/U0oNJCtSX61e9q3bs=;
 b=UGUdVO4DBlm4JQf26SBJeuoq/ttS3Fy8HC2i4hj4maAniyz8y30Sx7XJcCbOc8ZTQn
 6yKR7dD4HDz8/h+R0F/GK5PInoWzizmnSvsrx7AmhifkcVxBtiqzoVT+fwpdrg2i1TWu
 wkuPS6lzOgUcX2MvYPrY8jiADjghLrrmT+QsnyN2XPq0inQEe0t5oXmfbEAS19zST3tV
 f/QQynNXO1ayd2zGxybzdWw6794ILUArfI849c8NYMfucVU9MImQhwFJZ2KH4TKE8+LH
 6IcM4LbY0CfNbmPLrWpGoWj0pVLkOBw6jox89eKU8JQ7lv+ynYnYxmiFb9Hn1VqIaslc
 sQJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690292307; x=1690897107;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6RRhr/9qcWR1Bc0TD35MGocQD/U0oNJCtSX61e9q3bs=;
 b=JUJlXnzxqI4n98lYBzSgbEXPQx0LPm3qZKoweSsOjH1jaAstmJ3PYq96Ad7I2ZCWMU
 yIKQ8oe3MzSPwk3Hf3erSBAdFADpR3ykbl2WYiGQxngK+WhgiYF3h8GnBz9GU8JrGJWt
 4K+JruJztAoE9NqjU2zuta1XsepgQqMRgKRishG02bfY/2Ncj1eX3SkCwtpbYvMtn0VS
 GzBbZ28/xed5pUDeZjU9GIoCHxVYjaOrnouIdjQpv6gRvuKysh1HVkgmXh5gQ26J+wXL
 Z1OzbqVa6dme7sdmmio8FaOs6pc2gaEEQucj9JIGjqRuNfCt84yQwG/1fTS9TrmVCQT1
 bsLw==
X-Gm-Message-State: ABy/qLZ+vg5lGJtcoEOtvISBOB0l8fq+P9SgfKPfMhSwd9yTs9oQPVo1
 27SHbQgeEbEt71S6kQXtZMSFkB8h8SB8EvSRf6E=
X-Google-Smtp-Source: APBJJlErUJy4PMFMpvj+cW/Yx015/GYKU+NlVh0wEubmf6ybIVhTFAgnosC83Km9wS1FNJEpO8ngyWZb406Oyk4YP6s=
X-Received: by 2002:a25:8184:0:b0:d0c:5868:5144 with SMTP id
 p4-20020a258184000000b00d0c58685144mr6352932ybk.64.1690292307097; Tue, 25 Jul
 2023 06:38:27 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1689857559.git.manos.pitsidianakis@linaro.org>
 <68a13c43854d00efd62e43f3525a555ff83794bf.1689857559.git.manos.pitsidianakis@linaro.org>
In-Reply-To: <68a13c43854d00efd62e43f3525a555ff83794bf.1689857559.git.manos.pitsidianakis@linaro.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 25 Jul 2023 17:38:14 +0400
Message-ID: <CAJ+F1CKfRzinY51ks=3MxF+jg+_5=mOxW1h=04YW2=73+PMHOg@mail.gmail.com>
Subject: Re: [PATCH v4 05/12] virtio-sound: prepare PCM streams
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
Content-Type: multipart/alternative; boundary="00000000000087fc6906014fd8d7"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b30;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-yb1-xb30.google.com
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

--00000000000087fc6906014fd8d7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Thu, Jul 20, 2023 at 4:59=E2=80=AFPM Emmanouil Pitsidianakis <
manos.pitsidianakis@linaro.org> wrote:

> After setting PCM parameters, instantiate ("prepare") each stream in
> virtio_snd_pcm_prepare_impl().
>
> Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>  hw/virtio/virtio-snd.c | 133 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 133 insertions(+)
>
> diff --git a/hw/virtio/virtio-snd.c b/hw/virtio/virtio-snd.c
> index 62d9bf557c..ca09c937c7 100644
> --- a/hw/virtio/virtio-snd.c
> +++ b/hw/virtio/virtio-snd.c
> @@ -200,6 +200,132 @@ uint32_t virtio_snd_pcm_set_params_impl(VirtIOSound
> *s,
>      return VIRTIO_SND_S_OK;
>  }
>
> +/*
> + * Get a QEMU Audiosystem compatible format value from a
> VIRTIO_SND_PCM_FMT_*
> + */
> +static AudioFormat virtio_snd_get_qemu_format(uint32_t format)
> +{
> +    #define CASE(FMT)               \
> +    case VIRTIO_SND_PCM_FMT_##FMT:  \
> +        return AUDIO_FORMAT_##FMT;
> +
> +    switch (format) {
> +    CASE(U8)
> +    CASE(S8)
> +    CASE(U16)
> +    CASE(S16)
> +    CASE(U32)
> +    CASE(S32)
> +    case VIRTIO_SND_PCM_FMT_FLOAT:
> +        return AUDIO_FORMAT_F32;
> +    default:
> +        g_assert_not_reached();
> +    }
> +
> +    #undef CASE
> +}
> +
> +/*
> + * Get a QEMU Audiosystem compatible frequency value from a
> + * VIRTIO_SND_PCM_RATE_*
> + */
> +static uint32_t virtio_snd_get_qemu_freq(uint32_t rate)
> +{
> +    #define CASE(RATE)               \
> +    case VIRTIO_SND_PCM_RATE_##RATE: \
> +        return RATE;
> +
> +    switch (rate) {
> +    CASE(5512)
> +    CASE(8000)
> +    CASE(11025)
> +    CASE(16000)
> +    CASE(22050)
> +    CASE(32000)
> +    CASE(44100)
> +    CASE(48000)
> +    CASE(64000)
> +    CASE(88200)
> +    CASE(96000)
> +    CASE(176400)
> +    CASE(192000)
> +    CASE(384000)
> +    default:
> +        g_assert_not_reached();
> +    }
> +
> +    #undef CASE
> +}
> +
> +/*
> + * Get QEMU Audiosystem compatible audsettings from virtio based pcm
> stream
> + * params.
> + */
> +static void virtio_snd_get_qemu_audsettings(audsettings *as,
> +                                            VirtIOSoundPCMParams *params=
)
> +{
> +    as->nchannels =3D MIN(AUDIO_MAX_CHANNELS, params->channels);
> +    as->fmt =3D virtio_snd_get_qemu_format(params->format);
> +    as->freq =3D virtio_snd_get_qemu_freq(params->rate);
> +    as->endianness =3D AUDIO_HOST_ENDIANNESS;
> +}
> +
> +/*
> + * Prepares a VirtIOSound card stream.
> + * Returns the response status code. (VIRTIO_SND_S_*).
> + *
> + * @s: VirtIOSound device
> + * @stream_id: stream id
> + */
> +static uint32_t virtio_snd_pcm_prepare_impl(VirtIOSound *s, uint32_t
> stream_id)
> +{
> +    audsettings as;
> +    VirtIOSoundPCMParams *params;
> +    VirtIOSoundPCMStream *stream;
> +
> +    if (!s->pcm->streams ||
> +        !s->pcm->pcm_params ||
> +        !s->pcm->pcm_params[stream_id]) {
> +        return VIRTIO_SND_S_BAD_MSG;
> +    }
> +
> +    params =3D virtio_snd_pcm_get_params(s, stream_id);
> +    if (!params) {
> +        return VIRTIO_SND_S_BAD_MSG;
> +    }
> +
> +    virtio_snd_get_qemu_audsettings(&as, params);
> +
> +    stream =3D g_new0(VirtIOSoundPCMStream, 1);
> +
> +    stream->id =3D stream_id;
> +    stream->pcm =3D s->pcm;
> +    stream->direction =3D stream_id < s->snd_conf.streams / 2 +
> +        (s->snd_conf.streams & 1) ? VIRTIO_SND_D_OUTPUT :
> VIRTIO_SND_D_INPUT;
> +    stream->info.hdr.hda_fn_nid =3D VIRTIO_SOUND_HDA_FN_NID;
> +    stream->features =3D 0;
> +    stream->channels_min =3D 1;
> +    stream->channels_max =3D as.nchannels;
> +    stream->formats =3D supported_formats;
> +    stream->rates =3D supported_rates;
> +    stream->s =3D s;
> +
> +    stream->buffer_bytes =3D params->buffer_bytes;
> +    stream->period_bytes =3D params->period_bytes;
> +
> +    stream->positions[0] =3D VIRTIO_SND_CHMAP_FL;
> +    stream->positions[1] =3D VIRTIO_SND_CHMAP_FR;
> +
> +    stream->as =3D as;
> +    stream->desired_as =3D stream->as;
> +    qemu_mutex_init(&stream->queue_mutex);
> +    QSIMPLEQ_INIT(&stream->queue);
> +
> +    s->pcm->streams[stream_id] =3D stream;
>

Shouldn't it close & free the existing stream? Or return an error?


> +
> +    return VIRTIO_SND_S_OK;
> +}
> +
>  /*
>   * The actual processing done in virtio_snd_process_cmdq().
>   *
> @@ -432,6 +558,13 @@ static void virtio_snd_common_realize(DeviceState
> *dev,
>                         print_code(status));
>              return;
>          }
> +        status =3D virtio_snd_pcm_prepare_impl(vsnd, i);
> +        if (status !=3D VIRTIO_SND_S_OK) {
> +            error_setg(errp,
> +                       "Can't prepare streams, device responded with %s.=
",
> +                       print_code(status));
> +            return;
> +        }
>      }
>  }
>
> --
> 2.39.2
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--00000000000087fc6906014fd8d7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jul 20, 2023 at 4:59=E2=80=
=AFPM Emmanouil Pitsidianakis &lt;<a href=3D"mailto:manos.pitsidianakis@lin=
aro.org">manos.pitsidianakis@linaro.org</a>&gt; wrote:<br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">After setting PCM parameters, instan=
tiate (&quot;prepare&quot;) each stream in<br>
virtio_snd_pcm_prepare_impl().<br>
<br>
Signed-off-by: Emmanouil Pitsidianakis &lt;<a href=3D"mailto:manos.pitsidia=
nakis@linaro.org" target=3D"_blank">manos.pitsidianakis@linaro.org</a>&gt;<=
br>
---<br>
=C2=A0hw/virtio/virtio-snd.c | 133 ++++++++++++++++++++++++++++++++++++++++=
+<br>
=C2=A01 file changed, 133 insertions(+)<br>
<br>
diff --git a/hw/virtio/virtio-snd.c b/hw/virtio/virtio-snd.c<br>
index 62d9bf557c..ca09c937c7 100644<br>
--- a/hw/virtio/virtio-snd.c<br>
+++ b/hw/virtio/virtio-snd.c<br>
@@ -200,6 +200,132 @@ uint32_t virtio_snd_pcm_set_params_impl(VirtIOSound *=
s,<br>
=C2=A0 =C2=A0 =C2=A0return VIRTIO_SND_S_OK;<br>
=C2=A0}<br>
<br>
+/*<br>
+ * Get a QEMU Audiosystem compatible format value from a VIRTIO_SND_PCM_FM=
T_*<br>
+ */<br>
+static AudioFormat virtio_snd_get_qemu_format(uint32_t format)<br>
+{<br>
+=C2=A0 =C2=A0 #define CASE(FMT)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0\<br>
+=C2=A0 =C2=A0 case VIRTIO_SND_PCM_FMT_##FMT:=C2=A0 \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return AUDIO_FORMAT_##FMT;<br>
+<br>
+=C2=A0 =C2=A0 switch (format) {<br>
+=C2=A0 =C2=A0 CASE(U8)<br>
+=C2=A0 =C2=A0 CASE(S8)<br>
+=C2=A0 =C2=A0 CASE(U16)<br>
+=C2=A0 =C2=A0 CASE(S16)<br>
+=C2=A0 =C2=A0 CASE(U32)<br>
+=C2=A0 =C2=A0 CASE(S32)<br>
+=C2=A0 =C2=A0 case VIRTIO_SND_PCM_FMT_FLOAT:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return AUDIO_FORMAT_F32;<br>
+=C2=A0 =C2=A0 default:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert_not_reached();<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 #undef CASE<br>
+}<br>
+<br>
+/*<br>
+ * Get a QEMU Audiosystem compatible frequency value from a<br>
+ * VIRTIO_SND_PCM_RATE_*<br>
+ */<br>
+static uint32_t virtio_snd_get_qemu_freq(uint32_t rate)<br>
+{<br>
+=C2=A0 =C2=A0 #define CASE(RATE)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0\<br>
+=C2=A0 =C2=A0 case VIRTIO_SND_PCM_RATE_##RATE: \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return RATE;<br>
+<br>
+=C2=A0 =C2=A0 switch (rate) {<br>
+=C2=A0 =C2=A0 CASE(5512)<br>
+=C2=A0 =C2=A0 CASE(8000)<br>
+=C2=A0 =C2=A0 CASE(11025)<br>
+=C2=A0 =C2=A0 CASE(16000)<br>
+=C2=A0 =C2=A0 CASE(22050)<br>
+=C2=A0 =C2=A0 CASE(32000)<br>
+=C2=A0 =C2=A0 CASE(44100)<br>
+=C2=A0 =C2=A0 CASE(48000)<br>
+=C2=A0 =C2=A0 CASE(64000)<br>
+=C2=A0 =C2=A0 CASE(88200)<br>
+=C2=A0 =C2=A0 CASE(96000)<br>
+=C2=A0 =C2=A0 CASE(176400)<br>
+=C2=A0 =C2=A0 CASE(192000)<br>
+=C2=A0 =C2=A0 CASE(384000)<br>
+=C2=A0 =C2=A0 default:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_assert_not_reached();<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 #undef CASE<br>
+}<br>
+<br>
+/*<br>
+ * Get QEMU Audiosystem compatible audsettings from virtio based pcm strea=
m<br>
+ * params.<br>
+ */<br>
+static void virtio_snd_get_qemu_audsettings(audsettings *as,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 VirtIOSoundPCMParams *params)<br>
+{<br>
+=C2=A0 =C2=A0 as-&gt;nchannels =3D MIN(AUDIO_MAX_CHANNELS, params-&gt;chan=
nels);<br>
+=C2=A0 =C2=A0 as-&gt;fmt =3D virtio_snd_get_qemu_format(params-&gt;format)=
;<br>
+=C2=A0 =C2=A0 as-&gt;freq =3D virtio_snd_get_qemu_freq(params-&gt;rate);<b=
r>
+=C2=A0 =C2=A0 as-&gt;endianness =3D AUDIO_HOST_ENDIANNESS;<br>
+}<br>
+<br>
+/*<br>
+ * Prepares a VirtIOSound card stream.<br>
+ * Returns the response status code. (VIRTIO_SND_S_*).<br>
+ *<br>
+ * @s: VirtIOSound device<br>
+ * @stream_id: stream id<br>
+ */<br>
+static uint32_t virtio_snd_pcm_prepare_impl(VirtIOSound *s, uint32_t strea=
m_id)<br>
+{<br>
+=C2=A0 =C2=A0 audsettings as;<br>
+=C2=A0 =C2=A0 VirtIOSoundPCMParams *params;<br>
+=C2=A0 =C2=A0 VirtIOSoundPCMStream *stream;<br>
+<br>
+=C2=A0 =C2=A0 if (!s-&gt;pcm-&gt;streams ||<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 !s-&gt;pcm-&gt;pcm_params ||<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 !s-&gt;pcm-&gt;pcm_params[stream_id]) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return VIRTIO_SND_S_BAD_MSG;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 params =3D virtio_snd_pcm_get_params(s, stream_id);<br>
+=C2=A0 =C2=A0 if (!params) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return VIRTIO_SND_S_BAD_MSG;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 virtio_snd_get_qemu_audsettings(&amp;as, params);<br>
+<br>
+=C2=A0 =C2=A0 stream =3D g_new0(VirtIOSoundPCMStream, 1);<br>
+<br>
+=C2=A0 =C2=A0 stream-&gt;id =3D stream_id;<br>
+=C2=A0 =C2=A0 stream-&gt;pcm =3D s-&gt;pcm;<br>
+=C2=A0 =C2=A0 stream-&gt;direction =3D stream_id &lt; s-&gt;snd_conf.strea=
ms / 2 +<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 (s-&gt;snd_conf.streams &amp; 1) ? VIRTIO_SND_=
D_OUTPUT : VIRTIO_SND_D_INPUT;<br>
+=C2=A0 =C2=A0 stream-&gt;info.hdr.hda_fn_nid =3D VIRTIO_SOUND_HDA_FN_NID;<=
br>
+=C2=A0 =C2=A0 stream-&gt;features =3D 0;<br>
+=C2=A0 =C2=A0 stream-&gt;channels_min =3D 1;<br>
+=C2=A0 =C2=A0 stream-&gt;channels_max =3D as.nchannels;<br>
+=C2=A0 =C2=A0 stream-&gt;formats =3D supported_formats;<br>
+=C2=A0 =C2=A0 stream-&gt;rates =3D supported_rates;<br>
+=C2=A0 =C2=A0 stream-&gt;s =3D s;<br>
+<br>
+=C2=A0 =C2=A0 stream-&gt;buffer_bytes =3D params-&gt;buffer_bytes;<br>
+=C2=A0 =C2=A0 stream-&gt;period_bytes =3D params-&gt;period_bytes;<br>
+<br>
+=C2=A0 =C2=A0 stream-&gt;positions[0] =3D VIRTIO_SND_CHMAP_FL;<br>
+=C2=A0 =C2=A0 stream-&gt;positions[1] =3D VIRTIO_SND_CHMAP_FR;<br>
+<br>
+=C2=A0 =C2=A0 stream-&gt;as =3D as;<br>
+=C2=A0 =C2=A0 stream-&gt;desired_as =3D stream-&gt;as;<br>
+=C2=A0 =C2=A0 qemu_mutex_init(&amp;stream-&gt;queue_mutex);<br>
+=C2=A0 =C2=A0 QSIMPLEQ_INIT(&amp;stream-&gt;queue);<br>
+<br>
+=C2=A0 =C2=A0 s-&gt;pcm-&gt;streams[stream_id] =3D stream;<br></blockquote=
><div><br></div><div>Shouldn&#39;t it close &amp; free the existing stream?=
 Or return an error?</div><div>=C2=A0<br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">
+<br>
+=C2=A0 =C2=A0 return VIRTIO_SND_S_OK;<br>
+}<br>
+<br>
=C2=A0/*<br>
=C2=A0 * The actual processing done in virtio_snd_process_cmdq().<br>
=C2=A0 *<br>
@@ -432,6 +558,13 @@ static void virtio_snd_common_realize(DeviceState *dev=
,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 print_code(status));<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 status =3D virtio_snd_pcm_prepare_impl(vsnd, i=
);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (status !=3D VIRTIO_SND_S_OK) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&quot;Can&#39;t prepare streams, device responded with %s.&quot;,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0print_code(status));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
-- <br>
2.39.2<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=
=A9 Lureau<br></div></div>

--00000000000087fc6906014fd8d7--

