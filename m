Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A5A73FB22
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 13:31:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE6tm-00028T-IC; Tue, 27 Jun 2023 07:30:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qE6tk-00028A-5M
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 07:30:16 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qE6ti-0008OB-EN
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 07:30:15 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2b6a5fd1f46so25143041fa.1
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 04:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687865412; x=1690457412;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sqUzKr1ko1evPEzZPV3C25X3jPFar6TzejIIDDS8NBo=;
 b=fPWLfGjZzHvKfrRZcmQDH3BmBddetX21pXGFmXRFCAYkR8GqWvd7cUreaKOrl8bpCY
 4kcdAcaFf25nZg+qXFxRbl/Ut8g+J1+pGlXuge6pCizQNg9FhLVh22g5TZD9ys+ksU1Y
 Fqg4ayvSS5XhF4IsYFPJ84ROKzXM6kEWrC5P7GxsyERClctfc7D9XuUG5j2YT+ZC4kuA
 aYX/M/35E1oecfEj+NeB9yRfAi0ZIEP+ROMFR4dRdOyFk9/OAODrvQkhJHXSKXXeRRdp
 JzD7YULQdwy4o3XqARWf43PFWV63H/6COYybTrZGShiXv7By3+Rf58fWZ9bzqHpvuFfO
 oDYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687865412; x=1690457412;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sqUzKr1ko1evPEzZPV3C25X3jPFar6TzejIIDDS8NBo=;
 b=cup8mabIG+M/wd1j6geGgmLs2WQUQfY2C4gjcEMGSvzIMaEiH00jYgxmM9nUxIfb9W
 b6yG9ffEOHBL5/ujguE4vHB7PXYsHqxchrtHpwHG2NYRyYtQI4O4cafGMbe6xo/71Wr5
 HtDTT+2+8Ge9Oetyaif/mqxHZvZhDmJ9qm67U4LMC/YnolwtgyToKPVaAqjxgmMDgOOB
 7jrmE62YMx3xuArgmDmVfIE6xs9qMByi/yK+cAI4kzPjLvuBUOSjYvldFAfUV8+elXX6
 +a2rAguxxNLJwX8IayprNRg/SRIFYOy3A2bopyEbHNVgmZk/W4hXs5wshN+lA5D63h4J
 LGlg==
X-Gm-Message-State: AC+VfDzlxfK+hDMaQs/RxPKoRY0lJhU8YH0/TwV9djIjPxRvH7FAAyfl
 arliVCZ26dVTLKGPWxqxb05GQxqIMcUpDdCKPcW12Q==
X-Google-Smtp-Source: ACHHUZ4XRQ6JeZcCxhK1ZXgeBn5QwZVWBpTpwH3EvfzVEPCngiDq5ranoHeKLKHXShPwag9BJRcMtKYr1qASKmvt6G8=
X-Received: by 2002:a2e:94d0:0:b0:2b4:7f66:8c89 with SMTP id
 r16-20020a2e94d0000000b002b47f668c89mr18320369ljh.38.1687865412054; Tue, 27
 Jun 2023 04:30:12 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1687782442.git.mst@redhat.com>
 <152128d646973ed298d41dafd7a5bccff43336c8.1687782442.git.mst@redhat.com>
In-Reply-To: <152128d646973ed298d41dafd7a5bccff43336c8.1687782442.git.mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Jun 2023 12:30:01 +0100
Message-ID: <CAFEAcA8mNRZL2hQoRxtz1rKqbNS4srbSXY-paBQjPqbEXXE0SQ@mail.gmail.com>
Subject: Re: [PULL 28/53] vdpa: move CVQ isolation check to net_init_vhost_vdpa
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Lei Yang <leiyang@redhat.com>, Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Mon, 26 Jun 2023 at 13:29, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> From: Eugenio P=C3=A9rez <eperezma@redhat.com>
>
> Evaluating it at start time instead of initialization time may make the
> guest capable of dynamically adding or removing migration blockers.
>
> Also, moving to initialization reduces the number of ioctls in the
> migration, reducing failure possibilities.
>
> As a drawback we need to check for CVQ isolation twice: one time with no
> MQ negotiated and another one acking it, as long as the device supports
> it.  This is because Vring ASID / group management is based on vq
> indexes, but we don't know the index of CVQ before negotiating MQ.

I was looking at this code because of a Coverity report.
That turned out to be a false positive, but I did notice
something here that looks like it might be wrong:

>
> +/**
> + * Probe if CVQ is isolated
> + *
> + * @device_fd         The vdpa device fd
> + * @features          Features offered by the device.
> + * @cvq_index         The control vq pair index
> + *
> + * Returns <0 in case of failure, 0 if false and 1 if true.
> + */
> +static int vhost_vdpa_probe_cvq_isolation(int device_fd, uint64_t featur=
es,
> +                                          int cvq_index, Error **errp)
> +{
> +    uint64_t backend_features;
> +    int64_t cvq_group;
> +    uint8_t status =3D VIRTIO_CONFIG_S_ACKNOWLEDGE |
> +                     VIRTIO_CONFIG_S_DRIVER |
> +                     VIRTIO_CONFIG_S_FEATURES_OK;
> +    int r;
> +
> +    ERRP_GUARD();
> +
> +    r =3D ioctl(device_fd, VHOST_GET_BACKEND_FEATURES, &backend_features=
);
> +    if (unlikely(r < 0)) {
> +        error_setg_errno(errp, errno, "Cannot get vdpa backend_features"=
);
> +        return r;
> +    }
> +
> +    if (!(backend_features & BIT_ULL(VHOST_BACKEND_F_IOTLB_ASID))) {
> +        return 0;
> +    }
> +
> +    r =3D ioctl(device_fd, VHOST_SET_FEATURES, &features);
> +    if (unlikely(r)) {
> +        error_setg_errno(errp, errno, "Cannot set features");

Shouldn't we have a 'return r' (or maybe a 'goto out') here ?
Otherwise we'll just plough onward and attempt to continue
execution...

> +    }
> +
> +    r =3D ioctl(device_fd, VHOST_VDPA_SET_STATUS, &status);
> +    if (unlikely(r)) {
> +        error_setg_errno(errp, -r, "Cannot set device features");

Isn't this trying to set device status, not features ?

> +        goto out;
> +    }

thanks
-- PMM

