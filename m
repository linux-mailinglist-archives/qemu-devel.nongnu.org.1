Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC407D1093
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 15:33:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtpcI-000373-Hc; Fri, 20 Oct 2023 09:32:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qtpcB-0002zf-SI
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 09:32:36 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qtpc9-0005Mg-4k
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 09:32:35 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-53db360294fso1207462a12.3
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 06:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697808750; x=1698413550; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PkZhQmGHobdepwtIQCgod9yXgaqU0ZN+cHqqngDTpPc=;
 b=iuQH4jIdydd3kHIhWCakUF3rHwlNChR57HQejHiqHosYaLQcbtyQCZKYR/5X3CWcC+
 2Y296g9dQUJWVvZv5OFIQA11/L88Kb4oFlJvXY46kjm1qx1IerdvJRMpsPoFu4V6jd6/
 FhjSDRWTSJY+NguOli81fas3UXr6tbs+UFv9u7yLYkRWbZgDlKxYWWGKrywyFovI/GWQ
 b4RQl2RH3DHvlF3QOxfAxvN1wC2yHpkppymknhPBECdT13fTJFqCNNPmXm8irW6OKX7r
 z781mGNseknGpawZ7S277RHCS7QwGcWnJDIcFaVIGt1060gbt2TqFGmm8UTtlugWXwJB
 qwVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697808750; x=1698413550;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PkZhQmGHobdepwtIQCgod9yXgaqU0ZN+cHqqngDTpPc=;
 b=FFXLTG2tXK2lCaJpxgzVo4unt+xxy+Y3a8MbyoeJIxzmJQpiomuLAJEJYlxGxzsmAL
 syZvSWWz1+NWgirs0c10pUKnJYZCYiFE115gPa+yUJc0ubWRzM9Aqbb0B/7D6TTWcwGd
 z8A4t7+lYhJ/dCQP668qWGxp7wC+cVIqPzMcgMsgb+jfo8auzfmWsNKu3nHgupKOonqw
 RnsjcmuDEdWpYn7Y+fHupGT7MPvisVKgvQ8wtgV7IYbM+cbTgaIZCaytOs4/bW0lRyRU
 +hmVNvbBvK+6FJQexPkc2yF0PTiqG8qClE2f5IYdSzyLbVso+R6HzKKv4NcgUoMvbDqA
 Gnmw==
X-Gm-Message-State: AOJu0Yz/tplX1yyzNeK8DBQsnBvkoTnt3eQYpGedE9JjUMAt6A0hvnDl
 wi/auv8AI8t+gvvbrAyciRGrEcjuF1ipI4+ZKcBMrQ==
X-Google-Smtp-Source: AGHT+IHjRcXvveP5m3SuCgfAnGlPB+FFtZXC/XKp67RPtern7NxZeXMXj/BaUc3k/PGmzLi5PjFsT2uy0GxN51k+kEE=
X-Received: by 2002:a05:6402:190d:b0:53e:6da7:72ba with SMTP id
 e13-20020a056402190d00b0053e6da772bamr1968389edz.38.1697808750505; Fri, 20
 Oct 2023 06:32:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230509215923.3186420-1-alex.williamson@redhat.com>
 <20230509215923.3186420-2-alex.williamson@redhat.com>
In-Reply-To: <20230509215923.3186420-2-alex.williamson@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Oct 2023 14:32:19 +0100
Message-ID: <CAFEAcA_-gJ4pvP3vkdU0C5TbSiDrRjbVpU5eOmgYAasYCiRTJQ@mail.gmail.com>
Subject: Re: [PULL 1/3] vfio/pci: add support for VF token
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, Minwoo Im <minwoo.im@samsung.com>, 
 Klaus Jensen <k.jensen@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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

On Tue, 9 May 2023 at 23:01, Alex Williamson <alex.williamson@redhat.com> wrote:
>
> From: Minwoo Im <minwoo.im@samsung.com>
>
> VF token was introduced [1] to kernel vfio-pci along with SR-IOV
> support [2].  This patch adds support VF token among PF and VF(s). To
> passthu PCIe VF to a VM, kernel >= v5.7 needs this.
>
> It can be configured with UUID like:
>
>   -device vfio-pci,host=DDDD:BB:DD:F,vf-token=<uuid>,...
>
> [1] https://lore.kernel.org/linux-pci/158396393244.5601.10297430724964025753.stgit@gimli.home/
> [2] https://lore.kernel.org/linux-pci/158396044753.5601.14804870681174789709.stgit@gimli.home/
>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Minwoo Im <minwoo.im@samsung.com>
> Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
> Link: https://lore.kernel.org/r/20230320073522epcms2p48f682ecdb73e0ae1a4850ad0712fd780@epcms2p4
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>

Hi; Coverity points out that this change introduces a buffer
overrun (CID 1522913). I dunno why it's taken it so long
to notice...

> ---
>  hw/vfio/pci.c | 13 ++++++++++++-
>  hw/vfio/pci.h |  1 +
>  2 files changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index ec9a854361ac..cf27f28936cb 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -2856,6 +2856,8 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>      int groupid;
>      int i, ret;
>      bool is_mdev;
> +    char uuid[UUID_FMT_LEN];

We define the array uuid[] as UUID_FMT_LEN bytes long...

> +    char *name;
>
>      if (!vbasedev->sysfsdev) {
>          if (!(~vdev->host.domain || ~vdev->host.bus ||
> @@ -2936,7 +2938,15 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>          goto error;
>      }
>
> -    ret = vfio_get_device(group, vbasedev->name, vbasedev, errp);
> +    if (!qemu_uuid_is_null(&vdev->vf_token)) {
> +        qemu_uuid_unparse(&vdev->vf_token, uuid);

...but qemu_uuid_unparse() writes UUID_FMT_LEN + 1 bytes,
including a trailing NUL.

Every other use of UUID_FMT_LEN to declare an array
uses "UUID_FMT_LEN + 1" to avoid this.

(In fact, every use of UUID_FMT_LEN at all uses "+ 1",
which suggests that perhaps defining it differently (and
perhaps with a different name) would reduce the risk of
this particular bug...)

thanks
-- PMM

