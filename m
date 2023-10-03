Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CA1037B7037
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 19:46:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnjSm-0008TA-2D; Tue, 03 Oct 2023 13:45:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qnjSf-00083C-Bm
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:45:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qnjSd-0001lX-Dy
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:45:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696355130;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BqVHOkvsQ5i0T9ZQKQHtm/tuQbNTgTHWYemaUx/TN9E=;
 b=KH/YbvPYk6zOEHU2+ypN0BqYRdKep/7AChgvfLhtMyhX2ILY3A2si18IT+ECChjNa2O+Ea
 USQaTxZmy0VndsmwFDwzia8KJszvXMz/X6LOIuQkfFIip9xx8BSh4cjuIsnDNJLmB4hKSq
 3mNHp+TuEpfR86LrPdePh0koS2/q4sE=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-392-yIVqVt2POAiqVAziyXRJ8Q-1; Tue, 03 Oct 2023 13:45:29 -0400
X-MC-Unique: yIVqVt2POAiqVAziyXRJ8Q-1
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-59bdb9fe821so18408067b3.0
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 10:45:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696355128; x=1696959928;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BqVHOkvsQ5i0T9ZQKQHtm/tuQbNTgTHWYemaUx/TN9E=;
 b=L9C0XrX347R/R69mYe5vGXFkS3aI3JsIIe2S8HJ7JiY+ZU4QBnmeDJqvIOpm9FaqGL
 YWYF27FwEuVpJlBS/r6Wg3be2p6WMf+YLgvN3ORHkOFFtw2IRazkFSd4asvNV3nMFWUA
 7icKQW06QmZj4ubC6WxsXpJiS2GI4FHJStWXWjiGTC1dEJUkQ/79Wxxun1meoN3u8QDF
 AgbVendD7RCzpvBvskJie1CXAuMkj8J9cRWhMiwBM5uWy7RjChsa+yZNcA7oTmXZo11f
 XpSN2bSWcPqSupBO/MOddJ49osaVkfdFoqw6osvSyHTU+m5irBGO3Pnuc8v8wktElEag
 2Uhg==
X-Gm-Message-State: AOJu0YxO7hffBCliAbhEH8sxPfeugyYTLB1QxF7V6TYpUxz09cIK5btT
 tXUDmFKp//4ZteRsxR+gj8R7vgoUtJYNHkDWEJ2rWY0Vz4lfC5PkpY0s4SiwkD4t3c900qZIVSV
 kCCtAfy6U5JtAhNENNpXdOnHDBd/JnlE=
X-Received: by 2002:a0d:e2cf:0:b0:59f:75b9:a37c with SMTP id
 l198-20020a0de2cf000000b0059f75b9a37cmr251021ywe.35.1696355128438; 
 Tue, 03 Oct 2023 10:45:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnZ0iPOCFSwP2EFP9WP8KMPZIlv3MrXWblNZKyUEkoZA9LW6AJrQC1swPCLA9+FL9dmPagpq5I2eFaR55lUPA=
X-Received: by 2002:a0d:e2cf:0:b0:59f:75b9:a37c with SMTP id
 l198-20020a0de2cf000000b0059f75b9a37cmr251006ywe.35.1696355128158; Tue, 03
 Oct 2023 10:45:28 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693287885.git.yin31149@gmail.com>
 <13b3a36cc33c443a47525957ea38e80594d90595.1693287885.git.yin31149@gmail.com>
In-Reply-To: <13b3a36cc33c443a47525957ea38e80594d90595.1693287885.git.yin31149@gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 3 Oct 2023 19:44:52 +0200
Message-ID: <CAJaqyWf-jE79jq33FJM8HU=nAjq4qAd+TLHu6Xxt8SS-xYWbJw@mail.gmail.com>
Subject: Re: [PATCH v4 3/8] vhost: Expose vhost_svq_available_slots()
To: Hawkins Jiawei <yin31149@gmail.com>
Cc: jasowang@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 leiyang@redhat.com, 18801353760@163.com
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

On Tue, Aug 29, 2023 at 7:55=E2=80=AFAM Hawkins Jiawei <yin31149@gmail.com>=
 wrote:
>
> Next patches in this series will delay the polling
> and checking of buffers until either the SVQ is
> full or control commands shadow buffers are full,
> no longer perform an immediate poll and check of
> the device's used buffers for each CVQ state load command.
>
> To achieve this, this patch exposes
> vhost_svq_available_slots() and introduces a helper function,
> allowing QEMU to know whether the SVQ is full.
>
> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
> Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> ---
>  hw/virtio/vhost-shadow-virtqueue.c | 2 +-
>  hw/virtio/vhost-shadow-virtqueue.h | 1 +
>  net/vhost-vdpa.c                   | 9 +++++++++
>  3 files changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-=
virtqueue.c
> index e731b1d2ea..fc5f408f77 100644
> --- a/hw/virtio/vhost-shadow-virtqueue.c
> +++ b/hw/virtio/vhost-shadow-virtqueue.c
> @@ -66,7 +66,7 @@ bool vhost_svq_valid_features(uint64_t features, Error =
**errp)
>   *
>   * @svq: The svq
>   */
> -static uint16_t vhost_svq_available_slots(const VhostShadowVirtqueue *sv=
q)
> +uint16_t vhost_svq_available_slots(const VhostShadowVirtqueue *svq)
>  {
>      return svq->num_free;
>  }
> diff --git a/hw/virtio/vhost-shadow-virtqueue.h b/hw/virtio/vhost-shadow-=
virtqueue.h
> index 5bce67837b..19c842a15b 100644
> --- a/hw/virtio/vhost-shadow-virtqueue.h
> +++ b/hw/virtio/vhost-shadow-virtqueue.h
> @@ -114,6 +114,7 @@ typedef struct VhostShadowVirtqueue {
>
>  bool vhost_svq_valid_features(uint64_t features, Error **errp);
>
> +uint16_t vhost_svq_available_slots(const VhostShadowVirtqueue *svq);
>  void vhost_svq_push_elem(VhostShadowVirtqueue *svq,
>                           const VirtQueueElement *elem, uint32_t len);
>  int vhost_svq_add(VhostShadowVirtqueue *svq, const struct iovec *out_sg,

I think it is ok to split this export in its own patch. If you decide
to do it that way, you can add my Acked-by.

> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index a875767ee9..e6342b213f 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -620,6 +620,13 @@ static ssize_t vhost_vdpa_net_cvq_add(VhostVDPAState=
 *s,
>      return vhost_svq_poll(svq, 1);
>  }
>
> +/* Convenience wrapper to get number of available SVQ descriptors */
> +static uint16_t vhost_vdpa_net_svq_available_slots(VhostVDPAState *s)
> +{
> +    VhostShadowVirtqueue *svq =3D g_ptr_array_index(s->vhost_vdpa.shadow=
_vqs, 0);

This is not really generic enough for all VhostVDPAState, as dataplane
ones have two svqs.

I think the best is to just inline the function in the caller, as
there is only one, isn't it? If not, would it work to just replace
_net_ by _cvq_ or similar?

> +    return vhost_svq_available_slots(svq);
> +}
> +
>  static ssize_t vhost_vdpa_net_load_cmd(VhostVDPAState *s, uint8_t class,
>                                         uint8_t cmd, const struct iovec *=
data_sg,
>                                         size_t data_num)
> @@ -640,6 +647,8 @@ static ssize_t vhost_vdpa_net_load_cmd(VhostVDPAState=
 *s, uint8_t class,
>      };
>
>      assert(data_size < vhost_vdpa_net_cvq_cmd_page_len() - sizeof(ctrl))=
;
> +    /* Each CVQ command has one out descriptor and one in descriptor */
> +    assert(vhost_vdpa_net_svq_available_slots(s) >=3D 2);
>

I think we should remove this assertion. By the end of the series
there is an "if" checks explicitly for the opposite condition, and
flushing the queue in that case, so the code can never reach it.

>      /* pack the CVQ command header */
>      memcpy(s->cvq_cmd_out_buffer, &ctrl, sizeof(ctrl));
> --
> 2.25.1
>


