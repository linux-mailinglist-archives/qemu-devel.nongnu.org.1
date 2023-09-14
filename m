Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B0937A0554
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 15:17:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgmD5-0001R5-7P; Thu, 14 Sep 2023 09:16:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgmCs-0001Di-Lu
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 09:16:30 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgmCq-00007r-9k
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 09:16:30 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-52c9be5e6f0so1059695a12.1
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 06:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694697385; x=1695302185; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vi+RdWrj91FTr+9PtMRp4SvcchdQmWSydsre43PpMPA=;
 b=wOgstdmVOZ8PEwvavAAyHSPsanSe8KGq9uBLCiVgOXt1TwGfM7cN8H6xGZHjCk4aDt
 30w4FBwD0FHDdzZzkQhOOVivaOyfxm+/0REVxWFgI7ARQBykAbHPpnNKuhz4Y/A2Usix
 PRdu0OPATXbeUkbH5oYwMMNQI22NaBIIafRNx5j2DNyJ8vrvH1v4uVc549mGNRgR5sFc
 mMizjb22n4Yaa+1lNOsuLgYDvn8tL5jrWsvFazZ9DqtpaONMArtgkB5xEjb+BQgvKVBx
 qsJviH4SXIKZ/2H9+wpz1gZthRnoD3DQqWcg603AavY8jHRBTFMcH1k+pbNRJemUTrUG
 tf4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694697385; x=1695302185;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vi+RdWrj91FTr+9PtMRp4SvcchdQmWSydsre43PpMPA=;
 b=dMOCwV2pZ2sN3carqgvAiA8gBOo3EwyeeJLZn3Va6QLeBzfAC3hpG7Q+y+J6dxMszH
 Qx3hOlDETCbKOHgOJ2Lu0+XxJxyMa19aPFiGJfXebsc1lwE8OWm4G0auKtnA0A1/cY+8
 mY0EvtKLyfnGh5zxQ+RkzwCDUKPrOg+wsfmACxIKzfNKcb8kZU9bJd90VtxcTDOMd9JR
 oj2Cz6ReN/BqOJ8BqO3dJWx68HpEnIa8i0unslB3LmLrdE14zZDvYwpS2JFpQp/EK+yD
 JjyFTNXF4Ho9pwqR5aBGQVVssvI9g55E8uk8FOdJi3EUJUVTPutyVbzgi9wRasLTAuHl
 Ihjg==
X-Gm-Message-State: AOJu0YyfCjgdfU+WFKw89qXv2UmWH+sBU7RpSBuKB9uKCTQHM++Gpr+H
 z0f+5wahjxRMTXcNCjUbXTfE7g==
X-Google-Smtp-Source: AGHT+IFTFRLbxUS27lbwHTUbgUvgdbLpaLKVgsrUXmOPY2xB5eBB8wlfexjEVa3oHtiTV2JITiDO4g==
X-Received: by 2002:aa7:da14:0:b0:525:466c:5fda with SMTP id
 r20-20020aa7da14000000b00525466c5fdamr5144185eds.28.1694697385329; 
 Thu, 14 Sep 2023 06:16:25 -0700 (PDT)
Received: from [192.168.69.115] (176-131-223-129.abo.bbox.fr.
 [176.131.223.129]) by smtp.gmail.com with ESMTPSA id
 n10-20020aa7c44a000000b00522572f323dsm914429edr.16.2023.09.14.06.16.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Sep 2023 06:16:24 -0700 (PDT)
Message-ID: <289d323e-2726-c957-4150-fd0595d5213c@linaro.org>
Date: Thu, 14 Sep 2023 15:16:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v2 08/20] asc: generate silence if FIFO empty but engine
 still running
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, laurent@vivier.eu,
 qemu-devel@nongnu.org, =?UTF-8?Q?Volker_R=c3=bcmelin?=
 <vr_qemu@t-online.de>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
References: <20230909094827.33871-1-mark.cave-ayland@ilande.co.uk>
 <20230909094827.33871-9-mark.cave-ayland@ilande.co.uk>
 <25d8059c-422a-3f2a-3f33-7a9848f4b3da@linaro.org>
In-Reply-To: <25d8059c-422a-3f2a-3f33-7a9848f4b3da@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x530.google.com
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

On 14/9/23 09:56, Philippe Mathieu-Daudé wrote:
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
>> for now using a simple heuristic: if the FIFO remains empty for half a 
>> cycle
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
>>       if (!generated) {
>> +        /* Workaround for audio underflow bug on Windows dsound 
>> backend */
>> +        int64_t now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
>> +        int silent_samples = muldiv64(now - s->fifo_empty_ns,
>> +                                      NANOSECONDS_PER_SECOND, ASC_FREQ);
>> +
>> +        if (silent_samples > ASC_FIFO_CYCLE_TIME / 2) {
>> +            /*
>> +             * No new FIFO data within half a cycle time (~23ms) so 
>> fill the
>> +             * entire available buffer with silence. This prevents an 
>> issue
>> +             * with the Windows dsound backend whereby the sound 
>> appears to
>> +             * loop because the FIFO has run out of data, and the driver
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
> -- >8 --
> diff --git a/audio/audio.h b/audio/audio.h
> index 01bdc567fb..4844771c92 100644
> --- a/audio/audio.h
> +++ b/audio/audio.h
> @@ -30,7 +30,7 @@
>   #include "hw/qdev-properties.h"
>   #include "hw/qdev-properties-system.h"
> 
> -typedef void (*audio_callback_fn) (void *opaque, int avail);
> +typedef bool (*audio_callback_fn) (void *opaque, int avail);
> 
>   #if HOST_BIG_ENDIAN
>   #define AUDIO_HOST_ENDIANNESS 1
> diff --git a/audio/audio.c b/audio/audio.c
> index 90c7c49d11..5b6e69fbd6 100644
> --- a/audio/audio.c
> +++ b/audio/audio.c
> @@ -1178,8 +1178,11 @@ static void audio_run_out (AudioState *s)
>                   if (free > sw->resample_buf.pos) {
>                       free = MIN(free, sw->resample_buf.size)
>                              - sw->resample_buf.pos;
> -                    sw->callback.fn(sw->callback.opaque,
> -                                    free * sw->info.bytes_per_frame);
> +                    if (!sw->callback.fn(sw->callback.opaque,
> +                                         free * sw->info.bytes_per_frame)
> +                            && unlikely(hw->silentbuf_required)) {
> +                        /* write silence ... */
> +                    }
>                   }
>               }
>           }
> ---

(Clarifying, not a blocker for this series, just wondering)


