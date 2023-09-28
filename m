Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E33467B26BC
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 22:42:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlxoY-0005e1-Bu; Thu, 28 Sep 2023 16:40:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qlxoW-0005dc-7d
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 16:40:48 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qlxoT-0007DS-Ts
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 16:40:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6W0z4FX/NPCfwu7RnzT/cEy5dDDel5WuZFaamaZgA6E=; b=C+mkBYEBq/LiE4dVHQOvoFxHf/
 zcSQzwdWMIAMXTa/sZRNJ3Mt78c7OC3RKLvAbEQCCvEHWHkIpOEMcnSSuTQAmWVjW3p8rDydPqjWU
 vA/GfuNAVgSLvhh2P3u1GYb4eoWKAYnWY0yizfu7xNO+yTpFxdQiTReF0kXTujZ2Nni93/VqlCbWM
 BfPyfXNLVTlFvX+mSKOO8hmLN8MIuTPDacBJJMw/bhcdHNjQMZ+hIK6C2HcKgAikgcT6I7xPQreSe
 7HGVOZCkjOroax/Zs9uL4BbEE0Edene4CriqAUIk+PtqFYuRul7alU5hsU2aR1rN9DT0rwDMzRJKK
 mNghaKreUWQdQ1WprokX7Eo8S6t8fOkmVIzQNLYSLtACjeEUbqgsoEHHlVeiAi6bRbaMzM88aIwL0
 mo3/openz7RNIXk1OWOTCintaYfUGQYmSv1fQxPauLr7Vk5ntfkr8pSzmvGbOcDdBKiuHymbTHTur
 F/hCS3jRgIiuEAo1Xq1/4iY6NnnHvK57YFHceY1t+nw7wwcPj0qxQ19Ij8d6iQU3e2OgLpccD4U2A
 csL5Y00bywYkq69nePP0D8avtSeA4hvlrRG4/DyfdvTbVK+aWEc423kahmRrjMxy+lpjKClciVI/6
 mZn0LOhD3kGzjpsgPFm2Oxvrq+zgIZ2cs4hUsW3LA=;
Received: from [2a00:23c4:8baf:5f00:89cc:78d2:7179:5c3b]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qlxoF-00078Y-4F; Thu, 28 Sep 2023 21:40:35 +0100
Message-ID: <c2b7feb8-2db0-5144-f0f0-232f96e2724b@ilande.co.uk>
Date: Thu, 28 Sep 2023 21:40:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20230909094827.33871-1-mark.cave-ayland@ilande.co.uk>
 <20230909094827.33871-9-mark.cave-ayland@ilande.co.uk>
 <1e3be6f8-d3a2-dfc2-417a-bfb0b770d707@vivier.eu>
Content-Language: en-US
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
In-Reply-To: <1e3be6f8-d3a2-dfc2-417a-bfb0b770d707@vivier.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8baf:5f00:89cc:78d2:7179:5c3b
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v2 08/20] asc: generate silence if FIFO empty but engine
 still running
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

On 25/09/2023 18:19, Laurent Vivier wrote:

> Le 09/09/2023 à 11:48, Mark Cave-Ayland a écrit :
>> MacOS (un)helpfully leaves the FIFO engine running even when all the samples have
>> been written to the hardware, and expects the FIFO status flags and IRQ to be
>> updated continuously.
>>
>> There is an additional problem in that not all audio backends guarantee an
>> all-zero output when there is no FIFO data available, in particular the Windows
>> dsound backend which re-uses its internal circular buffer causing the last played
>> sound to loop indefinitely.
>>
>> Whilst this is effectively a bug in the Windows dsound backend, work around it
>> for now using a simple heuristic: if the FIFO remains empty for half a cycle
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
>> +        /* Workaround for audio underflow bug on Windows dsound backend */
>> +        int64_t now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
>> +        int silent_samples = muldiv64(now - s->fifo_empty_ns,
>> +                                      NANOSECONDS_PER_SECOND, ASC_FREQ);
>> +
>> +        if (silent_samples > ASC_FIFO_CYCLE_TIME / 2) {
>> +            /*
>> +             * No new FIFO data within half a cycle time (~23ms) so fill the
>> +             * entire available buffer with silence. This prevents an issue
>> +             * with the Windows dsound backend whereby the sound appears to
>> +             * loop because the FIFO has run out of data, and the driver
>> +             * reuses the stale content in its circular audio buffer.
>> +             */
>> +            AUD_write(s->voice, s->silentbuf, samples << s->shift);
>> +        }
>>           return;
>>       }
>> @@ -611,6 +626,7 @@ static void asc_unrealize(DeviceState *dev)
>>       ASCState *s = ASC(dev);
>>       g_free(s->mixbuf);
>> +    g_free(s->silentbuf);
>>       AUD_remove_card(&s->card);
>>   }
>> @@ -633,6 +649,9 @@ static void asc_realize(DeviceState *dev, Error **errp)
>>       s->samples = AUD_get_buffer_size_out(s->voice) >> s->shift;
>>       s->mixbuf = g_malloc0(s->samples << s->shift);
>> +    s->silentbuf = g_malloc0(s->samples << s->shift);
>> +    memset(s->silentbuf, 0x80, s->samples << s->shift);
>> +
>>       /* Add easc registers if required */
>>       if (s->type == ASC_TYPE_EASC) {
>>           memory_region_add_subregion(&s->asc, ASC_EXTREG_OFFSET,
>> diff --git a/include/hw/audio/asc.h b/include/hw/audio/asc.h
>> index d9412815c3..4741f92c46 100644
>> --- a/include/hw/audio/asc.h
>> +++ b/include/hw/audio/asc.h
>> @@ -68,6 +68,8 @@ struct ASCState {
>>       int samples;
>>       int shift;
>> +    uint8_t *silentbuf;
>> +
>>       /* Time when we were last able to generate samples */
>>       int64_t fifo_empty_ns;
> 
> If it's specific to Windows why not using "#if defined(CONFIG_WIN32) && 
> defined(CONFIG_AUDIO_DSOUND)" to clearly identify this piece of code as specific to a 
> windows bug with dsound?

Basically when the FIFO is left running constantly (i.e. the frontend is always 
generating samples regardless of whether there is data), we are relying on undefined 
behaviour when there is underflow in these cases. It just so happens that Windows is 
one of the more popular platforms for Mac emulation and that happens to use a 
circular buffer which is why the audio artifacts exist - but side-effects can 
potentially occur on any audio backend.

> Anyway, code looks good:
> 
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>

Thanks!


ATB,

Mark.


