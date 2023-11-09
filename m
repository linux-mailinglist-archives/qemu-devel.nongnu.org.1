Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 597927E6C77
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 15:33:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1660-0001md-Aw; Thu, 09 Nov 2023 09:33:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r165w-0001ly-3X
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 09:33:20 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r165u-0005tg-F2
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 09:33:19 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-53e3b8f906fso1442723a12.2
 for <qemu-devel@nongnu.org>; Thu, 09 Nov 2023 06:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699540397; x=1700145197; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p/p9yeW43NcSMER0YQpwehxYcbDOe/wAYZ9SJZyRksQ=;
 b=GOki4Bpe4BVP3UJohSOc7vkFwCatL4phEexHe8ffmSP9SSJQNgTI+EmfJopJKR/xfu
 gzwlHXv7YU8IvIYSHE0GKJwPzIOAyTwsJDqVOVOZV2WJKAGYPRIz48K/MHZWQz5NmQWy
 V507KUArwuV9CFl5jNN9vmoVywlhey9v4sZqfhMEYnb1p+tdDUtpdPu8Xwx+CxAYwBc3
 gcyAdpjlNaGZdcNtfK/c6LY1QTGEO/gI5OsQEMT96G9JqI8OlIkT56qAkYPOfNQ06DQu
 3nqM59u8LWEXCOQ1/jOEC49/r70r83pOmaAT8Teqg7wCrdojcSFBfdSth1VenNyJQkpi
 +Oiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699540397; x=1700145197;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p/p9yeW43NcSMER0YQpwehxYcbDOe/wAYZ9SJZyRksQ=;
 b=vjabPceuZYt1NLlkiyPkD2mi31R1cLskSs8DSLnnSBYR3GefKnfb9I8vbg7sS8Kfqe
 pY4p4JfLCb1cgMulcbofmbtj8MXvz4W0OHn0uT8Odynewe6I7IHTUjZ/04mRWknMCzL5
 R/2Qyj/QYjLb4DmXorOdnp7F2QdECm/CHsM3V6w6MrKrijnyoJhwxFx2Z5mExqnpaU9F
 iiThbV9+tsqVnVmZQJYxZppRFU7ScgbSLB+mk3fz1+xJU+pX0PECLu8t62UbafVs645c
 4QIjfGsqeosjEtD8/UR5oU4C4lo5agX+vaxPsBN8MZZSkefSR2cyXssa5grQa6VDNgOL
 FSiA==
X-Gm-Message-State: AOJu0YxamF4CWM1YvLWDsc2hDtofsUiG8XgAc03N38Yz0zY3tgcEOzPp
 4LljA0Cn8WCmt8hJQ0/DE8fntalAk62qJ00EhxtVuQ==
X-Google-Smtp-Source: AGHT+IG357JpQyVxWaJjqbV8YiVbKX+wpl5yjOXXCxYoMHlCTyZk6gVT3AeKgF8otnbJuRZg7j8Xbtz/KkJPUM7pYnw=
X-Received: by 2002:a17:907:a0b:b0:9e2:8206:2ea9 with SMTP id
 bb11-20020a1709070a0b00b009e282062ea9mr3873060ejc.60.1699540396832; Thu, 09
 Nov 2023 06:33:16 -0800 (PST)
MIME-Version: 1.0
References: <20231107092149.404842-1-dwmw2@infradead.org>
 <20231107092149.404842-7-dwmw2@infradead.org>
In-Reply-To: <20231107092149.404842-7-dwmw2@infradead.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 Nov 2023 14:33:06 +0000
Message-ID: <CAFEAcA8McSqwXyAg1+9_DOjy5PU==FRja_gjkdXAAqjr7QtLQA@mail.gmail.com>
Subject: Re: [PULL 06/15] hw/xen: automatically assign device index to block
 devices
To: David Woodhouse <dwmw2@infradead.org>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, 
 Jason Wang <jasowang@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 qemu-block@nongnu.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
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

On Tue, 7 Nov 2023 at 09:24, David Woodhouse <dwmw2@infradead.org> wrote:
>
> From: David Woodhouse <dwmw@amazon.co.uk>
>
> There's no need to force the user to assign a vdev. We can automatically
> assign one, starting at xvda and searching until we find the first disk
> name that's unused.
>
> This means we can now allow '-drive if=3Dxen,file=3Dxxx' to work without =
an
> explicit separate -driver argument, just like if=3Dvirtio.
>
> Rip out the legacy handling from the xenpv machine, which was scribbling
> over any disks configured by the toolstack, and didn't work with anything
> but raw images.

Hi; Coverity points out an issue in this code (CID 1523906):

> +/*
> + * Find a free device name in the xvda =E2=86=92 xvdfan range and set it=
 in
> + * blockdev->props.vdev. Our definition of "free" is that there must
> + * be no other disk or partition with the same disk number.
> + *
> + * You are technically permitted to have all of hda, hda1, sda, sda1,
> + * xvda and xvda1 as *separate* PV block devices with separate backing
> + * stores. That doesn't make it a good idea. This code will skip xvda
> + * if *any* of those "conflicting" devices already exists.
> + *
> + * The limit of xvdfan (disk 4095) is fairly arbitrary just to avoid a
> + * stupidly sized bitmap, but Linux as of v6.6 doesn't support anything
> + * higher than that anyway.
> + */
> +static bool xen_block_find_free_vdev(XenBlockDevice *blockdev, Error **e=
rrp)
> +{
> +    XenBus *xenbus =3D XEN_BUS(qdev_get_parent_bus(DEVICE(blockdev)));
> +    unsigned long used_devs[BITS_TO_LONGS(MAX_AUTO_VDEV)];
> +    XenBlockVdev *vdev =3D &blockdev->props.vdev;
> +    char fe_path[XENSTORE_ABS_PATH_MAX + 1];
> +    char **existing_frontends;
> +    unsigned int nr_existing =3D 0;
> +    unsigned int vdev_nr;
> +    int i, disk =3D 0;
> +
> +    snprintf(fe_path, sizeof(fe_path), "/local/domain/%u/device/vbd",
> +             blockdev->xendev.frontend_id);
> +
> +    existing_frontends =3D qemu_xen_xs_directory(xenbus->xsh, XBT_NULL, =
fe_path,
> +                                               &nr_existing);
> +    if (!existing_frontends && errno !=3D ENOENT) {

Here we check whether existing_frontends is NULL, implying it
might be NULL (and the && in the condition means we might not
take this error-exit path even if it is NULL)...

> +        error_setg_errno(errp, errno, "cannot read %s", fe_path);
> +        return false;
> +    }
> +
> +    memset(used_devs, 0, sizeof(used_devs));
> +    for (i =3D 0; i < nr_existing; i++) {
> +        if (qemu_strtoui(existing_frontends[i], NULL, 10, &vdev_nr)) {

...but here we deref existing_frontends, implying it can't be NULL.

> +            free(existing_frontends[i]);
> +            continue;
> +        }
> +
> +        free(existing_frontends[i]);
> +
> +        disk =3D vdev_to_diskno(vdev_nr);
> +        if (disk < 0 || disk >=3D MAX_AUTO_VDEV) {
> +            continue;
> +        }
> +
> +        set_bit(disk, used_devs);
> +    }
> +    free(existing_frontends);

thanks
-- PMM

