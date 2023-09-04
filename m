Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 792097915D0
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 12:44:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd73V-0007cM-Gh; Mon, 04 Sep 2023 06:43:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qd73R-0007bz-NJ
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 06:43:37 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qd73M-0008OH-SH
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 06:43:35 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-401f503b529so12796775e9.0
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 03:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693824211; x=1694429011; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=c0IDn+/TdfOj4MStmiHlZl7lnESFMn0ElrgHyzQexRk=;
 b=Y/sc1zQobtVWi5/T0X/K4f2WlpkGX/c2VzTEsQj6vTT6V7kxHW0sCUHBOrPSe1J/cn
 KcntFDDHp4+UWEzjN02mhDRBb2Il8WLUT/C+XvH5HtEEsF7jgkiSRCO1rWSPG2AO9FTB
 gEFWt63k80JRmNV81PcjCUdwZ+IY7+rldp9o8f++QRLmyasKnln+iUBlDjBIQtU26Zqb
 tHVaKCOmuniR+eQWFUDKJpIsEpb2e4WfwRup/wRASepMxDFE0sLu/CBSbCzvaEVt0HPP
 Psy7uDFXWUQtc6cIrGly+CrPAFlzsMGj5CJnIgHsvGipOXlYcq6VscmoZtNOHAfg9wLg
 hAGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693824211; x=1694429011;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=c0IDn+/TdfOj4MStmiHlZl7lnESFMn0ElrgHyzQexRk=;
 b=QRyaaFzZ/cLwZPFWu9bjcoXm8alTFWxm8obZWk2qKJW2qkDbQ17GOK9q4DCpAL/FsO
 Mpw0BMulTs/GlOW6IMSAl3OdnixpN+8pzpc/5MzyPMxqds6kS/Z2K4/WeDL2h7iQYXxc
 JyYtwLSLLZoBJGpfQr0LCrUZyqliOKu2qcp0DQUppn7Xm+z3JNtkwiOG86BH/jWFZoxo
 AOQDmsk3StVg/Hvt0XuU/qa2muskOhgdsHD8xwDcODxXHILOrAMVhmn2NdyQc5pfCCdM
 wkfncK7uuMs/EAJf1s0BVoUa7lzDX07eyF8dxWfa93LBrkMh6z9uGVrszkwV+0U05WkU
 Gf3A==
X-Gm-Message-State: AOJu0Yxn50M6hDz+pPhj4Fbh4CzzelTvzgQmJ20FA+wrNlgNcqurV9hR
 fo5Mrv20uHhxdm29X26Uw4zmrA==
X-Google-Smtp-Source: AGHT+IFYHjQ4G7OYdgJ/Y+O4gCb9Aw/qtYiCQYApJ/h2Jvr8cUONLuJwhKNEwnHxrz02SR7AGitxDg==
X-Received: by 2002:adf:e647:0:b0:31a:ea9f:1aa6 with SMTP id
 b7-20020adfe647000000b0031aea9f1aa6mr6927424wrn.47.1693824211182; 
 Mon, 04 Sep 2023 03:43:31 -0700 (PDT)
Received: from meli.delivery (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 g7-20020a5d46c7000000b0031accc7228asm14073423wrs.34.2023.09.04.03.43.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Sep 2023 03:43:30 -0700 (PDT)
Date: Mon, 04 Sep 2023 13:34:12 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Igor Skalkin <Igor.Skalkin@opensynergy.com>,
 Anton Yakovlev <Anton.Yakovlev@opensynergy.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "ichael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Daniel P. Berrang=?UTF-8?B?w6k=?= " <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marc-Andr=?UTF-8?B?w6kg?=Lureau <marcandre.lureau@redhat.com>,
 Volker R=?UTF-8?B?w7w=?= melin <vr_qemu@t-online.de>,
 "K=?UTF-8?B?xZE=?= v=?UTF-8?B?w6E=?= g=?UTF-8?B?w7M=?= ,
 Zolt=?UTF-8?B?w6E=?= n" <DirtY.iCE.hu@gmail.com>,
 Alex Benn=?UTF-8?B?w6k=?= e <alex.bennee@linaro.org>
Subject: Re: [PATCH v8 10/12] virtio-sound: implement audio output (TX)
User-Agent: meli 0.8.0
References: <cover.1693252037.git.manos.pitsidianakis@linaro.org>
 <c94a9c1e65bb6bb43c58e5ccb982948424a3f3f2.1693252037.git.manos.pitsidianakis@linaro.org>
 <3e844c1a-4f44-7a99-cc7f-810881335e45@linaro.org>
In-Reply-To: <3e844c1a-4f44-7a99-cc7f-810881335e45@linaro.org>
Message-ID: <0gj4g.pagm7im4jud8@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Mon, 04 Sep 2023 13:26, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>   /*
>> - * Handles VIRTIO_SND_R_PCM_RELEASE. Releases the buffer resources allocated to
>> - * a stream.
>> + * Returns the number of I/O messages that are being processed.
>> + *
>> + * @stream: VirtIOSoundPCMStream
>> + */
>> +static size_t virtio_snd_pcm_get_pending_io_msgs(VirtIOSoundPCMStream *stream)
>> +{
>> +    VirtIOSoundPCMBlock *block;
>> +    VirtIOSoundPCMBlock *next;
>> +    size_t size = 0;
>> +
>> +    WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
>> +        QSIMPLEQ_FOREACH_SAFE(block, &stream->queue, entry, next) {
>> +            size += 1;
>
>Can you add a comment explaining this magic size?

It's not magic, it's simply how many messages there are as explained in 
the function doc comment. This was previously bytes hence `size`. I will 
change the variable name to `count`.

>> +static void virtio_snd_handle_tx(VirtIODevice *vdev, VirtQueue *vq)
>> +{
>> +    VirtIOSound *s = VIRTIO_SND(vdev);
>> +    VirtIOSoundPCMStream *stream = NULL;
>> +    VirtQueueElement *elem;
>> +    size_t sz;
>> +    virtio_snd_pcm_xfer hdr;
>> +    virtio_snd_pcm_status resp = { 0 };
>
>virtio_snd_pcm_status has multiple fields, so better zero-initialize
>all of them with '{ }'.

I don't understand why, virtio_snd_pcm_status has two int fields hence { 
0 } zero-initializes all of them.

>> +/*
>> + * AUD_* output callback.
>> + *
>> + * @data: VirtIOSoundPCMStream stream
>> + * @available: number of bytes that can be written with AUD_write()
>> + */
>> +static void virtio_snd_pcm_out_cb(void *data, int available)
>> +{
>> +    VirtIOSoundPCMStream *stream = data;
>> +    VirtIOSoundPCMBlock *block;
>> +    VirtIOSoundPCMBlock *next;
>> +    size_t size;
>> +
>> +    WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
>> +        QSIMPLEQ_FOREACH_SAFE(block, &stream->queue, entry, next) {
>> +            for (;;) {
>> +                size = MIN(block->size, available);
>> +                size = AUD_write(stream->voice.out,
>> +                        block->data + block->offset,
>> +                        size);
>
>If AUD_write() returns 0, is this an infinite loop?

Hm since we have available > 0 bytes this wouldn't theoretically happen, 
but I see there are code paths that return 0 on bugs/failures, I will 
add the check.

>> +                block->size -= size;
>> +                block->offset += size;
>> +                if (!block->size) {
>> +                    virtqueue_push(block->vq,
>> +                            block->elem,
>> +                            sizeof(block->elem));
>> +                    virtio_notify(VIRTIO_DEVICE(stream->s),
>> +                            block->vq);
>> +                    QSIMPLEQ_REMOVE_HEAD(&stream->queue, entry);
>> +                    g_free(block);
>> +                    available -= size;
>> +                    break;
>> +                }
>> +
>> +                available -= size;
>> +                if (!available) {
>> +                    break;
>> +                }
>> +            }
>> +            if (!available) {
>> +                break;
>> +            }
>> +        }
>> +    }
>> +}
>> +
>> +/*
>> + * Flush all buffer data from this stream's queue into the driver's virtual
>> + * queue.
>> + *
>> + * @stream: VirtIOSoundPCMStream *stream
>> + */
>> +static void virtio_snd_pcm_flush(VirtIOSoundPCMStream *stream)
>> +{
>> +    VirtIOSoundPCMBlock *block;
>> +    VirtIOSoundPCMBlock *next;
>> +
>> +    WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
>> +        QSIMPLEQ_FOREACH_SAFE(block, &stream->queue, entry, next) {
>> +            AUD_write(stream->voice.out, block->data + block->offset, block->size);
>
>Is it OK to ignore AUD_write() returning < block->size?
>If so, can you add a comment please?

This is a flush event with a timeout so it should complete asap. As 
mentioned in another reply it might be better to copy the data to a 
buffer in order not to lose any audio bytes.

Thank you for the feedback,
Manos

