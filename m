Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 667507EAD73
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 10:55:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2q8R-00025e-9r; Tue, 14 Nov 2023 04:55:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1r2q8P-00025V-Bw
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 04:55:05 -0500
Received: from mail-qt1-x82b.google.com ([2607:f8b0:4864:20::82b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1r2q8N-0002JS-E5
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 04:55:05 -0500
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-41cd444d9d0so31552721cf.2
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 01:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699955702; x=1700560502; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=26pUyhgwWDfV9d3ORUC9ulIef5AmKbOAKF5qSHVwYJQ=;
 b=Ac/pTtnTFCF6yHYIPzORDfOCKE2nE43zwwrL13xEnZ2QjEso0eZck0KFHHGJvzUGdJ
 uDene8eui37ZAWmvFDuaHZs3L4hwdKaXFwL4RIAjG/am8f7TP8gupyfnx53ap4EIGjx+
 WAmtH3hMcaLGZAAVI2z0eSo8ZvIS2AZrYFmuGj3wU4SaleRB3Rf/bbuowv+7KNyMCkoO
 boYyeRnpctvcSR4zi2Sq5FHj1p9fM7ATDnpGUKcYEks9GSfNtiBtDwTZxCWa9rTocsLJ
 9K5NNUMTHCvSmqSLoSl/oN1enct6hmqkn8RL5AYgVzXWWkmgy5Qs9PMpTfO4NghQ8RP4
 q+dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699955702; x=1700560502;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=26pUyhgwWDfV9d3ORUC9ulIef5AmKbOAKF5qSHVwYJQ=;
 b=CoJc5zR+42pbKuCGr96CwrlUj9I/CQy2n8U/EPTSo19cmpcUGYxbNT9C4zzO6S4rJz
 S6xKh6bnQVhmFLnhzpbXAFGvc8nGs/BSKfPV357q7Pa4cmII5PsJJpEh9nYG9DD8GoJr
 uFEbVSKVxenG3FWZiixr3Ap2C086j6znhJ8sb1NjNIF/MrPh8g+5SSGTGIXXOBpRRVeT
 4AoniLClQYfyu4NtAbzkNm46CGp9K0KZgkywivNil7CO6hdtTGUplSaiM0OG7F7Tx7dW
 dD3JVYc7tvKNIsnZW7XsNFCBQ5VaQ/uvr7EmVhRnM3MbMtZlYUZKjEoYUaoEVAhJtU02
 v6rQ==
X-Gm-Message-State: AOJu0Yzgy8U8gFv0Glvq7scOXD2edJG6JsqTlGrn2MQRQl/S5LrmPNiB
 nW/rQEE1MAxuKrK8M1B6/3XBfepJ+jXg6hEitZk=
X-Google-Smtp-Source: AGHT+IE/67/2M6d9plTXIi+fpuoCYJsbAyQEXOIthjVUeu65/NZSJOGe77QErCBpEXUxlrgRZRt0hP5IUnS3NzQE9xU=
X-Received: by 2002:ac8:4e85:0:b0:41c:d0b5:c605 with SMTP id
 5-20020ac84e85000000b0041cd0b5c605mr1901168qtp.22.1699955702095; Tue, 14 Nov
 2023 01:55:02 -0800 (PST)
MIME-Version: 1.0
References: <20231113190211.92412-1-leo.yan@linaro.org>
 <20231113190211.92412-3-leo.yan@linaro.org>
In-Reply-To: <20231113190211.92412-3-leo.yan@linaro.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 14 Nov 2023 13:54:50 +0400
Message-ID: <CAJ+F1CJTGWoV2kvzcxMsp6wE-6d_c2OxQfVQ+025DxK3kK3EPA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] docs/system: Add vhost-user-input documentation
To: Leo Yan <leo.yan@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82b;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi

On Mon, Nov 13, 2023 at 11:04=E2=80=AFPM Leo Yan <leo.yan@linaro.org> wrote=
:
>
> This adds basic documentation for vhost-user-input.
>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  MAINTAINERS                              |  1 +
>  docs/system/devices/vhost-user-input.rst | 44 ++++++++++++++++++++++++
>  docs/system/devices/vhost-user.rst       |  2 +-
>  3 files changed, 46 insertions(+), 1 deletion(-)
>  create mode 100644 docs/system/devices/vhost-user-input.rst
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 86c649784e..ef72c6d512 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2233,6 +2233,7 @@ L: virtio-fs@redhat.com
>  virtio-input
>  M: Gerd Hoffmann <kraxel@redhat.com>
>  S: Odd Fixes
> +F: docs/system/devices/vhost-user-input.rst
>  F: hw/input/vhost-user-input.c
>  F: hw/input/virtio-input*.c
>  F: include/hw/virtio/virtio-input.h
> diff --git a/docs/system/devices/vhost-user-input.rst b/docs/system/devic=
es/vhost-user-input.rst

You need to include the file in the toctree, in docs/system/device-emulatio=
n.rst

> new file mode 100644
> index 0000000000..4ff9dd4b27
> --- /dev/null
> +++ b/docs/system/devices/vhost-user-input.rst
> @@ -0,0 +1,44 @@
> +.. _vhost_user_input:
> +
> +QEMU vhost-user-input - Input emulation
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +This document describes the setup and usage of the Virtio input device.
> +The Virtio input device is a paravirtualized device for input events.
> +
> +Description
> +-----------
> +
> +The vhost-user-input device implementation was designed to work with a d=
aemon
> +polling on input devices and passes input events to the guest.
> +
> +QEMU provides a backend implementation in contrib/vhost-user-input.
> +
> +Linux kernel support
> +--------------------
> +
> +Virtio input requires a guest Linux kernel built with the
> +``CONFIG_VIRTIO_INPUT`` option.
> +
> +Examples
> +--------
> +
> +The backend daemon should be started first:
> +
> +::
> +
> +  host# vhost-user-input --socket-path=3Dinput.sock      \
> +      --evdev-path=3D/dev/input/event17
> +
> +The QEMU invocation needs to create a chardev socket to communicate with=
 the
> +backend daemon and share memory with the guest over a memfd.
> +
> +::
> +
> +  host# qemu-system                                                     =
       \
> +      -chardev socket,path=3D/tmp/input.sock,id=3Dmouse0                =
           \
> +      -device vhost-user-input-pci,chardev=3Dmouse0                     =
         \
> +      -m 4096                                                           =
       \
> +      -object memory-backend-file,id=3Dmem,size=3D4G,mem-path=3D/dev/shm=
,share=3Don    \
> +      -numa node,memdev=3Dmem


Well, this is not a memfd. This is taken from vhost-user-rng.rst, and
should probably be adjusted there too.

It needs shared memory, memory-backend-file can provide it and is
generally more available than memfd, although memfd should be
preferred as it offers some extra security guarantees. There is
already some explanations in vhost-user.rst, maybe we should just add
extra links.

> +      ...
> diff --git a/docs/system/devices/vhost-user.rst b/docs/system/devices/vho=
st-user.rst
> index c6afc4836f..75b40f08c6 100644
> --- a/docs/system/devices/vhost-user.rst
> +++ b/docs/system/devices/vhost-user.rst
> @@ -42,7 +42,7 @@ platform details for what sort of virtio bus to use.
>      - See https://github.com/rust-vmm/vhost-device
>    * - vhost-user-input
>      - Generic input driver
> -    - See contrib/vhost-user-input
> +    - :ref:`vhost_user_input`
>    * - vhost-user-rng
>      - Entropy driver
>      - :ref:`vhost_user_rng`
> --
> 2.34.1
>
>


--=20
Marc-Andr=C3=A9 Lureau

