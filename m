Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 03841791EE1
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 23:09:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdGo2-00084l-0I; Mon, 04 Sep 2023 17:08:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1qdGny-00084N-3G
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 17:08:18 -0400
Received: from mailout06.t-online.de ([194.25.134.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1qdGnv-000854-Ev
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 17:08:17 -0400
Received: from fwd85.aul.t-online.de (fwd85.aul.t-online.de [10.223.144.111])
 by mailout06.t-online.de (Postfix) with SMTP id 1A9FD1E338;
 Mon,  4 Sep 2023 23:08:11 +0200 (CEST)
Received: from [192.168.211.200] ([79.208.25.148]) by fwd85.t-online.de
 with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
 esmtp id 1qdGnq-24Pq410; Mon, 4 Sep 2023 23:08:11 +0200
Message-ID: <059c5cbc-fe22-8b37-5427-f88016eee66d@t-online.de>
Date: Mon, 4 Sep 2023 23:08:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
From: =?UTF-8?Q?Volker_R=c3=bcmelin?= <vr_qemu@t-online.de>
Subject: Re: [PATCH v8 02/12] Add virtio-sound-pci device
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
Cc: Igor Skalkin <Igor.Skalkin@opensynergy.com>,
 Anton Yakovlev <Anton.Yakovlev@opensynergy.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?B?S8WRdsOhZ8OzICwgWm9sdMOhbg==?= <DirtY.iCE.hu@gmail.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
References: <cover.1693252037.git.manos.pitsidianakis@linaro.org>
 <8de966a86bc21358528eeee66ffe74f8a82bb687.1693252037.git.manos.pitsidianakis@linaro.org>
 <99c231b8-8447-93a7-6a94-3a68921190ae@t-online.de>
 <0gil3.63jtdidrts0@linaro.org>
Content-Language: en-US
In-Reply-To: <0gil3.63jtdidrts0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1693861691-CD5E2EAB-8B50F400/0/0 CLEAN NORMAL
X-TOI-MSGID: 90be2d26-0264-4454-92f0-2b2e3c23cef4
Received-SPF: none client-ip=194.25.134.19; envelope-from=vr_qemu@t-online.de;
 helo=mailout06.t-online.de
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
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

Am 04.09.23 um 12:26 schrieb Manos Pitsidianakis:
> On Mon, 04 Sep 2023 09:32, Volker Rümelin <vr_qemu@t-online.de> wrote:
>>> +static Property virtio_snd_pci_properties[] = {
>>> +    DEFINE_AUDIO_PROPERTIES(VirtIOSoundPCI, vdev.card),
>>
>> I think DEFINE_AUDIO_PROPERTIES should be moved back to virtio-snd.c. 
>> The audiodev property is a virtio-sound property and not a 
>> virtio-sound-pci property.
>
> Hm, is it? Can you instantiate a virtio-sound device without the PCI 
> wrapper? Under hw/audio, DEFINE_AUDIO_PROPERTIES is set in PCI devices 
> as well (e.g. ac97)
>

Creating a virtio-sound device without the PCI wrapper is possible.
./qemu-system-x86_64 -M microvm -accel kvm -cpu host -m 512m -smp 2 
-serial stdio -device virtio-sound,audiodev=audio0 -audiodev 
pipewire,id=audio0 -display gtk
qemu-system-x86_64: -device virtio-sound,audiodev=audio0: Property 
'virtio-sound.audiodev' not found

If you move DEFINE_AUDIO_PROPERTIES to virtio-snd.c you don't see this 
error message and you can see a virtio-mmio sound device if you type 
info qtree in the QEMU compat monitor.

Now that you asked this question I wonder if this should be #define 
TYPE_VIRTIO_SND "virtio-sound-device". Other virtio devices have the 
-device suffix.

With best regards,
Volker

>>
>>> +    DEFINE_PROP_BIT("ioeventfd", VirtIOPCIProxy, flags,
>>> +                    VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT, true),
>>> +    DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors,
>>> +                       DEV_NVECTORS_UNSPECIFIED),
>>> +    DEFINE_PROP_END_OF_LIST(),
>>> +};
>>> +
>>> +static void virtio_snd_pci_realize(VirtIOPCIProxy *vpci_dev, Error 
>>> **errp)
>>> +{
>>> +    VirtIOSoundPCI *dev = VIRTIO_SND_PCI(vpci_dev);
>>> +    DeviceState *vdev = DEVICE(&dev->vdev);
>>> +
>>> +    if (vpci_dev->nvectors == DEV_NVECTORS_UNSPECIFIED) {
>>> +        vpci_dev->nvectors = 2;
>>> +    }
>>
>> Why do you need that intermediate step with DEV_NVECTORS_UNSPECIFIED? 
>> Unlike e.g. virtio-scsi-pci and virtio-net-pci devices, the default 
>> value of nvectors is already known at compile time and can be 
>> specified in the property definition.
>
> I did not think this through properly, you are correct. Thank you!
>
> Manos


