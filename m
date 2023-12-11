Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 658D180D514
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 19:15:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCknN-0001BP-CZ; Mon, 11 Dec 2023 13:14:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rCknM-0001BG-7o
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 13:14:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rCknK-0004RP-EX
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 13:14:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702318457;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tJMi8WkdrDBIPtQW5HTJ3Kr78QW2kiqhboqC2TEFo/g=;
 b=cLqPK1I1V17t74+cV1H4HnDjkvthhuqHaER9DARjuhMOVxK0cSsY6JmXBYcgHGBNsG6H4m
 c0HnKWmqKk/x1c8FNJmgtW6ngJK2f/SvyAUgngSwkH6/NwiMMY0EESJMevp6VCFJ0v6XGg
 KpvGF4TYw47CKdeCT5SE1dvYWAVDHjY=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-XvPCG9IHOeilG3EGQMy43g-1; Mon, 11 Dec 2023 13:14:15 -0500
X-MC-Unique: XvPCG9IHOeilG3EGQMy43g-1
Received: by mail-yb1-f197.google.com with SMTP id
 3f1490d57ef6-db402e6f61dso5188142276.3
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 10:14:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702318455; x=1702923255;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tJMi8WkdrDBIPtQW5HTJ3Kr78QW2kiqhboqC2TEFo/g=;
 b=gCgocD3RRfL3pBLmR7on+ZDDNEJhDyfBjpgDfypT1/e3jRHF+etYOHSqHFaYcm/0uY
 4QS5vuJw3xktyaAhq5ep2Eh+WEEPr9cdNht22ANs6i98ZIEOU5k1avU6GZop+MmHhuob
 XOMYCA3NcRmHb+x1WgJFLkKKoDoj/ihMT1Klt/1rrYw1QG8nUh+LBH0q9uSEzuK81XJM
 AheLZUQ/0MPOwURx4tuVAe7+nHR6C3BfRkOZH4Fc94PLZQyRuq5vDM+uMGdcUCtY5Tb2
 /2qdryvUPNyTD3YBgs4/BdCYXUfKuM2KYtt4odGn9Kd+UknuR+hwNMbPtrw3hv9/qI5H
 r+/g==
X-Gm-Message-State: AOJu0YxLfuKMYIvz58SQ1/AbrqjgGIW6XHH0OGTILDBuFEhlD1pzAZ2x
 cIonzphLxorM8fVdVW7HW6X4AnYodzV9xZueha8o3ecJtQ/1kp8bYnv1IFJ0G4qm4rP35JhBl2t
 Mj3op03TPnaEDt2M+RME70Sstjdx05Dw=
X-Received: by 2002:a05:6902:e07:b0:db5:5097:69ff with SMTP id
 df7-20020a0569020e0700b00db5509769ffmr3880539ybb.6.1702318455275; 
 Mon, 11 Dec 2023 10:14:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGcJUVlu1UXBthTRa1AM3TFgh69FuV5CUdUjStodYvqw0yItew5ZUcTGQArBweenBAV0p1v25/yIh+4EWLYAlc=
X-Received: by 2002:a05:6902:e07:b0:db5:5097:69ff with SMTP id
 df7-20020a0569020e0700b00db5509769ffmr3880529ybb.6.1702318455023; Mon, 11 Dec
 2023 10:14:15 -0800 (PST)
MIME-Version: 1.0
References: <1701970793-6865-1-git-send-email-si-wei.liu@oracle.com>
 <1701970793-6865-36-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1701970793-6865-36-git-send-email-si-wei.liu@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 11 Dec 2023 19:13:38 +0100
Message-ID: <CAJaqyWfSSAX9roge3+dJKM7BckDJoF9b5bA1NgtR_xbO332hxA@mail.gmail.com>
Subject: Re: [PATCH 35/40] vdpa: add vhost_vdpa_set_address_space_id trace
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Dec 7, 2023 at 7:51=E2=80=AFPM Si-Wei Liu <si-wei.liu@oracle.com> w=
rote:
>
> For better debuggability and observability.
>
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>

Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
>  net/trace-events | 3 +++
>  net/vhost-vdpa.c | 3 +++
>  2 files changed, 6 insertions(+)
>
> diff --git a/net/trace-events b/net/trace-events
> index 823a071..aab666a 100644
> --- a/net/trace-events
> +++ b/net/trace-events
> @@ -23,3 +23,6 @@ colo_compare_tcp_info(const char *pkt, uint32_t seq, ui=
nt32_t ack, int hdlen, in
>  # filter-rewriter.c
>  colo_filter_rewriter_pkt_info(const char *func, const char *src, const c=
har *dst, uint32_t seq, uint32_t ack, uint32_t flag) "%s: src/dst: %s/%s p:=
 seq/ack=3D%u/%u  flags=3D0x%x"
>  colo_filter_rewriter_conn_offset(uint32_t offset) ": offset=3D%u"
> +
> +# vhost-vdpa.c
> +vhost_vdpa_set_address_space_id(void *v, unsigned vq_group, unsigned asi=
d_num) "vhost_vdpa: %p vq_group: %u asid: %u"
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index 41714d1..84876b0 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -30,6 +30,7 @@
>  #include "migration/misc.h"
>  #include "hw/virtio/vhost.h"
>  #include "hw/virtio/vhost-vdpa.h"
> +#include "trace.h"
>
>  /* Todo:need to add the multiqueue support here */
>  typedef struct VhostVDPAState {
> @@ -365,6 +366,8 @@ static int vhost_vdpa_set_address_space_id(struct vho=
st_vdpa *v,
>      };
>      int r;
>
> +    trace_vhost_vdpa_set_address_space_id(v, vq_group, asid_num);
> +
>      r =3D ioctl(v->shared->device_fd, VHOST_VDPA_SET_GROUP_ASID, &asid);
>      if (unlikely(r < 0)) {
>          error_report("Can't set vq group %u asid %u, errno=3D%d (%s)",
> --
> 1.8.3.1
>


