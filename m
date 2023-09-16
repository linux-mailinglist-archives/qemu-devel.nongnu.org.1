Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B22777A2ED4
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Sep 2023 10:21:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhQWg-0003Sg-Cj; Sat, 16 Sep 2023 04:19:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1qhQWd-0003S6-Gr
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 04:19:35 -0400
Received: from mailout07.t-online.de ([194.25.134.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1qhQWb-0001Dq-Ct
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 04:19:35 -0400
Received: from fwd70.aul.t-online.de (fwd70.aul.t-online.de [10.223.144.96])
 by mailout07.t-online.de (Postfix) with SMTP id 68AE257A1D;
 Sat, 16 Sep 2023 10:19:28 +0200 (CEST)
Received: from [192.168.211.200] ([79.208.31.89]) by fwd70.t-online.de
 with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
 esmtp id 1qhQWU-1djGmv0; Sat, 16 Sep 2023 10:19:26 +0200
Message-ID: <1ffc1fab-94ef-445f-9df3-a029bf9e68ef@t-online.de>
Date: Sat, 16 Sep 2023 10:19:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/20] asc: generate silence if FIFO empty but engine
 still running
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, laurent@vivier.eu,
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20230909094827.33871-1-mark.cave-ayland@ilande.co.uk>
 <20230909094827.33871-9-mark.cave-ayland@ilande.co.uk>
 <25d8059c-422a-3f2a-3f33-7a9848f4b3da@linaro.org>
From: =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>
In-Reply-To: <25d8059c-422a-3f2a-3f33-7a9848f4b3da@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1694852366-7D9FFE98-79C1A3C1/0/0 CLEAN NORMAL
X-TOI-MSGID: 44ceb656-7534-4294-9609-e1350e615080
Received-SPF: none client-ip=194.25.134.83; envelope-from=vr_qemu@t-online.de;
 helo=mailout07.t-online.de
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

Am 14.09.23 um 09:56 schrieb Philippe Mathieu-Daudé:
>
> On 9/9/23 11:48, Mark Cave-Ayland wrote:
>> MacOS (un)helpfully leaves the FIFO engine running even when all the
>> samples have
>> been written to the hardware, and expects the FIFO status flags and
>> IRQ to be
>> updated continuously.
>>
>> There is an additional problem in that not all audio backends
>> guarantee an
>> all-zero output when there is no FIFO data available, in particular
>> the Windows
>> dsound backend which re-uses its internal circular buffer causing the
>> last played
>> sound to loop indefinitely.
>>
>> Whilst this is effectively a bug in the Windows dsound backend, work
>> around it
>> for now using a simple heuristic: if the FIFO remains empty for half
>> a cycle
>> (~23ms) then continuously fill the generated buffer with empty silence.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> ---
>>   hw/audio/asc.c         | 19 +++++++++++++++++++
>>   include/hw/audio/asc.h |  2 ++
>>   2 files changed, 21 insertions(+)
>>
>> diff --git a/hw/audio/asc.c b/hw/audio/asc.c
>> index 336ace0cd6..b01b285512 100644
>> --- a/hw/audio/asc.c
>> +++ b/hw/audio/asc.c
>> @@ -334,6 +334,21 @@ static void asc_out_cb(void *opaque, int free_b)
>>       }
>>         if (!generated) {
>> +        /* Workaround for audio underflow bug on Windows dsound
>> backend */
>> +        int64_t now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
>> +        int silent_samples = muldiv64(now - s->fifo_empty_ns,
>> +                                      NANOSECONDS_PER_SECOND,
>> ASC_FREQ);
>> +
>> +        if (silent_samples > ASC_FIFO_CYCLE_TIME / 2) {
>> +            /*
>> +             * No new FIFO data within half a cycle time (~23ms) so
>> fill the
>> +             * entire available buffer with silence. This prevents
>> an issue
>> +             * with the Windows dsound backend whereby the sound
>> appears to
>> +             * loop because the FIFO has run out of data, and the
>> driver
>> +             * reuses the stale content in its circular audio buffer.
>> +             */
>> +            AUD_write(s->voice, s->silentbuf, samples << s->shift);
>> +        }
>>           return;
>>       }
>
> What about having audio_callback_fn returning a boolean, and using
> a flag in backends for that silence case? Roughtly:
>

Hi Philippe,

I don't think there will be many audio devices that need this feature in
the future. It's probably better to keep the code in hw/audio/asc.c

I plan to change the buffer underflow behavior of the DirectSound
backend after these patches are commited. I already have a patch
available. This doesn't mean this patch is unnecessary after my patch.
It is a mistake when audio devices simply stop writing audio samples
without changing the status of the audio playback stream to deactivated.
At the moment the ASC device can't deactivate the audio stream.

With best regards,
Volker

> -- >8 --
> diff --git a/audio/audio.h b/audio/audio.h
> index 01bdc567fb..4844771c92 100644
> --- a/audio/audio.h
> +++ b/audio/audio.h
> @@ -30,7 +30,7 @@
>  #include "hw/qdev-properties.h"
>  #include "hw/qdev-properties-system.h"
>
> -typedef void (*audio_callback_fn) (void *opaque, int avail);
> +typedef bool (*audio_callback_fn) (void *opaque, int avail);
>
>  #if HOST_BIG_ENDIAN
>  #define AUDIO_HOST_ENDIANNESS 1
> diff --git a/audio/audio.c b/audio/audio.c
> index 90c7c49d11..5b6e69fbd6 100644
> --- a/audio/audio.c
> +++ b/audio/audio.c
> @@ -1178,8 +1178,11 @@ static void audio_run_out (AudioState *s)
>                  if (free > sw->resample_buf.pos) {
>                      free = MIN(free, sw->resample_buf.size)
>                             - sw->resample_buf.pos;
> -                    sw->callback.fn(sw->callback.opaque,
> -                                    free * sw->info.bytes_per_frame);
> +                    if (!sw->callback.fn(sw->callback.opaque,
> +                                         free *
> sw->info.bytes_per_frame)
> +                            && unlikely(hw->silentbuf_required)) {
> +                        /* write silence ... */
> +                    }
>                  }
>              }
>          }
> ---


