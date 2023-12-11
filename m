Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B483180C25B
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 08:49:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCb1A-0007XV-Tr; Mon, 11 Dec 2023 02:47:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rCb12-0007XI-2L
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 02:47:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rCb0y-0003hX-UA
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 02:47:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702280861;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FqDIj9tHqvoHSyk4PARRoIVOk8nDyK5n7cLNYID2aL4=;
 b=AAZRb1vRqdfWsXsW5/mie3W9MNrkoShDLgdWgZy2AfTryaKK+T0LBKQD/MbkUo1/eM0TLE
 euHmQP+1/6SaWtTOr472P9CmrtVit6dU5C/6QAvikEWGu+Lb7t+RkNAiwGoyoZ6KeIPYj/
 tE7osIgq0nGKtVEiCK3Cl0kjD0Z06yY=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-xvb2jATfPpKNC1hk0Yg2Dg-1; Mon, 11 Dec 2023 02:47:39 -0500
X-MC-Unique: xvb2jATfPpKNC1hk0Yg2Dg-1
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-5df9f98994bso8134637b3.0
 for <qemu-devel@nongnu.org>; Sun, 10 Dec 2023 23:47:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702280859; x=1702885659;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FqDIj9tHqvoHSyk4PARRoIVOk8nDyK5n7cLNYID2aL4=;
 b=r6ojOmkReGAHPhDCV+DyQYID6zMfPrfsKFlOg9wdPNWp8Y0ivId4lwICdQUlLS5+om
 CM7ZtWa9SHSe749jO0cqKFlHOFZ55CBaeFn3Lua/EFchyWmYr2x7AYSwyWccfO1J0KQ3
 hfVJ1iEf+SlvgmvXvB7xid2dWqiGHphRyvfp+ifSXKZONAB/drTtJfI3La3uaGnU2PRh
 N20SXRGnh3sQoGhxJVgpGdA7dD/Pvx5FhRrG1UzQMjR9fRuyInxMFKJYtlJCDxudHeSj
 2mpwqcIOEe90xjOraZP5CjBsn+egTRnbHGMzzmbsd4OPOI0EVVNO9eCeHIQesCIXUIhH
 9Zmg==
X-Gm-Message-State: AOJu0YwHw4imWgFbZQio7lfuscJU7rqkKoqOKnWRWKjzAfMxQO4gr9Vr
 BvrYd8KVJjm1KmVmh8GnF1FRQwEUxeTJQ29YFWXFEoSscRVyT2UeXiNCgIaqvYxT9/d6WorDpea
 GGbccAwO+xMnutd6IGiQgatubH0gmNwg=
X-Received: by 2002:a0d:e2c7:0:b0:5d7:1a33:5ae3 with SMTP id
 l190-20020a0de2c7000000b005d71a335ae3mr2807257ywe.48.1702280859007; 
 Sun, 10 Dec 2023 23:47:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFZOTuYpsHaYOo4dL1CHvE5nCdmiWJDwWUprkY/Z4xHBLfrtBW1bk/HpNAey+Zx1CfAEY8aWQXu5TncA2jy95c=
X-Received: by 2002:a0d:e2c7:0:b0:5d7:1a33:5ae3 with SMTP id
 l190-20020a0de2c7000000b005d71a335ae3mr2807254ywe.48.1702280858766; Sun, 10
 Dec 2023 23:47:38 -0800 (PST)
MIME-Version: 1.0
References: <1701970793-6865-1-git-send-email-si-wei.liu@oracle.com>
 <1701970793-6865-2-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1701970793-6865-2-git-send-email-si-wei.liu@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 11 Dec 2023 08:47:02 +0100
Message-ID: <CAJaqyWdNygZLus4cPPu+9Pd2cNMC3-fS=yMbV8B-f3XYkCdUbw@mail.gmail.com>
Subject: Re: [PATCH 01/40] linux-headers: add vhost_types.h and vhost.h
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: jasowang@redhat.com, mst@redhat.com, dtatulea@nvidia.com, 
 leiyang@redhat.com, yin31149@gmail.com, boris.ostrovsky@oracle.com, 
 jonah.palmer@oracle.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, Dec 7, 2023 at 7:50=E2=80=AFPM Si-Wei Liu <si-wei.liu@oracle.com> w=
rote:
>
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>

This should be updated from scripts/update-linux-headers.sh.

> ---
>  include/standard-headers/linux/vhost_types.h | 13 +++++++++++++
>  linux-headers/linux/vhost.h                  |  9 +++++++++
>  2 files changed, 22 insertions(+)
>
> diff --git a/include/standard-headers/linux/vhost_types.h b/include/stand=
ard-headers/linux/vhost_types.h
> index 5ad07e1..c39199b 100644
> --- a/include/standard-headers/linux/vhost_types.h
> +++ b/include/standard-headers/linux/vhost_types.h
> @@ -185,5 +185,18 @@ struct vhost_vdpa_iova_range {
>   * DRIVER_OK
>   */
>  #define VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK  0x6
> +/* Device can be resumed */
> +#define VHOST_BACKEND_F_RESUME  0x5
> +/* Device supports the driver enabling virtqueues both before and after
> + * DRIVER_OK
> + */
> +#define VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK  0x6
> +/* Device may expose the virtqueue's descriptor area, driver area and
> + * device area to a different group for ASID binding than where its
> + * buffers may reside. Requires VHOST_BACKEND_F_IOTLB_ASID.
> + */
> +#define VHOST_BACKEND_F_DESC_ASID    0x7
> +/* IOTLB don't flush memory mapping across device reset */
> +#define VHOST_BACKEND_F_IOTLB_PERSIST  0x8
>
>  #endif
> diff --git a/linux-headers/linux/vhost.h b/linux-headers/linux/vhost.h
> index f5c48b6..c61c687 100644
> --- a/linux-headers/linux/vhost.h
> +++ b/linux-headers/linux/vhost.h
> @@ -219,4 +219,13 @@
>   */
>  #define VHOST_VDPA_RESUME              _IO(VHOST_VIRTIO, 0x7E)
>
> +/* Get the dedicated group for the descriptor table of a virtqueue:
> + * read index, write group in num.
> + * The virtqueue index is stored in the index field of vhost_vring_state=
.
> + * The group id for the descriptor table of this specific virtqueue
> + * is returned via num field of vhost_vring_state.
> + */
> +#define VHOST_VDPA_GET_VRING_DESC_GROUP        _IOWR(VHOST_VIRTIO, 0x7F,=
       \
> +                                             struct vhost_vring_state)
> +
>  #endif
> --
> 1.8.3.1
>


