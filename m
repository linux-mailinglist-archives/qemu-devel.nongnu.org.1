Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C141982527F
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 11:58:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLhtl-0003nP-8t; Fri, 05 Jan 2024 05:57:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1rLhtj-0003n3-Ap
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 05:57:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1rLhth-00031H-LK
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 05:57:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704452272;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N9Iuy1O/MzSQAIE19zAD+fanRbhxddtcavkTM5bywOY=;
 b=B/heW3EVm9kfmhuSM0qtSJ+QIHNBBlHAHi63GEYSG1jDqwY6iTMZDH5dtCN+26RPgybvML
 gVFD+HuY+GnIBePi+icbUIJCr7XTXG/Jlt9Ga8rzrkOBDTF9XZnvDZwReA4V4A/+2V+PCA
 DVl2WuWbb+i5znXlJuttndQa+JfBgRQ=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-t8d3vmoGNhilmEadvIB0HA-1; Fri, 05 Jan 2024 05:57:50 -0500
X-MC-Unique: t8d3vmoGNhilmEadvIB0HA-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-5560cd16f03so853145a12.2
 for <qemu-devel@nongnu.org>; Fri, 05 Jan 2024 02:57:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704452270; x=1705057070;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N9Iuy1O/MzSQAIE19zAD+fanRbhxddtcavkTM5bywOY=;
 b=eRgjC0saQRJw4GfFUbTOBeXIEhxZd5R7jxYimfdoV8UErJWx16MWsvu0dhkdmyhcup
 BE1nlfIijCr0782OXhXYE1ECqa0rokpy/0vF3wkENVuzxFKUSe3PMTepdWe2lnVXjxh6
 fulEAfpFG+A5XMHYWE9RIXF1q35BOh5j0HYaJ9dSYSwrlNRD5Ezuti0/6Zfsl6NQcmep
 il0SFE9mrTubja832IYfNsOyHONjI5bOc9pl7s35g+zmc6fpS6IQ4/otmZvRJi9zbKy7
 Rxr8Y1FQfYLMzDdxGW9HRaoKdqafhfmL5R9ONJjz6agyviDHDtON2NJmkCEW5XeChLgD
 8Mzg==
X-Gm-Message-State: AOJu0Yz+0IQC+RBlPZpfbgfNYz7hSQyIESRr/PbwHdwWXkKKUxdy04fq
 0S83VnheNNuGS8qIL4j3R2AGtEnNf/ZAcGi7GWRkaSyL3KF9viqvONzvjhpF76R0RsFasUyWZ9s
 pf2DC5HgjbHNi5CsEuu10dmsjKo+x1RjgPNilZO0=
X-Received: by 2002:a50:9308:0:b0:553:739e:bfac with SMTP id
 m8-20020a509308000000b00553739ebfacmr1155761eda.8.1704452269872; 
 Fri, 05 Jan 2024 02:57:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGEkkdilOJ/kotKXsYobUSA3IjYU8QOZuX5T7RPd5lulXrrPVc2vVA9MnVX+XXNQNhMr6vmqcj+DKmDtF+qxPE=
X-Received: by 2002:a50:9308:0:b0:553:739e:bfac with SMTP id
 m8-20020a509308000000b00553739ebfacmr1155754eda.8.1704452269595; Fri, 05 Jan
 2024 02:57:49 -0800 (PST)
MIME-Version: 1.0
References: <b416aee3-72a9-4642-b219-3e1800ee5b3c@t-online.de>
 <20240104203422.12308-3-vr_qemu@t-online.de>
In-Reply-To: <20240104203422.12308-3-vr_qemu@t-online.de>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 5 Jan 2024 14:57:38 +0400
Message-ID: <CAMxuvax9fswBrmQ9VnG=ZA-hF_BZPPY70o-iyyLNi_f+WxydOA@mail.gmail.com>
Subject: Re: [PATCH 03/10] hw/audio/virtio-sound: split out
 virtio_snd_pcm_start_stop()
To: =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.691,
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

On Fri, Jan 5, 2024 at 12:34=E2=80=AFAM Volker R=C3=BCmelin <vr_qemu@t-onli=
ne.de> wrote:
>
> Split out virtio_snd_pcm_start_stop(). This is a preparation
> for the next patch so that it doesn't become too big.
>
> Signed-off-by: Volker R=C3=BCmelin <vr_qemu@t-online.de>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  hw/audio/trace-events |  3 ++-
>  hw/audio/virtio-snd.c | 57 ++++++++++++++++++++++++++++---------------
>  2 files changed, 39 insertions(+), 21 deletions(-)
>
> diff --git a/hw/audio/trace-events b/hw/audio/trace-events
> index b1870ff224..7554bfcc60 100644
> --- a/hw/audio/trace-events
> +++ b/hw/audio/trace-events
> @@ -50,7 +50,8 @@ virtio_snd_unrealize(void *snd) "snd %p: unrealize"
>  virtio_snd_handle_pcm_set_params(uint32_t stream) "VIRTIO_SND_PCM_SET_PA=
RAMS called for stream %"PRIu32
>  virtio_snd_handle_ctrl(void *vdev, void *vq) "snd %p: handle ctrl event =
for queue %p"
>  virtio_snd_handle_pcm_info(uint32_t stream) "VIRTIO_SND_R_PCM_INFO calle=
d for stream %"PRIu32
> -virtio_snd_handle_pcm_start_stop(const char *code, uint32_t stream) "%s =
called for stream %"PRIu32
> +virtio_snd_handle_pcm_start(uint32_t stream) "VIRTIO_SND_R_PCM_START cal=
led for stream %"PRIu32
> +virtio_snd_handle_pcm_stop(uint32_t stream) "VIRTIO_SND_R_PCM_STOP calle=
d for stream %"PRIu32
>  virtio_snd_handle_pcm_release(uint32_t stream) "VIRTIO_SND_PCM_RELEASE c=
alled for stream %"PRIu32
>  virtio_snd_handle_code(uint32_t val, const char *code) "ctrl code msg va=
l =3D %"PRIu32" =3D=3D %s"
>  virtio_snd_handle_chmap_info(void) "VIRTIO_SND_CHMAP_INFO called"
> diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
> index 36b1bb502c..040bc32ebe 100644
> --- a/hw/audio/virtio-snd.c
> +++ b/hw/audio/virtio-snd.c
> @@ -534,7 +534,42 @@ static void virtio_snd_handle_pcm_prepare(VirtIOSoun=
d *s,
>  }
>
>  /*
> - * Handles VIRTIO_SND_R_PCM_START.
> + * Starts/Stops a VirtIOSound card stream.
> + * Returns the response status code. (VIRTIO_SND_S_*).
> + *
> + * @s: VirtIOSound device
> + * @stream_id: stream id
> + * @start: whether to start or stop the stream
> + */
> +static uint32_t virtio_snd_pcm_start_stop(VirtIOSound *s,
> +                                          uint32_t stream_id,
> +                                          bool start)
> +{
> +    VirtIOSoundPCMStream *stream;
> +
> +    stream =3D virtio_snd_pcm_get_stream(s, stream_id);
> +    if (!stream) {
> +        return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
> +    }
> +
> +    if (start) {
> +        trace_virtio_snd_handle_pcm_start(stream_id);
> +    } else {
> +        trace_virtio_snd_handle_pcm_stop(stream_id);
> +    }
> +
> +    stream->active =3D start;
> +    if (stream->info.direction =3D=3D VIRTIO_SND_D_OUTPUT) {
> +        AUD_set_active_out(stream->voice.out, start);
> +    } else {
> +        AUD_set_active_in(stream->voice.in, start);
> +    }
> +
> +    return cpu_to_le32(VIRTIO_SND_S_OK);
> +}
> +
> +/*
> + * Handles VIRTIO_SND_R_PCM_START and VIRTIO_SND_R_PCM_STOP.
>   *
>   * @s: VirtIOSound device
>   * @cmd: The request command queue element from VirtIOSound cmdq field
> @@ -544,7 +579,6 @@ static void virtio_snd_handle_pcm_start_stop(VirtIOSo=
und *s,
>                                               virtio_snd_ctrl_command *cm=
d,
>                                               bool start)
>  {
> -    VirtIOSoundPCMStream *stream;
>      virtio_snd_pcm_hdr req;
>      uint32_t stream_id;
>      size_t msg_sz =3D iov_to_buf(cmd->elem->out_sg,
> @@ -562,24 +596,7 @@ static void virtio_snd_handle_pcm_start_stop(VirtIOS=
ound *s,
>      }
>
>      stream_id =3D le32_to_cpu(req.stream_id);
> -    cmd->resp.code =3D cpu_to_le32(VIRTIO_SND_S_OK);
> -    trace_virtio_snd_handle_pcm_start_stop(start ? "VIRTIO_SND_R_PCM_STA=
RT" :
> -            "VIRTIO_SND_R_PCM_STOP", stream_id);
> -
> -    stream =3D virtio_snd_pcm_get_stream(s, stream_id);
> -    if (stream) {
> -        stream->active =3D start;
> -        if (stream->info.direction =3D=3D VIRTIO_SND_D_OUTPUT) {
> -            AUD_set_active_out(stream->voice.out, start);
> -        } else {
> -            AUD_set_active_in(stream->voice.in, start);
> -        }
> -    } else {
> -        error_report("Invalid stream id: %"PRIu32, stream_id);
> -        cmd->resp.code =3D cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
> -        return;
> -    }
> -    stream->active =3D start;
> +    cmd->resp.code =3D virtio_snd_pcm_start_stop(s, stream_id, start);
>  }
>
>  /*
> --
> 2.35.3
>


