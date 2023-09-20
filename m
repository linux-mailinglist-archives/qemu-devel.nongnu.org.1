Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D127A889F
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 17:41:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qizIp-0002gM-TZ; Wed, 20 Sep 2023 11:39:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qizIn-0002g7-8v
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 11:39:45 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qizIl-0006DX-KN
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 11:39:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rZZzNl7HwOSwGjXrxfgiP4H/n6w8+5+7ZX3jH7+Qo2Q=; b=vOOEVOx+64aCWOPmR8VvTU0nm0
 1arfLmC47KeAU64Bokf+uQsX1U3RsV/CwgeLMbgD3hXZU5qphedCcg2aCzDcUoiQDBkp9puHMEfPk
 Xj3RMPWQJL4DNAgzjON/PqUvjW6k1jdKUS6bkqTbFOajDAMEy3StZMEqKUkNSScjW8FteR1VKykpx
 dKBQOGAkROKIxANSZAmUwbwVXXzK/qkgnj40ZUKvBEs1iN7EUqe8MA9218D7d3fCijS7SxrV/Xtlt
 fGo9MDntKQ2va9AqmHEY+oftW+0RII3CHwXC+6/h+kYv67RgPAGV52NhVc9vjQbsisMplM+LXDlsa
 pUGlQ76qbJmtRWq6yba6uFfe4q57KDtSszeKN5FpIUeF9Pp+qtCxv9MhVjksOt4eYQGvRd9iLyJSh
 7cHuE9/YLO0kFqOOcAV8YbeEj1X0kdW09nkJ0y41PHv287xr1OSOJSbm3b6Lsmtd6GZQmo2y+fRnX
 zt6lLaOHkHfDz0T51qDHC4vl9zGP9UoXc4CNAxml2jihhNSCN+adJLS50KkHyw8qX7L8OyVZxLrYj
 NQA5Sq+5fHZa2mspNe6TlBAe3pkuAtFLQi08kWiJyDoCWt4cazB33MC02J3YzPrKlVAiglaHWtZEF
 Ts0P4l1VTTmUkjYGrdWaft127QuTxsKQD6yPOyp3k=;
Received: from [2a00:23c4:8baf:5f00:4f7d:f5b:6c8a:d0af]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qizIZ-0004m1-Df; Wed, 20 Sep 2023 16:39:35 +0100
Message-ID: <f3e9aa48-d450-c11d-9639-a7a852719a64@ilande.co.uk>
Date: Wed, 20 Sep 2023 16:39:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
To: =?UTF-8?Q?Volker_R=c3=bcmelin?= <vr_qemu@t-online.de>, laurent@vivier.eu
Cc: qemu-devel@nongnu.org
References: <20230909094827.33871-1-mark.cave-ayland@ilande.co.uk>
 <20230909094827.33871-8-mark.cave-ayland@ilande.co.uk>
 <373b3abd-a726-e795-eaee-0389a25c662f@t-online.de>
Content-Language: en-US
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
In-Reply-To: <373b3abd-a726-e795-eaee-0389a25c662f@t-online.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8baf:5f00:4f7d:f5b:6c8a:d0af
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v2 07/20] audio: add Apple Sound Chip (ASC) emulation
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 14/09/2023 08:06, Volker Rümelin wrote:

> Am 09.09.23 um 11:48 schrieb Mark Cave-Ayland:
>> The Apple Sound Chip was primarily used by the Macintosh II to generate sound
>> in hardware which was previously handled by the toolbox ROM with software
>> interrupts.
>>
>> Implement both the standard ASC and also the enhanced ASC (EASC) functionality
>> which is used in the Quadra 800.
>>
>> Note that whilst real ASC hardware uses AUDIO_FORMAT_S8, this implementation uses
>> AUDIO_FORMAT_U8 instead because AUDIO_FORMAT_S8 is rarely used and not supported
>> by some audio backends like PulseAudio and DirectSound when played directly with
>> -audiodev out.mixing-engine=off.
>>
>> Co-developed-by: Laurent Vivier <laurent@vivier.eu>
>> Co-developed-by: Volker Rümelin <vr_qemu@t-online.de>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> ---
>>   MAINTAINERS            |   2 +
>>   hw/audio/Kconfig       |   3 +
>>   hw/audio/asc.c         | 699 +++++++++++++++++++++++++++++++++++++++++
>>   hw/audio/meson.build   |   1 +
>>   hw/audio/trace-events  |  10 +
>>   hw/m68k/Kconfig        |   1 +
>>   include/hw/audio/asc.h |  84 +++++
>>   7 files changed, 800 insertions(+)
>>   create mode 100644 hw/audio/asc.c
>>   create mode 100644 include/hw/audio/asc.h
> 
> Hi Mark,
> 
> the function generate_fifo() has four issues. Only the first one
> is noticeable.
> 
> 1. The calculation of the variable limit assumes generate_fifo()
> generates one output sample from every input byte. This is correct
> for the raw mode, but not for the CD-XA BRR mode. This mode
> generates 28 output samples from 15 input bytes. This is the
> reason for the stuttering end of a CD-XA BRR mode sound. Every
> generate_fifo() call generates approximately only half of the
> possible samples when the fifo bytes are running low.
> 
> 2. generate_fifo() doesn't generate the last output sample from
> a CD-XA BRR mode sound. The last sample is generated from internal
> state and the code will not be called without at least one byte
> in the fifo.
> 
> 3. It's not necessary to wait for a complete 15 byte packet in
> CD-XA BRR mode. Audio playback devices should write all
> requested samples immediately if possible.
> 
> 4. The saturation function in CD-XA BRR mode works with 16 bit
> integers. It should saturate at +32767 and -32768.
> 
> Since I think a few lines of code explain the issues better
> than my words, I've attached a patch below.
> 
> With best regards,
> Volker

Hi Volker,

Thanks for detailed explanation above - everything makes sense based upon previous 
discussions. My only question is in comment 3 where you say "Audio playback devices 
should write all requested samples immediately if possible": can you clarify does 
this mean that the supplied length to the audio callback represents a *required* 
rather than a *maximum* number of samples?

Regardless of this I've had some time to test on Windows this afternoon, and I can 
confirm that your changes fix the outstanding audio issues. I've squashed your 
changes locally and I'll included them in the next revision of the series, although 
I'll likely wait a bit first to see if any more reviews are forthcoming.


Many thanks,

Mark.


