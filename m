Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD547ABE43
	for <lists+qemu-devel@lfdr.de>; Sat, 23 Sep 2023 09:11:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjwls-0000nc-5p; Sat, 23 Sep 2023 03:09:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1qjwlo-0000nS-1a
 for qemu-devel@nongnu.org; Sat, 23 Sep 2023 03:09:40 -0400
Received: from mailout11.t-online.de ([194.25.134.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1qjwll-0006dF-TR
 for qemu-devel@nongnu.org; Sat, 23 Sep 2023 03:09:39 -0400
Received: from fwd71.aul.t-online.de (fwd71.aul.t-online.de [10.223.144.97])
 by mailout11.t-online.de (Postfix) with SMTP id 9C92327878;
 Sat, 23 Sep 2023 09:09:35 +0200 (CEST)
Received: from [192.168.211.200] ([79.208.31.195]) by fwd71.t-online.de
 with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
 esmtp id 1qjwlh-37Z3Sr0; Sat, 23 Sep 2023 09:09:33 +0200
Message-ID: <7c123058-4004-48d9-9e4f-815d65e0b2e1@t-online.de>
Date: Sat, 23 Sep 2023 09:09:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/20] audio: add Apple Sound Chip (ASC) emulation
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, laurent@vivier.eu
Cc: qemu-devel@nongnu.org
References: <20230909094827.33871-1-mark.cave-ayland@ilande.co.uk>
 <20230909094827.33871-8-mark.cave-ayland@ilande.co.uk>
 <373b3abd-a726-e795-eaee-0389a25c662f@t-online.de>
 <f3e9aa48-d450-c11d-9639-a7a852719a64@ilande.co.uk>
From: =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>
In-Reply-To: <f3e9aa48-d450-c11d-9639-a7a852719a64@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1695452973-C497F103-4E0A3277/0/0 CLEAN NORMAL
X-TOI-MSGID: c24e4500-4ca0-42e6-ba0a-805adfd3edaa
Received-SPF: none client-ip=194.25.134.85; envelope-from=vr_qemu@t-online.de;
 helo=mailout11.t-online.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Am 20.09.23 um 17:39 schrieb Mark Cave-Ayland:
> On 14/09/2023 08:06, Volker Rümelin wrote:
>
>> Am 09.09.23 um 11:48 schrieb Mark Cave-Ayland:
>>> The Apple Sound Chip was primarily used by the Macintosh II to
>>> generate sound
>>> in hardware which was previously handled by the toolbox ROM with
>>> software
>>> interrupts.
>>>
>>> Implement both the standard ASC and also the enhanced ASC (EASC)
>>> functionality
>>> which is used in the Quadra 800.
>>>
>>> Note that whilst real ASC hardware uses AUDIO_FORMAT_S8, this
>>> implementation uses
>>> AUDIO_FORMAT_U8 instead because AUDIO_FORMAT_S8 is rarely used and
>>> not supported
>>> by some audio backends like PulseAudio and DirectSound when played
>>> directly with
>>> -audiodev out.mixing-engine=off.
>>>
>>> Co-developed-by: Laurent Vivier <laurent@vivier.eu>
>>> Co-developed-by: Volker Rümelin <vr_qemu@t-online.de>
>>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>> ---
>>>   MAINTAINERS            |   2 +
>>>   hw/audio/Kconfig       |   3 +
>>>   hw/audio/asc.c         | 699
>>> +++++++++++++++++++++++++++++++++++++++++
>>>   hw/audio/meson.build   |   1 +
>>>   hw/audio/trace-events  |  10 +
>>>   hw/m68k/Kconfig        |   1 +
>>>   include/hw/audio/asc.h |  84 +++++
>>>   7 files changed, 800 insertions(+)
>>>   create mode 100644 hw/audio/asc.c
>>>   create mode 100644 include/hw/audio/asc.h
>>
>> Hi Mark,
>>
>> the function generate_fifo() has four issues. Only the first one
>> is noticeable.
>>
>> 1. The calculation of the variable limit assumes generate_fifo()
>> generates one output sample from every input byte. This is correct
>> for the raw mode, but not for the CD-XA BRR mode. This mode
>> generates 28 output samples from 15 input bytes. This is the
>> reason for the stuttering end of a CD-XA BRR mode sound. Every
>> generate_fifo() call generates approximately only half of the
>> possible samples when the fifo bytes are running low.
>>
>> 2. generate_fifo() doesn't generate the last output sample from
>> a CD-XA BRR mode sound. The last sample is generated from internal
>> state and the code will not be called without at least one byte
>> in the fifo.
>>
>> 3. It's not necessary to wait for a complete 15 byte packet in
>> CD-XA BRR mode. Audio playback devices should write all
>> requested samples immediately if possible.
>>
>> 4. The saturation function in CD-XA BRR mode works with 16 bit
>> integers. It should saturate at +32767 and -32768.
>>
>> Since I think a few lines of code explain the issues better
>> than my words, I've attached a patch below.
>>
>> With best regards,
>> Volker
>
> Hi Volker,
>
> Thanks for detailed explanation above - everything makes sense based
> upon previous discussions. My only question is in comment 3 where you
> say "Audio playback devices should write all requested samples
> immediately if possible": can you clarify does this mean that the
> supplied length to the audio callback represents a *required* rather
> than a *maximum* number of samples?
>

Hi Mark,

the supplied length is the number of bytes needed to fill the downstream
audio buffer completely or as fast as possible. An incompletely filled
buffer increases the probability of dropouts. The supplied length is
also the maximum number of bytes AUD_write() will write.

So it's better to write as many bytes as possible, but if you can't it
won't cause audio problems immediately in most cases.

With best regards,
Volker

> Regardless of this I've had some time to test on Windows this
> afternoon, and I can confirm that your changes fix the outstanding
> audio issues. I've squashed your changes locally and I'll included
> them in the next revision of the series, although I'll likely wait a
> bit first to see if any more reviews are forthcoming.
>
>
> Many thanks,
>
> Mark.
>


