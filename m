Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF1BA79164E
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 13:41:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd7w7-0005oN-Jw; Mon, 04 Sep 2023 07:40:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qd7w4-0005mk-8H
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 07:40:04 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qd7w1-0005Lg-KL
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 07:40:03 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-9a21b6d105cso195182366b.3
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 04:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693827600; x=1694432400; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=I9VSZ/RoCz2PvXgp7lskCvNP5Oy7UcC/7nDWAnMjRII=;
 b=RnPT7jvgEG7+efylFv6q57k9fRlILn8w6T0iiJU01aHNG35dabx4F01X6qWzJlkpon
 4zbRwhZkKgs8jyRx2dq5QrjpF8BjT7Qsax7evjnvVNQ7i5ejadjwkrkLVvq+5FaDTDhp
 4vvrenlJY1Qy/SwW5Wb4i3bdCu20dWZ6WiOGJOjmbYFf4EgnajSxOoe1v/LoD6Yv63lz
 70Nz5YofM8iJrmkD3ut6MDiOV6ZpJITBtK+EkEJib6Ro2ZUD3sGvp6dCVx0VZUgq+CTD
 +htKpHgZSUiXlUc0ee8Ete57KdNTzoJetHEsqwIp3J2qgnAvQN1mAGvv9uEbKnoDLq/c
 N3Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693827600; x=1694432400;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=I9VSZ/RoCz2PvXgp7lskCvNP5Oy7UcC/7nDWAnMjRII=;
 b=cumYCOfSRwxkX80t5QXxFURAaWa/KhNvT1weYu3+Kr6/pS8A8uazfRy7H4xH8cjjs1
 iQbJYwtb1oDg/4e36os/ravba+IhK0qAvcL4txlGFpJqcO9MCcNPDIlrouIWOFlBz+kM
 KmJ1KjxGta8hpg5LeXJBRCQbnlUrk15bjdwwR44gJNrNBnYBiGC1zysoXGqzJ7rOJaHh
 /soi8rTvtQumzCRJn+wsXt3zaIT2Io0QGLhd418BgmIT46Sypp0PYzG7T1RnUPPqF4RM
 TAx7M53I23AzbrPUEN+WMfMWfsXlLfk66GZa0E0BF6PBXeDyjQ8bnLsLTGYGQilHWdi4
 GK2A==
X-Gm-Message-State: AOJu0YwQWg68F2dKHN2rdCpiw+QRmeGEyaIOb4lTqvqApHwvIhBHDLc2
 Et3GaplvNQokiiKQSO/8MatK7g==
X-Google-Smtp-Source: AGHT+IHJ7mGaHxEqPFVqU9OrCtbDFLeUvvmZ7u1TbiHltUlpoIb6alK/pcjS41LtNXl777kpLOFd+A==
X-Received: by 2002:a17:906:1d:b0:9a2:28dc:4166 with SMTP id
 29-20020a170906001d00b009a228dc4166mr8047924eja.75.1693827599187; 
 Mon, 04 Sep 2023 04:39:59 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.209.227])
 by smtp.gmail.com with ESMTPSA id
 c25-20020a170906529900b0098ce63e36e9sm6137336ejm.16.2023.09.04.04.39.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Sep 2023 04:39:58 -0700 (PDT)
Message-ID: <f2828683-ad02-9558-7e88-bbfe343da97a@linaro.org>
Date: Mon, 4 Sep 2023 13:39:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v8 10/12] virtio-sound: implement audio output (TX)
Content-Language: en-US
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
Cc: Igor Skalkin <Igor.Skalkin@opensynergy.com>,
 Anton Yakovlev <Anton.Yakovlev@opensynergy.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "ichael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Marc-Andr_=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Volker_R_=c3=bc_melin?= <vr_qemu@t-online.de>,
 =?UTF-8?B?S8WRIHbDoSBnw7MgLCBab2x0w6Egbg==?= <DirtY.iCE.hu@gmail.com>,
 =?UTF-8?Q?Alex_Benn_=c3=a9_e?= <alex.bennee@linaro.org>
References: <cover.1693252037.git.manos.pitsidianakis@linaro.org>
 <c94a9c1e65bb6bb43c58e5ccb982948424a3f3f2.1693252037.git.manos.pitsidianakis@linaro.org>
 <3e844c1a-4f44-7a99-cc7f-810881335e45@linaro.org>
 <0gj4g.pagm7im4jud8@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <0gj4g.pagm7im4jud8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x630.google.com
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

On 4/9/23 12:34, Manos Pitsidianakis wrote:
> On Mon, 04 Sep 2023 13:26, Philippe Mathieu-Daudé <philmd@linaro.org> 
> wrote:
>>>   /*
>>> - * Handles VIRTIO_SND_R_PCM_RELEASE. Releases the buffer resources 
>>> allocated to
>>> - * a stream.
>>> + * Returns the number of I/O messages that are being processed.
>>> + *
>>> + * @stream: VirtIOSoundPCMStream
>>> + */
>>> +static size_t 
>>> virtio_snd_pcm_get_pending_io_msgs(VirtIOSoundPCMStream *stream)
>>> +{
>>> +    VirtIOSoundPCMBlock *block;
>>> +    VirtIOSoundPCMBlock *next;
>>> +    size_t size = 0;
>>> +
>>> +    WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
>>> +        QSIMPLEQ_FOREACH_SAFE(block, &stream->queue, entry, next) {
>>> +            size += 1;
>>
>> Can you add a comment explaining this magic size?
> 
> It's not magic, it's simply how many messages there are as explained in 
> the function doc comment. This was previously bytes hence `size`. I will 
> change the variable name to `count`.

Ah OK. 'msg_processed'?

>>> +static void virtio_snd_handle_tx(VirtIODevice *vdev, VirtQueue *vq)
>>> +{
>>> +    VirtIOSound *s = VIRTIO_SND(vdev);
>>> +    VirtIOSoundPCMStream *stream = NULL;
>>> +    VirtQueueElement *elem;
>>> +    size_t sz;
>>> +    virtio_snd_pcm_xfer hdr;
>>> +    virtio_snd_pcm_status resp = { 0 };
>>
>> virtio_snd_pcm_status has multiple fields, so better zero-initialize
>> all of them with '{ }'.
> 
> I don't understand why, virtio_snd_pcm_status has two int fields hence { 
> 0 } zero-initializes all of them.

Hmm I'm too busy right now to check the C standard. Looking at QEMU
code base, most of the time we use nothing or N * 0 to initialize N
fields:

$ git grep '{ }' | wc -l
      536
$ git grep -E '{ ?0, 0 ?}' | wc -l
       50
$ git grep '{ }' | wc -l
      536

Anyway, not a blocker.

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
> Hm since we have available > 0 bytes this wouldn't theoretically happen, 
> but I see there are code paths that return 0 on bugs/failures, I will 
> add the check.

Thanks.

>>> +                block->size -= size;
>>> +                block->offset += size;
>>> +                if (!block->size) {
>>> +                    virtqueue_push(block->vq,
>>> +                            block->elem,
>>> +                            sizeof(block->elem));
>>> +                    virtio_notify(VIRTIO_DEVICE(stream->s),
>>> +                            block->vq);
>>> +                    QSIMPLEQ_REMOVE_HEAD(&stream->queue, entry);
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
>> Is it OK to ignore AUD_write() returning < block->size?
>> If so, can you add a comment please?
> 
> This is a flush event with a timeout so it should complete asap. As 
> mentioned in another reply it might be better to copy the data to a 
> buffer in order not to lose any audio bytes.

Maybe this could do:

   /*
    * This is a flush event with a timeout which should complete ASAP.
    * TODO: Copy the data to a buffer in order not to lose any audio
    * bytes. (Meanwhile we just discard any write failure).
    */

Regards,

Phil.

