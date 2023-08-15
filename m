Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F5D77CEAA
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Aug 2023 17:05:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVvc4-0002yp-JF; Tue, 15 Aug 2023 11:05:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <linwei6@ruijie.com.cn>)
 id 1qVvbq-0002uO-4I
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 11:05:33 -0400
Received: from t03.bc.larksuite.com ([209.127.231.35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <linwei6@ruijie.com.cn>)
 id 1qVvbg-0000rM-5d
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 11:05:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=ruijie-com-cn.20200927.dkim.feishu.cn; t=1692111898;
 h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=GZdPjvCdWk5r/2IxW7IH7f49w4XZJ1iXWFuvnEWXchc=;
 b=OuttU/vw9WVMN3/WnvKZ9gtZS9DFWO6p8FCsm3znt0IKvps/+WB8F8mY737PnzGX7PlsNB
 Cp66hdipM0OAROdLu2cQQgSalDwnwscSYy4VDR4KMaPEenmq/z5xfd9aPLlUQkU4NYSbHT
 7iCtDswVZ+FUnfDcEDEGSGZAXFqxkGqva7NBvYUpIyjH2Qp40i6SNq2kjw9AyEKgQAMgkS
 PyCBd6YpauSpushMPfY8w2dYMA04KpOSQFjfsm2+/FGToqD67QEekTxxtFaXjRJMJlVThF
 l1bqKKkhq5dheGu3xAD0nUyGnQw0ZhzapqsH70wLJSAiYq6ZYU3qo54BwKpE0w==
Message-Id: <4656f178aac73d5ca2a338dcc4d2ff0646d023b3.2ed2ecf9.391f.44ce.aca1.7b4c475ed80b@feishu.cn>
Cc: <qemu-devel@nongnu.org>, 
 "Emmanouil Pitsidianakis" <manos.pitsidianakis@linaro.org>, 
 "Igor Skalkin" <Igor.Skalkin@opensynergy.com>, 
 "Anton Yakovlev" <Anton.Yakovlev@opensynergy.com>, 
 "Paolo Bonzini" <pbonzini@redhat.com>, 
 "Gerd Hoffmann" <kraxel@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 "Marcel Apfelbaum" <marcel.apfelbaum@gmail.com>, 
 =?utf-8?b?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>, 
 "Eduardo Habkost" <eduardo@habkost.net>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>, 
 =?utf-8?b?S8WRdsOhZ8OzLCBab2x0w6Fu?= <DirtY.iCE.hu@gmail.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v6 11/12] virtio-sound: implement audio capture (RX)
Date: Tue, 15 Aug 2023 23:04:57 +0800
To: "Emmanouil Pitsidianakis" <manos.pitsidianakis@linaro.org>
From: =?utf-8?q?=E6=9E=97=E4=BC=9F6?= <linwei6@ruijie.com.cn>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+164db9419+45ddca+nongnu.org+linwei6@ruijie.com.cn>
In-Reply-To: <5e8f4234992411e49af618d1500581713f6d1621.1692089917.git.manos.pitsidianakis@linaro.org>
Content-Type: multipart/alternative;
 boundary=09e956f3f99ff4db625f1c071915bc4e0210868d2d5996f5776d65bbe205
Received-SPF: pass client-ip=209.127.231.35;
 envelope-from=linwei6@ruijie.com.cn; helo=t03.bc.larksuite.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--09e956f3f99ff4db625f1c071915bc4e0210868d2d5996f5776d65bbe205
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

typo error? this should be rx queue callback called ?

+virtio_snd_handle_rx_xfer(void) "tx queue callback called"
> From: "Emmanouil Pitsidianakis"<manos.pitsidianakis@linaro.org>
> Date:  Tue, Aug 15, 2023, 17:10
> Subject:  [PATCH v6 11/12] virtio-sound: implement audio capture (RX)
> To: <qemu-devel@nongnu.org>
> Cc: "Emmanouil Pitsidianakis"<manos.pitsidianakis@linaro.org>, "Igor Skal=
kin"<Igor.Skalkin@opensynergy.com>, "Anton Yakovlev"<Anton.Yakovlev@opensyn=
ergy.com>, "Paolo Bonzini"<pbonzini@redhat.com>, "Gerd Hoffmann"<kraxel@red=
hat.com>, "Michael S. Tsirkin"<mst@redhat.com>, "Marcel Apfelbaum"<marcel.a=
pfelbaum@gmail.com>, "Daniel P. Berrang=C3=A9"<berrange@redhat.com>, "Eduar=
do Habkost"<eduardo@habkost.net>, "Marc-Andr=C3=A9 Lureau"<marcandre.lureau=
@redhat.com>, "Volker R=C3=BCmelin"<vr_qemu@t-online.de>, "K=C5=91v=C3=A1g=
=C3=B3, Zolt=C3=A1n"<DirtY.iCE.hu@gmail.com>, "Alex Benn=C3=A9e"<alex.benne=
e@linaro.org>, "Philippe Mathieu-Daud=C3=A9"<philmd@linaro.org>
> To perform audio capture we duplicate the TX logic of the previous
> commit with the following difference: we receive data from the QEMU
> audio backend and write it in the virt queue IO buffers the guest sends
> to QEMU. When they are full (i.e. they have `period_bytes` amount of
> data) or when recording stops in QEMU's audio backend, the buffer is
> returned to the guest by notifying it.
>=20
> Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>  hw/virtio/trace-events |   3 +-
>  hw/virtio/virtio-snd.c | 233 +++++++++++++++++++++++++++++++++++------
>  2 files changed, 203 insertions(+), 33 deletions(-)
>=20
> diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
> index 3b95e745c2..a5829b112c 100644
> --- a/hw/virtio/trace-events
> +++ b/hw/virtio/trace-events
> @@ -172,4 +172,5 @@ virtio_snd_handle_code(uint32_t val, const char *code=
) "ctrl code msg val =3D %"PR
>  virtio_snd_handle_chmap_info(void) "VIRTIO_SND_CHMAP_INFO called"
>  virtio_snd_handle_event(void) "event queue callback called"
>  virtio_snd_pcm_stream_flush(uint32_t stream) "flushing stream %"PRIu32
> -virtio_snd_handle_xfer(void) "tx/rx queue callback called"
> +virtio_snd_handle_tx_xfer(void) "tx queue callback called"
> +virtio_snd_handle_rx_xfer(void) "tx queue callback called"
> diff --git a/hw/virtio/virtio-snd.c b/hw/virtio/virtio-snd.c
> index 926f6bbf62..b3e175a03c 100644
> --- a/hw/virtio/virtio-snd.c
> +++ b/hw/virtio/virtio-snd.c
> @@ -26,18 +26,21 @@
> =20
>  #define VIRTIO_SOUND_VM_VERSION 1
>  #define VIRTIO_SOUND_JACK_DEFAULT 0
> -#define VIRTIO_SOUND_STREAM_DEFAULT 1
> +#define VIRTIO_SOUND_STREAM_DEFAULT 2
>  #define VIRTIO_SOUND_CHMAP_DEFAULT 0
>  #define VIRTIO_SOUND_HDA_FN_NID 0
> =20
>  static void virtio_snd_pcm_out_cb(void *data, int available);
>  static void virtio_snd_process_cmdq(VirtIOSound *s);
> -static void virtio_snd_pcm_flush(VirtIOSoundPCMStream *stream);
> -static uint32_t
> -virtio_snd_pcm_read_write(VirtIOSoundPCMStream *stream,
> -                          VirtQueue *vq,
> -                          VirtQueueElement *element,
> -                          bool read);
> +static void virtio_snd_pcm_out_flush(VirtIOSoundPCMStream *stream);
> +static void virtio_snd_pcm_in_flush(VirtIOSoundPCMStream *stream);
> +static void virtio_snd_pcm_in_cb(void *data, int available);
> +static uint32_t virtio_snd_pcm_write(VirtIOSoundPCMStream *stream,
> +                                     VirtQueue *vq,
> +                                     VirtQueueElement *element);
> +static uint32_t virtio_snd_pcm_read(VirtIOSoundPCMStream *stream,
> +                                    VirtQueue *vq,
> +                                    VirtQueueElement *element);
> =20
>  static uint32_t supported_formats =3D BIT(VIRTIO_SND_PCM_FMT_S8)
>                                    | BIT(VIRTIO_SND_PCM_FMT_U8)
> @@ -403,6 +406,9 @@ static void virtio_snd_pcm_close(VirtIOSoundPCMStream=
 *stream)
>          if (stream->direction =3D=3D VIRTIO_SND_D_OUTPUT) {
>              AUD_close_out(&stream->pcm->snd->card, stream->voice.out);
>              stream->voice.out =3D NULL;
> +        } else if (stream->direction =3D=3D VIRTIO_SND_D_INPUT) {
> +            AUD_close_in(&stream->pcm->snd->card, stream->voice.in);
> +            stream->voice.in =3D NULL;
>          }
>          qemu_mutex_destroy(&stream->queue_mutex);
>          g_free(stream);
> @@ -465,7 +471,12 @@ static uint32_t virtio_snd_pcm_prepare_impl(VirtIOSo=
und *s, uint32_t stream_id)
>                                           virtio_snd_pcm_out_cb,
>                                           &as);
>      } else {
> -        qemu_log_mask(LOG_UNIMP, "virtio_snd: input/capture is unimpleme=
nted.");
> +        stream->voice.in =3D AUD_open_in(&s->card,
> +                                        stream->voice.in,
> +                                        "virtio_snd_card",
> +                                        stream,
> +                                        virtio_snd_pcm_in_cb,
> +                                        &as);
>      }
> =20
>      stream->as =3D as;
> @@ -530,6 +541,8 @@ static void virtio_snd_handle_pcm_start_stop(VirtIOSo=
und *s,
>      if (stream) {
>          if (stream->direction =3D=3D VIRTIO_SND_D_OUTPUT) {
>              AUD_set_active_out(stream->voice.out, start);
> +        } else {
> +            AUD_set_active_in(stream->voice.in, start);
>          }
>      } else {
>          error_report("Invalid stream id: %"PRIu32, req.stream_id);
> @@ -601,7 +614,11 @@ static void virtio_snd_handle_pcm_release(VirtIOSoun=
d *s,
>           */
>          virtio_snd_process_cmdq(stream->s);
>          trace_virtio_snd_pcm_stream_flush(stream_id);
> -        virtio_snd_pcm_flush(stream);
> +        if (stream->direction =3D=3D VIRTIO_SND_D_OUTPUT) {
> +            virtio_snd_pcm_out_flush(stream);
> +        } else {
> +            virtio_snd_pcm_in_flush(stream);
> +        }
>      }
> =20
>      cmd->resp.code =3D VIRTIO_SND_S_OK;
> @@ -760,7 +777,7 @@ static void virtio_snd_handle_event(VirtIODevice *vde=
v, VirtQueue *vq)
>   * @vdev: VirtIOSound device
>   * @vq: tx virtqueue
>   */
> -static void virtio_snd_handle_tx(VirtIODevice *vdev, VirtQueue *vq)
> +static void virtio_snd_handle_tx_xfer(VirtIODevice *vdev, VirtQueue *vq)
>  {
>      VirtIOSound *s =3D VIRTIO_SND(vdev);
>      VirtIOSoundPCMStream *stream =3D NULL;
> @@ -769,7 +786,7 @@ static void virtio_snd_handle_tx(VirtIODevice *vdev, =
VirtQueue *vq)
>      virtio_snd_pcm_xfer hdr;
>      virtio_snd_pcm_status resp =3D { 0 };
> =20
> -    trace_virtio_snd_handle_xfer();
> +    trace_virtio_snd_handle_tx_xfer();
> =20
>      for (;;) {
>          elem =3D virtqueue_pop(vq, sizeof(VirtQueueElement));
> @@ -793,11 +810,11 @@ static void virtio_snd_handle_tx(VirtIODevice *vdev=
, VirtQueue *vq)
>              goto tx_err;
>          }
> =20
> +        assert(hdr.stream_id !=3D VIRTIO_SND_D_INPUT);
>          WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
> -            virtio_snd_pcm_read_write(stream,
> +            virtio_snd_pcm_write(stream,
>                      vq,
> -                    elem,
> -                    hdr.stream_id =3D=3D VIRTIO_SND_D_INPUT);
> +                    elem);
> =20
>              resp.status =3D VIRTIO_SND_S_OK;
>              iov_from_buf(elem->in_sg,
> @@ -827,12 +844,54 @@ tx_err:
>  }
> =20
>  /*
> - * Stub buffer virtqueue handler.
> + * The rx virtqueue handler. Makes the buffers available to their respec=
tive
> + * streams for consumption.
>   *
>   * @vdev: VirtIOSound device
> - * @vq: virtqueue
> + * @vq: tx virtqueue
>   */
> -static void virtio_snd_handle_xfer(VirtIODevice *vdev, VirtQueue *vq) {}
> +static void virtio_snd_handle_rx_xfer(VirtIODevice *vdev, VirtQueue *vq)
> +{
> +    VirtIOSound *s =3D VIRTIO_SND(vdev);
> +    VirtIOSoundPCMStream *stream =3D NULL;
> +    VirtQueueElement *elem;
> +    size_t sz;
> +    virtio_snd_pcm_xfer hdr;
> +
> +    trace_virtio_snd_handle_rx_xfer();
> +
> +    for (;;) {
> +        elem =3D virtqueue_pop(vq, sizeof(VirtQueueElement));
> +        if (!elem) {
> +            break;
> +        }
> +        /* get the message hdr object */
> +        sz =3D iov_to_buf(elem->out_sg,
> +                        elem->out_num,
> +                        0,
> +                        &hdr,
> +                        sizeof(hdr));
> +        if (sz !=3D sizeof(hdr)
> +            || hdr.stream_id >=3D s->snd_conf.streams
> +            || !s->pcm->streams[hdr.stream_id]) {
> +            continue;
> +        }
> +
> +        stream =3D s->pcm->streams[hdr.stream_id];
> +        if (stream->direction =3D=3D VIRTIO_SND_D_OUTPUT) {
> +            continue;
> +        }
> +        WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
> +            virtio_snd_pcm_read(stream, vq, elem);
> +        }
> +    }
> +
> +    /*
> +     * Notify vq about virtio_snd_pcm_status responses.
> +     * Buffer responses must be notified separately later.
> +     */
> +    virtio_notify(VIRTIO_DEVICE(s), vq);
> +}
> =20
>  static uint64_t get_features(VirtIODevice *vdev, uint64_t features,
>                               Error **errp)
> @@ -961,8 +1020,8 @@ static void virtio_snd_realize(DeviceState *dev, Err=
or **errp)
>      virtio_snd_common_realize(dev,
>                                virtio_snd_handle_ctrl,
>                                virtio_snd_handle_event,
> -                              virtio_snd_handle_tx,
> -                              virtio_snd_handle_xfer,
> +                              virtio_snd_handle_tx_xfer,
> +                              virtio_snd_handle_rx_xfer,
>                                errp);
>  }
> =20
> @@ -1013,26 +1072,119 @@ static void virtio_snd_pcm_out_cb(void *data, in=
t available)
>  }
> =20
>  /*
> - * Flush all buffer data from this stream's queue into the driver's virt=
ual
> - * queue.
> + * AUD_* input callback.
>   *
> - * @stream: VirtIOSoundPCMStream *stream
> + * @data: VirtIOSoundPCMStream stream
> + * @available: number of bytes that can be read with AUD_read()
>   */
> -static void virtio_snd_pcm_flush(VirtIOSoundPCMStream *stream)
> +static void virtio_snd_pcm_in_cb(void *data, int available)
>  {
> +    VirtIOSoundPCMStream *stream =3D data;
>      VirtIOSoundPCMBlock *block;
> -    VirtIOSoundPCMBlock *next;
> +    uint32_t sz;
> +    virtio_snd_pcm_status resp =3D { 0 };
> +    size_t size;
> =20
>      WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
> -        QSIMPLEQ_FOREACH_SAFE(block, &stream->queue, entry, next) {
> -            AUD_write(stream->voice.out, block->data, block->size);
> -            virtqueue_push(block->vq, block->elem, sizeof(block->elem));
> -            virtio_notify(VIRTIO_DEVICE(stream->s), block->vq);
> -            QSIMPLEQ_REMOVE(&stream->queue, block, VirtIOSoundPCMBlock, =
entry);
> +        while (!QSIMPLEQ_EMPTY(&stream->queue)) {
> +            block =3D QSIMPLEQ_FIRST(&stream->queue);
> +
> +            for (;;) {
> +                size =3D AUD_read(stream->voice.in,
> +                        block->data + block->offset,
> +                        MIN(stream->period_bytes - block->offset, availa=
ble));
> +                block->offset +=3D size;
> +                block->size +=3D size;
> +                if (size =3D=3D 0 || block->size >=3D stream->period_byt=
es) {
> +                    resp.status =3D VIRTIO_SND_S_OK;
> +                     sz =3D iov_from_buf(block->elem->in_sg,
> +                                  block->elem->in_num,
> +                                  0,
> +                                  &resp,
> +                                  sizeof(resp));
> +
> +                    /* Copy data -if any- to guest */
> +                    if (block->size) {
> +                        iov_from_buf(block->elem->in_sg,
> +                                     block->elem->in_num,
> +                                     sz,
> +                                     &block->data,
> +                                     MIN(stream->period_bytes, block->si=
ze));
> +                    }
> +                    virtqueue_push(block->vq,
> +                            block->elem,
> +                            sizeof(block->elem));
> +                    virtio_notify(VIRTIO_DEVICE(stream->s),
> +                            block->vq);
> +                    QSIMPLEQ_REMOVE_HEAD(&stream->queue, entry);
> +                    g_free(block);
> +                    available -=3D size;
> +                    break;
> +                }
> +
> +                available -=3D size;
> +                if (!available) {
> +                    break;
> +                }
> +            }
> +            if (!available) {
> +                break;
> +            }
>          }
>      }
>  }
> =20
> +#define virtio_snd_pcm_flush(AUD_CB)                                    =
\
> +    VirtIOSoundPCMBlock *block;                                         =
\
> +    VirtIOSoundPCMBlock *next;                                          =
\
> +    WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {                        =
\
> +        QSIMPLEQ_FOREACH_SAFE(block, &stream->queue, entry, next) {     =
\
> +            do {                                                        =
\
> +                AUD_CB;                                                 =
\
> +            } while (0)                                                 =
\
> +            ;                                                           =
\
> +            virtqueue_push(block->vq, block->elem, sizeof(block->elem));=
\
> +            virtio_notify(VIRTIO_DEVICE(stream->s), block->vq);         =
\
> +            QSIMPLEQ_REMOVE(&stream->queue,                             =
\
> +                            block,                                      =
\
> +                            VirtIOSoundPCMBlock,                        =
\
> +                            entry);                                     =
\
> +        }                                                               =
\
> +    }                                                                   =
\
> +
> +
> +/*
> + * Flush all buffer data from this output stream's queue into the driver=
's
> + * virtual queue.
> + *
> + * @stream: VirtIOSoundPCMStream *stream
> + */
> +static void virtio_snd_pcm_out_flush(VirtIOSoundPCMStream *stream)
> +{
> +    virtio_snd_pcm_flush(
> +            AUD_write(stream->voice.out,
> +                              block->data,
> +                              block->size);
> +            );
> +}
> +
> +/*
> + * Flush all buffer data from this input stream's queue into the driver'=
s
> + * virtual queue.
> + *
> + * @stream: VirtIOSoundPCMStream *stream
> + */
> +static void virtio_snd_pcm_in_flush(VirtIOSoundPCMStream *stream)
> +{
> +    virtio_snd_pcm_flush(
> +            iov_from_buf(block->elem->in_sg,
> +                         block->elem->in_num,
> +                         sizeof(virtio_snd_pcm_info),
> +                         block->data,
> +                         block->offset);
> +            );
> +}
> +
>  static void virtio_snd_unrealize(DeviceState *dev)
>  {
>      VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
> @@ -1068,10 +1220,9 @@ static void virtio_snd_unrealize(DeviceState *dev)
> =20
> =20
>  static uint32_t
> -virtio_snd_pcm_read_write(VirtIOSoundPCMStream *stream,
> +virtio_snd_pcm_write(VirtIOSoundPCMStream *stream,
>                            VirtQueue *vq,
> -                          VirtQueueElement *element,
> -                          bool read)
> +                          VirtQueueElement *element)
>  {
>      VirtIOSoundPCMBlock *fragment;
>      size_t size =3D iov_size(element->out_sg, element->out_num) -
> @@ -1093,6 +1244,24 @@ virtio_snd_pcm_read_write(VirtIOSoundPCMStream *st=
ream,
>      return fragment->size;
>  }
> =20
> +static uint32_t
> +virtio_snd_pcm_read(VirtIOSoundPCMStream *stream,
> +                          VirtQueue *vq,
> +                          VirtQueueElement *element)
> +{
> +    VirtIOSoundPCMBlock *fragment;
> +
> +    fragment =3D g_malloc0(sizeof(VirtIOSoundPCMBlock) + stream->period_=
bytes);
> +    fragment->elem =3D element;
> +    fragment->vq =3D vq;
> +    fragment->size =3D 0;
> +    fragment->offset =3D 0;
> +
> +    QSIMPLEQ_INSERT_TAIL(&stream->queue, fragment, entry);
> +
> +    return fragment->size;
> +}
> +
>  static void virtio_snd_reset(VirtIODevice *vdev)
>  {
>      VirtIOSound *s =3D VIRTIO_SND(vdev);
> --=20
> 2.39.2

--09e956f3f99ff4db625f1c071915bc4e0210868d2d5996f5776d65bbe205
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset=UTF-8

<html><head></head><body><div id=3D"editor_version_1.17.2_AfWkqUyv" style=
=3D"word-break:break-word;"><div data-zone-id=3D"0" data-line-index=3D"0" d=
ata-line=3D"true" style=3D"margin-top: 4px; margin-bottom: 4px; line-height=
: 1.6;"><div class=3D"" style=3D"font-size: 16px;">typo error? this should =
be rx queue callback called ?</div></div><div data-zone-id=3D"0" data-line-=
index=3D"1" data-line=3D"true" style=3D"margin-top: 4px; margin-bottom: 4px=
; line-height: 1.6;"><div class=3D"" style=3D"font-size: 16px;"><br/></div>=
</div><div data-zone-id=3D"0" data-line-index=3D"2" data-line=3D"true" styl=
e=3D"margin-top: 4px; margin-bottom: 4px; line-height: 1.6;"><div class=3D"=
" style=3D"font-size: 16px;">+virtio_snd_handle_rx_xfer(void) &#34;tx queue=
 callback called&#34;</div></div></div><div class=3D"history-quote-wrapper"=
 id=3D"lark-mail-quote-169211189"><div style=3D"list-style-position: inside=
" data-html-block=3D"quote" data-mail-html-ignore=3D""><div class=3D"adit-h=
tml-block adit-html-block--collapsed" style=3D"border-left: none; padding-l=
eft: 0px;"><div><div class=3D"adit-html-block__attr history-quote-meta-wrap=
per history-quote-gap-tag" id=3D"lark-mail-quote-meta-fAoqjpHJE" style=3D"p=
adding: 12px; background: rgb(245, 246, 247); color: rgb(31, 35, 41); borde=
r-radius: 4px; margin-top: 24px; margin-bottom: 12px;"><div id=3D"lark-mail=
-quote-402d5e89c1dcdca577735dbb80dd4588"><div style=3D"word-break: break-wo=
rd;"><div style=3D""><span style=3D"white-space:nowrap;">From: </span><span=
 style=3D"white-space: nowrap;">&#34;Emmanouil Pitsidianakis&#34;&lt;<a sty=
le=3D"overflow-wrap: break-word; white-space: pre-wrap; hyphens: none; word=
-break: break-word; cursor: pointer; text-decoration: none; color: inherit;=
" href=3D"mailto:manos.pitsidianakis@linaro.org" class=3D"quote-head-meta-m=
ailto" data-mailto=3D"mailto:manos.pitsidianakis@linaro.org">manos.pitsidia=
nakis@linaro.org</a>&gt;</span></div><div style=3D""><span style=3D"white-s=
pace:nowrap;">Date: </span> Tue, Aug 15, 2023, 17:10</div><div style=3D""><=
span style=3D"white-space:nowrap;">Subject: </span> [PATCH v6 11/12] virtio=
-sound: implement audio capture (RX)</div><div style=3D""><span style=3D"wh=
ite-space:nowrap;">To: </span><span style=3D"white-space: nowrap;">&lt;<a s=
tyle=3D"overflow-wrap: break-word; white-space: pre-wrap; hyphens: none; wo=
rd-break: break-word; cursor: pointer; text-decoration: none; color: inheri=
t;" href=3D"mailto:qemu-devel@nongnu.org" class=3D"quote-head-meta-mailto" =
data-mailto=3D"mailto:qemu-devel@nongnu.org">qemu-devel@nongnu.org</a>&gt;<=
/span></div><div style=3D""><span style=3D"white-space:nowrap;">Cc: </span>=
<span style=3D"white-space: nowrap;">&#34;Emmanouil Pitsidianakis&#34;&lt;<=
a style=3D"overflow-wrap: break-word; white-space: pre-wrap; hyphens: none;=
 word-break: break-word; cursor: pointer; text-decoration: none; color: inh=
erit;" href=3D"mailto:manos.pitsidianakis@linaro.org" class=3D"quote-head-m=
eta-mailto" data-mailto=3D"mailto:manos.pitsidianakis@linaro.org">manos.pit=
sidianakis@linaro.org</a>&gt;</span>, <span style=3D"white-space: nowrap;">=
&#34;Igor Skalkin&#34;&lt;<a style=3D"overflow-wrap: break-word; white-spac=
e: pre-wrap; hyphens: none; word-break: break-word; cursor: pointer; text-d=
ecoration: none; color: inherit;" href=3D"mailto:Igor.Skalkin@opensynergy.c=
om" class=3D"quote-head-meta-mailto" data-mailto=3D"mailto:Igor.Skalkin@ope=
nsynergy.com">Igor.Skalkin@opensynergy.com</a>&gt;</span>, <span style=3D"w=
hite-space: nowrap;">&#34;Anton Yakovlev&#34;&lt;<a style=3D"overflow-wrap:=
 break-word; white-space: pre-wrap; hyphens: none; word-break: break-word; =
cursor: pointer; text-decoration: none; color: inherit;" href=3D"mailto:Ant=
on.Yakovlev@opensynergy.com" class=3D"quote-head-meta-mailto" data-mailto=
=3D"mailto:Anton.Yakovlev@opensynergy.com">Anton.Yakovlev@opensynergy.com</=
a>&gt;</span>, <span style=3D"white-space: nowrap;">&#34;Paolo Bonzini&#34;=
&lt;<a style=3D"overflow-wrap: break-word; white-space: pre-wrap; hyphens: =
none; word-break: break-word; cursor: pointer; text-decoration: none; color=
: inherit;" href=3D"mailto:pbonzini@redhat.com" class=3D"quote-head-meta-ma=
ilto" data-mailto=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.com</a>&gt=
;</span>, <span style=3D"white-space: nowrap;">&#34;Gerd Hoffmann&#34;&lt;<=
a style=3D"overflow-wrap: break-word; white-space: pre-wrap; hyphens: none;=
 word-break: break-word; cursor: pointer; text-decoration: none; color: inh=
erit;" href=3D"mailto:kraxel@redhat.com" class=3D"quote-head-meta-mailto" d=
ata-mailto=3D"mailto:kraxel@redhat.com">kraxel@redhat.com</a>&gt;</span>, <=
span style=3D"white-space: nowrap;">&#34;Michael S. Tsirkin&#34;&lt;<a styl=
e=3D"overflow-wrap: break-word; white-space: pre-wrap; hyphens: none; word-=
break: break-word; cursor: pointer; text-decoration: none; color: inherit;"=
 href=3D"mailto:mst@redhat.com" class=3D"quote-head-meta-mailto" data-mailt=
o=3D"mailto:mst@redhat.com">mst@redhat.com</a>&gt;</span>, <span style=3D"w=
hite-space: nowrap;">&#34;Marcel Apfelbaum&#34;&lt;<a style=3D"overflow-wra=
p: break-word; white-space: pre-wrap; hyphens: none; word-break: break-word=
; cursor: pointer; text-decoration: none; color: inherit;" href=3D"mailto:m=
arcel.apfelbaum@gmail.com" class=3D"quote-head-meta-mailto" data-mailto=3D"=
mailto:marcel.apfelbaum@gmail.com">marcel.apfelbaum@gmail.com</a>&gt;</span=
>, <span style=3D"white-space: nowrap;">&#34;Daniel P. Berrang=C3=A9&#34;&l=
t;<a style=3D"overflow-wrap: break-word; white-space: pre-wrap; hyphens: no=
ne; word-break: break-word; cursor: pointer; text-decoration: none; color: =
inherit;" href=3D"mailto:berrange@redhat.com" class=3D"quote-head-meta-mail=
to" data-mailto=3D"mailto:berrange@redhat.com">berrange@redhat.com</a>&gt;<=
/span>, <span style=3D"white-space: nowrap;">&#34;Eduardo Habkost&#34;&lt;<=
a style=3D"overflow-wrap: break-word; white-space: pre-wrap; hyphens: none;=
 word-break: break-word; cursor: pointer; text-decoration: none; color: inh=
erit;" href=3D"mailto:eduardo@habkost.net" class=3D"quote-head-meta-mailto"=
 data-mailto=3D"mailto:eduardo@habkost.net">eduardo@habkost.net</a>&gt;</sp=
an>, <span style=3D"white-space: nowrap;">&#34;Marc-Andr=C3=A9 Lureau&#34;&=
lt;<a style=3D"overflow-wrap: break-word; white-space: pre-wrap; hyphens: n=
one; word-break: break-word; cursor: pointer; text-decoration: none; color:=
 inherit;" href=3D"mailto:marcandre.lureau@redhat.com" class=3D"quote-head-=
meta-mailto" data-mailto=3D"mailto:marcandre.lureau@redhat.com">marcandre.l=
ureau@redhat.com</a>&gt;</span>, <span style=3D"white-space: nowrap;">&#34;=
Volker R=C3=BCmelin&#34;&lt;<a style=3D"overflow-wrap: break-word; white-sp=
ace: pre-wrap; hyphens: none; word-break: break-word; cursor: pointer; text=
-decoration: none; color: inherit;" href=3D"mailto:vr_qemu@t-online.de" cla=
ss=3D"quote-head-meta-mailto" data-mailto=3D"mailto:vr_qemu@t-online.de">vr=
_qemu@t-online.de</a>&gt;</span>, <span style=3D"white-space: nowrap;">&#34=
;K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n&#34;&lt;<a style=3D"overflow-wrap: brea=
k-word; white-space: pre-wrap; hyphens: none; word-break: break-word; curso=
r: pointer; text-decoration: none; color: inherit;" href=3D"mailto:DirtY.iC=
E.hu@gmail.com" class=3D"quote-head-meta-mailto" data-mailto=3D"mailto:Dirt=
Y.iCE.hu@gmail.com">DirtY.iCE.hu@gmail.com</a>&gt;</span>, <span style=3D"w=
hite-space: nowrap;">&#34;Alex Benn=C3=A9e&#34;&lt;<a style=3D"overflow-wra=
p: break-word; white-space: pre-wrap; hyphens: none; word-break: break-word=
; cursor: pointer; text-decoration: none; color: inherit;" href=3D"mailto:a=
lex.bennee@linaro.org" class=3D"quote-head-meta-mailto" data-mailto=3D"mail=
to:alex.bennee@linaro.org">alex.bennee@linaro.org</a>&gt;</span>, <span sty=
le=3D"white-space: nowrap;">&#34;Philippe Mathieu-Daud=C3=A9&#34;&lt;<a sty=
le=3D"overflow-wrap: break-word; white-space: pre-wrap; hyphens: none; word=
-break: break-word; cursor: pointer; text-decoration: none; color: inherit;=
" href=3D"mailto:philmd@linaro.org" class=3D"quote-head-meta-mailto" data-m=
ailto=3D"mailto:philmd@linaro.org">philmd@linaro.org</a>&gt;</span></div></=
div></div></div><div><div data-type=3D"plainText" style=3D"white-space: pre=
-wrap"><span>To perform audio capture we duplicate the TX logic of the prev=
ious
commit with the following difference: we receive data from the QEMU
audio backend and write it in the virt queue IO buffers the guest sends
to QEMU. When they are full (i.e. they have `period_bytes` amount of
data) or when recording stops in QEMU&#39;s audio backend, the buffer is
returned to the guest by notifying it.

Signed-off-by: Emmanouil Pitsidianakis &lt;<a href=3D"mailto:manos.pitsidia=
nakis@linaro.org" target=3D"_blank" ref=3D"noopener noreferrer">manos.pitsi=
dianakis@linaro.org</a>&gt;
---
 hw/virtio/trace-events |   3 +-
 hw/virtio/virtio-snd.c | 233 +++++++++++++++++++++++++++++++++++------
 2 files changed, 203 insertions(+), 33 deletions(-)

diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 3b95e745c2..a5829b112c 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -172,4 +172,5 @@ virtio_snd_handle_code(uint32_t val, const char *code) =
&#34;ctrl code msg val =3D %&#34;PR
 virtio_snd_handle_chmap_info(void) &#34;VIRTIO_SND_CHMAP_INFO called&#34;
 virtio_snd_handle_event(void) &#34;event queue callback called&#34;
 virtio_snd_pcm_stream_flush(uint32_t stream) &#34;flushing stream %&#34;PR=
Iu32
-virtio_snd_handle_xfer(void) &#34;tx/rx queue callback called&#34;
+virtio_snd_handle_tx_xfer(void) &#34;tx queue callback called&#34;
+virtio_snd_handle_rx_xfer(void) &#34;tx queue callback called&#34;
diff --git a/hw/virtio/virtio-snd.c b/hw/virtio/virtio-snd.c
index 926f6bbf62..b3e175a03c 100644
--- a/hw/virtio/virtio-snd.c
+++ b/hw/virtio/virtio-snd.c
@@ -26,18 +26,21 @@
=20
 #define VIRTIO_SOUND_VM_VERSION 1
 #define VIRTIO_SOUND_JACK_DEFAULT 0
-#define VIRTIO_SOUND_STREAM_DEFAULT 1
+#define VIRTIO_SOUND_STREAM_DEFAULT 2
 #define VIRTIO_SOUND_CHMAP_DEFAULT 0
 #define VIRTIO_SOUND_HDA_FN_NID 0
=20
 static void virtio_snd_pcm_out_cb(void *data, int available);
 static void virtio_snd_process_cmdq(VirtIOSound *s);
-static void virtio_snd_pcm_flush(VirtIOSoundPCMStream *stream);
-static uint32_t
-virtio_snd_pcm_read_write(VirtIOSoundPCMStream *stream,
-                          VirtQueue *vq,
-                          VirtQueueElement *element,
-                          bool read);
+static void virtio_snd_pcm_out_flush(VirtIOSoundPCMStream *stream);
+static void virtio_snd_pcm_in_flush(VirtIOSoundPCMStream *stream);
+static void virtio_snd_pcm_in_cb(void *data, int available);
+static uint32_t virtio_snd_pcm_write(VirtIOSoundPCMStream *stream,
+                                     VirtQueue *vq,
+                                     VirtQueueElement *element);
+static uint32_t virtio_snd_pcm_read(VirtIOSoundPCMStream *stream,
+                                    VirtQueue *vq,
+                                    VirtQueueElement *element);
=20
 static uint32_t supported_formats =3D BIT(VIRTIO_SND_PCM_FMT_S8)
                                   | BIT(VIRTIO_SND_PCM_FMT_U8)
@@ -403,6 +406,9 @@ static void virtio_snd_pcm_close(VirtIOSoundPCMStream *=
stream)
         if (stream-&gt;direction =3D=3D VIRTIO_SND_D_OUTPUT) {
             AUD_close_out(&amp;stream-&gt;pcm-&gt;snd-&gt;card, stream-&gt=
;voice.out);
             stream-&gt;voice.out =3D NULL;
+        } else if (stream-&gt;direction =3D=3D VIRTIO_SND_D_INPUT) {
+            AUD_close_in(&amp;stream-&gt;pcm-&gt;snd-&gt;card, stream-&gt;=
<a href=3D"voice.in)" target=3D"_blank" ref=3D"noopener noreferrer">voice.i=
n)</a>;
+            stream-&gt;<a href=3D"voice.in" target=3D"_blank" ref=3D"noope=
ner noreferrer">voice.in</a> =3D NULL;
         }
         qemu_mutex_destroy(&amp;stream-&gt;queue_mutex);
         g_free(stream);
@@ -465,7 +471,12 @@ static uint32_t virtio_snd_pcm_prepare_impl(VirtIOSoun=
d *s, uint32_t stream_id)
                                          virtio_snd_pcm_out_cb,
                                          &amp;as);
     } else {
-        qemu_log_mask(LOG_UNIMP, &#34;virtio_snd: input/capture is unimple=
mented.&#34;);
+        stream-&gt;<a href=3D"voice.in" target=3D"_blank" ref=3D"noopener =
noreferrer">voice.in</a> =3D AUD_open_in(&amp;s-&gt;card,
+                                        stream-&gt;<a href=3D"voice.in" ta=
rget=3D"_blank" ref=3D"noopener noreferrer">voice.in</a>,
+                                        &#34;virtio_snd_card&#34;,
+                                        stream,
+                                        virtio_snd_pcm_in_cb,
+                                        &amp;as);
     }
=20
     stream-&gt;as =3D as;
@@ -530,6 +541,8 @@ static void virtio_snd_handle_pcm_start_stop(VirtIOSoun=
d *s,
     if (stream) {
         if (stream-&gt;direction =3D=3D VIRTIO_SND_D_OUTPUT) {
             AUD_set_active_out(stream-&gt;voice.out, start);
+        } else {
+            AUD_set_active_in(stream-&gt;<a href=3D"voice.in" target=3D"_b=
lank" ref=3D"noopener noreferrer">voice.in</a>, start);
         }
     } else {
         error_report(&#34;Invalid stream id: %&#34;PRIu32, req.stream_id);
@@ -601,7 +614,11 @@ static void virtio_snd_handle_pcm_release(VirtIOSound =
*s,
          */
         virtio_snd_process_cmdq(stream-&gt;s);
         trace_virtio_snd_pcm_stream_flush(stream_id);
-        virtio_snd_pcm_flush(stream);
+        if (stream-&gt;direction =3D=3D VIRTIO_SND_D_OUTPUT) {
+            virtio_snd_pcm_out_flush(stream);
+        } else {
+            virtio_snd_pcm_in_flush(stream);
+        }
     }
=20
     cmd-&gt;resp.code =3D VIRTIO_SND_S_OK;
@@ -760,7 +777,7 @@ static void virtio_snd_handle_event(VirtIODevice *vdev,=
 VirtQueue *vq)
  * @vdev: VirtIOSound device
  * @vq: tx virtqueue
  */
-static void virtio_snd_handle_tx(VirtIODevice *vdev, VirtQueue *vq)
+static void virtio_snd_handle_tx_xfer(VirtIODevice *vdev, VirtQueue *vq)
 {
     VirtIOSound *s =3D VIRTIO_SND(vdev);
     VirtIOSoundPCMStream *stream =3D NULL;
@@ -769,7 +786,7 @@ static void virtio_snd_handle_tx(VirtIODevice *vdev, Vi=
rtQueue *vq)
     virtio_snd_pcm_xfer hdr;
     virtio_snd_pcm_status resp =3D { 0 };
=20
-    trace_virtio_snd_handle_xfer();
+    trace_virtio_snd_handle_tx_xfer();
=20
     for (;;) {
         elem =3D virtqueue_pop(vq, sizeof(VirtQueueElement));
@@ -793,11 +810,11 @@ static void virtio_snd_handle_tx(VirtIODevice *vdev, =
VirtQueue *vq)
             goto tx_err;
         }
=20
+        assert(hdr.stream_id !=3D VIRTIO_SND_D_INPUT);
         WITH_QEMU_LOCK_GUARD(&amp;stream-&gt;queue_mutex) {
-            virtio_snd_pcm_read_write(stream,
+            virtio_snd_pcm_write(stream,
                     vq,
-                    elem,
-                    hdr.stream_id =3D=3D VIRTIO_SND_D_INPUT);
+                    elem);
=20
             resp.status =3D VIRTIO_SND_S_OK;
             iov_from_buf(elem-&gt;in_sg,
@@ -827,12 +844,54 @@ tx_err:
 }
=20
 /*
- * Stub buffer virtqueue handler.
+ * The rx virtqueue handler. Makes the buffers available to their respecti=
ve
+ * streams for consumption.
  *
  * @vdev: VirtIOSound device
- * @vq: virtqueue
+ * @vq: tx virtqueue
  */
-static void virtio_snd_handle_xfer(VirtIODevice *vdev, VirtQueue *vq) {}
+static void virtio_snd_handle_rx_xfer(VirtIODevice *vdev, VirtQueue *vq)
+{
+    VirtIOSound *s =3D VIRTIO_SND(vdev);
+    VirtIOSoundPCMStream *stream =3D NULL;
+    VirtQueueElement *elem;
+    size_t sz;
+    virtio_snd_pcm_xfer hdr;
+
+    trace_virtio_snd_handle_rx_xfer();
+
+    for (;;) {
+        elem =3D virtqueue_pop(vq, sizeof(VirtQueueElement));
+        if (!elem) {
+            break;
+        }
+        /* get the message hdr object */
+        sz =3D iov_to_buf(elem-&gt;out_sg,
+                        elem-&gt;out_num,
+                        0,
+                        &amp;hdr,
+                        sizeof(hdr));
+        if (sz !=3D sizeof(hdr)
+            || hdr.stream_id &gt;=3D s-&gt;snd_conf.streams
+            || !s-&gt;pcm-&gt;streams[hdr.stream_id]) {
+            continue;
+        }
+
+        stream =3D s-&gt;pcm-&gt;streams[hdr.stream_id];
+        if (stream-&gt;direction =3D=3D VIRTIO_SND_D_OUTPUT) {
+            continue;
+        }
+        WITH_QEMU_LOCK_GUARD(&amp;stream-&gt;queue_mutex) {
+            virtio_snd_pcm_read(stream, vq, elem);
+        }
+    }
+
+    /*
+     * Notify vq about virtio_snd_pcm_status responses.
+     * Buffer responses must be notified separately later.
+     */
+    virtio_notify(VIRTIO_DEVICE(s), vq);
+}
=20
 static uint64_t get_features(VirtIODevice *vdev, uint64_t features,
                              Error **errp)
@@ -961,8 +1020,8 @@ static void virtio_snd_realize(DeviceState *dev, Error=
 **errp)
     virtio_snd_common_realize(dev,
                               virtio_snd_handle_ctrl,
                               virtio_snd_handle_event,
-                              virtio_snd_handle_tx,
-                              virtio_snd_handle_xfer,
+                              virtio_snd_handle_tx_xfer,
+                              virtio_snd_handle_rx_xfer,
                               errp);
 }
=20
@@ -1013,26 +1072,119 @@ static void virtio_snd_pcm_out_cb(void *data, int =
available)
 }
=20
 /*
- * Flush all buffer data from this stream&#39;s queue into the driver&#39;=
s virtual
- * queue.
+ * AUD_* input callback.
  *
- * @stream: VirtIOSoundPCMStream *stream
+ * @data: VirtIOSoundPCMStream stream
+ * @available: number of bytes that can be read with AUD_read()
  */
-static void virtio_snd_pcm_flush(VirtIOSoundPCMStream *stream)
+static void virtio_snd_pcm_in_cb(void *data, int available)
 {
+    VirtIOSoundPCMStream *stream =3D data;
     VirtIOSoundPCMBlock *block;
-    VirtIOSoundPCMBlock *next;
+    uint32_t sz;
+    virtio_snd_pcm_status resp =3D { 0 };
+    size_t size;
=20
     WITH_QEMU_LOCK_GUARD(&amp;stream-&gt;queue_mutex) {
-        QSIMPLEQ_FOREACH_SAFE(block, &amp;stream-&gt;queue, entry, next) {
-            AUD_write(stream-&gt;voice.out, block-&gt;data, block-&gt;size=
);
-            virtqueue_push(block-&gt;vq, block-&gt;elem, sizeof(block-&gt;=
elem));
-            virtio_notify(VIRTIO_DEVICE(stream-&gt;s), block-&gt;vq);
-            QSIMPLEQ_REMOVE(&amp;stream-&gt;queue, block, VirtIOSoundPCMBl=
ock, entry);
+        while (!QSIMPLEQ_EMPTY(&amp;stream-&gt;queue)) {
+            block =3D QSIMPLEQ_FIRST(&amp;stream-&gt;queue);
+
+            for (;;) {
+                size =3D AUD_read(stream-&gt;<a href=3D"voice.in" target=
=3D"_blank" ref=3D"noopener noreferrer">voice.in</a>,
+                        block-&gt;data + block-&gt;offset,
+                        MIN(stream-&gt;period_bytes - block-&gt;offset, av=
ailable));
+                block-&gt;offset +=3D size;
+                block-&gt;size +=3D size;
+                if (size =3D=3D 0 || block-&gt;size &gt;=3D stream-&gt;per=
iod_bytes) {
+                    resp.status =3D VIRTIO_SND_S_OK;
+                     sz =3D iov_from_buf(block-&gt;elem-&gt;in_sg,
+                                  block-&gt;elem-&gt;in_num,
+                                  0,
+                                  &amp;resp,
+                                  sizeof(resp));
+
+                    /* Copy data -if any- to guest */
+                    if (block-&gt;size) {
+                        iov_from_buf(block-&gt;elem-&gt;in_sg,
+                                     block-&gt;elem-&gt;in_num,
+                                     sz,
+                                     &amp;block-&gt;data,
+                                     MIN(stream-&gt;period_bytes, block-&g=
t;size));
+                    }
+                    virtqueue_push(block-&gt;vq,
+                            block-&gt;elem,
+                            sizeof(block-&gt;elem));
+                    virtio_notify(VIRTIO_DEVICE(stream-&gt;s),
+                            block-&gt;vq);
+                    QSIMPLEQ_REMOVE_HEAD(&amp;stream-&gt;queue, entry);
+                    g_free(block);
+                    available -=3D size;
+                    break;
+                }
+
+                available -=3D size;
+                if (!available) {
+                    break;
+                }
+            }
+            if (!available) {
+                break;
+            }
         }
     }
 }
=20
+#define virtio_snd_pcm_flush(AUD_CB)                                    \
+    VirtIOSoundPCMBlock *block;                                         \
+    VirtIOSoundPCMBlock *next;                                          \
+    WITH_QEMU_LOCK_GUARD(&amp;stream-&gt;queue_mutex) {                   =
     \
+        QSIMPLEQ_FOREACH_SAFE(block, &amp;stream-&gt;queue, entry, next) {=
     \
+            do {                                                        \
+                AUD_CB;                                                 \
+            } while (0)                                                 \
+            ;                                                           \
+            virtqueue_push(block-&gt;vq, block-&gt;elem, sizeof(block-&gt;=
elem));\
+            virtio_notify(VIRTIO_DEVICE(stream-&gt;s), block-&gt;vq);     =
    \
+            QSIMPLEQ_REMOVE(&amp;stream-&gt;queue,                        =
     \
+                            block,                                      \
+                            VirtIOSoundPCMBlock,                        \
+                            entry);                                     \
+        }                                                               \
+    }                                                                   \
+
+
+/*
+ * Flush all buffer data from this output stream&#39;s queue into the driv=
er&#39;s
+ * virtual queue.
+ *
+ * @stream: VirtIOSoundPCMStream *stream
+ */
+static void virtio_snd_pcm_out_flush(VirtIOSoundPCMStream *stream)
+{
+    virtio_snd_pcm_flush(
+            AUD_write(stream-&gt;voice.out,
+                              block-&gt;data,
+                              block-&gt;size);
+            );
+}
+
+/*
+ * Flush all buffer data from this input stream&#39;s queue into the drive=
r&#39;s
+ * virtual queue.
+ *
+ * @stream: VirtIOSoundPCMStream *stream
+ */
+static void virtio_snd_pcm_in_flush(VirtIOSoundPCMStream *stream)
+{
+    virtio_snd_pcm_flush(
+            iov_from_buf(block-&gt;elem-&gt;in_sg,
+                         block-&gt;elem-&gt;in_num,
+                         sizeof(virtio_snd_pcm_info),
+                         block-&gt;data,
+                         block-&gt;offset);
+            );
+}
+
 static void virtio_snd_unrealize(DeviceState *dev)
 {
     VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
@@ -1068,10 +1220,9 @@ static void virtio_snd_unrealize(DeviceState *dev)
=20
=20
 static uint32_t
-virtio_snd_pcm_read_write(VirtIOSoundPCMStream *stream,
+virtio_snd_pcm_write(VirtIOSoundPCMStream *stream,
                           VirtQueue *vq,
-                          VirtQueueElement *element,
-                          bool read)
+                          VirtQueueElement *element)
 {
     VirtIOSoundPCMBlock *fragment;
     size_t size =3D iov_size(element-&gt;out_sg, element-&gt;out_num) -
@@ -1093,6 +1244,24 @@ virtio_snd_pcm_read_write(VirtIOSoundPCMStream *stre=
am,
     return fragment-&gt;size;
 }
=20
+static uint32_t
+virtio_snd_pcm_read(VirtIOSoundPCMStream *stream,
+                          VirtQueue *vq,
+                          VirtQueueElement *element)
+{
+    VirtIOSoundPCMBlock *fragment;
+
+    fragment =3D g_malloc0(sizeof(VirtIOSoundPCMBlock) + stream-&gt;period=
_bytes);
+    fragment-&gt;elem =3D element;
+    fragment-&gt;vq =3D vq;
+    fragment-&gt;size =3D 0;
+    fragment-&gt;offset =3D 0;
+
+    QSIMPLEQ_INSERT_TAIL(&amp;stream-&gt;queue, fragment, entry);
+
+    return fragment-&gt;size;
+}
+
 static void virtio_snd_reset(VirtIODevice *vdev)
 {
     VirtIOSound *s =3D VIRTIO_SND(vdev);
--=20
2.39.2</span></div></div></div></div></div></div></body></html>
--09e956f3f99ff4db625f1c071915bc4e0210868d2d5996f5776d65bbe205--

