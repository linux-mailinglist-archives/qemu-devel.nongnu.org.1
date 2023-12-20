Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4678381980E
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Dec 2023 06:23:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFp22-0008VR-OU; Wed, 20 Dec 2023 00:22:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rFp1y-0008VD-Pr
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 00:22:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rFp1x-00016X-5E
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 00:22:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703049720;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YeAkY1VMqQaEmKJg848iL3fYCjmz/WeZLG6+9g1/6xk=;
 b=hhadnVBCkeaIZfsnjf1RQNHwJjJ3GEQxLucPmJ8ynjSF7w5+cMDOfHkMUc7JagykZzNn+W
 zV/q0rgugFqjyHuAGN+m0H6NaCHsg2PwbN6t5n8ExeDk/s3SBYwN3AcNca5CrqXfxixwEs
 KefV7obTERFvXhW/uU6uNXxcd7d/EeY=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-TXIEqQrbM_eifl_jw_Evtg-1; Wed, 20 Dec 2023 00:21:17 -0500
X-MC-Unique: TXIEqQrbM_eifl_jw_Evtg-1
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-6d5c594f63aso310701b3a.1
 for <qemu-devel@nongnu.org>; Tue, 19 Dec 2023 21:21:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703049677; x=1703654477;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YeAkY1VMqQaEmKJg848iL3fYCjmz/WeZLG6+9g1/6xk=;
 b=w+7dSf2aQWHFGaZK/yGei0MNlOS57BaNTyH5Vgj9TVWhy4bEXmx0fbUGESksBE1Mqy
 0Kc4gUY3JUaIualvcsZpYg9rAL9dWZ8DObAFxjS56C07aLXPz9yXMNZg8q2bAnGSu5eg
 bi3JtWDX2OKS7CreqEa2/iUN4HNAXZ2QdQcXBdU7NvhaDCf0DoewKJM/4P0PXmao8YIe
 1LQtxXsL2gjlfbwxOegrEJpGUS5RoKQmvyidnSUbnf6DSA0145mgHoxwTEO6gZilgJkx
 b4vWzhpjaM4cAKfheQt5pSXfEPc4rIldtZHYJ/qHK6pAdjSAx5Gn0m1kYPfigtbTr+J4
 jDBw==
X-Gm-Message-State: AOJu0YyORLxf8SudMcXoGG16nhscANVgwAe2xAskyVZy+7B/4V1fie0G
 KcWWz7YYerc376Q4i89hDD6Z+j25XYG/+hMTO8UGYgU7eSAuezeZcWxuX1F/EEsrzuQQmyXaV8E
 sZmoDVXIJ3gWxLIfWUm7dvLOeHyBgmNE=
X-Received: by 2002:a05:6a20:371c:b0:18f:97c:3849 with SMTP id
 t28-20020a056a20371c00b0018f097c3849mr2138948pze.35.1703049676943; 
 Tue, 19 Dec 2023 21:21:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEg4rDG92n0ed6w17AQEBIJS0VzdqJE37JA/GbyNey+J5MpkysyCPdLtJPod8MH152bW10WzSH2orgXV/EUK3Y=
X-Received: by 2002:a05:6a20:371c:b0:18f:97c:3849 with SMTP id
 t28-20020a056a20371c00b0018f097c3849mr2138942pze.35.1703049676674; Tue, 19
 Dec 2023 21:21:16 -0800 (PST)
MIME-Version: 1.0
References: <20231215172830.2540987-1-eperezma@redhat.com>
 <20231215172830.2540987-9-eperezma@redhat.com>
In-Reply-To: <20231215172830.2540987-9-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 20 Dec 2023 13:21:05 +0800
Message-ID: <CACGkMEvH=uU4QxMHVHTo5tQiuML2+NTE3gZssfz84-+4kGHa1Q@mail.gmail.com>
Subject: Re: [PATCH for 9.0 08/12] vdpa: add vhost_vdpa_load_setup
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 si-wei.liu@oracle.com, 
 Lei Yang <leiyang@redhat.com>, Dragos Tatulea <dtatulea@nvidia.com>, 
 Zhu Lingshan <lingshan.zhu@intel.com>, Parav Pandit <parav@mellanox.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.066,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Sat, Dec 16, 2023 at 1:28=E2=80=AFAM Eugenio P=C3=A9rez <eperezma@redhat=
.com> wrote:
>
> Callers can use this function to setup the incoming migration thread.
>
> This thread is able to map the guest memory while the migration is
> ongoing, without blocking QMP or other important tasks. While this
> allows the destination QEMU not to block, it expands the mapping time
> during migration instead of making it pre-migration.

If it's just QMP, can we simply use bh with a quota here?

Btw, have you measured the hotspot that causes such slowness? Is it
pinning or vendor specific mapping that slows down the progress? Or if
VFIO has a similar issue?

>
> This thread joins at vdpa backend device start, so it could happen that
> the guest memory is so large that we still have guest memory to map
> before this time.

So we would still hit the QMP stall in this case?

> This can be improved in later iterations, when the
> destination device can inform QEMU that it is not ready to complete the
> migration.
>
> If the device is not started, the clean of the mapped memory is done at
> .load_cleanup.  This is far from ideal, as the destination machine has
> mapped all the guest ram for nothing, and now it needs to unmap it.
> However, we don't have information about the state of the device so its
> the best we can do.  Once iterative migration is supported, this will be
> improved as we know the virtio state of the device.
>
> If the VM migrates before finishing all the maps, the source will stop
> but the destination is still not ready to continue, and it will wait
> until all guest RAM is mapped.  It is still an improvement over doing
> all the map when the migration finish, but next patches use the
> switchover_ack method to prevent source to stop until all the memory is
> mapped at the destination.
>
> The memory unmapping if the device is not started is weird
> too, as ideally nothing would be mapped.  This can be fixed when we
> migrate the device state iteratively, and we know for sure if the device
> is started or not.  At this moment we don't have such information so
> there is no better alternative.
>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
>
> ---

Thanks


