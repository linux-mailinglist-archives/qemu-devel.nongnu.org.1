Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B5682D380
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 04:50:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPDzO-0006dg-ID; Sun, 14 Jan 2024 22:50:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rPDzM-0006dB-Cr
 for qemu-devel@nongnu.org; Sun, 14 Jan 2024 22:50:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rPDzK-00011K-Tu
 for qemu-devel@nongnu.org; Sun, 14 Jan 2024 22:50:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705290614;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KiM49KSsDPd6UoIT5KEsuBEsSbGj0oDH0N1Xk8XlxBw=;
 b=B5J5OWIhqXn/KVBil5o8DKLRSewFClaqP8NIEDylyq7OooA0GDIhpIP09fluuezDnI2HPj
 cHDIqfcLYc8a2+2AzJZioFWwiBYKrpiTelli/9Z0eANfuBAhzZUisAfVjAU4XN5f8Li29q
 0tauidI6qZLL6hbJalLkZYoONKvHznc=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-fFpDTWfeMLOB8LqJtTrj3A-1; Sun, 14 Jan 2024 22:50:12 -0500
X-MC-Unique: fFpDTWfeMLOB8LqJtTrj3A-1
Received: by mail-oo1-f69.google.com with SMTP id
 006d021491bc7-5953e534a96so9681109eaf.0
 for <qemu-devel@nongnu.org>; Sun, 14 Jan 2024 19:50:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705290612; x=1705895412;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KiM49KSsDPd6UoIT5KEsuBEsSbGj0oDH0N1Xk8XlxBw=;
 b=dOV2qkzI7OnxslUwhFCzettUK5QfRx1nIEw9cSLTeVbHr1UMRqjN9rd75D9y0nOQrE
 lLQG/TCzZYkCnq5kUIHJA4MIwNfD78w/uf6I6kOPEZ2NwTiHVB+hqNjIO5GENCDrhdXS
 cZ+LtZYcEN89HGvAdGK8Q4sXil/Vghg6jkgHLAAQTemz1vIYhVDypozvl3KiXvgZMTl5
 gX+npmso3Lkdz2dEC3NF8igSKbLz7UeqTT/I0+aFvWY+EU6FXjB5mdJo+Q2BHbcZq272
 FETcYZ5FTrx0SH1vKPjgapimegk9BQvQnBJO87DR7s9t4A8ANBgxAGFY6VgWQCFOcMtM
 czMg==
X-Gm-Message-State: AOJu0Yy8n2ClZu/IoW3AckEQNdW35vbhwZBgEz0fYjheYpnDQ1MEqrCD
 ej1LCgeU2+xYD9nNfeo8GvdZGxScP3tkQbxRttpBZoc2C9qAC92ezmyRPECi3ip5QI0hf2mBbVQ
 26y7t4NlVROk6MO+b/wbkZ08P1Sy8telnEJ2E8Ew=
X-Received: by 2002:a05:6358:60ca:b0:173:8b3:71c2 with SMTP id
 i10-20020a05635860ca00b0017308b371c2mr7328949rwi.45.1705290612100; 
 Sun, 14 Jan 2024 19:50:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHxc22JEd5J490uNm/FkrQKKAD9S0kplXteedzwOY7l3ZoDUaqvdRbB0zLHtZCYZFq8VGbzfQ92GkYlkl5pNnY=
X-Received: by 2002:a05:6358:60ca:b0:173:8b3:71c2 with SMTP id
 i10-20020a05635860ca00b0017308b371c2mr7328938rwi.45.1705290611833; Sun, 14
 Jan 2024 19:50:11 -0800 (PST)
MIME-Version: 1.0
References: <1701970793-6865-1-git-send-email-si-wei.liu@oracle.com>
 <1701970793-6865-36-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1701970793-6865-36-git-send-email-si-wei.liu@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 15 Jan 2024 11:50:00 +0800
Message-ID: <CACGkMEvhiWiH5JMBySkm9Gwc+gB=kReaOrFE+XRrHZj=_aqu2w@mail.gmail.com>
Subject: Re: [PATCH 35/40] vdpa: add vhost_vdpa_set_address_space_id trace
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

On Fri, Dec 8, 2023 at 2:51=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.com> w=
rote:
>
> For better debuggability and observability.
>
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
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

So pointer is not user friendly, how about using the name of the netclient?

Thanks

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


