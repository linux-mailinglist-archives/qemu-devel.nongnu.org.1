Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 001B9781D9C
	for <lists+qemu-devel@lfdr.de>; Sun, 20 Aug 2023 13:48:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXgtG-0005La-SL; Sun, 20 Aug 2023 07:46:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1qXgt5-0005LM-CJ
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 07:46:32 -0400
Received: from mailout05.t-online.de ([194.25.134.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1qXgt2-0007hK-Cb
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 07:46:31 -0400
Received: from fwd70.aul.t-online.de (fwd70.aul.t-online.de [10.223.144.96])
 by mailout05.t-online.de (Postfix) with SMTP id 8E3DC21D7A;
 Sun, 20 Aug 2023 13:46:24 +0200 (CEST)
Received: from [192.168.211.200] ([79.208.21.165]) by fwd70.t-online.de
 with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
 esmtp id 1qXgsy-0ZVVYH0; Sun, 20 Aug 2023 13:46:24 +0200
Content-Type: multipart/alternative;
 boundary="------------Ee2B5ChgEfctzzdDEQ8zZKnW"
Message-ID: <7d4e70f5-c930-e665-c0b0-44e3d8831743@t-online.de>
Date: Sun, 20 Aug 2023 13:46:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v6 00/12] Add VIRTIO sound card
To: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org
Cc: Igor Skalkin <Igor.Skalkin@opensynergy.com>,
 Anton Yakovlev <Anton.Yakovlev@opensynergy.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
References: <cover.1692089917.git.manos.pitsidianakis@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Volker_R=c3=bcmelin?= <vr_qemu@t-online.de>
In-Reply-To: <cover.1692089917.git.manos.pitsidianakis@linaro.org>
X-TOI-EXPURGATEID: 150726::1692531984-7C9A9E98-BEDB2912/0/0 CLEAN NORMAL
X-TOI-MSGID: 654c00b1-3dd9-44e9-8164-aebac8631a74
Received-SPF: none client-ip=194.25.134.82; envelope-from=vr_qemu@t-online.de;
 helo=mailout05.t-online.de
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, NICE_REPLY_A=-4.279, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

This is a multi-part message in MIME format.
--------------Ee2B5ChgEfctzzdDEQ8zZKnW
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Manos,

I tested the virtio-sound-pci device. It seems the device works 
unreliably. Audio playback has a lot of dropouts. I can actually hear my 
mouse moving around. Audio recording with audacity doesn't work. Either 
recording stops with an error or the recorded stream is silent.

I'll see if I can change the code so audio playback works reliably. I 
don't think it makes sense to review the current code as it is. I will 
of course report any issues I find.

With best regards,
Volker

> This patch series adds an audio device implementing the recent virtio
> sound spec (1.2) and a corresponding PCI wrapper device.
>
> https://github.com/epilys/qemu-virtio-snd/tree/virtio-snd-v6
>
> Main differences with v5 patch series [^v5]
> <cover.1690626150.git.manos.pitsidianakis@linaro.org>:
>
> - Free any existing PCM stream resources before allocating a new one.
> - Add docs.
>
> [^v5]:
> https://lore.kernel.org/qemu-devel/cover.1690626150.git.manos.pitsidianakis@linaro.org/
>
> Previously:
>
> [^v4]:
> https://lore.kernel.org/qemu-devel/cover.1689857559.git.manos.pitsidianakis@linaro.org/
> [^v3]:
> https://lore.kernel.org/qemu-devel/cover.1689692765.git.manos.pitsidianakis@linaro.org/
>
>
> Emmanouil Pitsidianakis (12):
>    Add virtio-sound device stub
>    Add virtio-sound-pci device
>    virtio-sound: handle control messages and streams
>    virtio-sound: set PCM stream parameters
>    virtio-sound: handle VIRTIO_SND_R_PCM_INFO request
>    virtio-sound: handle VIRTIO_SND_R_PCM_{START,STOP}
>    virtio-sound: handle VIRTIO_SND_PCM_SET_PARAMS
>    virtio-sound: handle VIRTIO_SND_R_PCM_PREPARE
>    virtio-sound: handle VIRTIO_SND_PCM_RELEASE
>    virtio-sound: implement audio output (TX)
>    virtio-sound: implement audio capture (RX)
>    docs/system: add basic virtio-snd documentation
>
>   MAINTAINERS                        |    6 +
>   docs/system/device-emulation.rst   |    1 +
>   docs/system/devices/virtio-snd.rst |   36 +
>   hw/virtio/Kconfig                  |    5 +
>   hw/virtio/meson.build              |    2 +
>   hw/virtio/trace-events             |   20 +
>   hw/virtio/virtio-snd-pci.c         |   91 ++
>   hw/virtio/virtio-snd.c             | 1308 ++++++++++++++++++++++++++++
>   include/hw/pci/pci.h               |    1 +
>   include/hw/virtio/virtio-snd.h     |  158 ++++
>   softmmu/qdev-monitor.c             |    1 +
>   11 files changed, 1629 insertions(+)
>   create mode 100644 docs/system/devices/virtio-snd.rst
>   create mode 100644 hw/virtio/virtio-snd-pci.c
>   create mode 100644 hw/virtio/virtio-snd.c
>   create mode 100644 include/hw/virtio/virtio-snd.h
>
--------------Ee2B5ChgEfctzzdDEQ8zZKnW
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <div class="moz-cite-prefix">Hi Manos,<br>
      <br>
      I tested the virtio-sound-pci device. It seems the device works
      unreliably. Audio playback has a lot of dropouts. I can actually
      hear my mouse moving around. Audio recording with audacity doesn't
      work. Either recording stops with an error or the recorded stream
      is silent.<br>
      <br>
      I'll see if I can change the code so audio playback works
      reliably. I don't think it makes sense to review the current code
      as it is. <span _d-id="86700" class="--l --r sentence_highlight">I
        will of course report any issues I find.</span><br>
      <br>
      With best regards,<br>
      Volker<br>
      <br>
    </div>
    <blockquote type="cite"
      cite="mid:cover.1692089917.git.manos.pitsidianakis@linaro.org">
      <pre class="moz-quote-pre" wrap="">
This patch series adds an audio device implementing the recent virtio 
sound spec (1.2) and a corresponding PCI wrapper device.

<a class="moz-txt-link-freetext" href="https://github.com/epilys/qemu-virtio-snd/tree/virtio-snd-v6">https://github.com/epilys/qemu-virtio-snd/tree/virtio-snd-v6</a>

Main differences with v5 patch series [^v5]
<a class="moz-txt-link-rfc2396E" href="mailto:cover.1690626150.git.manos.pitsidianakis@linaro.org">&lt;cover.1690626150.git.manos.pitsidianakis@linaro.org&gt;</a>:

- Free any existing PCM stream resources before allocating a new one.
- Add docs.

[^v5]: 
<a class="moz-txt-link-freetext" href="https://lore.kernel.org/qemu-devel/cover.1690626150.git.manos.pitsidianakis@linaro.org/">https://lore.kernel.org/qemu-devel/cover.1690626150.git.manos.pitsidianakis@linaro.org/</a>

Previously:

[^v4]: 
<a class="moz-txt-link-freetext" href="https://lore.kernel.org/qemu-devel/cover.1689857559.git.manos.pitsidianakis@linaro.org/">https://lore.kernel.org/qemu-devel/cover.1689857559.git.manos.pitsidianakis@linaro.org/</a>
[^v3]: 
<a class="moz-txt-link-freetext" href="https://lore.kernel.org/qemu-devel/cover.1689692765.git.manos.pitsidianakis@linaro.org/">https://lore.kernel.org/qemu-devel/cover.1689692765.git.manos.pitsidianakis@linaro.org/</a>


Emmanouil Pitsidianakis (12):
  Add virtio-sound device stub
  Add virtio-sound-pci device
  virtio-sound: handle control messages and streams
  virtio-sound: set PCM stream parameters
  virtio-sound: handle VIRTIO_SND_R_PCM_INFO request
  virtio-sound: handle VIRTIO_SND_R_PCM_{START,STOP}
  virtio-sound: handle VIRTIO_SND_PCM_SET_PARAMS
  virtio-sound: handle VIRTIO_SND_R_PCM_PREPARE
  virtio-sound: handle VIRTIO_SND_PCM_RELEASE
  virtio-sound: implement audio output (TX)
  virtio-sound: implement audio capture (RX)
  docs/system: add basic virtio-snd documentation

 MAINTAINERS                        |    6 +
 docs/system/device-emulation.rst   |    1 +
 docs/system/devices/virtio-snd.rst |   36 +
 hw/virtio/Kconfig                  |    5 +
 hw/virtio/meson.build              |    2 +
 hw/virtio/trace-events             |   20 +
 hw/virtio/virtio-snd-pci.c         |   91 ++
 hw/virtio/virtio-snd.c             | 1308 ++++++++++++++++++++++++++++
 include/hw/pci/pci.h               |    1 +
 include/hw/virtio/virtio-snd.h     |  158 ++++
 softmmu/qdev-monitor.c             |    1 +
 11 files changed, 1629 insertions(+)
 create mode 100644 docs/system/devices/virtio-snd.rst
 create mode 100644 hw/virtio/virtio-snd-pci.c
 create mode 100644 hw/virtio/virtio-snd.c
 create mode 100644 include/hw/virtio/virtio-snd.h

</pre>
    </blockquote>
  </body>
</html>

--------------Ee2B5ChgEfctzzdDEQ8zZKnW--

