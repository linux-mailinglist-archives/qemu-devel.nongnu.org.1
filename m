Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD917148C3
	for <lists+qemu-devel@lfdr.de>; Mon, 29 May 2023 13:42:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3bFW-0000gt-9y; Mon, 29 May 2023 07:41:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1q3bFL-0000gZ-Sz
 for qemu-devel@nongnu.org; Mon, 29 May 2023 07:41:09 -0400
Received: from mailout04.t-online.de ([194.25.134.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1q3bFJ-0002Na-56
 for qemu-devel@nongnu.org; Mon, 29 May 2023 07:41:07 -0400
Received: from fwd88.dcpf.telekom.de (fwd88.aul.t-online.de [10.223.144.114])
 by mailout04.t-online.de (Postfix) with SMTP id B828195B;
 Mon, 29 May 2023 13:40:59 +0200 (CEST)
Received: from [192.168.211.200] ([79.208.24.239]) by fwd88.t-online.de
 with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
 esmtp id 1q3bFC-28tIPZ0; Mon, 29 May 2023 13:40:58 +0200
Message-ID: <5d1e4924-b797-c2ca-1dd6-94d12bc4f3ed@t-online.de>
Date: Mon, 29 May 2023 13:40:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 15/30] asc: generate silence if FIFO empty but engine
 still running
Content-Language: de-DE
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, laurent@vivier.eu,
 qemu-devel@nongnu.org
References: <20230524211104.686087-1-mark.cave-ayland@ilande.co.uk>
 <20230524211104.686087-16-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Volker_R=c3=bcmelin?= <vr_qemu@t-online.de>
In-Reply-To: <20230524211104.686087-16-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1685360458-18DBAE62-4CD4C56B/0/0 CLEAN NORMAL
X-TOI-MSGID: 61ab4860-24be-4cd3-a6d8-67a246d7b618
Received-SPF: none client-ip=194.25.134.18; envelope-from=vr_qemu@t-online.de;
 helo=mailout04.t-online.de
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
> provided, explicitly generate an all-zero output when this condition occurs to
> avoid the audio backends re-using their internal buffers and looping audio once
> the FIFOs are empty.
>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/audio/asc.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)

Reviewed-by: Volker Rümelin <vr_qemu@t-online.de>

> diff --git a/hw/audio/asc.c b/hw/audio/asc.c
> index 04194b1e43..c5173a8d35 100644
> --- a/hw/audio/asc.c
> +++ b/hw/audio/asc.c
> @@ -158,8 +158,10 @@ static int generate_fifo(ASCState *s, int maxsamples)
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
>       if (limit == 0 && s->fifos[0].int_status == 0 &&
>               s->fifos[1].int_status == 0) {
> @@ -168,8 +170,9 @@ static int generate_fifo(ASCState *s, int maxsamples)
>           s->fifos[1].int_status |= ASC_FIFO_STATUS_HALF_FULL |
>                                     ASC_FIFO_STATUS_FULL_EMPTY;
>   
> +        memset(buf, 0x80, maxsamples << s->shift);
>           asc_raise_irq(s);
> -        return 0;
> +        return maxsamples;
>       }
>   
>       while (count < limit) {


