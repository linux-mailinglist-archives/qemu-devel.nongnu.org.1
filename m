Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D50E825185
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 11:11:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLh9n-0003UB-E0; Fri, 05 Jan 2024 05:10:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rLh9k-0003TS-2A
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 05:10:24 -0500
Received: from mail-ua1-x933.google.com ([2607:f8b0:4864:20::933])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rLh9e-000255-ID
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 05:10:23 -0500
Received: by mail-ua1-x933.google.com with SMTP id
 a1e0cc1a2514c-7cc7bae27b5so574187241.2
 for <qemu-devel@nongnu.org>; Fri, 05 Jan 2024 02:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704449415; x=1705054215; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oHPiqHmF16BN0X5y4fPxHgMMiBhzjlcVAEflxUvNFoU=;
 b=L2o7Ti4JzPkUgESj/BwDgLzfT80DoPNZ1swss2m/GDpiUAXeMLKObUZn1XRW9TF1EL
 a2RTCLbTVvBr8VtqEB9M0H2NUVnHHdh/KjQ7GgK9ayFDkftwNo1/Rq7b/9hW3u1FueVS
 Da+96w9wLGvsRR3QzcUh9PR10GdAqGxTCTsSH7S3fyUChaQwoLVkpXL1IsYsGBjT0ahi
 JxTJrz8BnH6nzkYx6FO2DixfBAuPwAJyc/ij6e50y7akvlR544pVLJUvWO4tOlTSa/RZ
 6MC6MSln9WQjYqQaeRsoy/eet7esxlqP6kdCKB25UKtxJIqjMxkxvf/PSl5lfW3aZO9Q
 TKGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704449415; x=1705054215;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oHPiqHmF16BN0X5y4fPxHgMMiBhzjlcVAEflxUvNFoU=;
 b=eTX4P+z8dhvyDimnX0jsZAUX32pBvL9t16iabKb5UkehcKKi9Ntl+WFRhvHBm15hgS
 Z7Bt7rYQpXNaS+cBFGEGJMSl06UmOSiYeOO5Jky5DG6LDA7ALhfLJIrMr1Fux7TtJxUr
 RkQKWGsMMeaLeYHVTNUXRg7/JoWNQK9iPcovlNYY89FVMjCpVAdkyNOA1IO7CxSZXWOH
 N7QAlSvi6CNY9dAkCS67OKmpKw1G8Yjxy6M3A8MFxsDDr2f0eG83mw0XYwf42S4kE46F
 9qZRrBp22B8qDMrmTXUqRiKT3X9s3Lw5u90E9jh0zdMvzgZXAMUzKm7qe/Nad4YVlY34
 lXgw==
X-Gm-Message-State: AOJu0Yxq6HeyvY+2uZmgucvfT7Y42qn5R8IO6W8etSI+oeOU7208c0bF
 6d+SdPmjEB3ZRgE9p7lVkICWOXgVntWkrIvI3cs=
X-Google-Smtp-Source: AGHT+IFIO/4m1wVIlF6ij/1xDxcKVxz+sZOufRIz14JRkVKcMC/wv4vNR2H/5xgfUX/o35Vuv+WiV5M/KAEa5LtVwKk=
X-Received: by 2002:a05:6102:5043:b0:467:a48b:cdd2 with SMTP id
 by3-20020a056102504300b00467a48bcdd2mr1316904vsb.49.1704449414753; Fri, 05
 Jan 2024 02:10:14 -0800 (PST)
MIME-Version: 1.0
References: <b416aee3-72a9-4642-b219-3e1800ee5b3c@t-online.de>
 <20240104203422.12308-1-vr_qemu@t-online.de>
In-Reply-To: <20240104203422.12308-1-vr_qemu@t-online.de>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 5 Jan 2024 14:10:02 +0400
Message-ID: <CAJ+F1CKj25uLU-vecOR18qJzEWmK+drtwDYqb+zVojCssu=89Q@mail.gmail.com>
Subject: Re: [PATCH 01/10] hw/audio/virtio-sound: remove command and stream
 mutexes
To: =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::933;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ua1-x933.google.com
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

On Fri, Jan 5, 2024 at 12:35=E2=80=AFAM Volker R=C3=BCmelin <vr_qemu@t-onli=
ne.de> wrote:
>
> All code in virtio-snd.c runs with the BQL held. Remove the
> command queue mutex and the stream queue mutexes. The qatomic
> functions are also not needed.

I am not comfortable with this assertion. Someone more familiar with
virtio.c implementation should confirm

Rust would really save us from thinking about this kind of problems,
and a standalone vhost-user implementation..

>
> Signed-off-by: Volker R=C3=BCmelin <vr_qemu@t-online.de>
> ---
>  hw/audio/virtio-snd.c         | 294 +++++++++++++++-------------------
>  include/hw/audio/virtio-snd.h |   3 -
>  2 files changed, 130 insertions(+), 167 deletions(-)
>
> diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
> index ea2aeaef14..8344f61c64 100644
> --- a/hw/audio/virtio-snd.c
> +++ b/hw/audio/virtio-snd.c
> @@ -19,7 +19,6 @@
>  #include "qemu/iov.h"
>  #include "qemu/log.h"
>  #include "qemu/error-report.h"
> -#include "include/qemu/lockable.h"
>  #include "sysemu/runstate.h"
>  #include "trace.h"
>  #include "qapi/error.h"
> @@ -453,7 +452,6 @@ static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s=
, uint32_t stream_id)
>          stream->id =3D stream_id;
>          stream->pcm =3D s->pcm;
>          stream->s =3D s;
> -        qemu_mutex_init(&stream->queue_mutex);
>          QSIMPLEQ_INIT(&stream->queue);
>          QSIMPLEQ_INIT(&stream->invalid);
>
> @@ -580,9 +578,7 @@ static void virtio_snd_handle_pcm_start_stop(VirtIOSo=
und *s,
>
>      stream =3D virtio_snd_pcm_get_stream(s, stream_id);
>      if (stream) {
> -        WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
> -            stream->active =3D start;
> -        }
> +        stream->active =3D start;
>          if (stream->info.direction =3D=3D VIRTIO_SND_D_OUTPUT) {
>              AUD_set_active_out(stream->voice.out, start);
>          } else {
> @@ -606,13 +602,11 @@ static size_t virtio_snd_pcm_get_io_msgs_count(Virt=
IOSoundPCMStream *stream)
>      VirtIOSoundPCMBuffer *buffer, *next;
>      size_t count =3D 0;
>
> -    WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
> -        QSIMPLEQ_FOREACH_SAFE(buffer, &stream->queue, entry, next) {
> -            count +=3D 1;
> -        }
> -        QSIMPLEQ_FOREACH_SAFE(buffer, &stream->invalid, entry, next) {
> -            count +=3D 1;
> -        }
> +    QSIMPLEQ_FOREACH_SAFE(buffer, &stream->queue, entry, next) {
> +        count +=3D 1;
> +    }
> +    QSIMPLEQ_FOREACH_SAFE(buffer, &stream->invalid, entry, next) {
> +        count +=3D 1;
>      }
>      return count;
>  }
> @@ -762,23 +756,15 @@ static void virtio_snd_process_cmdq(VirtIOSound *s)
>  {
>      virtio_snd_ctrl_command *cmd;
>
> -    if (unlikely(qatomic_read(&s->processing_cmdq))) {
> -        return;
> -    }
> -
> -    WITH_QEMU_LOCK_GUARD(&s->cmdq_mutex) {
> -        qatomic_set(&s->processing_cmdq, true);
> -        while (!QTAILQ_EMPTY(&s->cmdq)) {
> -            cmd =3D QTAILQ_FIRST(&s->cmdq);
> +    while (!QTAILQ_EMPTY(&s->cmdq)) {
> +        cmd =3D QTAILQ_FIRST(&s->cmdq);
>
> -            /* process command */
> -            process_cmd(s, cmd);
> +        /* process command */
> +        process_cmd(s, cmd);
>
> -            QTAILQ_REMOVE(&s->cmdq, cmd, next);
> +        QTAILQ_REMOVE(&s->cmdq, cmd, next);
>
> -            virtio_snd_ctrl_cmd_free(cmd);
> -        }
> -        qatomic_set(&s->processing_cmdq, false);
> +        virtio_snd_ctrl_cmd_free(cmd);
>      }
>  }
>
> @@ -840,32 +826,30 @@ static inline void empty_invalid_queue(VirtIODevice=
 *vdev, VirtQueue *vq)
>          stream =3D vsnd->pcm->streams[i];
>          if (stream) {
>              any =3D false;
> -            WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
> -                while (!QSIMPLEQ_EMPTY(&stream->invalid)) {
> -                    buffer =3D QSIMPLEQ_FIRST(&stream->invalid);
> -                    if (buffer->vq !=3D vq) {
> -                        break;
> -                    }
> -                    any =3D true;
> -                    resp.status =3D cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
> -                    iov_from_buf(buffer->elem->in_sg,
> -                                 buffer->elem->in_num,
> -                                 0,
> -                                 &resp,
> -                                 sizeof(virtio_snd_pcm_status));
> -                    virtqueue_push(vq,
> -                                   buffer->elem,
> -                                   sizeof(virtio_snd_pcm_status));
> -                    QSIMPLEQ_REMOVE_HEAD(&stream->invalid, entry);
> -                    virtio_snd_pcm_buffer_free(buffer);
> -                }
> -                if (any) {
> -                    /*
> -                     * Notify vq about virtio_snd_pcm_status responses.
> -                     * Buffer responses must be notified separately late=
r.
> -                     */
> -                    virtio_notify(vdev, vq);
> +            while (!QSIMPLEQ_EMPTY(&stream->invalid)) {
> +                buffer =3D QSIMPLEQ_FIRST(&stream->invalid);
> +                if (buffer->vq !=3D vq) {
> +                    break;
>                  }
> +                any =3D true;
> +                resp.status =3D cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
> +                iov_from_buf(buffer->elem->in_sg,
> +                             buffer->elem->in_num,
> +                             0,
> +                             &resp,
> +                             sizeof(virtio_snd_pcm_status));
> +                virtqueue_push(vq,
> +                               buffer->elem,
> +                               sizeof(virtio_snd_pcm_status));
> +                QSIMPLEQ_REMOVE_HEAD(&stream->invalid, entry);
> +                virtio_snd_pcm_buffer_free(buffer);
> +            }
> +            if (any) {
> +                /*
> +                 * Notify vq about virtio_snd_pcm_status responses.
> +                 * Buffer responses must be notified separately later.
> +                 */
> +                virtio_notify(vdev, vq);
>              }
>          }
>      }
> @@ -924,28 +908,24 @@ static void virtio_snd_handle_tx_xfer(VirtIODevice =
*vdev, VirtQueue *vq)
>              goto tx_err;
>          }
>
> -        WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
> -            size =3D iov_size(elem->out_sg, elem->out_num) - msg_sz;
> +        size =3D iov_size(elem->out_sg, elem->out_num) - msg_sz;
>
> -            buffer =3D g_malloc0(sizeof(VirtIOSoundPCMBuffer) + size);
> -            buffer->elem =3D elem;
> -            buffer->populated =3D false;
> -            buffer->vq =3D vq;
> -            buffer->size =3D size;
> -            buffer->offset =3D 0;
> +        buffer =3D g_malloc0(sizeof(VirtIOSoundPCMBuffer) + size);
> +        buffer->elem =3D elem;
> +        buffer->populated =3D false;
> +        buffer->vq =3D vq;
> +        buffer->size =3D size;
> +        buffer->offset =3D 0;
>
> -            QSIMPLEQ_INSERT_TAIL(&stream->queue, buffer, entry);
> -        }
> +        QSIMPLEQ_INSERT_TAIL(&stream->queue, buffer, entry);
>          continue;
>
>  tx_err:
> -        WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
> -            must_empty_invalid_queue =3D true;
> -            buffer =3D g_malloc0(sizeof(VirtIOSoundPCMBuffer));
> -            buffer->elem =3D elem;
> -            buffer->vq =3D vq;
> -            QSIMPLEQ_INSERT_TAIL(&stream->invalid, buffer, entry);
> -        }
> +        must_empty_invalid_queue =3D true;
> +        buffer =3D g_malloc0(sizeof(VirtIOSoundPCMBuffer));
> +        buffer->elem =3D elem;
> +        buffer->vq =3D vq;
> +        QSIMPLEQ_INSERT_TAIL(&stream->invalid, buffer, entry);
>      }
>
>      if (must_empty_invalid_queue) {
> @@ -1005,26 +985,23 @@ static void virtio_snd_handle_rx_xfer(VirtIODevice=
 *vdev, VirtQueue *vq)
>          if (stream =3D=3D NULL || stream->info.direction !=3D VIRTIO_SND=
_D_INPUT) {
>              goto rx_err;
>          }
> -        WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
> -            size =3D iov_size(elem->in_sg, elem->in_num) -
> -                sizeof(virtio_snd_pcm_status);
> -            buffer =3D g_malloc0(sizeof(VirtIOSoundPCMBuffer) + size);
> -            buffer->elem =3D elem;
> -            buffer->vq =3D vq;
> -            buffer->size =3D 0;
> -            buffer->offset =3D 0;
> -            QSIMPLEQ_INSERT_TAIL(&stream->queue, buffer, entry);
> -        }
> +        size =3D iov_size(elem->in_sg, elem->in_num) -
> +            sizeof(virtio_snd_pcm_status);
> +        buffer =3D g_malloc0(sizeof(VirtIOSoundPCMBuffer) + size);
> +        buffer->elem =3D elem;
> +        buffer->vq =3D vq;
> +        buffer->size =3D 0;
> +        buffer->offset =3D 0;
> +        QSIMPLEQ_INSERT_TAIL(&stream->queue, buffer, entry);
>          continue;
>
>  rx_err:
> -        WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
> -            must_empty_invalid_queue =3D true;
> -            buffer =3D g_malloc0(sizeof(VirtIOSoundPCMBuffer));
> -            buffer->elem =3D elem;
> -            buffer->vq =3D vq;
> -            QSIMPLEQ_INSERT_TAIL(&stream->invalid, buffer, entry);
> -        }
> +        must_empty_invalid_queue =3D true;
> +        buffer =3D g_malloc0(sizeof(VirtIOSoundPCMBuffer));
> +        buffer->elem =3D elem;
> +        buffer->vq =3D vq;
> +        QSIMPLEQ_INSERT_TAIL(&stream->invalid, buffer, entry);
> +
>      }
>
>      if (must_empty_invalid_queue) {
> @@ -1122,7 +1099,6 @@ static void virtio_snd_realize(DeviceState *dev, Er=
ror **errp)
>          virtio_add_queue(vdev, 64, virtio_snd_handle_tx_xfer);
>      vsnd->queues[VIRTIO_SND_VQ_RX] =3D
>          virtio_add_queue(vdev, 64, virtio_snd_handle_rx_xfer);
> -    qemu_mutex_init(&vsnd->cmdq_mutex);
>      QTAILQ_INIT(&vsnd->cmdq);
>
>      for (uint32_t i =3D 0; i < vsnd->snd_conf.streams; i++) {
> @@ -1182,50 +1158,48 @@ static void virtio_snd_pcm_out_cb(void *data, int=
 available)
>      VirtIOSoundPCMBuffer *buffer;
>      size_t size;
>
> -    WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
> -        while (!QSIMPLEQ_EMPTY(&stream->queue)) {
> -            buffer =3D QSIMPLEQ_FIRST(&stream->queue);
> -            if (!virtio_queue_ready(buffer->vq)) {
> -                return;
> +    while (!QSIMPLEQ_EMPTY(&stream->queue)) {
> +        buffer =3D QSIMPLEQ_FIRST(&stream->queue);
> +        if (!virtio_queue_ready(buffer->vq)) {
> +            return;
> +        }
> +        if (!stream->active) {
> +            /* Stream has stopped, so do not perform AUD_write. */
> +            return_tx_buffer(stream, buffer);
> +            continue;
> +        }
> +        if (!buffer->populated) {
> +            iov_to_buf(buffer->elem->out_sg,
> +                       buffer->elem->out_num,
> +                       sizeof(virtio_snd_pcm_xfer),
> +                       buffer->data,
> +                       buffer->size);
> +            buffer->populated =3D true;
> +        }
> +        for (;;) {
> +            size =3D AUD_write(stream->voice.out,
> +                             buffer->data + buffer->offset,
> +                             MIN(buffer->size, available));
> +            assert(size <=3D MIN(buffer->size, available));
> +            if (size =3D=3D 0) {
> +                /* break out of both loops */
> +                available =3D 0;
> +                break;
>              }
> -            if (!stream->active) {
> -                /* Stream has stopped, so do not perform AUD_write. */
> +            buffer->size -=3D size;
> +            buffer->offset +=3D size;
> +            available -=3D size;
> +            if (buffer->size < 1) {
>                  return_tx_buffer(stream, buffer);
> -                continue;
> -            }
> -            if (!buffer->populated) {
> -                iov_to_buf(buffer->elem->out_sg,
> -                           buffer->elem->out_num,
> -                           sizeof(virtio_snd_pcm_xfer),
> -                           buffer->data,
> -                           buffer->size);
> -                buffer->populated =3D true;
> -            }
> -            for (;;) {
> -                size =3D AUD_write(stream->voice.out,
> -                                 buffer->data + buffer->offset,
> -                                 MIN(buffer->size, available));
> -                assert(size <=3D MIN(buffer->size, available));
> -                if (size =3D=3D 0) {
> -                    /* break out of both loops */
> -                    available =3D 0;
> -                    break;
> -                }
> -                buffer->size -=3D size;
> -                buffer->offset +=3D size;
> -                available -=3D size;
> -                if (buffer->size < 1) {
> -                    return_tx_buffer(stream, buffer);
> -                    break;
> -                }
> -                if (!available) {
> -                    break;
> -                }
> +                break;
>              }
>              if (!available) {
>                  break;
>              }
>          }
> +        if (!available) {
> +            break;
> +        }
>      }
>  }
>
> @@ -1276,41 +1250,39 @@ static void virtio_snd_pcm_in_cb(void *data, int =
available)
>      VirtIOSoundPCMBuffer *buffer;
>      size_t size;
>
> -    WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
> -        while (!QSIMPLEQ_EMPTY(&stream->queue)) {
> -            buffer =3D QSIMPLEQ_FIRST(&stream->queue);
> -            if (!virtio_queue_ready(buffer->vq)) {
> -                return;
> +    while (!QSIMPLEQ_EMPTY(&stream->queue)) {
> +        buffer =3D QSIMPLEQ_FIRST(&stream->queue);
> +        if (!virtio_queue_ready(buffer->vq)) {
> +            return;
> +        }
> +        if (!stream->active) {
> +            /* Stream has stopped, so do not perform AUD_read. */
> +            return_rx_buffer(stream, buffer);
> +            continue;
> +        }
> +
> +        for (;;) {
> +            size =3D AUD_read(stream->voice.in,
> +                            buffer->data + buffer->size,
> +                            MIN(available, (stream->params.period_bytes =
-
> +                                            buffer->size)));
> +            if (!size) {
> +                available =3D 0;
> +                break;
>              }
> -            if (!stream->active) {
> -                /* Stream has stopped, so do not perform AUD_read. */
> +            buffer->size +=3D size;
> +            available -=3D size;
> +            if (buffer->size >=3D stream->params.period_bytes) {
>                  return_rx_buffer(stream, buffer);
> -                continue;
> -            }
> -
> -            for (;;) {
> -                size =3D AUD_read(stream->voice.in,
> -                        buffer->data + buffer->size,
> -                        MIN(available, (stream->params.period_bytes -
> -                                        buffer->size)));
> -                if (!size) {
> -                    available =3D 0;
> -                    break;
> -                }
> -                buffer->size +=3D size;
> -                available -=3D size;
> -                if (buffer->size >=3D stream->params.period_bytes) {
> -                    return_rx_buffer(stream, buffer);
> -                    break;
> -                }
> -                if (!available) {
> -                    break;
> -                }
> +                break;
>              }
>              if (!available) {
>                  break;
>              }
>          }
> +        if (!available) {
> +            break;
> +        }
>      }
>  }
>
> @@ -1327,11 +1299,9 @@ static inline void virtio_snd_pcm_flush(VirtIOSoun=
dPCMStream *stream)
>          (stream->info.direction =3D=3D VIRTIO_SND_D_OUTPUT) ? return_tx_=
buffer :
>          return_rx_buffer;
>
> -    WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
> -        while (!QSIMPLEQ_EMPTY(&stream->queue)) {
> -            buffer =3D QSIMPLEQ_FIRST(&stream->queue);
> -            cb(stream, buffer);
> -        }
> +    while (!QSIMPLEQ_EMPTY(&stream->queue)) {
> +        buffer =3D QSIMPLEQ_FIRST(&stream->queue);
> +        cb(stream, buffer);
>      }
>  }
>
> @@ -1351,7 +1321,6 @@ static void virtio_snd_unrealize(DeviceState *dev)
>                  if (stream) {
>                      virtio_snd_process_cmdq(stream->s);
>                      virtio_snd_pcm_close(stream);
> -                    qemu_mutex_destroy(&stream->queue_mutex);
>                      g_free(stream);
>                  }
>              }
> @@ -1362,7 +1331,6 @@ static void virtio_snd_unrealize(DeviceState *dev)
>          vsnd->pcm =3D NULL;
>      }
>      AUD_remove_card(&vsnd->card);
> -    qemu_mutex_destroy(&vsnd->cmdq_mutex);
>      virtio_delete_queue(vsnd->queues[VIRTIO_SND_VQ_CONTROL]);
>      virtio_delete_queue(vsnd->queues[VIRTIO_SND_VQ_EVENT]);
>      virtio_delete_queue(vsnd->queues[VIRTIO_SND_VQ_TX]);
> @@ -1376,12 +1344,10 @@ static void virtio_snd_reset(VirtIODevice *vdev)
>      VirtIOSound *s =3D VIRTIO_SND(vdev);
>      virtio_snd_ctrl_command *cmd;
>
> -    WITH_QEMU_LOCK_GUARD(&s->cmdq_mutex) {
> -        while (!QTAILQ_EMPTY(&s->cmdq)) {
> -            cmd =3D QTAILQ_FIRST(&s->cmdq);
> -            QTAILQ_REMOVE(&s->cmdq, cmd, next);
> -            virtio_snd_ctrl_cmd_free(cmd);
> -        }
> +    while (!QTAILQ_EMPTY(&s->cmdq)) {
> +        cmd =3D QTAILQ_FIRST(&s->cmdq);
> +        QTAILQ_REMOVE(&s->cmdq, cmd, next);
> +        virtio_snd_ctrl_cmd_free(cmd);
>      }
>  }
>
> diff --git a/include/hw/audio/virtio-snd.h b/include/hw/audio/virtio-snd.=
h
> index c3767f442b..ea6315f59b 100644
> --- a/include/hw/audio/virtio-snd.h
> +++ b/include/hw/audio/virtio-snd.h
> @@ -148,7 +148,6 @@ struct VirtIOSoundPCMStream {
>          SWVoiceIn *in;
>          SWVoiceOut *out;
>      } voice;
> -    QemuMutex queue_mutex;
>      bool active;
>      QSIMPLEQ_HEAD(, VirtIOSoundPCMBuffer) queue;
>      QSIMPLEQ_HEAD(, VirtIOSoundPCMBuffer) invalid;
> @@ -220,9 +219,7 @@ struct VirtIOSound {
>      QEMUSoundCard card;
>      VMChangeStateEntry *vmstate;
>      virtio_snd_config snd_conf;
> -    QemuMutex cmdq_mutex;
>      QTAILQ_HEAD(, virtio_snd_ctrl_command) cmdq;
> -    bool processing_cmdq;
>  };
>
>  struct virtio_snd_ctrl_command {
> --
> 2.35.3
>
>


--=20
Marc-Andr=C3=A9 Lureau

