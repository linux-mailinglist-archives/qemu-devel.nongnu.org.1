Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D090B77B1E1
	for <lists+qemu-devel@lfdr.de>; Mon, 14 Aug 2023 08:58:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVRWX-0003hE-01; Mon, 14 Aug 2023 02:57:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qVRWG-0003dK-M6
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 02:57:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qVRWF-0005LV-03
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 02:57:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691996258;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KuNNnqHhw5kUDsyj/L9uzzgSuXYPywd/L620I/K0XVI=;
 b=ZWO0CoLVr/OcFdmKFVebNI30wNxy4f20FMI1tYXy9bpzHMprsN6CRVa7nrBMDQHY0ApRX/
 yP4tf5bdSs2lGcx9ZTtzgX5FkgKXRKVanrEneL3mjXMBRXzjzfBeezxlJUvdWZuGWNWDOK
 nzZ5X8/6HwosaLljmj8GQ0l/3UuIAjU=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-Uk80J9JDPGCFyzzNsTM5Jw-1; Mon, 14 Aug 2023 02:57:36 -0400
X-MC-Unique: Uk80J9JDPGCFyzzNsTM5Jw-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2b9b820c94fso38945471fa.2
 for <qemu-devel@nongnu.org>; Sun, 13 Aug 2023 23:57:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691996251; x=1692601051;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KuNNnqHhw5kUDsyj/L9uzzgSuXYPywd/L620I/K0XVI=;
 b=gEU614H5gZ9SrKrQkNyff0fhnJQUMB61GOhDWDocWkMGRmVEs2060QapbDSxx0UKXF
 oZ9agGRANmHA2VzVZyZYsfu6IKu+HEWpfK0jCYBoKl7CNzEY+SrhnNkNKCKDrArdzBNk
 nm8Ed6kcIjlcvfmGm/icD8LKQ1vKh+LuvcnPL5lu9O0ZkGuRe07m71o9pB8rfmOXYD7p
 ulNJSTQC2o9D7fUGYl8MtpX8Npfx/S/XLraprOoskC37BiXJBbSwjqxymwC4NLGKoHPZ
 3s7MjJDsxVRVOKyAPrmgoJxy1bkrDf0FoIjqpNEnZfEf/NTNLM99Yi4NGNXq/TZKGB7v
 sAsw==
X-Gm-Message-State: AOJu0YwdK3eO3fG2sTQZGjswhHt90nvW3g3UEAJdSTBrvnAfaMtzNQ3h
 s0FuxMVpSXQGBHXNIqzADmbm4R8bJMcUWAlliwbRoEaBtos1AI/Sj3JzthdRnPDBpyHUOoVUn7F
 qWz+KxFD5jWPQ0zHuuw3C7BUrcTOsDiU=
X-Received: by 2002:a2e:7c18:0:b0:2b9:20fe:4bcc with SMTP id
 x24-20020a2e7c18000000b002b920fe4bccmr6377563ljc.21.1691996251593; 
 Sun, 13 Aug 2023 23:57:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/WNdXd1mscfkR0m79ZHwn6mFgoA2UmphFMZZwq7yaKzPE44refIiBej6cdLyWWRI1j6pMun8/0euFvanShYU=
X-Received: by 2002:a2e:7c18:0:b0:2b9:20fe:4bcc with SMTP id
 x24-20020a2e7c18000000b002b920fe4bccmr6377543ljc.21.1691996251291; Sun, 13
 Aug 2023 23:57:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230810153611.3410882-1-eperezma@redhat.com>
 <20230810153611.3410882-2-eperezma@redhat.com>
In-Reply-To: <20230810153611.3410882-2-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 14 Aug 2023 14:57:20 +0800
Message-ID: <CACGkMEvbL7XkXHm591v9YJHK173spTdW4Tmpsh6efm9osnjcFA@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] vdpa: use first queue SVQ state for CVQ default
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, 
 Dragos Tatulea <dtatulea@nvidia.com>, si-wei.liu@oracle.com, 
 Parav Pandit <parav@mellanox.com>, Gautam Dawar <gdawar@xilinx.com>, 
 Zhu Lingshan <lingshan.zhu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Cindy Lu <lulu@redhat.com>, Harpreet Singh Anand <hanand@xilinx.com>,
 Stefano Garzarella <sgarzare@redhat.com>, 
 Hawkins Jiawei <yin31149@gmail.com>, Shannon Nelson <snelson@pensando.io>,
 Lei Yang <leiyang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Thu, Aug 10, 2023 at 11:36=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redha=
t.com> wrote:
>
> Previous to this patch the only way CVQ would be shadowed is if it does
> support to isolate CVQ group or if all vqs were shadowed from the
> beginning.  The second condition was checked at the beginning, and no
> more configuration was done.
>
> After this series we need to check if data queues are shadowed because
> they are in the middle of the migration.  As checking if they are
> shadowed already covers the previous case, let's just mimic it.
>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  net/vhost-vdpa.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index 9795306742..a772540250 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -505,7 +505,7 @@ static int vhost_vdpa_net_cvq_start(NetClientState *n=
c)
>
>      s0 =3D vhost_vdpa_net_first_nc_vdpa(s);
>      v->shadow_data =3D s0->vhost_vdpa.shadow_vqs_enabled;
> -    v->shadow_vqs_enabled =3D s->always_svq;
> +    v->shadow_vqs_enabled =3D s0->vhost_vdpa.shadow_vqs_enabled;
>      s->vhost_vdpa.address_space_id =3D VHOST_VDPA_GUEST_PA_ASID;
>
>      if (s->vhost_vdpa.shadow_data) {
> --
> 2.39.3
>


