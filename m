Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B343E7A35B9
	for <lists+qemu-devel@lfdr.de>; Sun, 17 Sep 2023 15:43:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhs2a-0008No-U1; Sun, 17 Sep 2023 09:42:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qhs2Z-0008NS-CI
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 09:42:23 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qhs2X-0008Ev-P3
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 09:42:23 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-31f7638be6eso3473241f8f.3
 for <qemu-devel@nongnu.org>; Sun, 17 Sep 2023 06:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694958139; x=1695562939; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qFhEb8YapB6rTDJ2IWMFilHEZHv7zgHl6oyFlcFSeTk=;
 b=Lh7WVpDFrKHaq3Cg1HquI6zZfvLRdmkcb4V1IF3PUKadi8Y64en38mS02tAiNfLbJG
 Gtd8zslHYGp8rmnu/JqOC0CTiq4UOX/xZawYPFsbFTnZDZ/amDqQVfyaBGM1aszE/oDy
 e7unvRAyJraLM22O4EndERke3VwB2SkRwfS9LqjtQtbE8aJnX9mJHxUKlUN1mMFEE5tF
 j1PaZTMUYkF8k4EVyR3yHU3Lvm4YdrgKZQTA2Th67bPsup+XZQAMWSRx/rHijFF6ji/+
 kSNWpmWCD7IlYpTPHga4l7L3BWydxY1YSoJ7mpqfxH6nUbHbsiAGNXRZknEPhcfb0y1M
 2UmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694958139; x=1695562939;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qFhEb8YapB6rTDJ2IWMFilHEZHv7zgHl6oyFlcFSeTk=;
 b=PkZ6EVNd7PHxPHyFhmkaXhFjQdufjDgQvUMnVII2CtRfJxqsQji9Pvp8G1ieJYUMpV
 eXO092jGTjiulmpM7vCJ0SYNeWImswB/JJfcuS7VXOqp6mozMAl1qtEwrKgKzPEMXvwk
 onIAj7R5sT9g4Z9vtG+iaRE8wEZTSx6o/X3gWjRRQwDReENuFEL35mpLtp8/8zrjrtnH
 lOHcn+JWdGaZTjL3yVhbVnOGEH7/zhgNngQaeFy3RgM7Acaow8z4KJ1nwHjD3xuAHGN4
 ZK4Uc8NR4ezqhDYMkxXGnei7UDB0QPwFlAWCrVEtVTmvU6mMbLoePxbcbJGC9eRZNlN0
 +sYQ==
X-Gm-Message-State: AOJu0YyvISs79TQTMEVBhAQWjiawY0lr8RH04bvRqUVrsjPIEj/uSQa8
 Fdcs24nDe0lpSdu9ARqVa4I5sA==
X-Google-Smtp-Source: AGHT+IF1AvExKZCeUy2ZtrfMjr0GHFd2fyxci/0vDDkLOzx1+h/yO2i20h3/C7aa6XHaQ1hZLopQUQ==
X-Received: by 2002:adf:f742:0:b0:319:6e3f:d5f0 with SMTP id
 z2-20020adff742000000b003196e3fd5f0mr5005042wrp.44.1694958139590; 
 Sun, 17 Sep 2023 06:42:19 -0700 (PDT)
Received: from [192.168.69.115] (ric62-h01-176-170-218-28.dsl.sta.abo.bbox.fr.
 [176.170.218.28]) by smtp.gmail.com with ESMTPSA id
 l12-20020a5d674c000000b0030ae53550f5sm9692961wrw.51.2023.09.17.06.42.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 17 Sep 2023 06:42:19 -0700 (PDT)
Message-ID: <07f1473f-d308-aa8d-ca04-6f2d45e53686@linaro.org>
Date: Sun, 17 Sep 2023 15:42:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v2 08/20] asc: generate silence if FIFO empty but engine
 still running
Content-Language: en-US
To: =?UTF-8?Q?Volker_R=c3=bcmelin?= <vr_qemu@t-online.de>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, laurent@vivier.eu,
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
References: <20230909094827.33871-1-mark.cave-ayland@ilande.co.uk>
 <20230909094827.33871-9-mark.cave-ayland@ilande.co.uk>
 <25d8059c-422a-3f2a-3f33-7a9848f4b3da@linaro.org>
 <1ffc1fab-94ef-445f-9df3-a029bf9e68ef@t-online.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <1ffc1fab-94ef-445f-9df3-a029bf9e68ef@t-online.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

On 16/9/23 10:19, Volker Rümelin wrote:
> Am 14.09.23 um 09:56 schrieb Philippe Mathieu-Daudé:
>>
>> On 9/9/23 11:48, Mark Cave-Ayland wrote:
>>> MacOS (un)helpfully leaves the FIFO engine running even when all the
>>> samples have
>>> been written to the hardware, and expects the FIFO status flags and
>>> IRQ to be
>>> updated continuously.
>>>
>>> There is an additional problem in that not all audio backends
>>> guarantee an
>>> all-zero output when there is no FIFO data available, in particular
>>> the Windows
>>> dsound backend which re-uses its internal circular buffer causing the
>>> last played
>>> sound to loop indefinitely.
>>>
>>> Whilst this is effectively a bug in the Windows dsound backend, work
>>> around it
>>> for now using a simple heuristic: if the FIFO remains empty for half
>>> a cycle
>>> (~23ms) then continuously fill the generated buffer with empty silence.
>>>
>>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>> ---
>>>    hw/audio/asc.c         | 19 +++++++++++++++++++
>>>    include/hw/audio/asc.h |  2 ++
>>>    2 files changed, 21 insertions(+)
>>>
>>> diff --git a/hw/audio/asc.c b/hw/audio/asc.c
>>> index 336ace0cd6..b01b285512 100644
>>> --- a/hw/audio/asc.c
>>> +++ b/hw/audio/asc.c
>>> @@ -334,6 +334,21 @@ static void asc_out_cb(void *opaque, int free_b)
>>>        }
>>>          if (!generated) {
>>> +        /* Workaround for audio underflow bug on Windows dsound
>>> backend */
>>> +        int64_t now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
>>> +        int silent_samples = muldiv64(now - s->fifo_empty_ns,
>>> +                                      NANOSECONDS_PER_SECOND,
>>> ASC_FREQ);
>>> +
>>> +        if (silent_samples > ASC_FIFO_CYCLE_TIME / 2) {
>>> +            /*
>>> +             * No new FIFO data within half a cycle time (~23ms) so
>>> fill the
>>> +             * entire available buffer with silence. This prevents
>>> an issue
>>> +             * with the Windows dsound backend whereby the sound
>>> appears to
>>> +             * loop because the FIFO has run out of data, and the
>>> driver
>>> +             * reuses the stale content in its circular audio buffer.
>>> +             */
>>> +            AUD_write(s->voice, s->silentbuf, samples << s->shift);
>>> +        }
>>>            return;
>>>        }
>>
>> What about having audio_callback_fn returning a boolean, and using
>> a flag in backends for that silence case? Roughtly:
>>
> 
> Hi Philippe,
> 
> I don't think there will be many audio devices that need this feature in
> the future. It's probably better to keep the code in hw/audio/asc.c
> 
> I plan to change the buffer underflow behavior of the DirectSound
> backend after these patches are commited. I already have a patch
> available. This doesn't mean this patch is unnecessary after my patch.
> It is a mistake when audio devices simply stop writing audio samples
> without changing the status of the audio playback stream to deactivated.
> At the moment the ASC device can't deactivate the audio stream.

OK, thanks for clarifying.


