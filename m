Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D671A825F76
	for <lists+qemu-devel@lfdr.de>; Sat,  6 Jan 2024 13:26:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rM5jg-0005fm-L8; Sat, 06 Jan 2024 07:25:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1rM5je-0005fY-4K
 for qemu-devel@nongnu.org; Sat, 06 Jan 2024 07:25:06 -0500
Received: from mailout03.t-online.de ([194.25.134.81])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1rM5jb-00029H-Rp
 for qemu-devel@nongnu.org; Sat, 06 Jan 2024 07:25:05 -0500
Received: from fwd83.aul.t-online.de (fwd83.aul.t-online.de [10.223.144.109])
 by mailout03.t-online.de (Postfix) with SMTP id BBD2E517EC;
 Sat,  6 Jan 2024 13:25:00 +0100 (CET)
Received: from [192.168.211.200] ([93.236.158.98]) by fwd83.t-online.de
 with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
 esmtp id 1rM5jX-1lRSq10; Sat, 6 Jan 2024 13:24:59 +0100
Message-ID: <bd56f299-a425-45d5-9dba-558829600bac@t-online.de>
Date: Sat, 6 Jan 2024 13:24:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] hw/audio/virtio-sound: allocate all streams in
 advance
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
References: <b416aee3-72a9-4642-b219-3e1800ee5b3c@t-online.de>
 <20240104203422.12308-2-vr_qemu@t-online.de>
 <CAMxuvazUD51rzJAL0h6u70dm4EP33CMYoz=akydJ0k8cEmaOpQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>
In-Reply-To: <CAMxuvazUD51rzJAL0h6u70dm4EP33CMYoz=akydJ0k8cEmaOpQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1704543899-B980699C-932E1096/0/0 CLEAN NORMAL
X-TOI-MSGID: 596b3a2a-0560-4ef5-a006-bf1b8b9f767d
Received-SPF: pass client-ip=194.25.134.81; envelope-from=vr_qemu@t-online.de;
 helo=mailout03.t-online.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FROM=0.001,
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

Am 05.01.24 um 11:54 schrieb Marc-André Lureau:
> Hi
>
> On Fri, Jan 5, 2024 at 12:34 AM Volker Rümelin <vr_qemu@t-online.de> wrote:
>> It is much easier to migrate an array of structs than individual
>> structs that are accessed via a pointer to a pointer to an array
>> of pointers to struct, where some pointers can also be NULL.
>>
>> For this reason, the audio streams are already allocated during
>> the realization phase and all stream variables that are constant
>> at runtime are initialised immediately after allocation. This is
>> a step towards being able to migrate the audio streams of the
>> virtio sound device after the next few patches.
>>
>> Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
>> ---
>>  hw/audio/virtio-snd.c         | 35 ++++++++++++++++++++++-------------
>>  include/hw/audio/virtio-snd.h |  1 +
>>  2 files changed, 23 insertions(+), 13 deletions(-)
>>
>> diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
>> index 8344f61c64..36b1bb502c 100644
>> --- a/hw/audio/virtio-snd.c
>> +++ b/hw/audio/virtio-snd.c
>> @@ -447,11 +447,9 @@ static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, uint32_t stream_id)
>>
>>      stream = virtio_snd_pcm_get_stream(s, stream_id);
>>      if (stream == NULL) {
>> -        stream = g_new0(VirtIOSoundPCMStream, 1);
>> +        stream = &s->streams[stream_id];
>>          stream->active = false;
>> -        stream->id = stream_id;
>>          stream->pcm = s->pcm;
>> -        stream->s = s;
>>          QSIMPLEQ_INIT(&stream->queue);
>>          QSIMPLEQ_INIT(&stream->invalid);
> note: I can't find where s->pcm->streams[stream_id] is reset to NULL
> on pcm_release...

Hi Marc-André,

right, I'll have to remove the subordinate clause from the commit
message where I claim some pointers can be NULL. All streams get
allocated in virtio_snd_realize() with calls of virtio_snd_pcm_prepare()
and get freed in virtio_snd_unrealize().

>> @@ -463,14 +461,6 @@ static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, uint32_t stream_id)
>>      }
>>
>>      virtio_snd_get_qemu_audsettings(&as, params);
>> -    stream->info.direction = stream_id < s->snd_conf.streams / 2 +
>> -        (s->snd_conf.streams & 1) ? VIRTIO_SND_D_OUTPUT : VIRTIO_SND_D_INPUT;
>> -    stream->info.hdr.hda_fn_nid = VIRTIO_SOUND_HDA_FN_NID;
>> -    stream->info.features = 0;
>> -    stream->info.channels_min = 1;
>> -    stream->info.channels_max = as.nchannels;
>> -    stream->info.formats = supported_formats;
>> -    stream->info.rates = supported_rates;
>>      stream->params = *params;
>>
>>      stream->positions[0] = VIRTIO_SND_CHMAP_FL;
>> @@ -1074,6 +1064,24 @@ static void virtio_snd_realize(DeviceState *dev, Error **errp)
>>      vsnd->vmstate =
>>          qemu_add_vm_change_state_handler(virtio_snd_vm_state_change, vsnd);
>>
>> +    vsnd->streams = g_new0(VirtIOSoundPCMStream, vsnd->snd_conf.streams);
>> +
>> +    for (uint32_t i = 0; i < vsnd->snd_conf.streams; i++) {
>> +        VirtIOSoundPCMStream *stream = &vsnd->streams[i];
>> +
>> +        stream->id = i;
>> +        stream->s = vsnd;
>> +        stream->info.hdr.hda_fn_nid = VIRTIO_SOUND_HDA_FN_NID;
>> +        stream->info.features = 0;
>> +        stream->info.formats = supported_formats;
>> +        stream->info.rates = supported_rates;
>> +        stream->info.direction =
>> +            i < vsnd->snd_conf.streams / 2 + (vsnd->snd_conf.streams & 1)
>> +            ? VIRTIO_SND_D_OUTPUT : VIRTIO_SND_D_INPUT;
>> +        stream->info.channels_min = 1;
>> +        stream->info.channels_max = 2;
> Fixed max channels set to 2.. ? before this was set to
> MIN(AUDIO_MAX_CHANNELS, params->channels)

Before my patch params->channels and stream->info.max_channels were also
2 at the time the guest driver queried stream info. They got initialized
in function virtio_snd_realize().

default_params.channels = 2;
...
status = virtio_snd_set_pcm_params(vsnd, i, &default_params);
...
status = virtio_snd_pcm_prepare(vsnd, i);

The guest may not update stream->info variables. They are configuration
information set when QEMU starts. This was wrong in
virtio_snd_pcm_prepare().

>
>> +    }
>> +
>>      vsnd->pcm = g_new0(VirtIOSoundPCM, 1);
>>      vsnd->pcm->snd = vsnd;
>>      vsnd->pcm->streams =
>> @@ -1314,14 +1322,13 @@ static void virtio_snd_unrealize(DeviceState *dev)
>>      qemu_del_vm_change_state_handler(vsnd->vmstate);
>>      trace_virtio_snd_unrealize(vsnd);
>>
>> -    if (vsnd->pcm) {
>> +    if (vsnd->streams) {
>>          if (vsnd->pcm->streams) {
>>              for (uint32_t i = 0; i < vsnd->snd_conf.streams; i++) {
>>                  stream = vsnd->pcm->streams[i];
>>                  if (stream) {
>>                      virtio_snd_process_cmdq(stream->s);
>>                      virtio_snd_pcm_close(stream);
>> -                    g_free(stream);
>>                  }
>>              }
>>              g_free(vsnd->pcm->streams);
>> @@ -1329,6 +1336,8 @@ static void virtio_snd_unrealize(DeviceState *dev)
>>          g_free(vsnd->pcm->pcm_params);
>>          g_free(vsnd->pcm);
>>          vsnd->pcm = NULL;
>> +        g_free(vsnd->streams);
>> +        vsnd->streams = NULL;
>>      }
>>      AUD_remove_card(&vsnd->card);
>>      virtio_delete_queue(vsnd->queues[VIRTIO_SND_VQ_CONTROL]);
>> diff --git a/include/hw/audio/virtio-snd.h b/include/hw/audio/virtio-snd.h
>> index ea6315f59b..05b4490488 100644
>> --- a/include/hw/audio/virtio-snd.h
>> +++ b/include/hw/audio/virtio-snd.h
>> @@ -216,6 +216,7 @@ struct VirtIOSound {
>>      VirtQueue *queues[VIRTIO_SND_VQ_MAX];
>>      uint64_t features;
>>      VirtIOSoundPCM *pcm;
>> +    VirtIOSoundPCMStream *streams;
>>      QEMUSoundCard card;
>>      VMChangeStateEntry *vmstate;
>>      virtio_snd_config snd_conf;
>> --
>> 2.35.3
>>


