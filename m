Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ED5C07D74EC
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 21:56:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvjyN-0001FX-IN; Wed, 25 Oct 2023 15:55:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1qvjyJ-0001FF-TH
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 15:55:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1qvjyI-0000Rj-3u
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 15:55:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698263716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UBiljv0kfTv8dXAdwoJawYkCyjGSo1ol/Me0FiccM9Q=;
 b=Qqjfo6fZQFYKWDGW5YMlgNaNTsDmCV29QiyvjY5IjND+e7kFHpCG6CYjxajmsSXBYhMkNa
 GKHOfowYo+b3qWQmBUr9E1mhm6MzgDA7WNrHOcGgMS1M4Lljzo8NdNor3/qMTfT55IAu3N
 xoYpx6COBMjyMgazKto74ZWOcv314ak=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-XaXkEYrmOIy_B47Vin-oVg-1; Wed, 25 Oct 2023 15:55:14 -0400
X-MC-Unique: XaXkEYrmOIy_B47Vin-oVg-1
Received: by mail-io1-f69.google.com with SMTP id
 ca18e2360f4ac-7a16fe687aaso6209139f.3
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 12:55:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698263713; x=1698868513;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UBiljv0kfTv8dXAdwoJawYkCyjGSo1ol/Me0FiccM9Q=;
 b=r09uEJ97IDFUrkXl7E6kg6B4uvDN39omphEC6WEiCqmFwSAIDlmVu9WNZIM/AdLC6V
 elBWvm61/Qq5l8S/f1EOCPa1ktWqswndjx1t/X6FLhvAUSy+XYcSY4N8+OtIISPvBoA+
 eBrAUlLt28qBqQG5wfkREBsgRnAGIbR2CIRtTWs0LLZU/Zkiv5HsiH6/NRWJ8SWtgqTO
 by+jpVnRrMT8gIPLZ9GrLWfzCElmdA9C7XUopZz3wssAnTUJsWyywgMndvdFQOHidcb1
 Y8J8Y4tkis6OLUAyhCk7R9HSs5X+uzMjbGH1H07TwNF1rxBKAfzzJZMN0m76kYE45r6Q
 LSOw==
X-Gm-Message-State: AOJu0YxQT9yPPhQBemg6rYRty7MCkpqOV/MIckCBdyZsO+vu52ih7pJM
 KMhUHKbTehKmOMoFM8ps5AdqxvqbDq+tB1jktT9TIygPqow0CWYSR0hBm2D7C+xG6UNBBziCcn+
 Ej0LePAnUW114iPQ=
X-Received: by 2002:a05:6e02:1a6f:b0:34f:d1bc:c47c with SMTP id
 w15-20020a056e021a6f00b0034fd1bcc47cmr20931549ilv.22.1698263713518; 
 Wed, 25 Oct 2023 12:55:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAABPLdRGT6UenlpPcsla4CId0DTNlNiZ4OjXvtMeyC2AoKh2so9CqVSG4IlNbNeqUzJfdCA==
X-Received: by 2002:a05:6e02:1a6f:b0:34f:d1bc:c47c with SMTP id
 w15-20020a056e021a6f00b0034fd1bcc47cmr20931528ilv.22.1698263713181; 
 Wed, 25 Oct 2023 12:55:13 -0700 (PDT)
Received: from redhat.com ([38.15.60.12]) by smtp.gmail.com with ESMTPSA id
 c25-20020a02a619000000b0045a04a88b0csm139604jam.86.2023.10.25.12.55.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 12:55:12 -0700 (PDT)
Date: Wed, 25 Oct 2023 13:55:11 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, "Denis V .
 Lunev" <den@openvz.org>, Kevin Wolf <kwolf@redhat.com>, Hanna Reitz
 <hreitz@redhat.com>, Stefan Weil <sw@weilnetz.de>, Paolo Bonzini
 <pbonzini@redhat.com>, "Daniel P . =?UTF-8?B?QmVycmFuZ8Op?="
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, "Maciej S .
 Szmigiero" <maciej.szmigiero@oracle.com>, Fam Zheng <fam@euphon.net>, Juan
 Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH 2/2] vfio/pci: Fix buffer overrun when writing the VF token
Message-ID: <20231025135511.18636e4e.alex.williamson@redhat.com>
In-Reply-To: <20231025101245.751559-3-clg@redhat.com>
References: <20231025101245.751559-1-clg@redhat.com>
 <20231025101245.751559-3-clg@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, 25 Oct 2023 12:12:45 +0200
C=C3=A9dric Le Goater <clg@redhat.com> wrote:

> qemu_uuid_unparse() includes a trailing NUL when writing the uuid
> string and the buffer size should be UUID_FMT_LEN + 1 bytes. Use the
> recently added UUID_STR_LEN which defines the correct size.
>=20
> Fixes: CID 1522913
> Fixes: 2dca1b37a760 ("vfio/pci: add support for VF token")
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com>
> ---
>  hw/vfio/pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
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
> =20
>      if (vbasedev->fd < 0 && !vbasedev->sysfsdev) {

Reviewed-by: Alex Williamson <alex.williamson@redhat.com>


