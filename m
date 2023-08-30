Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E8678D7E4
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 19:53:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbPLp-0006DJ-BH; Wed, 30 Aug 2023 13:51:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qbPLn-0006D7-Fl
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 13:51:31 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qbPLl-0000Qh-4m
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 13:51:31 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-31dd10c2b8bso2408979f8f.3
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 10:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693417887; x=1694022687; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lqjOovzKZiF4cEkpElGacjGhl2pPIROjegeiSw4rVQM=;
 b=m8hmv4RkgbVeCzJIXq6v5VSXx+6tjVtBdDcBnxuCf8W44ERxa2jezE6gqKURytHhkl
 j1UH3YOXdvh4rTzvcEaABVoksUyzOEI6FlP6mllPpMYZFjjKQGjgWddnEvCr5Plye0hD
 8JXsdCtiwqwqH6B+R0ozBWd3T6ANE9SvtEH7HBWS7cU39S0rmKolGPIypM30l/HVoTBc
 1RWupmV4etCcJrHnEaow7wJEJPFXXsB8Wyn6/BzJvTWzoOckZz4Ohi10Afv9yJvlZl3+
 XAOpcw8kioHlyioecXV04A98hpf3JQO+Fxj5P029hMTnhVtFTbbDl8GB9UrkTBx04KWJ
 UgFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693417887; x=1694022687;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lqjOovzKZiF4cEkpElGacjGhl2pPIROjegeiSw4rVQM=;
 b=OuOWhLRy0rGbrk3+pgr0NKxmwi2M8KRIREL7ZPTmhSrmni0+2WSUOl7WyjMqrc+uxv
 J3DqdNplSlgYXzR2lHO1WG64OOylr02+x6s7FgHX/0Zxs9yRjZFYHTAUTOJ4Ig0wEcNF
 FytSfnfrdvzk5nTxnwGgEZdEPZTn/rSiU5SdTssXh7NKdrodwgyEZKdMqSuWirkDHXVa
 A+WfKs864ePWgnJbrpjNuKHoJQ9G6F9PrOvhcyaIFG6jwROraRljErfSA5ernE6PyXZa
 7VIgyDmHPHJbbkakswmedVFsejnBxrchKkylFiQ1U9whnc9pCX5qyhTS3FFgWwxBKhgS
 +neA==
X-Gm-Message-State: AOJu0Yw6nMrnzeRxMME+5Bu5pPkzzR2xXWTgNQGCMcK2Xgn/MjBmbms+
 FEzFkoiNh7B+ZstKCok7QFZRzQ==
X-Google-Smtp-Source: AGHT+IEkctwZw75YKgxWbmwiAnxMDm29RL+wvUZpElTsgOVZ7grOjvUo4GQbEYEDQ1g7oyMLjU2Bxg==
X-Received: by 2002:a5d:5601:0:b0:317:6c16:a8a8 with SMTP id
 l1-20020a5d5601000000b003176c16a8a8mr2500804wrv.35.1693417887345; 
 Wed, 30 Aug 2023 10:51:27 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 b3-20020adfde03000000b0031accc7228asm17215857wrm.34.2023.08.30.10.51.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 10:51:27 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5F2E91FFBB;
 Wed, 30 Aug 2023 18:51:26 +0100 (BST)
References: <cover.1693252037.git.manos.pitsidianakis@linaro.org>
 <69eb5f4fbae731f5fc05dea8a5f4b656e0de127f.1693252037.git.manos.pitsidianakis@linaro.org>
User-agent: mu4e 1.11.16; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, Igor Skalkin <Igor.Skalkin@opensynergy.com>,
 Anton Yakovlev <Anton.Yakovlev@opensynergy.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Eduardo
 Habkost <eduardo@habkost.net>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Volker =?utf-8?Q?R=C3=BCmelin?= <vr_qemu@t-online.de>, =?utf-8?B?S8WRdsOh?=
 =?utf-8?B?Z8OzLCBab2x0w6Fu?=
 <DirtY.iCE.hu@gmail.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Subject: Re: [PATCH v8 12/12] docs/system: add basic virtio-snd documentation
Date: Wed, 30 Aug 2023 18:49:03 +0100
In-reply-to: <69eb5f4fbae731f5fc05dea8a5f4b656e0de127f.1693252037.git.manos.pitsidianakis@linaro.org>
Message-ID: <87ttsgpgf5.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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


Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org> writes:

> This commit adds basic documentation for using virtio-snd.
>
> Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>  docs/system/device-emulation.rst   |  1 +
>  docs/system/devices/virtio-snd.rst | 49 ++++++++++++++++++++++++++++++
>  2 files changed, 50 insertions(+)
>  create mode 100644 docs/system/devices/virtio-snd.rst
>
> diff --git a/docs/system/device-emulation.rst b/docs/system/device-emulat=
ion.rst
> index 4491c4cbf7..dae19446e5 100644
> --- a/docs/system/device-emulation.rst
> +++ b/docs/system/device-emulation.rst
> @@ -92,6 +92,7 @@ Emulated Devices
>     devices/usb.rst
>     devices/vhost-user.rst
>     devices/virtio-pmem.rst
> +   devices/virtio-snd.rst
>     devices/vhost-user-rng.rst
>     devices/canokey.rst
>     devices/usb-u2f.rst
> diff --git a/docs/system/devices/virtio-snd.rst b/docs/system/devices/vir=
tio-snd.rst
> new file mode 100644
> index 0000000000..2a9187fd70
> --- /dev/null
> +++ b/docs/system/devices/virtio-snd.rst
> @@ -0,0 +1,49 @@
> +virtio sound
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +This document explains the setup and usage of the Virtio sound device.
> +The Virtio sound device is a paravirtualized sound card device.
> +
> +Linux kernel support
> +--------------------
> +
> +Virtio sound requires a guest Linux kernel built with the
> +``CONFIG_SND_VIRTIO`` option.
> +
> +Description
> +-----------
> +
> +Virtio sound implements capture and playback from inside a guest using t=
he
> +configured audio backend of the host machine.
> +
> +Device properties
> +-----------------
> +
> +The Virtio sound device can be configured with the following properties:
> +
> + * ``jacks`` number of physical jacks (Unimplemented).
> + * ``streams`` number of PCM streams. At the moment, no stream configura=
tion is supported: the first one will always be a playback stream, an optio=
nal second will always be a capture stream. Adding more will cycle stream d=
irections from playback to capture.
> + * ``chmaps`` number of channel maps (Unimplemented).

I think you can drop the unimplemented properties from the docs and the
code. No point having them if they do nothing and you might change your
mind on the name when they are implemented ;-)

> +
> +All streams are stereo and have the default channel positions ``Front le=
ft, right``.
> +
> +Examples
> +--------
> +
> +Add an audio device and an audio backend at once with ``-audio`` and ``m=
odel=3Dvirtio``:
> +
> + * pulseaudio: ``-audio driver=3Dpa,model=3Dvirtio``
> +   or ``-audio driver=3Dpa,model=3Dvirtio,server=3D/run/user/1000/pulse/=
native``
> + * sdl: ``-audio driver=3Dsdl,model=3Dvirtio``
> + * coreaudio: ``-audio driver=3Dcoreaudio,model=3Dvirtio``
> +
> +etc.
> +
> +To specifically add virtualized sound devices, you have to specify a PCI=
 device
> +and an audio backend listed with ``-audio driver=3Dhelp`` that works on =
your host
> +machine, e.g.:

I'd be tempted to start with the specific example and then mention the
shortcut. I'm curious as to how model=3D resolves on various platforms or
how you would tell from the command line.

> +
> +::
> +
> +  -device virtio-sound-pci,audiodev=3Dmy_audiodev \
> +  -audiodev alsa,id=3Dmy_audiodev

Otherwise:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>




--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

