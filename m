Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D502774CDA1
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 08:51:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIkiu-0004Db-Oh; Mon, 10 Jul 2023 02:50:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qIkir-0004DE-RC
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 02:50:13 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qIkiq-0005ur-1e
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 02:50:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BFvGmypyI5ykBy677fTMqEVPpI7fJ44BNC29wOa8Hso=; b=1prEaeAh3DhanRc/z8H1NKG+gg
 dBGpp0BEo0DBH3PTRTLntaw/KBeDoaJuuleOhbCjHQfAWyTESEezagRvuNkAJwY5ABRzjDayOrPBS
 QxWElXu2l6J3XPkzLo8Xe2PnTBmVkjvTK/IOdQ1eyFsZy7NNltipY5gF/rMrBn2BIA88ZkSkxrdZe
 t4+1FvBZVAh5BQU9V+QAAF3jBI67SeljI6iYUk772Pvk0c6lBljfNL7hVjleTOhGtTCAkjgItfMus
 EGYeZRIYOoCnvVS1KV45akw05lgPbAWFGutnYk8u/w++isZjPlrz0nb8YDH2h8orbxsg52eXEuTJP
 1KQa9cMYX4IvYLsdiY5meVu0CVNXmjD1pz8OJJLLo0LnjSoIhQKq7E76VUaCx/m4PQrREhQBM+gY8
 WAB//EfOYP9J8kz9bjLVVJ/k8rT1e1taWqe+CukbQOAiUO2AkHsNaznsY3E9MRoP7VZdGpvYBGDtj
 j4qDF2im+8cLQOJHOabe07z7YIduDw17+X0fGCAG/9f4uvjx95d2NlIcDVeoPs1YQSfTKq8wM5JMk
 XufSAJqtK3PhPKppl2tNuZJfKSev9YzwgblbgL/E3RK6rlAxoLoH/MtJGAU38ArCNgeJcZY6gMDLv
 rBThHV8aORcQV7xQHikmsibldBawhUbtMpv8RmMU8=;
Received: from [2a00:23c4:8bae:1c00:dfd7:380:3565:1db7]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qIkiT-000BQp-NF; Mon, 10 Jul 2023 07:49:53 +0100
Message-ID: <11ee334f-1a42-3378-0507-7312b4f9ed54@ilande.co.uk>
Date: Mon, 10 Jul 2023 07:50:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: =?UTF-8?Q?Volker_R=c3=bcmelin?= <vr_qemu@t-online.de>, laurent@vivier.eu
Cc: qemu-devel@nongnu.org
References: <20230702154838.722809-1-mark.cave-ayland@ilande.co.uk>
 <20230702154838.722809-9-mark.cave-ayland@ilande.co.uk>
 <a3bfcbd6-733b-169b-6a44-0433ffe34a95@t-online.de>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
In-Reply-To: <a3bfcbd6-733b-169b-6a44-0433ffe34a95@t-online.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bae:1c00:dfd7:380:3565:1db7
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH 08/21] asc: generate silence if FIFO empty but engine
 still running
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 07/07/2023 07:24, Volker Rümelin wrote:

>> MacOS (un)helpfully leaves the FIFO engine running even when all the samples have
>> been written to the hardware, and expects the FIFO status flags and IRQ to be
>> updated continuously.
>>
>> Since not all audio backends guarantee an all-zero output when no data is
>> provided, explicitly generate at least one full output buffer of all-zero output
>> when the FIFO is disabled and continuously if the FIFO is empty. Otherwise some
>> audio backends such as Windows re-use their internal buffers causing the last
>> played sound to loop indefinitely.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> ---
>>   hw/audio/asc.c         | 43 ++++++++++++++++++++++++++++++++----------
>>   include/hw/audio/asc.h |  1 +
>>   2 files changed, 34 insertions(+), 10 deletions(-)
>>
>> diff --git a/hw/audio/asc.c b/hw/audio/asc.c
>> index ebcb8a97a6..f9bfae5168 100644
>> --- a/hw/audio/asc.c
>> +++ b/hw/audio/asc.c
>> @@ -148,6 +148,20 @@ static uint8_t asc_fifo_get(ASCFIFOState *fs)
>>       return val;
>>   }
> 
> Hi Mark,
> 
> I don't understand why the flush_zero_samples variable is necessary at all.
> 
>> +static int generate_silence(ASCState *s, int maxsamples)
>> +{
>> +    uint8_t *buf = s->mixbuf;
>> +
>> +    if (s->flush_zero_samples) {
>> +        memset(buf, 0x80, maxsamples << s->shift);
>> +        s->flush_zero_samples -= MIN(maxsamples, s->flush_zero_samples);
>> +
>> +        return maxsamples;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>>   static int generate_fifo(ASCState *s, int maxsamples)
>>   {
>>       uint8_t *buf = s->mixbuf;
>> @@ -156,18 +170,26 @@ static int generate_fifo(ASCState *s, int maxsamples)
>>       limit = MIN(MAX(s->fifos[0].cnt, s->fifos[1].cnt), maxsamples);
>>       /*
>> -     * If starting a new run with no FIFO data present, update the IRQ and
>> -     * continue
>> +     * MacOS (un)helpfully leaves the FIFO engine running even when it has
>> +     * finished writing out samples. Since not all audio backends guarantee an
>> +     * all-zero output when no data is provided, zero out the sample buffer
>> +     * and then update the FIFO flags and IRQ as normal and continue
>>        */
>> -    if (limit == 0 && s->fifos[0].int_status == 0 &&
>> -            s->fifos[1].int_status == 0) {
>> -        s->fifos[0].int_status |= ASC_FIFO_STATUS_HALF_FULL |
>> -                                  ASC_FIFO_STATUS_FULL_EMPTY;
>> -        s->fifos[1].int_status |= ASC_FIFO_STATUS_HALF_FULL |
>> -                                  ASC_FIFO_STATUS_FULL_EMPTY;
>> +    if (limit == 0) {
>> +        if (s->fifos[0].int_status == 0 && s->fifos[1].int_status == 0) {
>> +            s->fifos[0].int_status |= ASC_FIFO_STATUS_HALF_FULL |
>> +                                      ASC_FIFO_STATUS_FULL_EMPTY;
>> +            s->fifos[1].int_status |= ASC_FIFO_STATUS_HALF_FULL |
>> +                                      ASC_FIFO_STATUS_FULL_EMPTY;
>> +        }
>> +
>> +        if (s->flush_zero_samples == 0) {
>> +            s->flush_zero_samples = s->samples;
>> +        }
> 
> At this point s->flush_zero_samples is != 0 and generate_silence() always generates 
> maxsamples silent audio frames.
> 
>> +        generate_silence(s, maxsamples);
>>           asc_raise_irq(s);
>> -        return 0;
>> +        return maxsamples;
>>       }
>>       while (count < limit) {
>> @@ -309,7 +331,7 @@ static void asc_out_cb(void *opaque, int free_b)
>>       switch (s->regs[ASC_MODE] & 3) {
>>       default:
>>           /* Off */
> 
> This code will not be called for s->regs[ASC_MODE] & 3 == 0 because in asc_write() 
> AUD_set_active_out(s->voice, 0) was called before.
> 
> For s->regs[ASC_MODE] & 3 == 3 the code in asc_write() clears s->flush_zero_samples 
> and generate_silence() always returns 0. The audio subsystem is running and expects 
> new audio frames here.
> 
> With best regards,
> Volker

Ooof indeed, thanks - I've been trying to tweak this logic to improve the results on 
Windows, but clearly missed this obvious flaw. Unfortunately at the moment I have 
visitors until the end of the week and so I don't have much of an opportunity to 
revisit this before next week.

>> -        samples = 0;
>> +        samples = generate_silence(s, samples);
>>           break;
>>       case 1:
>>           /* FIFO mode */
>> @@ -437,6 +459,7 @@ static void asc_write(void *opaque, hwaddr addr, uint64_t value,
>>               asc_lower_irq(s);
>>               if (value != 0) {
>>                   AUD_set_active_out(s->voice, 1);
>> +                s->flush_zero_samples = 0;
>>               } else {
>>                   AUD_set_active_out(s->voice, 0);
>>               }
>> diff --git a/include/hw/audio/asc.h b/include/hw/audio/asc.h
>> index 41c6cba8fa..918f6ac582 100644
>> --- a/include/hw/audio/asc.h
>> +++ b/include/hw/audio/asc.h
>> @@ -65,6 +65,7 @@ struct ASCState {
>>       uint8_t *mixbuf;
>>       int samples;
>>       int shift;
>> +    uint32_t flush_zero_samples;
>>       qemu_irq irq;


ATB,

Mark.


