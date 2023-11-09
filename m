Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B4987E6CE1
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 16:09:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r16dl-0006oC-O6; Thu, 09 Nov 2023 10:08:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r16dj-0006nw-4o
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 10:08:15 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r16dh-0006Xo-Gh
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 10:08:14 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5409bc907edso1503254a12.0
 for <qemu-devel@nongnu.org>; Thu, 09 Nov 2023 07:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699542492; x=1700147292; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JiAotfhiZUR5Fnoe4X6ciSmNdvRKEZEHLtRqCjm6z2A=;
 b=A0Rchg1v40o7kQRUS2hQ9RxyWr92zBmy3cZgKijloHSPtLPt1gvDUukcKWL1cOqmUh
 N8k3FlHbmnBLwA77CudrW1apQOOwgYd5YAh526u+154xNDiHXX5FvSlu/2spGaF+LEbc
 j0FaeuT1F/37nPQVZDgGwSEtdw6tjtPIEUy5HZMRyy8zDTrZ69kDXbJM1Ru7x/1CZLSD
 UD8d40RU1a4mspfpU6BOwuIerHwbYdOrqjPpj2U33meY/ptn0vtXp3S7E507qx0CUTWM
 fB/UkxbMCR4P37MLFvFdTaP8uAY5j7ozhQri0tAuC7FgylkaMnPkP8ZUrTuZCnnAWypV
 CViQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699542492; x=1700147292;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JiAotfhiZUR5Fnoe4X6ciSmNdvRKEZEHLtRqCjm6z2A=;
 b=jXam08wbJ1fXacIg5CAW0DmEDldCvl9VAPBbks18RvqCJ5zO4CgFtMyCFKUSy6vGJM
 izYimtfe6IFJkfOth+KfY57VwPCT5fmOMiYUBQzCsDI20dvaAUQ6YgRE10pC/fkZYJLS
 qd6kqF6SJuKbIIGev4Qms2C8zFxfMoYue8gM45rshEsrJ3O60fGr7QOesHkDarWp7YdZ
 xbxR5VG/6dApTLV9CUqjVFzY4gmYkjKdq/gSXJ4uN71AkOQwt9kaDDeIc69JfCjchitq
 +owj/2OHlqfe4zx/dCFI2TI0rywYwH2Bxbfkj1O3frLsn8n5VbvKf6LmHm0WOnLpCet1
 W9Fw==
X-Gm-Message-State: AOJu0Yx38gDhvZe3ainsnc9MXvdn0e9Y38gm1BZ/2LxKo4oM4lpQ02VA
 ro7P4BjN1qad2nj838vOtmFAdnRoth1oKKGNZOyA8w==
X-Google-Smtp-Source: AGHT+IE94JLgDYRogIYFmnVqHpWXvZmJJi05H/2lDzONMs6p7ZmC/hF5y9kV6Rf2nphMofp3kwuF1M8e1LidxNJmDSQ=
X-Received: by 2002:a50:d583:0:b0:53e:468d:64a9 with SMTP id
 v3-20020a50d583000000b0053e468d64a9mr4597383edi.21.1699542491824; Thu, 09 Nov
 2023 07:08:11 -0800 (PST)
MIME-Version: 1.0
References: <20231106143653.302391-1-clg@redhat.com>
 <20231106143653.302391-10-clg@redhat.com>
In-Reply-To: <20231106143653.302391-10-clg@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 Nov 2023 15:08:01 +0000
Message-ID: <CAFEAcA_P+ewPD7PD_ZqfWJ_GX1szM_zxMr_G5cMYNWLApn_raw@mail.gmail.com>
Subject: Re: [PULL 09/22] virtio-iommu: Record whether a probe request has
 been issued
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>, 
 Eric Auger <eric.auger@redhat.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Yanghang Liu <yanghliu@redhat.com>
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

On Mon, 6 Nov 2023 at 14:48, C=C3=A9dric Le Goater <clg@redhat.com> wrote:
>
> From: Eric Auger <eric.auger@redhat.com>
>
> Add an IOMMUDevice 'probe_done' flag to record that the driver
> already issued a probe request on that device.
>
> This will be useful to double check host reserved regions aren't
> notified after the probe and hence are not taken into account
> by the driver.

Hi; Coverity points out (CID 1523901) that this change introduced
dead code (but improves on the previous bad code!):


> -static ssize_t virtio_iommu_fill_resv_mem_prop(VirtIOIOMMU *s, uint32_t =
ep,
> +static ssize_t virtio_iommu_fill_resv_mem_prop(IOMMUDevice *sdev, uint32=
_t ep,
>                                                 uint8_t *buf, size_t free=
)
>  {
>      struct virtio_iommu_probe_resv_mem prop =3D {};
>      size_t size =3D sizeof(prop), length =3D size - sizeof(prop.head), t=
otal;
> -    IOMMUDevice *sdev;
>      GList *l;
>
> -    sdev =3D container_of(virtio_iommu_mr(s, ep), IOMMUDevice, iommu_mr)=
;
> -    if (!sdev) {
> -        return -EINVAL;
> -    }

In the old code this check on sdev was wrong -- because iommu_mr
is not the first field in IOMMUDevice, if virtio_iommu_mr() returns
NULL that doesn't mean that container_of(...) is going to be NULL.

> -
>      total =3D size * g_list_length(sdev->resv_regions);
>      if (total > free) {
>          return -ENOSPC;
> @@ -688,19 +682,27 @@ static int virtio_iommu_probe(VirtIOIOMMU *s,
>                                uint8_t *buf)
>  {
>      uint32_t ep_id =3D le32_to_cpu(req->endpoint);
> +    IOMMUMemoryRegion *iommu_mr =3D virtio_iommu_mr(s, ep_id);
>      size_t free =3D VIOMMU_PROBE_SIZE;
> +    IOMMUDevice *sdev;
>      ssize_t count;
>
> -    if (!virtio_iommu_mr(s, ep_id)) {
> +    if (!iommu_mr) {
>          return VIRTIO_IOMMU_S_NOENT;
>      }
>
> -    count =3D virtio_iommu_fill_resv_mem_prop(s, ep_id, buf, free);
> +    sdev =3D container_of(iommu_mr, IOMMUDevice, iommu_mr);
> +    if (!sdev) {
> +        return -EINVAL;
> +    }

In the new code we already check directly whether virtio_iommu_mr()
returned NULL. So the check on sdev being NULL is simply dead
code -- it can never be true and we should just delete it.

> +
> +    count =3D virtio_iommu_fill_resv_mem_prop(sdev, ep_id, buf, free);
>      if (count < 0) {
>          return VIRTIO_IOMMU_S_INVAL;
>      }
>      buf +=3D count;
>      free -=3D count;
> +    sdev->probe_done =3D true;
>
>      return VIRTIO_IOMMU_S_OK;
>  }

thanks
-- PMM

