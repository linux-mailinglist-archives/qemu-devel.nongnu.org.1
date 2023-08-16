Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B16EB77DB53
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 09:44:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWBBR-0007Pw-CQ; Wed, 16 Aug 2023 03:43:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1qWBBH-0007Nz-TM
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 03:43:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1qWBBF-0003sx-Iq
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 03:43:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692171779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x7EVZV5/qNP//nj9L2kCyJqmBy6SNQq/jc4+LaaYrqw=;
 b=hA9DOyAorT1uVbtZ77H/pfu6q4BbXRSsgaHtrlKN2jKzhxSAbBJU0WrDfjbOJsu4yLUUVI
 RqdR1MHjj8ebegC/LN+bh/TVfVdzEX3oaoVe2z0d38VUGFgMMFyki6moqc8/ZYfdO6a/9f
 9GiHNCSyyVxDpqEDoEK97R0Pfl9e5wk=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-R-yXUrU3O-eYnh47ppj7YA-1; Wed, 16 Aug 2023 03:42:57 -0400
X-MC-Unique: R-yXUrU3O-eYnh47ppj7YA-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2b9ce397ef1so60905661fa.1
 for <qemu-devel@nongnu.org>; Wed, 16 Aug 2023 00:42:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692171775; x=1692776575;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x7EVZV5/qNP//nj9L2kCyJqmBy6SNQq/jc4+LaaYrqw=;
 b=K+ebCZXNWRG8FkUZQtoN/udPnYPVV6L7BQ5k6saohzH5YT4UsF+7wmEFIuiDrS708W
 virmsNpLxLlD6Iex2PTujqmzUrqFvO9UOV3Sn18KkAQMwHueiEE7Jc6VPeSlt7f5xmtA
 QgQ6CcTfufurNErvFejcmcbIHko6Eoh0449rxlHdWtTWlxFTnKfKivMF251Z205y25uF
 g5UOGH6y0vYp5bv6Buu8WAFkzn4R18bqi93GxW2vrtsSYyd/Fds2tNKILgM6HGvFB0Qi
 kKkpE/YZTRipREu89j3y5xvRYQKpxAgpsNTHbAPjyaIRnWtqYKckl4WJa3bzPO2eqblE
 b43A==
X-Gm-Message-State: AOJu0YyJ2HGX8Sn1SSthbtN9Nqp//rDzdlHyOviv8sjFL1r38nZwLV6V
 WFqaFAW+lSvbKJLv2N7UAO0i1wOy7F+pBFRzC34vBxFDCSCyE7HTvH6tqmLQkVb/otjLlkGxI06
 xumPxqclbNzXmElPWnFeSFLT+SUh//yY=
X-Received: by 2002:a19:8c56:0:b0:4ff:8742:4488 with SMTP id
 i22-20020a198c56000000b004ff87424488mr843543lfj.52.1692171775423; 
 Wed, 16 Aug 2023 00:42:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgaVFBEXNcx1vpw01C6TTOJ5l+XvyzXS90XRxndSl6VWfFPiRyRoDcb6w3eukjJFmmmMOOAXaBAzexvEbXHMk=
X-Received: by 2002:a19:8c56:0:b0:4ff:8742:4488 with SMTP id
 i22-20020a198c56000000b004ff87424488mr843537lfj.52.1692171775086; Wed, 16 Aug
 2023 00:42:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230815122007.928049-1-thuth@redhat.com>
In-Reply-To: <20230815122007.928049-1-thuth@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 16 Aug 2023 11:42:43 +0400
Message-ID: <CAMxuvayEJFE526ry7K64Szbk_nvCUBNoh=brTC7doEqACcSrWQ@mail.gmail.com>
Subject: Re: [PATCH] include/hw/virtio/virtio-gpu: Fix virtio-gpu with blob on
 big endian hosts
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-s390x@nongnu.org,
 qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.04,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Aug 15, 2023 at 4:20=E2=80=AFPM Thomas Huth <thuth@redhat.com> wrot=
e:
>
> Using "-device virtio-gpu,blob=3Dtrue" currently does not work on big
> endian hosts (like s390x). The guest kernel prints an error message
> like:
>
>  [drm:virtio_gpu_dequeue_ctrl_func [virtio_gpu]] *ERROR* response 0x1200 =
(command 0x10c)
>
> and the display stays black. When running QEMU with "-d guest_errors",
> it shows an error message like this:
>
>  virtio_gpu_create_mapping_iov: nr_entries is too big (83886080 > 16384)
>
> which indicates that this value has not been properly byte-swapped.
> And indeed, the virtio_gpu_create_blob_bswap() function (that should
> swap the fields in the related structure) fails to swap some of the
> entries. After correctly swapping all missing values here, too, the
> virtio-gpu device is now also working with blob=3Dtrue on s390x hosts.
>
> Fixes: e0933d91b1 ("virtio-gpu: Add virtio_gpu_resource_create_blob")
> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D2230469
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  include/hw/virtio/virtio-gpu-bswap.h | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/include/hw/virtio/virtio-gpu-bswap.h b/include/hw/virtio/vir=
tio-gpu-bswap.h
> index 9124108485..637a0585d0 100644
> --- a/include/hw/virtio/virtio-gpu-bswap.h
> +++ b/include/hw/virtio/virtio-gpu-bswap.h
> @@ -63,7 +63,10 @@ virtio_gpu_create_blob_bswap(struct virtio_gpu_resourc=
e_create_blob *cblob)
>  {
>      virtio_gpu_ctrl_hdr_bswap(&cblob->hdr);
>      le32_to_cpus(&cblob->resource_id);
> +    le32_to_cpus(&cblob->blob_mem);
>      le32_to_cpus(&cblob->blob_flags);
> +    le32_to_cpus(&cblob->nr_entries);
> +    le64_to_cpus(&cblob->blob_id);
>      le64_to_cpus(&cblob->size);
>  }
>
> --
> 2.39.3
>


