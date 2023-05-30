Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B232E715D2C
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 13:28:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3xVx-0002yd-9E; Tue, 30 May 2023 07:27:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1q3xVv-0002yT-5C
 for qemu-devel@nongnu.org; Tue, 30 May 2023 07:27:43 -0400
Received: from mout.kundenserver.de ([217.72.192.75])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1q3xVs-0008Rl-6T
 for qemu-devel@nongnu.org; Tue, 30 May 2023 07:27:42 -0400
Received: from [192.168.100.1] ([82.142.8.70]) by mrelayeu.kundenserver.de
 (mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MfZDK-1qanEA0drc-00fyHF; Tue, 30 May 2023 13:27:38 +0200
Message-ID: <681d9b58-d08b-c541-3337-14d50b9c187c@vivier.eu>
Date: Tue, 30 May 2023 13:27:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 15/30] asc: generate silence if FIFO empty but engine
 still running
Content-Language: fr
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
References: <20230524211104.686087-1-mark.cave-ayland@ilande.co.uk>
 <20230524211104.686087-16-mark.cave-ayland@ilande.co.uk>
From: Laurent Vivier <laurent@vivier.eu>
In-Reply-To: <20230524211104.686087-16-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:NWCZsdHhSYBTpdlzeKjR1PuExonxBSK80uUNtdiu3tc4agWqB/M
 xPOKspfBb3wG07wpL3ADoiw0zpLDDi0C63jQttGQR2BORW8KUYoZgjbnPvAVP8GyJZtKVaX
 /0DfahQkNQp6SAzKNg5ovLV8l3OA5xSPVApFKQv8N8sSX7wXz9544fiJ6bUeutrZnovb7XZ
 yyV4Dgz60dvrEHSQw5YRw==
UI-OutboundReport: notjunk:1;M01:P0:ZrHOqETTl8I=;h0+KbTa+U7vUVtF7eB+0phRsTDk
 1P/Vk5qfnTeu4nsYWnhOETbr4hVoC5quSRRri7E4VtLKnUq3bRK/52ku1xL6mFCnII4kxJPyg
 4Qr1vM/Ky6AYDNRour/VPvTVgXtPPpanO92hOgylwv++FYEjPPnxXEVL40RJqJKhIARRcn6jg
 ePLH0r+9Ypo0Ct7dWrnjjRkLwAud2Myc3wpnxMGgQk9md92QkkL1rWq4kIEtC1yVvHUw0+rdr
 bPnItnqblEEBjiVYXDmIMh92k6o/mTSoYrUxisCf6aXYX76qOVvJsRknEPiKq+O8bN2B/dBus
 xFVPVY1FGItfVxquq17MKry2latevCB2onQpkQeokWo3H8zkwzMgYl+XuWLGgRW6CueDkkPdS
 nR/B/L96rDkrko62BJh3bh6zhudJwaNrgauVG807sKoD6lChlkPJdiFJ0JtRIJN3Vk6t3V0Yl
 D0XS7dtFbkXGgl/6cjM0DO5Ev0K7D4stSS3SSIqS4KbOPlrN2H7cUA8b0es4UaqeZJIynyWLO
 M/9JJDEHjmoBjAaUAPEzFz2hHMj1ujEgqQlxN9pVvKYOwUwkJyJxni2KM4vGDYJBfs8CkQNhW
 Qk+UT2IpSK0xcJ7SK8qmfTfVFPFVE6BgQ3ni3t7XBqtye4RPLh6l/6tZTbLTULaud33I18HhZ
 lhDBsbaSAK/NroxxOeMsxA9w0Y608COEnYlZL2s3wg==
Received-SPF: none client-ip=217.72.192.75; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.09,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Le 24/05/2023 à 23:10, Mark Cave-Ayland a écrit :
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
> 
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

Reviewed-by: Laurent Vivier <laurent@vivier.eu>


