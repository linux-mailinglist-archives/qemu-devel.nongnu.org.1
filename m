Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6485D82A914
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 09:26:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNqOY-0003Om-27; Thu, 11 Jan 2024 03:26:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rNqOR-0003OH-F6
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 03:26:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rNqOQ-0004zz-00
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 03:26:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704961585;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KerKdKuAJoSwyb505m5Rd3lE7y31Ws+epYvGiY3iaNc=;
 b=gq27W4BRLmuLWafmv8VfOLyjso6XFnhPCiDEhEYbopeKOnOMg8h2dC0Nwgg6oiz8xWQM79
 N/HHqG+NzS41U16V3Zqh2VbTo03A4s/szG9SWxI6lNkwXMYBcgJQSUrKjuP3riPrdvLzSa
 kmHIUiceipehF6ahblak+D+7S0JlIBU=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-YCCkio4JOK-90jgaYdAdsQ-1; Thu, 11 Jan 2024 03:26:23 -0500
X-MC-Unique: YCCkio4JOK-90jgaYdAdsQ-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-28b3b3633f2so3087810a91.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 00:26:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704961582; x=1705566382;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KerKdKuAJoSwyb505m5Rd3lE7y31Ws+epYvGiY3iaNc=;
 b=rocxdjhJn0QK/GAoGBtUqUhiCD68xbgRBPfvM/HKBs4dgzBqJokNmYb0x5163liU8h
 idTjBa/IAGc/PdQHtMXV91RRTCFpjHxHb4lNS/WicgHXufNtxTF84In7E+DVEYM/X55l
 nRAGgU3BiR7ZOnZuwQxEQMuEHj5j0qUIx3wUvrxP33lbKh4fTFJKIu8dH+wr/LzWxFbj
 59A4JBnctfzfhgYrlmWMd4I+y96xjazS/e73jOS6L5ufDS/BkV4JhvPC2Qtqou6PBZd7
 oCZluH+P0fBKN6JSDyN3nJgX3Kd3oc+G2PqgH738slfYL+amTRPSD1MA2rEU6yvI+keo
 wFyw==
X-Gm-Message-State: AOJu0YyfP7xXk+26NR/hlKtwg0yYS2Aikn76XieYOVnALR+qfPeb2A6F
 DugnEFvbYDJmBRC1kxmJ6DnwaiZhd/VQ24jpnrSMy5WskHcOx0OJ4+U0z9tzXI2x4aoNo1EHiY2
 GblzD6gCLqkRtBKCBPeHwI2UCtlpn7d4nZo/C+0M=
X-Received: by 2002:a17:90a:cb8c:b0:28c:a872:e25b with SMTP id
 a12-20020a17090acb8c00b0028ca872e25bmr581738pju.86.1704961582346; 
 Thu, 11 Jan 2024 00:26:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGX5/QeiJ9pqkIdJhWj+zQ1DYJqfiuZv69RFpCYcGmICPGm5lTcwZaaIJS5Y7rx8aIKFYLZnfmM/aHG5zXX2CE=
X-Received: by 2002:a17:90a:cb8c:b0:28c:a872:e25b with SMTP id
 a12-20020a17090acb8c00b0028ca872e25bmr581728pju.86.1704961582078; Thu, 11 Jan
 2024 00:26:22 -0800 (PST)
MIME-Version: 1.0
References: <1701970793-6865-1-git-send-email-si-wei.liu@oracle.com>
 <1701970793-6865-19-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1701970793-6865-19-git-send-email-si-wei.liu@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 11 Jan 2024 16:26:11 +0800
Message-ID: <CACGkMEteJq=pV3f9FLn0kiE-Bs9AT7Jrmqx3g-YYckXV6HSyCA@mail.gmail.com>
Subject: Re: [PATCH 18/40] vdpa: unregister listener on last dev cleanup
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: eperezma@redhat.com, mst@redhat.com, dtatulea@nvidia.com, 
 leiyang@redhat.com, yin31149@gmail.com, boris.ostrovsky@oracle.com, 
 jonah.palmer@oracle.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.774,
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

On Fri, Dec 8, 2023 at 2:50=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.com> w=
rote:
>
> So that the free of iova tree struct can be safely deferred to
> until the last vq referencing it goes away.
>
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> ---
>  hw/virtio/vhost-vdpa.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> index 4f026db..ea2dfc8 100644
> --- a/hw/virtio/vhost-vdpa.c
> +++ b/hw/virtio/vhost-vdpa.c
> @@ -815,7 +815,10 @@ static int vhost_vdpa_cleanup(struct vhost_dev *dev)
>      }
>
>      vhost_vdpa_host_notifiers_uninit(dev, dev->nvqs);
> -    memory_listener_unregister(&v->shared->listener);
> +    if (vhost_vdpa_last_dev(dev) && v->shared->listener_registered) {
> +        memory_listener_unregister(&v->shared->listener);
> +        v->shared->listener_registered =3D false;
> +    }

Can we move this to the put() (refcnt decreasing helper) of shared?

Thanks

>      vhost_vdpa_svq_cleanup(dev);
>
>      dev->opaque =3D NULL;
> --
> 1.8.3.1
>


