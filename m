Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 136387E365F
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 09:10:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0H9f-000360-BN; Tue, 07 Nov 2023 03:09:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1r0H9R-00035f-TC; Tue, 07 Nov 2023 03:09:35 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1r0H9Q-0003eV-5Y; Tue, 07 Nov 2023 03:09:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+Fc9OD33QaWc1q/SwTCs0LX53i0mluHZDvZPRoGJFhY=; b=1Zly4JJQIIYe8YRZL6xut99m0V
 +HEfCpLIo4YpeGAeQumzlD/PAxQCU561T8cOr9U2Y5nu9AkTQIkLjzgxI1Xkp5+rxzQyn+DqQliNW
 HI2Mn360ZzaqjZvnOQBlpSRIbzSQ4oevwFsiiTYv82QsASw9XA1F1t8UgGSVbcXUvBa/TQqKq9pgf
 pf/jfuGf/1JkjD8Z4JKmh0otU6J0vTUKivis9TFbF7t+4hO0wP9FXfpsXfHpivxCwPbtoGfB6hOF/
 wp2mMXsKoTRMg8NaL40DC9Q/+vyELXL1I85Q8Mfl8KBhvWOxbAGywJTsOJ1nPv+q9HNTzltmRMxil
 zH40m7IjQRBcUQcW2qLydGXVZwv9fAbGEGdrNB5ie3J0+umPRnfXbwXEpkK3E2TJFAhQ28KUMgNnf
 94ZEgPhyvTpcxurl7YEYfmlCaP14UDfBFgoPaXJny/zVTb7n3myizw/BuEM893I3S/uP1Cvy8eyxX
 +/I9Os76ek3bsAlde3c3HLSbXE5L0louXWtwrwJxDQOzAzepeW9Tb/i1g4zxB5ofqGmiDgCe1O5R7
 QM1n9IWVP/dXQCb1PsG7KojEi9Bjz2KGMSTyArPBO7i3djFw0bKKJjn8/25mD+0fmVTfARAKv7/Tr
 YfElmRp3th3LZ5qbVrfOfUkBCBQB78QDyGOTskuWM=;
Received: from [2a00:23c4:8bb0:5400:786d:754a:beab:3c15]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1r0H94-000BYJ-0v; Tue, 07 Nov 2023 08:09:14 +0000
Message-ID: <5f90de59-bddc-49ef-8586-756654450c3a@ilande.co.uk>
Date: Tue, 7 Nov 2023 08:09:16 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi
 <stefanha@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, virtio-fs@redhat.com,
 Hanna Reitz <hreitz@redhat.com>, Fam Zheng <fam@euphon.net>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>, Kevin Wolf
 <kwolf@redhat.com>, Erik Schilling <erik.schilling@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, Eric Blake
 <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20231106191515.2801863-1-alex.bennee@linaro.org>
Content-Language: en-US
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Autocrypt: addr=mark.cave-ayland@ilande.co.uk; keydata=
 xsBNBFQJuzwBCADAYvxrwUh1p/PvUlNFwKosVtVHHplgWi5p29t58QlOUkceZG0DBYSNqk93
 3JzBTbtd4JfFcSupo6MNNOrCzdCbCjZ64ik8ycaUOSzK2tKbeQLEXzXoaDL1Y7vuVO7nL9bG
 E5Ru3wkhCFc7SkoypIoAUqz8EtiB6T89/D9TDEyjdXUacc53R5gu8wEWiMg5MQQuGwzbQy9n
 PFI+mXC7AaEUqBVc2lBQVpAYXkN0EyqNNT12UfDLdxaxaFpUAE2pCa2LTyo5vn5hEW+i3VdN
 PkmjyPvL6DdY03fvC01PyY8zaw+UI94QqjlrDisHpUH40IUPpC/NB0LwzL2aQOMkzT2NABEB
 AAHNME1hcmsgQ2F2ZS1BeWxhbmQgPG1hcmsuY2F2ZS1heWxhbmRAaWxhbmRlLmNvLnVrPsLA
 eAQTAQIAIgUCVAm7PAIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQW8LFb64PMh9f
 NAgAuc3ObOEY8NbZko72AGrg2tWKdybcMVITxmcor4hb9155o/OWcA4IDbeATR6cfiDL/oxU
 mcmtXVgPqOwtW3NYAKr5g/FrZZ3uluQ2mtNYAyTFeALy8YF7N3yhs7LOcpbFP7tEbkSzoXNG
 z8iYMiYtKwttt40WaheWuRs0ZOLbs6yoczZBDhna3Nj0LA3GpeJKlaV03O4umjKJgACP1c/q
 T2Pkg+FCBHHFP454+waqojHp4OCBo6HyK+8I4wJRa9Z0EFqXIu8lTDYoggeX0Xd6bWeCFHK3
 DhD0/Xi/kegSW33unsp8oVcM4kcFxTkpBgj39dB4KwAUznhTJR0zUHf63M7ATQRUCbs8AQgA
 y7kyevA4bpetM/EjtuqQX4U05MBhEz/2SFkX6IaGtTG2NNw5wbcAfhOIuNNBYbw6ExuaJ3um
 2uLseHnudmvN4VSJ5Hfbd8rhqoMmmO71szgT/ZD9MEe2KHzBdmhmhxJdp+zQNivy215j6H27
 14mbC2dia7ktwP1rxPIX1OOfQwPuqlkmYPuVwZP19S4EYnCELOrnJ0m56tZLn5Zj+1jZX9Co
 YbNLMa28qsktYJ4oU4jtn6V79H+/zpERZAHmH40IRXdR3hA+Ye7iC/ZpWzT2VSDlPbGY9Yja
 Sp7w2347L5G+LLbAfaVoejHlfy/msPeehUcuKjAdBLoEhSPYzzdvEQARAQABwsBfBBgBAgAJ
 BQJUCbs8AhsMAAoJEFvCxW+uDzIfabYIAJXmBepHJpvCPiMNEQJNJ2ZSzSjhic84LTMWMbJ+
 opQgr5cb8SPQyyb508fc8b4uD8ejlF/cdbbBNktp3BXsHlO5BrmcABgxSP8HYYNsX0n9kERv
 NMToU0oiBuAaX7O/0K9+BW+3+PGMwiu5ml0cwDqljxfVN0dUBZnQ8kZpLsY+WDrIHmQWjtH+
 Ir6VauZs5Gp25XLrL6bh/SL8aK0BX6y79m5nhfKI1/6qtzHAjtMAjqy8ChPvOqVVVqmGUzFg
 KPsrrIoklWcYHXPyMLj9afispPVR8e0tMKvxzFBWzrWX1mzljbBlnV2n8BIwVXWNbgwpHSsj
 imgcU9TTGC5qd9g=
In-Reply-To: <20231106191515.2801863-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb0:5400:786d:754a:beab:3c15
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v6 0/6] virtio: cleanup vhost-user-generic and reduce c&p
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 06/11/2023 19:15, Alex Bennée wrote:

> A lot of our vhost-user stubs are large chunks of boilerplate that do
> (mostly) the same thing. This series continues the cleanups by
> splitting the vhost-user-base and vhost-user-generic implementations.
> After adding a new vq_size property the rng, gpio and i2c vhost-user
> devices become simple specialisations of the common base defining the
> ID, number of queues and potentially the config handling.
> 
> I've also added Manos' vhost-user-sound while I was at it.

Looks like patches 2-5 are still missing s/parent/parent_obj/ for the QOM classes 
that are derived from VHostUserBase?

> Changes
> -------
> 
> v6
>    - re-base to current master
>    - make vhost-user-device abstract
>    - mention abstractness in docs
> 
> v5
>    - addressing comments and tags
>    - improved the docs
> 
> v4
>    - dropped the F_TRANSPORT work for another series
>    - added vhost-user-sound
> 
> Alex Bennée (5):
>    virtio: split into vhost-user-base and vhost-user-device
>    hw/virtio: derive vhost-user-rng from vhost-user-base
>    hw/virtio: derive vhost-user-gpio from vhost-user-base
>    hw/virtio: derive vhost-user-i2c from vhost-user-base
>    docs/system: add a basic enumeration of vhost-user devices
> 
> Manos Pitsidianakis (1):
>    hw/virtio: add vhost-user-snd and virtio-snd-pci devices
> 
>   docs/system/devices/vhost-user-rng.rst        |   2 +
>   docs/system/devices/vhost-user.rst            |  65 ++-
>   ...{vhost-user-device.h => vhost-user-base.h} |  21 +-
>   include/hw/virtio/vhost-user-gpio.h           |  23 +-
>   include/hw/virtio/vhost-user-i2c.h            |  14 +-
>   include/hw/virtio/vhost-user-rng.h            |  11 +-
>   include/hw/virtio/vhost-user-snd.h            |  26 ++
>   hw/virtio/vhost-user-base.c                   | 345 +++++++++++++++
>   hw/virtio/vhost-user-device-pci.c             |  10 +-
>   hw/virtio/vhost-user-device.c                 | 337 +--------------
>   hw/virtio/vhost-user-gpio.c                   | 406 +-----------------
>   hw/virtio/vhost-user-i2c.c                    | 272 +-----------
>   hw/virtio/vhost-user-rng.c                    | 278 +-----------
>   hw/virtio/vhost-user-snd-pci.c                |  75 ++++
>   hw/virtio/vhost-user-snd.c                    |  67 +++
>   hw/virtio/Kconfig                             |   5 +
>   hw/virtio/meson.build                         |  23 +-
>   17 files changed, 690 insertions(+), 1290 deletions(-)
>   rename include/hw/virtio/{vhost-user-device.h => vhost-user-base.h} (71%)
>   create mode 100644 include/hw/virtio/vhost-user-snd.h
>   create mode 100644 hw/virtio/vhost-user-base.c
>   create mode 100644 hw/virtio/vhost-user-snd-pci.c
>   create mode 100644 hw/virtio/vhost-user-snd.c


ATB,

Mark.


