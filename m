Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 81FA47D55E1
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 17:22:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvJDz-0002yS-2Q; Tue, 24 Oct 2023 11:21:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qvJDw-0002yE-JF
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 11:21:40 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qvJDn-0003BZ-A1
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 11:21:40 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-408425c7c10so38348725e9.0
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 08:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698160889; x=1698765689; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=72MqZ1TBERfNnRGg6ZSoU6zm6pbzRusIVQunUe10BJE=;
 b=Cbgh1YRZEo0qcjLMug2iFKC3rlR5RgROKyA2CVEcpPf7dywFTD3LFW3biRu/nBGx38
 d0BkleBHyncGbliw1ws8coGApMdE7H9l8F8lWKmKQR2wVAuye9HxHsgQXRMv36RfsP2Y
 T18FF9xPHR6htf4j8uGlp4rU8AS9pmlXtNTdymielXtVu9MNTzPVw2mZzLP8YIj+sjm2
 I8BbRq3stIKOAyP73+s50R12haX2fIp/otFj+cun3TA3bO+lRYfNTjsRV1fD2DUJUtsk
 RFpr56V0whX1f5sox/A4bJ/LZbn+yXC7xByETOVnloVq/HMBNm7Eh5Ib8ct3Hk+JEqfY
 JCVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698160889; x=1698765689;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=72MqZ1TBERfNnRGg6ZSoU6zm6pbzRusIVQunUe10BJE=;
 b=HCNx1VcQPjI3tsx29GfoGcIQfDSzm2O1swnNHBSm8AC3aGpYYHCDLZDztugZ7lbmBv
 BaGFnVxYZBYwS2806UNlakVmOZszh/Wv8jnUXcUBQzoOl1RGmqcTx/XoHBi4JPu2VdR2
 m1XDtkzTYuIUj0zzeH3Jntacgh24EEFH5f2AqMjX23kGAl3l5UTZBgCt/n4L8qL60VyE
 ULxEH7qEtxlB8N2N9VJxRgFcaeZXq+fFtKI+qDXVPAVqP1dDbWqHgpZnTj2wK7qryBZ7
 sSq0x6Cw/ICRzLFVqIVDiUTtxU+k6M8XgdymdVGcb7DzgP0dQbkSUQ6CZRI4zTUsALs1
 wCEQ==
X-Gm-Message-State: AOJu0YyIXAWopjS2XpkLLGKgVjbBCwRLNrGNPSDXGjQcMLry6zfxMC3N
 mqkSMBNZS8pQwybF3cT8Ex3e/g==
X-Google-Smtp-Source: AGHT+IG8ByIhwcQ2kvNqfueeefb4Vcw8VCdxXcp5kN79zc7rsnjImZ7LwRQPKSKSD3QQx+4i2leh7w==
X-Received: by 2002:a05:600c:1ca5:b0:401:b6f6:d8fd with SMTP id
 k37-20020a05600c1ca500b00401b6f6d8fdmr9395386wms.6.1698160889525; 
 Tue, 24 Oct 2023 08:21:29 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 l8-20020a05600c1d0800b0040531f5c51asm12422906wms.5.2023.10.24.08.21.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 08:21:29 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7DA211FFBB;
 Tue, 24 Oct 2023 16:21:28 +0100 (BST)
References: <878r7t482z.fsf@linaro.org>
 <CAMxuvaw8b6QEZO_Z_-ityoEOFPRuQ7D0pBVwK3BEKBNWX3S3KA@mail.gmail.com>
 <87jzrc2ihe.fsf@linaro.org>
User-agent: mu4e 1.11.22; emacs 29.1.90
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Stefan
 Hajnoczi
 <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Leo Yan
 <leo.yan@linaro.org>, qemu-devel <qemu-devel@nongnu.org>
Subject: Re: State of contrib/vhost-user-input?
Date: Tue, 24 Oct 2023 16:20:43 +0100
In-reply-to: <87jzrc2ihe.fsf@linaro.org>
Message-ID: <87bkco2ghz.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
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


Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
>> Hi Alex
>>
>> On Mon, Oct 23, 2023 at 8:34=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@li=
naro.org> wrote:
>>>
>>>
>>> Hi,
>>>
>>> I'm trying to get the contrib/vhost-user-input working but it exits
>>> during the boot up sequence:
>>>
<snip>
>>> Which looks like libvhost-user is expecting
>>> VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS to be negotiated and the
>>> resulting VHOST_USER_ADD_MEM_REG to be sent. How is this meant to work
>>> if the protocol feature isn't negotiated?
>>
>>
>> How did you start QEMU ? Did you forget to use shared memory ?
>
> I had:
>
>        -m 8192 \
>        -object memory-backend-memfd,id=3Dmem,size=3D8G,share=3Don \
>
> Alongside:
>
>        -device virtio-gpu-pci \
>        -device qemu-xhci -device usb-kbd \
>        -kernel ~/lsrc/linux.git/builds/arm64/arch/arm64/boot/Image.gz
> -append 'console=3DttyAMA0 root=3D/dev/sda2' \
>        -display gtk,gl=3Don \
>        -chardev socket,id=3Dmouse2,path=3D/tmp/mouse.sock -device vhost-u=
ser-input-pci,chardev=3Dmouse2
>
> I even double checked with the generic device I was working with:
>
>        -chardev socket,id=3Dmouse2,path=3D/tmp/mouse.sock -device
> vhost-user-device-pci,chardev=3Dmouse2,virtio-id=3D18,config_size=3D136,n=
um_vqs=3D2

Ahh but not the magic:

  -numa node,memdev=3Dmem

>
>> We should probably add some error at QEMU level when vhost-user devices
>> are used without shared memory!
>
> That would certainly be a good idea.

Where would the best place to do this check be?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

