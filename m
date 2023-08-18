Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE637805AA
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 07:30:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWs2L-0004sF-Rr; Fri, 18 Aug 2023 01:28:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1qWs2I-0004rt-Gb
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 01:28:38 -0400
Received: from mailout10.t-online.de ([194.25.134.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1qWs2F-0007N8-M4
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 01:28:38 -0400
Received: from fwd79.aul.t-online.de (fwd79.aul.t-online.de [10.223.144.105])
 by mailout10.t-online.de (Postfix) with SMTP id 55CA447A56;
 Fri, 18 Aug 2023 07:28:31 +0200 (CEST)
Received: from [192.168.211.200] ([79.208.21.165]) by fwd79.t-online.de
 with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
 esmtp id 1qWs28-06ltgH0; Fri, 18 Aug 2023 07:28:29 +0200
Message-ID: <cc055b04-0ded-a897-281f-73962cae09f9@t-online.de>
Date: Fri, 18 Aug 2023 07:28:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] HDA codec: Fix wanted_r/w position overflow
To: M_O_Bz@163.com, qemu-devel@nongnu.org
Cc: kraxel@redhat.com, manos.pitsidianakis@linaro.org, linwei6@ruijie.com.cn
References: <20230818032217.31134-1-M_O_Bz@163.com>
Content-Language: en-US
From: =?UTF-8?Q?Volker_R=c3=bcmelin?= <vr_qemu@t-online.de>
In-Reply-To: <20230818032217.31134-1-M_O_Bz@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1692336509-EF7FC2E6-F0E1669D/0/0 CLEAN NORMAL
X-TOI-MSGID: 58adb07c-c7fb-42e4-9334-963bee373cd0
Received-SPF: none client-ip=194.25.134.21; envelope-from=vr_qemu@t-online.de;
 helo=mailout10.t-online.de
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-4.01, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Hi,

> From: zeroway <linwei6@ruijie.com.cn>
>
> when the duration now - buft_start reach to some kind of value,
> which will get the multiply hda_bytes_per_second(st) * (now - buft_start) overflow,
> instead of calculate the wanted_r/wpos from start time to current time,
> here calculate the each timer tick delta data first in wanted_r/wpos_delta,
> and sum it all to wanted_r/wpos to avoid the overflow

you could avoid the multiplication overflow with the following code

#include "qemu/host-utils.h"

     int64_t wanted_rpos = muldiv64(now - buft_start, 
hda_bytes_per_second(st),
                                    NANOSECONDS_PER_SECOND);

and

     int64_t wanted_wpos = muldiv64(now - buft_start, 
hda_bytes_per_second(st),
                                    NANOSECONDS_PER_SECOND);

This would be a less intrusive change. The wanted_pos with your code 
will grow slower than with the original code because you sum up 
truncated results from the division by NANOSECONDS_PER_SECONDS rounded 
down to next multiple of 4.

With best regards,
Volker

>
> Signed-off-by: zeroway <linwei6@ruijie.com.cn>
> ---
>   hw/audio/hda-codec.c | 24 ++++++++++++++++--------
>   1 file changed, 16 insertions(+), 8 deletions(-)
>
> diff --git a/hw/audio/hda-codec.c b/hw/audio/hda-codec.c
> index c51d8ba617..747188221a 100644
> --- a/hw/audio/hda-codec.c
> +++ b/hw/audio/hda-codec.c
> @@ -169,6 +169,8 @@ struct HDAAudioStream {
>       uint8_t buf[8192]; /* size must be power of two */
>       int64_t rpos;
>       int64_t wpos;
> +    int64_t wanted_rpos;
> +    int64_t wanted_wpos;
>       QEMUTimer *buft;
>       int64_t buft_start;
>   };
> @@ -226,16 +228,18 @@ static void hda_audio_input_timer(void *opaque)
>       int64_t wpos = st->wpos;
>       int64_t rpos = st->rpos;
>   
> -    int64_t wanted_rpos = hda_bytes_per_second(st) * (now - buft_start)
> +    int64_t wanted_rpos_delta = hda_bytes_per_second(st) * (now - buft_start)
>                             / NANOSECONDS_PER_SECOND;
> -    wanted_rpos &= -4; /* IMPORTANT! clip to frames */
> +    st->wanted_rpos += wanted_rpos_delta;
> +    st->wanted_rpos &= -4; /* IMPORTANT! clip to frames */
>   
> -    if (wanted_rpos <= rpos) {
> +    st->buft_start = now;
> +    if (st->wanted_rpos <= rpos) {
>           /* we already transmitted the data */
>           goto out_timer;
>       }
>   
> -    int64_t to_transfer = MIN(wpos - rpos, wanted_rpos - rpos);
> +    int64_t to_transfer = MIN(wpos - rpos, st->wanted_rpos - rpos);
>       while (to_transfer) {
>           uint32_t start = (rpos & B_MASK);
>           uint32_t chunk = MIN(B_SIZE - start, to_transfer);
> @@ -290,16 +294,18 @@ static void hda_audio_output_timer(void *opaque)
>       int64_t wpos = st->wpos;
>       int64_t rpos = st->rpos;
>   
> -    int64_t wanted_wpos = hda_bytes_per_second(st) * (now - buft_start)
> +    int64_t wanted_wpos_delta = hda_bytes_per_second(st) * (now - buft_start)
>                             / NANOSECONDS_PER_SECOND;
> -    wanted_wpos &= -4; /* IMPORTANT! clip to frames */
> +    st->wanted_wpos += wanted_wpos_delta;
> +    st->wanted_wpos &= -4; /* IMPORTANT! clip to frames */
>   
> -    if (wanted_wpos <= wpos) {
> +    st->buft_start = now;
> +    if (st->wanted_wpos <= wpos) {
>           /* we already received the data */
>           goto out_timer;
>       }
>   
> -    int64_t to_transfer = MIN(B_SIZE - (wpos - rpos), wanted_wpos - wpos);
> +    int64_t to_transfer = MIN(B_SIZE - (wpos - rpos), st->wanted_wpos - wpos);
>       while (to_transfer) {
>           uint32_t start = (wpos & B_MASK);
>           uint32_t chunk = MIN(B_SIZE - start, to_transfer);
> @@ -420,6 +426,8 @@ static void hda_audio_set_running(HDAAudioStream *st, bool running)
>               int64_t now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
>               st->rpos = 0;
>               st->wpos = 0;
> +            st->wanted_rpos = 0;
> +            st->wanted_wpos = 0;
>               st->buft_start = now;
>               timer_mod_anticipate_ns(st->buft, now + HDA_TIMER_TICKS);
>           } else {


