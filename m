Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1582A82A686
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 04:34:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNloJ-0002gO-CT; Wed, 10 Jan 2024 22:32:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rNloH-0002gG-Si
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 22:32:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rNloF-0005sv-Qy
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 22:32:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704943966;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wMxY1+yflmEV4B4lDl46nS63zCWBLJbCY22RoPFVzEs=;
 b=DFifpiC9lco6OCccb8zkPSe9jKOIDkKccHBfLDzPBRW6DT7SkzRpwfbBD+ZqfZ9HpzFQOj
 y87/kSBZnaJZIGOEvm3HLMuKtqYB8DoAZqazXJHBpzKQP+KDg8S3VksIoJrjH0eUrLJag6
 7cldtmj129G9PiWWQXPC+ily2R0d+Ts=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-393-fI4Sr1XzNwW4ttjxCO0TgQ-1; Wed, 10 Jan 2024 22:32:44 -0500
X-MC-Unique: fI4Sr1XzNwW4ttjxCO0TgQ-1
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-6d9b0c58e39so4758987b3a.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 19:32:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704943963; x=1705548763;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wMxY1+yflmEV4B4lDl46nS63zCWBLJbCY22RoPFVzEs=;
 b=IzIKYLmoKdv20JvrUGskOE1/+wICh17rv6C4CtnuOBetvJe9kxsXeU0tH3rbAPzBI8
 S60Hx9ND90+qSBNO93+uQ4D06KF4HtB1YfrNgbwBku+WNj7qcRWrs0mSKCFT8f+0dwwj
 LoSPQLmRh6jhNSphCEUZJlnUkfI7W/vTaX8Zpdtjqo6XByPdJ8ICxWC9PhsFP9Qs5J8X
 EyWa0Y71IFiFiOgzVwFCweOG5i6UFNPtxmADqXb+YEA2/q8GyTJLu6XcVyK60aNz6yT8
 nS805aiuw326zmE29yzp9nZb0ZhDowmRXyrUksO0Az6xuwWwUbU5jS9TNrZ7Kq1cyx/s
 zSnw==
X-Gm-Message-State: AOJu0YyZVTYW9vW3l4gJ08d0vEPdicj5I6CRcXJFbw1o1WtIq0mN9Ei9
 aWz8XUtH4YPRkaByvaRg43HkzBbs9yqJJOZ9JELpXwn3ffBdVsxkSOuOWijeUctr2QsF50YQGTc
 FpoU+FYpWif5UfxzSM94GqLmHumYl5patL6C8hME=
X-Received: by 2002:a05:6a00:1d8f:b0:6d9:b5ce:f17e with SMTP id
 z15-20020a056a001d8f00b006d9b5cef17emr643317pfw.5.1704943963542; 
 Wed, 10 Jan 2024 19:32:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEF9GwSLcAAAHxbYwXXNz9twVL3Nqd8Vc84WaVGac0s2WnuM/3JYfKBb1L8kFf7UiD7Cfb8RkCWl1PO9e40V44=
X-Received: by 2002:a05:6a00:1d8f:b0:6d9:b5ce:f17e with SMTP id
 z15-20020a056a001d8f00b006d9b5cef17emr643312pfw.5.1704943963307; Wed, 10 Jan
 2024 19:32:43 -0800 (PST)
MIME-Version: 1.0
References: <1701970793-6865-1-git-send-email-si-wei.liu@oracle.com>
 <1701970793-6865-2-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1701970793-6865-2-git-send-email-si-wei.liu@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 11 Jan 2024 11:32:32 +0800
Message-ID: <CACGkMEsn=dibiuav8RKHYEWn6CrXPL2PxSyNqsrtj-k6Z0WhmA@mail.gmail.com>
Subject: Re: [PATCH 01/40] linux-headers: add vhost_types.h and vhost.h
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
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>

It's better to document which version did this commit sync to.

Thanks

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


