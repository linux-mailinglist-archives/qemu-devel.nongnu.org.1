Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0042577DAE3
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 09:06:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWAZx-0006D4-Fu; Wed, 16 Aug 2023 03:04:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1qWAZu-0006Ch-Jh
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 03:04:27 -0400
Received: from mailout06.t-online.de ([194.25.134.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1qWAZr-0003gv-Qk
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 03:04:26 -0400
Received: from fwd83.aul.t-online.de (fwd83.aul.t-online.de [10.223.144.109])
 by mailout06.t-online.de (Postfix) with SMTP id E081B11F87;
 Wed, 16 Aug 2023 09:04:16 +0200 (CEST)
Received: from [192.168.211.200] ([79.208.21.165]) by fwd83.t-online.de
 with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
 esmtp id 1qWAZj-1aOl3h0; Wed, 16 Aug 2023 09:04:15 +0200
Message-ID: <a0f3d6f9-9009-fb1d-d4d5-5830b6f1edcf@t-online.de>
Date: Wed, 16 Aug 2023 09:04:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
From: =?UTF-8?Q?Volker_R=c3=bcmelin?= <vr_qemu@t-online.de>
Subject: Re: hda codec issue
To: M_O_Bz <m_o_bz@163.com>, kraxel@redhat.com, manos.pitsidianakis@linaro.org
Cc: qemu-devel@nongnu.org
References: <4f51bcdb.8572.189f890a97c.Coremail.m_o_bz@163.com>
Content-Language: en-US
In-Reply-To: <4f51bcdb.8572.189f890a97c.Coremail.m_o_bz@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1692169455-EEFF6670-9F408AE2/0/0 CLEAN NORMAL
X-TOI-MSGID: 9325cd99-7e54-4d54-a306-f0c0509dded2
Received-SPF: none client-ip=194.25.134.19; envelope-from=vr_qemu@t-online.de;
 helo=mailout06.t-online.de
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-1.045, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Cc: qemu-devel@nongnu.org

> cc Volker Rümelin
>
> ==========================================
>
> so I was curious about:
> 1. why using wpos, rpos which will increasing along the time, which 
> may overflow in the feature time?

wpos and rpos are 64 bit integers. At a sample rate of 96kHz and with 32 
bit stereo audio frames they overflow after 2^63 bytes / (8 bytes/frame 
* 96000 frames/s) = 1.2E13 s = 380561.23 years. I don't think you will 
notice an overflow.

But you're right anyway. The wanted_rpos and wanted_wpos calculation 
overflows quite early. At a sample rate of 44100kHz and with 16 bit 
stereo samples the multiplication hda_bytes_per_second(st) * (now - 
buft_start) overflows after 2^63 bytes / 176400 bytes/ns = 5,23E13 ns = 
14.58 hours.

I don't think your fix below is correct. There are certainly ways to 
prevent the overflow without resetting the buffer.

> 2. how to fix the wanted_wpos or wanted_rpos, I current don't 
> understand the  wanted_pos mean and how it work to optimize the codec

This is a jitter-buffer implementation to decouple the audio backend 
updates from the hda device updates. The code splits large  >10ms sized 
audio packets into 1ms sized audio packets.

With best regards,
Volker

> =======================================================================================================
>
> Currently  I got Playback and Capture issue
>
> I test Playing and recoding for a very long time, Playback issue is 
> hard to reproduce, Capture issue is easy to reproduce for recording 
> about 14 hours
>
> Playback issue current can only be found on qemu 2.11, which I found 
> the code below (remove some unnecessary)
>
> wanted_wpos overflow, and is always little then the wpos,(current wpos 
> - rpos = 0) so qemu will no long get data from vm, as a result
>
> static void hda_audio_output_timer(void *opaque)
> {
> .............
>
>     int64_t wanted_wpos = hda_bytes_per_second(st) * (now - 
> buft_start) ============> overflow here
>                           / NANOSECONDS_PER_SECOND;
>     wanted_wpos &= -4; /* IMPORTANT! clip to frames */
>
>     if (wanted_wpos <= wpos) {
>         /* we already received the data */
>         goto out_timer;
>     }
> }
>
>
> Capture issue: Just record all the time
> (i using qemu 6.0 to test) I add code below to the input callback 
> function like below, the issue dispear
> hda_audio_input_cb
>     if (wpos - rpos == B_SIZE) {
>         /* drop buffer, reset timer adjust */
>         st->rpos = 0;
>         st->wpos = 0;
>         st->buft_start = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
>         error_report("input drop buffer, reset timer adjust\n");
>         return;
>     }
>
>
>
>
>
>


