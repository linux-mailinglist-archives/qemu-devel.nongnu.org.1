Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC1D82D33A
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 04:06:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPDIu-0006Gw-61; Sun, 14 Jan 2024 22:06:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rPDIe-0006Ah-I8
 for qemu-devel@nongnu.org; Sun, 14 Jan 2024 22:06:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rPDIZ-0001te-UN
 for qemu-devel@nongnu.org; Sun, 14 Jan 2024 22:06:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705287960;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bul7agBcHeMtvsVTedfkTcpr2vj59Kn5VjCqFXHJDhQ=;
 b=T0HTDDjKS+siUmMVVRu28g1GAR+ZU9KsZARY+DwEqWoJt03vphQyYpIaHis71uoX4XC2Xa
 a2xzAuHXuZBVSv3+V/zeSfeB4skvl4J9i695rLM7WAndBHI/qavA02cUfEhDVr3Bfufg8N
 zKqSDccYQyCjEOJQX6xIQG4K2wXh68I=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-3bMMeTSgN0SacISc-k4Kow-1; Sun, 14 Jan 2024 22:05:59 -0500
X-MC-Unique: 3bMMeTSgN0SacISc-k4Kow-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-28c391d255dso5269727a91.2
 for <qemu-devel@nongnu.org>; Sun, 14 Jan 2024 19:05:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705287958; x=1705892758;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bul7agBcHeMtvsVTedfkTcpr2vj59Kn5VjCqFXHJDhQ=;
 b=wZkEryF9d6kygr8Nzaf97o/BJqjNEkGzQizazg+5KcKmuU2oPz1gjIp+bquU7Ee0ku
 g0DmrQ8/0EI6LZ6pTStEwCNqDT3hT+EqV95VuvDE8fiIBKHJdZZq2a7fdlcJ+InJZvHR
 4dXgALu+muc3fkKHx9Cj14568d6tSowigeQmwr3dEwwGXMmrld/jku7y3GhDPUpQp991
 Le21WO+ET7GHmObfFeJ5gBc2OPkBbcvh7CVcnCPPEC11gQLei5oK+PgTGQb6jD77tLeI
 07ceocfk4q7/cnnMarDuWFUQwPzkoWXZfiqk5t5pFB+ECC9aPnUfHTysyGwmFQfft1x7
 3m1g==
X-Gm-Message-State: AOJu0YykGZEZZBqaQ4lFZ0V42g3yecFiXytkBZs7s0YEJUvIMdcbLDFG
 yjCGE/8knZde0mdjkntly1OYCq9Nidz02mN8r8bzHYYpfuYyJU7UhpSQ5nmoqD1cyWpcCresSRg
 Vse8yPCbf1e0F2DGLfbJWWNxXp2Aa49I5/ZssmCM=
X-Received: by 2002:a17:90b:1b51:b0:28b:955b:f9f5 with SMTP id
 nv17-20020a17090b1b5100b0028b955bf9f5mr2169590pjb.67.1705287958026; 
 Sun, 14 Jan 2024 19:05:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHTAatiwWBh1Dxw635c/CM8dFYXseFLyCvBExdsA08z8hFhGfJdzrjX+02rT2rOB+n9TU5IQIrgX8eVfN7cEDw=
X-Received: by 2002:a17:90b:1b51:b0:28b:955b:f9f5 with SMTP id
 nv17-20020a17090b1b5100b0028b955bf9f5mr2169583pjb.67.1705287957765; Sun, 14
 Jan 2024 19:05:57 -0800 (PST)
MIME-Version: 1.0
References: <1701970793-6865-1-git-send-email-si-wei.liu@oracle.com>
 <1701970793-6865-25-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1701970793-6865-25-git-send-email-si-wei.liu@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 15 Jan 2024 11:05:46 +0800
Message-ID: <CACGkMEtbcEknHLR3DJKCR1TMT9ThDYBgqmjoDnw_=BUEzXxTcw@mail.gmail.com>
Subject: Re: [PATCH 24/40] vdpa: factor out vhost_vdpa_dma_batch_end
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: eperezma@redhat.com, mst@redhat.com, dtatulea@nvidia.com, 
 leiyang@redhat.com, yin31149@gmail.com, boris.ostrovsky@oracle.com, 
 jonah.palmer@oracle.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.758,
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

On Fri, Dec 8, 2023 at 2:52=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.com> w=
rote:
>
> Refactoring only. No functional change.
>
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> ---
>  hw/virtio/trace-events |  2 +-
>  hw/virtio/vhost-vdpa.c | 30 ++++++++++++++++++------------
>  2 files changed, 19 insertions(+), 13 deletions(-)
>
> diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
> index b0239b8..3411a07 100644
> --- a/hw/virtio/trace-events
> +++ b/hw/virtio/trace-events
> @@ -33,7 +33,7 @@ vhost_user_create_notifier(int idx, void *n) "idx:%d n:=
%p"
>  vhost_vdpa_dma_map(void *vdpa, int fd, uint32_t msg_type, uint32_t asid,=
 uint64_t iova, uint64_t size, uint64_t uaddr, uint8_t perm, uint8_t type) =
"vdpa_shared:%p fd: %d msg_type: %"PRIu32" asid: %"PRIu32" iova: 0x%"PRIx64=
" size: 0x%"PRIx64" uaddr: 0x%"PRIx64" perm: 0x%"PRIx8" type: %"PRIu8
>  vhost_vdpa_dma_unmap(void *vdpa, int fd, uint32_t msg_type, uint32_t asi=
d, uint64_t iova, uint64_t size, uint8_t type) "vdpa_shared:%p fd: %d msg_t=
ype: %"PRIu32" asid: %"PRIu32" iova: 0x%"PRIx64" size: 0x%"PRIx64" type: %"=
PRIu8
>  vhost_vdpa_map_batch_begin(void *v, int fd, uint32_t msg_type, uint8_t t=
ype)  "vdpa_shared:%p fd: %d msg_type: %"PRIu32" type: %"PRIu8
> -vhost_vdpa_listener_commit(void *v, int fd, uint32_t msg_type, uint8_t t=
ype)  "vdpa_shared:%p fd: %d msg_type: %"PRIu32" type: %"PRIu8
> +vhost_vdpa_dma_batch_end(void *v, int fd, uint32_t msg_type, uint8_t typ=
e)  "vdpa_shared:%p fd: %d msg_type: %"PRIu32" type: %"PRIu8
>  vhost_vdpa_listener_region_add_unaligned(void *v, const char *name, uint=
64_t offset_as, uint64_t offset_page) "vdpa_shared: %p region %s offset_wit=
hin_address_space %"PRIu64" offset_within_region %"PRIu64
>  vhost_vdpa_listener_region_add(void *vdpa, uint64_t iova, uint64_t llend=
, void *vaddr, bool readonly) "vdpa: %p iova 0x%"PRIx64" llend 0x%"PRIx64" =
vaddr: %p read-only: %d"
>  vhost_vdpa_listener_region_del_unaligned(void *v, const char *name, uint=
64_t offset_as, uint64_t offset_page) "vdpa_shared: %p region %s offset_wit=
hin_address_space %"PRIu64" offset_within_region %"PRIu64
> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> index a6c6fe5..999a97a 100644
> --- a/hw/virtio/vhost-vdpa.c
> +++ b/hw/virtio/vhost-vdpa.c
> @@ -198,19 +198,11 @@ static void vhost_vdpa_dma_batch_begin_once(VhostVD=
PAShared *s)
>      }
>  }
>
> -static void vhost_vdpa_dma_batch_end_once(VhostVDPAShared *s)
> +static bool vhost_vdpa_dma_batch_end(VhostVDPAShared *s)
>  {

I had the same comment for using "iotlb" instead of "dma".

Others look good.

Thanks


