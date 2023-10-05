Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 881BC7B9D6D
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 15:40:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoOZl-0007Ke-Dj; Thu, 05 Oct 2023 09:39:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qoOZh-0007KM-Qf
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 09:39:33 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qoOZd-00049e-M6
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 09:39:33 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 7491275715B;
 Thu,  5 Oct 2023 15:38:42 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 33D27756BF9; Thu,  5 Oct 2023 15:38:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 32381748FF4;
 Thu,  5 Oct 2023 15:38:42 +0200 (CEST)
Date: Thu, 5 Oct 2023 15:38:42 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Paolo Bonzini <pbonzini@redhat.com>
cc: qemu-devel@nongnu.org, berrange@redhat.com
Subject: Re: [PATCH 5/7] audio: do not use first -audiodev as default audio
 device
In-Reply-To: <d8327a5f-9a06-2c35-a0c8-372707ea0c4a@eik.bme.hu>
Message-ID: <18a7de6d-b542-9bf6-2128-d005e2e08a64@eik.bme.hu>
References: <20231005125815.66082-1-pbonzini@redhat.com>
 <20231005125815.66082-6-pbonzini@redhat.com>
 <d8327a5f-9a06-2c35-a0c8-372707ea0c4a@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Probability: 9%
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

On Thu, 5 Oct 2023, BALATON Zoltan wrote:
> On Thu, 5 Oct 2023, Paolo Bonzini wrote:
>> It is now possible to specify the options for the default audio device
>> using -audio, so there is no need anymore to use a fake -audiodev option.
>> 
>> Remove the fall back to QTAILQ_FIRST(&audio_states), instead remember the
>> AudioState that was created from default_audiodevs and use that one.
>> 
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>> audio/audio.c                   | 25 +++++++------------------
>> docs/about/deprecated.rst       |  6 ------
>> docs/about/removed-features.rst |  8 ++++++++
>> 3 files changed, 15 insertions(+), 24 deletions(-)
>> 
>> diff --git a/audio/audio.c b/audio/audio.c
>> index 186cc4d336e..de37ad7c074 100644
>> --- a/audio/audio.c
>> +++ b/audio/audio.c
>> @@ -104,6 +104,7 @@ static audio_driver *audio_driver_lookup(const char 
>> *name)
>> 
>> static QTAILQ_HEAD(AudioStateHead, AudioState) audio_states =
>>     QTAILQ_HEAD_INITIALIZER(audio_states);
>> +static AudioState *default_audio_state;
>> 
>> const struct mixeng_volume nominal_volume = {
>>     .mute = 0,
>> @@ -1660,6 +1661,7 @@ static void free_audio_state(AudioState *s)
>> 
>> void audio_cleanup(void)
>> {
>> +    default_audio_state = NULL;
>>     while (!QTAILQ_EMPTY(&audio_states)) {
>>         AudioState *s = QTAILQ_FIRST(&audio_states);
>>         QTAILQ_REMOVE(&audio_states, s, list);
>> @@ -1760,6 +1762,7 @@ static AudioState *audio_init(Audiodev *dev, Error 
>> **errp)
>>             goto out;
>>         }
>>     } else {
>> +        assert(!default_audio_state);
>>         for (;;) {
>>             AudiodevListEntry *e = QSIMPLEQ_FIRST(&default_audiodevs);
>>             if (!e) {
>> @@ -1801,24 +1804,9 @@ out:
>> bool AUD_register_card (const char *name, QEMUSoundCard *card, Error 
>> **errp)
>> {
>>     if (!card->state) {
>> -        if (!QTAILQ_EMPTY(&audio_states)) {
>> -            /*
>> -             * FIXME: once it is possible to create an arbitrary
>> -             * default device via -audio DRIVER,OPT=VALUE (no "model"),
>> -             * replace this special case with the default AudioState*,
>> -             * storing it in a separate global.  For now, keep the
>> -             * warning to encourage moving off magic use of the first
>> -             * -audiodev.
>> -             */
>> -            if (QSIMPLEQ_EMPTY(&default_audiodevs)) {
>> -                dolog("Device %s: audiodev default parameter is 
>> deprecated, please "
>> -                      "specify audiodev=%s\n", name,
>> -                      QTAILQ_FIRST(&audio_states)->dev->id);
>> -            }
>> -            card->state = QTAILQ_FIRST(&audio_states);
>> -        } else {
>> -            card->state = audio_init(NULL, errp);
>> -            if (!card->state) {
>> +        if (!default_audio_state) {
>> +            default_audio_state = audio_init(NULL, errp);
>> +            if (!default_audio_state) {
>>                 if (!QSIMPLEQ_EMPTY(&audiodevs)) {
>>                     error_append_hint(errp, "Perhaps you wanted to set 
>> audiodev=%s?\n",
>>                                       QSIMPLEQ_FIRST(&audiodevs)->dev->id);
>> @@ -1826,6 +1814,7 @@ bool AUD_register_card (const char *name, 
>> QEMUSoundCard *card, Error **errp)
>>                 return false;
>>             }
>>         }
>> +        card->state = default_audio_state;
>>     }
>>
>>     card->name = g_strdup (name);
>> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
>> index 2f51cf770ae..d59bcf36230 100644
>> --- a/docs/about/deprecated.rst
>> +++ b/docs/about/deprecated.rst
>> @@ -37,12 +37,6 @@ coverage.
>> System emulator command line arguments
>> --------------------------------------
>> 
>> -Creating sound card devices without ``audiodev=`` property (since 4.2)
>> -''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
>> -
>> -When not using the deprecated legacy audio config, each sound card
>> -should specify an ``audiodev=`` property.
>> -
>> Short-form boolean options (since 6.0)
>> ''''''''''''''''''''''''''''''''''''''
>> 
>> diff --git a/docs/about/removed-features.rst 
>> b/docs/about/removed-features.rst
>> index 58c94392c65..27639370f96 100644
>> --- a/docs/about/removed-features.rst
>> +++ b/docs/about/removed-features.rst
>> @@ -442,10 +442,18 @@ line using a ``secret`` object instance.
>> The ``-audiodev`` and ``-audio`` command line options are now the only
>> way to specify audio backend settings.
>> 
>> +Using ``-audiodev`` to define the default audio backend (removed in 8.2)
>> +''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
>> +
>> QEMU does not create default audio backends anymore if any of the
>> ``-audiodev``, ``-audio`` or ``-nodefaults`` options are used on the
>> command line.
>
> Maybe this needs further updating because -audio can now define the default 
> and is what should be used instead of -audiodev but this is not clear from 
> this documentation.

And while at it, maybe also mention machine audiodev property here as a 
way to set audiodev of embedded devices.

Regards,
BALATON Zoltan

>> +If an audio backend is created with ``-audiodev``, each sound card
>> +that wants to use it should specify an ``audiodev=``
>> +property.  Previously, the first audiodev command line option would be
>> +used as a fallback.
>> +
>> Creating vnc without ``audiodev=`` property (removed in 8.2)
>> ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
>> 
>> 
>
>

