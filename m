Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D8370784CC9
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 00:18:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYZhC-0006wL-Hg; Tue, 22 Aug 2023 18:17:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYZhA-0006w4-1I
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 18:17:52 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYZh7-00022r-22
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 18:17:51 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-31771bb4869so4489287f8f.0
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 15:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692742667; x=1693347467;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4dtP0UNqMEpH+j7hWOelrFBOcZkP+YY48qf/c5i2MrQ=;
 b=ZyVrocWfxL/w9CJPgZKwJvLdOCKvSPJ18q2w0xB98jehAKqeEKOPbFgOlbinkdofrH
 2gt0lfQJYXBeJ6tIYm8VoTVzT3DfVLnyIwhkN0j6r/ZAgFafTYhL56ck0JsQRYFtlGho
 ZhUyJeo+rmB3Rp4SNVoq7qOgKMl2UbAAH/jC3H0066jpEhximd67a/acdHUfx/iYd2rE
 NKKU9tyb5CsG4sC0BLG2JI3N3ZsrkZDLkaNOJGfpWLLzPbu6246Key/MGU92ma4G/Jyt
 rjzy3mvhHLN5o3HBU/srbiTf1OUwJchrO6W9PClOGl9Y2jk86/LsLBMvLBIABGEjq+Cn
 G+Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692742667; x=1693347467;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4dtP0UNqMEpH+j7hWOelrFBOcZkP+YY48qf/c5i2MrQ=;
 b=ZWgbyqXqnH/2Nq5r+lc/N/OgPPjAuLxyTPnlVkISrY5YOquy8D2YDlOt4Kfwgs663p
 CIfxPnvmi7U/7hX9Z2S3DwCEP9yHVE8tj8Ng87ubUl/SDUjRuw6b/AlOR5d7LoVou15W
 lDq8R2Q/YoQ3Uk4BkLfQhRepzzriNNU7hu4TLZRC2gHg0rbPi5cR0lJoSy/jRDg/AfVP
 TnxQDnrPQCZpdhNfR13TAms4clh2SQy6bGElB3M1771I8MGZuQRmGkJQ3Qr+CeLD1hvF
 Vtc6bOGvePunRh0b2Mt6b9TUrLkTF4WWlP/iBZ9Ip4VY1gQYDLtnsXoSqKnkPOjrKrvH
 3rmg==
X-Gm-Message-State: AOJu0YyNNyAnz3OubJfX5GGF+8Og26/dZL8GTFj+OBwyjFPtNmKdpbkm
 Zl9v1Dp5yvNV+q0EtlmdP/wDFg==
X-Google-Smtp-Source: AGHT+IFApfyXXIMbz93xKzjE7j3DejpfhctSRMHleAg4o3h4SCbQKqLZKX/mxjKj76ifdzIl/JMpVg==
X-Received: by 2002:adf:fd04:0:b0:319:731f:748c with SMTP id
 e4-20020adffd04000000b00319731f748cmr7976709wrr.34.1692742666947; 
 Tue, 22 Aug 2023 15:17:46 -0700 (PDT)
Received: from [10.2.0.2] ([37.19.214.4]) by smtp.gmail.com with ESMTPSA id
 d13-20020adff2cd000000b0031ac70b6aa7sm17035560wrp.20.2023.08.22.15.17.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Aug 2023 15:17:46 -0700 (PDT)
Message-ID: <75a3c938-f8c1-36b7-2914-34fb7677dcb0@linaro.org>
Date: Wed, 23 Aug 2023 00:17:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v7 10/12] virtio-sound: implement audio output (TX)
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
References: <cover.1692731646.git.manos.pitsidianakis@linaro.org>
 <fc270670926ec0ada64ef62172a2698bafa6f88e.1692731646.git.manos.pitsidianakis@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <fc270670926ec0ada64ef62172a2698bafa6f88e.1692731646.git.manos.pitsidianakis@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.767,
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

Hi Emmanouil,

On 22/8/23 21:18, Emmanouil Pitsidianakis wrote:
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
> Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>   hw/virtio/trace-events         |   2 +
>   hw/virtio/virtio-snd.c         | 250 ++++++++++++++++++++++++++++++++-
>   include/hw/virtio/virtio-snd.h |  11 ++
>   3 files changed, 259 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
> index 60ab62a80d..3b95e745c2 100644
> --- a/hw/virtio/trace-events
> +++ b/hw/virtio/trace-events
> @@ -171,3 +171,5 @@ virtio_snd_handle_pcm_release(uint32_t stream) "VIRTIO_SND_PCM_RELEASE called fo
>   virtio_snd_handle_code(uint32_t val, const char *code) "ctrl code msg val = %"PRIu32" == %s"
>   virtio_snd_handle_chmap_info(void) "VIRTIO_SND_CHMAP_INFO called"
>   virtio_snd_handle_event(void) "event queue callback called"
> +virtio_snd_pcm_stream_flush(uint32_t stream) "flushing stream %"PRIu32
> +virtio_snd_handle_xfer(void) "tx/rx queue callback called"


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
> +
> +    trace_virtio_snd_handle_xfer();

Maybe ...

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

... it is more useful displaying the callback stream index here?

            trace_virtio_snd_handle_xfer(hdr.stream_id);

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


