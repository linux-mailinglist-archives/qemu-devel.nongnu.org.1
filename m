Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FBA47911FC
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 09:22:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd3tE-0006MZ-Kj; Mon, 04 Sep 2023 03:20:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1qd3tA-0006MM-QD
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 03:20:48 -0400
Received: from mailout04.t-online.de ([194.25.134.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1qd3t7-0003VC-HD
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 03:20:48 -0400
Received: from fwd82.aul.t-online.de (fwd82.aul.t-online.de [10.223.144.108])
 by mailout04.t-online.de (Postfix) with SMTP id E6EAE147AF;
 Mon,  4 Sep 2023 09:20:40 +0200 (CEST)
Received: from [192.168.211.200] ([79.208.25.148]) by fwd82.t-online.de
 with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
 esmtp id 1qd3t1-2ubpbd0; Mon, 4 Sep 2023 09:20:40 +0200
Message-ID: <4b115410-9c0e-96aa-2f62-e82b7897ede5@t-online.de>
Date: Mon, 4 Sep 2023 09:20:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v8 00/12] Add VIRTIO sound card
Content-Language: en-US
To: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org
Cc: Igor Skalkin <Igor.Skalkin@opensynergy.com>,
 Anton Yakovlev <Anton.Yakovlev@opensynergy.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?B?S8WRdsOhZ8OzLCBab2x0w6Fu?= <DirtY.iCE.hu@gmail.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
References: <cover.1693252037.git.manos.pitsidianakis@linaro.org>
From: =?UTF-8?Q?Volker_R=c3=bcmelin?= <vr_qemu@t-online.de>
In-Reply-To: <cover.1693252037.git.manos.pitsidianakis@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TOI-EXPURGATEID: 150726::1693812040-2BFE5D37-5857628A/0/0 CLEAN NORMAL
X-TOI-MSGID: 7782946a-6c99-47f4-8b41-a443f0e8ab54
Received-SPF: none client-ip=194.25.134.18; envelope-from=vr_qemu@t-online.de;
 helo=mailout04.t-online.de
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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

Am 28.08.23 um 21:54 schrieb Emmanouil Pitsidianakis:
> This patch series adds an audio device implementing the recent virtio
> sound spec (1.2) and a corresponding PCI wrapper device.

Hi Manos,

I have a few more general comments.

All qemu_log_mask() format strings need a trailing \n.

I still hear a lot of playback dropouts. I had planned to look at the 
playback code, but I didn't have the time until now.

Compared to v6 audio recording has improved but there are bugs. When I 
start QEMU with -audiodev 
pipewire,out.frequency=48000,in.frequency=48000,id=audio0 there are two 
either uninitialized or stale samples every 25ms in the recorded audio 
stream.

To reproduce the issue start audacity on the host and generate a 2s 
square wave tone with 315Hz and an amplitude of 0.8. Use pavucontrol to 
select the monitor of your host playback device as QEMU recording 
device. In the guest start recording with audacity. Start playback of 
the generated square wave on the host. Stop recording in the guest and 
have a look at a 200ms sequence of the recorded square wave and notice 
the wrong samples every 25ms.

When I start QEMU with -audiodev 
pipewire,out.mixing-engine=off,in.mixing-engine=off,id=audio0 audio 
recording starts but the recorded stream immediately stalls.

With best regards,
Volker

> v8 can be found online at:
>
> https://gitlab.com/epilys/qemu/-/tree/virtio-snd-v8
>
> Ref 69eb5f4fbae731f5fc05dea8a5f4b656e0de127f
>
> Main differences with v7 patch series [^v7]
> <cover.1692731646.git.manos.pitsidianakis@linaro.org>:
>
> - Addressed [^v7] review comments.
>    Functions that were called from more than one place for code re-use
>    are not created until they are actually needed.
> - Fixed cases where block->offset was not respected in Playback
>
>


