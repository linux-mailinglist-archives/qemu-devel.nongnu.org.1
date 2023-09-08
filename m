Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B067982B8
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 08:50:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeVJO-0004zo-AU; Fri, 08 Sep 2023 02:49:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1qeVJI-0004ub-0W
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:49:44 -0400
Received: from mailout07.t-online.de ([194.25.134.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1qeVJB-0003of-7o
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:49:43 -0400
Received: from fwd71.aul.t-online.de (fwd71.aul.t-online.de [10.223.144.97])
 by mailout07.t-online.de (Postfix) with SMTP id 3CA87256FC;
 Fri,  8 Sep 2023 08:49:31 +0200 (CEST)
Received: from [192.168.211.200] ([79.208.25.148]) by fwd71.t-online.de
 with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
 esmtp id 1qeVJ3-085qFt0; Fri, 8 Sep 2023 08:49:30 +0200
Message-ID: <23f756e4-c3ce-1554-c59a-16e180a1a9f4@t-online.de>
Date: Fri, 8 Sep 2023 08:49:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v8 11/12] virtio-sound: implement audio capture (RX)
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
 =?UTF-8?B?S8WRdsOhZ8OzLCBab2x0w6Fu?= <DirtY.iCE.hu@gmail.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
References: <cover.1693252037.git.manos.pitsidianakis@linaro.org>
 <9a85da0dde1ff77021909e05b992bcdc76914eb1.1693252037.git.manos.pitsidianakis@linaro.org>
From: =?UTF-8?Q?Volker_R=c3=bcmelin?= <vr_qemu@t-online.de>
In-Reply-To: <9a85da0dde1ff77021909e05b992bcdc76914eb1.1693252037.git.manos.pitsidianakis@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1694155770-D3DC42DD-BD616C07/0/0 CLEAN NORMAL
X-TOI-MSGID: 9f2433ff-542e-460d-979e-7478f3686208
Received-SPF: none client-ip=194.25.134.83; envelope-from=vr_qemu@t-online.de;
 helo=mailout07.t-online.de
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Am 28.08.23 um 21:55 schrieb Emmanouil Pitsidianakis:
> To perform audio capture we duplicate the TX logic of the previous
> commit with the following difference: we receive data from the QEMU
> audio backend and write it in the virt queue IO buffers the guest sends
> to QEMU. When they are full (i.e. they have `period_bytes` amount of
> data) or when recording stops in QEMU's audio backend, the buffer is
> returned to the guest by notifying it.
>
> Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>   hw/virtio/trace-events |   3 +-
>   hw/virtio/virtio-snd.c | 245 +++++++++++++++++++++++++++++++++++------
>   2 files changed, 215 insertions(+), 33 deletions(-)
>
> diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
> index 3b95e745c2..9b7fbffedc 100644
> --- a/hw/virtio/trace-events
> +++ b/hw/virtio/trace-events
> @@ -172,4 +172,5 @@ virtio_snd_handle_code(uint32_t val, const char *code) "ctrl code msg val = %"PR
>   virtio_snd_handle_chmap_info(void) "VIRTIO_SND_CHMAP_INFO called"
>   virtio_snd_handle_event(void) "event queue callback called"
>   virtio_snd_pcm_stream_flush(uint32_t stream) "flushing stream %"PRIu32
> -virtio_snd_handle_xfer(void) "tx/rx queue callback called"
> +virtio_snd_handle_tx_xfer(void) "tx queue callback called"
> +virtio_snd_handle_rx_xfer(void) "rx queue callback called"
> diff --git a/hw/virtio/virtio-snd.c b/hw/virtio/virtio-snd.c
> index 4859ce4bf6..70e8a73072 100644
> --- a/hw/virtio/virtio-snd.c
> +++ b/hw/virtio/virtio-snd.c

> @@ -1002,26 +1073,119 @@ static void virtio_snd_pcm_out_cb(void *data, int available)
>   }
>   
>   /*
> - * Flush all buffer data from this stream's queue into the driver's virtual
> - * queue.
> + * AUD_* input callback.
>    *
> - * @stream: VirtIOSoundPCMStream *stream
> + * @data: VirtIOSoundPCMStream stream
> + * @available: number of bytes that can be read with AUD_read()
>    */
> -static void virtio_snd_pcm_flush(VirtIOSoundPCMStream *stream)
> +static void virtio_snd_pcm_in_cb(void *data, int available)
>   {
> +    VirtIOSoundPCMStream *stream = data;
>       VirtIOSoundPCMBlock *block;
> -    VirtIOSoundPCMBlock *next;
> +    uint32_t sz;
> +    virtio_snd_pcm_status resp = { 0 };
> +    size_t size;
>   
>       WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
> -        QSIMPLEQ_FOREACH_SAFE(block, &stream->queue, entry, next) {
> -            AUD_write(stream->voice.out, block->data + block->offset, block->size);
> -            virtqueue_push(block->vq, block->elem, sizeof(block->elem));
> -            virtio_notify(VIRTIO_DEVICE(stream->s), block->vq);
> -            QSIMPLEQ_REMOVE(&stream->queue, block, VirtIOSoundPCMBlock, entry);
> +        while (!QSIMPLEQ_EMPTY(&stream->queue)) {
> +            block = QSIMPLEQ_FIRST(&stream->queue);
> +
> +            for (;;) {
> +                size = AUD_read(stream->voice.in,
> +                        block->data + block->offset,
> +                        MIN(stream->period_bytes - block->offset, available));

For the -audiodev in.mixing-engine=off case, 'available' is much larger 
than the available bytes AUD_read() can actually read. 'size' is 0 when 
the upstream buffer is empty.

+                if (size == 0) {
+                    available = 0;
+                    break;
+                }

This fixes audio recording with -audiodev 
pipewire,out.mixing-engine=off,in.mixing-engine=off,id=audio0. The issue 
with two wrong audio frames every 25ms remains.

> +                block->offset += size;
> +                block->size += size;
> +                if (size == 0 || block->size >= stream->period_bytes) {

-                if (size == 0 || block->size >= stream->period_bytes) {
+                if (block->size >= stream->period_bytes) {

With best regards,
Volker

> +                    resp.status = VIRTIO_SND_S_OK;
> +                     sz = iov_from_buf(block->elem->in_sg,
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
> +                                     block->data,
> +                                     MIN(stream->period_bytes, block->size));
> +                    }
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
>           }
>       }
>   }
>   

