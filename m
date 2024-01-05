Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CD83E8252FE
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 12:38:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLiVl-0005XX-7w; Fri, 05 Jan 2024 06:37:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1rLiVh-0005Wf-0c
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 06:37:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1rLiVe-00076A-H7
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 06:37:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704454624;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/AF7UZ0kIvzE4wEVF2e7piXtnsH7yKeM9MTSq/f0xqY=;
 b=X2UdFqt3wslfoTCCL3VJ6+Ap5dbaZqR6LIpHeQnO6AgRi4QLSb7u56V/nU5E/4WIlb7KDG
 SCaCThBhh0GcQYfUy8VjmqcG6oaXl+9Jd98MQL0HoQgV0ayQtpphBgzFXbSHepevSz05h9
 F61965xibq+PB6vdjjkzPHZ2LoHzQoA=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-JNcQuxW4NqmmevYuy3vUPw-1; Fri, 05 Jan 2024 06:37:03 -0500
X-MC-Unique: JNcQuxW4NqmmevYuy3vUPw-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-556c3940061so841658a12.3
 for <qemu-devel@nongnu.org>; Fri, 05 Jan 2024 03:37:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704454621; x=1705059421;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/AF7UZ0kIvzE4wEVF2e7piXtnsH7yKeM9MTSq/f0xqY=;
 b=dKCwXHiPjIgC4L/2MpxLdITK0oO6qHbuWtP9XPPVmHKcuukg6ET6mvzgVQHxDYnhEx
 zd0UowHdiThhLnXBIFEBPdr0rcFqmG8clz9NfK2Lx+47LwH1fwxcNgaYgs8BdVjs+wiv
 XzPKvvZkJkliz1Jzdr9HzE5b4ujJFOre6DeBUYXxS+WpjdDhB+9Aa+IrHE3yCurSVpWa
 dcR+iaMzPAKM6qNoTdnpq+wJn95Yfs+dWRTyZX0xUMjE6fD4IMQlwavY8Y0ffpej6Y/A
 KZX/c+kAoUf/52q7I1bdO583uzphjOtsZaF6lTI28Yu7uc5ryYXST9Dt7ilEZxQAeory
 izzw==
X-Gm-Message-State: AOJu0YzeK6u/ZFQiqj3oTIsYw1EUOgrtaUXRvLswrXQjhT7dl1FmsYCE
 E5VEhe0Fam71+G5zcKIRfk4FT/n2jg+pWbDm40bdjXkOZVwIHqESeP3N27Vc9QlG4neCfBWbZN8
 yNWRsm5ecd74NHoF6Zchw96RTJWGbfn+Rb2s0mAQ3WlRsFEL3dg==
X-Received: by 2002:a50:f603:0:b0:557:2af4:ae80 with SMTP id
 c3-20020a50f603000000b005572af4ae80mr426735edn.65.1704454621277; 
 Fri, 05 Jan 2024 03:37:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFmaq8XqWJTNVGvSI3lFsjb8k6VeUuX46s8jQzvD7QEGj1d4XCuRfWmGfvYmCh203QnKQobQiY9rQjsbseYLfM=
X-Received: by 2002:a50:f603:0:b0:557:2af4:ae80 with SMTP id
 c3-20020a50f603000000b005572af4ae80mr426731edn.65.1704454621018; Fri, 05 Jan
 2024 03:37:01 -0800 (PST)
MIME-Version: 1.0
References: <b416aee3-72a9-4642-b219-3e1800ee5b3c@t-online.de>
 <20240104203422.12308-5-vr_qemu@t-online.de>
In-Reply-To: <20240104203422.12308-5-vr_qemu@t-online.de>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Fri, 5 Jan 2024 15:36:49 +0400
Message-ID: <CAMxuvazLnP-_PC-0PbxNncp1C+HzZOwvvmNwbdrLUxgY7eMcqA@mail.gmail.com>
Subject: Re: [PATCH 05/10] hw/audio/virtio-sound: return correct command
 response size
To: =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.691,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi

On Fri, Jan 5, 2024 at 12:34=E2=80=AFAM Volker R=C3=BCmelin <vr_qemu@t-onli=
ne.de> wrote:
>
> The payload size returned by command VIRTIO_SND_R_PCM_INFO is
> wrong. The code in process_cmd() assumes that all commands
> return only a virtio_snd_hdr payload, but some commands like
> VIRTIO_SND_R_PCM_INFO may return an additional payload.
>
> Add a zero initialized payload_size variable to struct
> virtio_snd_ctrl_command to allow for additional payloads.
>
> Signed-off-by: Volker R=C3=BCmelin <vr_qemu@t-online.de>
> ---
>  hw/audio/virtio-snd.c         | 7 +++++--
>  include/hw/audio/virtio-snd.h | 1 +
>  2 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
> index a2817a64b5..9f3269d72b 100644
> --- a/hw/audio/virtio-snd.c
> +++ b/hw/audio/virtio-snd.c
> @@ -262,12 +262,13 @@ static void virtio_snd_handle_pcm_info(VirtIOSound =
*s,
>          memset(&pcm_info[i].padding, 0, 5);
>      }
>
> +    cmd->payload_size =3D sizeof(virtio_snd_pcm_info) * count;
>      cmd->resp.code =3D cpu_to_le32(VIRTIO_SND_S_OK);
>      iov_from_buf(cmd->elem->in_sg,
>                   cmd->elem->in_num,
>                   sizeof(virtio_snd_hdr),
>                   pcm_info,
> -                 sizeof(virtio_snd_pcm_info) * count);
> +                 cmd->payload_size);

iov_from_buf() return value should probably be checked to match the
expected written size..

The earlier check for iov_size() is then probably redundant. Hmm, it
checks for req.size, which should probably match
sizeof(virtio_snd_pcm_info) too.

>  }
>
>  /*
> @@ -805,7 +806,8 @@ process_cmd(VirtIOSound *s, virtio_snd_ctrl_command *=
cmd)
>                   0,
>                   &cmd->resp,
>                   sizeof(virtio_snd_hdr));
> -    virtqueue_push(cmd->vq, cmd->elem, sizeof(virtio_snd_hdr));
> +    virtqueue_push(cmd->vq, cmd->elem,
> +                   sizeof(virtio_snd_hdr) + cmd->payload_size);
>      virtio_notify(VIRTIO_DEVICE(s), cmd->vq);
>  }
>
> @@ -856,6 +858,7 @@ static void virtio_snd_handle_ctrl(VirtIODevice *vdev=
, VirtQueue *vq)
>          cmd->elem =3D elem;
>          cmd->vq =3D vq;
>          cmd->resp.code =3D cpu_to_le32(VIRTIO_SND_S_OK);
> +        /* implicit cmd->payload_size =3D 0; */
>          QTAILQ_INSERT_TAIL(&s->cmdq, cmd, next);
>          elem =3D virtqueue_pop(vq, sizeof(VirtQueueElement));
>      }
> diff --git a/include/hw/audio/virtio-snd.h b/include/hw/audio/virtio-snd.=
h
> index d1a68444d0..d6e08bd30d 100644
> --- a/include/hw/audio/virtio-snd.h
> +++ b/include/hw/audio/virtio-snd.h
> @@ -210,6 +210,7 @@ struct virtio_snd_ctrl_command {
>      VirtQueue *vq;
>      virtio_snd_hdr ctrl;
>      virtio_snd_hdr resp;
> +    size_t payload_size;
>      QTAILQ_ENTRY(virtio_snd_ctrl_command) next;
>  };
>  #endif
> --
> 2.35.3
>

otherwise, lgtm. Should it be backported to -stable ?
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


