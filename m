Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B08C747ED0
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 10:00:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGxRB-0007Q8-5G; Wed, 05 Jul 2023 04:00:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1qGxR6-0007Iw-ID
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 04:00:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1qGxR3-00049V-N6
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 04:00:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688544022;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iPDHLlMUnVNNaemqCOzqfQ78upQ/Dq5IQOKO7VoM00s=;
 b=U9wMEWwP88WcjAifely0tY3/r82ZlD5SxAtmEbvPz2jGX2ZYvjhiACbO/+pHSj2G4CD9/+
 h+gYfStHnwlhtdGREsoLZAkqlfGwUoXftmA7nu7Vcq7Oi6ldXLRmctnuUXNjIW6Ekme6ZA
 +pTIuP9in+3xMLrxM35DKq8AXzoKj/s=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-s5VeRfHjNnK6OYuzIPnDSg-1; Wed, 05 Jul 2023 04:00:21 -0400
X-MC-Unique: s5VeRfHjNnK6OYuzIPnDSg-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2b6b98ac356so59427061fa.1
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 01:00:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688544019; x=1691136019;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iPDHLlMUnVNNaemqCOzqfQ78upQ/Dq5IQOKO7VoM00s=;
 b=dz2r97295RXmk5cN3/sBFYueyNAjXSf8snRCmXuvKrGKPmtrZg2Lo8QJQ8g7H/vODb
 MILSBvul9KAQx+oSfBVPQjyjafk+CuNS5y0QacNCaqVKkyvc5yvy4hKdMJIJjMIKXo9R
 nGYF+hTgoq9PREyVZXEoctcI9CJXpbeKUUfDFwKSBVSFIc9YMm1hXliWiMKqxXt1XV35
 iOmROd79OEokUCeqxUDVH3SRBnE+w3cRo1rqpC5jHbNRg+yS63WBnr7zM4YjeJO3He06
 jGemy6eRnEyi/E4wocOvfW9eeXF73IxBe3Xkq7/Ilgp1e/rxbOEhTB1FiiSdKG20NDhk
 xb1Q==
X-Gm-Message-State: ABy/qLarPT/ISlCtRYSMa4jX65EiX2nu/cvNwFmnGvWp8sbAm2sQVYtA
 uswyF/ceKM6CEbOOsVHpVy/6FN1qNn0F1+Fv473b3ruLsfda6DNIIbQBb71w54BMqmx0Ji+TchQ
 sHtL0uhYzzHO2P++dASw6C2JZw+qBxfc=
X-Received: by 2002:a2e:99d0:0:b0:2b6:d582:5a0 with SMTP id
 l16-20020a2e99d0000000b002b6d58205a0mr9372565ljj.12.1688544019729; 
 Wed, 05 Jul 2023 01:00:19 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH37l47hBu+X6nyhOiw/MXF4WhakeH/TYGbmrf+t+k/lHpE3bLbQ4sawiI/f6bp9TLsCuoqrdsXDfmFeJ/7FHM=
X-Received: by 2002:a2e:99d0:0:b0:2b6:d582:5a0 with SMTP id
 l16-20020a2e99d0000000b002b6d58205a0mr9372546ljj.12.1688544019424; Wed, 05
 Jul 2023 01:00:19 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1688438055.git.yin31149@gmail.com>
In-Reply-To: <cover.1688438055.git.yin31149@gmail.com>
From: Lei Yang <leiyang@redhat.com>
Date: Wed, 5 Jul 2023 15:59:42 +0800
Message-ID: <CAPpAL=z6+Jhoy3w=itO7JEpkijJPZSZNyLVUQ1qS08gqnjN6hQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] vdpa: Return -EIO if device ack is VIRTIO_NET_ERR
To: Hawkins Jiawei <yin31149@gmail.com>
Cc: jasowang@redhat.com, mst@redhat.com, eperezma@redhat.com, 
 qemu-stable@nongnu.org, qemu-devel@nongnu.org, 18801353760@163.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=leiyang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Hello Hawkins

QE can help test this series before  it is merged into master, I would
like to know what test steps can cover this series related scenario?

Thanks
Lei

On Tue, Jul 4, 2023 at 11:36=E2=80=AFAM Hawkins Jiawei <yin31149@gmail.com>=
 wrote:
>
> According to VirtIO standard, "The class, command and
> command-specific-data are set by the driver,
> and the device sets the ack byte.
> There is little it can do except issue a diagnostic
> if ack is not VIRTIO_NET_OK."
>
> Therefore, QEMU should stop sending the queued SVQ commands and
> cancel the device startup if the device's ack is not VIRTIO_NET_OK.
>
> Yet the problem is that, vhost_vdpa_net_load_x() returns 1 based on
> `*s->status !=3D VIRTIO_NET_OK` when the device's ack is VIRTIO_NET_ERR.
> As a result, net->nc->info->load() also returns 1, this makes
> vhost_net_start_one() incorrectly assume the device state is
> successfully loaded by vhost_vdpa_net_load() and return 0, instead of
> goto `fail` label to cancel the device startup, as vhost_net_start_one()
> only cancels the device startup when net->nc->info->load() returns a
> negative value.
>
> This patchset fixes this problem by returning -EIO when the device's
> ack is not VIRTIO_NET_OK.
>
> Changelog
> =3D=3D=3D=3D=3D=3D=3D=3D=3D
> v3:
>  - split the fixes suggested by Eugenio
>  - return -EIO suggested by Michael
>
> v2: https://lore.kernel.org/all/69010e9ebb5e3729aef595ed92840f43e48e53e5.=
1687875592.git.yin31149@gmail.com/
>  - fix the same bug in vhost_vdpa_net_load_offloads()
>
> v1: https://lore.kernel.org/all/cover.1686746406.git.yin31149@gmail.com/
>
> Hawkins Jiawei (3):
>   vdpa: Return -EIO if device ack is VIRTIO_NET_ERR in _load_mac()
>   vdpa: Return -EIO if device ack is VIRTIO_NET_ERR in _load_mq()
>   vdpa: Return -EIO if device ack is VIRTIO_NET_ERR in _load_offloads()
>
>  net/vhost-vdpa.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>
> --
> 2.25.1
>
>


