Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D767916ED
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 14:15:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd8TZ-0003kt-Fb; Mon, 04 Sep 2023 08:14:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qd8TN-0003g5-Cu
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 08:14:32 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qd8TK-0005oh-CU
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 08:14:29 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-313e742a787so859852f8f.1
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 05:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693829664; x=1694434464; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ahc379zCbdl/RcY1MR0nIuwS4psQzOv2ITAHPGcEYtU=;
 b=R/prggUZ0U/81AiJTw20NnpPXZCpqxLqwSIopkiYQWNzFvmb8iOKmRS95ooNB5p86k
 qd1nxy9eiFA206j1qrzeyJnPdA7bmImQTG+nD1PWLZEGWM/Hi0z625qo8N/Nbuy2EqBO
 S96g/tXyyuJQxmVXHwhlpyZ0sWenrRqDhp+z3yC7P3jt9VrJjb/0p6vMGgzeuVN9WKEs
 jtkf6W6tpA+S9eRVArztjmQ1iScmcMYUBKNN7L4XecRLQHfyTjFWWXCQVZX9G+36cKUL
 VpIX/HbAoIzshR9ORrIQpS48DaNOQ5Q1JQRgQfKEPjCHY+M1mi1hdkIwAbEvWtg3AhXt
 u+EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693829664; x=1694434464;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ahc379zCbdl/RcY1MR0nIuwS4psQzOv2ITAHPGcEYtU=;
 b=gELyYcHs+PFUT7JPOMmOCRFDsDBhCOJF4a+cQ80ni31fJ3TlAvmVhffhOB+JakO5ay
 duVoWF8G0IsjhZ67rYbKDBmXdmD4CBOVgR7p03yfECITx9x1lcKEbbzWo+wCsoRGLvyY
 LWzFgqudDiBtQAiBc4z/ykgvaBrUnRgD9q7U8GnPCBJ5DyaTnjOBqG2njdhEMMpr2DMm
 UsPJc7R2knaRPok1wZFynr012q2y1SkCITVlA+dudi0L9IE3rInibwk5XXY51Z1rTIuW
 XH5+IMqE89+FECMuVr27sOYuYgeITTe2PlgheqaueZI0HZUhuCYNUWBA7X/afoIG1Uti
 vgwg==
X-Gm-Message-State: AOJu0YyqUpc/sTKWvoNE+L+8cFk3SFyobcN37AT/3XB7YM4x8vkZBaXo
 DDCSADogczw74iDI29kvLLR51w==
X-Google-Smtp-Source: AGHT+IEHoGKIIhUNYY1Bit2MzwW5SVmEWTPPUuK4MU/RnCRYE/M2DY9hkvFkjeiOYiJnfcfpSN6Fag==
X-Received: by 2002:adf:ebcd:0:b0:319:6ca9:7c38 with SMTP id
 v13-20020adfebcd000000b003196ca97c38mr6771425wrn.22.1693829664109; 
 Mon, 04 Sep 2023 05:14:24 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 m24-20020adfa3d8000000b0031753073abcsm9857602wrb.36.2023.09.04.05.14.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Sep 2023 05:14:23 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 171F11FFBB;
 Mon,  4 Sep 2023 13:14:23 +0100 (BST)
References: <cover.1693252037.git.manos.pitsidianakis@linaro.org>
 <4b115410-9c0e-96aa-2f62-e82b7897ede5@t-online.de>
 <0ghxq.3r60jgujq0t@linaro.org>
User-agent: mu4e 1.11.16; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: Volker =?utf-8?Q?R=C3=BC?= melin <vr_qemu@t-online.de>,
 qemu-devel@nongnu.org, Igor
 Skalkin <Igor.Skalkin@opensynergy.com>, Anton Yakovlev
 <Anton.Yakovlev@opensynergy.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, "ichael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, =?utf-8?Q?Daniel_P=2E_Berr?=
 =?utf-8?Q?ang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, =?utf-8?Q?M?=
 =?utf-8?Q?arc-Andr=C3=A9?=
 Lureau <marcandre.lureau@redhat.com>, =?utf-8?B?S8WRIHbDoSBnw7MgLCBab2x0?=
 =?utf-8?B?w6Egbg==?=
 <DirtY.iCE.hu@gmail.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Subject: Re: [PATCH v8 00/12] Add VIRTIO sound card
Date: Mon, 04 Sep 2023 13:11:16 +0100
In-reply-to: <0ghxq.3r60jgujq0t@linaro.org>
Message-ID: <875y4qjftt.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42a.google.com
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


Manos Pitsidianakis <manos.pitsidianakis@linaro.org> writes:

> Hello Volker :)
>
> On Mon, 04 Sep 2023 10:20, Volker R=C3=BCmelin <vr_qemu@t-online.de> wrot=
e:
>>All qemu_log_mask() format strings need a trailing \n.
>
> Thank you, will fix it!
>
>> I still hear a lot of playback dropouts. I had planned to look at
>> the playback code, but I didn't have the time until now.
>>
>> Compared to v6 audio recording has improved but there are bugs. When
>> I start QEMU with -audiodev
>> pipewire,out.frequency=3D48000,in.frequency=3D48000,id=3Daudio0 there are
>> two either uninitialized or stale samples every 25ms in the recorded
>> audio stream.
>>
>> To reproduce the issue start audacity on the host and generate a 2s
>> square wave tone with 315Hz and an amplitude of 0.8. Use pavucontrol
>> to select the monitor of your host playback device as QEMU recording
>> device. In the guest start recording with audacity. Start playback
>> of the generated square wave on the host. Stop recording in the
>> guest and have a look at a 200ms sequence of the recorded square
>> wave and notice the wrong samples every 25ms.
>
> We've noticed this and decided to fix it in the future. I think the
> problem lies when PCM release is called from the guest. Quoting the
> spec:
>
>  The device MUST complete all pending I/O messages for the specified
>  stream ID.
>  The device MUST NOT complete the control request while there are
>  pending I/O messages for the specified stream ID.
>
> When RELEASE is received, buffers are simply dropped. This is pure
> conjecture but I think creating an in-device buffer could solve this.
> Unless the bug is found to be caused by something else, I settled on
> accepting it for this patch series because it is spec conformant.

Volker,

Can you run with:

  -d trace:virtio_snd\*

to confirm you are seeing the same behaviour. The experience I had with
ogg123 in an emulated guest was it would work fine but then the next run
I would get audio corruption. You can see this if you see lots of
START/STOP/RELEASE messages constantly restarting things. If you are
getting corruption without this pattern that is something else which we
should investigate before merging.

>
>> When I start QEMU with -audiodev
>> pipewire,out.mixing-engine=3Doff,in.mixing-engine=3Doff,id=3Daudio0 audio
>> recording starts but the recorded stream immediately stalls.
>
> Can you elaborate? Do you mean you repeat the same process as before,
> but the stall happens immediately? I personally rarely get any drops I
> could notice, only one or two for many minutes of playback / capture.
> I also could not reproduce exactly the same behavior you had in the
> previous version. The bugs *were* there but it was not as severe.
> Maybe it's a hardware performance issue? Can someone else test this
> too? It'd be helpful.
>
> Thank you very much for your help,
> Manos


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

