Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 399CC73B860
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 15:06:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCgT6-0007SJ-6R; Fri, 23 Jun 2023 09:04:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qCgT4-0007SA-N3
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 09:04:50 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qCgT3-0007xe-0T
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 09:04:50 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-4f871c93a5fso736709e87.2
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 06:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687525486; x=1690117486;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m+Wk4PulGMyQglaBGyS5VThwTIN442ioBIvyNpWgCA4=;
 b=Tm/1dKLQ/KVG0pI6+9reRS+ivctq0khOn5B1TYFvBZRMsJemiNTXRhAryhDlU6SudM
 KIbgD21fgHwgaD1kDU6AiwgMbRtItUx3ZZPz7e8qUq9akMfHaE35pPKN40a0h/NHZ0eh
 GOMgJAHkv8qQ+x6ANRlKZ+j0uSzHVmsV9xpQU3F4u0YaVjIrl7FGSiX0t6CbaC8xZPRX
 ztisnR/F+qtM0X7zdQTQ67nA8sT+xqONCLLKOmxKJ6dpMEOmx819ilF/pSzVdglMx6bA
 Z0beb87K3jZjp8XoZTuNJ1hSHeN0e5KLLpP3y9zTmzDIqETRAxrKyqfOSp7GE5UIqrG+
 P57A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687525486; x=1690117486;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m+Wk4PulGMyQglaBGyS5VThwTIN442ioBIvyNpWgCA4=;
 b=XcQFsb2xrgNe8WDlcCgBxPy2tI0rBP+j63lbDqWx1QsMu1AeEXjRCtJJ8RoN+04fsJ
 1c9A/uMhbW/8Ek52/5JU/6XSO2o1tw2bJO6Kpdb+zyI0r3dkcV4Dy51dBhL67vX9SAtE
 rNEgC01eQiFSq7E4NunecUjm3C07q2h3SwEd9U56prlzIPfkmw7PLMwGXDr3Cl1jg0fN
 TpdcRmzgF8GwLLWZl5edrpEc6dY6GjVXjo2ZrXBeqGuhrQMWvhBnd6u4ogW8x5NhaPW3
 G/vTq69mQoyGR/MkBqEyZLgUREqYxSva3r8z4rRasCapg1/v3+syhVc7XOn7+2dmaJY9
 jsCg==
X-Gm-Message-State: AC+VfDy1fPF7PEBGIUTE/AFKQ9a00HoGMdFoOmdPSg8w3tFyme2M933w
 kglBGmcQ7c73O3cFyJ215jaJxfd/TSGMpMpEAiJrTQ==
X-Google-Smtp-Source: ACHHUZ58lGY/f18w3z18v/IZIURac84YC4gvK+ailZOVwmCtpyvggZri24V8Q7+LfkZPA003mWi+kq0koTMf6cch+To=
X-Received: by 2002:a05:6512:3a8d:b0:4f9:5c6a:d4d9 with SMTP id
 q13-20020a0565123a8d00b004f95c6ad4d9mr6416340lfu.38.1687525486538; Fri, 23
 Jun 2023 06:04:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230526153143.470745-1-eperezma@redhat.com>
In-Reply-To: <20230526153143.470745-1-eperezma@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Jun 2023 14:04:35 +0100
Message-ID: <CAFEAcA_7C7jD5x+eT6XbheMYAESVy-VNn2RXxg4pBW9c7PN=tA@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] Move ASID test to vhost-vdpa net initialization
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, Parav Pandit <parav@mellanox.com>, 
 "Gonglei (Arei)" <arei.gonglei@huawei.com>, longpeng2@huawei.com, 
 Shannon Nelson <snelson@pensando.io>, Laurent Vivier <lvivier@redhat.com>,
 si-wei.liu@oracle.com, 
 Cindy Lu <lulu@redhat.com>, Lei Yang <leiyang@redhat.com>, 
 Harpreet Singh Anand <hanand@xilinx.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Gautam Dawar <gdawar@xilinx.com>, 
 Jason Wang <jasowang@redhat.com>, Liuxiangdong <liuxiangdong5@huawei.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, alvaro.karsz@solid-run.com, 
 Zhu Lingshan <lingshan.zhu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x130.google.com
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

On Fri, 26 May 2023 at 16:32, Eugenio P=C3=A9rez <eperezma@redhat.com> wrot=
e:
>
> QEMU v8.0 is able to switch dynamically between vhost-vdpa passthrough
> and SVQ mode as long as the net device does not have CVQ.  The net device
> state followed (and migrated) by CVQ requires special care.
>
> A pre-requisite to add CVQ to that framework is to determine if devices w=
ith
> CVQ are migratable or not at initialization time.  The solution to it is =
to
> always shadow only CVQ, and vq groups and ASID are used for that.
>
> However, current qemu version only checks ASID at device start (as "drive=
r set
> DRIVER_OK status bit"), not at device initialization.  A check at
> initialization time is required.  Otherwise, the guest would be able to s=
et
> and remove migration blockers at will [1].
>
> This series is a requisite for migration of vhost-vdpa net devices with C=
VQ.
> However it already makes sense by its own, as it reduces the number of io=
ctls
> at migration time, decreasing the error paths there.

Hi -- since you're working on the net_init_vhost_vdpa() code,
would you mind having a look at Coverity CID 1490785 ?
This is about a leak of the vdpa_device_fd. We fixed one
instance of that leak in commit aed5da45daf734ddc54 but
it looks like there's still a different leak:

    for (i =3D 0; i < queue_pairs; i++) {
        ncs[i] =3D net_vhost_vdpa_init(peer, TYPE_VHOST_VDPA, name,
                                     vdpa_device_fd, i, 2, true, opts->x_sv=
q,
                                     iova_range, features);
        if (!ncs[i])
            goto err;
    }

    if (has_cvq) {
        nc =3D net_vhost_vdpa_init(peer, TYPE_VHOST_VDPA, name,
                                 vdpa_device_fd, i, 1, false,
                                 opts->x_svq, iova_range, features);
        if (!nc)
            goto err;
    }

    return 0;

In this code, if queue_pairs is non-zero we will use
vdpa_device_fd because we pass it to net_vhost_vdpa_init().
Similarly, if has_cvq is true then we'll also use the fd.
But if queue_pairs is zero and has_cvq is false then we
will not do anything with the fd, and will return 0,
leaking the file descriptor.

Maybe this combination is not supposed to happen, but
I can't see anything in vhost_vdpa_get_max_queue_pairs()
or in this function which guards against it. If it's
an invalid setup we should detect it and return an
error, I think.

thanks
-- PMM

