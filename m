Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1CA7ADDC1
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 19:20:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkpFr-0002b8-I3; Mon, 25 Sep 2023 13:20:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qkpFb-0002Y3-VJ
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 13:20:04 -0400
Received: from mout.kundenserver.de ([212.227.126.187])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qkpFY-0003qA-5d
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 13:20:02 -0400
Received: from [192.168.100.1] ([82.142.8.70]) by mrelayeu.kundenserver.de
 (mreue012 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MIKs0-1qqNg20rp6-00EPYp; Mon, 25 Sep 2023 19:19:58 +0200
Message-ID: <1e3be6f8-d3a2-dfc2-417a-bfb0b770d707@vivier.eu>
Date: Mon, 25 Sep 2023 19:19:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: fr
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
References: <20230909094827.33871-1-mark.cave-ayland@ilande.co.uk>
 <20230909094827.33871-9-mark.cave-ayland@ilande.co.uk>
From: Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PATCH v2 08/20] asc: generate silence if FIFO empty but engine
 still running
In-Reply-To: <20230909094827.33871-9-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:BMwqT9xhbP1sf3/kzrjgvAEdEYibe2biTEsCDq/JG4EmxfGoKLR
 M/PHcLfeCxUe5FBxtGGKSHCe9TLYWnBxp5s0tNw9Nu+CsaHqkoZhUysPO5c2mbnlod4fEjd
 /p+rjlWggFriqu93XjcW1cAQslinb4C16E6hMm8Jqk+4mqIH0MwubzwPTOYqr6pxLaNflI5
 +qUAe0f1B0rOTcd6R50pA==
UI-OutboundReport: notjunk:1;M01:P0:BTUN1mdyBhI=;2VgV42kxt4A3uG1B+UYLglnYHVE
 WfAwYWarNq1+zgzf8lB/mtFj3RYE+iN/wMiHYqHgUFbbK4uuxpKpaT/DO/DP18Aut0f0GB3s6
 m0Q2F/NmWFE5izEGGsVAa8RGZPtpZcQB/iojdTSiI87wIfgcnIE5XY0L/MWollGUA7/HqKu/g
 DeENOxEXMtXRbfNjg/Ex7oyTCcmmzQIhlA8XgA9tqJbEVWIsRpRaimv62QYcH/ivZPOcC+GSR
 Ohj1mWYc9MInbPMsXB1fblpH4iL5lSmopejkA9moSpE6wfXEIotCg37YHRZ7naIj7y53kHcee
 bt9RwbltQgoMMJq6YZxa9txCH7sIsfllP9wKjvSjGGgcn/Rt09uImcGNgaaik4FGhcedzUbj0
 Zoi3X1SLYQQcJng6QoKwxDP8bfgUsxeMNZmbVEc6bJ+SidPxMHkJJ6C7Jsyq1Bo3iNytnYKQ+
 AmWTNpX/cAOV3YTgdkoSY1xCSXtYixOMJPlCsZB0FViHO9r6ilGiMzfOgeGZeh1nBPaqb9BnB
 V0BxoZWIk6Hly56lmNbAOS43LI7BTl/+SGbokNohPhbciHEK5h49f7NyBcANm9ZinBs7Pm5zq
 LCMY8lh4WwRYFYXgk2b+KHuLa89EwoDhoCxAAJC4hYVHSr1Ithy1uwsh3AD0NG6eNUXGpDoGg
 b7voWLZxH1KLwpiQ5OawYRzG1aVlBssDI3uWbxLhQDe8NaAA0zyE0Rsp3u6VWlyHMei6QWd/q
 QF3vpT33QYp0HT1umKKkgE/265+4EjI3bBLHPMaFuD5ZosqvJNwXnqDFydQvi7PfZI/aCmhCq
 BPTda6OUPLqJK0kfKvqAjvHPJi2UUKoiK19/Zl4jQQCqBysQ2RfA2YxWs51lm13nXlB4OYzZi
 ETlGVlLgxunM/Ow==
Received-SPF: none client-ip=212.227.126.187; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.473,
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

Le 09/09/2023 à 11:48, Mark Cave-Ayland a écrit :
> MacOS (un)helpfully leaves the FIFO engine running even when all the samples have
> been written to the hardware, and expects the FIFO status flags and IRQ to be
> updated continuously.
> 
> There is an additional problem in that not all audio backends guarantee an
> all-zero output when there is no FIFO data available, in particular the Windows
> dsound backend which re-uses its internal circular buffer causing the last played
> sound to loop indefinitely.
> 
> Whilst this is effectively a bug in the Windows dsound backend, work around it
> for now using a simple heuristic: if the FIFO remains empty for half a cycle
> (~23ms) then continuously fill the generated buffer with empty silence.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/audio/asc.c         | 19 +++++++++++++++++++
>   include/hw/audio/asc.h |  2 ++
>   2 files changed, 21 insertions(+)
> 
> diff --git a/hw/audio/asc.c b/hw/audio/asc.c
> index 336ace0cd6..b01b285512 100644
> --- a/hw/audio/asc.c
> +++ b/hw/audio/asc.c
> @@ -334,6 +334,21 @@ static void asc_out_cb(void *opaque, int free_b)
>       }
>   
>       if (!generated) {
> +        /* Workaround for audio underflow bug on Windows dsound backend */
> +        int64_t now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> +        int silent_samples = muldiv64(now - s->fifo_empty_ns,
> +                                      NANOSECONDS_PER_SECOND, ASC_FREQ);
> +
> +        if (silent_samples > ASC_FIFO_CYCLE_TIME / 2) {
> +            /*
> +             * No new FIFO data within half a cycle time (~23ms) so fill the
> +             * entire available buffer with silence. This prevents an issue
> +             * with the Windows dsound backend whereby the sound appears to
> +             * loop because the FIFO has run out of data, and the driver
> +             * reuses the stale content in its circular audio buffer.
> +             */
> +            AUD_write(s->voice, s->silentbuf, samples << s->shift);
> +        }
>           return;
>       }
>   
> @@ -611,6 +626,7 @@ static void asc_unrealize(DeviceState *dev)
>       ASCState *s = ASC(dev);
>   
>       g_free(s->mixbuf);
> +    g_free(s->silentbuf);
>   
>       AUD_remove_card(&s->card);
>   }
> @@ -633,6 +649,9 @@ static void asc_realize(DeviceState *dev, Error **errp)
>       s->samples = AUD_get_buffer_size_out(s->voice) >> s->shift;
>       s->mixbuf = g_malloc0(s->samples << s->shift);
>   
> +    s->silentbuf = g_malloc0(s->samples << s->shift);
> +    memset(s->silentbuf, 0x80, s->samples << s->shift);
> +
>       /* Add easc registers if required */
>       if (s->type == ASC_TYPE_EASC) {
>           memory_region_add_subregion(&s->asc, ASC_EXTREG_OFFSET,
> diff --git a/include/hw/audio/asc.h b/include/hw/audio/asc.h
> index d9412815c3..4741f92c46 100644
> --- a/include/hw/audio/asc.h
> +++ b/include/hw/audio/asc.h
> @@ -68,6 +68,8 @@ struct ASCState {
>       int samples;
>       int shift;
>   
> +    uint8_t *silentbuf;
> +
>       /* Time when we were last able to generate samples */
>       int64_t fifo_empty_ns;
>   

If it's specific to Windows why not using "#if defined(CONFIG_WIN32) && 
defined(CONFIG_AUDIO_DSOUND)" to clearly identify this piece of code as specific to a windows bug 
with dsound?

Anyway, code looks good:

Reviewed-by: Laurent Vivier <laurent@vivier.eu>


