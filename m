Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB177830FA
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 21:36:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYAgh-0000bq-QW; Mon, 21 Aug 2023 15:35:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1qYAge-0000bF-Rj
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 15:35:40 -0400
Received: from mailout09.t-online.de ([194.25.134.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1qYAga-00055E-O6
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 15:35:39 -0400
Received: from fwd73.aul.t-online.de (fwd73.aul.t-online.de [10.223.144.99])
 by mailout09.t-online.de (Postfix) with SMTP id 5D38A1F288;
 Mon, 21 Aug 2023 21:35:32 +0200 (CEST)
Received: from [192.168.211.200] ([79.208.21.165]) by fwd73.t-online.de
 with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
 esmtp id 1qYAgV-1gJrLl0; Mon, 21 Aug 2023 21:35:32 +0200
Message-ID: <11f13062-008c-42b4-f633-4b1c6f471421@t-online.de>
Date: Mon, 21 Aug 2023 21:35:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v6 00/12] Add VIRTIO sound card
Content-Language: en-US
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
Cc: Igor Skalkin <Igor.Skalkin@opensynergy.com>,
 Anton Yakovlev <Anton.Yakovlev@opensynergy.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
References: <cover.1692089917.git.manos.pitsidianakis@linaro.org>
 <7d4e70f5-c930-e665-c0b0-44e3d8831743@t-online.de>
 <zq9c1.g47o7x4yagn6@linaro.org>
From: =?UTF-8?Q?Volker_R=c3=bcmelin?= <vr_qemu@t-online.de>
In-Reply-To: <zq9c1.g47o7x4yagn6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1692646532-99E88904-3D914E64/0/0 CLEAN NORMAL
X-TOI-MSGID: 2795dc2f-bbef-41c1-b934-82e5753f2946
Received-SPF: none client-ip=194.25.134.84; envelope-from=vr_qemu@t-online.de;
 helo=mailout09.t-online.de
X-Spam_score_int: -59
X-Spam_score: -6.0
X-Spam_bar: ------
X-Spam_report: (-6.0 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-3.374, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001,
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

Am 21.08.23 um 08:10 schrieb Manos Pitsidianakis:
> Hello Volker,
>
> On Sun, 20 Aug 2023 14:46, Volker Rümelin <vr_qemu@t-online.de> wrote:
>> I tested the virtio-sound-pci device. It seems the device works 
>> unreliably. Audio playback has a lot of dropouts. I can actually hear 
>> my mouse moving around. Audio recording with audacity doesn't work. 
>> Either recording stops with an error or the recorded stream is silent.
>>
>> I'll see if I can change the code so audio playback works reliably. I 
>> don't think it makes sense to review the current code as it is. I 
>> will of course report any issues I find.
>
> have you been having this bad performance with pulseaudio/pipewire? 
> Are you using alsa for playback/recording in the guest?
>
> I am asking because this was my setup and I was wondering if it 
> affected the code I ended up with. For me I had normal playback, 
> except for a short delay at first (maybe something to do with alsa 
> buffer lengths, I am not familiar with ALSA much).
>
> If you can share your guest and host setup you used for this I can try 
> replicating it.
>

Hi Manos,

on the host I use pipewire. The audio device used for playback and 
recording is a Intel HDA device. I also tested recording from the 
playback monitor of the HDA device. The important command line arguments 
are: ./qemu-system-x86_64 -machine q35 -device 
virtio-vga-gl,xres=1280,yres=768,bus=pcie.0 -display 
gtk,zoom-to-fit=off,gl=on -machine pcspk-audiodev=audio0 -device 
virtio-sound-pci,bus=pcie.0,audiodev=audio0 -audiodev 
pipewire,out.frequency=48000,in.frequency=48000,id=audio0

The guest is Linux OpenSUSE 15.5 system. The guest uses PulseAudio. This 
means audacity ALSA audio recording was routed through PulseAudio. 
Audacity doesn't really start recording but after a few seconds it 
reports 'Wait timed out' and 'Error opening sound device. Try changing 
the audio host, recording device and the project sample rate'.

When I start QEMU with -audiodev 
pipewire,out.mixing-engine=off,in.mixing-engine=off,id=audio0 audacity 
only records silence.

For playback I use Rhythmbox or Audacity. If you don't immediately hear 
dropouts try activating and deactivating the QEMU gtk window in quick 
succession. A slightly increased processor load like moving the mouse 
around also increases the dropout rate.

With best regards,
Volker


