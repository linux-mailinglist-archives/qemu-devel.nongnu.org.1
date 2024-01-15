Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0AC82D383
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 04:53:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPE1y-0007xL-4i; Sun, 14 Jan 2024 22:52:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rPE1m-0007wp-K4
 for qemu-devel@nongnu.org; Sun, 14 Jan 2024 22:52:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rPE1h-0001Lc-Cs
 for qemu-devel@nongnu.org; Sun, 14 Jan 2024 22:52:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705290760;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8f/5SgJbW6yhbOfossU3sMUiNh1giZ0ykzVEhjXBAKg=;
 b=Qj4tqhAed/e1etLHA5lQapbivpMTtMsHLirzAh5eeCYNnoJc4L8nCn53e8lEdnpzB2RL+M
 csugs0QO76XpEO3zSL1l4Hch4ZmuWC1BOjsT/LRt8hXJtvx93ZQ7R/AbeK3ZOMDGjLln2g
 Uy5nJ3U0m5jzZgREhoKiMPklFW6YOeM=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-pAIYtYhwMb6Xwi6kbLaJQw-1; Sun, 14 Jan 2024 22:52:38 -0500
X-MC-Unique: pAIYtYhwMb6Xwi6kbLaJQw-1
Received: by mail-il1-f200.google.com with SMTP id
 e9e14a558f8ab-3608942d3easo88674375ab.0
 for <qemu-devel@nongnu.org>; Sun, 14 Jan 2024 19:52:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705290758; x=1705895558;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8f/5SgJbW6yhbOfossU3sMUiNh1giZ0ykzVEhjXBAKg=;
 b=Z8oV8Gv22GLZGVcIBUXvLhueaiJxu38k1OG/nzGlxM3WtwPK0SKfFnXuUsSj0xvSPq
 PooCvHxOTbg1KNyGv88J8pkElOHUAdztcZzaYYY0qx4vpE4d9MVVf8iEODJPpnr19ABN
 KZXdu6s8rQUYRm0hIaNAJYTJvuj2W2jwrWYxfmh/nzyPP14H8FWzkno2BeoKmGZxkllA
 QKQXv+WtCs7g5rdHe1NJsRu+QfkI19EMc293P4k8lQ6xOye73rEeTefU7h0XspppW3a3
 96FwkZ4PB6LbA5NxXZGucTEViDdx6GmZZgNE2F1LW+YCa9G6njr+Gb39hAaPmMxLmEEN
 l8xQ==
X-Gm-Message-State: AOJu0YxFScXDm7R4Xwf0LVpN3lm4vF3vUcWVGFMH5h9LelmpXR1A1BY0
 Bzwy6u0/foVnEr+a/Csgp+vi334BK3rHTzz7s5m/Yh7dWPyOlsmgTtCs8c82vrzkU5KxyW5C38i
 TuyUfSzyDHXGvAwTWg8kKsx6tG5UKEjURmA6GYfM=
X-Received: by 2002:a92:d4c6:0:b0:35f:e3e4:a38b with SMTP id
 o6-20020a92d4c6000000b0035fe3e4a38bmr6876340ilm.2.1705290758176; 
 Sun, 14 Jan 2024 19:52:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGMJF0n72URNKP7VPySZhb4Vphl49qGfK36VtZr59YiEIhq05nGH166tFMLiDE3nURsgdGPMDgqD3yRGJvPEeQ=
X-Received: by 2002:a92:d4c6:0:b0:35f:e3e4:a38b with SMTP id
 o6-20020a92d4c6000000b0035fe3e4a38bmr6876331ilm.2.1705290757978; Sun, 14 Jan
 2024 19:52:37 -0800 (PST)
MIME-Version: 1.0
References: <1701970793-6865-1-git-send-email-si-wei.liu@oracle.com>
 <1701970793-6865-37-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1701970793-6865-37-git-send-email-si-wei.liu@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 15 Jan 2024 11:52:27 +0800
Message-ID: <CACGkMEutdpjWkAtQTA-xYaVOvZ+-X+T=WwLfLN_XyzJ958LJcg@mail.gmail.com>
Subject: Re: [PATCH 36/40] vdpa: add vhost_vdpa_get_vring_base trace for svq
 mode
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
>  hw/virtio/trace-events | 2 +-
>  hw/virtio/vhost-vdpa.c | 3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
> index 196f32f..a8d3321 100644
> --- a/hw/virtio/trace-events
> +++ b/hw/virtio/trace-events
> @@ -58,7 +58,7 @@ vhost_vdpa_set_log_base(void *dev, uint64_t base, unsig=
ned long long size, int r
>  vhost_vdpa_set_vring_addr(void *dev, unsigned int index, unsigned int fl=
ags, uint64_t desc_user_addr, uint64_t used_user_addr, uint64_t avail_user_=
addr, uint64_t log_guest_addr) "dev: %p index: %u flags: 0x%x desc_user_add=
r: 0x%"PRIx64" used_user_addr: 0x%"PRIx64" avail_user_addr: 0x%"PRIx64" log=
_guest_addr: 0x%"PRIx64
>  vhost_vdpa_set_vring_num(void *dev, unsigned int index, unsigned int num=
) "dev: %p index: %u num: %u"
>  vhost_vdpa_set_vring_base(void *dev, unsigned int index, unsigned int nu=
m) "dev: %p index: %u num: %u"
> -vhost_vdpa_get_vring_base(void *dev, unsigned int index, unsigned int nu=
m) "dev: %p index: %u num: %u"
> +vhost_vdpa_get_vring_base(void *dev, unsigned int index, unsigned int nu=
m, bool svq) "dev: %p index: %u num: %u svq: %d"

In the future, it might be better to use the name of VirtIODevice as
well as vq index instead of pointer. But consider %p has been used, so

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


