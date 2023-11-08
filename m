Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7447E4ED6
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 03:26:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0YG0-0000EW-1S; Tue, 07 Nov 2023 21:25:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1r0YFx-0000EL-GX
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 21:25:25 -0500
Received: from mail-oo1-xc2c.google.com ([2607:f8b0:4864:20::c2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1r0YFv-00048M-K1
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 21:25:25 -0500
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-586753b0ab0so3405575eaf.0
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 18:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699410322; x=1700015122; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OMKgWNI3AUg8dI3HBKXgtOgVRpM0GUrrIqCVzw2t3aE=;
 b=IQzP0ysQUCyvr+iQAps3kKgmyp1cABkf6cwbmoYea6Xopi6DgD1Xikt6GLNmwZ8MAc
 Sxqd2fHMu+QyaiS++pZnpwoYEMcPXeN6mLf8UIxX/DNzmJ9Cgzk9s6+JHnH8L2Wlw3d2
 eg1un/ijbPIN9bnAuEU9IuvrPInKo7Q/uy6jnGLKjq2ua7vvztCl5WDoFy8hQhtO6o4i
 +nnZSjhfdo+5hpga+IMcJ7VZTIVZ0eI4pm34E2zG5DeCx/93/JqLhTIjVmfoTAeOOvfZ
 +kTEFCEnzOp3Pf1uyMb5EA3497H2M3Oco7e6F/G7RuAwGOH4/UlYqiuHPFZIAzcSdaWU
 TJfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699410322; x=1700015122;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OMKgWNI3AUg8dI3HBKXgtOgVRpM0GUrrIqCVzw2t3aE=;
 b=Ml21Ibo7hQ34h6dHR+FsPcS09xAvzbgMhy1bqt9E60ZGcjc3W0K22cUjopZbvLVQ0U
 VXwZane7VMe8iUJTTSIqiUD2baoOaHNQAQA4VLbNUntuTecoa38FDPm/OuO6JOc85Wbw
 LUauLfqd16HlnH8+NKSiYoIiMjNeLjfULQtEqFImKp5svba6kEPXnOZaWNBfYrNwDgGc
 fCrfgDH+gKNlIDj+3lyGZy050kTSHaeqrsQhbtO6UwRGKHsZ/HnNgzYBI31mkErsYOMK
 JTL2bvQyqjCTtVltq7w5reN7DKykT++kgPrpz0tIU6lNlnv6SgmY/juH1yAAwkIPf39V
 8+bg==
X-Gm-Message-State: AOJu0Yxo/pBulMydwECscsBlJeNA3fmlQs79pFwrQYGtK7pJG8Shh5KN
 lNhUKK2dVYdyMZufwVpFSJxmkqlqAc4Mshq4p3Q=
X-Google-Smtp-Source: AGHT+IE3mWklMnoETKk9w12usV8q7nJGIqXp0rz1mAuj7NMUR4PndP8FacySBybx428QfPD+9DGHdesklgeLSee5d1Y=
X-Received: by 2002:a4a:e088:0:b0:587:873d:7e2c with SMTP id
 w8-20020a4ae088000000b00587873d7e2cmr594850oos.1.1699410322309; Tue, 07 Nov
 2023 18:25:22 -0800 (PST)
MIME-Version: 1.0
References: <20231107134828.35909-1-kwolf@redhat.com>
In-Reply-To: <20231107134828.35909-1-kwolf@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 8 Nov 2023 10:25:10 +0800
Message-ID: <CAJSP0QVNwrQ4DCP63+mVqDRvadX4NrcDXc9u4uSn2n3VUcjpQA@mail.gmail.com>
Subject: Re: [PULL 00/11] qdev: Make array properties user accessible again
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2c;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc2c.google.com
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

On Tue, 7 Nov 2023 at 21:52, Kevin Wolf <kwolf@redhat.com> wrote:
>
> The following changes since commit bb541a7068d2eee51a9abbe2dedcdf27298b18=
72:
>
>   Merge tag 'pull-pa-20231106' of https://gitlab.com/rth7680/qemu into st=
aging (2023-11-07 15:01:17 +0800)
>
> are available in the Git repository at:
>
>   https://repo.or.cz/qemu/kevin.git qdev-array-prop
>
> for you to fetch changes up to d6df0059910b13071c15bba3b061aaed5bfdb5da:
>
>   qdev: Rework array properties based on list visitor (2023-11-07 14:43:3=
7 +0100)
>
> ----------------------------------------------------------------
> Kevin Wolf (11):
>       hw/i386/pc: Use qdev_prop_set_array()
>       hw/arm/mps2-tz: Use qdev_prop_set_array()
>       hw/arm/mps2: Use qdev_prop_set_array()
>       hw/arm/sbsa-ref: Use qdev_prop_set_array()
>       hw/arm/vexpress: Use qdev_prop_set_array()
>       hw/arm/virt: Use qdev_prop_set_array()
>       hw/arm/xlnx-versal: Use qdev_prop_set_array()
>       hw/rx/rx62n: Use qdev_prop_set_array()
>       qom: Add object_property_set_default_list()
>       qdev: Make netdev properties work as list elements
>       qdev: Rework array properties based on list visitor

Hi Kevin,
Please take a look at the following CI failure:

In file included from ../include/hw/qdev-properties-system.h:4,
from ../include/net/net.h:7,
from ../include/hw/virtio/virtio.h:19,
from ../include/hw/virtio/virtio-bus.h:29,
from ../include/hw/virtio/virtio-pci.h:19,
from ../hw/virtio/virtio-iommu-pci.c:14:
../include/qemu/compiler.h:77:36: error: static assertion failed: "not
expecting: !QEMU_IS_ALIGNED(sizeof(GenericList),
__alignof__(ReservedRegion))"
77 | #define QEMU_BUILD_BUG_MSG(x, msg) _Static_assert(!(x), msg)
| ^~~~~~~~~~~~~~
../include/hw/qdev-properties.h:73:9: note: in definition of macro =E2=80=
=98DEFINE_PROP=E2=80=99
73 | __VA_ARGS__ \
| ^~~~~~~~~~~
../include/qemu/compiler.h:79:30: note: in expansion of macro
=E2=80=98QEMU_BUILD_BUG_MSG=E2=80=99
79 | #define QEMU_BUILD_BUG_ON(x) QEMU_BUILD_BUG_MSG(x, "not expecting: " #=
x)
| ^~~~~~~~~~~~~~~~~~
../include/hw/qdev-properties.h:164:21: note: in expansion of macro
=E2=80=98QEMU_BUILD_BUG_ON=E2=80=99
164 | QEMU_BUILD_BUG_ON( \
| ^~~~~~~~~~~~~~~~~
../hw/virtio/virtio-iommu-pci.c:39:5: note: in expansion of macro
=E2=80=98DEFINE_PROP_ARRAY=E2=80=99
39 | DEFINE_PROP_ARRAY("reserved-regions", VirtIOIOMMUPCI,
| ^~~~~~~~~~~~~~~~~

https://gitlab.com/qemu-project/qemu/-/jobs/5483441144

Stefan

>
>  include/hw/qdev-properties.h     |  57 ++++++----
>  include/qom/object.h             |   8 ++
>  hw/arm/mps2-tz.c                 |  10 +-
>  hw/arm/mps2.c                    |  12 ++-
>  hw/arm/sbsa-ref.c                |   7 +-
>  hw/arm/vexpress.c                |  21 ++--
>  hw/arm/virt.c                    |  31 +++---
>  hw/arm/xlnx-versal.c             |   9 +-
>  hw/core/qdev-properties-system.c |   2 +-
>  hw/core/qdev-properties.c        | 224 +++++++++++++++++++++++++--------=
------
>  hw/i386/pc.c                     |   8 +-
>  hw/rx/rx62n.c                    |  19 ++--
>  qom/object.c                     |   6 ++
>  13 files changed, 266 insertions(+), 148 deletions(-)
>
>

