Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A74FD7D81C8
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 13:29:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvyXM-0001vQ-FV; Thu, 26 Oct 2023 07:28:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qvyXK-0001v9-IR
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 07:28:26 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qvyXI-00022e-Un
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 07:28:26 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-53e3b8f906fso1173035a12.2
 for <qemu-devel@nongnu.org>; Thu, 26 Oct 2023 04:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698319703; x=1698924503; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c1qJ4ud+KmfxnATbv4y8pIA3yMxTBDyTrPg5boLdT9Y=;
 b=khYc5WdY64tM/qomUnTm+BcsfhepK0dJl0H67bYQ8PeRW9OCLGJc0Byisgd9JcR2Fp
 gdfux3aF/3Jt0l/O5kC1s+e83tABAWK65gvqv5xYA5c18e3Dic4s3xmX7oAtw+1A0HuF
 J8d67MISLOuB10VnCqjrNkEhfLq0o+uWTS3+MclO4KNLjcQ45Lemv5xoWjqxPl/Z/dMJ
 QbSb/lXlBbMgP+0vRJA+gBaMb+dz0Mmj9NFkOAjh0I73yKQ65RKCyZTATCYO2/seGB39
 JcYsCGyy2YjU+LA4+p1gNEeqev37uZHglgUUF0IwQ49uYt0TgnSoCXS/YrUo0a15Qhdo
 Th4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698319703; x=1698924503;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c1qJ4ud+KmfxnATbv4y8pIA3yMxTBDyTrPg5boLdT9Y=;
 b=D1iHivD1hqCm71kVJ6d2o9nxA9eiFegzAZlTMH2E32RyvqmlCbsyHCLzLQjoS4zXiB
 izn1Y7TAsi5ED7V++XN3rEEea/K+Thu/x2TBvzHhffWuUCtWmJwYPaQCdFP7Sky3g5cK
 xJIbQqv/jREJzEdSeHIuBwutnFi+DrPtSvMSbcaRa0hdwX8y4JT1x4h0Z9eHD6WXfCQJ
 kV1IztSPyDb6cY+7Lzu/4uq2g9BmoY96OGBwD64OXeoW3UYknrTfrEk5QxwFouiNZXGF
 L4X0SdmLJaNroluwF4AHR5xzUQJuSq7vsX+RHOy4Y1aErbZZna54tKRc63LFlGNy6PH9
 n+gg==
X-Gm-Message-State: AOJu0YzCU4RO1qu1BlDHffs0YhdocRNfYKtG8/aIZn17aQHKnwPJVEyn
 xCdYRaw2yX/9Nyu9TiGKpJYk62b7DZiCc82pEHQzFg==
X-Google-Smtp-Source: AGHT+IEP19UHi39ahLiH/d6shd9nT8digpLG6r3ihPk3vrk0M7F8mc952vdo3Tt49qWENorDALmnvcg21U/nTKdl9sQ=
X-Received: by 2002:a50:d09b:0:b0:53e:6da7:72b7 with SMTP id
 v27-20020a50d09b000000b0053e6da772b7mr12222841edd.20.1698319702758; Thu, 26
 Oct 2023 04:28:22 -0700 (PDT)
MIME-Version: 1.0
References: <20231026070636.1165037-1-clg@redhat.com>
 <20231026070636.1165037-3-clg@redhat.com>
In-Reply-To: <20231026070636.1165037-3-clg@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Oct 2023 12:28:11 +0100
Message-ID: <CAFEAcA9jbb6MYOC8DHaPEiQsq9BZoLhfk7-vfOM1Gmi0amEM4g@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] vfio/pci: Fix buffer overrun when writing the VF
 token
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, 
 "Denis V . Lunev" <den@openvz.org>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, 
 Stefan Weil <sw@weilnetz.de>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 "Maciej S . Szmigiero" <maciej.szmigiero@oracle.com>, 
 Fam Zheng <fam@euphon.net>, Juan Quintela <quintela@redhat.com>,
 Peter Xu <peterx@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>, 
 Alex Williamson <alex.williamson@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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

On Thu, 26 Oct 2023 at 08:08, C=C3=A9dric Le Goater <clg@redhat.com> wrote:
>
> qemu_uuid_unparse() includes a trailing NUL when writing the uuid
> string and the buffer size should be UUID_FMT_LEN + 1 bytes. Use the
> recently added UUID_STR_LEN which defines the correct size.
>
> Fixes: CID 1522913
> Fixes: 2dca1b37a760 ("vfio/pci: add support for VF token")
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com>
> ---
>  hw/vfio/pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 9bfa83aca1a87952e18743c9ca951b1bfc873507..c02a5d70f5e1b8e4d22051285=
748f514f1b9f008 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3274,7 +3274,7 @@ static void vfio_realize(PCIDevice *pdev, Error **e=
rrp)
>      Error *err =3D NULL;
>      int i, ret;
>      bool is_mdev;
> -    char uuid[UUID_FMT_LEN];
> +    char uuid[UUID_STR_LEN];
>      char *name;
>
>      if (vbasedev->fd < 0 && !vbasedev->sysfsdev) {

This patch (and its dependency) should probably be cc qemu-stable ?

thanks
-- PMM

