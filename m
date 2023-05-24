Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B7870F9B8
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 17:04:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1q2J-0000kf-Sz; Wed, 24 May 2023 11:04:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1q2G-0000hi-9j
 for qemu-devel@nongnu.org; Wed, 24 May 2023 11:04:20 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1q2B-0007yq-VL
 for qemu-devel@nongnu.org; Wed, 24 May 2023 11:04:20 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-307d58b3efbso695606f8f.0
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 08:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684940654; x=1687532654;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CI83zH0C0bABgoGhwUWm8OnfyA/jE6wxGzjvYow+xeE=;
 b=xEj3yzWcxOH/A/nG8dG89BvTQFwHHSSj21yjWWMeAbrksdDQ53WxcpTtpB+Yt9Suf0
 OSfRQc+Gj/G3rQ+7bg7TojE52pKWxvrsPTv0IReOq8Ky9gWz8JtPjOcDf9+nZpoU3t+t
 RlJx3aibuMuPoExzCdrdQf1lMvbd4+WbB6XbwvyK8MpX5U5+he+U2ZpscTCWaaBMjhrp
 PZ9TcPRzBF5e3HVcGt+9BZLBt7WnpfJugsFMyIw/GW4k1DUk9mTPFkrAA4Y0uj3kQvaH
 ODJurGJto0yVbByndXHAGdOFf1JVlmrGd9a7RnVtoLEkglQ1dx12cMjPwED3twTv/uqq
 sEqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684940654; x=1687532654;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=CI83zH0C0bABgoGhwUWm8OnfyA/jE6wxGzjvYow+xeE=;
 b=fpMnNfoY+DLC1epAL2StKTTwpi3gznKwTWkeKT0CqBDv384U110WAV/s/yi99+xHD2
 D7Nrg1An5WN+6uDwEUEgz+dpBeGbmev7lhPsLj27hK89RMSEIwiHMouVlVDYrTaFsIbg
 DbMkZmpI66e25jbOK1kV6+SBpkgHrphdHkhwUTLIUTmuDlMYQt0ynvm7fnppThu04vRF
 zLdxl/tATwJGWREku0Ix7MsUI77e06/LibPkjqUpzS5qHARBNkIfgnRKZzVLpqJoZpc9
 Iumat3eAPWFgtsBSSYT21Nwr63WKOAvu1eJrd3cpbuaKKQbTM9bw0QkoakeQjcWRqfSi
 InFA==
X-Gm-Message-State: AC+VfDw9+KuW7UT77q7pzGBgktQV0lgjlGeZo7G5jCsdxjEK6opKf9UM
 e79k+mnzxrD3TXDmCdHwFbV+Qg==
X-Google-Smtp-Source: ACHHUZ65PgyKRbkZNgneuExUdMkUbDOVvyeQAG/Ehhi+p4XnhGL38VLCtgfx1/ALpFma+Un1y3puiw==
X-Received: by 2002:adf:df09:0:b0:307:c0c4:109a with SMTP id
 y9-20020adfdf09000000b00307c0c4109amr84509wrl.6.1684940654313; 
 Wed, 24 May 2023 08:04:14 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 o10-20020a1c750a000000b003f423dfc686sm2583212wmc.45.2023.05.24.08.04.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 May 2023 08:04:14 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 940481FFBB;
 Wed, 24 May 2023 16:04:13 +0100 (BST)
References: <20230524093744.88442-1-philmd@linaro.org>
 <20230524093744.88442-8-philmd@linaro.org>
User-agent: mu4e 1.11.6; emacs 29.0.91
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Eric Farman <farman@linux.ibm.com>, Peter
 Xu <peterx@redhat.com>, Hanna Reitz <hreitz@redhat.com>, Christian
 Borntraeger <borntraeger@linux.ibm.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Raphael Norwitz <raphael.norwitz@nutanix.com>, Ilya
 Leoshkevich <iii@linux.ibm.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eric Auger <eric.auger@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>, David Hildenbrand
 <david@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Halil Pasic
 <pasic@linux.ibm.com>, qemu-block@nongnu.org, Kevin Wolf
 <kwolf@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 07/10] hw/virtio/vhost-vsock: Include missing
 'virtio/virtio-bus.h' header
Date: Wed, 24 May 2023 16:04:06 +0100
In-reply-to: <20230524093744.88442-8-philmd@linaro.org>
Message-ID: <87ttw1vkia.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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


Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> Instead of having "virtio/virtio-bus.h" implicitly included,
> explicitly include it, to avoid when rearranging headers:
>
>   hw/virtio/vhost-vsock-common.c: In function =E2=80=98vhost_vsock_common=
_start=E2=80=99:
>   hw/virtio/vhost-vsock-common.c:51:5: error: unknown type name =E2=80=98=
VirtioBusClass=E2=80=99; did you mean =E2=80=98VirtioDeviceClass=E2=80=99?
>      51 |     VirtioBusClass *k =3D VIRTIO_BUS_GET_CLASS(qbus);
>         |     ^~~~~~~~~~~~~~
>         |     VirtioDeviceClass
>   hw/virtio/vhost-vsock-common.c:51:25: error: implicit declaration of
> function =E2=80=98VIRTIO_BUS_GET_CLASS=E2=80=99; did you mean =E2=80=98VI=
RTIO_DEVICE_CLASS=E2=80=99?
> [-Werror=3Dimplicit-function-declaration]
>      51 |     VirtioBusClass *k =3D VIRTIO_BUS_GET_CLASS(qbus);
>         |                         ^~~~~~~~~~~~~~~~~~~~
>         |                         VIRTIO_DEVICE_CLASS
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  hw/virtio/vhost-vsock-common.c | 1 +
>  1 file changed, 1 insertion(+)
--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

