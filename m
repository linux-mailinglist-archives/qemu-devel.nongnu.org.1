Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EC1377915B1
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 12:27:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd6nU-00023n-0X; Mon, 04 Sep 2023 06:27:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qd6mb-0001pl-Lx
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 06:26:19 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qd6mW-0004JE-6A
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 06:26:11 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-99c1c66876aso185019566b.2
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 03:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693823164; x=1694427964; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Hgj+FcGLwehO0MkY2TehbY0FJw23Bm3pDtgcwDf1aG0=;
 b=yu2TqvZoNAWhtKHiyUHO7dfIitp8AZOQSD+iOrXPMBPuT16vq0dhx4nkUuZdDA5aII
 VAt3eF5jjrtu7/9IWsNakGwj2Z2mpAXj3gZEA9uqn9Uu4E8L4Xw9JaQppuZURJUCHKHB
 zHugbNYa+iBxR55taqJF4qTVyfau0Uip/JyIateMV5eCuBFcabPkF28ghSzRwov9qpTj
 p3lhRyrM3doCMfLST3D7DRDpYU8jBipt1I6xykUwcxFKKMVAr6xd6CIdPdcC/DR3fAt7
 1HN2u9AdxYBHz7oICfpHLmMJNYS3806aP3kEKfn58Dmu2RHHfcgQhG9XZcUjzPHYuG42
 QhqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693823164; x=1694427964;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Hgj+FcGLwehO0MkY2TehbY0FJw23Bm3pDtgcwDf1aG0=;
 b=fXrhG0UY72nSjx/EMxQN60LbEf5Kth3Hiqio8TroNeGMAYnR9fFW+fUBgEoSqC2xW0
 YAGBj9TZMja0hDiicp8ygdQAXveTaZMWFbDSPmVF9flMDxJxr3xy6KPWyfCffe+Inqkw
 i9Zxs9a17htb2/ICZs1RV2ZJKIzIf4jj9kFzIPWYCoZbrPZ6U2Y7EAadaDhIAn9cFpgh
 byguMRWRlBc5k9BcrfVrFHmzdXDrbsbcpffQ+EIXfFVLBUZ0ciDUPQLQpDMdg4ZUpuuQ
 6yovryfreJ97PNAGQZ/xAN3PuoBQgJWEg/RIFb2khOXJHbTwQXsxj00sGc695kRyOh6h
 Rnkg==
X-Gm-Message-State: AOJu0YzZ+di2+e8W4NHAxxQeM5zysLIQUnXRzcGD0rLPPg+IVwoGZmr7
 cbUnwgIPque8CqPH0OSg2je5Pw==
X-Google-Smtp-Source: AGHT+IG8L3Z+jb1z7Wd2Rm8GG6jt3iF/Ne481AeyYiANC6UBN3r8ksmcP7YZPu+GUFtoa4zsXxpOLA==
X-Received: by 2002:a17:907:1de6:b0:9a1:cbe5:7586 with SMTP id
 og38-20020a1709071de600b009a1cbe57586mr7163984ejc.35.1693823164207; 
 Mon, 04 Sep 2023 03:26:04 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.209.227])
 by smtp.gmail.com with ESMTPSA id
 s13-20020a1709064d8d00b0099bca8b9a31sm5943147eju.100.2023.09.04.03.26.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Sep 2023 03:26:03 -0700 (PDT)
Message-ID: <3e844c1a-4f44-7a99-cc7f-810881335e45@linaro.org>
Date: Mon, 4 Sep 2023 12:26:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v8 10/12] virtio-sound: implement audio output (TX)
Content-Language: en-US
To: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org
Cc: Igor Skalkin <Igor.Skalkin@opensynergy.com>,
 Anton Yakovlev <Anton.Yakovlev@opensynergy.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Volker_R=c3=bcmelin?= <vr_qemu@t-online.de>,
 =?UTF-8?B?S8WRdsOhZ8OzLCBab2x0w6Fu?= <DirtY.iCE.hu@gmail.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <cover.1693252037.git.manos.pitsidianakis@linaro.org>
 <c94a9c1e65bb6bb43c58e5ccb982948424a3f3f2.1693252037.git.manos.pitsidianakis@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <c94a9c1e65bb6bb43c58e5ccb982948424a3f3f2.1693252037.git.manos.pitsidianakis@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62e.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 28/8/23 21:55, Emmanouil Pitsidianakis wrote:
> Handle output IO messages in the transmit (TX) virtqueue.
> 
> It allocates a VirtIOSoundPCMBlock for each IO message and copies the
> data buffer to it. When the IO buffer is written to the host's sound
> card, the guest will be notified that it has been consumed.
> 
> The lifetime of an IO message is:
> 
> 1. Guest sends IO message to TX virtqueue.
> 2. QEMU adds it to the appropriate stream's IO buffer queue.
> 3. Sometime later, the host audio backend calls the output callback,
>     virtio_snd_pcm_out_cb(), which is defined with an AUD_open_out()
>     call. The callback gets an available number of bytes the backend can
>     receive. Then it writes data from the IO buffer queue to the backend.
>     If at any time a buffer is exhausted, it is returned to the guest as
>     completed.
> 4. If the guest releases the stream, its buffer queue is flushed by
>     attempting to write any leftover data to the audio backend and
>     releasing all IO messages back to the guest. This is how according to
>     the spec the guest knows the release was successful.
> 
> Based-on: https://github.com/OpenSynergy/qemu/commit/5a2f350eec5d157b90d9c7b40a8e603f4da92471
> Signed-off-by: Igor Skalkin <Igor.Skalkin@opensynergy.com>
> Signed-off-by: Anton Yakovlev <Anton.Yakovlev@opensynergy.com>
> Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>   hw/virtio/trace-events         |   2 +
>   hw/virtio/virtio-snd.c         | 262 ++++++++++++++++++++++++++++++++-
>   include/hw/virtio/virtio-snd.h |  11 ++
>   3 files changed, 271 insertions(+), 4 deletions(-)


>   /*
> - * Handles VIRTIO_SND_R_PCM_RELEASE. Releases the buffer resources allocated to
> - * a stream.
> + * Returns the number of I/O messages that are being processed.
> + *
> + * @stream: VirtIOSoundPCMStream
> + */
> +static size_t virtio_snd_pcm_get_pending_io_msgs(VirtIOSoundPCMStream *stream)
> +{
> +    VirtIOSoundPCMBlock *block;
> +    VirtIOSoundPCMBlock *next;
> +    size_t size = 0;
> +
> +    WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
> +        QSIMPLEQ_FOREACH_SAFE(block, &stream->queue, entry, next) {
> +            size += 1;

Can you add a comment explaining this magic size?

> +        }
> +    }
> +    return size;
> +}


> +/*
> + * The tx virtqueue handler. Makes the buffers available to their respective
> + * streams for consumption.
> + *
> + * @vdev: VirtIOSound device
> + * @vq: tx virtqueue
> + */
> +static void virtio_snd_handle_tx(VirtIODevice *vdev, VirtQueue *vq)
> +{
> +    VirtIOSound *s = VIRTIO_SND(vdev);
> +    VirtIOSoundPCMStream *stream = NULL;
> +    VirtQueueElement *elem;
> +    size_t sz;
> +    virtio_snd_pcm_xfer hdr;
> +    virtio_snd_pcm_status resp = { 0 };

virtio_snd_pcm_status has multiple fields, so better zero-initialize
all of them with '{ }'.

> +
> +    trace_virtio_snd_handle_xfer();
> +
> +    for (;;) {
> +        elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
> +        if (!elem) {
> +            break;
> +        }
> +        /* get the message hdr object */
> +        sz = iov_to_buf(elem->out_sg,
> +                        elem->out_num,
> +                        0,
> +                        &hdr,
> +                        sizeof(hdr));
> +        if (sz != sizeof(hdr)
> +            || hdr.stream_id >= s->snd_conf.streams
> +            || !s->pcm->streams[hdr.stream_id]) {
> +            goto tx_err;
> +        }
> +
> +        stream = s->pcm->streams[hdr.stream_id];
> +        if (stream->direction != VIRTIO_SND_D_OUTPUT) {
> +            goto tx_err;
> +        }
> +
> +        WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
> +            virtio_snd_pcm_read_write(stream,
> +                    vq,
> +                    elem,
> +                    hdr.stream_id == VIRTIO_SND_D_INPUT);
> +
> +            resp.status = VIRTIO_SND_S_OK;
> +            iov_from_buf(elem->in_sg,
> +                         elem->in_num,
> +                         0,
> +                         &resp,
> +                         sizeof(resp));
> +        }
> +        continue;
> +
> +tx_err:
> +        WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
> +            resp.status = VIRTIO_SND_S_BAD_MSG;
> +            iov_from_buf(elem->in_sg,
> +                         elem->in_num,
> +                         0,
> +                         &resp,
> +                         sizeof(resp));
> +        }
> +    }
> +
> +    /*
> +     * Notify vq about virtio_snd_pcm_status responses.
> +     * Buffer responses must be notified separately later.
> +     */
> +    virtio_notify(VIRTIO_DEVICE(s), vq);
> +}


> +/*
> + * AUD_* output callback.
> + *
> + * @data: VirtIOSoundPCMStream stream
> + * @available: number of bytes that can be written with AUD_write()
> + */
> +static void virtio_snd_pcm_out_cb(void *data, int available)
> +{
> +    VirtIOSoundPCMStream *stream = data;
> +    VirtIOSoundPCMBlock *block;
> +    VirtIOSoundPCMBlock *next;
> +    size_t size;
> +
> +    WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
> +        QSIMPLEQ_FOREACH_SAFE(block, &stream->queue, entry, next) {
> +            for (;;) {
> +                size = MIN(block->size, available);
> +                size = AUD_write(stream->voice.out,
> +                        block->data + block->offset,
> +                        size);

If AUD_write() returns 0, is this an infinite loop?

> +                block->size -= size;
> +                block->offset += size;
> +                if (!block->size) {
> +                    virtqueue_push(block->vq,
> +                            block->elem,
> +                            sizeof(block->elem));
> +                    virtio_notify(VIRTIO_DEVICE(stream->s),
> +                            block->vq);
> +                    QSIMPLEQ_REMOVE_HEAD(&stream->queue, entry);
> +                    g_free(block);
> +                    available -= size;
> +                    break;
> +                }
> +
> +                available -= size;
> +                if (!available) {
> +                    break;
> +                }
> +            }
> +            if (!available) {
> +                break;
> +            }
> +        }
> +    }
> +}
> +
> +/*
> + * Flush all buffer data from this stream's queue into the driver's virtual
> + * queue.
> + *
> + * @stream: VirtIOSoundPCMStream *stream
> + */
> +static void virtio_snd_pcm_flush(VirtIOSoundPCMStream *stream)
> +{
> +    VirtIOSoundPCMBlock *block;
> +    VirtIOSoundPCMBlock *next;
> +
> +    WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
> +        QSIMPLEQ_FOREACH_SAFE(block, &stream->queue, entry, next) {
> +            AUD_write(stream->voice.out, block->data + block->offset, block->size);

Is it OK to ignore AUD_write() returning < block->size?
If so, can you add a comment please?

> +            virtqueue_push(block->vq, block->elem, sizeof(block->elem));
> +            virtio_notify(VIRTIO_DEVICE(stream->s), block->vq);
> +            QSIMPLEQ_REMOVE(&stream->queue, block, VirtIOSoundPCMBlock, entry);
> +        }
> +    }
> +}


