Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A11767C0022
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 17:15:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqERO-0007rj-L3; Tue, 10 Oct 2023 11:14:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qqERN-0007rF-5X; Tue, 10 Oct 2023 11:14:33 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qqERJ-0001BW-FA; Tue, 10 Oct 2023 11:14:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uEDLiVVrLktznZUIRCsVgnsCI5pxyytwgpqvchTpi78=; b=Qa20PfDB/6RuG2abzxzVt42zZB
 d4NDQiQM2ujwrhec1kyahPg86O2eBM48hIuPeOIZ82NUj1fZjMTjWK50Sw8oe9z54TFl96PyqAE3U
 WCY36cOPxNGWesyPZoPIBb1fzYFT5FRT9Lgi+dpVe7KbC5r0Citscq4tRJCZIY4H1i4K9gxN13H1q
 C0q1kuEnFxcLBK5Y+o25a6FIAVkszRphGrctum5404MXh64hc2qtS5AgDoj9BHbYVIx9x1Pcf2E+O
 O4VD/Z/vrW5Ynz92gJ6iyPF4WS+QbLLA+xEbA4OH042wd3sA3cmBnTLKzWff5Trqn7fW6pDEDc/26
 OTMZmy72E0vV4sYP7TxyBDKFxHlh09PWkyKcpIeO6QuzUoVKMB+DjbIxgAW5O7CO9WFBpynA7Kz0X
 Ee4De0KvrtYxx+I2nCSJbKEXhWmkK5iy7FPipPhb8Ok9Ob+bre6e8X1a8U3qjWSP+uX1hfbyomG+s
 4zjhM5QZ2INCCx18Mr8hpD2XD9h6R3J2U6Zcd7OxARA1Rt3qN0hzSEajwgE+gylBKxh+ZQ+oSwTfr
 c2EcA4lDWfkq66HxT08zqJ0++WcXn5+79YGXAmrB+82NoNwmj9mHftray+4yugAkDcEQIWEcn4rZk
 gElFEikc3Hx6nvJaM05rKnu5FjtuRz05eMH7dgqnY=;
Received: from host86-135-55-164.range86-135.btcentralplus.com
 ([86.135.55.164] helo=[10.8.0.6])
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qqERA-000CXg-5G; Tue, 10 Oct 2023 16:14:24 +0100
Message-ID: <881062fe-b8c7-4437-92cf-0e9838f3708b@ilande.co.uk>
Date: Tue, 10 Oct 2023 16:14:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Erik Schilling <erik.schilling@linaro.org>, Fam Zheng <fam@euphon.net>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-block@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Paolo Bonzini <pbonzini@redhat.com>, Viresh Kumar <viresh.kumar@linaro.org>,
 virtio-fs@redhat.com, "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Markus Armbruster <armbru@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20231009095937.195728-1-alex.bennee@linaro.org>
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
In-Reply-To: <20231009095937.195728-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.135.55.164
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v4 0/6] virtio: cleanup vhost-user-generic and reduce c&p
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 09/10/2023 10:59, Alex Bennée wrote:

> A lot of our vhost-user stubs are large chunks of boilerplate that do
> (mostly) the same thing. This series continues the cleanups by
> splitting the vhost-user-base and vhost-user-generic implementations.
> After adding a new vq_size property the rng, gpio and i2c vhost-user
> devices become simple specialisations of the common base defining the
> ID, number of queues and potentially the config handling.
> 
> I've also added Manos' vhost-user-sound while I was at it.
> 
> Changes
> -------
> 
> I've dropped the F_TRANSPORT work from this series to keep this small
> and ready to merge. The changes for F_TRANSPORT are a bit more
> invasive and still need a bit of debugging but I wanted to get this
> stuff merged now.
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
>   docs/system/devices/vhost-user-rng.rst |   2 +
>   docs/system/devices/vhost-user.rst     |  41 +++
>   include/hw/virtio/vhost-user-base.h    |  49 +++
>   include/hw/virtio/vhost-user-gpio.h    |  23 +-
>   include/hw/virtio/vhost-user-i2c.h     |  14 +-
>   include/hw/virtio/vhost-user-rng.h     |  11 +-
>   include/hw/virtio/vhost-user-snd.h     |  26 ++
>   hw/virtio/vhost-user-base.c            | 348 +++++++++++++++++++++
>   hw/virtio/vhost-user-device-pci.c      |  10 +-
>   hw/virtio/vhost-user-device.c          | 335 +-------------------
>   hw/virtio/vhost-user-gpio.c            | 407 ++-----------------------
>   hw/virtio/vhost-user-i2c.c             | 272 +----------------
>   hw/virtio/vhost-user-rng.c             | 278 ++---------------
>   hw/virtio/vhost-user-snd-pci.c         |  75 +++++
>   hw/virtio/vhost-user-snd.c             |  67 ++++
>   hw/virtio/Kconfig                      |   5 +
>   hw/virtio/meson.build                  |  25 +-
>   17 files changed, 705 insertions(+), 1283 deletions(-)
>   create mode 100644 include/hw/virtio/vhost-user-base.h
>   create mode 100644 include/hw/virtio/vhost-user-snd.h
>   create mode 100644 hw/virtio/vhost-user-base.c
>   create mode 100644 hw/virtio/vhost-user-snd-pci.c
>   create mode 100644 hw/virtio/vhost-user-snd.c

Hi Alex,

 From a quick skim the QOM modelling looks good to me. The only thing I've noticed is 
that the parent object for VHostUserBase derived classes is sometimes named as 
"VHostUserBase parent" instead of "VHostUserBase parent_obj" as per the QOM naming 
guidelines.


ATB,

Mark.


