Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F3B787749
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 19:50:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZET1-0008F9-3x; Thu, 24 Aug 2023 13:49:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qZESw-0008Eg-1z
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 13:49:56 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qZESt-0004eU-TL
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 13:49:53 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3fef56f7248so631105e9.3
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 10:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692899390; x=1693504190;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GgEZLN7fsIo+eZ32f3WuXFjDhUa7ezAM7bqTPIlScgA=;
 b=sFcQ/D4sP6kGFWg0kbCFdwtBHbQ9uZ57N1p15kyW93228/1ifiMuCkD9mbbbz/PcuP
 J+PAhcO1wL0YplyV63ykeY9n+BjI2R2M33EvYFt/rHcmDYDu4JJz3qnYLbn/BOe5SOHZ
 2Mms4qV/qH6CUtSjh9GHxWlDoK6mcAE8IR9DkpnB97bAsqHKAlGNiTPNM131goa7SOoO
 XiTaglgzauPn/vpauBwuLXxhF2cx/SSZ/hobpzir7z3qykr9e1pBQ5lk6GUlcTX9hBc1
 wY1fAY9EduyIhZm1SNGq/Y8uYGy4ZXPhifgAsK3KzGnQg+utkpOGICApP0AFVVRFAADX
 uLpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692899390; x=1693504190;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=GgEZLN7fsIo+eZ32f3WuXFjDhUa7ezAM7bqTPIlScgA=;
 b=UFFWmDRxYtyvDErHThUa4bm8cCdwtIn5pv0O8QDWlRjtNb2J4+tFIs6FDvrxnPYiS7
 5ofaiHcJv7Tw430pvPdOkBCBJsrgTXJ4b0u/rwoWNbOD5nmJofxVHSGhnPQ8l4kBeavE
 zu1nDAtPa+b/3bYkOyad4e01We0HPdfSy2ivbEZiD/mg+q5gPscbQeoHwfx67nsTYRAh
 Ll/p/kNpCI0BjOkEjDXn7p8U1PjzyAvjOshpZyDLni9dKTBeOhZL8HIAYwGSXKJR2BRq
 cEDakBf3Cl46lHHNnRHgQJGyca71kZGgQFgZfsPOk+1xrGIGJPqPjZMRwHJHkom7abdj
 jEag==
X-Gm-Message-State: AOJu0Yz6yq3u1A3OWRsWNHhC/kNyh2WyExx4bvEU7O8yWvLKZ9n2Ia5t
 ibmlGA5KiZ3gTDveh8I4IvmKzg==
X-Google-Smtp-Source: AGHT+IHcrT5s8sAEGnX003Dy6GXwBN98RaUZ/LcGDUtcwGd37vkSmxHQRg/B3BHZveUEL4RbxCwr8w==
X-Received: by 2002:a05:600c:2297:b0:401:4417:a82d with SMTP id
 23-20020a05600c229700b004014417a82dmr2164069wmf.38.1692899389755; 
 Thu, 24 Aug 2023 10:49:49 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 f23-20020a7bc8d7000000b003fbc9d178a8sm3212141wml.4.2023.08.24.10.49.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 10:49:49 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id BBB5C1FFBB;
 Thu, 24 Aug 2023 18:49:48 +0100 (BST)
References: <cover.1692731646.git.manos.pitsidianakis@linaro.org>
 <a32cf5571be51df67ac759be37f269b459e6ab05.1692731646.git.manos.pitsidianakis@linaro.org>
User-agent: mu4e 1.11.14; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org, Emmanouil Pitsidianakis
 <manos.pitsidianakis@linaro.org>
Cc: Igor Skalkin <Igor.Skalkin@opensynergy.com>, Anton Yakovlev
 <Anton.Yakovlev@opensynergy.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, =?utf-8?Q?Daniel_P=2E_Berr?=
 =?utf-8?Q?ang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, =?utf-8?Q?M?=
 =?utf-8?Q?arc-Andr=C3=A9?=
 Lureau <marcandre.lureau@redhat.com>, Volker =?utf-8?Q?R=C3=BCmelin?=
 <vr_qemu@t-online.de>, =?utf-8?B?S8WRdsOhZ8OzLCBab2x0w6Fu?=
 <DirtY.iCE.hu@gmail.com>, Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v7 02/12] Add virtio-sound-pci device
Date: Thu, 24 Aug 2023 18:48:45 +0100
In-reply-to: <a32cf5571be51df67ac759be37f269b459e6ab05.1692731646.git.manos.pitsidianakis@linaro.org>
Message-ID: <87jztkfhz7.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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

> This patch adds a PCI wrapper device for the virtio-sound device.
> It is necessary to instantiate a virtio-snd device in a guest.
> All sound logic will be added to the virtio-snd device in the following
> commits.
>
> To add this device with a guest, you'll need a >=3D5.13 kernel compiled
> with CONFIG_SND_VIRTIO=3Dy, which at the time of writing most distros have
> off by default.
>
> Use with following flags in the invocation:
>
> Pulseaudio:
>   -audio driver=3Dpa,model=3Dvirtio
>   or
>   -audio driver=3Dpa,model=3Dvirtio,server=3D/run/user/1000/pulse/native
> sdl:
>   -audio driver=3Dsdl,model=3Dvirtio
> coreaudio (macos/darwin):
>   -audio driver=3Dcoreaudio,model=3Dvirtio
> etc.
>
> Signed-off-by: Emmanouil Pitsidianakis
> <manos.pitsidianakis@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

<snip>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

