Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E407791F08
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 23:36:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdHE3-00066d-9j; Mon, 04 Sep 2023 17:35:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1qdHE0-00066H-A6
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 17:35:12 -0400
Received: from mailout11.t-online.de ([194.25.134.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1qdHDw-0004MA-MU
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 17:35:12 -0400
Received: from fwd71.aul.t-online.de (fwd71.aul.t-online.de [10.223.144.97])
 by mailout11.t-online.de (Postfix) with SMTP id 4891F12FA1;
 Mon,  4 Sep 2023 23:34:52 +0200 (CEST)
Received: from [192.168.211.200] ([79.208.25.148]) by fwd71.t-online.de
 with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
 esmtp id 1qdHDd-1nBG0f0; Mon, 4 Sep 2023 23:34:49 +0200
Message-ID: <dbc4b65f-364b-02cc-b182-9c2f592d2ff5@t-online.de>
Date: Mon, 4 Sep 2023 23:34:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v8 10/12] virtio-sound: implement audio output (TX)
Content-Language: en-US
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud_=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Igor Skalkin <Igor.Skalkin@opensynergy.com>,
 Anton Yakovlev <Anton.Yakovlev@opensynergy.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?B?S8WRdsOhZ8OzICwgWm9sdMOhbg==?= <DirtY.iCE.hu@gmail.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <cover.1693252037.git.manos.pitsidianakis@linaro.org>
 <c94a9c1e65bb6bb43c58e5ccb982948424a3f3f2.1693252037.git.manos.pitsidianakis@linaro.org>
 <3e844c1a-4f44-7a99-cc7f-810881335e45@linaro.org>
 <0gj4g.pagm7im4jud8@linaro.org>
From: =?UTF-8?Q?Volker_R=c3=bcmelin?= <vr_qemu@t-online.de>
In-Reply-To: <0gj4g.pagm7im4jud8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1693863289-D0DBE2DD-1F1EBCEA/0/0 CLEAN NORMAL
X-TOI-MSGID: 56ab7972-747c-4a3d-a368-039d05f19240
Received-SPF: none client-ip=194.25.134.85; envelope-from=vr_qemu@t-online.de;
 helo=mailout11.t-online.de
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
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

Am 04.09.23 um 12:34 schrieb Manos Pitsidianakis:
> On Mon, 04 Sep 2023 13:26, Philippe Mathieu-Daudé <philmd@linaro.org> 
> wrote:
>
>>> +/*
>>> + * AUD_* output callback.
>>> + *
>>> + * @data: VirtIOSoundPCMStream stream
>>> + * @available: number of bytes that can be written with AUD_write()
>>> + */
>>> +static void virtio_snd_pcm_out_cb(void *data, int available)
>>> +{
>>> +    VirtIOSoundPCMStream *stream = data;
>>> +    VirtIOSoundPCMBlock *block;
>>> +    VirtIOSoundPCMBlock *next;
>>> +    size_t size;
>>> +
>>> +    WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
>>> +        QSIMPLEQ_FOREACH_SAFE(block, &stream->queue, entry, next) {
>>> +            for (;;) {
>>> +                size = MIN(block->size, available);
>>> +                size = AUD_write(stream->voice.out,
>>> +                        block->data + block->offset,
>>> +                        size);
>>
>> If AUD_write() returns 0, is this an infinite loop?
>
> Hm since we have available > 0 bytes this wouldn't theoretically 
> happen, but I see there are code paths that return 0 on bugs/failures, 
> I will add the check.

Before QEMU 8.0.0 it was possible that AUD_write() couldn't write the 
last audio frame and sometimes 'available' was just miscalculated. Since 
commit e1e6a6fcc9 ("audio: handle leftover audio frame from upsampling") 
AUD_write() writes all 'available' bytes.

With best regards,
Volker

>
>>> +                block->size -= size;
>>> +                block->offset += size;
>>> +                if (!block->size) {
>>> +                    virtqueue_push(block->vq,
>>> +                            block->elem,
>>> +                            sizeof(block->elem));
>>> + virtio_notify(VIRTIO_DEVICE(stream->s),
>>> +                            block->vq);
>>> + QSIMPLEQ_REMOVE_HEAD(&stream->queue, entry);
>>> +                    g_free(block);
>>> +                    available -= size;
>>> +                    break;
>>> +                }
>>> +
>>> +                available -= size;
>>> +                if (!available) {
>>> +                    break;
>>> +                }
>>> +            }
>>> +            if (!available) {
>>> +                break;
>>> +            }
>>> +        }
>>> +    }
>>> +}
>>> +
>>> +/*
>>> + * Flush all buffer data from this stream's queue into the driver's 
>>> virtual
>>> + * queue.
>>> + *
>>> + * @stream: VirtIOSoundPCMStream *stream
>>> + */
>>> +static void virtio_snd_pcm_flush(VirtIOSoundPCMStream *stream)
>>> +{
>>> +    VirtIOSoundPCMBlock *block;
>>> +    VirtIOSoundPCMBlock *next;
>>> +
>>> +    WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
>>> +        QSIMPLEQ_FOREACH_SAFE(block, &stream->queue, entry, next) {
>>> +            AUD_write(stream->voice.out, block->data + 
>>> block->offset, block->size);
>>


