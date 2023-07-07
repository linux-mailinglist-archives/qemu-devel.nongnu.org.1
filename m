Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1122E74AB12
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 08:25:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHetT-00026j-Uw; Fri, 07 Jul 2023 02:24:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1qHetR-00026a-IJ
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 02:24:37 -0400
Received: from mailout08.t-online.de ([194.25.134.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1qHetP-0007Z5-Cc
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 02:24:37 -0400
Received: from fwd86.dcpf.telekom.de (fwd86.aul.t-online.de [10.223.144.112])
 by mailout08.t-online.de (Postfix) with SMTP id 3A6C62A4F;
 Fri,  7 Jul 2023 08:24:31 +0200 (CEST)
Received: from [192.168.211.200] ([93.236.151.121]) by fwd86.t-online.de
 with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
 esmtp id 1qHetK-0GbX6n0; Fri, 7 Jul 2023 08:24:30 +0200
Message-ID: <a3bfcbd6-733b-169b-6a44-0433ffe34a95@t-online.de>
Date: Fri, 7 Jul 2023 08:24:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 08/21] asc: generate silence if FIFO empty but engine
 still running
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, laurent@vivier.eu
References: <20230702154838.722809-1-mark.cave-ayland@ilande.co.uk>
 <20230702154838.722809-9-mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org
From: =?UTF-8?Q?Volker_R=c3=bcmelin?= <vr_qemu@t-online.de>
In-Reply-To: <20230702154838.722809-9-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TOI-EXPURGATEID: 150726::1688711070-0492CEBC-7B5DF9E5/0/0 CLEAN NORMAL
X-TOI-MSGID: e284596e-00dd-47da-a416-3449c74cc7ae
Received-SPF: none client-ip=194.25.134.20; envelope-from=vr_qemu@t-online.de;
 helo=mailout08.t-online.de
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

> MacOS (un)helpfully leaves the FIFO engine running even when all the samples have
> been written to the hardware, and expects the FIFO status flags and IRQ to be
> updated continuously.
>
> Since not all audio backends guarantee an all-zero output when no data is
> provided, explicitly generate at least one full output buffer of all-zero output
> when the FIFO is disabled and continuously if the FIFO is empty. Otherwise some
> audio backends such as Windows re-use their internal buffers causing the last
> played sound to loop indefinitely.
>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/audio/asc.c         | 43 ++++++++++++++++++++++++++++++++----------
>   include/hw/audio/asc.h |  1 +
>   2 files changed, 34 insertions(+), 10 deletions(-)
>
> diff --git a/hw/audio/asc.c b/hw/audio/asc.c
> index ebcb8a97a6..f9bfae5168 100644
> --- a/hw/audio/asc.c
> +++ b/hw/audio/asc.c
> @@ -148,6 +148,20 @@ static uint8_t asc_fifo_get(ASCFIFOState *fs)
>       return val;
>   }

Hi Mark,

I don't understand why the flush_zero_samples variable is necessary at all.

>   
> +static int generate_silence(ASCState *s, int maxsamples)
> +{
> +    uint8_t *buf = s->mixbuf;
> +
> +    if (s->flush_zero_samples) {
> +        memset(buf, 0x80, maxsamples << s->shift);
> +        s->flush_zero_samples -= MIN(maxsamples, s->flush_zero_samples);
> +
> +        return maxsamples;
> +    }
> +
> +    return 0;
> +}
> +
>   static int generate_fifo(ASCState *s, int maxsamples)
>   {
>       uint8_t *buf = s->mixbuf;
> @@ -156,18 +170,26 @@ static int generate_fifo(ASCState *s, int maxsamples)
>       limit = MIN(MAX(s->fifos[0].cnt, s->fifos[1].cnt), maxsamples);
>   
>       /*
> -     * If starting a new run with no FIFO data present, update the IRQ and
> -     * continue
> +     * MacOS (un)helpfully leaves the FIFO engine running even when it has
> +     * finished writing out samples. Since not all audio backends guarantee an
> +     * all-zero output when no data is provided, zero out the sample buffer
> +     * and then update the FIFO flags and IRQ as normal and continue
>        */
> -    if (limit == 0 && s->fifos[0].int_status == 0 &&
> -            s->fifos[1].int_status == 0) {
> -        s->fifos[0].int_status |= ASC_FIFO_STATUS_HALF_FULL |
> -                                  ASC_FIFO_STATUS_FULL_EMPTY;
> -        s->fifos[1].int_status |= ASC_FIFO_STATUS_HALF_FULL |
> -                                  ASC_FIFO_STATUS_FULL_EMPTY;
> +    if (limit == 0) {
> +        if (s->fifos[0].int_status == 0 && s->fifos[1].int_status == 0) {
> +            s->fifos[0].int_status |= ASC_FIFO_STATUS_HALF_FULL |
> +                                      ASC_FIFO_STATUS_FULL_EMPTY;
> +            s->fifos[1].int_status |= ASC_FIFO_STATUS_HALF_FULL |
> +                                      ASC_FIFO_STATUS_FULL_EMPTY;
> +        }
> +
> +        if (s->flush_zero_samples == 0) {
> +            s->flush_zero_samples = s->samples;
> +        }

At this point s->flush_zero_samples is != 0 and generate_silence() 
always generates maxsamples silent audio frames.

>   
> +        generate_silence(s, maxsamples);
>           asc_raise_irq(s);
> -        return 0;
> +        return maxsamples;
>       }
>   
>       while (count < limit) {
> @@ -309,7 +331,7 @@ static void asc_out_cb(void *opaque, int free_b)
>       switch (s->regs[ASC_MODE] & 3) {
>       default:
>           /* Off */

This code will not be called for s->regs[ASC_MODE] & 3 == 0 because in 
asc_write() AUD_set_active_out(s->voice, 0) was called before.

For s->regs[ASC_MODE] & 3 == 3 the code in asc_write() clears 
s->flush_zero_samples and generate_silence() always returns 0. The audio 
subsystem is running and expects new audio frames here.

With best regards,
Volker

> -        samples = 0;
> +        samples = generate_silence(s, samples);
>           break;
>       case 1:
>           /* FIFO mode */
> @@ -437,6 +459,7 @@ static void asc_write(void *opaque, hwaddr addr, uint64_t value,
>               asc_lower_irq(s);
>               if (value != 0) {
>                   AUD_set_active_out(s->voice, 1);
> +                s->flush_zero_samples = 0;
>               } else {
>                   AUD_set_active_out(s->voice, 0);
>               }
> diff --git a/include/hw/audio/asc.h b/include/hw/audio/asc.h
> index 41c6cba8fa..918f6ac582 100644
> --- a/include/hw/audio/asc.h
> +++ b/include/hw/audio/asc.h
> @@ -65,6 +65,7 @@ struct ASCState {
>       uint8_t *mixbuf;
>       int samples;
>       int shift;
> +    uint32_t flush_zero_samples;
>   
>       qemu_irq irq;
>   


