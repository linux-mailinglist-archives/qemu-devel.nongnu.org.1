Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F214C79209F
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 08:58:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdPzk-00087t-9R; Tue, 05 Sep 2023 02:57:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1qdPzh-00086p-FT
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 02:57:01 -0400
Received: from mailout05.t-online.de ([194.25.134.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1qdPze-0005yQ-QO
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 02:57:01 -0400
Received: from fwd77.aul.t-online.de (fwd77.aul.t-online.de [10.223.144.103])
 by mailout05.t-online.de (Postfix) with SMTP id AD7B1484D;
 Tue,  5 Sep 2023 08:56:53 +0200 (CEST)
Received: from [192.168.211.200] ([79.208.25.148]) by fwd77.t-online.de
 with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
 esmtp id 1qdPzU-2lIdwv0; Tue, 5 Sep 2023 08:56:48 +0200
Message-ID: <217d86c3-fb74-6bae-8394-927da0d9ef0e@t-online.de>
Date: Tue, 5 Sep 2023 08:56:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v8 00/12] Add VIRTIO sound card
Content-Language: en-US
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
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
 <4b115410-9c0e-96aa-2f62-e82b7897ede5@t-online.de>
 <0ghxq.3r60jgujq0t@linaro.org>
From: =?UTF-8?Q?Volker_R=c3=bcmelin?= <vr_qemu@t-online.de>
In-Reply-To: <0ghxq.3r60jgujq0t@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1693897008-1281C931-43A80420/0/0 CLEAN NORMAL
X-TOI-MSGID: 487fd9ef-75c3-47a3-97da-228b9be6ec77
Received-SPF: none client-ip=194.25.134.82; envelope-from=vr_qemu@t-online.de;
 helo=mailout05.t-online.de
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001,
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

Am 04.09.23 um 12:01 schrieb Manos Pitsidianakis:
> Hello Volker :)
>
> On Mon, 04 Sep 2023 10:20, Volker Rümelin <vr_qemu@t-online.de> wrote:
>> All qemu_log_mask() format strings need a trailing \n.
>
> Thank you, will fix it!
>
>> I still hear a lot of playback dropouts. I had planned to look at the 
>> playback code, but I didn't have the time until now.
>>
>> Compared to v6 audio recording has improved but there are bugs. When 
>> I start QEMU with -audiodev 
>> pipewire,out.frequency=48000,in.frequency=48000,id=audio0 there are 
>> two either uninitialized or stale samples every 25ms in the recorded 
>> audio stream.
>>
>> To reproduce the issue start audacity on the host and generate a 2s 
>> square wave tone with 315Hz and an amplitude of 0.8. Use pavucontrol 
>> to select the monitor of your host playback device as QEMU recording 
>> device. In the guest start recording with audacity. Start playback of 
>> the generated square wave on the host. Stop recording in the guest 
>> and have a look at a 200ms sequence of the recorded square wave and 
>> notice the wrong samples every 25ms.
>
> We've noticed this and decided to fix it in the future. I think the 
> problem lies when PCM release is called from the guest. Quoting the spec:
>
>  The device MUST complete all pending I/O messages for the specified 
>  stream ID.
>  The device MUST NOT complete the control request while there are 
>  pending I/O messages for the specified stream ID.
>
> When RELEASE is received, buffers are simply dropped. This is pure 
> conjecture but I think creating an in-device buffer could solve this.
> Unless the bug is found to be caused by something else, I settled on 
> accepting it for this patch series because it is spec conformant.
>
>> When I start QEMU with -audiodev 
>> pipewire,out.mixing-engine=off,in.mixing-engine=off,id=audio0 audio 
>> recording starts but the recorded stream immediately stalls.
>
> Can you elaborate? Do you mean you repeat the same process as before, 
> but the stall happens immediately? I personally rarely get any drops I 
> could notice, only one or two for many minutes of playback / capture. 
> I also could not reproduce exactly the same behavior you had in the 
> previous version. The bugs *were* there but it was not as severe. 
> Maybe it's a hardware performance issue? Can someone else test this 
> too? It'd be helpful.

For this test I only start QEMU with the mixing engine disabled. When I 
start recording with audacity, audacity reports 'Recording' in the 
status line but it actually doesn't record. The recording marker in the 
tracks window stays a 0.

I don't think it's a hardware performance issue. Other QEMU audio 
devices don't show this behaviour.

With best regards,
Volker

>
> Thank you very much for your help,
> Manos


